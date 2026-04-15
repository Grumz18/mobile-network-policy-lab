# Android Local Build Baseline

## Purpose
This document defines the minimal Android workspace skeleton and local build baseline for the current project phase.
It establishes local preparation structure and verification only.
It does not create Android product code, Gradle modules, fork content, routing behavior, or transport behavior.

## Baseline Assumptions
The exact Android project structure and build graph are intentionally undecided at this stage.
The local build baseline exists to reserve workspace boundaries and define non-secret placeholders before implementation begins.
Local Java availability is useful for future checkpoints.
Android SDK and `adb` availability may remain optional until a later checkpoint explicitly requires them.

## Workspace Skeleton
The Android workspace skeleton introduced by this baseline consists of:
- `android/workspace/README.md` for the reserved future code workspace
- `android/build/README.md` for local build-file and wrapper boundaries
- `android/local.properties.example` for non-secret machine-local path placeholders
- `android/gradle.properties.example` for non-secret local Gradle behavior placeholders
- `android/scripts/verify-local-build.ps1` for safe local baseline verification

These additions are layered on top of the CP-004 Android fork integration baseline.

## Directory Responsibilities
- `android/workspace/` is reserved for future Android project structure after a later checkpoint authorizes actual workspace materialization.
- `android/build/` is reserved for local build notes, wrapper placement expectations, and future build-support assets.
- `android/fork/`, `android/patches/`, and `android/config/` remain baseline-only areas defined by CP-004 and are not expanded here.

## Local Build Templates
The local build baseline uses non-secret placeholders only.
Current properties are intended to document expected local inputs:
- `sdk.dir`
- `org.gradle.jvmargs`
- `org.gradle.parallel`
- `org.gradle.configuration-cache`
- `android.useAndroidX`

These are placeholders, not commitments to a final build implementation.

## Local Verification Flow
From the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\android\scripts\verify-local-build.ps1
```

The verification script should:
- confirm required Android local-build baseline files exist
- confirm checkpoint-driven repository context is still present
- report the availability of local Java and `adb` without requiring builds
- avoid downloads, Gradle execution, emulator actions, or source changes

## Explicit Non-Goals
- no Android app module creation
- no Gradle wrapper creation
- no AndroidManifest or source tree creation
- no per-app routing implementation
- no transport or proxy logic
- no fork synchronization

## Exit Condition For This Baseline
This baseline is complete when a future session can understand the reserved Android workspace and local build placeholders without discovering or inventing structure from scratch.
