# PROJECT_STATE

## PROJECT_ID
adaptive-mobile-network-lab

## CURRENT_PHASE
Repository bootstrap, governance anchoring, repository execution-surface bootstrap, server baseline definition, Android fork baseline definition, Android local build baseline definition, Android fork intake and patch workflow baseline, upstream fork snapshot materialization, initial Android build verification, Android build-prerequisite bootstrap, the first Android build attempt, libcore gomobile blocker diagnosis, CP-012 repair-checkpoint definition, CP-012 isolated repair validation, CP-013 diagnosis-checkpoint definition, CP-013 blocker diagnosis execution, CP-014 metadata-bridge repair-checkpoint definition, CP-014 metadata-bridge repair execution, CP-015 post-metadata dependency-blocker checkpoint definition, CP-015 post-metadata dependency-blocker execution, CP-016 sing-box alignment-test checkpoint definition, CP-016 sing-box alignment-test execution, CP-017 sing-box baseline-persistence checkpoint definition, CP-017 sing-box baseline-persistence execution, CP-018 post-libcore continuation checkpoint definition, CP-018 post-libcore continuation checkpoint execution, CP-019 post-kotlin continuation checkpoint definition, CP-019 post-kotlin continuation checkpoint execution, CP-020 post-javac continuation checkpoint definition, CP-020 post-javac continuation checkpoint execution, CP-021 post-compile-jar continuation checkpoint definition, CP-021 post-compile-jar continuation checkpoint execution, CP-022 post-runtime-jar continuation checkpoint definition, CP-022 post-runtime-jar continuation checkpoint execution, and CP-023 post-dex continuation checkpoint definition are complete.
CP-023 post-dex continuation checkpoint execution is partial, CP-024 post-merge-project-dex continuation checkpoint definition and execution are complete, CP-025 post-merge-ext-dex continuation checkpoint definition and execution are complete, CP-026 post-merge-lib-dex continuation checkpoint definition and execution are complete, CP-027 post-process-java-res continuation checkpoint definition and execution are complete, CP-028 post-merged-java-res continuation checkpoint definition and execution are complete, CP-029 post-merged-jni-libs continuation checkpoint definition and execution are complete, CP-030 post-merged-native-libs continuation checkpoint definition and execution are complete, CP-031 post-stripped-native-libs continuation checkpoint definition and execution are complete, CP-032 post-validate-signing continuation checkpoint definition is complete while CP-032 execution is partial, CP-033 post-package-boundary-correction checkpoint definition and execution are complete, CP-034 post-APK-verification continuation checkpoint definition and execution are complete, CP-035 post-install-verification continuation checkpoint definition and execution are complete, CP-036 post-launch-process-verification checkpoint definition and execution are complete, CP-037 post-process-verification continuation checkpoint definition and execution are complete, CP-038 post-foreground-state continuation checkpoint definition is complete while CP-038 execution is partial, CP-039 post-focus-boundary-correction checkpoint definition and execution are complete, CP-040 post-focus-verification continuation checkpoint definition and execution are complete, CP-041 post-resumed-task service-state continuation checkpoint definition and execution are complete, CP-042 post-service interface-state continuation checkpoint definition is complete while retry execution is blocked, CP-043 persistence-with-reporting continuation checkpoint definition is complete while retry execution remains blocked (environment-limited) at explicit stabilization gate, and CP-044 adb-environment recovery preconditions checkpoint definition is complete while execution is pending.
The repository is operating under a checkpoint-driven workflow with documented local, server, and Android bootstrap guidance.
The next eligible work is to execute CP-044 only in bounded host-side scope.

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
CP-039 now defines the smallest bounded boundary-correction continuation after that partial result, replacing the focus/window probe surface with `dumpsys window | grep -m 1 -E 'mCurrentFocus|mFocusedApp'` while preserving strict no-UI/no-runtime-debug scope.
CP-039 execution then proved that the bounded replacement probe succeeds with deterministic focus signal `mCurrentFocus=... moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity` and `EXIT_CODE: 0`.
CP-040 now defines the next smallest bounded continuation after successful focus/window verification as one resumed-task verification probe (`dumpsys activity activities | grep -m 1 -E 'topResumedActivity=.* t[0-9]+'`), explicitly separated from UI interaction, network activity, and runtime-debugging flows.
CP-040 execution now revalidated prerequisites under recovered device state (`emulator-5554`, `device`, ABI `x86_64`) and executed the single bounded resumed-task probe once.
CP-040 captured first exact meaningful success outcome:
- `topResumedActivity=ActivityRecord{71196b7 u0 moe.nb4a.debug/io.nekohasekai.sagernet.ui.MainActivity t11}`
CP-040 required success signals were satisfied (`topResumedActivity=`, package/activity match, task token `t11`, and `EXIT_CODE: 0`).
CP-041 now defines the next smallest bounded continuation after resumed-task success as one service-state verification probe based on `dumpsys activity services`.
CP-041 execution then revalidated prerequisites, executed one bounded probe once, and stopped at first exact probe failure:
- `CP-041 probe failed: grep: bad regex 'ServiceRecord\\{.*moe\\.nb4a\\.debug/.+': repetition-operator operand invalid`
CP-041 retry execution then used corrected probe syntax, revalidated prerequisites, executed one bounded probe once, and stopped at first exact toolchain error:
- `CP-041 retry probe failed: adb.exe : Failed to write while dumping service activity: Broken pipe`
CP-041 re-retry execution then kept the same corrected syntax and bounded scope, but captured the same first exact transient adb toolchain error:
- `CP-041 re-retry probe failed: adb.exe : Failed to write while dumping service activity: Broken pipe`
CP-041 re-retry-2 execution then repeated the same transient adb toolchain error on the single bounded probe:
- `CP-041 re-retry-2 probe failed: adb.exe : Failed to write while dumping service activity: Broken pipe`
CP-041 is now explicitly environment-limited for this session due third consecutive transient `Broken pipe` in retry-stage runs.
CP-041 re-retry-3 execution then passed explicit stabilization gate (`adb kill-server`, `adb start-server`, wait 5s, single online `emulator-5554`, ABI `x86_64`) and still captured the same first exact transient adb toolchain error on the single bounded probe:
- `CP-041 re-retry-3 probe failed: adb.exe : Failed to write while dumping service activity: Broken pipe`
CP-041 is now persistently environment-limited in this session due fourth consecutive transient `Broken pipe` in retry-stage runs.
CP-041 re-retry-4 execution then kept the same bounded service-state scope, revalidated stabilization/prerequisites, and captured required success signals without transport error on probe output:
- `CP-041 re-retry-4 probe success:   * ServiceRecord{a8a5dec u0 moe.nb4a.debug/androidx.room.MultiInstanceInvalidationService c:moe.nb4a.debug}`
- `EXIT_CODE: 0`
CP-041 execution is now complete.
CP-042 is now authored as a definition-only checkpoint for the next bounded post-service surface:
- bounded tunnel-interface presence verification via `ip link show | grep -E 'tun|tap'`
- execution remains pending by design
CP-042 execution then revalidated prerequisites and stopped at first exact prerequisite failure before probe entry:
- `CP-042 prerequisite failed: expected exactly one online adb target, found 0`
CP-042 retry then applied explicit device-recovery verification and stopped immediately at the gate:
- `CP-042 retry blocked: expected exactly one online adb target with state device, found 0`
CP-042 is now blocked pending adb device-state recovery (exactly one online target with ABI `x86_64`).
CP-043 is now authored as a definition-only checkpoint that standardizes prospective persistence-with-reporting behavior for CP-043 and all future checkpoints:
- bounded recovery cycle discipline (`max 5`) with one retry probe per cycle
- explicit `environment-limited` blocked-state requirement when cycles are exhausted
- mandatory completion narrative requirement on recovered success
- no retroactive rewrite of prior checkpoint outcomes
CP-043 execution then validated the bounded persistence-with-reporting rule using `adb devices -l` as the single bounded validation probe, ran all 5 allowed recovery cycles, and remained blocked:
- first exact meaningful outcome: `expected exactly one online adb target with state device, found 0`
- explicit `environment-limited` flag: `true`
- execution artifact created: `docs/android/ANDROID_PERSISTENCE_WITH_REPORTING_RULE.md`
CP-043 retry then executed explicit stabilization gate first (`adb kill-server`, `adb start-server`, wait 5s) and remained blocked before cycle entry:
- first exact meaningful outcome: `expected exactly one online target with device state, found 0`
- explicit `environment-limited` flag: `true`
- retry evidence captured under `cp043_retry_*` logs
CP-044 is now authored as a definition-only checkpoint for the next exact bounded continuation surface:
- host-side adb-environment recovery preconditions only
- one bounded host-side readiness probe (`emulator -list-avds` or `adb devices -l`)
- strict separation from device-side checkpoint execution and host mutation actions
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
- CP-039 post-focus-boundary-correction checkpoint definition
- CP-039 post-focus-boundary-correction checkpoint execution report
- CP-040 post-focus-verification continuation checkpoint definition
- CP-040 post-focus-verification continuation checkpoint execution report (complete)
- CP-040 execution evidence logs (`cp040_adb_devices.log`, `cp040_prereq_checks.log`, `cp040_probe.log`)
- CP-041 post-resumed-task service-state continuation checkpoint definition
- CP-041 post-resumed-task service-state continuation checkpoint execution report (`complete`)
- CP-041 execution evidence logs (`cp041_adb_devices.log`, `cp041_prereq_checks.log`, `cp041_probe.log`, `cp041_probe.clean.log`)
- CP-041 retry evidence logs (`cp041_retry_adb_devices.log`, `cp041_retry_prereq_checks.log`, `cp041_retry_probe.log`, `cp041_retry_probe.clean.log`)
- CP-041 re-retry evidence logs (`cp041_reretry_adb_devices.log`, `cp041_reretry_prereq_checks.log`, `cp041_reretry_probe.log`, `cp041_reretry_probe.clean.log`)
- CP-041 re-retry-2 evidence logs (`cp041_reretry2_adb_devices.log`, `cp041_reretry2_prereq_checks.log`, `cp041_reretry2_probe.log`, `cp041_reretry2_probe.clean.log`)
- CP-041 re-retry-3 evidence logs (`cp041_reretry3_adb_stabilization.log`, `cp041_reretry3_adb_devices.log`, `cp041_reretry3_prereq_checks.log`, `cp041_reretry3_probe.log`, `cp041_reretry3_probe.clean.log`)
- CP-041 re-retry-4 evidence logs (`cp041_reretry4_adb_stabilization.log`, `cp041_reretry4_adb_devices.log`, `cp041_reretry4_prereq_checks.log`, `cp041_reretry4_probe.log`, `cp041_reretry4_probe.clean.log`)
- CP-042 post-service interface-state continuation checkpoint definition (`checkpoints/CP-042.md`)
- CP-042 execution artifact (`docs/android/ANDROID_POST_SERVICE_INTERFACE_VERIFICATION.md`)
- CP-042 execution evidence logs (`cp042_adb_devices.log`, `cp042_prereq_checks.log`)
- CP-042 retry device-gate evidence log (`cp042_retry_adb_devices.log`)
- CP-043 persistence-with-reporting continuation checkpoint definition (`checkpoints/CP-043.md`)
- CP-043 execution artifact (`docs/android/ANDROID_PERSISTENCE_WITH_REPORTING_RULE.md`)
- CP-043 execution evidence logs (`cp043_recovery_actions.log`, `cp043_cycle_1_adb_devices.log`, `cp043_cycle_1_probe.log`, `cp043_cycle_2_adb_devices.log`, `cp043_cycle_2_probe.log`, `cp043_cycle_3_adb_devices.log`, `cp043_cycle_3_probe.log`, `cp043_cycle_4_adb_devices.log`, `cp043_cycle_4_probe.log`, `cp043_cycle_5_adb_devices.log`, `cp043_cycle_5_probe.log`)
- CP-043 retry stabilization-gate evidence log (`cp043_retry_stabilization_gate.log`)
- CP-043 retry recovery transcript (`cp043_retry_recovery_actions.log`)
- CP-043 retry per-cycle evidence logs (`cp043_retry_cycle_1_adb_devices.log`, `cp043_retry_cycle_1_probe.log`, `cp043_retry_cycle_2_adb_devices.log`, `cp043_retry_cycle_2_probe.log`, `cp043_retry_cycle_3_adb_devices.log`, `cp043_retry_cycle_3_probe.log`, `cp043_retry_cycle_4_adb_devices.log`, `cp043_retry_cycle_4_probe.log`, `cp043_retry_cycle_5_adb_devices.log`, `cp043_retry_cycle_5_probe.log`)
- CP-044 adb-environment recovery preconditions checkpoint definition (`checkpoints/CP-044.md`)
- CP-040 retry evidence logs (`cp040_retry_adb_devices.log`, `cp040_retry_prereq_checks.log`, `cp040_retry_probe.log`)
- CP-040 re-retry device-gate evidence log (`cp040_reretry_adb_devices.log`)
- CP-040 re-retry-2 device-gate evidence log (`cp040_reretry2_adb_devices.log`)
- CP-040 re-retry-3 device-gate evidence log (`cp040_reretry3_adb_devices.log`)
- Materialized external source dependencies (`android/libneko/`, `android/sing-box/`)
- Intentional local `android/sing-box` baseline on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`
- `android/fork/local.properties` for SDK path resolution
- Installed JDK 17, Android SDK (platform 35, Build Tools 35.0.1, NDK 25.0.8775105), Go 1.23.6, gomobile-matsuri, gobind-matsuri
- Cached Gradle 8.10.2 wrapper distribution

## WHAT_DOES_NOT_EXIST_YET
- Local patches against fork content (requires a post-build-verification checkpoint)
- A persisted default-environment repair for the libcore gomobile path
- Successful CP-042 interface-state verification evidence (`tun|tap` with `UP` and `EXIT_CODE: 0`)
- Successful CP-043 rule-validation completion evidence (exactly one online adb target with state `device`, ABI `x86_64`, and bounded cycle success)
- CP-044 execution artifact (`docs/android/ANDROID_ADB_ENVIRONMENT_RECOVERY_PRECONDITIONS.md`)

## EXECUTION_RULE
From this point forward, all work must begin from a checkpoint file.
Each checkpoint must be small, bounded, and end with an updated handoff section.

## NEXT_REQUIRED_ACTION
Execute CP-044 only: verify host-side prerequisites, run one bounded host-side readiness probe, capture first exact meaningful outcome, and stop.

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
Continuity will degrade if future work skips CP-042 retry discipline and jumps directly into UI interaction, runtime debugging, network actions, or broad `assemble*` work.
CP-038 execution proved that the authored `dumpsys window windows | grep -m 1 -E 'mCurrentFocus|mFocusedApp'` probe did not return deterministic focus-state success signals on this emulator session (`EXIT_CODE: 1`) even while process and foreground continuity remained healthy.
CP-039 execution proved that the bounded replacement probe `dumpsys window | grep -m 1 -E 'mCurrentFocus|mFocusedApp'` returns deterministic focus-state success signals (`mCurrentFocus` with package/activity and `EXIT_CODE: 0`) in this environment.
CP-040 execution is now complete with bounded resumed-task verification success captured under recovered device state.
Version drift remains a risk at the tool-build layer because the isolated repaired `gomobile-matsuri` binary still rebuilt under `go1.24.0`, but the generated workspace itself no longer drifted to `go1.25.x`.
The disposable CP-017, CP-018, and CP-019 validation workspaces were removed after evidence capture, so the default installed `gomobile-matsuri` path remains unchanged.
The current local `android/sing-box` checkout is now intentionally persisted on branch `cp017-local-baseline` at `aed32ee3066cdbc7d471e3e0415c5134088962df`; continuity will degrade if that local branch is changed without updating checkpoint artifacts.
CP-018 intentionally proved the Kotlin compile consumer surface only; continuity will degrade if future work skips checkpoint definition for the next downstream surface and jumps into `assemble*`, packaging, or repair work first.
`JAVA_HOME` and `ANDROID_HOME` are not persisted to the system environment and must be set per-session.
If future work starts Android product implementation, per-app routing, transport logic, or broad build repair before CP-042 is completed in bounded scope, continuity and checkpoint discipline will degrade.

## OWNER_DECISION_LOG
- The project is personal, research-oriented, and not aimed at app store deployment first.
- Android-first path is accepted.
- NekoBox fork direction is accepted.
- NaiveProxy-centered transport direction is accepted.
- Per-app routing on Android is a mandatory product capability.



