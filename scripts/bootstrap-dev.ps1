[CmdletBinding()]
param()

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$requiredCommands = @("git")
$recommendedCommands = @("rg")
$optionalCommands = @("java", "adb")
$requiredPaths = @(
    ".editorconfig",
    ".gitignore",
    ".env.example",
    "PROJECT_STATE.md",
    "README.md",
    "checkpoints\\CP-002.md",
    "docs\\bootstrap\\01_LLM_OPERATING_CONTRACT.md",
    "docs\\bootstrap\\02_LLM_CHECKPOINT_PROTOCOL.md",
    "docs\\bootstrap\\03_OWNER_PROJECT_MAP.md",
    "docs\\repository\\EXECUTION_SURFACE.md",
    "docs\\development\\ENVIRONMENT_BOOTSTRAP.md"
)

function Test-CommandPresent {
    param([string]$Name)
    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($null -ne $command) {
        return $command.Source
    }
    return $null
}

function Test-RelativePath {
    param([string]$RelativePath)
    $fullPath = Join-Path $repoRoot $RelativePath
    return Test-Path -LiteralPath $fullPath
}

$errors = New-Object System.Collections.Generic.List[string]

Write-Host "Repository root: $repoRoot"
Write-Host "Bootstrap stage: repository-only"
Write-Host ""

Write-Host "Required commands:"
foreach ($name in $requiredCommands) {
    $source = Test-CommandPresent -Name $name
    if ($source) {
        Write-Host ("  [ok] {0} -> {1}" -f $name, $source)
    }
    else {
        Write-Host ("  [missing] {0}" -f $name)
        $errors.Add("Missing required command: $name") | Out-Null
    }
}

Write-Host ""
Write-Host "Recommended commands:"
foreach ($name in $recommendedCommands) {
    $source = Test-CommandPresent -Name $name
    if ($source) {
        Write-Host ("  [ok] {0} -> {1}" -f $name, $source)
    }
    else {
        Write-Host ("  [warn] {0} not found" -f $name)
    }
}

Write-Host ""
Write-Host "Optional future commands:"
foreach ($name in $optionalCommands) {
    $source = Test-CommandPresent -Name $name
    if ($source) {
        Write-Host ("  [info] {0} -> {1}" -f $name, $source)
    }
    else {
        Write-Host ("  [info] {0} not installed" -f $name)
    }
}

Write-Host ""
Write-Host "Required repository paths:"
foreach ($relativePath in $requiredPaths) {
    if (Test-RelativePath -RelativePath $relativePath) {
        Write-Host ("  [ok] {0}" -f $relativePath)
    }
    else {
        Write-Host ("  [missing] {0}" -f $relativePath)
        $errors.Add("Missing required path: $relativePath") | Out-Null
    }
}

Write-Host ""
if ($errors.Count -gt 0) {
    Write-Host "Bootstrap verification failed."
    foreach ($errorLine in $errors) {
        Write-Host ("  - {0}" -f $errorLine)
    }
    exit 1
}

Write-Host "Bootstrap verification passed."
Write-Host "Safe next step: continue only with the active checkpoint."
exit 0
