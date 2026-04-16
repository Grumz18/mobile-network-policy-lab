# Android Post-Kotlin Continuation

## Purpose
This document records the CP-019 execution that probed only the first exact downstream build surface after successful `.\gradlew.bat :app:compileOssDebugKotlin --stacktrace`.

The checkpoint stayed narrow:
- the cleared `libcore` metadata bridge was reused only as an existing prerequisite through the same disposable gomobile path already validated in CP-014, CP-017, and CP-018
- the persisted `android/sing-box` baseline was only confirmed as a prerequisite and not changed
- no upstream source under `android/fork/` was modified
- no broad patches were applied outside the disposable `gomobile-matsuri` clone
- no Gradle task broader than `.\gradlew.bat :app:compileOssDebugJavaWithJavac --stacktrace` was executed intentionally

## Checkpoint
CP-019

## Date
2026-04-16

## Scope Boundary
Performed:
- printed the pre-probe Java environment state
- confirmed `android/sing-box` remained on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- recreated a disposable `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the already-approved CP-014 fallback `go.mod` metadata behavior inside that disposable tool clone
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri`
- reran `android/fork/libcore/build.sh` only until it installed transient `android/fork/app/libs/libcore.aar`
- entered the exact downstream Java compile consumer surface with `.\gradlew.bat :app:compileOssDebugJavaWithJavac --stacktrace`
- stopped after the first exact downstream outcome was identified
- captured the exact direct shell transcript for the Gradle command
- verified that javac output directories now exist and that class-jar and dex outputs still do not
- removed the disposable CP-019 tool workspaces, `android/fork/libcore/.build`, and transient copied `android/fork/app/libs/libcore.aar` after evidence capture

Not performed:
- no new metadata-bridge diagnosis or repair
- no new sing-box alignment or persistence work
- no edits under `android/fork/`
- no class-jar merge, dexing, packaging, install, assemble, or APK generation work
- no Android product, routing, transport, or server work

## Pre-Probe Environment
Observed before running the probe:

```text
JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot\
openjdk version "17.0.18" 2026-01-20
OpenJDK Runtime Environment Temurin-17.0.18+8 (build 17.0.18+8)
OpenJDK 64-Bit Server VM Temurin-17.0.18+8 (build 17.0.18+8, mixed mode, sharing)
```

Interpretation:
- `JAVA_HOME` was already set in the shell to the expected JDK 17 path
- CP-019 reused the same JDK baseline as CP-018

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

Meaning:
- the persisted CP-017 baseline remained intact
- CP-019 did not need to revisit that surface beyond prerequisite confirmation

## Disposable Tool Baseline Used
Temporary paths used during CP-019:
- source workspace: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp019-gomobile-src`
- isolated GOPATH and patched binaries: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp019-gopath`

Installed baseline preserved:
- host Go for generated workspace continuity: `go1.23.6` baseline remained the target
- default installed `gomobile-matsuri` and `gobind-matsuri` under `C:\Users\grUm.IGOR\go\bin\` were not modified

Exact disposable rebuild commands:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp019-gopath'
$env:GOTOOLCHAIN='auto'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp019-gomobile-src'
& 'C:\Program Files\Go\bin\go.exe' version
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" ./cmd/gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" ./cmd/gobind
& 'C:\Program Files\Go\bin\go.exe' version -m "$env:GOPATH\bin\gomobile-matsuri.exe"
& "$env:GOPATH\bin\gomobile-matsuri.exe" init
```

Observed result:

```text
go version go1.24.0 windows/amd64
... gomobile-matsuri.exe ...
build  vcs.revision=17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
build  vcs.modified=true
go: downloading go1.24.0 (windows/amd64)
```

Interpretation:
- the disposable tool rebuild again stepped up to `go1.24.0`
- that drift stayed explicit and confined to the disposable tool workspace
- the same already-approved metadata-preserving fallback behavior from CP-014 was reused only as a prerequisite to regenerate transient `libcore.aar`

## Exact Prerequisite Entry Artifact
The prerequisite artifact before Java compile entry remained:
- `android/fork/app/libs/libcore.aar`

