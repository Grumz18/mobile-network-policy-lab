# Android Post-Runtime-Jar Continuation

## Purpose
This document records the CP-022 execution that probed only the first exact downstream build surface after successful `.\gradlew.bat :app:bundleOssDebugClassesToRuntimeJar --stacktrace`.

The checkpoint stayed narrow:
- the cleared `libcore` metadata bridge was reused only as an existing prerequisite through the same disposable gomobile path already validated in CP-014 through CP-021
- the persisted `android/sing-box` baseline was only confirmed as a prerequisite and not changed
- no upstream source under `android/fork/` was modified
- no broad patches were applied outside the disposable `gomobile-matsuri` clone
- no Gradle task broader than `.\gradlew.bat :app:dexBuilderOssDebug --stacktrace` was executed intentionally

## Checkpoint
CP-022

## Date
2026-04-16

## Scope Boundary
Performed:
- printed the pre-probe Java environment state
- confirmed `android/sing-box` remained on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- verified all CP-022 prerequisite state checks before entering the probe
- recreated a disposable `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the already-approved CP-014 fallback `go.mod` metadata behavior inside that disposable tool clone
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri`
- reran `android/fork/libcore/build.sh` only until it installed transient `android/fork/app/libs/libcore.aar`
- re-verified the exact prerequisite state before Gradle entry
- entered the exact downstream dex-builder consumer surface with `.\gradlew.bat :app:dexBuilderOssDebug --stacktrace`
- stopped after the first exact downstream outcome was identified
- captured the exact direct shell transcript for the Gradle command
- verified the exact expected dex success artifact path
- verified that the exact out-of-scope APK path still remained absent
- removed the disposable CP-022 tool workspaces, `android/fork/libcore/.build`, and transient copied `android/fork/app/libs/libcore.aar` after evidence capture

Not performed:
- no new metadata-bridge diagnosis or repair
- no new sing-box alignment or persistence work
- no edits under `android/fork/`
- no merge-dex, packaging, install, assemble, or APK generation work
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
dex_exists=False
apk_outputs_exist=False
libcore_aar_exists=False

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\compile_app_classes_jar\ossDebug\bundleOssDebugClassesToCompileJar\classes.jar
Length        : 6063123
LastWriteTime : 16.04.2026 11:03:17

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\runtime_app_classes_jar\ossDebug\bundleOssDebugClassesToRuntimeJar\classes.jar
Length        : 6063123
LastWriteTime : 16.04.2026 11:24:14
```

Meaning:
- the compile-jar success artifact from CP-020 still existed
- the runtime-jar success artifact from CP-021 still existed
- dex output and APK output were still absent because they remained out of scope
- transient `android/fork/app/libs/libcore.aar` had been cleaned up after CP-021 and needed to be reproduced

## Disposable Tool Baseline Used
Temporary paths used during CP-022:
- source workspace: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp022-gomobile-src`
- isolated GOPATH and patched binaries: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp022-gopath`

Exact disposable rebuild commands:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp022-gopath'
$env:GOTOOLCHAIN='auto'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp022-gomobile-src'
& 'C:\Program Files\Go\bin\go.exe' version
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" ./cmd/gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" ./cmd/gobind
& 'C:\Program Files\Go\bin\go.exe' version -m "$env:GOPATH\bin\gomobile-matsuri.exe"
& "$env:GOPATH\bin\gomobile-matsuri.exe" init
Copy-Item '.tmp/cp022-gopath/bin/gomobile-matsuri.exe' '.tmp/cp022-gopath/bin/gomobile-matsuri' -Force
Copy-Item '.tmp/cp022-gopath/bin/gobind-matsuri.exe' '.tmp/cp022-gopath/bin/gobind-matsuri' -Force
```

Observed result:

```text
go version go1.24.0 windows/amd64
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp022-gopath\bin\gomobile-matsuri.exe: go1.24.0
build	vcs.revision=17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
build	vcs.modified=true
go: downloading go1.24.0 (windows/amd64)
go: downloading golang.org/x/mod v0.27.0
go: downloading golang.org/x/sync v0.16.0
go: downloading golang.org/x/tools v0.36.0
```

