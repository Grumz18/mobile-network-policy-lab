# Android Post-Validate-Signing Continuation

## Purpose
This document records CP-032 execution of only the first exact downstream continuation surface after successful `.\gradlew.bat :app:validateSigningOssDebug --stacktrace`.

The checkpoint remained bounded to `.\gradlew.bat :app:packageOssDebug --stacktrace` and did not continue into install/assemble/feature work.

## Checkpoint
CP-032

## Date
2026-04-22

## Scope Boundary
Performed:
- printed `JAVA_HOME` and `java -version`
- confirmed `android/sing-box` stayed on `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified CP-032 prerequisite checks exactly as defined
- reused only the bounded prerequisite `libcore` path and regenerated transient `android/fork/app/libs/libcore.aar`
- executed exactly once: `.\gradlew.bat :app:packageOssDebug --stacktrace`
- stopped at the first exact meaningful outcome
- verified expected success signal, expected success path, and out-of-scope path checks
- performed CP-032 cleanup expectations

Not performed:
- no metadata-bridge revisit as a new repair surface
- no baseline changes to `android/sing-box`
- no source changes under `android/fork/`
- no install/assemble continuation
- no Android feature, per-app routing, transport, or server work

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
Before reproducing transient `libcore.aar`:
```text
android/fork/app/build/intermediates/compile_app_classes_jar/ossDebug/bundleOssDebugClassesToCompileJar/classes.jar => True
android/fork/app/build/intermediates/runtime_app_classes_jar/ossDebug/bundleOssDebugClassesToRuntimeJar/classes.jar => True
android/fork/app/build/intermediates/project_dex_archive/ossDebug => True
android/fork/app/build/intermediates/project_dex_archive/ossDebug/dexBuilderOssDebug/out => True
android/fork/app/build/intermediates/external_libs_dex_archive/ossDebug/dexBuilderOssDebug/out => True
android/fork/app/build/intermediates/sub_project_dex_archive/ossDebug/dexBuilderOssDebug/out => True
android/fork/app/build/intermediates/dex/ossDebug/mergeProjectDexOssDebug => True
android/fork/app/build/intermediates/dex/ossDebug/mergeExtDexOssDebug => True
android/fork/app/build/intermediates/dex/ossDebug/mergeLibDexOssDebug => True
android/fork/app/build/intermediates/java_res/ossDebug/processOssDebugJavaRes/out => True
android/fork/app/build/intermediates/merged_java_res/ossDebug/mergeOssDebugJavaResource => True
android/fork/app/build/intermediates/merged_jni_libs/ossDebug/mergeOssDebugJniLibFolders => True
android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out => True
android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out => True
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
android/fork/app/libs/libcore.aar => False
```

After reproducing transient `libcore.aar` and before Gradle entry:
```text
android/fork/app/libs/libcore.aar => True
android/fork/app/build/intermediates/compile_app_classes_jar/ossDebug/bundleOssDebugClassesToCompileJar/classes.jar => True
android/fork/app/build/intermediates/runtime_app_classes_jar/ossDebug/bundleOssDebugClassesToRuntimeJar/classes.jar => True
android/fork/app/build/intermediates/project_dex_archive/ossDebug => True
android/fork/app/build/intermediates/project_dex_archive/ossDebug/dexBuilderOssDebug/out => True
android/fork/app/build/intermediates/external_libs_dex_archive/ossDebug/dexBuilderOssDebug/out => True
android/fork/app/build/intermediates/sub_project_dex_archive/ossDebug/dexBuilderOssDebug/out => True
android/fork/app/build/intermediates/dex/ossDebug/mergeProjectDexOssDebug => True
android/fork/app/build/intermediates/dex/ossDebug/mergeExtDexOssDebug => True
android/fork/app/build/intermediates/dex/ossDebug/mergeLibDexOssDebug => True
android/fork/app/build/intermediates/java_res/ossDebug/processOssDebugJavaRes/out => True
android/fork/app/build/intermediates/merged_java_res/ossDebug/mergeOssDebugJavaResource => True
android/fork/app/build/intermediates/merged_jni_libs/ossDebug/mergeOssDebugJniLibFolders => True
android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out => True
android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out => True
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
```

## Bounded Prerequisite Reproduction
Only the existing bounded libcore prerequisite path was reused.

Disposable paths:
- `.tmp/cp032-gomobile-src`
- `.tmp/cp032-gopath`

Observed prerequisite command marker:
```text
bash -x ./build.sh (android/fork/libcore) with GOPATH=/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/.tmp/cp032-gopath
```

Observed prerequisite signal:
```text
>> install /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/app/libs/libcore.aar
```

Known non-blocking line remained present:
```text
./build.sh: line 3: ./env_java.sh: No such file or directory
```

Prerequisite transcript:
- `docs/android/evidence/cp032_libcore_build.log`

## Exact Probe Command
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:packageOssDebug --stacktrace
```

