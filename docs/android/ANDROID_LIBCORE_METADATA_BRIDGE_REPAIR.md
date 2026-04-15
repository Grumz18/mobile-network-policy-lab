# Android Libcore Metadata Bridge Repair

## Purpose
This document records the CP-014 execution of the smallest tool-local repair attempt for the generated `go.mod` fallback metadata bridge in the `libcore` gomobile path.
It is limited to a disposable local `gomobile-matsuri` patch that preserves:
- `replace libcore`
- local replacement mappings for `github.com/matsuridayo/libneko` and `github.com/sagernet/sing-box`
- the original `golang.org/x/mobile` baseline

No upstream source under `android/fork/` was modified.
No Gradle or app build continuation was attempted.

## Checkpoint
CP-014

## Date
2026-04-16

## Scope Boundary
Performed:
- recreated an isolated `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- patched only the generated fallback `go.mod` path in the disposable tool-local clone
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri`
- reran `android/fork/libcore/build.sh` only far enough to test the metadata-bridge result
- preserved `.build/` long enough to inspect generated `src-android-386/go.mod`
- validated one generated architecture root (`src-android-386`) with direct `go list` and `go mod tidy` checks
- stopped at the first new meaningful blocker after the bare `libcore` import cleared

Not performed:
- no edits under `android/fork/`
- no persistent changes to default `gomobile-matsuri` or `gobind-matsuri` binaries
- no source-copy/layout changes for `.build/src`
- no Gradle or app assembly work
- no Android feature, routing, transport, or server work

## Selected Repair Surface
The repair surface selected by CP-013 and tested here was:
- generated fallback `go.mod` metadata for the local `libcore` module and its local replacements

Reason:
- CP-013 proved the generated workspace intentionally stages only `gobind` sources
- the immediate blocker was not missing copied `libcore` source under `.build/src`
- the failure came from a generated `module gobind` workspace that lacked the metadata bridge required for `import "libcore"`

## Tool Baseline Used

### Installed baseline before the repair
- project state baseline: host Go `1.23.6`
- `gomobile-matsuri`/`gobind-matsuri` default installs remained untouched
- pinned tool source revision: `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`

### Isolated rebuild observation
Exact commands:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp014-gopath'
$env:GOTOOLCHAIN='auto'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp014-gomobile-src'
& 'C:\Program Files\Go\bin\go.exe' version
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" ./cmd/gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" ./cmd/gobind
& 'C:\Program Files\Go\bin\go.exe' version -m "$env:GOPATH\bin\gomobile-matsuri.exe"
```

Observed result:
- the disposable tool rebuild ran under `go1.24.0`
- rebuilt `gomobile-matsuri.exe` still carried revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- rebuilt binary reported `vcs.modified=true`

Interpretation:
- a toolchain step-up still occurred for the isolated tool build itself
- that drift was explicit and captured
- CP-014 did not allow that drift to silently change the generated workspace baseline

## Original Metadata Baseline Preserved
Observed from `android/fork/libcore/go.mod`:
- module path `libcore`
- `golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da`
- `replace github.com/matsuridayo/libneko => ../../libneko`
- `replace github.com/sagernet/sing-box => ../../sing-box`

Those were the exact metadata elements targeted by the fallback repair.

## Isolated Repair Workspace
Temporary paths used during the attempt:
- source workspace: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp014-gomobile-src`
- isolated GOPATH and patched binaries: `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp014-gopath`

Original installed binaries under `C:\Users\grUm.IGOR\go\bin\` were not modified.

## Patch Applied
Only one source file was patched in the isolated tool workspace:
- `cmd/gomobile/bind.go`

Patch intent:
- keep the CP-012 zero-byte repair behavior
- when strict `go list -m -json all` fails, build a metadata-preserving fallback from the source module's own `go.mod` instead of emitting the minimal drift-prone fallback

Exact behavioral change:
- added a new helper `fallbackModuleVersions(src string)`
- parsed `src/go.mod` directly with `modfile.Parse(...)`
- emitted fallback `module gobind`
- preserved the source `go` directive
- added:
  - `require libcore v0.0.0`
  - `replace libcore => <absolute path to android/fork/libcore>`
  - local replacement mappings for `libneko` and `sing-box` as absolute paths
  - `require golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da`
- changed `writeGoMod(...)` to use the metadata-preserving fallback instead of the old minimal fallback when strict module enumeration returned `nil`

Key code path tested:
- `cmd/gomobile/bind.go`

## Execution Commands

### 1. Recreate the isolated tool workspace
```powershell
git clone https://github.com/MatsuriDayo/gomobile.git .tmp/cp014-gomobile-src
Set-Location .tmp/cp014-gomobile-src
git checkout 17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
```

### 2. Rebuild isolated binaries
```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp014-gopath'
$env:GOTOOLCHAIN='auto'
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" ./cmd/gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" ./cmd/gobind
& "$env:GOPATH\bin\gomobile-matsuri.exe" init
```

### 3. Reproduce the libcore path only to the first new blocker
```powershell
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'
$env:ANDROID_HOME='C:\Android\Sdk'
$env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'
& 'C:\Program Files\Git\bin\bash.exe' -lc 'cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore && ./build.sh'
```

### 4. Inspect one generated architecture root
```powershell
Get-Content -Raw 'android/fork/libcore/.build/src-android-386/go.mod'
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp014-gopath'
$env:GOTOOLCHAIN='auto'
$env:GOOS='android'
$env:GOARCH='386'
$env:CGO_ENABLED='1'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386'
& 'C:\Program Files\Go\bin\go.exe' list -e -json -tags with_conntrack,with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api ./gobind
& 'C:\Program Files\Go\bin\go.exe' mod tidy -v
& 'C:\Program Files\Go\bin\go.exe' list -m -json golang.org/x/mobile
& 'C:\Program Files\Go\bin\go.exe' version
```

## Generated `go.mod` Result
Observed generated `android/fork/libcore/.build/src-android-386/go.mod`:

```text
module gobind

