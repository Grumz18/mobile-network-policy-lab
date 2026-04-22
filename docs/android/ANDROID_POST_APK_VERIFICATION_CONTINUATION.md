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
- ran the single bounded install-verification command and captured success output
- captured exact command marker and prerequisite/fallback evidence
- verified out-of-scope actions remained unperformed
- applied CP-034 cleanup expectations

Not performed:
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

## Exact Prerequisite State Checks (Initial Blocked Attempt)
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

## Exact Prerequisite State Checks (Successful Final Attempt)
```text
exactly one online adb target exists
target ABI is x86_64
```

## ADB Device State (Required Gate)
CP-034 requires exactly one online adb target with ABI `x86_64` before attempting install.

Observed:
```text
List of devices attached

online adb target count=0
```

## Exact Probe Command
Bounded probe command:
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
& "$env:ANDROID_HOME\platform-tools\adb.exe" install -r ".\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-x86_64-debug.apk"
```

Earlier CP-034 attempts stopped at adb prerequisite gating.
The later observed bounded install-verification run entered this exact command and succeeded.

## First Exact Meaningful Outcome
The first exact meaningful outcome for the successful bounded install-verification run was install success:
```text
Performing Streamed Install
Success
EXIT_CODE: 0
```

Observed device/package continuity facts for that same successful run:
```text
exactly one online adb target exists
target ABI is x86_64
package moe.nb4a.debug is installed on device
```

## Expected Success Signals
Expected install success signals were observed:
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
Direct shell output for prerequisites and successful install verification was complete.
Prerequisite/fallback evidence snapshots remain captured:
- `docs/android/evidence/cp034_prereq_checks.log`
- `docs/android/evidence/cp034_adb_devices.log`
- `docs/android/evidence/cp034_output_metadata_snapshot.json`
- `docs/android/evidence/cp034_out_of_scope_path_checks.log`
- `docs/android/evidence/cp034_retry_prereq_checks.log`
- `docs/android/evidence/cp034_retry_adb_devices.log`
- `docs/android/evidence/cp034_retry_out_of_scope_path_checks.log`

## Cleanup Expectations and Result
Cleanup expectations were satisfied:
- no `libcore.aar` regeneration
- no disposable gomobile/GOPATH workspace creation
- no scratch artifacts outside `docs/android/evidence/`
- canonical evidence retained under `docs/android/evidence/`
- no uninstall performed
- upstream source trees unchanged

## Outcome
CP-034 execution is complete.

Completed:
- all prerequisite checks and bounded gate evidence capture
- successful bounded install verification with required success lines
- confirmation that `moe.nb4a.debug` is installed on target device
- strict scope preservation
