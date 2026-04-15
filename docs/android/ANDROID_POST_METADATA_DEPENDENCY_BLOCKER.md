# Android Post-Metadata Dependency Blocker

## Purpose
This document records the CP-015 execution that isolates the first generated-workspace dependency-resolution blocker after the CP-014 `libcore` metadata bridge repair.
It is limited to reproducing the blocker in an isolated gomobile workspace, comparing the generated `src-android-*` failure against the local `android/sing-box/` tree, and classifying whether the primary cause is:
- `android/sing-box` revision/layout mismatch
- invalid `github.com/sagernet/cloudflare-tls` revision
- or their interaction

No upstream source under `android/fork/` was modified.
No Gradle or app build continuation was attempted.

## Checkpoint
CP-015

## Date
2026-04-16

## Scope Boundary
Performed:
- recreated an isolated `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the already-approved CP-014 fallback `go.mod` bridge behavior in the disposable tool clone
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri`
- reran `android/fork/libcore/build.sh` only far enough to reproduce the first post-bridge dependency-resolution failure
- inspected one generated architecture root: `android/fork/libcore/.build/src-android-386`
- compared `libcore`'s imported `github.com/sagernet/sing-box/...` package paths against:
  - the current local `android/sing-box/` checkout
  - the fork-pinned commit declared by `android/fork/buildScript/lib/core/get_source_env.sh`
- checked whether `github.com/sagernet/cloudflare-tls` fails independently in the current module graph

Not performed:
- no edits under `android/fork/`
- no edits under `android/sing-box/` or `android/libneko/`
- no persistent changes to default `gomobile-matsuri` or `gobind-matsuri` binaries
- no broader dependency repair
- no Gradle or app assembly work
- no Android feature, routing, transport, or server work

## Reproduction Baseline
The already-cleared CP-014 metadata bridge was preserved in a disposable tool clone so the generated root still contained:
- `require libcore v0.0.0`
- `replace libcore => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore`
- `replace github.com/matsuridayo/libneko => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\libneko`
- `replace github.com/sagernet/sing-box => C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\sing-box`
- `require golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da`

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

Observed generated stub import from `gobind/go_libcoremain.go`:

```text
import (
	_seq "golang.org/x/mobile/bind/seq"
	"libcore"
)
```

Interpretation:
- the CP-014 bridge remained present
- the bare `libcore` import was no longer the blocker
- the next failure was reached without revisiting the cleared metadata problem

## Exact Commands Used

### 1. Recreate the isolated tool workspace
```powershell
git clone https://github.com/MatsuriDayo/gomobile.git .tmp/cp015-gomobile-src
Set-Location .tmp/cp015-gomobile-src
git checkout 17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
```

### 2. Rebuild isolated binaries
```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp015-gopath'
$env:GOTOOLCHAIN='auto'
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gomobile-matsuri.exe" ./cmd/gomobile
& 'C:\Program Files\Go\bin\go.exe' build -o "$env:GOPATH\bin\gobind-matsuri.exe" ./cmd/gobind
& "$env:GOPATH\bin\gomobile-matsuri.exe" init
```

### 3. Reproduce only the post-bridge dependency blocker
```powershell
$env:JAVA_HOME='C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot'
$env:ANDROID_HOME='C:\Android\Sdk'
$env:ANDROID_NDK_HOME='C:\Android\Sdk\ndk\25.0.8775105'
& 'C:\Program Files\Git\bin\bash.exe' -lc 'cd /c/Users/grUm.IGOR/Documents/mobile-network-policy-lab/android/fork/libcore && ./build.sh'
```

