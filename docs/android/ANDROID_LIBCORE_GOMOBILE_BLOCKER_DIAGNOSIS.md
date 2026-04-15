# Android Libcore Gomobile Blocker Diagnosis

## Purpose
This document records the CP-011 diagnosis of the `libcore` gomobile/go.mod blocker discovered in CP-010.
It is limited to diagnosis and evidence preservation.
No repair work, upstream source modification, patch application, or feature implementation was performed.

## Checkpoint
CP-011

## Date
2026-04-15

## Scope Boundary
Diagnosis only:
- reproduce the blocker
- preserve `.build/` long enough to inspect it
- isolate the exact failing generated path
- determine the most likely origin category
- rank plausible causes by evidence

Not performed:
- no source edits
- no command-flag workarounds
- no dependency version changes
- no Gradle app build
- no blocker repair

## Baseline Inputs Inspected

### Upstream and local module inputs
Exact commands:

```powershell
Get-Content -Raw 'android/fork/libcore/go.mod'
Get-Content -Raw 'android/fork/libcore/build.sh'
Get-Content -Raw 'android/fork/libcore/init.sh'
Get-Content -Raw 'android/libneko/go.mod'
Get-Content -Raw 'android/sing-box/go.mod'
```

Key findings:
- `android/fork/libcore/go.mod` is a valid module file with `module libcore`
- `android/libneko/go.mod` is a valid module file with `module github.com/matsuridayo/libneko`
- `android/sing-box/go.mod` is a valid module file with `module github.com/sagernet/sing-box`
- `android/fork/libcore/build.sh` invokes:
  - `"$GOPATH"/bin/gomobile-matsuri bind ... .`
  - then copies `libcore.aar` into `../app/libs`

This baseline evidence reduces the likelihood that the immediate missing-module-declaration error originates from an already-invalid source `go.mod` in `libcore`, `libneko`, or `sing-box`.

## Reproduction

### Session environment
The same environment shape as CP-010 was re-established:
- `JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot`
- `ANDROID_HOME=C:\Android\Sdk`
- `ANDROID_NDK_HOME=C:\Android\Sdk\ndk\25.0.8775105`
- `GOPATH=C:\Users\grUm.IGOR\go`
- `PATH` prefixed with JDK, Go, GOPATH bin, Android platform-tools, and cmdline-tools paths

### Exact reproduction command

```powershell
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'; $env:ANDROID_HOME='C:\Android\Sdk'; $env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'; $env:GOPATH='C:\Users\grUm.IGOR\go'; $env:PATH="$env:JAVA_HOME\bin;C:\Program Files\Go\bin;$env:GOPATH\bin;$env:ANDROID_HOME\platform-tools;$env:ANDROID_HOME\cmdline-tools\latest\bin;$env:PATH"; & 'C:\Program Files\Git\bin\bash.exe' -lc 'pwd; ./build.sh'
```

Working directory:
- `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore`

Shell mode:
- Git Bash `C:\Program Files\Git\bin\bash.exe`

### Exact output

```text
/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore
./build.sh: line 3: ./env_java.sh: No such file or directory
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-amd64\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-arm\go.mod
write C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-arm64\go.mod
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

## Generated State Inspection

### Exact commands

```powershell
Get-ChildItem -Recurse 'android/fork/libcore/.build' | Select-Object FullName,Length,Mode
$files = Get-ChildItem 'android/fork/libcore/.build' -Directory -Filter 'src-android-*' | Sort-Object Name; foreach ($d in $files) { $p = Join-Path $d.FullName 'go.mod'; if (Test-Path $p) { Write-Output ('### ' + $p); Get-Content $p } }
$dirs = Get-ChildItem 'android/fork/libcore/.build' -Directory -Filter 'src-android-*' | Sort-Object Name; foreach ($d in $dirs) { Write-Output ('### ' + $d.FullName); Get-ChildItem $d.FullName | Select-Object Name,Mode,Length }
$p='android/fork/libcore/.build/src-android-386'; Push-Location $p; try { & 'C:\Program Files\Go\bin\go.exe' mod tidy -v } finally { Pop-Location }
Get-Content -TotalCount 80 'android/fork/libcore/.build/src-android-386/gobind/go_main.go'
Get-Content -TotalCount 80 'android/fork/libcore/.build/src-android-386/gobind/go_libcoremain.go'
```

### First exact failing generated path
The first exact generated path isolated for the failure is:

- `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386\go.mod`

Why this path is the anchor:
- it was the first `src-android-*` `go.mod` emitted in this reproduction
- it exists on disk after reproduction
- it is zero bytes long
- running `go mod tidy -v` directly inside `src-android-386` reproduces the same missing-module-declaration error immediately

Exact path-specific command:

```powershell
$p='android/fork/libcore/.build/src-android-386'; Push-Location $p; try { & 'C:\Program Files\Go\bin\go.exe' mod tidy -v } finally { Pop-Location }
```

Exact output:

```text
go: error reading go.mod: missing module declaration. To specify the module path:
	go mod edit -module=example.com/mod
