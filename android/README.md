# Android Workspace

## Purpose
This directory holds the Android fork integration baseline and future Android implementation surface for the project.
At the current checkpoint, it contains only baseline documentation, configuration placeholders, and local verification helpers.

## Current Layout
- `fork/` - reserved for future upstream fork intake
- `patches/` - reserved for future repository-owned Android modifications
- `config/` - reserved for future Android integration configuration
- `scripts/` - local helper scripts for safe baseline checks
- `.env.example` - non-secret example variables for local Android preparation
- `.gitignore` - Android-local ignore rules

## Current Constraints
- No Android application code is implemented here.
- No fork content is present here.
- No Gradle files are created here.
- No per-app routing or transport behavior is implemented here.

## Safe Verification
Run the baseline check from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\android\scripts\verify-baseline.ps1
```