### 4. Inspect one generated root directly
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386'
& 'C:\Program Files\Go\bin\go.exe' version
& 'C:\Program Files\Go\bin\go.exe' env GOTOOLCHAIN
& 'C:\Program Files\Go\bin\go.exe' list -e -json -tags with_conntrack,with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api ./gobind
& 'C:\Program Files\Go\bin\go.exe' mod tidy -v
```

### 5. Compare current local `sing-box` checkout with the fork-pinned expectation
```powershell
Get-Content -Raw android/fork/buildScript/lib/core/get_source_env.sh
git -C android/sing-box rev-parse HEAD
git -C android/sing-box branch --show-current
git -C android/sing-box show --stat --oneline --no-patch HEAD
git -C android/sing-box show --stat --oneline --no-patch aed32ee3066cdbc7d471e3e0415c5134088962df
git -C android/sing-box show aed32ee3066cdbc7d471e3e0415c5134088962df:go.mod
```

### 6. Check the cloudflare edge directly
```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore'
& 'C:\Program Files\Go\bin\go.exe' list -m -e -json github.com/sagernet/cloudflare-tls

Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\sing-box'
& 'C:\Program Files\Go\bin\go.exe' list -m -e -json github.com/sagernet/cloudflare-tls
```

## Key Evidence

### 1. The first post-bridge failure occurs in generated-workspace dependency resolution
Observed from the rerun of `android/fork/libcore/build.sh`:

```text
go: gobind/gobind imports
	libcore imports
	github.com/sagernet/sing-box/adapter/endpoint: module github.com/sagernet/sing-box@latest found (v1.13.8, replaced by C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\sing-box), but does not contain package github.com/sagernet/sing-box/adapter/endpoint
```

and later in the same `go mod tidy -v` failure:

```text
go: gobind/gobind imports
	libcore imports
	github.com/sagernet/sing-box/transport/v2rayquic imports
	github.com/sagernet/sing-box/common/tls imports
	github.com/sagernet/cloudflare-tls: github.com/sagernet/cloudflare-tls@v0.0.0-20221031050923-d70792f4c3a0: invalid version: unknown revision d70792f4c3a0
```

Meaning:
- the generated root gets past the old `libcore` import blocker
- the first new failure class is dependency resolution inside the replaced `android/sing-box` module graph

### 2. The current local `android/sing-box/` tree does not match the package layout `libcore` imports
Read-only comparison of `libcore`'s `github.com/sagernet/sing-box/...` package imports against the current local tree showed:
- `present_now=10`
- `missing_now=34`
- `present_in_fork_pinned=44`
- `total=44`

Representative package paths imported by `libcore` that are absent from the current local checkout but present at the fork-pinned commit:
- `github.com/sagernet/sing-box/adapter/endpoint`
- `github.com/sagernet/sing-box/adapter/inbound`
- `github.com/sagernet/sing-box/adapter/outbound`
- `github.com/sagernet/sing-box/adapter/service`
- `github.com/sagernet/sing-box/boxapi`
- `github.com/sagernet/sing-box/common/conntrack`
- `github.com/sagernet/sing-box/dns`
- `github.com/sagernet/sing-box/dns/transport`
- `github.com/sagernet/sing-box/dns/transport/local`
- `github.com/sagernet/sing-box/nekoutils`
- `github.com/sagernet/sing-box/protocol/direct`
- `github.com/sagernet/sing-box/protocol/vmess`

Meaning:
- the missing-package errors are real package-layout mismatches, not a false diagnostic from the generated workspace

### 3. The fork itself declares a different `sing-box` revision than the current local checkout
Observed from `android/fork/buildScript/lib/core/get_source_env.sh`:

```text
export COMMIT_SING_BOX="aed32ee3066cdbc7d471e3e0415c5134088962df"
```

Observed from the local checkout:

```text
git -C android/sing-box rev-parse HEAD
ab23e111dda5f9ee66fca2d49cb28f39d41192bb

git -C android/sing-box branch --show-current
def

git -C android/sing-box show --stat --oneline --no-patch HEAD
ab23e111 Add multi-peer support for wireguard outbound

