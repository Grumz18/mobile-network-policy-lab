# Android Post-Stripped-Native-Libs Continuation

## Purpose
This document records CP-031 execution of only the first exact downstream continuation surface after successful `.\gradlew.bat :app:stripOssDebugDebugSymbols --stacktrace`.

The checkpoint remained bounded to `.\gradlew.bat :app:validateSigningOssDebug --stacktrace` and did not continue into packaging/install/assemble work.

## Checkpoint
CP-031

## Date
2026-04-22

## Scope Boundary
Performed:
- printed `JAVA_HOME` and `java -version`
- confirmed `android/sing-box` stayed on `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified CP-031 prerequisite checks exactly as defined
- reused only the bounded prerequisite `libcore` path and regenerated transient `android/fork/app/libs/libcore.aar`
- executed exactly once: `.\gradlew.bat :app:validateSigningOssDebug --stacktrace`
- stopped at the first exact meaningful outcome
- verified expected validation success signal and out-of-scope absent paths
- performed CP-031 cleanup expectations

Not performed:
- no metadata-bridge revisit as a new repair surface
- no baseline changes to `android/sing-box`
- no source changes under `android/fork/`
- no packaging/install/assemble continuation
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
- `.tmp/cp031-gomobile-src`
- `.tmp/cp031-gopath`

Observed prerequisite command marker:
```text
bash -x ./build.sh (android/fork/libcore) with GOPATH=/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/.tmp/cp031-gopath
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
- `docs/android/evidence/cp031_libcore_build.log`

## Exact Probe Command
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:validateSigningOssDebug --stacktrace
```

Exact direct shell transcript:
- `docs/android/evidence/cp031_validateSigningOssDebug.log`
- `docs/android/evidence/cp031_validateSigningOssDebug.clean.log` (same transcript with null bytes removed)

Key exact output lines:
```text
> Task :app:validateSigningOssDebug
BUILD SUCCESSFUL in 1s
EXIT_CODE: 0
```

## First Exact Meaningful Outcome
The first exact meaningful outcome was success of `:app:validateSigningOssDebug`.

## Post-Probe Signal and Out-of-Scope Verification
Expected validation success signal was confirmed:
```text
> Task :app:validateSigningOssDebug
BUILD SUCCESSFUL in 1s
EXIT_CODE: 0
```

Required out-of-scope paths remained absent:
```text
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
```

## Fallback Evidence Sources
Direct shell transcript was complete, so daemon-log fallback was not required to determine outcome.

Available daemon-log fallback scope remained:
- `C:\Users\grUm.IGOR\.gradle\daemon\8.10.2\daemon-13220.out.log`

## Cleanup After Evidence Capture
Removed exactly per CP-031 expectations:
- `.tmp/cp031-gomobile-src`
- `.tmp/cp031-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Cleanup state check:
```text
.tmp/cp031-gomobile-src => False
.tmp/cp031-gopath => False
android/fork/libcore/.build => False
android/fork/app/libs/libcore.aar => False
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
```

## Outcome
CP-031 execution is complete and successful.

Confirmed:
- exact bounded probe command was executed once
- first exact meaningful outcome was success of `:app:validateSigningOssDebug`
- exact expected validation success signal was observed
- out-of-scope APK output paths remained absent

Explicit separation preserved:
- continuation probing stopped at `validateSigningOssDebug` and did not broaden into packaging/install/assemble work

## Exact Next Surface
The next checkpoint should define only the smallest bounded continuation after successful `.\gradlew.bat :app:validateSigningOssDebug --stacktrace`, most likely:
- `.\gradlew.bat :app:packageOssDebug --stacktrace`
