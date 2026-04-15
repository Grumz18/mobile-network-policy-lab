# verify-fork-intake.ps1
# Safe, non-destructive verification of the Android fork intake and patch workflow baseline.
# Does NOT fetch code, run builds, or mutate any state.
# Checkpoint: CP-006

param(
    [switch]$Verbose
)

$ErrorActionPreference = "Continue"
$exitCode = 0
$passed = 0
$failed = 0
$warnings = 0

function Write-Check {
    param([string]$Label, [bool]$Ok, [string]$Detail = "")
    if ($Ok) {
        Write-Host "  [PASS] $Label" -ForegroundColor Green
        $script:passed++
    } else {
        Write-Host "  [FAIL] $Label" -ForegroundColor Red
        if ($Detail) { Write-Host "         $Detail" -ForegroundColor Yellow }
        $script:failed++
        $script:exitCode = 1
    }
}

function Write-Warn {
    param([string]$Label, [string]$Detail = "")
    Write-Host "  [WARN] $Label" -ForegroundColor Yellow
    if ($Detail) { Write-Host "         $Detail" -ForegroundColor DarkYellow }
    $script:warnings++
}

Write-Host ""
Write-Host "=== Android Fork Intake & Patch Workflow Baseline Verification ===" -ForegroundColor Cyan
Write-Host ""

# --- Section 1: Fork intake documentation ---
Write-Host "--- Fork Intake Documentation ---" -ForegroundColor White

$forkIntakeDoc = "docs/android/ANDROID_FORK_INTAKE.md"
Write-Check "Fork intake document exists" (Test-Path $forkIntakeDoc)

if (Test-Path $forkIntakeDoc) {
    $content = Get-Content $forkIntakeDoc -Raw
    Write-Check "Documents upstream repository coordinates" ($content -match "MatsuriDayo/NekoBoxForAndroid")
    Write-Check "Documents chosen intake method" ($content -match "(?i)manual snapshot")
    Write-Check "Documents intake procedure steps" ($content -match "(?i)step-by-step|intake procedure")
    Write-Check "Documents upstream tracking convention" ($content -match "UPSTREAM_TRACKING")
}

# --- Section 2: Patch workflow documentation ---
Write-Host ""
Write-Host "--- Patch Workflow Documentation ---" -ForegroundColor White

$patchWorkflowDoc = "docs/android/ANDROID_PATCH_WORKFLOW.md"
Write-Check "Patch workflow document exists" (Test-Path $patchWorkflowDoc)

if (Test-Path $patchWorkflowDoc) {
    $content = Get-Content $patchWorkflowDoc -Raw
    Write-Check "Documents patch naming convention" ($content -match "(?i)naming convention|sequence.*scope.*description")
    Write-Check "Documents patch application procedure" ($content -match "(?i)application procedure|apply.*patch")
    Write-Check "Documents patch re-application after sync" ($content -match "(?i)re-application|upstream sync")
    Write-Check "Documents patch creation procedure" ($content -match "(?i)creation procedure|generate the patch")
}

# --- Section 3: Workspace boundary files ---
Write-Host ""
Write-Host "--- Workspace Boundary Files ---" -ForegroundColor White

$forkReadme = "android/fork/README.md"
Write-Check "android/fork/README.md exists" (Test-Path $forkReadme)

if (Test-Path $forkReadme) {
    $content = Get-Content $forkReadme -Raw
    Write-Check "Fork README references intake document" ($content -match "ANDROID_FORK_INTAKE")
    Write-Check "Fork README describes post-intake state" ($content -match "(?i)post-intake|after.*intake")
}

$patchesReadme = "android/patches/README.md"
Write-Check "android/patches/README.md exists" (Test-Path $patchesReadme)

if (Test-Path $patchesReadme) {
    $content = Get-Content $patchesReadme -Raw
    Write-Check "Patches README references workflow document" ($content -match "ANDROID_PATCH_WORKFLOW")
    Write-Check "Patches README describes patch file conventions" ($content -match "(?i)naming|convention|\.patch")
}

# --- Section 4: Fork intake state ---
Write-Host ""
Write-Host "--- Fork Intake State ---" -ForegroundColor White

$upstreamTracking = "android/fork/UPSTREAM_TRACKING.md"
if (Test-Path $upstreamTracking) {
    Write-Warn "UPSTREAM_TRACKING.md exists (fork may have been materialized)" "Verify this is expected at the current checkpoint."
} else {
    Write-Host "  [INFO] No UPSTREAM_TRACKING.md yet (fork not materialized - expected pre-intake)" -ForegroundColor DarkGray
}

# Check that no source code has been placed in android/fork/ prematurely
$forkFiles = Get-ChildItem -Path "android/fork" -File -Recurse -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -ne "README.md" -and $_.Name -ne "UPSTREAM_TRACKING.md" }
if ($forkFiles -and $forkFiles.Count -gt 0) {
    Write-Warn "Unexpected files found in android/fork/" "Fork content may have been placed outside the intake procedure."
    if ($Verbose) {
        foreach ($f in $forkFiles) {
            Write-Host "         - $($f.FullName)" -ForegroundColor DarkYellow
        }
    }
} else {
    Write-Host "  [INFO] android/fork/ is clean (no premature source code)" -ForegroundColor DarkGray
}

# --- Section 5: Patch state ---
Write-Host ""
Write-Host "--- Patch State ---" -ForegroundColor White

$patchFiles = Get-ChildItem -Path "android/patches" -Filter "*.patch" -ErrorAction SilentlyContinue
if ($patchFiles -and $patchFiles.Count -gt 0) {
    Write-Host "  [INFO] $($patchFiles.Count) patch file(s) found" -ForegroundColor DarkGray

    # Validate naming convention
    foreach ($patch in $patchFiles) {
        $nameOk = $patch.Name -match "^\d{3}-[a-z]+-[a-z0-9-]+\.patch$"
        if (-not $nameOk) {
            Write-Warn "Patch file does not follow naming convention: $($patch.Name)"
        } elseif ($Verbose) {
            Write-Host "  [INFO] Patch name OK: $($patch.Name)" -ForegroundColor DarkGray
        }
    }
} else {
    Write-Host "  [INFO] No patch files yet (expected pre-implementation)" -ForegroundColor DarkGray
}

# --- Section 6: Checkpoint context ---
Write-Host ""
Write-Host "--- Checkpoint Context ---" -ForegroundColor White

Write-Check "PROJECT_STATE.md exists" (Test-Path "PROJECT_STATE.md")
Write-Check "Checkpoint protocol exists" (Test-Path "docs/bootstrap/02_LLM_CHECKPOINT_PROTOCOL.md")

# --- Summary ---
Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Cyan
Write-Host "  Passed:   $passed" -ForegroundColor Green
Write-Host "  Failed:   $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "  Warnings: $warnings" -ForegroundColor $(if ($warnings -gt 0) { "Yellow" } else { "Green" })
Write-Host ""

if ($exitCode -eq 0) {
    Write-Host "Fork intake and patch workflow baseline verification PASSED." -ForegroundColor Green
} else {
    Write-Host "Fork intake and patch workflow baseline verification FAILED." -ForegroundColor Red
}

exit $exitCode
