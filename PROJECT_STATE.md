# PROJECT_STATE

## PROJECT_ID
adaptive-mobile-network-lab

## CURRENT_PHASE
Repository bootstrap, governance anchoring, repository execution-surface bootstrap, server baseline definition, Android fork baseline definition, Android local build baseline definition, Android fork intake and patch workflow baseline, upstream fork snapshot materialization, initial Android build verification, Android build-prerequisite bootstrap, the first Android build attempt, libcore gomobile blocker diagnosis, CP-012 repair-checkpoint definition, CP-012 isolated repair validation, CP-013 diagnosis-checkpoint definition, CP-013 blocker diagnosis execution, CP-014 metadata-bridge repair-checkpoint definition, CP-014 metadata-bridge repair execution, CP-015 post-metadata dependency-blocker checkpoint definition, CP-015 post-metadata dependency-blocker execution, CP-016 sing-box alignment-test checkpoint definition, CP-016 sing-box alignment-test execution, CP-017 sing-box baseline-persistence checkpoint definition, CP-017 sing-box baseline-persistence execution, CP-018 post-libcore continuation checkpoint definition, CP-018 post-libcore continuation checkpoint execution, CP-019 post-kotlin continuation checkpoint definition, CP-019 post-kotlin continuation checkpoint execution, CP-020 post-javac continuation checkpoint definition, CP-020 post-javac continuation checkpoint execution, CP-021 post-compile-jar continuation checkpoint definition, CP-021 post-compile-jar continuation checkpoint execution, CP-022 post-runtime-jar continuation checkpoint definition, CP-022 post-runtime-jar continuation checkpoint execution, and CP-023 post-dex continuation checkpoint definition are complete.
CP-023 post-dex continuation checkpoint execution is partial, CP-024 post-merge-project-dex continuation checkpoint definition and execution are complete, CP-025 post-merge-ext-dex continuation checkpoint definition and execution are complete, CP-026 post-merge-lib-dex continuation checkpoint definition and execution are complete, CP-027 post-process-java-res continuation checkpoint definition and execution are complete, CP-028 post-merged-java-res continuation checkpoint definition and execution are complete, CP-029 post-merged-jni-libs continuation checkpoint definition and execution are complete, CP-030 post-merged-native-libs continuation checkpoint definition and execution are complete, CP-031 post-stripped-native-libs continuation checkpoint definition and execution are complete, CP-032 post-validate-signing continuation checkpoint definition is complete while CP-032 execution is partial, CP-033 post-package-boundary-correction checkpoint definition and execution are complete, CP-034 post-APK-verification continuation checkpoint definition and execution are complete, CP-035 post-install-verification continuation checkpoint definition and execution are complete, CP-036 post-launch-process-verification checkpoint definition and execution are complete, CP-037 post-process-verification continuation checkpoint definition and execution are complete, and CP-038 post-foreground-state continuation checkpoint definition is complete while CP-038 execution is partial.
The repository is operating under a checkpoint-driven workflow with documented local, server, and Android bootstrap guidance.
The next eligible work is to create CP-039 only.

## CONFIRMED_FOUNDATIONS
The repository exists and is pushed.
The following bootstrap files are assumed to exist and remain authoritative:
- docs/bootstrap/01_LLM_OPERATING_CONTRACT.md
- docs/bootstrap/02_LLM_CHECKPOINT_PROTOCOL.md
- docs/bootstrap/03_OWNER_PROJECT_MAP.md

