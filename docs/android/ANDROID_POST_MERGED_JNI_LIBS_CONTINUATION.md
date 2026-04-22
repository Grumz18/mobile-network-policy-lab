# Android Post-Merged-JNI-Libs Continuation

## Purpose
This document records CP-029 execution of only the first exact downstream continuation surface after successful `.\gradlew.bat :app:mergeOssDebugJniLibFolders --stacktrace`.

The checkpoint remained bounded to `.\gradlew.bat :app:mergeOssDebugNativeLibs --stacktrace` and explicitly did not continue into strip/signing/packaging/install/assemble work.

## Checkpoint
CP-029

## Date
2026-04-22

## Scope Boundary
Performed:
- printed `JAVA_HOME` and `java -version`
- confirmed `android/sing-box` stayed on `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified all CP-029 prerequisite checks exactly as defined
- reused only the bounded prerequisite `libcore` path and regenerated transient `android/fork/app/libs/libcore.aar`
- executed exactly once: `.\gradlew.bat :app:mergeOssDebugNativeLibs --stacktrace`
- stopped at the first exact meaningful outcome
- verified expected success artifact path and out-of-scope absent paths
- performed CP-029 cleanup expectations

Not performed:
- no metadata-bridge revisit as a new repair surface
- no baseline changes to `android/sing-box`
- no source changes under `android/fork/`
- no strip/signing/packaging/install/assemble continuation
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
android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out => False
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
android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out => False
android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out => False
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
```

## Bounded Prerequisite Reproduction
Only the existing bounded libcore prerequisite path was reused.

Disposable paths:
- `.tmp/cp029-gomobile-src`
- `.tmp/cp029-gopath`

Exact prerequisite command:
```powershell
$env:GOTOOLCHAIN='auto'
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'
$env:ANDROID_HOME='C:\Android\Sdk'
$env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'
& 'C:\Program Files\Git\bin\bash.exe' -lc 'set -x; export GOPATH=/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/.tmp/cp029-gopath; export GOTOOLCHAIN=auto; export ANDROID_HOME=/c/Android/Sdk; export ANDROID_NDK_HOME=/c/Android/Sdk/ndk/25.0.8775105; cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore; bash -x ./build.sh'
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
- `docs/android/evidence/cp029_libcore_build.log`

## Exact Probe Command
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:mergeOssDebugNativeLibs --stacktrace
```

Exact direct shell transcript:
- `docs/android/evidence/cp029_mergeOssDebugNativeLibs.clean.log`

Key exact output lines:
```text
> Task :app:mergeOssDebugNativeLibs

BUILD SUCCESSFUL in 2s
6 actionable tasks: 2 executed, 4 up-to-date
EXIT_CODE: 0
```

## First Exact Meaningful Outcome
The first exact meaningful outcome was success of `:app:mergeOssDebugNativeLibs`.

## Post-Probe Artifact Verification
Expected success artifact path:
```text
android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out => True
```

Observed example files under the expected success path:
```text
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\merged_native_libs\ossDebug\mergeOssDebugNativeLibs\out\lib\arm64-v8a\libgojni.so | len=25456104 | mtime=2026-04-22 12:59:38
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\merged_native_libs\ossDebug\mergeOssDebugNativeLibs\out\lib\armeabi-v7a\libgojni.so | len=23328736 | mtime=2026-04-22 12:59:38
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\merged_native_libs\ossDebug\mergeOssDebugNativeLibs\out\lib\x86\libgojni.so | len=23639204 | mtime=2026-04-22 12:59:39
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\merged_native_libs\ossDebug\mergeOssDebugNativeLibs\out\lib\x86_64\libgojni.so | len=26588904 | mtime=2026-04-22 12:59:39
```

Required out-of-scope paths remained absent:
```text
android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out => False
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
```

## Fallback Evidence Sources
Direct shell transcript was complete, so daemon-log fallback was not required to determine outcome.

Available daemon-log fallback scope remained:
- `C:\Users\grUm.IGOR\.gradle\daemon\8.10.2\*.out.log`

## Cleanup After Evidence Capture
Removed exactly per CP-029 expectations:
- `.tmp/cp029-gomobile-src`
- `.tmp/cp029-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Cleanup state check:
```text
android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out => True
android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out => False
android/fork/app/build/intermediates/apk/oss/debug => False
android/fork/app/build/outputs/apk/oss/debug => False
android/fork/app/libs/libcore.aar => False
```

## Outcome
CP-029 execution is complete and successful.

Confirmed:
- exact bounded probe command was executed once
- first exact meaningful outcome was success of `:app:mergeOssDebugNativeLibs`
- expected success path now exists: `android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out`
- out-of-scope strip/signing/packaging/install/assemble paths remained absent

Explicit separation preserved:
- continuation probing stopped at `mergeOssDebugNativeLibs` and did not broaden into strip/signing/packaging/install/assemble work

## Exact Next Surface
The next checkpoint should define only the smallest bounded continuation after successful `.\gradlew.bat :app:mergeOssDebugNativeLibs --stacktrace`, most likely:
- `.\gradlew.bat :app:stripOssDebugDebugSymbols --stacktrace`

