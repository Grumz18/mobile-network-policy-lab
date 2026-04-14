# Server Baseline

## Purpose
This document defines the minimal server-side skeleton and configuration baseline for the current project phase.
It establishes structure and local verification only.
It does not implement transport behavior, deployment behavior, or Android integration.

## Baseline Assumption
The server runtime choice is intentionally undecided at this stage.
Future checkpoints may select a concrete runtime after the repository-level server surface is stable.
Until that decision is made, the server workspace should remain runtime-neutral and documentation-first.

## Initial Server Surface
The initial server surface consists of:
- `server/README.md` for workspace purpose and layout
- `server/.env.example` for non-secret local configuration variables
- `server/.gitignore` for local server-side noise
- `server/src/README.md` for future application source boundaries
- `server/config/README.md` for future configuration responsibilities
- `server/tests/README.md` for future test boundaries
- `server/scripts/verify-baseline.ps1` for safe local baseline verification

## Directory Responsibilities
- `server/` is the top-level server workspace and coordination surface.
- `server/src/` is reserved for future application code only after a later checkpoint authorizes implementation.
- `server/config/` is reserved for non-secret configuration structure and documentation.
- `server/tests/` is reserved for verification assets added only after server behavior exists.
- `server/scripts/` is reserved for safe local helper scripts that do not start services or mutate infrastructure by default.

## Configuration Baseline
The server baseline uses non-secret placeholders only.
Current variables are intended for local structure and documentation:
- `SERVER_APP_NAME`
- `SERVER_RUNTIME`
- `SERVER_BIND_HOST`
- `SERVER_BIND_PORT`
- `SERVER_LOG_LEVEL`
- `SERVER_CONFIG_DIR`
- `SERVER_SRC_DIR`
- `SERVER_TEST_DIR`

## Local Verification Flow
From the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\server\scripts\verify-baseline.ps1
```

The verification script should:
- confirm required server baseline files exist
- confirm the checkpoint-driven repository context is still present
- avoid service startup, dependency installation, and transport behavior

## Explicit Non-Goals
- no proxy or transport implementation
- no API handler implementation
- no persistence layer
- no authentication layer
- no Docker or deployment logic
- no CI/CD automation

## Exit Condition For This Baseline
This baseline is complete when the server workspace is understandable to a future session without requiring runtime-specific code.
