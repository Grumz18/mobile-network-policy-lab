# Android Fork Intake

## Purpose
This document defines how the upstream NekoBox source is acquired, placed into the local workspace, and tracked across updates.
It is the authoritative reference for fork intake procedures in this project.

## Upstream Source

| Field              | Value                                                        |
|--------------------|--------------------------------------------------------------|
| Repository         | `MatsuriDayo/NekoBoxForAndroid`                              |
| Host               | GitHub                                                       |
| URL                | `https://github.com/MatsuriDayo/NekoBoxForAndroid`           |
| Primary branch     | `main` (confirm at intake time; some periods used `dev`)     |
| License            | GPL-2.0                                                      |

> **Owner confirmation required:** verify the repository URL and primary branch are still correct before executing the first fork intake in CP-007.

## Chosen Intake Method

**Manual snapshot** (archive download and explicit commit).

### Why Not Submodule
Git submodules maintain a pointer to a remote commit but introduce friction for heavy local modification.
Patch workflows on top of submodules require careful choreography of detached-HEAD states.
For a research-grade project with checkpoint-driven execution, submodules add coupling between the local and upstream git histories that complicates rollback and audit.

### Why Not Subtree
Git subtree merge pulls upstream history into the local repository, which is cleaner than submodules for modification but inflates the commit graph.
Subtree splits and re-merges become error-prone when the upstream repository is large and frequently rebased.

### Why Manual Snapshot
- Each intake is one explicit commit with a known upstream commit hash recorded in metadata.
- The checkpoint workflow naturally maps to discrete snapshot events.
- Patches are applied as separate, auditable commits on top of the snapshot.
- Rollback is a single `git revert` or branch reset to the snapshot commit.
- No git plumbing commands (subtree split, submodule sync) are required.
- The tradeoff is that upstream diffs must be computed manually between snapshots, which is acceptable for a research project with infrequent upstream syncs.

## Intake Procedure

### Prerequisites
- Git CLI available
- Network access to GitHub
- `android/fork/` directory exists (established in CP-004)

### Step-by-Step

1. **Identify the target upstream commit.**
   Visit the upstream repository and record the full commit SHA of the desired snapshot point on the primary branch.

2. **Download the source archive.**
   ```powershell
   # From the repository root
   $UPSTREAM_COMMIT = "<full-sha>"
   $ARCHIVE_URL = "https://github.com/MatsuriDayo/NekoBoxForAndroid/archive/${UPSTREAM_COMMIT}.zip"
   Invoke-WebRequest -Uri $ARCHIVE_URL -OutFile android/fork/upstream-snapshot.zip
   ```

3. **Extract into `android/fork/`.**
   ```powershell
   Expand-Archive -Path android/fork/upstream-snapshot.zip -DestinationPath android/fork/tmp-extract -Force
   # The archive extracts into a single subdirectory named NekoBoxForAndroid-<sha>.
   # Move its contents to android/fork/ directly.
   $extractedDir = Get-ChildItem android/fork/tmp-extract | Select-Object -First 1
   Copy-Item -Path "$($extractedDir.FullName)/*" -Destination android/fork/ -Recurse -Force
   Remove-Item -Path android/fork/tmp-extract -Recurse -Force
   Remove-Item -Path android/fork/upstream-snapshot.zip -Force
   ```

4. **Record the upstream tracking metadata.**
   Create or update `android/fork/UPSTREAM_TRACKING.md`:
   ```markdown
   # Upstream Tracking
   - Upstream repository: MatsuriDayo/NekoBoxForAndroid
   - Upstream commit: <full-sha>
   - Upstream branch: main
   - Snapshot date: <YYYY-MM-DD>
   - Intake checkpoint: CP-007
   ```

5. **Stage and commit the snapshot.**
   ```powershell
   git add android/fork/
   git commit -m "feat(android): intake NekoBox upstream snapshot <short-sha>"
   ```

6. **Verify the intake.**
   Run the fork intake verification script (see below).

### Post-Intake State
After a successful intake, `android/fork/` contains:
- The full NekoBox source tree at the recorded upstream commit
- `UPSTREAM_TRACKING.md` with the commit hash, branch, date, and checkpoint reference
- `README.md` (updated to reflect materialized state)

## Upstream Tracking Convention

Every fork intake must update `android/fork/UPSTREAM_TRACKING.md` with:
- the full upstream commit SHA
- the upstream branch name
- the calendar date of the snapshot
- the checkpoint ID that authorized the intake

This file is the single source of truth for which upstream version the local fork is based on.
A future upstream sync repeats the intake procedure with a newer commit and records the new metadata before patch re-application.

## Upstream Sync Procedure (Future)

When a newer upstream version is desired:
1. Create a new checkpoint for the sync.
2. Record the current `UPSTREAM_TRACKING.md` state.
3. Remove the old fork content from `android/fork/` (preserving `UPSTREAM_TRACKING.md` and `README.md` temporarily).
4. Repeat the intake procedure with the new upstream commit.
5. Update `UPSTREAM_TRACKING.md`.
6. Re-apply patches using the patch workflow (see `docs/android/ANDROID_PATCH_WORKFLOW.md`).
7. Resolve any conflicts.
8. Commit and verify.

## Explicit Non-Goals of This Document
- This document does not execute the intake.
- This document does not fetch, download, or materialize any upstream code.
- This document does not define Android application behavior, per-app routing, or transport logic.
