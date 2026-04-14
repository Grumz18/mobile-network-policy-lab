# Environment Bootstrap

## Purpose
This document defines the local development bootstrap for the repository-only phase.
It is intentionally limited to workstation readiness for checkpoint-driven work and does not start server or Android implementation.

## Scope
This bootstrap covers:
- repository editing
- checkpoint execution
- documentation updates
- local prerequisite verification

This bootstrap does not cover:
- server runtime setup
- Android SDK or emulator setup
- Dockerized services
- CI/CD configuration

## Workstation Assumption
The current owner workstation is Windows-first.
Commands below assume PowerShell from the repository root.

## Required Tools
- `git` for repository status and versioned changes
- PowerShell 5.1 or newer for local helper scripts

## Recommended Tools
- `rg` for fast repository search during future checkpoint work

## Optional Future Tools
- `java` for later Android-related checkpoints
- `adb` for later Android device and emulator work

These optional tools are not required to complete CP-002.

## Root Bootstrap Files
CP-002 establishes these root-level files:
- `.editorconfig`
- `.gitignore`
- `.env.example`
- `scripts/bootstrap-dev.ps1`

## Environment Variables
Start from `.env.example` when a future checkpoint needs local configuration.
No secrets are required for CP-002.

Variables currently defined:
- `LAB_PROJECT_ID`
- `LAB_BOOTSTRAP_STAGE`
- `LAB_PRIMARY_WORKSTATION`
- `LAB_SERVER_IMPLEMENTATION_ENABLED`
- `LAB_ANDROID_IMPLEMENTATION_ENABLED`

## Local Bootstrap Flow
1. Open PowerShell in the repository root.
2. Review `PROJECT_STATE.md` and the active checkpoint before making changes.
3. Run the bootstrap helper:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\bootstrap-dev.ps1
```

4. Confirm the script reports required tools and files as ready.
5. Confirm `git status --short` shows only expected working-tree changes before starting the active checkpoint.

## Verification Commands
Use these commands from the repository root:

```powershell
git status --short
```

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\bootstrap-dev.ps1
```

```powershell
rg --files
```

If `rg` is unavailable, repository work may continue, but search will be less efficient.

## Guardrails
- Do not place secrets in `.env.example`.
- Do not let bootstrap scripts install dependencies silently.
- Do not start server, Android, infrastructure, or CI/CD implementation from this bootstrap phase.
- Document uncertain tool requirements as assumptions before enforcing them.
