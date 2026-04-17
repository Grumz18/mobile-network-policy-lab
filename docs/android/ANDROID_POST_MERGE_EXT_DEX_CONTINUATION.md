# Android Post-Merge-Ext-Dex Continuation

## Purpose
This document records the CP-025 execution that probed only the first exact downstream build surface after the observed successful `.\gradlew.bat :app:mergeExtDexOssDebug --stacktrace` result.

The checkpoint stayed narrow:
- the cleared `libcore` metadata bridge was reused only as an existing prerequisite through the same disposable gomobile path already validated in CP-014 through CP-024
- the persisted `android/sing-box` baseline was only confirmed as a prerequisite and not changed
- no upstream source under `android/fork/` was modified
- no broad patches were applied outside the disposable `gomobile-matsuri` clone
- no Gradle task broader than `.\gradlew.bat :app:mergeLibDexOssDebug --stacktrace` was executed intentionally

## Checkpoint
CP-025

## Date
2026-04-17

## Scope Boundary
Performed:
- printed the pre-probe Java environment state
- confirmed `android/sing-box` remained on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified all CP-025 prerequisite state checks before entering the probe
- recreated a disposable `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the already-approved CP-014 fallback `go.mod` metadata behavior inside that disposable tool clone
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri`
- reran `android/fork/libcore/build.sh` only until it installed transient `android/fork/app/libs/libcore.aar`
- re-verified the exact prerequisite state before Gradle entry
- entered the exact downstream merge-lib-dex surface with `.\gradlew.bat :app:mergeLibDexOssDebug --stacktrace`
- stopped after the first exact downstream outcome was identified
- captured the complete direct shell transcript for the Gradle command
- verified the exact expected merge-lib-dex success artifact path
- verified that the exact out-of-scope APK path still remained absent
- removed the disposable CP-025 tool workspaces, `android/fork/libcore/.build`, and transient copied `android/fork/app/libs/libcore.aar` after evidence capture

Not performed:
- no new metadata-bridge diagnosis or repair
- no new sing-box alignment or persistence work
- no edits under `android/fork/`
- no packaging, install, or assemble work
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
Observed before any tool or build action:

```text
git -C android/sing-box status --short --branch
## cp017-local-baseline

git -C android/sing-box branch --show-current
cp017-local-baseline

git -C android/sing-box rev-parse HEAD
aed32ee3066cdbc7d471e3e0415c5134088962df
```

## Exact Prerequisite State Checks
Observed before regenerating the transient prerequisite:

```text
compile_jar_exists=True
runtime_jar_exists=True
project_dex_archive_exists=True
project_dex_out_exists=True
external_libs_dex_out_exists=True
sub_project_dex_out_exists=True
merge_project_dex_exists=True
merge_ext_dex_exists=True
merge_lib_dex_exists=False
apk_outputs_exist=False
libcore_aar_exists=False
```

Supporting artifact evidence observed at the same point:

```text
FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\compile_app_classes_jar\ossDebug\bundleOssDebugClassesToCompileJar\classes.jar
Length        : 6063123
LastWriteTime : 16.04.2026 11:03:17

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\runtime_app_classes_jar\ossDebug\bundleOssDebugClassesToRuntimeJar\classes.jar
Length        : 6063123
LastWriteTime : 16.04.2026 11:24:14

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\project_dex_archive\ossDebug
LastWriteTime : 16.04.2026 11:42:04

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\project_dex_archive\ossDebug\dexBuilderOssDebug\out
LastWriteTime : 16.04.2026 11:42:07

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\external_libs_dex_archive\ossDebug\dexBuilderOssDebug\out
LastWriteTime : 16.04.2026 11:42:04

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\sub_project_dex_archive\ossDebug\dexBuilderOssDebug\out
LastWriteTime : 16.04.2026 11:42:04

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\dex\ossDebug\mergeProjectDexOssDebug
LastWriteTime : 16.04.2026 11:57:22

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\dex\ossDebug\mergeExtDexOssDebug
LastWriteTime : 17.04.2026 12:23:19
```

Meaning:
- the compile-jar success artifact from CP-020 still existed
- the runtime-jar success artifact from CP-021 still existed
- the project dex archive success artifacts from CP-022 still existed
- the corrected post-`mergeProjectDexOssDebug` boundary from CP-023 still existed
- the merge-ext-dex success artifacts from CP-024 still existed
- merge-lib-dex and APK outputs were still absent before entry
- transient `android/fork/app/libs/libcore.aar` had been cleaned up after CP-024 and needed to be reproduced

