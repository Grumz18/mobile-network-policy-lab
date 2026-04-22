# Android Post-Install-Verification Continuation

## Purpose
This document records CP-035 execution retry that captures a bounded CLI launch-verification outcome after successful install verification.

Scope remained limited to CP-035 prerequisite checks plus one bounded launch probe.
No runtime debugging, interaction testing, feature work, or broader build continuation was performed.

## Checkpoint
CP-035 (retry3)

## Date
2026-04-22

## Scope Boundary
Performed:
- verified CP-035 prerequisites exactly as authored
- confirmed one online adb target (`device`), ABI `x86_64`, and package `moe.nb4a.debug` installed
- executed exactly one bounded launch probe:
  - `adb shell am start -W -n "moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity"`
- captured first exact meaningful outcome and full command output

Not performed:
- no `adb logcat`
- no `adb shell dumpsys*`
- no interaction commands (`adb shell input`, `adb shell monkey`, UI automation)
- no runtime debugging
- no feature validation beyond bounded launch confirmation
- no `assemble*` continuation
- no release signing/distribution work

## Pre-Probe Environment
```text
JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot\
openjdk version "17.0.18" 2026-01-20
OpenJDK Runtime Environment Temurin-17.0.18+8 (build 17.0.18+8)
OpenJDK 64-Bit Server VM Temurin-17.0.18+8 (build 17.0.18+8, mixed mode, sharing)
```

## Persisted Sing-Box Prerequisite Confirmation
```text
branch=cp017-local-baseline
commit=aed32ee3066cdbc7d471e3e0415c5134088962df
```

## Exact Prerequisite State Checks
```text
docs/android/ANDROID_POST_APK_VERIFICATION_CONTINUATION.md => True
android/fork/app/build/outputs/apk/oss/debug/output-metadata.json => True
android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk => True
output-metadata applicationId=moe.nb4a.debug
applicationId expected moe.nb4a.debug => True
ANDROID_HOME=C:/Android/Sdk
adb resolved path=C:/Android/Sdk/platform-tools/adb.exe
adb resolvable => True
aapt resolved path=C:/Android/Sdk/build-tools/35.0.1/aapt.exe
aapt resolvable => True
launchable-activity line=launchable-activity: name='io.nekohasekai.sagernet.ui.MainActivity'  label='' icon=''
launchable activity expected io.nekohasekai.sagernet.ui.MainActivity => True
List of devices attached
emulator-5554          device product:sdk_gphone64_x86_64 model:sdk_gphone64_x86_64 device:emu64xa transport_id:1
online adb target count=1
online adb exactly one => True
online adb serial=emulator-5554
adb target abi=x86_64
adb target abi is x86_64 => True
pm path output=package:/data/app/~~5luga3s0QmDqGRYEv51_HA==/moe.nb4a.debug-yGFPWG-QoCmncva-7Hw5PQ==/base.apk
installed package check passes => True
CP-035 hard prerequisites pass => True
```

## Exact Probe Command
```powershell
& "$env:ANDROID_HOME\platform-tools\adb.exe" -s emulator-5554 shell am start -W -n "moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity"
```

## Exact Probe Output
```text
Starting: Intent { cmp=moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity }
Warning: Activity not started, intent has been delivered to currently running top-most instance.
Status: ok
LaunchState: UNKNOWN (0)
Activity: moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity
TotalTime: 0
WaitTime: 10
Complete
EXIT_CODE: 0
```

## First Exact Meaningful Outcome
```text
Status: ok
Activity: moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity
EXIT_CODE: 0
```

This satisfies the bounded launch-verification success boundary for CP-035.

## Expected Success Signals Check
Observed:
- `Starting: Intent { cmp=moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity` - Yes
- `Status: ok` - Yes
- `Activity: moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity` - Yes
- `Complete` - Yes
- `EXIT_CODE: 0` - Yes

## Out-of-Scope Verification
Out-of-scope actions remained unperformed.

Out-of-scope path checks:
```text
android/fork/app/build/outputs/apk/oss/release => False
android/fork/app/build/outputs/bundle/ossDebug => False
android/fork/app/build/outputs/apk/androidTest/oss/debug => False
```

## Fallback Evidence Sources
Direct shell output was complete.
Canonical evidence retained:
- `docs/android/evidence/cp035_retry3_prereq_checks.log`
- `docs/android/evidence/cp035_retry3_adb_devices.log`
- `docs/android/evidence/cp035_retry3_launch_probe.log`
- `docs/android/evidence/cp035_retry3_launch_probe.clean.log`
- `docs/android/evidence/cp035_retry3_out_of_scope_path_checks.log`
- `docs/android/evidence/cp035_retry2_adb_recovery.log`

## Cleanup Expectations and Result
Cleanup expectations were satisfied:
- no `libcore.aar` regeneration
- no disposable gomobile/GOPATH workspace creation
- no temporary scratch files outside `docs/android/evidence/`
- canonical evidence retained under `docs/android/evidence/`
- no uninstall performed
- upstream source trees unchanged

## Outcome
CP-035 execution is complete.

Completed:
- prerequisites verified
- one bounded launch probe executed
- required launch success signals captured
- strict scope preservation
