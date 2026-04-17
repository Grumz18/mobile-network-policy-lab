# Android Post-Dex Continuation

## Purpose
This document records the CP-023 execution that probed only the first exact downstream build surface after successful `.\gradlew.bat :app:dexBuilderOssDebug --stacktrace`.

The checkpoint stayed narrow:
- the cleared `libcore` metadata bridge was reused only as an existing prerequisite through the same disposable gomobile path already validated in CP-014 through CP-022
- the persisted `android/sing-box` baseline was only confirmed as a prerequisite and not changed
- no upstream source under `android/fork/` was modified
- no broad patches were applied outside the disposable `gomobile-matsuri` clone
- no Gradle task broader than `.\gradlew.bat :app:mergeProjectDexOssDebug --stacktrace` was executed intentionally

## Checkpoint
CP-023

## Date
2026-04-16

## Scope Boundary
Performed:
- printed the pre-probe Java environment state
- confirmed `android/sing-box` remained on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified all CP-023 prerequisite state checks before entering the probe
- recreated a disposable `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the already-approved CP-014 fallback `go.mod` metadata behavior inside that disposable tool clone
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri`
- reran `android/fork/libcore/build.sh` only until it installed transient `android/fork/app/libs/libcore.aar`
- re-verified the exact prerequisite state before Gradle entry
- entered the exact downstream merge-project-dex surface with `.\gradlew.bat :app:mergeProjectDexOssDebug --stacktrace`
- stopped after the first exact downstream outcome was identified
- captured the direct shell transcript for the Gradle command
- verified the actual output path created by the task
- verified that the authored expected success path did not exist
- verified that APK outputs still remained absent
- removed the disposable CP-023 tool workspaces, `android/fork/libcore/.build`, and transient copied `android/fork/app/libs/libcore.aar` after evidence capture

Not performed:
- no new metadata-bridge diagnosis or repair
- no new sing-box alignment or persistence work
- no edits under `android/fork/`
- no `mergeExtDex*`, `mergeLibDex*`, packaging, install, or assemble work
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
merged_project_dex_exists=False
final_dex_exists=False
apk_outputs_exist=False
libcore_aar_exists=False
```

Supporting artifact evidence observed at the same point:

```text
FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\compile_app_classes_jar\ossDebug\bundleOssDebugClassesToCompileJar\classes.jar
Length        : 6063123

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\runtime_app_classes_jar\ossDebug\bundleOssDebugClassesToRuntimeJar\classes.jar
Length        : 6063123

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\project_dex_archive\ossDebug

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\project_dex_archive\ossDebug\dexBuilderOssDebug\out
```

Meaning:
- the compile-jar success artifact from CP-020 still existed
- the runtime-jar success artifact from CP-021 still existed
- the dex-builder success artifacts from CP-022 still existed
- merged project dex, final dex, and APK outputs were still absent before entry
- transient `android/fork/app/libs/libcore.aar` had been cleaned up after CP-022 and needed to be reproduced

## Disposable Tool Baseline Used
Temporary paths used during CP-023:
- source workspace: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gomobile-src`
- isolated GOPATH and patched binaries: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gopath`

Exact disposable rebuild commands:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gopath'
$env:GOTOOLCHAIN='auto'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gomobile-src'
& 'C:\Program Files\Go\bin\go.exe' version
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" ./cmd/gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" ./cmd/gobind
& 'C:\Program Files\Go\bin\go.exe' version -m "$env:GOPATH\bin\gomobile-matsuri.exe"
Copy-Item 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gopath\bin\gomobile-matsuri.exe' 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gopath\bin\gomobile-matsuri' -Force
Copy-Item 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gopath\bin\gobind-matsuri.exe' 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gopath\bin\gobind-matsuri' -Force
```

Observed result:

```text
go version go1.24.0 windows/amd64
build	vcs.revision=17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
build	vcs.modified=true
```

## Exact Prerequisite Entry Artifact
The prerequisite artifact before merge-project-dex entry remained:
- `android/fork/app/libs/libcore.aar`

Exact successful command used to reach the entry artifact:

```powershell
$env:GOTOOLCHAIN='auto'
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'
$env:ANDROID_HOME='C:\Android\Sdk'
$env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'
& 'C:\Program Files\Git\bin\bash.exe' -lc 'set -x; export GOPATH=/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/.tmp/cp023-gopath; export GOTOOLCHAIN=auto; export ANDROID_HOME=/c/Android/Sdk; export ANDROID_NDK_HOME=/c/Android/Sdk/ndk/25.0.8775105; cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore; bash -x ./build.sh'
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
merged_project_dex_exists=False
final_dex_exists=False
apk_outputs_exist=False
libcore_aar_exists=True
```

