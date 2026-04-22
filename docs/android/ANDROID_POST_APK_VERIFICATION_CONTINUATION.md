# Android Post-APK-Verification Continuation

## Purpose
This document records CP-034 execution of only the bounded post-APK-verification continuation surface.

CP-034 scope remained limited to install-verification prerequisites and the single bounded install command defined by the checkpoint.
No launch, runtime debugging, full assemble continuation, or feature work was performed.

## Checkpoint
CP-034

## Date
2026-04-22

## Scope Boundary
Performed:
- printed `JAVA_HOME`
- printed `java -version`
- confirmed `android/sing-box` remained on `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified all CP-034 prerequisite state checks exactly as authored
- verified the authored APK path for the bounded probe
- verified adb device state exactly as required by CP-034 before any install attempt
- captured exact command marker and prerequisite/fallback evidence
- verified out-of-scope actions remained unperformed
- applied CP-034 cleanup expectations

Not performed:
- no install probe execution (blocked by failed hard prerequisite)
- no app launch (`adb shell am start`)
- no runtime-debugging (`adb logcat`, `adb shell dumpsys`, profiler/trace capture)
- no functional feature validation
- no `assemble*` continuation
- no metadata-bridge revisit
- no baseline changes to `android/sing-box`
- no upstream source modifications under `android/fork/`

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
docs/android/ANDROID_POST_PACKAGE_BOUNDARY_CORRECTION.md => True
docs/android/evidence/cp033_apksigner_verify.log => True
docs/android/evidence/cp033_apksigner_verify.clean.log => True
android/fork/app/build/outputs/apk/oss/debug/output-metadata.json => True
android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk => True
apk path exact check: android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk => True
output-metadata applicationId=moe.nb4a.debug
ANDROID_HOME=C:/Android/Sdk
adb path=C:/Android/Sdk\platform-tools\adb.exe
adb path exists => True
online adb target count=0
online adb exactly one => False
adb target abi is x86_64 => False
```

## ADB Device State (Required Gate)
CP-034 requires exactly one online adb target with ABI `x86_64` before attempting install.

Observed:
```text
List of devices attached

online adb target count=0
```

## Exact Probe Command (Defined but Not Entered)
Defined bounded probe command:
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
& "$env:ANDROID_HOME\platform-tools\adb.exe" install -r ".\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-x86_64-debug.apk"
```

CP-034 did not enter this command because the hard precondition gate failed (`exactly one online adb target` and ABI check).

## First Exact Meaningful Outcome
The first exact meaningful outcome was prerequisite failure before probe entry:
```text
online adb target count=0
online adb exactly one => False
```

Per CP-034 first-meaningful-outcome rules, execution stopped immediately at that prerequisite failure.

## Expected Success Signals
Expected install success signals were not observed because the bounded probe was not entered:
- `Performing Streamed Install`
- `Success`
- `EXIT_CODE: 0`

## Out-of-Scope Verification
Out-of-scope actions remained unperformed:
- no launch command execution
- no runtime-debugging command execution
- no assemble continuation

Out-of-scope path checks remained absent:
```text
android/fork/app/build/outputs/apk/oss/release => False
android/fork/app/build/outputs/bundle/ossDebug => False
android/fork/app/build/outputs/apk/androidTest/oss/debug => False
```

## Fallback Evidence Sources
Direct shell output for prerequisite checks was complete.
Fallback evidence snapshots were still captured:
- `docs/android/evidence/cp034_prereq_checks.log`
- `docs/android/evidence/cp034_adb_devices.log`
- `docs/android/evidence/cp034_output_metadata_snapshot.json`
- `docs/android/evidence/cp034_out_of_scope_path_checks.log`

## Cleanup Expectations and Result
Cleanup expectations were satisfied:
- no `libcore.aar` regeneration
- no disposable gomobile/GOPATH workspace creation
- no scratch artifacts outside `docs/android/evidence/`
- canonical evidence retained under `docs/android/evidence/`
- no uninstall performed
- upstream source trees unchanged

## Outcome
CP-034 execution is partial.

Completed:
- all prerequisite checks and bounded gate evidence capture
- strict scope preservation

Remaining blocker:
- no eligible adb device state (`exactly one online x86_64 target`) to enter the bounded install-verification probe.