## Disposable Tool Baseline Used
Temporary paths used during CP-025:
- source workspace: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp025-gomobile-src`
- isolated GOPATH and patched binaries: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp025-gopath`

Exact disposable rebuild commands:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp025-gopath'
$env:GOTOOLCHAIN='auto'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp025-gomobile-src'
& 'C:\Program Files\Go\bin\go.exe' version
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" ./cmd/gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" ./cmd/gobind
& 'C:\Program Files\Go\bin\go.exe' version -m "$env:GOPATH\bin\gomobile-matsuri.exe"
Copy-Item "$env:GOPATH\bin\gomobile-matsuri.exe" "$env:GOPATH\bin\gomobile-matsuri" -Force
Copy-Item "$env:GOPATH\bin\gobind-matsuri.exe" "$env:GOPATH\bin\gobind-matsuri" -Force
```

Observed result:

```text
go version go1.24.0 windows/amd64
build	vcs.revision=17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
build	vcs.modified=true
```

## Exact Prerequisite Entry Artifact
The prerequisite artifact before merge-lib-dex entry remained:
- `android/fork/app/libs/libcore.aar`

Exact successful command used to reach the entry artifact:

```powershell
$env:GOTOOLCHAIN='auto'
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'
$env:ANDROID_HOME='C:\Android\Sdk'
$env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'
& 'C:\Program Files\Git\bin\bash.exe' -lc 'set -x; export GOPATH=/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/.tmp/cp025-gopath; export GOTOOLCHAIN=auto; export ANDROID_HOME=/c/Android/Sdk; export ANDROID_NDK_HOME=/c/Android/Sdk/ndk/25.0.8775105; cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore; bash -x ./build.sh'
```

Observed result summary:
- exact success signal at entry: `>> install /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/app/libs/libcore.aar`
- the known non-blocking line persisted: `./build.sh: line 3: ./env_java.sh: No such file or directory`
- generated fallback `go.mod` files were written again for the Android architectures
- the build completed through final AAR packaging without surfacing a new blocker

Observed artifact state before Gradle entry:

```text
compile_jar_exists=True
runtime_jar_exists=True
project_dex_archive_exists=True
project_dex_out_exists=True
external_libs_dex_out_exists=True
sub_project_dex_out_exists=True
merge_project_dex_exists=True
merge_ext_dex_exists=True
merge_lib_dex_exists=False
apk_outputs_exist=False
libcore_aar_exists=True
```

## First Downstream Merge-Lib-Dex Probe
Why this is the correct next exact surface:
- CP-024 already execution-validated `mergeExtDexOssDebug`
- the corrected upstream success paths now include:
  - `android/fork/app/build/intermediates/dex/ossDebug/mergeProjectDexOssDebug`
  - `android/fork/app/build/intermediates/dex/ossDebug/mergeExtDexOssDebug`
- the sub-project dex archive input already existed at:
  - `android/fork/app/build/intermediates/sub_project_dex_archive/ossDebug/dexBuilderOssDebug/out`
- the first still-absent downstream library merge-dex output family was:
  - `android/fork/app/build/intermediates/dex/ossDebug/mergeLibDexOssDebug`
- packaging remains broader than the first post-`mergeExtDexOssDebug` continuation point

Exact entry command:

```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:mergeLibDexOssDebug --stacktrace
```

Direct shell command result:

```text
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>if "Windows_NT" == "Windows_NT" setlocal
> Task :buildSrc:checkKotlinGradlePluginConfigurationErrors
> Task :buildSrc:compileKotlin UP-TO-DATE
> Task :buildSrc:compileJava NO-SOURCE
> Task :buildSrc:compileGroovy NO-SOURCE
> Task :buildSrc:pluginDescriptors UP-TO-DATE
> Task :buildSrc:processResources NO-SOURCE
> Task :buildSrc:classes UP-TO-DATE
> Task :buildSrc:jar UP-TO-DATE
> Task :app:preBuild UP-TO-DATE
> Task :app:preOssDebugBuild UP-TO-DATE
> Task :app:checkOssDebugDuplicateClasses UP-TO-DATE
> Task :app:mergeLibDexOssDebug