## Exact Prerequisite Entry Artifact
The prerequisite artifact before dex-builder entry remained:
- `android/fork/app/libs/libcore.aar`

The first direct prerequisite rerun used a Windows-style `GOPATH` inside Git Bash and failed before AAR production:

```text
./build.sh: line 3: ./env_java.sh: No such file or directory
./build.sh: line 18: C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp022-gopath/bin/gomobile-matsuri: No such file or directory
```

That was corrected inside the same disposable tool surface by:
- adding extensionless copies of the isolated binaries in `.tmp/cp022-gopath/bin/`
- rerunning `build.sh` with a Bash-safe `GOPATH=/c/Users/.../.tmp/cp022-gopath`

Exact successful command used to reach the entry artifact:

```powershell
$env:GOTOOLCHAIN='auto'
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'
$env:ANDROID_HOME='C:\Android\Sdk'
$env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'
& 'C:\Program Files\Git\bin\bash.exe' -lc 'set -x; export GOPATH=/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/.tmp/cp022-gopath; export GOTOOLCHAIN=auto; export ANDROID_HOME=/c/Android/Sdk; export ANDROID_NDK_HOME=/c/Android/Sdk/ndk/25.0.8775105; cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore; bash -x ./build.sh'
```

Observed result summary:
- exact success signal at entry: `>> install /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/app/libs/libcore.aar`
- the known non-blocking line persisted: `./build.sh: line 3: ./env_java.sh: No such file or directory`
- generated fallback `go.mod` files were written for all Android architectures
- the build completed through final AAR packaging without surfacing a new blocker

Observed artifact state before Gradle entry:

```text
compile_jar_exists=True
runtime_jar_exists=True
dex_exists=False
apk_outputs_exist=False
libcore_aar_exists=True

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\compile_app_classes_jar\ossDebug\bundleOssDebugClassesToCompileJar\classes.jar
Length        : 6063123
LastWriteTime : 16.04.2026 11:03:17

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\runtime_app_classes_jar\ossDebug\bundleOssDebugClassesToRuntimeJar\classes.jar
Length        : 6063123
LastWriteTime : 16.04.2026 11:24:14

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\libs\libcore.aar
Length        : 37518758
LastWriteTime : 16.04.2026 11:41:46
```

## First Downstream Dex-Builder Probe
Why this is the correct next exact surface:
- CP-021 had already produced runtime-jar output
- the first still-absent downstream output family after CP-021 was:
  - `android/fork/app/build/intermediates/project_dex_archive/ossDebug`
- the local task listing had already exposed:
  - `dexBuilderOssDebug`
  - `mergeExtDexOssDebug`
  - `mergeLibDexOssDebug`
  - `mergeProjectDexOssDebug`
- `dexBuilderOssDebug` is the narrowest first dex-side surface aligned with the still-absent `project_dex_archive` output family

Exact entry command:

```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:dexBuilderOssDebug --stacktrace
```

Direct shell command result:

