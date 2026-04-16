# PROJECT_STATE

## PROJECT_ID
adaptive-mobile-network-lab

## CURRENT_PHASE
Repository bootstrap, governance anchoring, repository execution-surface bootstrap, server baseline definition, Android fork baseline definition, Android local build baseline definition, Android fork intake and patch workflow baseline, upstream fork snapshot materialization, initial Android build verification, Android build-prerequisite bootstrap, the first Android build attempt, libcore gomobile blocker diagnosis, CP-012 repair-checkpoint definition, CP-012 isolated repair validation, CP-013 diagnosis-checkpoint definition, CP-013 blocker diagnosis execution, CP-014 metadata-bridge repair-checkpoint definition, CP-014 metadata-bridge repair execution, CP-015 post-metadata dependency-blocker checkpoint definition, CP-015 post-metadata dependency-blocker execution, CP-016 sing-box alignment-test checkpoint definition, CP-016 sing-box alignment-test execution, CP-017 sing-box baseline-persistence checkpoint definition, and CP-017 sing-box baseline-persistence execution are complete.
The repository is operating under a checkpoint-driven workflow with documented local, server, and Android bootstrap guidance.
The next eligible work is to create CP-018 only.

## CONFIRMED_FOUNDATIONS
The repository exists and is pushed.
The following bootstrap files are assumed to exist and remain authoritative:
- docs/bootstrap/01_LLM_OPERATING_CONTRACT.md
- docs/bootstrap/02_LLM_CHECKPOINT_PROTOCOL.md
- docs/bootstrap/03_OWNER_PROJECT_MAP.md

## CURRENT_OBJECTIVE
Preserve all baselines created through CP-017 execution and the existing CP-014 metadata-bridge repair artifact.
CP-015 proved that the first post-CP-014 blocker is primarily a revision/layout mismatch in the local `android/sing-box/` checkout, and that the current `cloudflare-tls` failure belongs to that drifted checkout rather than the fork-pinned snapshot.
CP-016 proved that a reversible alignment of `android/sing-box` to `aed32ee3066cdbc7d471e3e0415c5134088962df` alone clears both the missing-package and `cloudflare-tls` symptoms and allows the bounded `libcore` path to proceed through transient `libcore.aar` production.
CP-017 intentionally persisted that proven `android/sing-box` alignment as the new local dependency baseline by placing the dependency on local branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`, and revalidated the same bounded `libcore` path successfully.
The next step is to create CP-018 only so the first bounded continuation surface after transient `libcore.aar` production is defined without broadening into Gradle/app build work.
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
- CP-015 post-metadata dependency-blocker checkpoint definition
- CP-015 post-metadata dependency-blocker execution report
- CP-016 sing-box alignment-test checkpoint definition
- CP-016 sing-box alignment-test execution report
- CP-017 sing-box baseline-persistence checkpoint definition
- CP-017 sing-box baseline-persistence execution report
- Materialized external source dependencies (`android/libneko/`, `android/sing-box/`)
- Intentional local `android/sing-box` baseline on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
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
Create CP-018 only to define the first bounded continuation checkpoint after transient `libcore.aar` production under the persisted `android/sing-box` baseline, without revisiting the cleared metadata bridge or expanding into broad Gradle/app build work.

## RISK_NOTES
The main risk at this stage is scope drift from bounded blocker repair into unbounded build experimentation or implementation.
CP-013 proved that the generated `src-android-*` roots are intentionally copied from generated `gobind` sources only, so the current blocker is a missing generated module bridge for import path `libcore`, not merely a missing copied `libcore/` directory.
CP-014 proved that the metadata-bridge repair surface is sufficient to clear the exact bare `libcore` import and preserve the original `golang.org/x/mobile` baseline in generated `src-android-*`.
CP-015 proved that the next blocker is primarily a revision/layout mismatch in the current local `android/sing-box/` checkout. The fork build scripts expect `aed32ee3066cdbc7d471e3e0415c5134088962df`, while the local checkout remains at `ab23e111dda5f9ee66fca2d49cb28f39d41192bb` on branch `def`.
CP-015 also proved that the current unresolved `github.com/sagernet/cloudflare-tls` revision is real in the drifted local `android/sing-box/` checkout, but that edge is absent from the fork-pinned `sing-box` snapshot and is therefore not the first repair surface to isolate.
CP-016 proved that the reversible `android/sing-box` alignment test alone clears both blocker symptoms and does not surface a new meaningful blocker within the same bounded `libcore` validation path.
CP-017 then persisted that same validated `android/sing-box` alignment on local branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df` and confirmed that the persisted baseline still clears both blocker symptoms within the same bounded `libcore` validation surface.
Version drift remains a risk at the tool-build layer because the isolated repaired `gomobile-matsuri` binary still rebuilt under `go1.24.0`, but the generated workspace itself no longer drifted to `go1.25.x`.
The disposable CP-017 validation workspace was removed after evidence capture, so the default installed `gomobile-matsuri` path remains unchanged.
The current local `android/sing-box` checkout is now intentionally persisted on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`; continuity will degrade if that local branch is changed without updating checkpoint artifacts.
`JAVA_HOME` and `ANDROID_HOME` are not persisted to the system environment and must be set per-session.
If future work starts Android product implementation, per-app routing, transport logic, or broad build repair before CP-018 is defined and approved, continuity and checkpoint discipline will degrade.

## OWNER_DECISION_LOG
- The project is personal, research-oriented, and not aimed at app store deployment first.
- Android-first path is accepted.
- NekoBox fork direction is accepted.
- NaiveProxy-centered transport direction is accepted.
- Per-app routing on Android is a mandatory product capability.
