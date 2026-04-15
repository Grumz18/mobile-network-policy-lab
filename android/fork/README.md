# Android Fork — Materialized Upstream Snapshot

`android/fork/` contains the upstream NekoBox source tree, materialized via manual snapshot intake.
This is the post-intake state after CP-007 execution.

## Current State
- **Upstream repository:** `MatsuriDayo/NekoBoxForAndroid`
- **Upstream commit:** `5768494d8ae3c74a057bb6d46c0f8dc071b0d821`
- **Upstream branch:** `main`
- **Snapshot date:** 2026-04-15
- **Intake checkpoint:** CP-007
- **Status:** clean upstream snapshot, no local patches applied

## Tracking
See `UPSTREAM_TRACKING.md` in this directory for the canonical upstream version reference.

## Fork Intake Reference
The complete fork intake procedure, upstream coordinates, chosen intake method, and tracking convention are defined in:
- `docs/android/ANDROID_FORK_INTAKE.md`

## Patch Workflow
All local modifications to this fork content must be captured as patches in `android/patches/`.
See `docs/android/ANDROID_PATCH_WORKFLOW.md` for the patch creation and application process.

## Rules
- Do not manually place files here outside the documented intake procedure.
- Do not modify fork content without creating a corresponding patch in `android/patches/`.
- The upstream README is preserved as-is in the source tree (see `README.md` from the upstream at the time of intake — this file replaces it as the project-level boundary document).

## Upstream README
The original upstream `README.md` was overwritten by this project boundary document.
To view the upstream project description, refer to the upstream repository directly:
`https://github.com/MatsuriDayo/NekoBoxForAndroid`
