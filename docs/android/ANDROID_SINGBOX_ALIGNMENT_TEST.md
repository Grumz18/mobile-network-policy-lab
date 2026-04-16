# Android Sing-Box Alignment Test

## Purpose
This document records the CP-016 execution that tested only whether aligning the local `android/sing-box/` checkout to the fork-expected commit `aed32ee3066cdbc7d471e3e0415c5134088962df` is sufficient to clear:
- the missing-package errors seen in generated `src-android-*`
- the current `github.com/sagernet/cloudflare-tls` failure

No upstream source under `android/fork/` was modified.
No Gradle or app build continuation was attempted.

## Checkpoint
CP-016

## Date
2026-04-16

## Scope Boundary
Performed:
- recreated an isolated `gomobile-matsuri` source workspace at revision `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`
- reapplied only the already-approved CP-014 fallback `go.mod` bridge behavior in the disposable tool clone
- rebuilt only isolated `gomobile-matsuri` and `gobind-matsuri`
- captured the exact pre-test `android/sing-box/` branch and commit
- aligned `android/sing-box/` only to `aed32ee3066cdbc7d471e3e0415c5134088962df`
- reran the same bounded `libcore` generated-workspace path used in CP-015
- inspected one generated architecture root: `android/fork/libcore/.build/src-android-386`
- rolled the local `android/sing-box/` checkout back to its exact pre-test branch and commit
- removed all transient CP-016 workspaces, logs, `.build`, and the transient copied `libcore.aar`

Not performed:
- no edits under `android/fork/`
- no edits to tracked source under `android/sing-box/` or `android/libneko/`
- no persistent changes to default `gomobile-matsuri` or `gobind-matsuri` binaries
- no standalone `cloudflare-tls` repair
- no Gradle app assembly
- no Android product feature, routing, transport, or server work

## Pre-Test Checkout State
Observed before alignment:

```text
git -C android/sing-box status --short --branch
## def...origin/def

git -C android/sing-box rev-parse HEAD
ab23e111dda5f9ee66fca2d49cb28f39d41192bb

git -C android/sing-box show --stat --oneline --no-patch HEAD
ab23e111 Add multi-peer support for wireguard outbound
```

Direct pre-test dependency check:

```json
{
  "Path": "github.com/sagernet/cloudflare-tls",
  "Version": "v0.0.0-20221031050923-d70792f4c3a0",
  "Error": {
    "Err": "github.com/sagernet/cloudflare-tls@v0.0.0-20221031050923-d70792f4c3a0: invalid version: unknown revision d70792f4c3a0"
  }
}
```

## Alignment Performed
Exact checkout command:

```powershell
git -C android/sing-box checkout aed32ee3066cdbc7d471e3e0415c5134088962df
```

Observed aligned state:

```text
git -C android/sing-box status --short --branch
## HEAD (no branch)

git -C android/sing-box rev-parse HEAD
aed32ee3066cdbc7d471e3e0415c5134088962df
```

Observed aligned `android/sing-box/go.mod`:
- `go 1.23.1`
- no `github.com/sagernet/cloudflare-tls` requirement

Direct aligned dependency check:

```json
{
  "Path": "github.com/sagernet/cloudflare-tls",
  "Error": {
    "Err": "module github.com/sagernet/cloudflare-tls: not a known dependency"
  }
}
```

Meaning:
- the current `cloudflare-tls` failure disappeared immediately at the aligned checkout surface

## Tool Baseline Used
Installed baseline before the test:
- host generated-workspace baseline: `go1.23.6`
- default `gomobile-matsuri` and `gobind-matsuri` installs remained untouched
- pinned tool source revision: `17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f`

Isolated rebuild observation:

```text
go version go1.24.0 windows/amd64

go version -m .tmp/cp016-gopath/bin/gomobile-matsuri.exe
- toolchain: go1.24.0
- vcs.revision: 17d6af34f6bd6d7e1e428e0c652c8b54a46bda4f
- vcs.modified: true
```

Interpretation:
- the isolated tool rebuild still required `go1.24.0`
- that toolchain step-up remained explicit and confined to the disposable tool workspace

## Generated-Workspace Validation

### 1. Bounded `libcore` path rerun
Exact command:

