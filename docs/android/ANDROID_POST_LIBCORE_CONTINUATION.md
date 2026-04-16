# Android Post-Libcore Continuation

## Purpose
This document records the CP-018 execution that probed only the first exact downstream app consumer surface after transient `android/fork/app/libs/libcore.aar` production under the persisted `android/sing-box` baseline.

The checkpoint stayed narrow:
- the cleared `libcore` metadata bridge was reused only as an existing prerequisite through the same disposable gomobile path already validated in CP-014 and CP-017
- the persisted `android/sing-box` baseline was only confirmed as a prerequisite and not changed
- no upstream source under `android/fork/` was modified
- no broad patches were applied outside the disposable `gomobile-matsuri` clone
- no Gradle task broader than `.\gradlew.bat :app:compileOssDebugKotlin --stacktrace` was executed

## Checkpoint
CP-018

## Date
2026-04-16

## Scope Boundary
Performed:
- printed the pre-probe Java and Android environment state
- confirmed `android/sing-box` remained on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- recreated a disposable `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the already-approved CP-014 fallback `go.mod` metadata behavior inside that disposable tool clone
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri`
- reran `android/fork/libcore/build.sh` only until it installed transient `android/fork/app/libs/libcore.aar`
- entered the exact downstream app consumer surface with `.\gradlew.bat :app:compileOssDebugKotlin --stacktrace`
- stopped after the first meaningful Gradle-side outcome was identified
- captured the result from generated build outputs and the Gradle daemon log because the shell adapter returned an empty direct transcript for the Gradle command
- removed the disposable CP-018 tool workspaces, `android/fork/libcore/.build`, and transient copied `android/fork/app/libs/libcore.aar` after evidence capture

Not performed:
- no new metadata-bridge diagnosis or repair
- no new sing-box alignment or persistence work
- no edits under `android/fork/`
- no `assemble*`, `bundle*`, packaging, signing, or APK generation
- no Android product, routing, transport, or server work

## Pre-Probe Environment
Observed before running the probe:

```text
JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot\
openjdk version "17.0.18" 2026-01-20
OpenJDK Runtime Environment Temurin-17.0.18+8 (build 17.0.18+8)
OpenJDK 64-Bit Server VM Temurin-17.0.18+8 (build 17.0.18+8, mixed mode, sharing)
ANDROID_HOME=<unset>
ANDROID_NDK_HOME=<unset>
```

Interpretation:
- `JAVA_HOME` was already set in the shell to the expected JDK 17 path
- `ANDROID_HOME` and `ANDROID_NDK_HOME` were not persisted in the shell and therefore still needed explicit per-command assignment during CP-018, matching the project-state risk note

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
- CP-018 did not need to revisit that surface beyond prerequisite confirmation

## Disposable Tool Baseline Used
Temporary paths used during CP-018:
- source workspace: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp018-gomobile-src`
- isolated GOPATH and patched binaries: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp018-gopath`

