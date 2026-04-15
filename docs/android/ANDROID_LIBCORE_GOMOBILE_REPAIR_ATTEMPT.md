# Android Libcore Gomobile Repair Attempt

## Purpose
This document records the CP-012 execution of the smallest tool-local repair attempt for the zero-byte generated `go.mod` blocker in the `libcore` gomobile path.
It is limited to the `gomobile-matsuri` generated-module write path and the validation steps defined in CP-012.
No upstream source under `android/fork/` was modified.
No Gradle or app build continuation was attempted.

## Checkpoint
CP-012

## Date
2026-04-15

## Scope Boundary
Performed:
- used an isolated local `gomobile-matsuri` source workspace and isolated binaries
- patched only the generated `go.mod` write path in `cmd/gomobile/bind.go`
- rebuilt only `gomobile-matsuri` and `gobind-matsuri`
- re-ran the `libcore` gomobile path through `android/fork/libcore/build.sh`
- inspected generated `src-android-*` `go.mod` files
- ran direct `go mod tidy -v` in `android/fork/libcore/.build/src-android-386`
- stopped at the first new meaningful blocker

Not performed:
- no source edits under `android/fork/`
- no broad patches
- no Gradle app assembly
- no Android product feature work
- no per-app routing work
- no transport logic work
- no server artifact changes

## Selected Repair Surface
The repair surface selected by CP-012 was the local `gomobile-matsuri` code path that writes generated `src-android-*` `go.mod` files.

Reason:
- CP-011 proved that the first exact failing generated path was `android/fork/libcore/.build/src-android-386/go.mod`
- the generated `go.mod` files existed but were zero bytes long
- upstream `android/fork/libcore/go.mod`, `android/libneko/go.mod`, and `android/sing-box/go.mod` were already valid

## Tool Baseline Used

### Installed binary metadata
Exact command:

```powershell
& 'C:\Program Files\Go\bin\go.exe' version -m 'C:\Users\grUm.IGOR\go\bin\gomobile-matsuri.exe'
```

Key result:
- installed `gomobile-matsuri.exe` was built from `golang.org/x/mobile/cmd/gomobile`
- embedded VCS revision: `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`

### Source recovery
Exact command:

```powershell
git ls-remote https://github.com/MatsuriDayo/gomobile.git
```

Key result:
- branch `master2` pointed to the same revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`

This allowed the repair attempt to use the exact upstream tool source that matched the installed binary revision.

## Underlying Pre-Repair Failure Context
Before patching, the module enumeration call used by `writeGoMod` was checked directly from `android/fork/libcore`.

Exact command:

```powershell
$env:GOOS='android'
$env:GOARCH='386'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore'
& 'C:\Program Files\Go\bin\go.exe' list -m -json all
```

Exact result:

```text
go: github.com/sagernet/cloudflare-tls@v0.0.0-20221031050923-d70792f4c3a0: invalid version: unknown revision d70792f4c3a0
```

Interpretation:
- `getModuleVersions(...)` was returning `nil, nil` because `go list -m -json all` failed
- the existing `writeGoMod(...)` implementation still created the target file before checking whether module metadata existed
- that behavior explained the zero-byte generated `go.mod` files observed in CP-011

## Isolated Repair Workspace
Temporary paths used during the attempt:
- source workspace: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp012-gomobile-src`
- isolated GOPATH and patched binaries: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp012-gopath`

Original installed binaries under `C:\Users\grUm.IGOR\go\bin\` were not modified.

## Patch Applied
Only one source file was patched in the isolated tool workspace:
- `cmd/gomobile/bind.go`

Patch intent:
- generate `go.mod` content before writing the file
- if module enumeration is unavailable, write a minimal fallback module file instead of leaving a zero-byte file

Exact diff:

```diff
diff --git a/cmd/gomobile/bind.go b/cmd/gomobile/bind.go
index 70fab73..d0db41d 100644
--- a/cmd/gomobile/bind.go
+++ b/cmd/gomobile/bind.go
@@ -318,18 +318,35 @@ func writeGoMod(dir, targetPlatform, targetArch string) error {
 		return nil
 	}
 
