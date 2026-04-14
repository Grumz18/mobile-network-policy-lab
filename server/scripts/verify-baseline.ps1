[CmdletBinding()]
param()

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\\..")
$serverRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$requiredRepoPaths = @(
    "PROJECT_STATE.md",
    "checkpoints\\CP-003.md",
    "docs\\server\\SERVER_BASELINE.md"
)
$requiredServerPaths = @(
    "README.md",
    ".env.example",
    ".gitignore",
    "src\\README.md",
    "config\\README.md",
    "tests\\README.md",
    "scripts\\verify-baseline.ps1"
)

function Test-RelativePath {
    param(
        [string]$BasePath,
        [string]$RelativePath
    )

    return Test-Path -LiteralPath (Join-Path $BasePath $RelativePath)
}

$errors = New-Object System.Collections.Generic.List[string]

Write-Host "Repository root: $repoRoot"
Write-Host "Server root: $serverRoot"
Write-Host "Verification mode: baseline-only"
Write-Host ""

Write-Host "Repository context:"
foreach ($path in $requiredRepoPaths) {
    if (Test-RelativePath -BasePath $repoRoot -RelativePath $path) {
        Write-Host ("  [ok] {0}" -f $path)
    }
    else {
        Write-Host ("  [missing] {0}" -f $path)
        $errors.Add("Missing repository path: $path") | Out-Null
    }
}

Write-Host ""
Write-Host "Server baseline paths:"
foreach ($path in $requiredServerPaths) {
    if (Test-RelativePath -BasePath $serverRoot -RelativePath $path) {
        Write-Host ("  [ok] {0}" -f $path)
    }
    else {
        Write-Host ("  [missing] {0}" -f $path)
        $errors.Add("Missing server path: $path") | Out-Null
    }
}

Write-Host ""
if ($errors.Count -gt 0) {
    Write-Host "Server baseline verification failed."
    foreach ($line in $errors) {
        Write-Host ("  - {0}" -f $line)
    }
    exit 1
}

Write-Host "Server baseline verification passed."
Write-Host "Safe next step: continue only with the active checkpoint."
exit 0
