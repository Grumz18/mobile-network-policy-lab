# PROJECT_STATE

## PROJECT_ID
adaptive-mobile-network-lab

## CURRENT_PHASE
Repository bootstrap, governance anchoring, repository execution-surface bootstrap, server baseline definition, Android fork baseline definition, Android local build baseline definition, Android fork intake and patch workflow baseline, upstream fork snapshot materialization, initial Android build verification, Android build-prerequisite bootstrap, the first Android build attempt, libcore gomobile blocker diagnosis, CP-012 repair-checkpoint definition, CP-012 isolated repair validation, CP-013 diagnosis-checkpoint definition, CP-013 blocker diagnosis execution, CP-014 metadata-bridge repair-checkpoint definition, and CP-014 metadata-bridge repair execution are complete.
The repository is operating under a checkpoint-driven workflow with documented local, server, and Android bootstrap guidance.
The next eligible work is to define the post-CP-014 dependency-resolution checkpoint only.

## CONFIRMED_FOUNDATIONS
The repository exists and is pushed.
The following bootstrap files are assumed to exist and remain authoritative:
- docs/bootstrap/01_LLM_OPERATING_CONTRACT.md
- docs/bootstrap/02_LLM_CHECKPOINT_PROTOCOL.md
- docs/bootstrap/03_OWNER_PROJECT_MAP.md

## CURRENT_OBJECTIVE
Preserve all baselines created through CP-014 execution and the new metadata-bridge repair artifact.
CP-014 proved that a tool-local generated fallback `go.mod` can preserve the `libcore` bridge, local replacements, and the original `golang.org/x/mobile` baseline, and that this is sufficient to clear the exact bare `libcore` import blocker from CP-013.
The next step is to define one exact checkpoint for the first new blocker only: generated-workspace dependency resolution against the replaced `android/sing-box` tree and the unresolved `cloudflare-tls` revision.
No server or Android implementation should begin outside an approved checkpoint.

## WHAT_EXISTS_NOW
- Git repository initialized
- Base folder structure created
- Bootstrap LLM guidance files added
- Initial commit pushed
- Global project state file established
- First checkpoint file finalized
- Second checkpoint executed and finalized
- Third checkpoint executed and finalized
- Fourth checkpoint executed and finalized
- Fifth checkpoint executed and finalized
- Sixth checkpoint executed and finalized
- Seventh checkpoint executed and finalized
- Eighth checkpoint executed and finalized
- Ninth checkpoint executed and finalized
- Tenth checkpoint executed and finalized
- Eleventh checkpoint executed and finalized
- README aligned to the checkpoint workflow
- Repository execution surface document
- Development environment bootstrap document
- Root editor and ignore baseline files
- Root example environment file
- Local bootstrap helper script
- Server baseline document
- Server workspace baseline files
- Server baseline verification script
- Android fork baseline document
- Android workspace baseline files
- Android baseline verification script
- Android local build baseline document
- Android local build placeholder files
- Android local build verification script
- Android fork intake document
- Android patch workflow document
- Android fork intake verification script
- Materialized upstream NekoBox snapshot in android/fork/ (commit 5768494d8ae3c74a057bb6d46c0f8dc071b0d821)
- Upstream tracking metadata file
- Initial Android build verification report
- Android build prerequisites manifest
- Android prerequisite verification script
- First Android build attempt report
- Libcore gomobile blocker diagnosis report
- CP-012 repair checkpoint definition
- CP-012 libcore gomobile repair attempt report
- CP-013 layout-blocker diagnosis checkpoint definition
- CP-013 layout-blocker diagnosis execution report
- CP-014 metadata-bridge repair checkpoint definition
- CP-014 metadata-bridge repair execution report
- Materialized external source dependencies (`android/libneko/`, `android/sing-box/`)
- `android/fork/local.properties` for SDK path resolution
- Installed JDK 17, Android SDK (platform 35, Build Tools 35.0.1, NDK 25.0.8775105), Go 1.23.6, gomobile-matsuri, gobind-matsuri
- Cached Gradle 8.10.2 wrapper distribution

## WHAT_DOES_NOT_EXIST_YET
- Successful Android build output (`libcore.aar`, APK)
- Local patches against fork content (requires a post-build-verification checkpoint)
- A persisted default-environment repair for the libcore gomobile path

## EXECUTION_RULE
From this point forward, all work must begin from a checkpoint file.
Each checkpoint must be small, bounded, and end with an updated handoff section.

## NEXT_REQUIRED_ACTION
Define CP-015 to isolate the first post-CP-014 dependency-resolution blocker in the generated workspace, keeping the work tool-local and out of Gradle or upstream `android/fork/` source.

## RISK_NOTES
The main risk at this stage is scope drift from bounded blocker repair into unbounded build experimentation or implementation.
CP-013 proved that the generated `src-android-*` roots are intentionally copied from generated `gobind` sources only, so the current blocker is a missing generated module bridge for import path `libcore`, not merely a missing copied `libcore/` directory.
CP-014 proved that the metadata-bridge repair surface is sufficient to clear the exact bare `libcore` import and preserve the original `golang.org/x/mobile` baseline in generated `src-android-*`.
The next blocker is now generated-workspace dependency resolution against the replaced `android/sing-box` tree, plus the existing unresolved `github.com/sagernet/cloudflare-tls` revision. The next checkpoint must stay on that new blocker only.
Version drift remains a risk at the tool-build layer because the isolated repaired `gomobile-matsuri` binary still rebuilt under `go1.24.0`, but the generated workspace itself no longer drifted to `go1.25.x`.
The isolated CP-014 repair workspace was rolled back after evidence capture, so the default installed `gomobile-matsuri` path remains unchanged.
The `libneko` and `sing-box` source trees are cloned at default branch HEAD, not pinned to a revision matching the upstream fork snapshot. Additional module-alignment issues may appear after the current blocker is resolved.
`JAVA_HOME` and `ANDROID_HOME` are not persisted to the system environment and must be set per-session.
If future work starts Android product implementation, per-app routing, transport logic, or broad build repair before the post-CP-014 dependency-resolution checkpoint is defined and executed, continuity and checkpoint discipline will degrade.

## OWNER_DECISION_LOG
- The project is personal, research-oriented, and not aimed at app store deployment first.
- Android-first path is accepted.
- NekoBox fork direction is accepted.
- NaiveProxy-centered transport direction is accepted.
- Per-app routing on Android is a mandatory product capability.
