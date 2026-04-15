# Android Libcore Layout Blocker Diagnosis

## Purpose
This document records the CP-013 diagnosis of the generated `libcore` import/layout blocker that appears after the zero-byte generated `go.mod` symptom is cleared.
It is limited to isolated tool-local reproduction, generated-workspace inspection, cause ranking, version-drift bounds, and selection of one exact next repair surface.
No upstream source under `android/fork/` was modified.
No Gradle or app build continuation was attempted.

## Checkpoint
CP-013

## Date
2026-04-16

## Scope Boundary
Performed:
- recreated an isolated `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the temporary CP-012 `writeGoMod(...)` fallback needed to reach the later blocker again
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri` binaries
- reran `android/fork/libcore/build.sh` until the first post-CP-012 blocker
- preserved `android/fork/libcore/.build/` long enough to inspect `.build/src`, `.build/src-android-*`, generated `gobind/` sources, and generated module files
- inspected the relevant `gomobile-matsuri` source paths that govern generated workspace layout and module-file creation
- bounded the observed Go toolchain and `golang.org/x/mobile` drift

Not performed:
- no edits under `android/fork/`
- no persistent changes to default `gomobile-matsuri` or `gobind-matsuri` binaries
- no broader gomobile repair
- no Gradle or app assembly work
- no Android feature, routing, transport, or server work

## Result Summary
The generated failure is not caused by missing source-copy into `.build/src` alone.
`gomobile-matsuri` intentionally stages only generated `gobind` sources under `.build/src`, then copies that tree into `.build/src-android-*`.
In module mode, the per-architecture workspace is a separate `module gobind` root, so the generated `gobind/go_libcoremain.go` import of bare `libcore` can only resolve if the generated `go.mod` carries module metadata that bridges back to the original `android/fork/libcore` module.

That bridge is missing in the fallback `go.mod` path reproduced here.
The strict `go list -m -json all` call inside `writeGoMod(...)` still fails from `android/fork/libcore` because the module graph contains `github.com/sagernet/cloudflare-tls@v0.0.0-20221031050923-d70792f4c3a0`, which the Go tool reports as an unknown revision.
Once that metadata collection fails, the temporary fallback writes only:
- `module gobind`
- `go 1.25.0`
- `require golang.org/x/mobile v0.0.0-20260410095206-2cfb76559b7b`

The generated workspace then has:
- module path `gobind`
- package directory `./gobind`
- generated source that imports `libcore`
- no `replace libcore => <original dir>`
- no preserved local replacements for `github.com/matsuridayo/libneko` or `github.com/sagernet/sing-box`

In that state, `go build ./gobind` treats `libcore` as an unresolved standard-library-style import and fails with:
- `gobind/go_libcoremain.go:19:2: package libcore is not in std (...)`

## Exact Commands Used

### 1. Recreate the isolated tool workspace
```powershell
git clone https://github.com/MatsuriDayo/gomobile.git .tmp/cp013-gomobile-src
Set-Location .tmp/cp013-gomobile-src
git checkout 17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
```

### 2. Reapply the minimum temporary CP-012 fallback
Only the disposable local clone was patched in `cmd/gomobile/bind.go` so `writeGoMod(...)` emits a minimal fallback `go.mod` instead of leaving it zero bytes when module enumeration fails.

### 3. Build isolated binaries and rerun the libcore path
```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp013-gopath'
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" .\cmd\gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" .\cmd\gobind
& "$env:GOPATH\bin\gomobile-matsuri.exe" init
& 'C:\Program Files\Git\bin\bash.exe' -lc 'cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore && ./build.sh'
```

### 4. Inspect the generated workspace
```powershell
Get-ChildItem 'android/fork/libcore/.build/src' -Recurse
Get-ChildItem 'android/fork/libcore/.build/src-android-386' -Recurse
Get-Content -Raw 'android/fork/libcore/.build/src-android-386/go.mod'
Get-Content -Raw 'android/fork/libcore/.build/src-android-386/gobind/go_libcoremain.go'
```

### 5. Inspect the generated module view
```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp013-gopath'
$env:GOOS='android'
$env:GOARCH='386'
$env:CGO_ENABLED='1'
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386'
& 'C:\Program Files\Go\bin\go.exe' list -e -json -tags with_conntrack,with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api ./gobind
& 'C:\Program Files\Go\bin\go.exe' mod tidy -v
& 'C:\Program Files\Go\bin\go.exe' list -m -json all
```

