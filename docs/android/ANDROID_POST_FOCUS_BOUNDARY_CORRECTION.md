# Android Post-Focus Boundary Correction

## Purpose
This document records CP-039 execution of only the bounded post-CP-038 focus/window boundary-correction surface.

CP-039 scope remained limited to exact prerequisite checks and one bounded replacement focus/window-state probe.
No UI interaction, network actions, runtime debugging, feature work, or broader continuation was performed.

## Checkpoint
CP-039

## Date
2026-04-22

## Scope Boundary
Performed:
- verified all CP-039 prerequisite state checks exactly as authored
- confirmed exactly one online adb target exists
- confirmed installed package `moe.nb4a.debug` is present
- confirmed CP-035, CP-036, CP-037, and CP-038 evidence exists
- ran one bounded replacement focus/window-state probe:
  - `adb shell "dumpsys window | grep -m 1 -E 'mCurrentFocus|mFocusedApp'"`
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
docs/android/ANDROID_POST_FOREGROUND_STATE_CONTINUATION.md => True
docs/android/evidence/cp038_prereq_checks.log => True
docs/android/evidence/cp038_focus_probe.clean.log => True
docs/android/evidence/cp038_focus_fallback.log => True
docs/android/ANDROID_POST_PROCESS_VERIFICATION_CONTINUATION.md => True
docs/android/ANDROID_POST_LAUNCH_PROCESS_VERIFICATION.md => True
docs/android/ANDROID_POST_INSTALL_VERIFICATION_CONTINUATION.md => True
docs/android/evidence/cp035_retry3_prereq_checks.log => True
docs/android/evidence/cp036_prereq_checks.log => True
docs/android/evidence/cp037_prereq_checks.log => True
android/fork/app/build/outputs/apk/oss/debug/output-metadata.json => True
android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk => True
output-metadata applicationId=moe.nb4a.debug
applicationId expected moe.nb4a.debug => True
ANDROID_HOME=
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
foreground continuity output=topResumedActivity=ActivityRecord{9f9287f u0 moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity t7}
foreground continuity check passes => True
CP-039 hard prerequisites pass => True
```

## Exact Probe Command
```powershell
& "C:/Android/Sdk/platform-tools/adb.exe" -s emulator-5554 shell "dumpsys window | grep -m 1 -E 'mCurrentFocus|mFocusedApp'"
```

## Exact Probe Output
```text
  mCurrentFocus=Window{88b430e u0 moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity}
EXIT_CODE: 0
```

## First Exact Meaningful Outcome
First exact meaningful outcome after probe entry:
```text
  mCurrentFocus=Window{88b430e u0 moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity}
```

Interpretation inside CP-039 boundary:
- required replacement-probe success signal is present for focus/package/activity
- `EXIT_CODE: 0` confirms bounded command success
- non-fatal `Broken pipe` shell warning appeared in raw output and is expected with `grep -m 1` pipe termination

## Expected Success Signals Check
Observed:
- probe output non-empty: Yes
- output contains `mCurrentFocus` or `mFocusedApp`: Yes (`mCurrentFocus`)
- output contains `moe.nb4a.debug`: Yes
- output contains `io.nekohasekai.sagernet.ui.MainActivity` or `.ui.MainActivity`: Yes
- `EXIT_CODE: 0`: Yes

## Fallback Evidence Sources
Direct shell output was complete for CP-039 success verification.
Fallback commands were not required in this run.

Canonical evidence retained:
- `docs/android/evidence/cp039_prereq_checks.log`
- `docs/android/evidence/cp039_adb_devices.log`
- `docs/android/evidence/cp039_focus_probe.log`
- `docs/android/evidence/cp039_focus_probe.clean.log`
- `docs/android/evidence/cp039_out_of_scope_checks.log`

## Out-of-Scope Verification
Out-of-scope actions remained unperformed.

Out-of-scope path checks:
```text
android/fork/app/build/outputs/apk/oss/release => False
android/fork/app/build/outputs/bundle/ossDebug => False
android/fork/app/build/outputs/apk/androidTest/oss/debug => False
```

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
CP-039 execution is complete.

Completed:
- all prerequisites verified
- single bounded replacement focus probe executed
- expected success signals captured
- strict scope preservation
