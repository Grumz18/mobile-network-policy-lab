# Android First Build Attempt

## Purpose
This document records the CP-010 first Android build attempt from the bootstrapped prerequisites.
It is limited to build discovery only.
No repair work, upstream source modification, patch application, or feature implementation was performed.

## Checkpoint
CP-010

## Date
2026-04-15

## Dependency-Step Decision
`libcore.aar` generation is the first required build dependency step before Gradle app assembly.

Evidence:
- `android/fork/app/build.gradle.kts` declares `implementation(fileTree("libs"))`
- `android/fork/libcore/build.sh` copies `libcore.aar` into `../app/libs`
- `android/fork/app/libs/libcore.aar` was absent before the attempt

Because of that dependency chain, the first safe build path in CP-010 was:
1. set the session environment explicitly
2. attempt `android/fork/libcore/build.sh` through Git Bash
3. stop if `libcore.aar` generation fails
4. do not proceed into Gradle app assembly without `libcore.aar`

## Session Environment
The session environment was set explicitly before any build command:

- `JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot`
- `ANDROID_HOME=C:\Android\Sdk`
- `ANDROID_NDK_HOME=C:\Android\Sdk\ndk\25.0.8775105`
- `GOPATH=C:\Users\grUm.IGOR\go`
- `PATH` was prefixed with:
  - `%JAVA_HOME%\bin`
  - `C:\Program Files\Go\bin`
  - `%GOPATH%\bin`
  - `%ANDROID_HOME%\platform-tools`
  - `%ANDROID_HOME%\cmdline-tools\latest\bin`

## Pre-Build Environment Print
Exact command:

```powershell
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'; $env:ANDROID_HOME='C:\Android\Sdk'; $env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'; $env:GOPATH='C:\Users\grUm.IGOR\go'; $env:PATH="$env:JAVA_HOME\bin;C:\Program Files\Go\bin;$env:GOPATH\bin;$env:ANDROID_HOME\platform-tools;$env:ANDROID_HOME\cmdline-tools\latest\bin;$env:PATH"; Write-Output ('JAVA_HOME=' + $env:JAVA_HOME); & java -version; Write-Output ('ANDROID_HOME=' + $env:ANDROID_HOME); Write-Output ('ANDROID_NDK_HOME=' + $env:ANDROID_NDK_HOME)
```

Exact output:

```text
JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot
ANDROID_HOME=C:\Android\Sdk
ANDROID_NDK_HOME=C:\Android\Sdk\ndk\25.0.8775105
openjdk version "17.0.18" 2026-01-20
OpenJDK Runtime Environment Temurin-17.0.18+8 (build 17.0.18+8)
OpenJDK 64-Bit Server VM Temurin-17.0.18+8 (build 17.0.18+8, mixed mode, sharing)
```

## First Safe Build Path Attempted

### Working Directory
`C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore`

### Shell Mode
Git Bash:
- `C:\Program Files\Git\bin\bash.exe`

### Exact Build Command

```powershell
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'; $env:ANDROID_HOME='C:\Android\Sdk'; $env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'; $env:GOPATH='C:\Users\grUm.IGOR\go'; $env:PATH="$env:JAVA_HOME\bin;C:\Program Files\Go\bin;$env:GOPATH\bin;$env:ANDROID_HOME\platform-tools;$env:ANDROID_HOME\cmdline-tools\latest\bin;$env:PATH"; & 'C:\Program Files\Git\bin\bash.exe' -lc 'pwd; ./build.sh'
```

### Exact Output

```text
/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore
./build.sh: line 3: ./env_java.sh: No such file or directory
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-arm64\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-amd64\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-arm\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386\go.mod
go: error reading go.mod: missing module declaration. To specify the module path:
	go mod edit -module=example.com/mod
go: error reading go.mod: missing module declaration. To specify the module path:
	go mod edit -module=example.com/mod
go: error reading go.mod: missing module declaration. To specify the module path:
	go mod edit -module=example.com/mod
go: error reading go.mod: missing module declaration. To specify the module path:
	go mod edit -module=example.com/mod
C:\Users\grUm.IGOR\go\bin\gomobile-matsuri.exe: go mod tidy -v failed: exit status 1
```

## First Meaningful Blocker
The first meaningful blocker occurred during `libcore.aar` generation.

Observed blocker:
- `gomobile-matsuri bind` failed after generating intermediate `.build/src-android-*` directories
- the emitted `go` errors reported `go.mod: missing module declaration`
- `gomobile-matsuri.exe` then exited with `go mod tidy -v failed: exit status 1`

This is the blocker boundary for CP-010.
No Gradle app build command was attempted because `android/fork/app/libs/libcore.aar` was not produced.

## Non-Blocking Observation
`./build.sh` reported:

```text
./build.sh: line 3: ./env_java.sh: No such file or directory
```

This was not treated as the first meaningful blocker because the script explicitly tolerates that source step with `source ./env_java.sh || true` and continued past it.

## Post-Attempt Artifact State
- `android/fork/app/libs/libcore.aar` remained absent
- a temporary `android/fork/libcore/.build/` directory was created by the failed build attempt and then removed to keep the upstream snapshot unmodified after the checkpoint

## Gradle Step Status
No Gradle build command was run in CP-010.

Reason:
- `libcore.aar` is the required first dependency step
- that step failed
- continuing into Gradle without the required generated artifact would cross the checkpoint's discovery boundary and provide lower-signal failure data

## Discovery vs Repair Boundary
Discovery completed in CP-010:
- session environment values were established and recorded
- the first dependency step was identified and attempted
- the first meaningful blocker was captured with exact command and exact output

Repair deferred beyond CP-010:
- diagnosing why gomobile-generated intermediate `go.mod` files lack a module declaration
- changing Go, gomobile, shell, or upstream dependency behavior
- editing upstream scripts or source files
- retrying with alternative build commands or flags

## Outcome
The first Android build attempt did not reach Gradle app assembly.
The attempt stopped at the first meaningful blocker during `libcore.aar` generation, and that blocker is now documented for the next bounded checkpoint.
