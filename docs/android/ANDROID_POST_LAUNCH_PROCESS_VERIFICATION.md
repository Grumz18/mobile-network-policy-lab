# Android Post-Launch Process Verification

## Purpose
This document records CP-036 execution of only the bounded post-launch process-verification surface.

CP-036 scope remained limited to exact prerequisite checks and a single bounded process probe.
No runtime debugging, interaction testing, network actions, feature work, or broader continuation was performed.

## Checkpoint
CP-036

## Date
2026-04-22

## Scope Boundary
Performed:
- verified all CP-036 prerequisite state checks exactly as authored
- confirmed exactly one online adb target exists
- confirmed installed package `moe.nb4a.debug` is present
- confirmed CP-035 launch verification evidence exists
- ran one bounded probe:
  - `adb shell pidof moe.nb4a.debug`
- captured first exact meaningful outcome and stopped

Not performed:
- no `adb shell am start*` relaunch
- no UI interaction commands (`adb shell input`, `adb shell monkey`, UI automation)
- no network actions/traffic probes from shell
- no runtime-debugging capture (`adb logcat`, profiler, traces)
- no broad diagnostics beyond bounded probe
- no `assemble*` continuation
- no release signing/distribution work

## Persisted Baseline Confirmation
```text
android/sing-box branch=cp017-local-baseline
android/sing-box commit=aed32ee3066cdbc7d471e3e0415c5134088962df
```

## Exact Prerequisite State Checks
```text
docs/android/ANDROID_POST_INSTALL_VERIFICATION_CONTINUATION.md => True
docs/android/evidence/cp035_retry3_prereq_checks.log => True
docs/android/evidence/cp035_retry3_launch_probe.clean.log => True
android/fork/app/build/outputs/apk/oss/debug/output-metadata.json => True
android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk => True
output-metadata applicationId=moe.nb4a.debug
applicationId expected moe.nb4a.debug => True
ANDROID_HOME=C:/Android/Sdk
adb resolved path=C:/Android/Sdk/platform-tools/adb.exe
adb resolvable => True
List of devices attached
emulator-5554          device product:sdk_gphone64_x86_64 model:sdk_gphone64_x86_64 device:emu64xa transport_id:1
online adb target count=1
online adb exactly one => True
online adb serial=emulator-5554
adb target abi=x86_64
adb target abi is x86_64 => True
pm path output=package:/data/app/~~5luga3s0QmDqGRYEv51_HA==/moe.nb4a.debug-yGFPWG-QoCmncva-7Hw5PQ==/base.apk
installed package check passes => True
CP-036 hard prerequisites pass => True
```

## Exact Probe Command
```powershell
& "$env:ANDROID_HOME\platform-tools\adb.exe" -s emulator-5554 shell pidof moe.nb4a.debug
```

## Exact Probe Output
```text
3151
EXIT_CODE: 0
```

## First Exact Meaningful Outcome
First exact meaningful outcome after probe entry:
```text
3151
```

This confirms app process liveness for `moe.nb4a.debug` in bounded scope.

## Expected Success Signals Check
Observed:
- `pidof` output non-empty: Yes (`3151`)
- `pidof` output numeric PID token(s): Yes
- `EXIT_CODE: 0`: Yes

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
Fallback commands were not required.

Canonical evidence retained:
- `docs/android/evidence/cp036_prereq_checks.log`
- `docs/android/evidence/cp036_adb_devices.log`
- `docs/android/evidence/cp036_pidof_probe.log`
- `docs/android/evidence/cp036_pidof_probe.clean.log`
- `docs/android/evidence/cp036_out_of_scope_checks.log`

## Cleanup Expectations and Result
Cleanup expectations were satisfied:
- no `libcore.aar` regeneration
- no disposable gomobile/GOPATH workspaces
- no temporary scratch files outside `docs/android/evidence/`
- canonical evidence retained under `docs/android/evidence/`
- no uninstall performed
- no force-stop/kill performed
- upstream source trees unchanged

## Outcome
CP-036 execution is complete.

Completed:
- all prerequisites verified
- single bounded process probe executed
- expected process-alive success signals captured
- strict scope preservation
