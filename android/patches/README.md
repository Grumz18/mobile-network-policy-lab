# Android Patches Boundary

`android/patches/` is reserved for repository-owned Android modifications applied on top of the upstream fork snapshot.

## Current State
- No patch files exist.
- No local Android modifications are defined.
- No per-app routing or transport changes are implemented.

## Patch Workflow Reference
The complete patch creation, naming, ordering, application, and re-application workflow is defined in:
- `docs/android/ANDROID_PATCH_WORKFLOW.md`

## Patch File Conventions
- Format: standard unified diff (`.patch` files)
- Naming: `<sequence>-<scope>-<short-description>.patch`
  - Sequence: three-digit zero-padded integer (`001`, `002`, ...)
  - Scope: short category (`routing`, `transport`, `ui`, `build`, `config`, `core`)
  - Description: lowercase, hyphen-separated, max ~40 characters
- Application order: ascending by sequence number
- Each patch file includes a header comment with author, date, checkpoint, and description

## Patch Index
A `PATCH_INDEX.md` file will be created in this directory when the first patch is added.
It will track all patches with their sequence, scope, description, checkpoint, and status.

## Rules
- Every modification to `android/fork/` content must be captured as a patch here.
- Patches must be applicable in sequence order against a clean upstream snapshot.
- After an upstream sync, patches must be re-applied and updated if conflicts arise.
- See `docs/android/ANDROID_FORK_INTAKE.md` for the upstream sync procedure.