```powershell
$env:GOPATH='C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\.tmp\cp016-gopath'
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

Interpretation:
- the bounded `libcore` path no longer stopped at the CP-015 missing-package or `cloudflare-tls` blocker
- no Gradle step was invoked
- the transient copied `libcore.aar` was removed during rollback because CP-016 does not persist build outputs

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
- the CP-014 metadata bridge remained present
- the original `golang.org/x/mobile` baseline remained preserved
- the aligned local `android/sing-box/` tree resolved successfully enough to let the generated module graph materialize normally

### 3. Direct generated-root checks
Exact commands:

```powershell
Set-Location 'C:\Users\grUm.IGOR\Documents\mobile-network-policy-lab\android\fork\libcore\.build\src-android-386'
& 'C:\Program Files\Go\bin\go.exe' version
& 'C:\Program Files\Go\bin\go.exe' env GOTOOLCHAIN
& 'C:\Program Files\Go\bin\go.exe' list -e -json -tags with_conntrack,with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api ./gobind
& 'C:\Program Files\Go\bin\go.exe' mod tidy -v
& 'C:\Program Files\Go\bin\go.exe' list -m -e -json golang.org/x/mobile github.com/sagernet/cloudflare-tls
```

Observed result:
- `go version` returned `go1.23.6 windows/amd64`
- `go env GOTOOLCHAIN` returned `auto`
- `go list -e -json ./gobind` succeeded
- `go mod tidy -v` succeeded with no output
- `go list -m -e -json golang.org/x/mobile github.com/sagernet/cloudflare-tls` returned:
  - `golang.org/x/mobile v0.0.0-20231108233038-35478a0c49da`
  - `github.com/sagernet/cloudflare-tls: module ... not a known dependency`

Meaning:
- the missing-package errors did not recur
- the generated workspace no longer carried the previous `cloudflare-tls` failure

## Result Classification
Primary alignment question:
- Does aligning `android/sing-box` alone remove the missing-package errors?

Answer:
- Yes. The aligned checkout removed the generated-workspace missing-package failures that had blocked CP-015.

Secondary alignment question:
- Does that same alignment also remove the current `cloudflare-tls` failure?

Answer:
- Yes. Under the aligned checkout, `github.com/sagernet/cloudflare-tls` is no longer a known dependency in either the aligned `android/sing-box` module surface or the generated `src-android-386` module graph.

## First Residual Blocker After Alignment
Within the bounded CP-016 validation surface, no new meaningful blocker appeared.
The same generated-workspace path that had previously failed proceeded through AAR production.

Important boundary note:
- this does not mean the broader Android application build is complete
- CP-016 did not continue into Gradle or app assembly
- the transient copied `libcore.aar` was removed after evidence capture

## Version-Drift Bounds
Observed during CP-016:
- isolated `gomobile-matsuri` rebuild still required `go1.24.0`
- generated `src-android-386` stayed at `go 1.23.1`
- generated `toolchain` stayed `go1.23.6`
- generated `golang.org/x/mobile` stayed pinned to `v0.0.0-20231108233038-35478a0c49da`
- no silent dependency upgrade was used as the repair

Bounded conclusion:
- generated-workspace drift remained controlled
- the only explicit toolchain step-up remained the disposable tool rebuild already observed in CP-015
- the successful alignment result did not depend on a newer generated-module baseline

## Rollback And Cleanup
Exact rollback command:

```powershell
git -C android/sing-box checkout def
```

Observed restored state:

```text
restored_head=ab23e111dda5f9ee66fca2d49cb28f39d41192bb
restored_branch=def
git -C android/sing-box status --short --branch
## def...origin/def
```

Removed after evidence capture:
- `.tmp/cp016-gomobile-src`
- `.tmp/cp016-gopath`
- `.tmp/cp016-go-version-386.txt`
- `.tmp/cp016-go-gotoolchain-386.txt`
- `.tmp/cp016-go-list-386.json`
- `.tmp/cp016-go-mod-tidy-386.log`
- `.tmp/cp016-go-list-modules-386.json`
- `android/fork/libcore/.build`
- `android/fork/app/libs/libcore.aar`

What remained unchanged:
- default installed binaries under `C:\Users\grUm.IGOR\go\bin\`
- all upstream source under `android/fork/`
- tracked source under `android/sing-box/`

## Outcome
CP-016 completed the requested reversible alignment test.

It proved:
- aligning `android/sing-box` to `aed32ee3066cdbc7d471e3e0415c5134088962df` alone clears the generated-workspace missing-package errors
- that same alignment also clears the current `github.com/sagernet/cloudflare-tls` failure
- within the bounded validation surface, no new meaningful blocker appeared before transient `libcore.aar` production

It did not perform:
- any permanent local dependency alignment
- any Gradle or app build continuation
- any broader dependency repair