Installed baseline preserved:
- host Go for generated workspace continuity: `go1.23.6` baseline remained the target
- default installed `gomobile-matsuri` and `gobind-matsuri` under `C:\Users\grUm.IGOR\go\bin\` were not modified

Exact disposable rebuild commands:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp018-gopath'
$env:GOTOOLCHAIN='auto'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp018-gomobile-src'
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

## Exact Post-Libcore Entry Artifact
The exact downstream handoff artifact remained:
- `android/fork/app/libs/libcore.aar`

Exact command used to reach it:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp018-gopath'
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
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-arm64\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386\go.mod
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
- last write time: `2026-04-16 10:01:15 +0300`
- generated `android/fork/libcore/.build/src-android-386/go.mod` existed

Meaning:
- the bounded prerequisite path still reached the same exact post-libcore entry artifact
- CP-018 did not need to reopen the cleared metadata bridge as a new problem surface

## First Downstream App Consumer Probe
Exact entry command:

```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork'
.\gradlew.bat :app:compileOssDebugKotlin --stacktrace
```

Direct shell command result:

```text
<no stdout/stderr captured by the shell adapter>
exit code: 0
```

Supplementary exact daemon-log result for the same build:
- daemon log file: `C:\Users\grUm.IGOR\.gradle\daemon\8.10.2\daemon-12992.out.log`

Observed daemon-log tail:

```text
w: file:///C:/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/app/src/main/java/io/nekohasekai/sagernet/utils/CrashHandler.kt:136:57 Java type mismatch: inferred type is 'kotlin.String?', but 'kotlin.CharSequence' was expected.
w: file:///C:/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/app/src/main/java/io/nekohasekai/sagernet/utils/Subnet.kt:63:67 Only safe (?.) or non-null asserted (!!.) calls are allowed on a nullable receiver of type 'kotlin.String?'.
w: file:///C:/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/app/src/main/java/moe/matsuri/nb4a/NativeInterface.kt:74:42 'val connectionInfo: WifiInfo!' is deprecated. Deprecated in Java.
BUILD SUCCESSFUL in 2m 50s
23 actionable tasks: 23 executed
```

Observed downstream evidence after the command:
- `android/fork/app/build/tmp/kotlin-classes/ossDebug/` existed
- sample compiled classes existed under:
  - `android/fork/app/build/tmp/kotlin-classes/ossDebug/io/nekohasekai/sagernet/SagerNet.class`
  - `android/fork/app/build/tmp/kotlin-classes/ossDebug/moe/matsuri/nb4a/NativeInterface.class`
  - `android/fork/app/build/tmp/kotlin-classes/ossDebug/io/nekohasekai/sagernet/bg/proto/BoxInstance.class`
- `android/fork/app/build/generated/ksp/ossDebug/kotlin/` existed
- `android/fork/app/build/kotlin/compileOssDebugKotlin/local-state/build-history.bin` existed

Interpretation:
- the first exact downstream app consumer surface accepted the transient `libcore.aar`
- no new blocker appeared within the bounded `:app:compileOssDebugKotlin` probe
- the first meaningful Gradle-side outcome was a successful Kotlin compile continuation signal, not a failure

## Result Classification
Primary CP-018 question:
- Does the first exact downstream consumer surface after transient `libcore.aar` production stop at a new blocker?

Answer:
- No. The bounded probe entered `:app:compileOssDebugKotlin` successfully and completed it.

Secondary CP-018 question:
- What marks entry into that surface?

Answer:
- artifact marker: `android/fork/app/libs/libcore.aar`
- command marker: `.\gradlew.bat :app:compileOssDebugKotlin --stacktrace`

Bounded checkpoint conclusion:
- the first post-`libcore.aar` continuation surface is now execution-validated
- that surface is not the next blocker
- broader build continuation remains intentionally deferred

## Boundary Preserved
CP-018 stayed within scope:
- no upstream Android source edits
- no new metadata-bridge repair work
- no new sing-box baseline work
- no broad patches beyond the disposable tool-local prerequisite clone
- no `assemble*`, `bundle*`, packaging, or APK work
- no feature, routing, transport, or server work

## Cleanup After Evidence Capture
Removed after documentation:
- `.tmp/cp018-gomobile-src`
- `.tmp/cp018-gopath`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Left intentionally in place:
- `android/sing-box` on local branch `cp017-local-baseline`
- `android/sing-box` at commit `aed32ee3066cdbc7d471e3e0415c5134088962df`
- default installed binaries under `C:\Users\grUm.IGOR\go\bin\`
- app-side generated Gradle/Kotlin/KSP outputs under `android/fork/app/build/` as evidence of the successful bounded probe
- all upstream source under `android/fork/`

## Outcome
CP-018 completed the requested bounded continuation probe.

It proved:
- the exact post-libcore handoff artifact is still `android/fork/app/libs/libcore.aar`
- the first exact downstream consumer command is `.\gradlew.bat :app:compileOssDebugKotlin --stacktrace`
- that bounded app compile surface succeeds under the persisted sing-box baseline
- no new blocker appears at that surface

It did not perform:
- Java compilation continuation
- packaging or APK work
- broader Gradle repair
- Android feature work

## Exact Next Surface
The next exact smallest downstream surface is no longer Kotlin compilation.

The next checkpoint should define only the first bounded continuation after successful `:app:compileOssDebugKotlin`, most likely the app Java compile consumer surface entered by:

```powershell
.\gradlew.bat :app:compileOssDebugJavaWithJavac --stacktrace
```

That next checkpoint should stay separated from:
- `assemble*`
- packaging or APK generation
- any repair work unless that exact Java compile surface exposes the first new blocker