git -C android/sing-box show --stat --oneline --no-patch aed32ee3066cdbc7d471e3e0415c5134088962df
aed32ee3 1.12.19-neko-1
```

Meaning:
- the local `android/sing-box/` checkout is not at the fork-pinned commit the NekoBox build scripts expect
- the package-layout mismatch aligns with that revision mismatch

### 4. The invalid `cloudflare-tls` revision fails independently in the current checkout
Observed from both `android/fork/libcore` and `android/sing-box`:

```json
{
  "Path": "github.com/sagernet/cloudflare-tls",
  "Version": "v0.0.0-20221031050923-d70792f4c3a0",
  "Error": {
    "Err": "github.com/sagernet/cloudflare-tls@v0.0.0-20221031050923-d70792f4c3a0: invalid version: unknown revision d70792f4c3a0"
  }
}
```

Meaning:
- the `cloudflare-tls` edge is genuinely broken in the current local module graph
- it is not a generated-workspace-only artifact

### 5. The fork-pinned `sing-box` commit does not carry the same `cloudflare-tls` edge
Observed from `git -C android/sing-box show aed32ee3066cdbc7d471e3e0415c5134088962df:go.mod`:
- the fork-pinned `go.mod` does not require `github.com/sagernet/cloudflare-tls`
- the fork-pinned tree contains the package directories that the current local tree is missing

Meaning:
- the current `cloudflare-tls` failure is not the expected baseline of the fork-pinned `sing-box` snapshot
- it appears as part of the local checkout drift away from the fork-pinned revision, not as the first repair surface to isolate independently

## Classification
Primary cause selected:
- `android/sing-box` revision/layout mismatch

Why this is primary:
- the generated workspace, with the CP-014 metadata bridge preserved, immediately fails because `libcore` imports many `github.com/sagernet/sing-box/...` packages that are absent from the current local `android/sing-box/` tree
- those same package directories are present at the fork-pinned commit declared by the fork's own source-bootstrap script
- the current local checkout is at `ab23e111...` on branch `def`, while the fork expects `aed32ee...`

Why `cloudflare-tls` was not selected as the primary next blocker:
- the invalid `cloudflare-tls` revision is real, but it belongs to the current local `android/sing-box` checkout rather than the fork-pinned `sing-box` snapshot
- the fork-pinned `go.mod` does not require `github.com/sagernet/cloudflare-tls`
- because the current local tree already lacks 34 of the 44 package-style `sing-box` imports used by `libcore`, aligning the source revision is the narrower first surface than repairing a dependency edge that may disappear once the tree is aligned

Why `interaction` was not selected:
- the observed interaction is downstream of the same checkout drift
- the read-only fork-pinned evidence is strong enough to separate the first next surface: source-revision alignment for `android/sing-box`

## Exact First Meaningful Failure Point
The first meaningful post-bridge failure point is:
- generated-workspace `go mod tidy -v` in `android/fork/libcore/.build/src-android-386`

Reason:
- `go list -e -json ./gobind` already shows `libcore` importing many `sing-box` packages that the current replacement tree cannot satisfy
- `go mod tidy -v` is the first place where those missing-package errors and the current-checkout `cloudflare-tls` edge are emitted together

## Selected Smallest Next Surface
Selected next surface:
- source/revision alignment for `android/sing-box` only

What the next checkpoint should test:
- in a bounded, reversible way, align the local `android/sing-box/` checkout to the fork-declared commit `aed32ee3066cdbc7d471e3e0415c5134088962df`
- rerun only the same generated-workspace validation needed to see whether:
  - the missing-package errors disappear
  - the `cloudflare-tls` error disappears with that alignment
  - or a smaller residual dependency blocker remains

What the next checkpoint should not do:
- do not revisit the cleared `libcore` metadata bridge
- do not broaden into generic dependency upgrades
- do not repair `cloudflare-tls` in isolation before the revision-alignment test
- do not continue into Gradle or app build work

## Version-Drift Bounds
Observed during CP-015:
- host Go in the generated workspace remained `go1.23.6 windows/amd64`
- generated `src-android-386/go.mod` remained at `go 1.23.1`
- generated `golang.org/x/mobile` remained pinned to `v0.0.0-20231108233038-35478a0c49da`
- the disposable `gomobile-matsuri` rebuild still required `go1.24.0` because the tool source itself declares `go 1.24.0`
- no new dependency versions were intentionally selected as part of the diagnosis

Bounded interpretation:
- generated-workspace drift remained controlled
- the only explicit toolchain step-up remained the isolated tool rebuild, which was captured rather than treated as a repair
- the blocker classification did not rely on any silent dependency upgrade

## Rollback And Cleanup
After evidence capture, cleanup should leave:
- no isolated CP-015 gomobile source workspace
- no isolated CP-015 GOPATH
- no preserved `android/fork/libcore/.build/` tree
- default installed `gomobile-matsuri` and `gobind-matsuri` unchanged
- all upstream source trees unchanged

## Outcome
CP-015 completed the requested classification.

It proved:
- the post-CP-014 blocker is primarily a local `android/sing-box` revision/layout mismatch
- the invalid `github.com/sagernet/cloudflare-tls` revision is real but belongs to the current drifted `android/sing-box` checkout rather than the fork-pinned snapshot
- the smallest next surface is a bounded `android/sing-box` revision-alignment test only

It did not perform:
- any source alignment
- any `cloudflare-tls` repair
- any broader Android build continuation
