# Android Post-Service Interface Verification

## Purpose
This document records CP-042 execution of only the bounded post-service tunnel-interface presence verification surface.

Scope remained strict:
- prerequisite verification only
- one bounded interface-state probe allowed only after prerequisites pass
- first exact meaningful outcome capture and immediate stop

Out-of-scope actions remained unperformed:
- no ping/curl/traffic generation commands
- no DNS resolution tests
- no UI interaction commands
- no app relaunch commands
- no runtime-debugging capture
- no assemble/release continuation

## Checkpoint
CP-042

## Date
2026-04-27

## Exact Prerequisite Verification
```text
android/sing-box branch=cp017-local-baseline
android/sing-box commit=aed32ee3066cdbc7d471e3e0415c5134088962df
docs/android/ANDROID_POST_RESUMED_TASK_SERVICE_VERIFICATION.md => True
cp041 artifact contains VpnService => True
android/fork/app/build/outputs/apk/oss/debug/output-metadata.json => True
output-metadata applicationId=moe.nb4a.debug
adb resolved path=C:\Android\Sdk\platform-tools\adb.exe
online adb target count=0
FIRST_FAILED_PREREQUISITE=expected exactly one online adb target, found 0
PREREQUISITES=failed
```

## Single Bounded Probe
```powershell
adb shell "ip link show | grep -E 'tun|tap'"
```

Probe execution:
```text
NOT_EXECUTED (stopped at first failed prerequisite)
```

## First Exact Meaningful Outcome
```text
CP-042 prerequisite failed: expected exactly one online adb target, found 0
```

## Success Signal Evaluation
Expected interface-state success signals were not evaluated because probe entry was not reached:
- non-empty `tun|tap` interface line: not evaluated
- `UP` lifecycle indicator: not evaluated
- `EXIT_CODE: 0`: not evaluated

## Fallback Evidence Sources
Captured in this run:
- `docs/android/evidence/cp042_adb_devices.log`
- `docs/android/evidence/cp042_prereq_checks.log`

Not captured in this run because probe was never entered:
- direct probe transcript
- clean probe transcript
- fallback `pidof`
- fallback `pm path`
- fallback `dumpsys activity services | grep -m 1 'moe.nb4a.debug'`

## Cleanup and Boundary Confirmation
- no `libcore.aar` regeneration
- no disposable gomobile/GOPATH workspaces
- no uninstall / force-stop / kill commands used
- upstream source trees unchanged
- no out-of-scope UI/network/runtime-debugging/feature work performed

## Outcome
CP-042 execution result: `partial`.

Completed:
- prerequisites verified and logged
- first exact prerequisite failure outcome captured and stop rule applied before probe entry

Remaining:
- re-run CP-042 bounded flow after restoring exactly one online adb target with ABI `x86_64`, then execute the single bounded probe once and stop at first outcome.