BUILD SUCCESSFUL in 2s
6 actionable tasks: 2 executed, 4 up-to-date
```

Daemon-log evidence:
- not required to determine the result during CP-025 execution because the direct shell transcript already captured the exact task path and exact outcome
- later consistency cross-check from `C:\Users\grUm.IGOR\.gradle\daemon\8.10.2\daemon-14340.out.log` matched the same outcome:

```text
2026-04-17T12:36:05.922+0300 [DEBUG] [org.gradle.launcher.daemon.server.exec.ExecuteBuild] The daemon has started executing the build.
2026-04-17T12:36:05.922+0300 [DEBUG] [org.gradle.launcher.daemon.server.exec.ExecuteBuild] Executing build with daemon context: DefaultDaemonContext[uid=5bd82eea-4f72-4ea9-8476-804dc8f70d7c,javaHome=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot,javaVersion=17,javaVendor=Eclipse Adoptium,daemonRegistryDir=C:\Users\grUm.IGOR\.gradle\daemon,pid=14340,idleTimeout=10800000,priority=NORMAL,applyInstrumentationAgent=true,nativeServicesMode=ENABLED,daemonOpts=-XX:+UseParallelGC,--add-opens=java.base/java.util=ALL-UNNAMED,--add-opens=java.base/java.lang=ALL-UNNAMED,--add-opens=java.base/java.lang.invoke=ALL-UNNAMED,--add-opens=java.prefs/java.util.prefs=ALL-UNNAMED,--add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED,--add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED,--add-opens=java.base/java.nio.charset=ALL-UNNAMED,--add-opens=java.base/java.net=ALL-UNNAMED,--add-opens=java.base/java.util.concurrent.atomic=ALL-UNNAMED,-Xmx4g,-Dfile.encoding=UTF-8,-Duser.country=RU,-Duser.language=ru,-Duser.variant]
BUILD SUCCESSFUL in 2s
6 actionable tasks: 2 executed, 4 up-to-date
```

Observed downstream evidence after the command:

```text
merge_project_dex_exists=True
merge_ext_dex_exists=True
merge_lib_dex_exists=True
apk_outputs_exist=False
```

Exact expected success artifact path now present:

```text
FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\dex\ossDebug\mergeLibDexOssDebug\0
LastWriteTime : 17.04.2026 12:36:07

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\dex\ossDebug\mergeLibDexOssDebug\15
LastWriteTime : 17.04.2026 12:36:07
```

Interpretation:
- the bounded merge-lib-dex consumer surface is not the next blocker
- the first meaningful downstream continuation signal was success for the exact bounded `mergeLibDexOssDebug` surface
- the exact expected success artifact path was created
- the exact out-of-scope APK path still remained absent

## Cleanup After Evidence Capture
Removed after documentation:
- `.tmp/cp025-gomobile-src`
- `.tmp/cp025-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Observed cleanup result:

```text
cp025_gomobile_src_exists_after_cleanup=False
cp025_gopath_exists_after_cleanup=False
libcore_build_exists_after_cleanup=False
libcore_aar_exists_after_cleanup=False
compile_jar_still_exists=True
runtime_jar_still_exists=True
project_dex_archive_still_exists=True
merge_project_dex_still_exists=True
merge_ext_dex_still_exists=True
merge_lib_dex_still_exists=True
apk_outputs_exist_after_cleanup=False
```

## Outcome
CP-025 completed the requested bounded continuation probe.

It proved:
- the exact downstream consumer command is `.\gradlew.bat :app:mergeLibDexOssDebug --stacktrace`
- that bounded merge-lib-dex surface succeeds under the persisted sing-box baseline
- the exact expected success artifact path is:
  - `android/fork/app/build/intermediates/dex/ossDebug/mergeLibDexOssDebug`
- the exact out-of-scope APK path still remains absent at this stopping point:
  - `android/fork/app/build/outputs/apk/`

It did not perform:
- packaging work
- install or assemble work
- broader Gradle repair
- Android feature work

## Exact Next Surface
The next exact smallest downstream surface is no longer merge-lib-dex.

The next checkpoint should define only the first bounded continuation after successful `:app:mergeLibDexOssDebug`, most likely the first dex-merge or packaging-adjacent surface immediately downstream of the three merge-dex tasks, without continuing into install or `assemble*`.