```

### Generated module-root findings
All four generated architecture-specific module roots were in the same state:

- `...\.build\src-android-386\go.mod`
- `...\.build\src-android-amd64\go.mod`
- `...\.build\src-android-arm\go.mod`
- `...\.build\src-android-arm64\go.mod`

Observed facts:
- each file existed
- each file length was `0`
- `Get-Content` returned no content for each file
- each directory otherwise contained generated `gobind/` source files

This means the error is not a missing file problem.
It is a generated file content problem: the generated `go.mod` files exist but are empty.

### Nearby generated source context
The generated `gobind/` sources under `src-android-386` were present and non-empty.
Example observations from generated files:
- `gobind/go_main.go` declares `package main` and imports `golang.org/x/mobile/bind/seq`
- `gobind/go_libcoremain.go` imports `libcore`

So gomobile/gobind successfully generated source files under the temporary module root, but the module-definition file at that root was empty.

## Cause Ranking

### 1. Most likely: generated temporary module state
Evidence:
- the first exact failing path is a generated temporary file under `.build/`, not an upstream source file
- all generated `src-android-*` roots contain zero-byte `go.mod` files
- directly running `go mod tidy -v` in the first generated root reproduces the same missing-module-declaration error
- the root project and local materialized dependency module files are valid

Conclusion:
- the immediate blocker is the invalid generated temporary module state inside `.build/src-android-*`

### 2. Strong secondary cause: `gomobile-matsuri` behavior
Evidence:
- the failing files are produced during `gomobile-matsuri bind`
- the command output explicitly shows `gomobile-matsuri` writing each `go.mod` path before the zero-byte files are observed
- `gomobile-matsuri.exe` is the process that ultimately reports `go mod tidy -v failed: exit status 1`

Conclusion:
- the generated temporary module state is very likely produced incorrectly by `gomobile-matsuri` itself, or by code paths it controls during bind generation

### 3. Weaker candidate: upstream layout
Evidence for:
- upstream `libcore` layout may interact with gomobile generation in a way that triggers the bad temporary module output
- generated `gobind/go_libcoremain.go` imports `libcore`, so package layout is part of the generation context

Evidence against:
- `android/fork/libcore/go.mod` is valid
- the failure is specifically an empty generated `go.mod`, not an obviously malformed upstream `go.mod`

Conclusion:
- upstream layout remains a plausible contributing factor, but current evidence is weaker than the direct evidence for generated-state / gomobile behavior

### 4. Least likely: local dependency materialization
Evidence against:
- `android/libneko/go.mod` and `android/sing-box/go.mod` both contain valid `module` declarations
- the reproduced failure occurs before any evidence that these local dependencies generated the empty `go.mod` files
- the exact failing file is a zero-byte generated file under `.build/src-android-*`, not a dependency `go.mod`

Conclusion:
- current evidence does not support local dependency materialization as the primary cause of this blocker

## Diagnosis Boundary
Diagnosis completed in CP-011:
- the blocker was reproduced
- the transient `.build/` state was preserved and inspected
- the first exact failing generated path was isolated
- the likely origin categories were ranked by evidence

Repair deferred beyond CP-011:
- changing `gomobile-matsuri`
- editing generated `go.mod` files
- altering upstream `libcore` layout or scripts
- re-materializing dependencies
- retrying the build with workaround flags

## Post-Diagnosis Cleanup
After evidence capture, the generated `android/fork/libcore/.build/` directory was removed to keep the upstream snapshot unmodified between checkpoints.
This report is the durable record of the generated paths and file state.

## Outcome
The blocker is localized to zero-byte generated `go.mod` files under `.build/src-android-*`, with the first exact failing path anchored at `src-android-386/go.mod`.
The most likely immediate cause is invalid generated temporary module state, most likely emitted by `gomobile-matsuri` during bind generation.
