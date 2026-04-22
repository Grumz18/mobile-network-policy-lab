# Android Post-Install-Verification Continuation

## Purpose
This document records CP-035 execution of only the bounded post-install launch-verification continuation surface.

CP-035 scope stayed limited to prerequisite verification and decision-gating for one bounded launch probe.
No runtime debugging, interaction testing, feature work, or broader continuation was performed.

## Checkpoint
CP-035

## Date
2026-04-22

## Scope Boundary
Performed:
- printed `JAVA_HOME`
- printed `java -version`
- confirmed `android/sing-box` remained on `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified all CP-035 prerequisite checks exactly as authored
- verified package identity and launcher activity expectations from APK metadata/badging
- verified adb device-state gate and installed-package gate before probe entry
- stopped at the first exact meaningful outcome per CP-035 first-outcome rules

Not performed:
- no launch probe execution (`adb shell am start -W ...`) because hard prerequisites failed
- no `adb logcat`
- no `adb shell dumpsys*`
- no interaction commands (`adb shell input`, `adb shell monkey`, UI automation)
- no runtime debugging or feature validation
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
ANDROID_HOME=
resolved Android SDK root=C:/Android/Sdk
adb resolved path=C:\Android\Sdk\platform-tools\adb.exe
adb resolvable => True
aapt resolved path=C:\Android\Sdk\build-tools\35.0.1\aapt.exe
aapt resolvable => True
launchable-activity line=launchable-activity: name='io.nekohasekai.sagernet.ui.MainActivity'  label='' icon=''
launchable activity expected io.nekohasekai.sagernet.ui.MainActivity => True
List of devices attached

online adb target count=0
online adb exactly one => False
adb target abi is x86_64 => False
installed package check passes => False
CP-035 hard prerequisites pass => False
```

## First Exact Meaningful Outcome
First exact meaningful outcome is the first failed hard prerequisite line:
```text
online adb exactly one => False
```

Because this prerequisite failed, CP-035 correctly stopped before launch-probe execution.

## Exact Bounded Probe Command (Defined, Not Executed)
```powershell
& "$env:ANDROID_HOME\platform-tools\adb.exe" -s <serial> shell am start -W -n "moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity"
```

Execution status:
```text
SKIPPED: hard prerequisites failed before probe entry
```

## Expected Launch Success Signals
Not observed in this run because launch probe was not entered:
- `Starting: Intent { cmp=moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity`
- `Status: ok`
- `Activity: moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity`
- `Complete`
- `EXIT_CODE: 0`

## Out-of-Scope Verification
Out-of-scope actions remained unperformed:
- no launch probe retries
- no runtime-debugging commands
- no interaction testing
- no build-chain continuation

## Fallback Evidence Sources
Direct prereq shell output was complete for this bounded outcome.
Fallback sources retained for continuity:
- `docs/android/evidence/cp035_prereq_checks.log`
- `docs/android/evidence/cp035_adb_devices.log`
- `docs/android/evidence/cp035_output_metadata_snapshot.json`
- `docs/android/evidence/cp035_prereq_checks_retry.log`

No launch-output fallback (`pm path`/`pidof`) was needed because launch command was not entered after failed hard prerequisites.

## Cleanup Expectations and Result
Cleanup expectations were satisfied:
- no `libcore.aar` regeneration
- no disposable gomobile/GOPATH workspace creation
- no temporary scratch files outside `docs/android/evidence/`
- canonical evidence retained under `docs/android/evidence/`
- no uninstall performed
- upstream source trees unchanged

## Outcome
CP-035 execution is partial.

Completed:
- all prerequisite checks and prerequisite evidence capture
- precise first meaningful outcome capture at prereq gate
- strict scope preservation

Remaining inside CP-035:
- re-run CP-035 when exactly one online adb target is available with ABI `x86_64` and package `moe.nb4a.debug` present, then execute one bounded launch probe