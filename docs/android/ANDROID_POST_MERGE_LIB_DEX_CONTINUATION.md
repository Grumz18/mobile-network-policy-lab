# Android Post-Merge-Lib-Dex Continuation

## Purpose
This document records the CP-026 execution that probed only the first exact downstream build surface after the observed successful `.\gradlew.bat :app:mergeLibDexOssDebug --stacktrace` result.

The checkpoint stayed narrow:
- the cleared `libcore` metadata bridge was reused only as an existing prerequisite through the same disposable gomobile path validated in prior checkpoints
- the persisted `android/sing-box` baseline was only confirmed as a prerequisite and not changed
- no upstream source under `android/fork/` was modified
- no broad patches were applied outside the disposable `gomobile-matsuri` clone
- no Gradle task broader than `.\gradlew.bat :app:processOssDebugJavaRes --stacktrace` was intentionally executed

## Checkpoint
CP-026

## Date
2026-04-22

## Scope Boundary
Performed:
- printed `JAVA_HOME` and `java -version`
- confirmed `android/sing-box` stayed on `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified all CP-026 prerequisite checks before probe entry
- recreated a disposable `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the known metadata-preserving fallback behavior in the disposable clone
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri`
- reran `android/fork/libcore/build.sh` only until transient `android/fork/app/libs/libcore.aar` was installed
- re-verified prerequisite checks before Gradle entry
- entered the exact downstream surface with `.\gradlew.bat :app:processOssDebugJavaRes --stacktrace`
- stopped after the first exact meaningful outcome
- captured fallback evidence from daemon log and filesystem because direct shell output was incomplete
- verified expected success artifact path and required out-of-scope absent paths
- removed disposable CP-026 tool workspaces, `android/fork/libcore/.build`, and transient `android/fork/app/libs/libcore.aar`

Not performed:
- no new metadata-bridge diagnosis or repair
- no new sing-box alignment or persistence work
- no edits under `android/fork/`
- no Java-resource merge, native-lib merge, signing, packaging, install, or assemble work
- no Android product, routing, transport, or server work

## Pre-Probe Environment
Observed before running the probe:

```text
JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot\
openjdk version "17.0.18" 2026-01-20
OpenJDK Runtime Environment Temurin-17.0.18+8 (build 17.0.18+8)
OpenJDK 64-Bit Server VM Temurin-17.0.18+8 (build 17.0.18+8, mixed mode, sharing)
```

## Persisted Sing-Box Prerequisite Confirmation

```text
git -C android/sing-box status --short --branch
## cp017-local-baseline

git -C android/sing-box branch --show-current
cp017-local-baseline

git -C android/sing-box rev-parse HEAD
aed32ee3066cdbc7d471e3e0415c5134088962df
```

## Exact Prerequisite State Checks
Before reproducing transient `libcore.aar`:

```text
compile_jar_exists=True
runtime_jar_exists=True
project_dex_archive_exists=True
project_dex_out_exists=True
external_libs_dex_out_exists=True
sub_project_dex_out_exists=True
merge_project_dex_exists=True
merge_ext_dex_exists=True
merge_lib_dex_exists=True
process_java_res_out_exists=False
merged_java_res_exists=False
merged_jni_libs_exists=False
merged_native_libs_out_exists=False
stripped_native_libs_out_exists=False
intermediates_apk_exists=False
outputs_apk_exists=False
libcore_aar_exists=False
```

After reproducing transient `libcore.aar` and before Gradle entry:

```text
compile_jar_exists=True
runtime_jar_exists=True
project_dex_archive_exists=True
project_dex_out_exists=True
external_libs_dex_out_exists=True
sub_project_dex_out_exists=True
merge_project_dex_exists=True
merge_ext_dex_exists=True
merge_lib_dex_exists=True
process_java_res_out_exists=False
merged_java_res_exists=False
merged_jni_libs_exists=False
merged_native_libs_out_exists=False
stripped_native_libs_out_exists=False
intermediates_apk_exists=False
outputs_apk_exists=False
libcore_aar_exists=True
```

## Disposable Tool Baseline Used
Temporary paths:
- source workspace: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp026-gomobile-src`
- isolated GOPATH and patched binaries: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp026-gopath`

Exact disposable rebuild commands:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp026-gopath'
$env:GOTOOLCHAIN='auto'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp026-gomobile-src'
& 'C:\Program Files\Go\bin\go.exe' version
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" ./cmd/gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" ./cmd/gobind
& 'C:\Program Files\Go\bin\go.exe' version -m "$env:GOPATH\bin\gomobile-matsuri.exe"
Copy-Item "$env:GOPATH\bin\gomobile-matsuri.exe" "$env:GOPATH\bin\gomobile-matsuri" -Force
Copy-Item "$env:GOPATH\bin\gobind-matsuri.exe" "$env:GOPATH\bin\gobind-matsuri" -Force
```

