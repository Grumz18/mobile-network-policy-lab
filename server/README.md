# Server Workspace

## Purpose
This directory holds the server-side skeleton and future implementation surface for the project.
At the current checkpoint, it contains only baseline documentation, configuration templates, and local verification helpers.

## Current Layout
- `src/` - reserved for future server application code
- `config/` - reserved for future server configuration structure
- `tests/` - reserved for future server verification assets
- `scripts/` - local helper scripts for safe baseline checks
- `.env.example` - non-secret example variables for local development
- `.gitignore` - server-local ignore rules

## Current Constraints
- No transport logic is implemented here.
- No production deployment logic is implemented here.
- No Android integration is implemented here.
- Runtime selection remains intentionally deferred.

## Safe Verification
Run the baseline check from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\server\scripts\verify-baseline.ps1
```
