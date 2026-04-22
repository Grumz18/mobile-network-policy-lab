# Android Post-Focus Verification Continuation

## Purpose
This document records CP-040 execution of the smallest bounded resumed-task verification surface after CP-039 focus-boundary correction.

Scope remained strict:
- prerequisite verification only
- one bounded resumed-task probe exactly once
- first exact meaningful outcome capture and immediate stop

Out of scope remained unperformed:
- no UI interaction commands
- no network actions
- no app relaunch commands
- no runtime-debugging capture
- no assemble/release continuation

## Checkpoint
CP-040

## Date
2026-04-23

## Current Known State At Entry
- Device recovery gate passed: exactly one online adb target.
- Online target: `emulator-5554` (`device`).
- Target ABI: `x86_64`.
- Package `moe.nb4a.debug` installed.
- Process continuity present (`pidof` numeric).
- CP-039 focus-boundary correction artifact exists.

## Exact Prerequisite Verification
```text
android/sing-box branch=cp017-local-baseline
android/sing-box commit=aed32ee3066cdbc7d471e3e0415c5134088962df
docs/android/ANDROID_POST_FOCUS_BOUNDARY_CORRECTION.md => True
android/fork/app/build/outputs/apk/oss/debug/output-metadata.json => True
output-metadata applicationId=moe.nb4a.debug
applicationId expected moe.nb4a.debug => True
adb resolved path=C:/Android/Sdk/platform-tools/adb.exe
adb resolvable => True
online adb target count=1
online adb target serial=emulator-5554
target abi=x86_64
pm path moe.nb4a.debug => package:/data/app/~~5luga3s0QmDqGRYEv51_HA==/moe.nb4a.debug-yGFPWG-QoCmncva-7Hw5PQ==/base.apk
pidof moe.nb4a.debug => 3551
foreground continuity line =>     topResumedActivity=ActivityRecord{71196b7 u0 moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity t11}
```

## Single Bounded Probe (Executed Once)
```powershell
& "C:/Android/Sdk/platform-tools/adb.exe" -s emulator-5554 shell "dumpsys activity activities | grep -m 1 -E 'topResumedActivity=.* t[0-9]+'"
```

Captured output:
```text
topResumedActivity=ActivityRecord{71196b7 u0 moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity t11}
EXIT_CODE: 0
```

Note:
- `adb` also emitted `Failed to write while dumping service activity: Broken pipe` after `grep -m 1` terminated early; this did not invalidate success signals and probe exit code remained `0`.

## First Exact Meaningful Outcome
```text
topResumedActivity=ActivityRecord{71196b7 u0 moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity t11}
```

## Success Signal Evaluation
- probe output non-empty: yes
- contains `topResumedActivity=`: yes
- contains `moe.nb4a.debug`: yes
- contains `io.nekohasekai.sagernet.ui.MainActivity` or `.ui.MainActivity`: yes
- contains task token `t[0-9]+`: yes (`t11`)
- `EXIT_CODE: 0`: yes

## Fallback Evidence Sources
Direct probe output was sufficient. Additional captured evidence for continuity:
- `docs/android/evidence/cp040_probe.log`
- `docs/android/evidence/cp040_adb_devices.log`
- `docs/android/evidence/cp040_prereq_checks.log`

## Cleanup and Boundary Confirmation
- no `libcore.aar` regeneration
- no disposable gomobile/GOPATH workspaces created
- no uninstall / force-stop / kill commands used
- upstream source tree under `android/fork/` unchanged
- no out-of-scope UI/network/runtime-debugging/feature work performed

## Outcome
CP-040 execution result: `complete`.