## CURRENT_OBJECTIVE
Preserve all baselines created through CP-017 execution, CP-018 execution, CP-019 execution, and CP-020 execution, plus the existing CP-014 metadata-bridge repair artifact.
CP-015 proved that the first post-CP-014 blocker is primarily a revision/layout mismatch in the local `android/sing-box/` checkout, and that the current `cloudflare-tls` failure belongs to that drifted checkout rather than the fork-pinned snapshot.
CP-016 proved that a reversible alignment of `android/sing-box` to `aed32ee3066cdbc7d471e3e0415c5134088962df` alone clears both the missing-package and `cloudflare-tls` symptoms and allows the bounded `libcore` path to proceed through transient `libcore.aar` production.
CP-017 intentionally persisted that proven `android/sing-box` alignment as the new local dependency baseline by placing the dependency on local branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`, and revalidated the same bounded `libcore` path successfully.
CP-018 now defines the first exact downstream continuation surface after transient `libcore.aar` production as the app compile consumer path entered by `.\gradlew.bat :app:compileOssDebugKotlin --stacktrace`, while keeping that probe separate from broader Gradle repair or assembly work.
CP-018 execution then proved that the first exact downstream app consumer surface accepts the transient `libcore.aar` and that `.\gradlew.bat :app:compileOssDebugKotlin --stacktrace` completes successfully under the persisted sing-box baseline.
CP-019 now defines the next exact downstream continuation surface after successful Kotlin compilation as the app Java compile consumer path entered by `.\gradlew.bat :app:compileOssDebugJavaWithJavac --stacktrace`, while keeping that probe separate from class jar merge, dexing, assemble, packaging, or repair work.
CP-019 execution then proved that the first exact downstream Java compile consumer surface also succeeds under the persisted sing-box baseline.
CP-020 now defines the next exact downstream continuation surface after successful Java compilation as the app compile-jar consumer path entered by `.\gradlew.bat :app:bundleOssDebugClassesToCompileJar --stacktrace`, while keeping that probe separate from runtime-jar merge, dexing, packaging, assemble, or repair work.
CP-020 execution then proved that the first exact downstream compile-jar consumer surface also succeeds under the persisted sing-box baseline.
CP-021 now defines the next exact downstream continuation surface after successful compile-jar merge as the app runtime-jar consumer path entered by `.\gradlew.bat :app:bundleOssDebugClassesToRuntimeJar --stacktrace`, while keeping that probe separate from dexing, packaging, assemble, or repair work.
CP-021 execution then proved that the first exact downstream runtime-jar consumer surface also succeeds under the persisted sing-box baseline.
CP-022 now defines the next exact downstream continuation surface after successful runtime-jar merge as the first dex-side app consumer path entered by `.\gradlew.bat :app:dexBuilderOssDebug --stacktrace`, while keeping that probe separate from merge-dex, packaging, install, assemble, or repair work.
CP-022 execution then proved that the first exact downstream dex-builder consumer surface also succeeds under the persisted sing-box baseline.
CP-023 now defines the next exact downstream continuation surface after successful dex-builder generation as the first merge-project-dex app consumer path entered by `.\gradlew.bat :app:mergeProjectDexOssDebug --stacktrace`, while keeping that probe separate from other merge-dex, packaging, install, assemble, or repair work.
CP-023 execution then proved that `.\gradlew.bat :app:mergeProjectDexOssDebug --stacktrace` succeeds under the persisted sing-box baseline, but it materializes output under `android/fork/app/build/intermediates/dex/ossDebug/mergeProjectDexOssDebug` rather than the authored `android/fork/app/build/intermediates/merged_project_dex/ossDebug` boundary.
CP-024 now redefines the next exact downstream continuation from that observed result as the first bounded merge-ext-dex surface entered by `.\gradlew.bat :app:mergeExtDexOssDebug --stacktrace`, while keeping that probe separate from `mergeLibDex*`, packaging, install, assemble, or repair work.
CP-024 execution then proved that `.\gradlew.bat :app:mergeExtDexOssDebug --stacktrace` succeeds under the persisted sing-box baseline and creates `android/fork/app/build/intermediates/dex/ossDebug/mergeExtDexOssDebug` while `mergeLibDex*` and APK outputs remain absent.
CP-025 now defines the next exact downstream continuation from that observed result as the first bounded merge-lib-dex surface entered by `.\gradlew.bat :app:mergeLibDexOssDebug --stacktrace`, while keeping that probe separate from packaging, install, assemble, or repair work.
CP-025 execution then proved that `.\gradlew.bat :app:mergeLibDexOssDebug --stacktrace` succeeds under the persisted sing-box baseline and creates `android/fork/app/build/intermediates/dex/ossDebug/mergeLibDexOssDebug` while APK outputs remain absent.
CP-026 now defines the next exact downstream continuation from that observed result as the first bounded packaging-adjacent surface entered by `.\gradlew.bat :app:processOssDebugJavaRes --stacktrace`, while keeping that probe separate from Java-resource merge, native-lib merge, signing, packaging, install, or assemble work.
CP-026 execution then proved that `.\gradlew.bat :app:processOssDebugJavaRes --stacktrace` succeeds under the persisted sing-box baseline and creates `android/fork/app/build/intermediates/java_res/ossDebug/processOssDebugJavaRes/out` while Java-resource merge, JNI/native merge, and APK outputs remain absent.
CP-027 now defines the next exact downstream continuation from that observed result as the first bounded Java-resource-merge surface entered by `.\gradlew.bat :app:mergeOssDebugJavaResource --stacktrace`, while keeping that probe separate from JNI/native merge, signing, packaging, install, or assemble work.
CP-027 execution then proved that `.\gradlew.bat :app:mergeOssDebugJavaResource --stacktrace` succeeds under the persisted sing-box baseline and creates `android/fork/app/build/intermediates/merged_java_res/ossDebug/mergeOssDebugJavaResource` while JNI/native merge and APK outputs remain absent.
CP-028 now defines the next exact downstream continuation from that observed result as the first bounded JNI-libs-merge surface entered by `.\gradlew.bat :app:mergeOssDebugJniLibFolders --stacktrace`, while keeping that probe separate from native-lib merge, signing, packaging, install, or assemble work.
CP-028 execution then proved that `.\gradlew.bat :app:mergeOssDebugJniLibFolders --stacktrace` succeeds under the persisted sing-box baseline and creates `android/fork/app/build/intermediates/merged_jni_libs/ossDebug/mergeOssDebugJniLibFolders` while native-lib/signing/packaging/install/assemble outputs remain absent.
CP-029 now defines the next exact downstream continuation from that observed result as the first bounded native-libs-merge surface entered by `.\gradlew.bat :app:mergeOssDebugNativeLibs --stacktrace`, while keeping that probe separate from strip/signing/packaging/install/assemble work.
CP-029 execution then proved that `.\gradlew.bat :app:mergeOssDebugNativeLibs --stacktrace` succeeds under the persisted sing-box baseline and creates `android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out` while strip/signing/packaging/install/assemble outputs remain absent.
CP-030 defined the next exact downstream continuation from that observed result as the first bounded native-strip surface entered by `.\gradlew.bat :app:stripOssDebugDebugSymbols --stacktrace`, while keeping that probe separate from signing/packaging/install/assemble work.
CP-030 execution then proved that `.\gradlew.bat :app:stripOssDebugDebugSymbols --stacktrace` succeeds under the persisted sing-box baseline, creates `android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out`, and still leaves APK output paths absent.
CP-031 defined the next exact downstream continuation from that observed result as the first bounded signing-validation surface entered by `.\gradlew.bat :app:validateSigningOssDebug --stacktrace`, while keeping that probe separate from packaging/install/assemble work.
CP-031 execution then proved that `.\gradlew.bat :app:validateSigningOssDebug --stacktrace` succeeds under the persisted sing-box baseline with expected validation success signals while APK output paths remain absent.
CP-032 now defines the next exact downstream continuation from that observed result as the first bounded packaging-stage surface entered by `.\gradlew.bat :app:packageOssDebug --stacktrace`, while keeping that probe separate from install/assemble work.
CP-032 execution then proved that `.\gradlew.bat :app:packageOssDebug --stacktrace` succeeds under the persisted sing-box baseline, but the authored CP-032 boundary assumptions were invalidated: `android/fork/app/build/intermediates/apk/oss/debug` remained absent while `android/fork/app/build/outputs/apk/oss/debug` was materialized.
CP-033 now redefines that boundary to the observed APK output location `android/fork/app/build/outputs/apk/oss/debug`, explicitly confirms that CP-032 already crossed first APK materialization, and bounds the next continuation to APK verification only.
CP-033 execution then proved that the bounded `apksigner verify` probe succeeds for `android/fork/app/build/outputs/apk/oss/debug/NekoBox-1.4.2-x86_64-debug.apk`, while out-of-scope install/release/bundle/androidTest paths remain absent.
CP-034 now defines the next smallest bounded continuation after successful APK verification as one install-verification probe, explicitly separated from launch/runtime continuation.
CP-034 execution now confirms successful bounded install verification with already-observed evidence:
- exactly one online adb target exists
- target ABI is `x86_64`
- install output includes `Performing Streamed Install` and `Success`
- package `moe.nb4a.debug` is installed on device
CP-035 now defines the next smallest bounded continuation after successful install verification as one launch-verification probe, explicitly separated from runtime debugging and interaction testing.
CP-035 execution retry (`retry3`) verified prerequisites and captured bounded launch success signals via CLI (`Status: ok`, `Activity: moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity`, `Complete`, `EXIT_CODE: 0`).
CP-036 now defines the next smallest bounded continuation after successful launch verification as one process-alive probe (`adb shell pidof moe.nb4a.debug`), explicitly separated from interaction and runtime-debugging flows.
CP-036 execution then proved bounded process-alive verification succeeds with numeric `pidof` output and `EXIT_CODE: 0`.
CP-037 now defines the next smallest bounded continuation after successful process verification as one foreground activity/state verification probe, explicitly separated from UI interaction and runtime-debugging flows.
CP-037 execution then proved bounded foreground-state verification succeeds with `topResumedActivity` pointing to `moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity` and `EXIT_CODE: 0`.
CP-038 now defines the next smallest bounded continuation after successful foreground-state verification as one window-focus verification probe (`dumpsys window windows | grep -m 1 -E 'mCurrentFocus|mFocusedApp'`), explicitly separated from UI interaction and runtime-debugging flows.
CP-038 execution then proved prerequisites pass but the bounded probe returns empty output with `EXIT_CODE: 1`, so focus-state success signals were not captured while fallback continuity signals (`topResumedActivity`, `pidof`, `pm path`) remained healthy.
The next step is to create CP-039 only as a bounded boundary-correction definition for post-foreground-state focus verification.
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
- CP-018 post-libcore continuation checkpoint definition
- CP-018 post-libcore continuation execution report
- CP-019 post-kotlin continuation checkpoint definition
- CP-019 post-kotlin continuation execution report
- CP-020 post-javac continuation checkpoint definition
- CP-020 post-javac continuation execution report
- CP-021 post-compile-jar continuation checkpoint definition
- CP-021 post-compile-jar continuation execution report
- CP-022 post-runtime-jar continuation checkpoint definition
- CP-022 post-runtime-jar continuation execution report
- CP-023 post-dex continuation checkpoint definition
- CP-023 post-dex continuation execution report
- CP-024 post-merge-project-dex continuation checkpoint definition
- CP-024 post-merge-project-dex continuation execution report
- CP-025 post-merge-ext-dex continuation checkpoint definition
- CP-025 post-merge-ext-dex continuation execution report
- CP-026 post-merge-lib-dex continuation checkpoint definition
- CP-026 post-merge-lib-dex continuation execution report
- CP-027 post-process-java-res continuation checkpoint definition
- CP-027 post-process-java-res continuation execution report
- CP-028 post-merged-java-res continuation checkpoint definition
- CP-028 post-merged-java-res continuation execution report
- CP-029 post-merged-jni-libs continuation checkpoint definition
- CP-029 post-merged-jni-libs continuation execution report
- CP-030 post-merged-native-libs continuation checkpoint definition
- CP-030 post-merged-native-libs continuation execution report
- CP-031 post-stripped-native-libs continuation checkpoint definition
- CP-031 post-stripped-native-libs continuation execution report
- CP-032 post-validate-signing continuation checkpoint definition
- CP-032 post-validate-signing continuation execution report
- CP-033 post-package-boundary-correction checkpoint definition
- CP-033 post-package-boundary-correction checkpoint execution report
- CP-034 post-APK-verification continuation checkpoint definition
- CP-034 post-APK-verification continuation checkpoint execution report
- CP-035 post-install-verification continuation checkpoint definition
- CP-035 post-install-verification continuation execution report
- CP-036 post-launch-process-verification checkpoint definition
- CP-036 post-launch-process-verification checkpoint execution report
- CP-037 post-process-verification continuation checkpoint definition
- CP-037 post-process-verification continuation checkpoint execution report
- CP-038 post-foreground-state continuation checkpoint definition
- CP-038 post-foreground-state continuation checkpoint execution report
- Materialized external source dependencies (`android/libneko/`, `android/sing-box/`)
- Intentional local `android/sing-box` baseline on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- `android/fork/local.properties` for SDK path resolution
- Installed JDK 17, Android SDK (platform 35, Build Tools 35.0.1, NDK 25.0.8775105), Go 1.23.6, gomobile-matsuri, gobind-matsuri
- Cached Gradle 8.10.2 wrapper distribution

## WHAT_DOES_NOT_EXIST_YET
- CP-039 checkpoint definition for bounded post-CP-038 focus-surface boundary correction
- Local patches against fork content (requires a post-build-verification checkpoint)
- A persisted default-environment repair for the libcore gomobile path

## EXECUTION_RULE
From this point forward, all work must begin from a checkpoint file.
Each checkpoint must be small, bounded, and end with an updated handoff section.

## NEXT_REQUIRED_ACTION
Create CP-039 only to define the smallest bounded continuation after CP-038 partial execution, correcting the focus/window-state probe boundary without entering UI interaction, runtime debugging, network actions, or feature work.

## RISK_NOTES
The main risk at this stage is scope drift from bounded blocker repair into unbounded build experimentation or implementation.
CP-013 proved that the generated `src-android-*` roots are intentionally copied from generated `gobind` sources only, so the current blocker is a missing generated module bridge for import path `libcore`, not merely a missing copied `libcore/` directory.
CP-014 proved that the metadata-bridge repair surface is sufficient to clear the exact bare `libcore` import and preserve the original `golang.org/x/mobile` baseline in generated `src-android-*`.
CP-015 proved that the next blocker is primarily a revision/layout mismatch in the current local `android/sing-box/` checkout. The fork build scripts expect `aed32ee3066cdbc7d471e3e0415c5134088962df`, while the local checkout remains at `ab23e111dda5f9ee66fca2d49cb28f39d41192bb` on branch `def`.
CP-015 also proved that the current unresolved `github.com/sagernet/cloudflare-tls` revision is real in the drifted local `android/sing-box/` checkout, but that edge is absent from the fork-pinned `sing-box` snapshot and is therefore not the first repair surface to isolate.
CP-016 proved that the reversible `android/sing-box` alignment test alone clears both blocker symptoms and does not surface a new meaningful blocker within the same bounded `libcore` validation path.
CP-017 then persisted that same validated `android/sing-box` alignment on local branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df` and confirmed that the persisted baseline still clears both blocker symptoms within the same bounded `libcore` validation surface.
CP-018 then proved that the first downstream app compile consumer surface is not the next blocker: the bounded `.\gradlew.bat :app:compileOssDebugKotlin --stacktrace` probe completed successfully.
CP-019 then proved that the first downstream Java compile consumer surface is also not the next blocker: the bounded `.\gradlew.bat :app:compileOssDebugJavaWithJavac --stacktrace` probe completed successfully.
CP-020 then proved that the first downstream compile-jar consumer surface is also not the next blocker: the bounded `.\gradlew.bat :app:bundleOssDebugClassesToCompileJar --stacktrace` probe completed successfully.
CP-021 then proved that the first downstream runtime-jar consumer surface is also not the next blocker: the bounded `.\gradlew.bat :app:bundleOssDebugClassesToRuntimeJar --stacktrace` probe completed successfully.
CP-022 now defines the next exact downstream dex-side continuation surface as the bounded `.\gradlew.bat :app:dexBuilderOssDebug --stacktrace` probe aligned with the still-absent `android/fork/app/build/intermediates/project_dex_archive/ossDebug` output family.
CP-022 then proved that the first downstream dex-builder consumer surface is also not the next blocker: the bounded `.\gradlew.bat :app:dexBuilderOssDebug --stacktrace` probe completed successfully and created `android/fork/app/build/intermediates/project_dex_archive/ossDebug`.
CP-023 now defines the next exact downstream merge-project-dex continuation surface as the bounded `.\gradlew.bat :app:mergeProjectDexOssDebug --stacktrace` probe aligned with the still-absent `android/fork/app/build/intermediates/merged_project_dex/ossDebug` output family.
CP-023 execution then proved that `.\gradlew.bat :app:mergeProjectDexOssDebug --stacktrace` succeeds, but it writes directly into `android/fork/app/build/intermediates/dex/ossDebug/mergeProjectDexOssDebug` and does not create `android/fork/app/build/intermediates/merged_project_dex/ossDebug`.
CP-024 now redefines the next exact downstream merge-dex continuation surface as the bounded `.\gradlew.bat :app:mergeExtDexOssDebug --stacktrace` probe aligned with the still-absent `android/fork/app/build/intermediates/dex/ossDebug/mergeExtDexOssDebug` output family.
CP-024 execution then proved that `.\gradlew.bat :app:mergeExtDexOssDebug --stacktrace` succeeds and creates `android/fork/app/build/intermediates/dex/ossDebug/mergeExtDexOssDebug` while `android/fork/app/build/intermediates/dex/ossDebug/mergeLibDexOssDebug` and `android/fork/app/build/outputs/apk/` still remain absent.
CP-025 now redefines the next exact downstream merge-dex continuation surface as the bounded `.\gradlew.bat :app:mergeLibDexOssDebug --stacktrace` probe aligned with the still-absent `android/fork/app/build/intermediates/dex/ossDebug/mergeLibDexOssDebug` output family.
CP-025 execution then proved that `.\gradlew.bat :app:mergeLibDexOssDebug --stacktrace` succeeds and creates `android/fork/app/build/intermediates/dex/ossDebug/mergeLibDexOssDebug` while `android/fork/app/build/outputs/apk/` still remains absent.
CP-026 now redefined the next exact downstream continuation surface as the bounded `.\gradlew.bat :app:processOssDebugJavaRes --stacktrace` probe aligned with the then-still-absent `android/fork/app/build/intermediates/java_res/ossDebug/processOssDebugJavaRes/out` output family.
CP-026 execution then proved that `.\gradlew.bat :app:processOssDebugJavaRes --stacktrace` succeeds and creates `android/fork/app/build/intermediates/java_res/ossDebug/processOssDebugJavaRes/out` while `android/fork/app/build/intermediates/merged_java_res/ossDebug/mergeOssDebugJavaResource` and APK outputs remain absent.
CP-027 now redefines the next exact downstream continuation surface as the bounded `.\gradlew.bat :app:mergeOssDebugJavaResource --stacktrace` probe aligned with the still-absent `android/fork/app/build/intermediates/merged_java_res/ossDebug/mergeOssDebugJavaResource` output family.
CP-027 execution then proved that `.\gradlew.bat :app:mergeOssDebugJavaResource --stacktrace` succeeds and creates `android/fork/app/build/intermediates/merged_java_res/ossDebug/mergeOssDebugJavaResource` while `android/fork/app/build/intermediates/merged_jni_libs/ossDebug/mergeOssDebugJniLibFolders` and APK outputs remain absent.
CP-028 now redefined the next exact downstream continuation surface as the bounded `.\gradlew.bat :app:mergeOssDebugJniLibFolders --stacktrace` probe aligned with the previously still-absent `android/fork/app/build/intermediates/merged_jni_libs/ossDebug/mergeOssDebugJniLibFolders` output family. CP-028 execution then proved that surface succeeds and materializes that output family while broader downstream families remain absent.
CP-029 now redefined the next exact downstream continuation surface as the bounded `.\gradlew.bat :app:mergeOssDebugNativeLibs --stacktrace` probe aligned with the previously still-absent `android/fork/app/build/intermediates/merged_native_libs/ossDebug/mergeOssDebugNativeLibs/out` output family. CP-029 execution then proved that surface succeeds and materializes that output family while broader downstream families remain absent.
CP-030 execution proved that the bounded `.\gradlew.bat :app:stripOssDebugDebugSymbols --stacktrace` probe now succeeds and materializes `android/fork/app/build/intermediates/stripped_native_libs/ossDebug/stripOssDebugDebugSymbols/out` while APK output paths remain absent.
CP-031 execution proved that the bounded `.\gradlew.bat :app:validateSigningOssDebug --stacktrace` probe now succeeds while APK output paths remain absent.
CP-032 now defines the next exact downstream continuation surface as the bounded `.\gradlew.bat :app:packageOssDebug --stacktrace` probe aligned with the still-absent `android/fork/app/build/intermediates/apk/oss/debug` output family.
CP-032 execution proved the bounded `.\gradlew.bat :app:packageOssDebug --stacktrace` surface succeeds, but with path-boundary divergence (`intermediates/apk/oss/debug` absent while `outputs/apk/oss/debug` present).
CP-033 execution then confirmed the corrected boundary and successful bounded APK verification via `apksigner`.
CP-034 now bounds the next downstream step to single-probe install verification and separates it from launch/runtime continuation.
CP-034 execution now confirms successful bounded install verification and preserves the no-launch/no-runtime boundary.
CP-035 now bounds the next downstream step to single-probe launch verification and separates it from runtime debugging and interaction testing.
CP-035 execution is now complete with required CLI launch success signals captured in bounded scope.
CP-036 now bounds the immediate post-launch surface to one process-alive probe only.
CP-036 execution is now complete with required process-alive success signals captured in bounded scope.
CP-037 now bounds the immediate post-process surface to one foreground-state verification probe only.
CP-037 execution is now complete with required foreground-state success signals captured in bounded scope.
Continuity will degrade if future work skips CP-039 checkpoint definition and jumps directly into UI interaction, runtime debugging, network actions, or broad `assemble*` work.
CP-038 execution proved that the authored `dumpsys window windows | grep -m 1 -E 'mCurrentFocus|mFocusedApp'` probe did not return deterministic focus-state success signals on this emulator session (`EXIT_CODE: 1`) even while process and foreground continuity remained healthy.
Version drift remains a risk at the tool-build layer because the isolated repaired `gomobile-matsuri` binary still rebuilt under `go1.24.0`, but the generated workspace itself no longer drifted to `go1.25.x`.
The disposable CP-017, CP-018, and CP-019 validation workspaces were removed after evidence capture, so the default installed `gomobile-matsuri` path remains unchanged.
The current local `android/sing-box` checkout is now intentionally persisted on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`; continuity will degrade if that local branch is changed without updating checkpoint artifacts.
CP-018 intentionally proved the Kotlin compile consumer surface only; continuity will degrade if future work skips checkpoint definition for the next downstream surface and jumps into `assemble*`, packaging, or repair work first.
`JAVA_HOME` and `ANDROID_HOME` are not persisted to the system environment and must be set per-session.
If future work starts Android product implementation, per-app routing, transport logic, or broad build repair before CP-039 is defined under a bounded checkpoint, continuity and checkpoint discipline will degrade.

## OWNER_DECISION_LOG
- The project is personal, research-oriented, and not aimed at app store deployment first.
- Android-first path is accepted.
- NekoBox fork direction is accepted.
- NaiveProxy-centered transport direction is accepted.
- Per-app routing on Android is a mandatory product capability.



