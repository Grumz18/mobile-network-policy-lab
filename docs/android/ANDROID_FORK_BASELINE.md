# Android Fork Baseline

## Purpose
This document defines the minimal Android fork integration baseline for the current project phase.
It establishes structure, assumptions, and local verification only.
It does not fetch a fork, add Android source code, or implement transport or routing behavior.

## Baseline Assumption
The exact fork intake workflow is intentionally undecided at this stage.
Future checkpoints may select the concrete acquisition and synchronization method after the Android workspace boundaries are stable.
Until then, the Android workspace should remain documentation-first and non-destructive.

## Initial Android Surface
The initial Android surface consists of:
- `android/README.md` for workspace purpose and layout
- `android/.env.example` for non-secret local configuration placeholders
- `android/.gitignore` for local Android workspace noise
- `android/fork/README.md` for future fork intake boundaries
- `android/patches/README.md` for future local patch workflow boundaries
- `android/config/README.md` for future Android configuration responsibilities
- `android/scripts/verify-baseline.ps1` for safe local baseline verification

## Directory Responsibilities
- `android/` is the top-level Android integration workspace and coordination surface.
- `android/fork/` is reserved for future fork intake and synchronized upstream code only after a later checkpoint authorizes it.
- `android/patches/` is reserved for repository-owned modifications and patch documentation after fork intake is defined.
- `android/config/` is reserved for non-secret Android integration configuration structure and notes.
- `android/scripts/` is reserved for safe local helper scripts that do not fetch code, start builds, or mutate external state by default.

## Configuration Baseline
The Android baseline uses non-secret placeholders only.
Current variables are intended for local structure and documentation:
- `ANDROID_WORKSPACE_NAME`
- `ANDROID_FORK_STATUS`
- `ANDROID_FORK_DIR`
- `ANDROID_PATCH_DIR`
- `ANDROID_CONFIG_DIR`
- `ANDROID_LOCAL_SDK_REQUIRED`
- `ANDROID_LOCAL_JAVA_REQUIRED`

## Local Verification Flow
From the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\android\scripts\verify-baseline.ps1
```

The verification script should:
- confirm required Android baseline files exist
- confirm checkpoint-driven repository context is still present
- report the availability of local Java and `adb` without requiring them for baseline completion
- avoid fork acquisition, Gradle execution, or Android source changes

## Explicit Non-Goals
- no Android application code
- no per-app routing implementation
- no transport or proxy logic
- no fork clone or sync operation
- no Gradle wrapper or build configuration
- no emulator or device automation

## Exit Condition For This Baseline
This baseline is complete when the Android workspace is understandable to a future session without requiring any fork code or Android implementation artifacts.
