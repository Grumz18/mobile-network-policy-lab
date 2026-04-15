# PROJECT_STATE

## PROJECT_ID
adaptive-mobile-network-lab

## CURRENT_PHASE
Repository bootstrap, governance anchoring, repository execution-surface bootstrap, server baseline definition, Android fork baseline definition, Android local build baseline definition, Android fork intake and patch workflow baseline, upstream fork snapshot materialization, initial Android build verification, Android build-prerequisite bootstrap, the first Android build attempt, libcore gomobile blocker diagnosis, CP-012 repair-checkpoint definition, CP-012 isolated repair validation, and CP-013 diagnosis-checkpoint definition are complete through CP-013 definition.
The repository is operating under a checkpoint-driven workflow with documented local, server, and Android bootstrap guidance.
The next eligible work is to execute CP-013 from the documented post-CP-012 generated-source blocker.

## CONFIRMED_FOUNDATIONS
The repository exists and is pushed.
The following bootstrap files are assumed to exist and remain authoritative:
- docs/bootstrap/01_LLM_OPERATING_CONTRACT.md
- docs/bootstrap/02_LLM_CHECKPOINT_PROTOCOL.md
- docs/bootstrap/03_OWNER_PROJECT_MAP.md

## CURRENT_OBJECTIVE
Preserve all baselines created through CP-012 execution and the authored CP-013 diagnostic boundary.
The isolated CP-012 repair attempt proved that the zero-byte generated `go.mod` blocker can be cleared inside a tool-local `gomobile-matsuri` workspace, but that repair was not persisted into the default environment.
The next step is to execute the smallest bounded checkpoint defined in CP-013 for the newly exposed generated `libcore` import/layout blocker before retrying the native build path.
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
Execute CP-013 to diagnose the generated `libcore` import/layout blocker, bound version drift, and select one exact next repair surface in `docs/android/ANDROID_LIBCORE_LAYOUT_BLOCKER_DIAGNOSIS.md`.

## RISK_NOTES
The main risk at this stage is scope drift from bounded blocker repair into unbounded build experimentation or implementation.
CP-012 proved that the zero-byte generated `go.mod` files were a tool-local symptom in the gomobile/native bridge path, but the next blocker is now a generated-source layout/import issue where `gobind/go_libcoremain.go` imports `libcore` and the generated `src-android-*` roots do not contain a `libcore/` directory.
The CP-012 repair attempt also triggered a newer `golang.org/x/mobile` module resolution and Go toolchain auto-selection during `go mod tidy`, so the next checkpoint must bound version drift carefully.
CP-013 intentionally limits the next step to diagnosis, cause ranking, and selection of one exact repair surface. It must not drift into broader gomobile repair or Android build continuation.
The isolated CP-012 repair workspace was rolled back after evidence capture, so the default installed `gomobile-matsuri` path remains unchanged.
The `libneko` and `sing-box` source trees are cloned at default branch HEAD, not pinned to a revision matching the upstream fork snapshot. Additional module-alignment issues may appear after the current blocker is resolved.
`JAVA_HOME` and `ANDROID_HOME` are not persisted to the system environment and must be set per-session.
If future work starts Android product implementation, per-app routing, transport logic, or broad build repair before CP-013 is executed and closed, continuity and checkpoint discipline will degrade.

## OWNER_DECISION_LOG
- The project is personal, research-oriented, and not aimed at app store deployment first.
- Android-first path is accepted.
- NekoBox fork direction is accepted.
- NaiveProxy-centered transport direction is accepted.
- Per-app routing on Android is a mandatory product capability.
