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
    return (Get-Content -LiteralPath $path -Raw | ConvertFrom-Json)
}

$portable = Read-JsonFile 'plugins/task/plugin.json'
$overlay = Read-JsonFile 'plugins/task/.codex-plugin/plugin.json'
Assert-True ($portable.name -eq 'wos-task') 'Task portable manifest has an unexpected name'
Assert-True ($portable.version -eq '1.1.0') 'Task portable manifest must be version 1.1.0'
Assert-True ($overlay.version -eq $portable.version) 'Task manifest versions must match'

foreach ($marketplacePath in @('marketplace.json', '.agents/plugins/marketplace.json')) {
    $marketplace = Read-JsonFile $marketplacePath
    $entries = @($marketplace.plugins | Where-Object { $_.name -eq 'wos-task' })
    Assert-True ($entries.Count -eq 1) "$marketplacePath must publish wos-task exactly once"
    Assert-True ($entries[0].source.path -eq './plugins/task') "$marketplacePath must point wos-task to ./plugins/task"
}

$expectedSkills = @('task-agenda', 'task', 'task-handoff')
$actualSkills = @(Get-ChildItem -LiteralPath (Join-Path $RepositoryRoot 'plugins/task/skills') -Recurse -Filter 'SKILL.md' | ForEach-Object { $_.Directory.Name })
Assert-True ((Compare-Object $expectedSkills $actualSkills).Count -eq 0) 'Task must expose only task-agenda, task, and task-handoff'
foreach ($skill in $expectedSkills) {
    Assert-True (Test-Path -LiteralPath (Join-Path $RepositoryRoot "plugins/task/skills/$skill/SKILL.md")) "Missing $skill skill"
}

$taskRoot = Join-Path $RepositoryRoot 'plugins/task'
Assert-True (-not (Test-Path -LiteralPath (Join-Path $taskRoot 'templates/task-dashboard'))) 'Task dashboard template must not be bundled with wos-task v1.1'
Assert-True (-not (Test-Path -LiteralPath (Join-Path $taskRoot 'references/task-orchestration-policy.md'))) 'Task orchestration policy must not be bundled with wos-task v1.1'

$agenda = Get-Content -LiteralPath (Join-Path $taskRoot 'references/task-agenda-standard.md') -Raw
Assert-True ($agenda.Contains('Default delivery: agenda brief')) 'Task agenda must define the agenda brief as its default delivery'
Assert-True ($agenda.Contains('other-approved')) 'Task agenda must support approved future sources'
Assert-True (-not ($agenda -match '(?i)"source"\s*:\s*"wos-task"')) 'Task agenda must not define a retired task-memory record'

Write-Host 'WOS Task v1.1 structural validation passed.' -ForegroundColor Green
