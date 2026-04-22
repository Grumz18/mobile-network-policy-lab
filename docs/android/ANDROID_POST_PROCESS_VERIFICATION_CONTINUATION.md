# Android Post-Process Verification Continuation

## Purpose
This document records CP-037 execution of only the bounded post-process foreground-state verification surface.

CP-037 scope remained limited to exact prerequisite checks and one bounded foreground-state probe.
No UI interaction, network actions, runtime debugging, feature work, or broader continuation was performed.

## Checkpoint
CP-037

## Date
2026-04-22

## Scope Boundary
Performed:
- verified all CP-037 prerequisite state checks exactly as authored
- confirmed exactly one online adb target exists
- confirmed installed package `moe.nb4a.debug` is present
- confirmed CP-035 and CP-036 evidence exists
- ran one bounded state probe:
  - `adb shell "dumpsys activity activities | grep -m 1 -E 'mResumedActivity|topResumedActivity'"`
- captured first exact meaningful outcome and stopped

Not performed:
- no UI interaction commands (`adb shell input`, `adb shell monkey`, UI automation)
- no network actions/traffic probes from device shell
- no app relaunch commands (`adb shell am start*`)
- no runtime-debugging capture (`adb logcat`, profiler, traces)
- no broad diagnostics beyond bounded probe/fallback policy
- no `assemble*` continuation
- no release signing/distribution work

## Persisted Baseline Confirmation
```text
android/sing-box branch=cp017-local-baseline
android/sing-box commit=aed32ee3066cdbc7d471e3e0415c5134088962df
```

## Exact Prerequisite State Checks
```text
docs/android/ANDROID_POST_LAUNCH_PROCESS_VERIFICATION.md => True
docs/android/evidence/cp036_prereq_checks.log => True
docs/android/evidence/cp036_pidof_probe.clean.log => True
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
pidof output=3151
process check passes => True
CP-037 hard prerequisites pass => True
```

## Exact Probe Command
```powershell
& "$env:ANDROID_HOME\platform-tools\adb.exe" -s emulator-5554 shell "dumpsys activity activities | grep -m 1 -E 'mResumedActivity|topResumedActivity'"
```

## Exact Probe Output
```text
topResumedActivity=ActivityRecord{9f9287f u0 moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity t7}
adb.exe : Failed to write while dumping service activity: Broken pipe
EXIT_CODE: 0
```

## First Exact Meaningful Outcome
First exact meaningful outcome after probe entry:
```text
topResumedActivity=ActivityRecord{9f9287f u0 moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity t7}
```

Interpretation inside CP-037 boundary:
- required foreground-state success signal is present for package/activity
- `EXIT_CODE: 0` confirms bounded command success
- the `Broken pipe` line is non-blocking side-effect from grep terminating the pipe after first match (`-m 1`)

## Expected Success Signals Check
Observed:
- probe output non-empty: Yes
- output contains `moe.nb4a.debug`: Yes
- output contains `io.nekohasekai.sagernet.ui.MainActivity`: Yes
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
Direct shell output was complete for CP-037 success verification.
Fallback commands were not required in this run.

Canonical evidence retained:
- `docs/android/evidence/cp037_prereq_checks.log`
- `docs/android/evidence/cp037_adb_devices.log`
- `docs/android/evidence/cp037_state_probe.log`
- `docs/android/evidence/cp037_state_probe.clean.log`
- `docs/android/evidence/cp037_out_of_scope_checks.log`

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
CP-037 execution is complete.

Completed:
- all prerequisites verified
- single bounded foreground-state probe executed
- expected state success signals captured
- strict scope preservation
