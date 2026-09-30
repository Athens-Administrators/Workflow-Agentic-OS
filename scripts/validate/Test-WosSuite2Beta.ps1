[CmdletBinding()]
param(
    [string]$RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
)

$ErrorActionPreference = 'Stop'

function Assert-True {
    param([bool]$Condition, [string]$Message)
    if (-not $Condition) { throw $Message }
}

function Read-JsonFile {
    param([string]$RelativePath)
    $path = Join-Path $RepositoryRoot $RelativePath
    Assert-True (Test-Path -LiteralPath $path) "Missing required file: $RelativePath"
    return Get-Content -LiteralPath $path -Raw | ConvertFrom-Json
}

$expectedSuite = @('wos-onboarding', 'wos-jira', 'wos-documentation', 'wos-memory-lite', 'wos-project', 'wos-task')
foreach ($marketplacePath in @('marketplace.json', '.agents/plugins/marketplace.json')) {
    $marketplace = Read-JsonFile $marketplacePath
    Assert-True ($marketplace.name -eq 'workflow-os-suite-2-beta') "$marketplacePath must use the isolated beta marketplace identity"
    $names = @($marketplace.plugins | ForEach-Object { $_.name })
    $actualNames = ($names | Sort-Object) -join ','
    $expectedNames = ($expectedSuite | Sort-Object) -join ','
    Assert-True ($actualNames -eq $expectedNames) "$marketplacePath must publish exactly the six WOS Suite 2 Beta components"
    foreach ($entry in $marketplace.plugins) {
        Assert-True ($entry.source.path -like './plugins/*') "$marketplacePath has a non-local plugin source"
        Assert-True ($entry.policy.installation -in @('AVAILABLE', 'INSTALLED_BY_DEFAULT', 'NOT_AVAILABLE')) "$marketplacePath has an invalid installation policy for $($entry.name)"
        Assert-True ($entry.policy.authentication -in @('ON_INSTALL', 'ON_USE')) "$marketplacePath has an invalid authentication policy for $($entry.name)"
        Assert-True ([bool]$entry.category) "$marketplacePath is missing a category for $($entry.name)"
    }
}

$release = Read-JsonFile 'release/wos-suite-2-beta.json'
Assert-True ($release.release -eq 'WOS Suite 2.0 Beta') 'Release matrix must identify WOS Suite 2.0 Beta'
Assert-True ($release.status -eq 'beta-version-approved') 'Release matrix must record the approved beta version'
Assert-True (@($release.retired.name) -contains 'wos-memory-engine') 'Release matrix must retire WOS Memory Engine'
Assert-True (@($release.retired.name) -contains 'wos-dr') 'Release matrix must retire WOS DR'
Assert-True (@($release.not_in_suite_beta) -contains 'wos-azure-boards') 'Azure Boards must remain outside Suite 2 Beta'

$memoryLiteManifest = Read-JsonFile 'plugins/memory-lite/.codex-plugin/plugin.json'
Assert-True ($memoryLiteManifest.version -eq '2.0.0-beta') 'Memory Lite must use the approved Suite 2 beta version'

$onboardingManifest = Read-JsonFile 'plugins/onboarding/.codex-plugin/plugin.json'
Assert-True ($onboardingManifest.name -eq 'wos-onboarding') 'Onboarding manifest name must remain stable'
Assert-True ($onboardingManifest.version -eq '1.0.0') 'Onboarding version must not be changed before component-version approval'

$welcome = Get-Content -LiteralPath (Join-Path $RepositoryRoot 'plugins/onboarding/skills/welcome/SKILL.md') -Raw
Assert-True ($welcome -notmatch '(?i)wos-dr') 'First-time onboarding must not mention WOS DR'
Assert-True ($welcome -notmatch '(?i)memory engine') 'First-time onboarding must not recommend WOS Memory Engine'
Assert-True ($welcome -match '(?i)wos-memory-lite') 'First-time onboarding must recommend WOS Memory Lite'

$detector = Get-Content -LiteralPath (Join-Path $RepositoryRoot 'plugins/onboarding/scripts/detect-state.ps1') -Raw
$hook = Get-Content -LiteralPath (Join-Path $RepositoryRoot 'plugins/onboarding/hooks/check-installed.ps1') -Raw
Assert-True ($detector -notmatch '(?i)wos-dr') 'State detector must not require WOS DR'
Assert-True ($hook -notmatch '(?i)wos-dr') 'Onboarding hook must not require WOS DR'

$migrationSkill = Join-Path $RepositoryRoot 'plugins/onboarding/skills/suite-2-migration/SKILL.md'
Assert-True (Test-Path -LiteralPath $migrationSkill) 'Suite 2 migration assistant skill is missing'
$migrationText = Get-Content -LiteralPath $migrationSkill -Raw
foreach ($required in @('Inventory', 'ConfirmRetirement', 'wos-memory-engine', 'wos-dr', 'legacy SQLite data', 'OneDrive snapshots')) {
    Assert-True ($migrationText.Contains($required)) "Suite 2 migration assistant is missing required migration guard: $required"
}

$migrationScript = Join-Path $RepositoryRoot 'scripts/migrate/Invoke-WosSuite2BetaMigration.ps1'
Assert-True (Test-Path -LiteralPath $migrationScript) 'Suite 2 migration script is missing'
$tokens = $null
$errors = $null
[void][System.Management.Automation.Language.Parser]::ParseFile($migrationScript, [ref]$tokens, [ref]$errors)
Assert-True ($errors.Count -eq 0) 'Suite 2 migration script must parse without errors'
$migrationScriptText = Get-Content -LiteralPath $migrationScript -Raw
Assert-True ($migrationScriptText -notmatch 'Remove-Item') 'Suite 2 migration script must not delete cache or data folders'
Assert-True ($migrationScriptText -match 'Unregister-ScheduledTask') 'Suite 2 migration script must remove only the WOS DR scheduled task after confirmation'

Write-Host 'WOS Suite 2.0 Beta structural validation passed.' -ForegroundColor Green
