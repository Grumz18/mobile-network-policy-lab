# Android Post-Package Boundary Correction

## Purpose
This document records CP-033 execution of only the bounded post-package boundary correction and APK verification probe.

The checkpoint remained limited to verifying the corrected APK output boundary and running a single `apksigner verify` command.
No install, launch, runtime debugging, assemble continuation, or feature work was performed.

## Checkpoint
CP-033

## Date
2026-04-22

## Scope Boundary
Performed:
- printed `JAVA_HOME` and `java -version`
- confirmed `android/sing-box` stayed on `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified all CP-033 prerequisites exactly as authored
- verified the corrected APK output path under `android/fork/app/build/outputs/apk/oss/debug`
- verified CP-032 already reached first APK materialization at the corrected boundary
- ran one bounded APK verification probe:
  - `& "$env:ANDROID_HOME\build-tools\35.0.1\apksigner.bat" verify --verbose --print-certs ".\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-x86_64-debug.apk"`
- stopped at the first exact meaningful outcome
- verified expected success artifact and out-of-scope path checks
- applied CP-033 cleanup expectations

Not performed:
- no revisit of the cleared `libcore` metadata bridge
- no baseline changes in `android/sing-box`
- no modifications to upstream source under `android/fork/`
- no install / launch / runtime-debugging actions
- no Android product, per-app routing, transport, server, or CI/CD changes

## Pre-Probe Environment
```text
JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot\
openjdk version "17.0.18" 2026-01-20
OpenJDK Runtime Environment Temurin-17.0.18+8 (build 17.0.18+8)
OpenJDK 64-Bit Server VM Temurin-17.0.18+8 (build 17.0.18+8, mixed mode, sharing)
```

`ANDROID_HOME` was unset in the shell session and was resolved from `android/fork/local.properties` only to execute the exact CP-033 command:
```text
ANDROID_HOME_RESOLVED=C:/Android/Sdk
APKSIGNER_PATH=C:/Android/Sdk\build-tools\35.0.1\apksigner.bat
APKSIGNER_EXISTS=True
```

## Persisted Sing-Box Prerequisite Confirmation
```text
branch=cp017-local-baseline
commit=aed32ee3066cdbc7d471e3e0415c5134088962df
```

## Exact Prerequisite State Checks
```text
docs/android/ANDROID_POST_VALIDATE_SIGNING_CONTINUATION.md => True
docs/android/evidence/cp032_packageOssDebug.log => True
docs/android/evidence/cp032_packageOssDebug.clean.log => True
android/fork/app/build/outputs/apk/oss/debug/output-metadata.json => True
android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-arm64-v8a-debug.apk => True
android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-armeabi-v7a-debug.apk => True
android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86-debug.apk => True
android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk => True
android/fork/app/build/outputs/apk/oss/debug => True
```

Corrected output boundary listing:
```text
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-arm64-v8a-debug.apk | len=22164103 | mtime=2026-04-22 14:07:31
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-armeabi-v7a-debug.apk | len=22219444 | mtime=2026-04-22 14:07:31
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-x86_64-debug.apk | len=22791001 | mtime=2026-04-22 14:07:31
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-x86-debug.apk | len=22849975 | mtime=2026-04-22 14:07:31
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\output-metadata.json | len=1367 | mtime=2026-04-22 14:07:31
```

## CP-032 Boundary Confirmation
CP-032 already reached first APK materialization at the corrected boundary.

Evidence excerpt (from `docs/android/ANDROID_POST_VALIDATE_SIGNING_CONTINUATION.md`):
```text
> Task :app:packageOssDebug
BUILD SUCCESSFUL in 10s
EXIT_CODE: 0
android/fork/app/build/outputs/apk/oss/debug => True
```

## Exact Probe Command
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
& "$env:ANDROID_HOME\build-tools\35.0.1\apksigner.bat" verify --verbose --print-certs ".\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-x86_64-debug.apk"
```

Exact transcript:
- `docs/android/evidence/cp033_apksigner_verify.log`
- `docs/android/evidence/cp033_apksigner_verify.clean.log`

Key exact output:
```text
Verifies
Verified using v1 scheme (JAR signing): true
Verified using v2 scheme (APK Signature Scheme v2): true
EXIT_CODE: 0
```

Additional output captured:
- signer certificate details for one debug signer
- warnings about unprotected entries under `META-INF/` (non-fatal for verification result)

## First Exact Meaningful Outcome
The first exact meaningful outcome was successful bounded APK verification (`apksigner verify`) with `EXIT_CODE: 0`.

## Post-Probe Artifact and Scope Verification
Expected success artifacts remain present:
```text
android/fork/app/build/outputs/apk/oss/debug/output-metadata.json => True
android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk => True
```

Expected out-of-scope paths remain absent:
```text
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/release => False
android/fork/app/build/outputs/bundle/ossDebug => False
android/fork/app/build/outputs/apk/androidTest/oss/debug => False
```

Out-of-scope actions remained unperformed:
- no install command
- no launch/runtime-debugging command
- no `assemble*` continuation

## Fallback Evidence Sources
Direct shell output for the bounded probe was complete, so fallback evidence was not required to determine outcome.

Prepared fallback evidence sources:
- `docs/android/evidence/cp032_packageOssDebug.log`
- `docs/android/evidence/cp032_packageOssDebug.clean.log`
- `docs/android/evidence/cp033_apk_dir_listing.log`
- `docs/android/evidence/cp033_output_metadata_snapshot.json`
- `docs/android/evidence/cp033_cp032_boundary_evidence.log`

## Cleanup Expectations and Result
CP-033 cleanup expectations were met:
- `libcore.aar` was not regenerated
- no disposable gomobile/GOPATH workspace was created
- no temporary verification scratch workspace was created, so no scratch deletion was required
- produced APK outputs and metadata were left in place
- upstream source trees were left unchanged

`git` state checks after probe:
- workspace root: untracked evidence files only
- `android/fork`: no upstream source edits from this checkpoint

## Outcome
CP-033 execution is complete.

The package-stage boundary correction is validated:
- corrected boundary `android/fork/app/build/outputs/apk/oss/debug` is confirmed
- bounded APK verification succeeded with required signal lines
- scope remained fully bounded to CP-033
