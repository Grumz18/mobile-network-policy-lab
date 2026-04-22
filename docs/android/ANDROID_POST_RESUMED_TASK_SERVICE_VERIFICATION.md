# Android Post-Resumed-Task Service Verification

## Purpose
This document records CP-041 execution of only the bounded post-resumed-task service-state verification surface.

Scope remained strict:
- prerequisite verification only
- one bounded service-state probe executed exactly once
- first exact meaningful outcome capture and immediate stop

Out-of-scope actions remained unperformed:
- no UI interaction commands
- no network actions
- no app relaunch commands
- no runtime-debugging capture
- no assemble/release continuation

## Checkpoint
CP-041

## Date
2026-04-23

## Exact Prerequisite Verification
```text
android/sing-box branch=cp017-local-baseline
android/sing-box commit=aed32ee3066cdbc7d471e3e0415c5134088962df
docs/android/ANDROID_POST_FOCUS_VERIFICATION_CONTINUATION.md => True
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
```

## Single Bounded Probe (Executed Once)
```powershell
& "C:/Android/Sdk/platform-tools/adb.exe" -s emulator-5554 shell "dumpsys activity services | grep -m 1 -E 'ServiceRecord\{.*moe\.nb4a\.debug/.+'"
```

Probe transcript:
```text
grep: bad regex 'ServiceRecord\{.*moe\.nb4a\.debug/.+': repetition-operator operand invalid
EXIT_CODE: 1
```

## First Exact Meaningful Outcome
```text
CP-041 probe failed: grep: bad regex 'ServiceRecord\{.*moe\.nb4a\.debug/.+': repetition-operator operand invalid
```

## Success Signal Evaluation
Expected signals were not reached in this run because the probe failed at regex parsing before producing service-state output.

## Fallback Evidence Sources
Captured in this run:
- `docs/android/evidence/cp041_probe.log`
- `docs/android/evidence/cp041_probe.clean.log`
- `docs/android/evidence/cp041_adb_devices.log`
- `docs/android/evidence/cp041_prereq_checks.log`

Fallback process/package continuity checks were already satisfied in prerequisites (`pidof`, `pm path`).

## Cleanup and Boundary Confirmation
- no `libcore.aar` regeneration
- no disposable gomobile/GOPATH workspaces
- no uninstall / force-stop / kill commands used
- upstream source trees unchanged
- no out-of-scope UI/network/runtime-debugging/feature work performed

## Outcome
CP-041 execution result: `partial`.

Completed:
- prerequisites verified and logged
- single bounded probe executed once
- first exact failure outcome captured and stop rule applied

Remaining:
- rerun CP-041 bounded probe in a retry attempt with valid grep expression handling, while keeping identical scope boundaries.

## Retry Outcome (2026-04-23)
CP-041 was retried in bounded scope with corrected toybox-compatible probe syntax.

Corrected probe command (executed once):
```powershell
& "C:/Android/Sdk/platform-tools/adb.exe" -s emulator-5554 shell "dumpsys activity services | grep -m 1 -E 'ServiceRecord.*moe\.nb4a\.debug/'"
```

Retry prerequisites remained satisfied:
```text
online adb target count=1
online adb target serial=emulator-5554
target abi=x86_64
pm path moe.nb4a.debug => package:/data/app/~~5luga3s0QmDqGRYEv51_HA==/moe.nb4a.debug-yGFPWG-QoCmncva-7Hw5PQ==/base.apk
pidof moe.nb4a.debug => 3551
```

Retry probe transcript:
```text
adb.exe : Failed to write while dumping service activity: Broken pipe
EXIT_CODE: 1
```

First exact meaningful outcome in retry:
```text
CP-041 retry probe failed: adb.exe : Failed to write while dumping service activity: Broken pipe
```

Retry result:
- `partial`
- stop rule applied immediately after first exact toolchain error line

Retry evidence files:
- `docs/android/evidence/cp041_retry_adb_devices.log`
- `docs/android/evidence/cp041_retry_prereq_checks.log`
- `docs/android/evidence/cp041_retry_probe.log`
- `docs/android/evidence/cp041_retry_probe.clean.log`

## Re-retry Outcome (2026-04-23)
CP-041 was re-retried in bounded scope with the same corrected probe syntax and explicit transient adb error handling.

Re-retry corrected probe command (executed once):
```powershell
& "C:/Android/Sdk/platform-tools/adb.exe" -s emulator-5554 shell "dumpsys activity services | grep -m 1 -E 'ServiceRecord.*moe\.nb4a\.debug/'"
```

Re-retry prerequisites remained satisfied:
```text
online adb target count=1
online adb target serial=emulator-5554
target abi=x86_64
pm path moe.nb4a.debug => package:/data/app/~~5luga3s0QmDqGRYEv51_HA==/moe.nb4a.debug-yGFPWG-QoCmncva-7Hw5PQ==/base.apk
pidof moe.nb4a.debug => 3551
```

Re-retry probe transcript:
```text
adb.exe : Failed to write while dumping service activity: Broken pipe
EXIT_CODE: 1
```

First exact meaningful outcome in re-retry:
```text
CP-041 re-retry probe failed: adb.exe : Failed to write while dumping service activity: Broken pipe
```

Re-retry result:
- `partial`
- stop rule applied immediately after first exact transient adb error line (no in-run retry loop)

Re-retry evidence files:
- `docs/android/evidence/cp041_reretry_adb_devices.log`
- `docs/android/evidence/cp041_reretry_prereq_checks.log`
- `docs/android/evidence/cp041_reretry_probe.log`
- `docs/android/evidence/cp041_reretry_probe.clean.log`