```text
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>if "Windows_NT" == "Windows_NT" setlocal

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>set DIRNAME=C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\ 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>if "C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\" == "" set DIRNAME=. 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>set APP_BASE_NAME=gradlew 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>set APP_HOME=C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\ 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>for %i in ("C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\") do set APP_HOME=%~fi 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>set APP_HOME=C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\ 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>set DEFAULT_JVM_OPTS="-Xmx64m" "-Xms64m" 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>if defined JAVA_HOME goto findJavaFromJavaHome 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>set JAVA_EXE=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot/bin/java.exe 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>if exist "C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot/bin/java.exe" goto execute 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>set CLASSPATH=C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\\gradle\wrapper\gradle-wrapper.jar 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>"C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot/bin/java.exe" "-Xmx64m" "-Xms64m"   "-Dorg.gradle.appname=gradlew" -classpath "C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\\gradle\wrapper\gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain :app:dexBuilderOssDebug --stacktrace 
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
> Task :app:compileOssDebugAidl UP-TO-DATE
> Task :app:checkKotlinGradlePluginConfigurationErrors SKIPPED
> Task :app:dataBindingMergeDependencyArtifactsOssDebug UP-TO-DATE
> Task :app:generateOssDebugResValues UP-TO-DATE
> Task :app:extractOssDebugSupportedLocales UP-TO-DATE
> Task :app:generateOssDebugLocaleConfig UP-TO-DATE
> Task :app:generateOssDebugResources UP-TO-DATE
> Task :app:mergeOssDebugResources UP-TO-DATE
> Task :app:dataBindingGenBaseClassesOssDebug UP-TO-DATE
> Task :app:generateOssDebugBuildConfig UP-TO-DATE
> Task :app:checkOssDebugAarMetadata UP-TO-DATE
> Task :app:mapOssDebugSourceSetPaths UP-TO-DATE
> Task :app:createOssDebugCompatibleScreenManifests UP-TO-DATE
> Task :app:extractDeepLinksOssDebug UP-TO-DATE
> Task :app:processOssDebugMainManifest UP-TO-DATE
> Task :app:processOssDebugManifest UP-TO-DATE
> Task :app:processOssDebugManifestForPackage UP-TO-DATE
> Task :app:processOssDebugResources UP-TO-DATE
> Task :app:kspOssDebugKotlin UP-TO-DATE
> Task :app:compileOssDebugKotlin UP-TO-DATE
> Task :app:javaPreCompileOssDebug UP-TO-DATE
> Task :app:compileOssDebugJavaWithJavac UP-TO-DATE
> Task :app:dexBuilderOssDebug

BUILD SUCCESSFUL in 8s
26 actionable tasks: 2 executed, 24 up-to-date

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>if "0" == "0" goto mainEnd 

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>if "Windows_NT" == "Windows_NT" endlocal
```

Daemon-log evidence:
- not required in this checkpoint because the direct shell transcript was complete enough to capture the exact task path and exact outcome

Observed downstream evidence after the command:

```text
dex_exists=True
apk_outputs_exist=False

FullName      : C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\project_dex_archive\ossDebug
LastWriteTime : 16.04.2026 11:42:04

C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\project_dex_archive\ossDebug\dexBuilderOssDebug
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\project_dex_archive\ossDebug\dexBuilderOssDebug\out
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\project_dex_archive\ossDebug\dexBuilderOssDebug\out\48ac9e11bd9dcefd319268c76e9ec57f18d10a787d9c98e51f3a93050d7843f4_0.jar
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\build\intermediates\project_dex_archive\ossDebug\dexBuilderOssDebug\out\48ac9e11bd9dcefd319268c76e9ec57f18d10a787d9c98e51f3a93050d7843f4_1.jar
```

Interpretation:
- the dex-builder consumer surface is not the next blocker
- the first meaningful downstream outcome was success at `:app:dexBuilderOssDebug`
- the exact expected success artifact path was created
- the exact out-of-scope APK path still remained absent

## Cleanup After Evidence Capture
Removed after documentation:
- `.tmp/cp022-gomobile-src`
- `.tmp/cp022-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Observed cleanup result:

```text
exists_after_cleanup=False 	C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp022-gomobile-src
exists_after_cleanup=False 	C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp022-gopath
exists_after_cleanup=False 	C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build
exists_after_cleanup=False 	C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\libs\libcore.aar
compile_jar_still_exists=True
runtime_jar_still_exists=True
dex_root_still_exists=True
apk_outputs_exist_after_cleanup=False
```

## Outcome
CP-022 completed the requested bounded continuation probe.

It proved:
- the prerequisite artifact before this surface remains `android/fork/app/libs/libcore.aar`
- the exact downstream consumer command is `.\gradlew.bat :app:dexBuilderOssDebug --stacktrace`
- that bounded dex-builder surface succeeds under the persisted sing-box baseline
- no new blocker appears at that surface

It did not perform:
- merge-dex continuation
- packaging work
- install or assemble work
- broader Gradle repair
- Android feature work

## Exact Next Surface
The next exact smallest downstream surface is no longer dex-builder generation.

The next checkpoint should define only the first bounded continuation after successful `:app:dexBuilderOssDebug`, most likely the first merge-project-dex surface entered by `.\gradlew.bat :app:mergeProjectDexOssDebug --stacktrace`, without continuing into `mergeExtDex*`, `mergeLibDex*`, packaging, or `assemble*`.
