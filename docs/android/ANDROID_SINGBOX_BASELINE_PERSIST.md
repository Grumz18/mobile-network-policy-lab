# Android Sing-Box Baseline Persist

## Purpose
This document records the CP-017 execution that intentionally persisted the validated `android/sing-box/` alignment as the new local dependency baseline.

The checkpoint stayed narrow:
- no upstream source under `android/fork/` was modified
- no broad patches were applied outside the disposable `gomobile-matsuri` clone
- no Gradle or app build continuation was attempted

## Checkpoint
CP-017

## Date
2026-04-16

## Scope Boundary
Performed:
- captured the exact pre-CP-017 `android/sing-box/` branch and commit
- intentionally replaced that local baseline with a named local branch at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- reused the same disposable `gomobile-matsuri` source revision from CP-014 through CP-016: `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the already-approved CP-014 fallback `go.mod` metadata-bridge behavior inside the disposable tool clone
- reran only the bounded `libcore` validation surface from CP-016
- confirmed the persisted baseline still clears both:
  - the generated-workspace missing-package errors
  - the current `github.com/sagernet/cloudflare-tls` failure
- removed all transient CP-017 tool workspaces, logs, `.build`, and copied `libcore.aar` after evidence capture

Not performed:
- no rollback to the old `android/sing-box` baseline, because validation succeeded
- no edits under `android/fork/`
- no persistent change to the default installed `gomobile-matsuri` or `gobind-matsuri` binaries
- no Gradle or app assembly continuation
- no Android feature, routing, transport, or server work

## Previous Local Baseline
Observed before persistence:

```text
git -C android/sing-box status --short --branch
## def...origin/def

git -C android/sing-box rev-parse HEAD
ab23e111dda5f9ee66fca2d49cb28f39d41192bb
```

Meaning:
- the old local dependency baseline was the drifted `def` checkout
- that was the exact state CP-015 had already identified as carrying the missing-package and `cloudflare-tls` failures

## Persisted Local Baseline
Persistence command:

```powershell
git -C android/sing-box checkout -b cp017-local-baseline aed32ee3066cdbc7d471e3e0415c5134088962df
```

Observed persisted state:

```text
git -C android/sing-box status --short --branch
## cp017-local-baseline

git -C android/sing-box branch --show-current
cp017-local-baseline

git -C android/sing-box rev-parse HEAD
aed32ee3066cdbc7d471e3e0415c5134088962df
```

Meaning:
- the validated alignment is now intentional instead of transient
- the local baseline is tracked by three continuity surfaces:
  - the checked-out local branch `cp017-local-baseline`
  - this report
  - updated project continuity files (`PROJECT_STATE.md`, `checkpoints/CP-017.md`)

## Direct Dependency Surface After Persistence
Observed `android/sing-box/go.mod` still carries:
- `go 1.23.1`
- no `github.com/sagernet/cloudflare-tls` requirement

Direct dependency check:

```powershell
Set-Location android/sing-box
& 'C:\Program Files\Go\bin\go.exe' list -m -e -json github.com/sagernet/cloudflare-tls
```

Observed result:

```json
{
  "Path": "github.com/sagernet/cloudflare-tls",
  "Error": {
    "Err": "module github.com/sagernet/cloudflare-tls: not a known dependency"
  }
}
```

Meaning:
- the persisted local baseline itself does not carry the previous `cloudflare-tls` failure

## Tool Baseline Used
Installed host baseline before validation:
- host Go: `go1.23.6`
- default installed `gomobile-matsuri` and `gobind-matsuri` remained untouched
- disposable tool source revision: `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`

Disposable rebuild observation:

```text
go version go1.24.0 windows/amd64

go version -m .tmp/cp017-gopath/bin/gomobile-matsuri.exe
- vcs.revision: 17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
- vcs.modified: true
```

Interpretation:
- the disposable tool rebuild still stepped up to `go1.24.0`
- that drift stayed explicit and confined to the disposable tool workspace
- the generated workspace itself did not drift beyond the already-bounded CP-016 surface

## Bounded Validation Surface

### 1. `libcore` path rerun with the persisted baseline
Exact command:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp017-gopath'
$env:GOTOOLCHAIN='auto'
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'
$env:ANDROID_HOME='C:\Android\Sdk'
$env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'
& 'C:\Program Files\Git\bin\bash.exe' -lc 'cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore && ./build.sh'
```

Observed result:

```text
>> install /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/app/libs/libcore.aar
```

