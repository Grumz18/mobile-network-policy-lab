# PROJECT_STATE

## PROJECT_ID
adaptive-mobile-network-lab

## CURRENT_PHASE
Repository bootstrap, governance anchoring, repository execution-surface bootstrap, server baseline definition, Android fork baseline definition, Android local build baseline definition, Android fork intake and patch workflow baseline, upstream fork snapshot materialization, initial Android build verification, and Android build-prerequisite bootstrap are complete through CP-009.
The repository is operating under a checkpoint-driven workflow with documented local, server, and Android bootstrap guidance.
The next eligible work is to define and execute CP-010 for the first Android build attempt.

## CONFIRMED_FOUNDATIONS
The repository exists and is pushed.
The following bootstrap files are assumed to exist and remain authoritative:
- docs/bootstrap/01_LLM_OPERATING_CONTRACT.md
- docs/bootstrap/02_LLM_CHECKPOINT_PROTOCOL.md
- docs/bootstrap/03_OWNER_PROJECT_MAP.md

## CURRENT_OBJECTIVE
Preserve all baselines created through CP-009.
All Android build prerequisites are installed and external source dependencies are materialized.
The next step is to attempt the first Android build (libcore native bridge and Gradle app assembly) in a bounded checkpoint.
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
Define and execute CP-010 to attempt the first Android build using the bootstrapped prerequisites — libcore native bridge generation followed by Gradle sync and app assembly.

## RISK_NOTES
The main risk at this stage is scope drift from build attempts into unbounded repair or implementation.
The `libneko` and `sing-box` source trees are cloned at default branch HEAD, not pinned to a revision matching the upstream fork snapshot. Go module resolution during the first build may expose version mismatches.
`JAVA_HOME` and `ANDROID_HOME` are not persisted to the system environment and must be set per-session.
If future work starts Android product implementation, per-app routing, or transport logic before a successful build is confirmed, continuity and checkpoint discipline will degrade.

## OWNER_DECISION_LOG
- The project is personal, research-oriented, and not aimed at app store deployment first.
- Android-first path is accepted.
- NekoBox fork direction is accepted.
- NaiveProxy-centered transport direction is accepted.
- Per-app routing on Android is a mandatory product capability.
