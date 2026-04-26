# Android ADB Shell Transport Stability

## Purpose
This document records CP-046 execution of bounded ADB shell transport-stability verification after CP-045 transport errors.

Scope remained strict:
- prerequisite verification before probe entry
- exactly one minimal transport probe execution
- first meaningful outcome capture and immediate stop
- no interface-state probing, UI interaction, network actions, or runtime debugging

## Checkpoint
CP-046

## Date
2026-04-27

## Prerequisites Before Probe Entry
Verified in this run:
- `docs/android/ANDROID_POST_HOST_RECOVERY_INTERFACE_REENTRY.md` exists
- `adb devices -l` shows exactly one online target in `device` state
- target serial matches `emulator-5554`

Prerequisite evidence:
- `docs/android/evidence/cp046_prereq_checks.log`
- `docs/android/evidence/cp046_adb_devices.log`

## Single Bounded Transport Probe (Executed Once)
Executed exactly once:
```powershell
& "C:/Android/Sdk/platform-tools/adb.exe" shell "echo transport_check && echo ok"
```

Probe transcript:
- `docs/android/evidence/cp046_probe.log`
- `docs/android/evidence/cp046_probe.clean.log`

## First Exact Meaningful Outcome
`PROBE_SUCCESS: transport_check | ok`

## Success Signal Evaluation
Expected success signals were satisfied:
- output contains `transport_check`: `true`
- output contains `ok`: `true`
- `EXIT_CODE: 0`: `true`
- no `request send failed` / `Permission denied` transport errors: `true`

## Outcome
CP-046 execution result: `complete`.

## Cleanup And Boundary Confirmation
- no temporary scratch files retained outside `docs/android/evidence/`
- canonical evidence retained under `docs/android/evidence/`
- upstream source trees unchanged
- transport stability verification remained separated from interface-state verification and runtime debugging