Additional note:
- `./build.sh` emitted `./env_java.sh: No such file or directory` at startup in this shell path, but it did not prevent generated workspace materialization, `libcore.aar` production, or the bounded follow-up checks

Meaning:
- the persisted baseline did not reintroduce the CP-015 blocker
- no Gradle step was invoked

### 2. Generated `src-android-386` module state
Observed generated `android/fork/libcore/.build/src-android-386/go.mod`:

```text
module gobind

go 1.23.1

toolchain go1.23.6

replace libcore => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore

require (
	golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da
	libcore v0.0.0-00010101000000-000000000000
)

replace github.com/matsuridayo/libneko v1.0.0 => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\libneko

replace github.com/sagernet/sing-box v1.0.0 => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\sing-box
```

Meaning:
- the already-cleared CP-014 metadata bridge remained intact
- the original `golang.org/x/mobile` baseline stayed pinned
- the persisted `android/sing-box` baseline resolved successfully enough for the generated module graph to materialize

### 3. Generated-root checks
Exact commands:

```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386'
$env:GOOS='android'
$env:GOARCH='386'
$env:CGO_ENABLED='1'
$env:GOTOOLCHAIN='auto'
& 'C:\Program Files\Go\bin\go.exe' version
& 'C:\Program Files\Go\bin\go.exe' env GOTOOLCHAIN
& 'C:\Program Files\Go\bin\go.exe' list -e -json -tags with_conntrack,with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api ./gobind
& 'C:\Program Files\Go\bin\go.exe' mod tidy -v
& 'C:\Program Files\Go\bin\go.exe' list -m -e -json golang.org/x/mobile github.com/sagernet/cloudflare-tls
```

Observed result:
- `go version` returned `go1.23.6 windows/amd64`
- `go env GOTOOLCHAIN` returned `auto`
- `go list -e -json ./gobind` exited `0` and listed `libcore` in the import set
- `go mod tidy -v` exited `0`
- `go list -m -e -json golang.org/x/mobile github.com/sagernet/cloudflare-tls` returned:
  - `golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da`
  - `github.com/sagernet/cloudflare-tls: module ... not a known dependency`

Meaning:
- the missing-package errors did not recur under the persisted baseline
- the generated workspace still does not carry the previous `cloudflare-tls` failure

## Result Classification
Primary persistence question:
- Does intentionally persisting the validated `android/sing-box` alignment keep the missing-package errors cleared?

Answer:
- Yes.

Secondary persistence question:
- Does the persisted baseline also keep the current `cloudflare-tls` failure cleared?

Answer:
- Yes.

Bounded checkpoint conclusion:
- CP-017 successfully converted the validated sing-box alignment from a temporary diagnostic state into the intentional local dependency baseline
- that persisted baseline still passes the same bounded `libcore` validation surface from CP-016

## Rollback Expectations
Rollback was required only if persistence or bounded validation failed.

The rollback plan for such a failure was:

```powershell
git -C android/sing-box checkout def
git -C android/sing-box branch -D cp017-local-baseline
```

And then remove:
- `.tmp/cp017-gomobile-src`
- `.tmp/cp017-gopath`
- any remaining `.tmp/cp017-*` evidence files
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Rollback result in this execution:
- not invoked, because the persisted baseline validated successfully

## Cleanup After Evidence Capture
Removed after documentation:
- `.tmp/cp017-gomobile-src`
- `.tmp/cp017-gopath`
- remaining `.tmp/cp017-*` transient evidence files
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

Left intentionally in place:
- `android/sing-box` on local branch `cp017-local-baseline`
- `android/sing-box` at commit `aed32ee3066cdbc7d471e3e0415c5134088962df`
- default installed binaries under `C:\Users\grUm.IGOR\go\bin\`
- all upstream source under `android/fork/`

## Outcome
CP-017 completed the requested baseline-persistence step.

It proved:
- the validated `android/sing-box` alignment can be made intentional and durable as the local dependency baseline
- that persisted baseline still clears the generated-workspace missing-package errors
- that persisted baseline still clears the current `github.com/sagernet/cloudflare-tls` failure
- the bounded `libcore` path still proceeds through transient `libcore.aar` production without entering Gradle

It did not perform:
- Gradle or app build continuation
- broader dependency repair
- Android product work
- routing or transport implementation

## Exact Next Surface
The next exact smallest surface is no longer sing-box baseline repair.

The next checkpoint should define only the first bounded continuation after transient `libcore.aar` production under the persisted sing-box baseline, without revisiting the cleared metadata bridge or the now-persisted sing-box alignment.