Exact direct shell transcript:
- `docs/android/evidence/cp032_packageOssDebug.log`
- `docs/android/evidence/cp032_packageOssDebug.clean.log`

Key exact output lines:
```text
> Task :app:packageOssDebug
> Task :app:createOssDebugApkListingFileRedirect
BUILD SUCCESSFUL in 10s
EXIT_CODE: 0
```

## First Exact Meaningful Outcome
The first exact meaningful outcome was success of `:app:packageOssDebug`.

## Post-Probe Artifact and Scope Verification
Expected success signal was confirmed:
```text
> Task :app:packageOssDebug
BUILD SUCCESSFUL in 10s
EXIT_CODE: 0
```

Expected success artifact path check (as authored in CP-032):
```text
android/fork/app/build/intermediates/apk/oss/debug => False
```

Observed downstream materialization instead:
```text
android/fork/app/build/outputs/apk/oss/debug => True
```

Observed example files under the materialized output path:
```text
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-arm64-v8a-debug.apk | len=22164103 | mtime=2026-04-22 14:07:31
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-armeabi-v7a-debug.apk | len=22219444 | mtime=2026-04-22 14:07:31
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-x86-debug.apk | len=22849975 | mtime=2026-04-22 14:07:31
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\NekoBox-1.4.2-x86_64-debug.apk | len=22791001 | mtime=2026-04-22 14:07:31
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\outputs\apk\oss\debug\output-metadata.json | len=1367 | mtime=2026-04-22 14:07:31
```

Authored out-of-scope path check result:
```text
android/fork/app/build/outputs/apk/oss/debug => True
```

This means CP-032 captured a successful `packageOssDebug` outcome, but the authored expected-success/out-of-scope path assumptions did not hold.

## Fallback Evidence Sources
Direct shell transcript was complete, so daemon-log fallback was not required to determine outcome.

Available daemon-log fallback scope:
- `C:\Users\grUm.IGOR\.gradle\daemon\8.10.2\daemon-13220.out.log`

## Cleanup After Evidence Capture
Removed exactly per CP-032 expectations:
- `.tmp/cp032-gomobile-src`
- `.tmp/cp032-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Cleanup state check:
```text
.tmp/cp032-gomobile-src => False
.tmp/cp032-gopath => False
android/fork/libcore/.build => False
android/fork/app/libs/libcore.aar => False
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => True
```

## Outcome
CP-032 execution is partial.

Confirmed:
- exact bounded probe command was executed once
- first exact meaningful outcome was success of `:app:packageOssDebug`
- expected success signal lines were observed

Partial gap:
- CP-032 authored boundary assumptions about success/out-of-scope artifact paths did not hold:
  - authored success path `android/fork/app/build/intermediates/apk/oss/debug` was not materialized
  - authored out-of-scope path `android/fork/app/build/outputs/apk/oss/debug` became present

## Exact Next Surface
The next checkpoint should redefine the smallest bounded continuation from the observed CP-032 result and real output locations before any further install/assemble continuation.