### 6. Inspect the original module graph and the failing dependency edge
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore'
& 'C:\Program Files\Go\bin\go.exe' list -m -json all
& 'C:\Program Files\Go\bin\go.exe' list -m -e -json all
rg -n "cloudflare-tls|d70792f4c3a0" android/fork/libcore android/sing-box android/libneko
```

## Key Evidence

### 1. `.build/src` never contains the root `libcore` package
Observed generated layout before the per-architecture copy:
- `.build/src/gobind/...`
- no `.build/src/libcore/`
- no root-level copied `libcore` Go files

Answer to diagnostic question 1:
- No. `.build/src` does not contain the root `libcore` package files before `src-android-*` copying happens.

### 2. `.build/src-android-*` is only a copy of generated `src`
Observed `src-android-386` layout:
- `gobind/`
- `go.mod`
- `go.sum`
- no `libcore/` directory

Answer to diagnostic question 2:
- The root `libcore` package files do not end up in `src-android-*` at all, because the copy step only duplicates the already-generated `.build/src` tree.

### 3. The tool source shows that this copy behavior is intentional
Relevant `gomobile-matsuri` paths inspected:
- `.tmp/cp013-gomobile-src/cmd/gomobile/bind_androidapp.go`
- `.tmp/cp013-gomobile-src/cmd/gomobile/bind.go`
- `.tmp/cp013-gomobile-src/cmd/gomobile/init.go`
- `.tmp/cp013-gomobile-src/cmd/gomobile/bind_test.go`

Observed behavior:
- `goAndroidBind(...)` runs `gobind -lang=go,java -outdir=$WORK`
- `buildAndroidSO(...)` sets `srcDir := $WORK/src`
- for module builds it copies only `$WORK/src` to `$WORK/src-android-<arch>`
- it then writes `go.mod`, runs `go mod tidy`, and builds `./gobind`

Answer to diagnostic question 3:
- No source-copy step failed. Current `gomobile-matsuri` behavior is to stage generated `gobind` sources only, not the original package tree.

### 4. The generated `gobind` source assumes a module bridge back to `libcore`
Observed import block in `gobind/go_libcoremain.go`:
- `golang.org/x/mobile/bind/seq`
- `libcore`

This means the generated binder stub expects `libcore` to resolve as an import path from inside the generated workspace.

Answer to diagnostic question 4:
- The generated source is not assuming copied `libcore` files under `.build/src`.
- It is assuming module resolution back to the original `libcore` module, or an equivalent metadata bridge.

### 5. The generated fallback `go.mod` does not preserve that bridge
Observed generated `src-android-386/go.mod`:
```text
module gobind

go 1.25.0

