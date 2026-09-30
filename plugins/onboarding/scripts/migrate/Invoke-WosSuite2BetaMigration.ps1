[CmdletBinding()]
param(
    [ValidateSet('Inventory', 'Apply')]
    [string]$Mode = 'Inventory',
    [string]$SentinelPath = (Join-Path $env:USERPROFILE '.codex\workflow-os.json'),
    [string]$CodexConfigPath = (Join-Path $env:USERPROFILE '.codex\config.toml'),
    [string]$ScheduledTaskName = 'Workflow OS DR Snapshot',
    [switch]$ConfirmRetirement
)

$ErrorActionPreference = 'Stop'

function Read-WosJson {
    param([string]$Path, [string]$Label)
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "$Label not found: $Path" }
    try { return Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json }
    catch { throw "$Label is not valid JSON: $Path" }
}

function Get-WosTomlTables {
    param([string]$Content, [string[]]$Headers)
    $found = @()
    foreach ($header in $Headers) {
        $escaped = [regex]::Escape($header)
        if ($Content -match "(?m)^\[$escaped\]\s*$") { $found += $header }
    }
    return $found
}

function Remove-WosTomlTables {
    param([string]$Content, [string[]]$Headers)
    $updated = $Content
    foreach ($header in $Headers) {
        $escaped = [regex]::Escape($header)
        $pattern = "(?ms)^\[$escaped\]\s*\r?\n.*?(?=^\[|\z)"
        $updated = [regex]::Replace($updated, $pattern, '')
    }
    return $updated.TrimEnd() + [Environment]::NewLine
}

function Get-WosScheduledTask {
    param([string]$TaskName)
    $tasks = @(Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue)
    return @($tasks | Where-Object { $_.TaskPath -eq '\\' })
}

$sentinel = Read-WosJson -Path $SentinelPath -Label 'Workflow OS sentinel'
if (-not $sentinel.data_root) { throw "Workflow OS sentinel has no data_root: $SentinelPath" }
$dataRoot = [string]$sentinel.data_root
$localPath = Join-Path $dataRoot '.agent\local.json'
$local = Read-WosJson -Path $localPath -Label 'Workflow OS local profile'

$configText = if (Test-Path -LiteralPath $CodexConfigPath -PathType Leaf) { Get-Content -LiteralPath $CodexConfigPath -Raw } else { '' }
$retiredPluginTables = @(
    'plugins."wos-memory-engine@workflow-os"',
    'plugins."wos-dr@workflow-os"'
)
$engineRuntimeTables = @(
    'mcp_servers.memory-engine',
    'mcp_servers.memory-engine.env'
)
$engineHookPattern = '(?ms)^\[hooks\.state\."wos-memory-engine@workflow-os:[^"]+"\]\s*\r?\n.*?(?=^\[|\z)'

$installed = @($local.installed_plugins)
$retiredInProfile = @($installed | Where-Object { $_ -in @('wos-memory-engine', 'wos-dr') })
$setupMissing = @()
if (-not $local.plugin_state.'wos-jira'.setup_completed_at) { $setupMissing += 'jira' }
if (-not $local.plugin_state.'wos-documentation'.setup_completed_at) { $setupMissing += 'documentation' }
$drTasks = @(Get-WosScheduledTask -TaskName $ScheduledTaskName)

$inventory = [ordered]@{
    release = 'WOS Suite 2.0 Beta'
    mode = $Mode
    profile = [ordered]@{
        sentinel = $SentinelPath
        local_profile = $localPath
        usable = $true
        jira_setup = if ($setupMissing -contains 'jira') { 'incomplete' } else { 'complete' }
        documentation_setup = if ($setupMissing -contains 'documentation') { 'incomplete' } else { 'complete' }
        action_if_incomplete = if ($setupMissing.Count) { @($setupMissing | ForEach-Object { "run `$$_-setup only" }) } else { @() }
    }
    retired = [ordered]@{
        profile_entries = $retiredInProfile
        codex_plugin_tables = @(Get-WosTomlTables -Content $configText -Headers $retiredPluginTables)
        memory_engine_runtime_tables = @(Get-WosTomlTables -Content $configText -Headers $engineRuntimeTables)
        memory_engine_hook_state = [bool]($configText -match $engineHookPattern)
        wos_dr_scheduled_tasks = @($drTasks | ForEach-Object { "$($_.TaskPath)$($_.TaskName)" })
    }
    preserved = @(
        $SentinelPath,
        $localPath,
        'user role, work style, Jira and Documentation setup',
        'WOS.md markers and active pointers',
        'legacy SQLite data and plugin caches',
        'existing OneDrive backups',
        'unrelated Codex configuration and local repositories'
    )
    required_confirmation = 'Remove only retired WOS Engine/DR configuration and the WOS DR scheduled task; preserve all listed profile and data items.'
    app_uninstall_required = @('wos-memory-engine', 'wos-dr')
}

if ($Mode -eq 'Inventory') {
    $inventory | ConvertTo-Json -Depth 8
    exit 0
}

if (-not $ConfirmRetirement) {
    throw 'Apply requires -ConfirmRetirement. Run Inventory first, show the concise confirmation, then rerun Apply only after approval.'
}

$updatedConfig = Remove-WosTomlTables -Content $configText -Headers ($retiredPluginTables + $engineRuntimeTables)
$updatedConfig = [regex]::Replace($updatedConfig, $engineHookPattern, '').TrimEnd() + [Environment]::NewLine

if ($updatedConfig -ne $configText -and (Test-Path -LiteralPath $CodexConfigPath -PathType Leaf)) {
    Set-Content -LiteralPath $CodexConfigPath -Value $updatedConfig -Encoding utf8
}

$localChanged = $false
if ($local.installed_plugins) {
    $filtered = @($local.installed_plugins | Where-Object { $_ -notin @('wos-memory-engine', 'wos-dr') })
    if (@($filtered).Count -ne @($local.installed_plugins).Count) {
        $local.installed_plugins = $filtered
        $localChanged = $true
    }
}
if ($local.plugin_state -and $local.plugin_state.PSObject.Properties['wos-dr']) {
    $local.plugin_state.PSObject.Properties.Remove('wos-dr')
    $localChanged = $true
}
if ($localChanged) {
    $local | ConvertTo-Json -Depth 32 | Set-Content -LiteralPath $localPath -Encoding utf8
}

$removedTasks = @()
foreach ($task in $drTasks) {
    Unregister-ScheduledTask -TaskName $task.TaskName -TaskPath $task.TaskPath -Confirm:$false
    $removedTasks += "$($task.TaskPath)$($task.TaskName)"
}

[ordered]@{
    release = 'WOS Suite 2.0 Beta'
    applied = $true
    changed_local_profile = $localChanged
    removed_wos_dr_scheduled_tasks = $removedTasks
    preserved = $inventory.preserved
    next = 'Use the Codex Plugins Directory to uninstall wos-memory-engine and wos-dr, then restart Codex in a fresh chat. This script deliberately does not delete plugin caches or legacy data.'
} | ConvertTo-Json -Depth 8
