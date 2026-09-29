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

$marketplaces = @('marketplace.json', '.agents/plugins/marketplace.json')
foreach ($marketplacePath in $marketplaces) {
    $marketplace = Read-JsonFile $marketplacePath
    $names = @($marketplace.plugins | ForEach-Object { $_.name })
    Assert-True ($names -contains 'wos-memory-lite') "$marketplacePath does not publish wos-memory-lite"
    Assert-True (-not ($names -contains 'wos-memory-engine')) "$marketplacePath still publishes retired wos-memory-engine"
    $memoryLite = @($marketplace.plugins | Where-Object { $_.name -eq 'wos-memory-lite' })[0]
    Assert-True ($memoryLite.policy.authentication -in @('ON_INSTALL', 'ON_USE')) "$marketplacePath has an unsupported Memory Lite authentication policy"
}

$expectedVersions = @{
    'plugins/memory-lite/.codex-plugin/plugin.json' = '1.1.0'
    'plugins/project/.codex-plugin/plugin.json' = '1.1.0'
    'plugins/task/.codex-plugin/plugin.json' = '1.0.0'
}

$chatGptMetadata = Join-Path $RepositoryRoot 'plugins/memory-lite/skills/memory-lite/agents/openai.yaml'
Assert-True (Test-Path -LiteralPath $chatGptMetadata) 'Memory Lite must include ChatGPT Work skill metadata'
$chatGptMetadataText = Get-Content -LiteralPath $chatGptMetadata -Raw
foreach ($requiredField in @('display_name:', 'short_description:', 'default_prompt:', 'allow_implicit_invocation:')) {
    Assert-True ($chatGptMetadataText.Contains($requiredField)) "Memory Lite ChatGPT Work metadata is missing $requiredField"
}

$memoryLiteSkill = Get-Content -LiteralPath (Join-Path $RepositoryRoot 'plugins/memory-lite/skills/memory-lite/SKILL.md') -Raw
Assert-True ($memoryLiteSkill.Contains('ChatGPT Work')) 'Memory Lite skill must document ChatGPT Work behavior'
Assert-True ($memoryLiteSkill.Contains('Codex')) 'Memory Lite skill must document Codex behavior'
foreach ($entry in $expectedVersions.GetEnumerator()) {
    $manifest = Read-JsonFile $entry.Key
    Assert-True ($manifest.version -eq $entry.Value) "$($entry.Key) must be version $($entry.Value)"
    Assert-True (-not ($manifest.PSObject.Properties.Name -contains 'hooks')) "$($entry.Key) must not register hooks in Memory Lite v1"
}

$activeRoots = @(
    'plugins/memory-lite',
    'plugins/project',
    'plugins/task',
    'plugins/onboarding',
    'plugins/dr',
    'plugins/jira'
)
$forbidden = 'memory-engine|memory_write|memory_search|memory_recall|memory_export|session-summary'
$matches = @()
foreach ($relativeRoot in $activeRoots) {
    $root = Join-Path $RepositoryRoot $relativeRoot
    if (Test-Path -LiteralPath $root) {
        $matches += @(Get-ChildItem -LiteralPath $root -File -Recurse |
            Select-String -Pattern $forbidden -CaseSensitive:$false)
    }
}
Assert-True ($matches.Count -eq 0) ("Retired memory dependency found in active v1 paths:`n" + (($matches | ForEach-Object { "$($_.Path):$($_.LineNumber)" }) -join "`n"))

Assert-True (-not (Test-Path -LiteralPath (Join-Path $RepositoryRoot 'plugins/project/skills/project-import/SKILL.md'))) 'Project v1.1 must consolidate project-import into project-new'

Write-Host 'WOS Memory Lite v1.1 structural validation passed.' -ForegroundColor Green