go 1.23.1

require (
	libcore v0.0.0
	golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da
)

replace libcore => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore

replace github.com/matsuridayo/libneko => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\libneko

replace github.com/sagernet/sing-box => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\sing-box
```

Validation result:
- `replace libcore` was preserved
- local replacement mappings for `libneko` and `sing-box` were preserved
- the original `golang.org/x/mobile` baseline was preserved
- the prior minimal fallback drift to `go 1.25.0` and `golang.org/x/mobile v0.0.0-20260410095206-2cfb76559b7b` did not recur

## Bare `libcore` Import Validation
`go list -e -json ./gobind` from `src-android-386` no longer reported:
- `gobind/go_libcoremain.go:19:2: package libcore is not in std (...)`

Instead, the generated workspace now resolved:
- `libcore`
- `libcore/device`
- `libcore/ech`
- `libcore/procfs`
- `libcore/stun`

Interpretation:
- CP-014 successfully cleared the exact unresolved bare `libcore` import that blocked CP-013
- the metadata bridge repair surface was sufficient for that exact blocker

## Version-Drift Validation
Observed in the generated workspace:
- `go version` in `src-android-386` was `go1.23.6 windows/amd64`
- `go env GOTOOLCHAIN` remained `auto`
- `go list -m -json golang.org/x/mobile` reported `v0.0.0-20231108233038-35478a0c49da`
- there was no generated-workspace auto-switch into `go1.25.x`
- the generated `go.mod` did not drift to a newer `golang.org/x/mobile` version

Bounded conclusion:
- CP-014 held the generated workspace to the original `x/mobile` baseline
- the earlier CP-013 `go1.25.x` drift symptom was avoided inside generated `src-android-*`
- the isolated tool build itself still used `go1.24.0`, but that drift was explicit and did not propagate into the generated module baseline

## First New Meaningful Blocker
After the bare `libcore` import was cleared, the first new meaningful blocker appeared during generated-workspace dependency resolution in `go mod tidy -v`.

Exact blocker shape:
- many imports under `github.com/sagernet/sing-box/...` were reported as not present in the replaced local `android/sing-box` tree
- Go also still hit the existing invalid dependency edge:
  - `github.com/sagernet/cloudflare-tls@v0.0.0-20221031050923-d70792f4c3a0: invalid version: unknown revision d70792f4c3a0`

Representative exact failure lines:

```text
go: gobind/gobind imports
	libcore imports
	github.com/sagernet/sing-box/adapter/endpoint: module github.com/sagernet/sing-box@latest found (v1.13.8, replaced by C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\sing-box), but does not contain package github.com/sagernet/sing-box/adapter/endpoint
```

```text
go: gobind/gobind imports
	libcore imports
	github.com/sagernet/sing-box/transport/v2rayquic imports
	github.com/sagernet/sing-box/common/tls imports
	github.com/sagernet/cloudflare-tls: github.com/sagernet/cloudflare-tls@v0.0.0-20221031050923-d70792f4c3a0: invalid version: unknown revision d70792f4c3a0
```

Interpretation:
- the metadata-only repair worked for the exact `libcore` import bridge
- the next blocker is not the same class
- the next blocker is module/dependency alignment in the locally replaced `android/sing-box` tree, plus the known unresolved `cloudflare-tls` revision
- CP-014 stopped at that point as required

## Boundary Preserved
CP-014 stayed within scope:
- no upstream Android source edits
- no broad patches
- no source-copy/layout edits
- no Gradle or app build continuation
- no feature work
- no transport logic work
- no server changes

## Rollback And Cleanup
After evidence capture, cleanup was performed.

Removed:
- `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp014-gomobile-src`
- `C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp014-gopath`
- `android/fork/libcore/.build`

Confirmed absent after cleanup:
- isolated CP-014 tool workspace
- isolated CP-014 GOPATH
- generated `.build/` tree

What remained unchanged:
- original binaries under `C:\Users\grUm.IGOR\go\bin\`
- all source under `android/fork/`

## Outcome
CP-014 completed the selected metadata-bridge repair test.

What it proved:
- the generated fallback `go.mod` can preserve the required local module bridge
- that bridge is sufficient to clear the exact unresolved bare `libcore` import from CP-013
- the original `golang.org/x/mobile` baseline can be preserved without generated-workspace drift to `go1.25.x`

What it did not solve:
- the next blocker is module/dependency alignment in the replaced `android/sing-box` tree, plus the pre-existing unresolved `cloudflare-tls` revision
- no broader build continuation was attempted after that blocker appeared
