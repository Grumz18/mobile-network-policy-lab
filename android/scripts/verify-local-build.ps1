[CmdletBinding()]
param()

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\\..")
$androidRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$requiredRepoPaths = @(
    "PROJECT_STATE.md",
    "checkpoints\\CP-005.md",
    "docs\\android\\ANDROID_LOCAL_BUILD_BASELINE.md"
)
$requiredAndroidPaths = @(
    "workspace\\README.md",
    "build\\README.md",
    "local.properties.example",
    "gradle.properties.example",
    "scripts\\verify-local-build.ps1"
)
$requiredCommands = @("git", "powershell")
$optionalCommands = @("java", "adb")

function Test-RelativePath {
    param(
        [string]$BasePath,
        [string]$RelativePath
    )

    return Test-Path -LiteralPath (Join-Path $BasePath $RelativePath)
}

function Get-CommandSourceOrNull {
    param([string]$Name)

    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($null -ne $command) {
        return $command.Source
    }

    return $null
}

$errors = New-Object System.Collections.Generic.List[string]

Write-Host "Repository root: $repoRoot"
Write-Host "Android root: $androidRoot"
Write-Host "Verification mode: local-build-baseline-only"
Write-Host ""

Write-Host "Required commands:"
foreach ($name in $requiredCommands) {
    $source = Get-CommandSourceOrNull -Name $name
    if ($source) {
        Write-Host ("  [ok] {0} -> {1}" -f $name, $source)
    }
    else {
        Write-Host ("  [missing] {0}" -f $name)
        $errors.Add("Missing required command: $name") | Out-Null
    }
}

Write-Host ""
Write-Host "Optional Android-related commands:"
foreach ($name in $optionalCommands) {
    $source = Get-CommandSourceOrNull -Name $name
    if ($source) {
        Write-Host ("  [info] {0} -> {1}" -f $name, $source)
    }
    else {
        Write-Host ("  [info] {0} not installed" -f $name)
    }
}

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
Write-Host "Android local-build baseline paths:"
foreach ($path in $requiredAndroidPaths) {
    if (Test-RelativePath -BasePath $androidRoot -RelativePath $path) {
        Write-Host ("  [ok] {0}" -f $path)
    }
    else {
        Write-Host ("  [missing] {0}" -f $path)
        $errors.Add("Missing Android path: $path") | Out-Null
    }
}

Write-Host ""
if ($errors.Count -gt 0) {
    Write-Host "Android local-build baseline verification failed."
    foreach ($line in $errors) {
        Write-Host ("  - {0}" -f $line)
    }
    exit 1
}

Write-Host "Android local-build baseline verification passed."
Write-Host "Safe next step: continue only with the active checkpoint."
exit 0
