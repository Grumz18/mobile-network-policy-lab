# PROJECT_STATE

## PROJECT_ID
adaptive-mobile-network-lab

## CURRENT_PHASE
Repository bootstrap, governance anchoring, repository execution-surface bootstrap, server baseline definition, Android fork baseline definition, Android local build baseline definition, Android fork intake and patch workflow baseline, upstream fork snapshot materialization, initial Android build verification, Android build-prerequisite bootstrap, and the first Android build attempt are complete through CP-010.
CP-011 is now defined as the next bounded checkpoint and remains unexecuted.
The repository is operating under a checkpoint-driven workflow with documented local, server, and Android bootstrap guidance.
The next eligible work is to execute CP-011 to diagnose the libcore gomobile/go.mod blocker.

## CONFIRMED_FOUNDATIONS
The repository exists and is pushed.
The following bootstrap files are assumed to exist and remain authoritative:
- docs/bootstrap/01_LLM_OPERATING_CONTRACT.md
- docs/bootstrap/02_LLM_CHECKPOINT_PROTOCOL.md
- docs/bootstrap/03_OWNER_PROJECT_MAP.md

## CURRENT_OBJECTIVE
Preserve all baselines created through CP-010.
The first Android build attempt has been executed and the first blocker is now documented in the native `libcore` build path.
The next step is to execute CP-011 to isolate the exact generated failing path and blocker origin before any repair checkpoint is defined.
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
- Eleventh checkpoint defined (execution pending)
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
- Materialized external source dependencies (`android/libneko/`, `android/sing-box/`)
- `android/fork/local.properties` for SDK path resolution
- Installed JDK 17, Android SDK (platform 35, Build Tools 35.0.1, NDK 25.0.8775105), Go 1.23.6, gomobile-matsuri, gobind-matsuri
- Cached Gradle 8.10.2 wrapper distribution

## WHAT_DOES_NOT_EXIST_YET
- Successful Android build output (`libcore.aar`, APK)
- Local patches against fork content (requires a post-build-verification checkpoint)

## EXECUTION_RULE
From this point forward, all work must begin from a checkpoint file.
Each checkpoint must be small, bounded, and end with an updated handoff section.

## NEXT_REQUIRED_ACTION
Execute CP-011 to diagnose and bound the `gomobile-matsuri` / intermediate `go.mod` blocker discovered during `libcore.aar` generation.

## RISK_NOTES
The main risk at this stage is scope drift from blocker diagnosis into unbounded repair or implementation.
The current first blocker sits in the gomobile/native bridge path before Gradle app assembly, so later Android build issues are still unknown.
The `libneko` and `sing-box` source trees are cloned at default branch HEAD, not pinned to a revision matching the upstream fork snapshot. Additional module-alignment issues may appear after the current blocker is resolved.
`JAVA_HOME` and `ANDROID_HOME` are not persisted to the system environment and must be set per-session.
If future work starts Android product implementation, per-app routing, transport logic, or broad build repair before CP-011 is executed and its diagnostic result is documented, continuity and checkpoint discipline will degrade.

## OWNER_DECISION_LOG
- The project is personal, research-oriented, and not aimed at app store deployment first.
- Android-first path is accepted.
- NekoBox fork direction is accepted.
- NaiveProxy-centered transport direction is accepted.
- Per-app routing on Android is a mandatory product capability.
