# Android Post-Merged-Native-Libs Continuation

## Purpose
This document records CP-030 execution of only the first exact downstream continuation surface after successful `.\gradlew.bat :app:mergeOssDebugNativeLibs --stacktrace`.

The checkpoint remained bounded to `.\gradlew.bat :app:stripOssDebugDebugSymbols --stacktrace` and did not continue into signing/packaging/install/assemble work.

Why this was the exact next surface:
- CP-029 had already materialized `android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out`
- `android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out` was still absent before entry
- downstream task ordering kept `stripOssDebugDebugSymbols` as the smallest bounded continuation from that point

## Checkpoint
CP-030

## Date
2026-04-22

## Scope Boundary
Performed:
- printed `JAVA_HOME` and `java -version`
- confirmed `android/sing-box` stayed on `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified CP-030 prerequisites exactly as written
- reproduced only the bounded libcore prerequisite path to regenerate transient `android/fork/app/libs/libcore.aar`
- executed exactly once: `.\gradlew.bat :app:stripOssDebugDebugSymbols --stacktrace`
- stopped at the first exact meaningful outcome
- captured exact command/output evidence and daemon-log fallback scope
- verified expected success path and required out-of-scope absences
- performed CP-030 cleanup expectations

Not performed:
- no new metadata-bridge repair surface was opened
- no baseline changes to `android/sing-box`
- no source changes under `android/fork/`
- no signing/packaging/install/assemble continuation
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
android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out => False
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
android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out => False
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
```

## Bounded Prerequisite Reproduction
Only the existing bounded libcore prerequisite path was reused.

Disposable paths:
- `.tmp/cp030-gomobile-src`
- `.tmp/cp030-gopath`

Observed prerequisite command marker:
```text
bash -x ./build.sh (android/fork/libcore) with GOPATH=/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/.tmp/cp030-gopath
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
- `docs/android/evidence/cp030_libcore_build.log`

## Exact Probe Command
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:stripOssDebugDebugSymbols --stacktrace
```

Exact direct shell transcript:
- `docs/android/evidence/cp030_stripOssDebugDebugSymbols.log`

Key exact output lines:
```text
> Task :app:stripOssDebugDebugSymbols
Unable to strip the following libraries, packaging them as they are: libgojni.so.
BUILD SUCCESSFUL in 3s
EXIT_CODE: 0
```

## First Exact Meaningful Outcome
The first exact meaningful outcome was success of `:app:stripOssDebugDebugSymbols`.

## Post-Probe Artifact Verification
Expected success artifact path:
```text
android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out => True
```

Observed example files under the expected success path:
```text
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\stripped_native_libs\ossDebug\stripOssDebugDebugSymbols\out\lib\arm64-v8a\libgojni.so | len=25456104 | mtime=2026-04-22 13:14:25
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\stripped_native_libs\ossDebug\stripOssDebugDebugSymbols\out\lib\armeabi-v7a\libgojni.so | len=23328736 | mtime=2026-04-22 13:14:25
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\stripped_native_libs\ossDebug\stripOssDebugDebugSymbols\out\lib\x86\libgojni.so | len=23639204 | mtime=2026-04-22 13:14:25
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\stripped_native_libs\ossDebug\stripOssDebugDebugSymbols\out\lib\x86_64\libgojni.so | len=26588904 | mtime=2026-04-22 13:14:25
```

Required out-of-scope paths remained absent:
```text
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
```

## Fallback Evidence Sources
Direct shell transcript was complete, so daemon-log fallback was not required to determine outcome.

Available daemon-log fallback scope:
- `C:\Users\grUm.IGOR\.gradle\daemon\8.10.2\daemon-13220.out.log`

Observed daemon marker (fallback-ready):
```text
3989: Unable to strip the following libraries, packaging them as they are: libgojni.so.
```

## Cleanup After Evidence Capture
Removed exactly per CP-030 expectations:
- `.tmp/cp030-gomobile-src`
- `.tmp/cp030-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Cleanup state check:
```text
.tmp/cp030-gomobile-src => False
.tmp/cp030-gopath => False
android/fork/libcore/.build => False
android/fork/app/libs/libcore.aar => False
android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out => True
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
```

## Outcome
CP-030 execution is complete and successful.

Confirmed:
- exact bounded probe command was executed once
- first exact meaningful outcome was success of `:app:stripOssDebugDebugSymbols`
- expected success path now exists: `android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out`
- out-of-scope APK output paths remained absent
- the cleared metadata bridge was not revisited as a new repair surface
- probing stopped before signing/packaging/install/assemble continuation

## Exact Next Surface
The next checkpoint should define only the smallest bounded continuation after successful `.\gradlew.bat :app:stripOssDebugDebugSymbols --stacktrace`, most likely:
- `.\gradlew.bat :app:validateSigningOssDebug --stacktrace`