## First Downstream Merge-Project-Dex Probe
Why this was the authored next exact surface:
- CP-022 had already produced dex-builder output
- the local task listing had already exposed:
  - `mergeProjectDexOssDebug`
  - `mergeExtDexOssDebug`
  - `mergeLibDexOssDebug`
- the authored checkpoint assumed the next absent downstream project-dex output family was:
  - `android/fork/app/build/intermediates/merged_project_dex/ossDebug`

Exact entry command:

```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:mergeProjectDexOssDebug --stacktrace
```

Direct shell command result:

```text
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
> Task :app:checkKotlinGradlePluginConfigurationErrors SKIPPED
> Task :app:compileOssDebugKotlin UP-TO-DATE
> Task :app:compileOssDebugJavaWithJavac UP-TO-DATE
> Task :app:dexBuilderOssDebug UP-TO-DATE
> Task :app:mergeProjectDexOssDebug

BUILD SUCCESSFUL in 3s
28 actionable tasks: 3 executed, 25 up-to-date
```

Daemon-log evidence:
- not required in this checkpoint because the direct shell transcript was complete enough to capture the exact task path and exact outcome

Observed downstream evidence after the command:

```text
merged_project_dex_exists=False
final_dex_exists=True
apk_outputs_exist=False
merge_ext_dex_exists=False
merge_lib_dex_exists=False
```

Actual created output path:

```text
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\dex\ossDebug\mergeProjectDexOssDebug\0\classes.dex
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\dex\ossDebug\mergeProjectDexOssDebug\1\classes.dex
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\dex\ossDebug\mergeProjectDexOssDebug\8\classes.dex
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\dex\ossDebug\mergeProjectDexOssDebug\15\classes.dex
```

Interpretation:
- the Gradle task itself is not the next blocker
- the first meaningful downstream outcome was success at `:app:mergeProjectDexOssDebug`
- the authored expected success artifact path did not appear:
  - `android/fork/app/build/intermediates/merged_project_dex/ossDebug`
- the task instead materialized final dex output directly under:
  - `android/fork/app/build/intermediates/dex/ossDebug/mergeProjectDexOssDebug`
- the authored negative assertion that `android/fork/app/build/intermediates/dex/ossDebug` must remain absent was invalidated by the task itself
- APK outputs still remained absent, so the checkpoint did not drift into packaging

## Cleanup After Evidence Capture
Removed after documentation:
- `.tmp/cp023-gomobile-src`
- `.tmp/cp023-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Observed cleanup result:

```text
exists_after_cleanup=False  C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gomobile-src
exists_after_cleanup=False  C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp023-gopath
exists_after_cleanup=False  C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build
exists_after_cleanup=False  C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\libs\libcore.aar
compile_jar_still_exists=True
runtime_jar_still_exists=True
project_dex_archive_still_exists=True
final_dex_still_exists=True
apk_outputs_exist_after_cleanup=False
```

## Outcome
CP-023 did not complete its authored completion test, but it did produce the first exact downstream result for the requested probe.

It proved:
- the prerequisite artifact before this surface still remains `android/fork/app/libs/libcore.aar`
- the exact downstream consumer command is `.\gradlew.bat :app:mergeProjectDexOssDebug --stacktrace`
- that bounded merge-project-dex surface succeeds under the persisted sing-box baseline
- the task writes directly into `android/fork/app/build/intermediates/dex/ossDebug/mergeProjectDexOssDebug`
- APK outputs still remain absent at this stopping point

It did not prove the authored boundary assumptions:
- `android/fork/app/build/intermediates/merged_project_dex/ossDebug` was not created
- `android/fork/app/build/intermediates/dex/ossDebug` did not remain absent

Therefore CP-023 is `partial`, not `complete`.
The boundary-definition miss is in the checkpoint expectations, not in the Gradle task outcome.

## Exact Next Surface
The next checkpoint should redefine the smallest bounded continuation from the actual observed result instead of the authored `merged_project_dex` assumption.

The next likely exact bounded surface is:
- `.\gradlew.bat :app:mergeExtDexOssDebug --stacktrace`

Why:
- `android/fork/app/build/intermediates/external_libs_dex_archive/ossDebug/dexBuilderOssDebug/out` already exists
- `android/fork/app/build/intermediates/sub_project_dex_archive/ossDebug/dexBuilderOssDebug/out` already exists
- `android/fork/app/build/intermediates/dex/ossDebug/mergeExtDexOssDebug` still remains absent
- `android/fork/app/build/intermediates/dex/ossDebug/mergeLibDexOssDebug` still remains absent
- packaging and `assemble*` remain broader than the still-unexecuted merge-dex surfaces