require golang.org/x/mobile v0.0.0-20260410095206-2cfb76559b7b
```

Missing from the fallback file:
- `replace libcore => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore`
- `replace github.com/matsuridayo/libneko => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\libneko`
- `replace github.com/sagernet/sing-box => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\sing-box`
- a preserved `golang.org/x/mobile` version matching the original `libcore` module graph

### 6. The original module graph still exposes the metadata that the fallback lost
`go list -m -e -json all` from `android/fork/libcore` still showed:
- main module path `libcore`
- local replacement for `github.com/matsuridayo/libneko` to `../../libneko`
- local replacement for `github.com/sagernet/sing-box` to `../../sing-box`
- `golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da`

That confirms the original upstream layout is still coherent enough to describe the intended module bridge when the metadata call is allowed to complete.

### 7. The strict module-enumeration path still fails
`go list -m -json all` from `android/fork/libcore` still failed with:
```text
go: github.com/sagernet/cloudflare-tls@v0.0.0-20221031050923-d70792f4c3a0: invalid version: unknown revision d70792f4c3a0
```

The unresolved dependency edge is currently declared in:
- `android/sing-box/go.mod`

Because `writeGoMod(...)` uses the strict form and treats any failure as "module information unavailable", the generated fallback file loses the module bridge entirely.

### 8. The generated workspace confirms the failure mechanism
`go list -e -json ... ./gobind` inside `src-android-386` reported:
- module path `gobind`
- import `libcore`
- dependency error at `gobind/go_libcoremain.go:19:2`
- `package libcore is not in std (...)`

This is the direct proof that the immediate failure is module-resolution failure inside the generated `gobind` workspace, not a failed copy of `libcore` source into `.build/src`.

## Diagnosis

### Exact path relationship causing the failure
The generated path relationship is:
1. original package/module lives at `android/fork/libcore` with `module libcore`
2. `gobind` output is staged under `.build/src/gobind`
3. each architecture root copies that tree to `.build/src-android-<arch>`
4. each architecture root becomes its own `module gobind`
5. `go build ./gobind` runs from inside that `module gobind`
6. `gobind/go_libcoremain.go` imports bare `libcore`
7. because the generated `go.mod` does not preserve `replace libcore => <original dir>`, the Go tool cannot resolve `libcore` from the `gobind` module and reports it as an unresolved standard-library-style import

### What the critical missing piece is
Primary missing piece:
- generated module metadata for the local `libcore` module and its local replacements

Secondary contributing factor:
- import-path mismatch between generated module root `gobind` and the bound package import `libcore`

Not the primary missing piece:
- source-copy/layout of `libcore` under `.build/src`

Reason:
- current `gomobile-matsuri` intentionally does not stage `libcore` source under `.build/src`
- the generated workspace is designed to rely on module metadata, not copied source, for the original package import

## Ranked Cause Categories
1. `temporary workspace/module structure`
   The immediate failure occurs inside a generated `module gobind` workspace that contains only `gobind/` plus generated module files. In that structure, `import "libcore"` cannot work unless metadata bridges back to the original module.
2. `gomobile-matsuri` generation behavior
   The tool intentionally copies only generated `src`, and its current strict `writeGoMod(...)` path collapses to a metadata-free fallback when `go list -m -json all` fails. That behavior creates the broken workspace state.
3. `libcore` layout assumptions
   `android/fork/libcore` uses bare module path `libcore` and root-level package files. That layout is workable only if the generated workspace preserves a `libcore` module mapping. Once the metadata bridge is lost, the bare import becomes fragile and is treated as unresolved.
4. `bind invocation shape`
   Lowest likelihood. The invocation matched the expected `gomobile bind` flow documented in `bind_test.go`, and there is no evidence that the current package argument or tag set is what dropped the module bridge.

## Selected Smallest Next Repair Surface
Selected class:
- generated fallback `go.mod` metadata for the local `libcore` module and its local replacements

Reason for selection:
- this is the narrowest place where the missing bridge can be restored without editing `android/fork/`
- the tool source shows source-copy changes are broader than necessary and would fight the current design
- the bind invocation itself already matches expected behavior
- the original module graph still exposes the information needed for a metadata-preserving fallback

What the next repair checkpoint should test:
- in an isolated tool-local workspace only, teach the generated fallback `go.mod` path to preserve:
  - `replace libcore => <absolute path to android/fork/libcore>`
  - `replace github.com/matsuridayo/libneko => <absolute path to android/libneko>`
  - `replace github.com/sagernet/sing-box => <absolute path to android/sing-box>`
  - a non-drifting `golang.org/x/mobile` requirement aligned with the original `libcore` module graph (`v0.0.0-20231108233038-35478a0c49da`) instead of letting fallback `go mod tidy` select `latest`

Why the other repair classes were not selected yet:
- not `temporary workspace source-copy/layout behavior for the libcore package`
  - the current tool is not designed to stage root package files into `.build/src`; changing that is a broader behavior change than the evidence requires
- not `a bind invocation adjustment`
  - no evidence shows the current invocation shape is what removed the module bridge

## Version-Drift Bounds For The Next Repair Attempt
Observed during CP-013:
- host Go baseline remained `go1.23.6 windows/amd64`
- `GOTOOLCHAIN` remained `auto`
- the isolated rebuilt `gomobile-matsuri.exe` was stamped with toolchain `go1.24.0`
- the original `android/fork/libcore` graph still referenced `golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da`
- the generated fallback `src-android-*` module resolved `golang.org/x/mobile v0.0.0-20260410095206-2cfb76559b7b`
- that fallback resolution forced `go build` to auto-switch further to `go1.25.9` because the resolved `golang.org/x/mobile` required `go >= 1.25.0`

Bound for the next repair attempt:
- keep host Go at `go1.23.6` with `GOTOOLCHAIN=auto`; do not intentionally upgrade Go
- keep `gomobile-matsuri` source pinned to `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- do not intentionally upgrade `golang.org/x/mobile`
- treat `golang.org/x/mobile v0.0.0-20260410095206-2cfb76559b7b` and the resulting `go1.25.x` auto-selection as drift symptoms caused by the fallback, not as the target baseline
- next repair should preserve or recreate the original `libcore` graph's `golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da` mapping unless new evidence proves that impossible

## Rollback And Cleanup
After evidence capture, the transient diagnostic workspace was removed:
- `.tmp/cp013-gomobile-src`
- `.tmp/cp013-gopath`
- `android/fork/libcore/.build`

What remained unchanged:
- default installed binaries under `C:\Users\grUm.IGOR\go\bin\`
- all source under `android/fork/`

## Outcome
CP-013 completed the requested diagnosis.
The generated `libcore` blocker is now isolated to a missing metadata bridge inside the generated `module gobind` workspace, not to a failed source copy into `.build/src`.
The smallest next repair surface is a tool-local generated `go.mod` metadata fallback that preserves `libcore`, local replacements, and the non-drifting `golang.org/x/mobile` baseline.