-	return writeFile(filepath.Join(dir, "go.mod"), func(w io.Writer) error {
-		f, err := getModuleVersions(targetPlatform, targetArch, ".")
+	f, err := getModuleVersions(targetPlatform, targetArch, ".")
+	if err != nil {
+		return err
+	}
+	if f == nil {
+		if buildV {
+			fmt.Fprintf(os.Stderr, "warning: go list -m metadata unavailable for %s/%s; writing minimal fallback go.mod\n", targetPlatform, targetArch)
+		}
+		f = &modfile.File{}
+		if err := f.AddModuleStmt("gobind"); err != nil {
+			return err
+		}
+		v, err := ensureGoVersion()
 		if err != nil {
 			return err
 		}
-		if f == nil {
-			return nil
+		if v == "" {
+			v = fmt.Sprintf("go1.%d", minimumGoMinorVersion)
 		}
-		bs, err := f.Format()
-		if err != nil {
+		if err := f.AddGoStmt(strings.TrimPrefix(v, "go")); err != nil {
 			return err
 		}
+	}
+	bs, err := f.Format()
+	if err != nil {
+		return err
+	}
+
+	return writeFile(filepath.Join(dir, "go.mod"), func(w io.Writer) error {
 		if _, err := w.Write(bs); err != nil {
 			return err
 		}
```

## Rebuilt Tool Binaries
Exact commands:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp012-gopath'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp012-gomobile-src'
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" ./cmd/gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" ./cmd/gobind
```

Key result:
- patched binaries were built successfully in the isolated GOPATH
- patched `gomobile-matsuri.exe` still carried revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- the patched binary reported `vcs.modified=true`

## Validation Environment
Session environment used for the build attempt:
- `JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot`
- `ANDROID_HOME=C:\Android\Sdk`
- `ANDROID_NDK_HOME=C:\Android\Sdk\ndk\25.0.8775105`
- `GOPATH=C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp012-gopath`
- `PATH` prefixed with JDK, Go, isolated GOPATH bin, and Android tool paths

Host Go command:

```text
go version go1.23.6 windows/amd64
```

The patched binary itself was built with Go toolchain `go1.24.0`, and the later `go mod tidy` step auto-selected `go1.25.0` because the resolved `golang.org/x/mobile` module required it.

## Repair Validation Run

### Isolated gomobile init
Exact command:

```powershell
& "$env:GOPATH\bin\gomobile-matsuri.exe" init
```

Result:
- completed successfully in the isolated GOPATH

### Libcore build-path execution
Exact command:

```powershell
& 'C:\Program Files\Git\bin\bash.exe' -lc 'cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore && pwd && ./build.sh'
```

Key output:

```text
/c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore
./build.sh: line 3: ./env_java.sh: No such file or directory
warning: go list -m metadata unavailable for android/386; writing minimal fallback go.mod
write ...\.build\src-android-386\go.mod
warning: go list -m metadata unavailable for android/arm; writing minimal fallback go.mod
write ...\.build\src-android-arm\go.mod
warning: go list -m metadata unavailable for android/amd64; writing minimal fallback go.mod
write ...\.build\src-android-amd64\go.mod
warning: go list -m metadata unavailable for android/arm64; writing minimal fallback go.mod
write ...\.build\src-android-arm64\go.mod
...
gobind\go_libcoremain.go:19:2: package libcore is not in std (...)
C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp012-gopath\bin\gomobile-matsuri.exe: go build ... ./gobind failed: exit status 1
```

Outcome of this step:
- the old `missing module declaration` failure did not recur
- `build.sh` advanced past zero-byte `go.mod` generation
- `libcore.aar` was not produced
- the first new meaningful blocker was a generated-source import/layout failure during `go build`

## Generated `go.mod` Validation

### Generated file contents
Exact inspection command:

```powershell
$dirs = Get-ChildItem 'android/fork/libcore/.build' -Directory -Filter 'src-android-*' | Sort-Object Name
foreach ($d in $dirs) {
  $p = Join-Path $d.FullName 'go.mod'
  if (Test-Path $p) {
    $len = (Get-Item $p).Length
    Write-Output ('### ' + $p + ' [' + $len + ' bytes]')
    Get-Content $p
  }
}
```

Observed result for every generated architecture root:
- `src-android-386/go.mod` existed and was `89` bytes
- `src-android-amd64/go.mod` existed and was `89` bytes
- `src-android-arm/go.mod` existed and was `89` bytes
- `src-android-arm64/go.mod` existed and was `89` bytes

Observed content:

```text
module gobind

go 1.25.0

require golang.org/x/mobile v0.0.0-20260410095206-2cfb76559b7b
```

Validation result:
- the zero-byte symptom was repaired in the isolated attempt
- the generated `go.mod` files were non-zero and structurally valid

## Direct `go mod tidy -v` Validation
Exact command:

```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386'
& 'C:\Program Files\Go\bin\go.exe' mod tidy -v
```

Result:
- command exited successfully
- no output was emitted
- `go.sum` was created in `src-android-386`

Validation result:
- the direct `go mod tidy -v` check required by CP-012 passed for `src-android-386`

## First New Meaningful Blocker
The first new blocker after the zero-byte `go.mod` repair was:

```text
gobind\go_libcoremain.go:19:2: package libcore is not in std (...)
```

Supporting inspection:

```powershell
Get-Content -TotalCount 80 'android/fork/libcore/.build/src-android-386/gobind/go_libcoremain.go'
Get-ChildItem 'android/fork/libcore/.build/src-android-386'
```

Observed facts:
- `gobind/go_libcoremain.go` imports `libcore`
- `src-android-386` contained `gobind/`, `go.mod`, and `go.sum`
- there was no `src-android-386/libcore/` directory

Interpretation:
- the isolated `go.mod` repair was sufficient to clear the zero-byte generated-module blocker
- it was not sufficient to produce a buildable generated source tree
- the next blocker is a separate generated-source layout/import-resolution problem and should be handled in a new checkpoint

## Rollback And Cleanup
Because the repair attempt did not reach `libcore.aar`, rollback and cleanup were performed after evidence capture.

Cleanup actions:
- removed `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp012-gomobile-src`
- removed `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp012-gopath`
- removed `android/fork/libcore/.build`
- confirmed `android/fork/app/libs/libcore.aar` was absent

What remained unchanged:
- original binaries under `C:\Users\grUm.IGOR\go\bin\gomobile-matsuri.exe` and `gobind-matsuri.exe`
- all source under `android/fork/`

## Outcome
CP-012 successfully validated the smallest repair surface selected from CP-011:
- the tool-local `writeGoMod` patch eliminated the zero-byte generated `go.mod` files
- the generated `src-android-*` `go.mod` files became non-zero and structurally valid
- direct `go mod tidy -v` succeeded in `src-android-386`

CP-012 also proved that this repair surface is not sufficient to complete the libcore gomobile path:
- `build.sh` stopped later during `go build`
- the first new blocker was missing `libcore` package resolution in the generated `src-android-*` tree
- `libcore.aar` was not generated

## Boundary Preserved
The checkpoint stayed within scope:
- no upstream Android source edits
- no Gradle or app build continuation
- no feature work
- no transport logic work
- no server changes

## Next Checkpoint Suggestion
Define CP-013 to isolate and bound the generated `libcore` import/layout blocker that appears after the zero-byte `go.mod` repair, without expanding into broader Android build continuation.
