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

$manifestPath = 'plugins/project/.codex-plugin/plugin.json'
$manifest = Read-JsonFile $manifestPath
Assert-True ($manifest.name -eq 'wos-project') 'Project manifest name must be wos-project'
Assert-True ($manifest.version -eq '1.1.0') 'Project manifest version must be 1.1.0'
Assert-True (-not ($manifest.PSObject.Properties.Name -contains 'hooks')) 'Project must not register lifecycle hooks'
Assert-True (-not (Test-Path -LiteralPath (Join-Path $RepositoryRoot 'plugins/project/.mcp.json'))) 'Project must not register an MCP server'

foreach ($marketplacePath in @('marketplace.json', '.agents/plugins/marketplace.json')) {
    $marketplace = Read-JsonFile $marketplacePath
    $entry = @($marketplace.plugins | Where-Object { $_.name -eq 'wos-project' })
    Assert-True ($entry.Count -eq 1) "$marketplacePath must publish wos-project exactly once"
    Assert-True ($entry[0].source.path -eq './plugins/project') "$marketplacePath must point wos-project to ./plugins/project"
}

$expectedSkills = @('project-new', 'project-resume', 'project-checkpoint', 'project-orchestrate', 'project-complete')
$actualSkills = @(Get-ChildItem -LiteralPath (Join-Path $RepositoryRoot 'plugins/project/skills') -Directory |
    Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') } |
    ForEach-Object { $_.Name } | Sort-Object)
Assert-True (($actualSkills -join ',') -eq (($expectedSkills | Sort-Object) -join ',')) 'Project must expose only its five v1.1 skills'
foreach ($skill in $expectedSkills) {
    $path = Join-Path $RepositoryRoot "plugins/project/skills/$skill/SKILL.md"
    $content = Get-Content -LiteralPath $path -Raw
    Assert-True ($content -match '(?s)^---\s*\r?\nname:\s*[^\r\n]+\r?\ndescription:\s*[^\r\n]+\r?\n---') "$skill is missing valid frontmatter"
}

$projectText = Get-ChildItem -LiteralPath (Join-Path $RepositoryRoot 'plugins/project') -File -Recurse |
    Get-Content -Raw | Out-String
foreach ($forbidden in @('memory-engine', 'memory_write', 'memory_search', 'memory_recall', 'memory_export', 'project-state memory', 'SessionStart', 'Superpowers Protocol')) {
    Assert-True (-not $projectText.Contains($forbidden)) "Project v1.1 still contains retired or mandatory complexity: $forbidden"
}
foreach ($required in @('Local (default)', 'Jira-linked', 'External', 'Default to **linear work**')) {
    Assert-True ($projectText.Contains($required)) "Project v1.1 is missing its local-first tracking contract: $required"
}

$parseErrors = $null
[void][System.Management.Automation.Language.Parser]::ParseFile((Join-Path $RepositoryRoot 'plugins/project/scripts/active-project.ps1'), [ref]$null, [ref]$parseErrors)
Assert-True ($parseErrors.Count -eq 0) 'active-project.ps1 must parse without errors'

Write-Host 'WOS Project v1.1 validation passed.' -ForegroundColor Green