Observed baseline:

```text
go version go1.24.0 windows/amd64
build	vcs.revision=17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
build	vcs.modified=true
```

## Exact Prerequisite Entry Artifact
Exact command used to regenerate the transient prerequisite:

```powershell
$env:GOTOOLCHAIN='auto'
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'
$env:ANDROID_HOME='C:\Android\Sdk'
$env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'
& 'C:\Program Files\Git\bin\bash.exe' -lc 'set -x; export GOPATH=/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/.tmp/cp026-gopath; export GOTOOLCHAIN=auto; export ANDROID_HOME=/c/Android/Sdk; export ANDROID_NDK_HOME=/c/Android/Sdk/ndk/25.0.8775105; cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore; bash -x ./build.sh'
```

Observed entry signal:

```text
>> install /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/app/libs/libcore.aar
```

Known non-blocking line remained present:

```text
./build.sh: line 3: ./env_java.sh: No such file or directory
```

## First Downstream `processOssDebugJavaRes` Probe
Exact entry command:

```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:processOssDebugJavaRes --stacktrace
```

Direct shell command result:

```text
(exit code 0; direct shell transcript returned empty output)
```

Fallback evidence source used because direct output was incomplete:
- `C:\Users\grUm.IGOR\.gradle\daemon\8.10.2\daemon-13220.out.log`

Relevant daemon-log lines:

```text
2026-04-22T12:05:53.231+0300 ... Received command: Build{id=..., currentDir=C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork}
2026-04-22T12:05:53.243+0300 ... Executing build with daemon context: ... javaHome=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot ...
BUILD SUCCESSFUL in 13s
24 actionable tasks: 2 executed, 22 up-to-date
```

Filesystem evidence after the command:

```text
process_java_res_out_exists=True
merged_java_res_exists=False
merged_jni_libs_exists=False
merged_native_libs_out_exists=False
stripped_native_libs_out_exists=False
intermediates_apk_exists=False
outputs_apk_exists=False
```

Expected success artifact path observed:

```text
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\java_res\ossDebug\processOssDebugJavaRes\out\META-INF\app_ossDebug.kotlin_module | len=1058 | mtime=2026-04-22 12:06:04
```

Interpretation:
- first exact meaningful outcome was success of the bounded `processOssDebugJavaRes` continuation probe
- expected success artifact path now exists
- out-of-scope downstream paths remained absent at stop point

## Cleanup After Evidence Capture
Removed:
- `.tmp/cp026-gomobile-src`
- `.tmp/cp026-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Observed cleanup result:

```text
cp026_gomobile_src_exists_after_cleanup=False
cp026_gopath_exists_after_cleanup=False
libcore_build_exists_after_cleanup=False
libcore_aar_exists_after_cleanup=False
process_java_res_out_still_exists=True
merge_lib_dex_still_exists=True
merged_java_res_exists_after_cleanup=False
outputs_apk_exists_after_cleanup=False
```

## Outcome
CP-026 completed the requested bounded continuation probe.

It proved:
- exact probe command: `.\gradlew.bat :app:processOssDebugJavaRes --stacktrace`
- first meaningful outcome: success of the bounded `processOssDebugJavaRes` surface
- exact expected success artifact family now exists under:
  - `android/fork/app/build/intermediates/java_res/ossDebug/processOssDebugJavaRes/out`
- exact out-of-scope downstream paths remained absent:
  - `android/fork/app/build/intermediates/merged_java_res/ossDebug/mergeOssDebugJavaResource`
  - `android/fork/app/build/intermediates/merged_jni_libs/ossDebug/mergeOssDebugJniLibFolders`
  - `android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out`
  - `android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out`
  - `android/fork/app/build/intermediates/apk/oss/debug`
  - `android/fork/app/build/outputs/apk/oss/debug`

It did not perform:
- Java-resource merge work
- native-lib merge work
- signing, packaging, install, or assemble work
- Android feature work

## Exact Next Surface
The next exact smallest downstream surface is no longer `processOssDebugJavaRes`.

The next checkpoint should define only the first bounded continuation after successful `:app:processOssDebugJavaRes`, most likely `.\gradlew.bat :app:mergeOssDebugJavaResource --stacktrace`, without continuing into JNI/native merge, signing, packaging, install, or `assemble*`.

