# Android Fork Boundary

`android/fork/` is reserved for upstream Android fork intake.

## Current State
- No fork has been fetched.
- No upstream repository has been materialized here.
- No synchronization workflow has been executed.

## Fork Intake Reference
The complete fork intake procedure, upstream coordinates, chosen intake method, and tracking convention are defined in:
- `docs/android/ANDROID_FORK_INTAKE.md`

## Expected Post-Intake State
After the fork intake checkpoint (CP-007) is executed, this directory will contain:
- The full NekoBox source tree at a recorded upstream commit
- `UPSTREAM_TRACKING.md` with the upstream commit SHA, branch, date, and checkpoint reference
- This `README.md` (updated to reflect materialized state)

## Upstream Source (Assumed)
- Repository: `MatsuriDayo/NekoBoxForAndroid`
- URL: `https://github.com/MatsuriDayo/NekoBoxForAndroid`
- Primary branch: `main` (confirm before intake)

## Rules
- Do not manually place files here outside the documented intake procedure.
- Do not modify fork content without creating a corresponding patch in `android/patches/`.
- See `docs/android/ANDROID_PATCH_WORKFLOW.md` for the patch creation process.