Exact command used to reach it:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp019-gopath'
$env:GOTOOLCHAIN='auto'
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'
$env:ANDROID_HOME='C:\Android\Sdk'
$env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'
& 'C:\Program Files\Git\bin\bash.exe' -lc 'cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore && ./build.sh'
```

Observed result:

```text
>> install /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/app/libs/libcore.aar
./build.sh: line 3: ./env_java.sh: No such file or directory
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-arm\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-arm64\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-amd64\go.mod
go: found libcore in libcore v0.0.0-00010101000000-000000000000
... additional dependency downloads omitted here for brevity ...
jar: go/Seq.class
jar: libcore/Libcore.class
jar: libcore/BoxInstance.class
aar: jni/armeabi-v7a/libgojni.so
aar: jni/arm64-v8a/libgojni.so
aar: jni/x86/libgojni.so
aar: jni/x86_64/libgojni.so
```

Observed artifact state before cleanup:
- `android/fork/app/libs/libcore.aar` existed
- size: `37,518,766` bytes
- last write time: `2026-04-16 10:20:51 +0300`

Meaning:
- the bounded prerequisite path still reached the same exact post-libcore artifact
- CP-019 did not need to reopen the cleared metadata bridge as a new problem surface

## First Downstream Java Compile Probe
Why this is the correct next exact surface:
- real Java sources still remain under `android/fork/app/src/main/java/`, including:
  - `moe/matsuri/nb4a/SingBoxOptions.java`
  - `io/nekohasekai/sagernet/database/SubscriptionBean.java`
  - `io/nekohasekai/sagernet/fmt/AbstractBean.java`
- CP-018 had already produced Kotlin/KSP outputs
- no javac output directories existed before CP-019
- class-jar merge and dex outputs still did not exist before CP-019

Exact entry command:

```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:compileOssDebugJavaWithJavac --stacktrace
```

Direct shell command result:

```text
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork>"C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot/bin/java.exe" ... org.gradle.wrapper.GradleWrapperMain :app:compileOssDebugJavaWithJavac --stacktrace
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
> Task :app:javaPreCompileOssDebug
> Task :app:compileOssDebugJavaWithJavac

BUILD SUCCESSFUL in 6s
25 actionable tasks: 3 executed, 22 up-to-date
Note: C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\app\src\main\java\moe\matsuri\nb4a\SingBoxOptions.java uses unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.
```

Daemon-log evidence:
- not required in this checkpoint because the direct shell transcript was complete enough to capture the exact task path and exact outcome

Observed downstream evidence after the command:
- `android/fork/app/build/intermediates/javac/ossDebug/compileOssDebugJavaWithJavac/classes/` existed
- `android/fork/app/build/tmp/compileOssDebugJavaWithJavac/` existed
- sample compiled classes existed under:
  - `android/fork/app/build/intermediates/javac/ossDebug/compileOssDebugJavaWithJavac/classes/moe/matsuri/nb4a/SingBoxOptions.class`
  - `android/fork/app/build/intermediates/javac/ossDebug/compileOssDebugJavaWithJavac/classes/io/nekohasekai/sagernet/database/SubscriptionBean.class`
  - `android/fork/app/build/intermediates/javac/ossDebug/compileOssDebugJavaWithJavac/classes/io/nekohasekai/sagernet/fmt/AbstractBean.class`
- broader downstream outputs still did not exist:
  - `android/fork/app/build/intermediates/compile_app_classes_jar/ossDebug` was absent
  - `android/fork/app/build/intermediates/project_dex_archive/ossDebug` was absent

Interpretation:
- the Java compile consumer surface is also not the next blocker
- the first meaningful downstream outcome was success at `:app:compileOssDebugJavaWithJavac`
- the probe remained bounded and did not cross into class-jar merge or dexing

## Result Classification
Primary CP-019 question:
- Does the first exact downstream build surface after successful Kotlin compilation stop at a new blocker?

Answer:
- No. The bounded probe entered `:app:compileOssDebugJavaWithJavac` successfully and completed it.

Secondary CP-019 question:
- What counts as the first meaningful outcome here?

Answer:
- the exact success of `:app:compileOssDebugJavaWithJavac`, plus the creation of javac output directories and compiled `.class` files

Bounded checkpoint conclusion:
- the next exact downstream surface after successful Kotlin compilation is execution-validated
- that surface is not the next blocker
- broader build continuation remains intentionally deferred

## Boundary Preserved
CP-019 stayed within scope:
- no upstream Android source edits
- no new metadata-bridge repair work
- no new sing-box baseline work
- no broad patches beyond the disposable tool-local prerequisite clone
- no class-jar merge, dex, packaging, install, or assemble work
- no feature, routing, transport, or server work

## Cleanup After Evidence Capture
Removed after documentation:
- `.tmp/cp019-gomobile-src`
- `.tmp/cp019-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Left intentionally in place:
- `android/sing-box` on local branch `cp017-local-baseline`
- `android/sing-box` at commit `aed32ee3066cdbc7d471e3e0415c5134088962df`
- default installed binaries under `C:\Users\grUm.IGOR\go\bin\`
- app-side Kotlin/KSP outputs from CP-018 under `android/fork/app/build/`
- app-side javac outputs from CP-019 under `android/fork/app/build/intermediates/javac/ossDebug/compileOssDebugJavaWithJavac/`
- all upstream source under `android/fork/`

## Outcome
CP-019 completed the requested bounded continuation probe.

It proved:
- the prerequisite artifact before this surface remains `android/fork/app/libs/libcore.aar`
- the exact downstream consumer command is `.\gradlew.bat :app:compileOssDebugJavaWithJavac --stacktrace`
- that bounded Java compile surface succeeds under the persisted sing-box baseline
- no new blocker appears at that surface

It did not perform:
- class-jar merge continuation
- dex or packaging work
- broader Gradle repair
- Android feature work

## Exact Next Surface
The next exact smallest downstream surface is no longer Java compilation.

The next checkpoint should define only the first bounded continuation after successful `:app:compileOssDebugJavaWithJavac`, most likely the first class-jar merge surface immediately downstream of javac, without continuing into dexing, packaging, or `assemble*`.
