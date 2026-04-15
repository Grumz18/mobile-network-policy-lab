# CP-009 Android Build Prerequisites Verification Script
# Run: powershell -ExecutionPolicy Bypass -File scripts/android/verify_prerequisites.ps1

$ErrorActionPreference = "Continue"
$pass = 0
$fail = 0
$warn = 0

function Check-Pass($name) {
    Write-Host "  [PASS] $name" -ForegroundColor Green
    $script:pass++
}

function Check-Fail($name, $detail) {
    Write-Host "  [FAIL] $name - $detail" -ForegroundColor Red
    $script:fail++
}

function Check-Warn($name, $detail) {
    Write-Host "  [WARN] $name - $detail" -ForegroundColor Yellow
    $script:warn++
}

Write-Host "`n=== CP-009 Android Build Prerequisites Verification ===" -ForegroundColor Cyan
Write-Host ""

# --- JDK ---
Write-Host "--- JDK ---"
$jdkPath = "C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot"
if (Test-Path "$jdkPath\bin\java.exe") {
    $javaVer = & "$jdkPath\bin\java.exe" -version 2>&1 | Select-Object -First 1
    if ($javaVer -match "17\.") { Check-Pass "JDK 17 java.exe ($javaVer)" } else { Check-Fail "JDK 17 java.exe" "unexpected version: $javaVer" }
} else { Check-Fail "JDK 17 java.exe" "not found at $jdkPath" }

if (Test-Path "$jdkPath\bin\javac.exe") {
    $javacVer = & "$jdkPath\bin\javac.exe" -version 2>&1
    if ($javacVer -match "17\.") { Check-Pass "JDK 17 javac.exe ($javacVer)" } else { Check-Fail "JDK 17 javac.exe" "unexpected version: $javacVer" }
} else { Check-Fail "JDK 17 javac.exe" "not found at $jdkPath" }

# --- Android SDK ---
Write-Host "--- Android SDK ---"
$sdkRoot = "C:\Android\Sdk"
if (Test-Path $sdkRoot) { Check-Pass "Android SDK root ($sdkRoot)" } else { Check-Fail "Android SDK root" "not found at $sdkRoot" }

if (Test-Path "$sdkRoot\platforms\android-35") { Check-Pass "Android platform API 35" } else { Check-Fail "Android platform API 35" "not found" }

if (Test-Path "$sdkRoot\build-tools\35.0.1") { Check-Pass "Build Tools 35.0.1" } else { Check-Fail "Build Tools 35.0.1" "not found" }

if (Test-Path "$sdkRoot\ndk\25.0.8775105") { Check-Pass "NDK 25.0.8775105" } else { Check-Fail "NDK 25.0.8775105" "not found" }

if (Test-Path "$sdkRoot\platform-tools\adb.exe") { Check-Pass "Platform Tools (adb.exe)" } else { Check-Fail "Platform Tools (adb.exe)" "not found" }

if (Test-Path "$sdkRoot\cmdline-tools\latest\bin\sdkmanager.bat") { Check-Pass "SDK Command-line Tools" } else { Check-Fail "SDK Command-line Tools" "not found" }

# --- Go ---
Write-Host "--- Go ---"
$goPath = "C:\Program Files\Go\bin\go.exe"
if (Test-Path $goPath) {
    $goVer = & $goPath version 2>&1
    if ($goVer -match "go1\.23\.") { Check-Pass "Go ($goVer)" } else { Check-Fail "Go" "unexpected version: $goVer" }
} else { Check-Fail "Go" "not found at $goPath" }

# --- gomobile-matsuri / gobind-matsuri ---
Write-Host "--- gomobile / gobind ---"
$gobin = "$env:USERPROFILE\go\bin"
if (Test-Path "$gobin\gomobile-matsuri.exe") { Check-Pass "gomobile-matsuri.exe" } else { Check-Fail "gomobile-matsuri.exe" "not found at $gobin" }
if (Test-Path "$gobin\gobind-matsuri.exe") { Check-Pass "gobind-matsuri.exe" } else { Check-Fail "gobind-matsuri.exe" "not found at $gobin" }

# --- POSIX Shell ---
Write-Host "--- POSIX Shell ---"
$gitBash = "C:\Program Files\Git\bin\bash.exe"
if (Test-Path $gitBash) {
    $bashVer = & $gitBash -c 'echo $BASH_VERSION' 2>&1
    Check-Pass "Git Bash ($bashVer)"
} else { Check-Fail "Git Bash" "not found at $gitBash" }

# --- Gradle Wrapper Cache ---
Write-Host "--- Gradle ---"
$gradleCache = "$env:USERPROFILE\.gradle\wrapper\dists\gradle-8.10.2-bin"
if (Test-Path $gradleCache) { Check-Pass "Gradle 8.10.2 wrapper cache" } else { Check-Fail "Gradle 8.10.2 wrapper cache" "not found at $gradleCache" }

# --- local.properties ---
Write-Host "--- local.properties ---"
$projRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$localProps = Join-Path $projRoot "android\fork\local.properties"
if (Test-Path $localProps) {
    $content = Get-Content $localProps -Raw
    if ($content -match "sdk\.dir") { Check-Pass "local.properties (sdk.dir present)" } else { Check-Fail "local.properties" "sdk.dir not found in file" }
} else { Check-Fail "local.properties" "not found at $localProps" }

# --- External Source Dependencies ---
Write-Host "--- External Source Dependencies ---"
$libnekoPath = Join-Path $projRoot "android\libneko"
$singboxPath = Join-Path $projRoot "android\sing-box"

if (Test-Path "$libnekoPath\go.mod") {
    $mod = Get-Content "$libnekoPath\go.mod" -First 1
    if ($mod -match "matsuridayo/libneko") { Check-Pass "libneko source tree (module: $mod)" } else { Check-Warn "libneko source tree" "unexpected module path: $mod" }
} else { Check-Fail "libneko source tree" "go.mod not found at $libnekoPath" }

if (Test-Path "$singboxPath\go.mod") {
    $mod = Get-Content "$singboxPath\go.mod" -First 1
    if ($mod -match "sagernet/sing-box") { Check-Pass "sing-box source tree (module: $mod)" } else { Check-Warn "sing-box source tree" "unexpected module path: $mod" }
} else { Check-Fail "sing-box source tree" "go.mod not found at $singboxPath" }

# --- Environment Variables (informational) ---
Write-Host "--- Environment Variables (informational, not persisted) ---"
if ($env:JAVA_HOME) { Check-Pass "JAVA_HOME=$env:JAVA_HOME" } else { Check-Warn "JAVA_HOME" "not set in current session (set per-session or persist to user env)" }
if ($env:ANDROID_HOME) { Check-Pass "ANDROID_HOME=$env:ANDROID_HOME" } else { Check-Warn "ANDROID_HOME" "not set in current session (set per-session or persist to user env)" }

# --- Summary ---
Write-Host "`n=== Summary ===" -ForegroundColor Cyan
Write-Host "  Pass: $pass" -ForegroundColor Green
Write-Host "  Fail: $fail" -ForegroundColor $(if ($fail -gt 0) { "Red" } else { "Green" })
Write-Host "  Warn: $warn" -ForegroundColor $(if ($warn -gt 0) { "Yellow" } else { "Green" })

if ($fail -eq 0) {
    Write-Host "`nAll critical prerequisites are present." -ForegroundColor Green
    exit 0
} else {
    Write-Host "`nSome prerequisites are missing. See FAIL entries above." -ForegroundColor Red
    exit 1
}
