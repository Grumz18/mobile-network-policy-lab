# Android Emulator Startup Cycle

## Purpose
Quick repeatable cycle to bring up Android emulator, wait until it is ready in `adb`, and launch the debug app.

## Scope
Host-side startup and readiness only:
- start emulator
- wait for `adb` device state
- wait for Android boot completion
- launch app

No build/feature/debug workflow is included here.

## Prerequisites
- Windows host
- Android SDK installed at `C:\Android\Sdk`
- AVD exists: `CP034_x86_64`
- APK already built/installed (or install step enabled below)

## Manual Cycle (PowerShell)
```powershell
$adb = "C:\Android\Sdk\platform-tools\adb.exe"
$emu = "C:\Android\Sdk\emulator\emulator.exe"
$avd = "CP034_x86_64"
$pkg = "moe.nb4a.debug"
$activity = "io.nekohasekai.sagernet.ui.MainActivity"
$apk = "android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk"
```

1. Check AVD exists:
```powershell
& $emu -list-avds
```

2. Start emulator in background:
```powershell
Start-Process -FilePath $emu -ArgumentList "-avd $avd -no-boot-anim -no-snapshot-save -gpu swiftshader_indirect" -WindowStyle Hidden
```

3. Wait for `adb` to see a `device` target:
```powershell
for ($i=1; $i -le 90; $i++) {
  $out = & $adb devices -l
  $line = $out | Where-Object { $_ -match "\sdevice\b" -and $_ -notmatch "^List of devices attached" } | Select-Object -First 1
  if ($line) { $serial = ($line -split "\s+")[0]; break }
  Start-Sleep -Seconds 2
}
$serial
```

4. Wait for full Android boot:
```powershell
& $adb -s $serial wait-for-device | Out-Null
for ($j=1; $j -le 60; $j++) {
  $boot = (& $adb -s $serial shell getprop sys.boot_completed).Trim()
  if ($boot -eq "1") { break }
  Start-Sleep -Seconds 2
}
$boot
```

5. Ensure app is installed (install only if needed):
```powershell
$pm = (& $adb -s $serial shell pm path $pkg | Select-Object -First 1).Trim()
if ($pm -notmatch "^package:") {
  & $adb -s $serial install -r $apk
}
```

6. Launch app:
```powershell
& $adb -s $serial shell am start -W -n "$pkg/$activity"
```

7. Verify app process:
```powershell
& $adb -s $serial shell pidof $pkg
```

## One-Command Script Block
```powershell
$adb = "C:\Android\Sdk\platform-tools\adb.exe"
$emu = "C:\Android\Sdk\emulator\emulator.exe"
$avd = "CP034_x86_64"
$pkg = "moe.nb4a.debug"
$activity = "io.nekohasekai.sagernet.ui.MainActivity"
$apk = "android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk"

Start-Process -FilePath $emu -ArgumentList "-avd $avd -no-boot-anim -no-snapshot-save -gpu swiftshader_indirect" -WindowStyle Hidden

$serial = $null
for ($i=1; $i -le 90; $i++) {
  $out = & $adb devices -l
  $line = $out | Where-Object { $_ -match "\sdevice\b" -and $_ -notmatch "^List of devices attached" } | Select-Object -First 1
  if ($line) { $serial = ($line -split "\s+")[0]; break }
  Start-Sleep -Seconds 2
}
if (-not $serial) { throw "No adb device target found." }

& $adb -s $serial wait-for-device | Out-Null
for ($j=1; $j -le 60; $j++) {
  $boot = (& $adb -s $serial shell getprop sys.boot_completed).Trim()
  if ($boot -eq "1") { break }
  Start-Sleep -Seconds 2
}
if ($boot -ne "1") { throw "Device found but boot not completed." }

$pm = (& $adb -s $serial shell pm path $pkg | Select-Object -First 1).Trim()
if ($pm -notmatch "^package:") {
  if (-not (Test-Path $apk)) { throw "APK not found: $apk" }
  & $adb -s $serial install -r $apk
}

& $adb -s $serial shell am start -W -n "$pkg/$activity"
& $adb -s $serial shell pidof $pkg
```

## Success Criteria
- `adb devices -l` contains one line with `device` (for example `emulator-5554 device ...`)
- `sys.boot_completed = 1`
- `am start -W` returns `Status: ok` and `Complete`
- `pidof moe.nb4a.debug` returns numeric PID

## Quick Notes
- `adb kill-server/start-server` does not create a device by itself. It only reconnects to existing emulator/USB device.
- If `adb devices -l` stays empty, emulator/device is still not available to `adb`.
