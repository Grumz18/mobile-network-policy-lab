# Android Initial Build Verification

## Purpose
This document records the CP-008 verification outcome for the materialized upstream NekoBox fork in `android/fork/`.
It is limited to build-entry verification, prerequisite discovery, dependency-chain mapping, and blocker documentation.
No repair work, source modification, patch application, or feature implementation was performed.

## Execution Context
- Checkpoint: `CP-008`
- Verification date: `2026-04-15`
- Repository fork snapshot: `android/fork/` at upstream commit `5768494d8ae3c74a057bb6d46c0f8dc071b0d821`
- Host shell: PowerShell on Windows

## Final Verdict
The materialized fork cannot enter a build process on the current workstation within CP-008 constraints.

The first blocking condition is the Gradle wrapper bootstrap boundary:
- the fork requires Gradle `8.10.2` via `android/fork/gradle/wrapper/gradle-wrapper.properties`
- no local wrapper distribution cache was found under `%USERPROFILE%\.gradle\wrapper\dists`
- invoking `gradlew.bat` would therefore download Gradle, which is outside CP-008 scope

Even if Gradle download were allowed, the workstation has additional hard blockers:
- only a Java 8 runtime was detected, with no `javac` compiler
- no Android SDK or Android NDK installation was detected
- no Go toolchain was detected
- `gomobile-matsuri` and `gobind-matsuri` were not installed
- the required sibling source trees `libneko` and `sing-box` are absent
- the generated bridge artifact `app/libs/libcore.aar` is absent
- the available `bash.exe` entry point fails because `/bin/bash` is unavailable, so the `libcore` shell scripts do not currently have a working POSIX runtime

## Build Dependency Chain
The upstream fork exposes the following dependency chain for a local Android build:

1. `android/fork/gradlew.bat`
   Uses `android/fork/gradle/wrapper/gradle-wrapper.jar` and `android/fork/gradle/wrapper/gradle-wrapper.properties`.

2. Gradle distribution `8.10.2`
   Declared in `android/fork/gradle/wrapper/gradle-wrapper.properties`.

3. Gradle plugin resolution
   `android/fork/buildSrc/build.gradle.kts` declares:
   - Android Gradle Plugin `8.8.1`
   - Kotlin Gradle plugin `2.0.21`

4. Android application configuration
   `android/fork/buildSrc/src/main/kotlin/Helpers.kt` and `android/fork/app/build.gradle.kts` define:
   - Build Tools `35.0.1`
   - `compileSdk = 35`
   - `targetSdk = 35`
   - `minSdk = 21`
   - application packaging and ABI splits

5. Android SDK path resolution
   The build needs either:
   - a valid `local.properties` with `sdk.dir`, or
   - Android SDK environment variables such as `ANDROID_HOME` / `ANDROID_SDK_ROOT`

6. Native bridge artifact generation for the app
   `android/fork/app/build.gradle.kts` consumes `fileTree("libs")`.
   `android/fork/libcore/build.sh` copies the generated `libcore.aar` into `android/fork/app/libs/libcore.aar`.

7. `libcore` build prerequisites
   `android/fork/libcore/build.sh`, `android/fork/libcore/init.sh`, and `android/fork/buildScript/init/env_ndk.sh` require:
   - a working POSIX shell environment
   - Go `1.23.1` with toolchain `go1.23.6`
   - `gomobile-matsuri`
   - `gobind-matsuri`
   - Android NDK `25.0.8775105` or another valid NDK path exposed through `ANDROID_NDK_HOME` / `NDK`

8. External local source dependencies for `libcore`
   `android/fork/libcore/go.mod` contains local `replace` directives for:
   - `../../libneko`
   - `../../sing-box`
   These are not Git submodules in the materialized fork, but they are submodule-style local source dependencies because the `libcore` module expects them to exist as sibling trees outside `android/fork/libcore/`.

## Verified Requirement Inventory

| Component | Required / expected state | Evidence in fork | Local state |
| --- | --- | --- | --- |
| Gradle wrapper | Present | `gradlew.bat`, wrapper JAR, wrapper properties | Present |
| Gradle distribution | `8.10.2` | `gradle-wrapper.properties` | Not cached locally |
| Android Gradle Plugin | `8.8.1` | `buildSrc/build.gradle.kts` | Not executed |
| Kotlin Gradle plugin | `2.0.21` | `buildSrc/build.gradle.kts` | Not executed |
| JDK | Full JDK compatible with Gradle `8.10.2` and AGP `8.8.1`; detected Java 8 runtime is insufficient | Gradle/AGP stack plus missing `javac` on host | Java `1.8.0_401` runtime only; `javac` missing; `JAVA_HOME` unset |
| Android SDK platform | API 35 | `compileSdk = 35`, `targetSdk = 35` | Missing |
| Android Build Tools | `35.0.1` | `buildToolsVersion = "35.0.1"` | Missing |
| Android NDK | `25.0.8775105` preferred, else valid `ANDROID_NDK_HOME` / `NDK` | `buildScript/init/env_ndk.sh` | Missing |
| Go | `go 1.23.1`, toolchain `go1.23.6` | `libcore/go.mod` | Missing |
| gomobile fork | `gomobile-matsuri` | `libcore/build.sh`, `libcore/init.sh` | Missing |
| gobind fork | `gobind-matsuri` | `libcore/build.sh`, `libcore/init.sh` | Missing |
| Git | Required by `libcore/init.sh` and general fork workflow | `libcore/init.sh` clones gomobile fork if missing | Present (`git version 2.49.0.windows.1`) |
| POSIX shell | Usable Bash environment | `libcore/*.sh`, `buildScript/init/*.sh` | Launcher exists, runtime unusable |
| `local.properties` | SDK path resolution input on Windows if env vars are absent | `Helpers.kt` reads `local.properties`; Android build also needs SDK path | Missing |
| `app/libs/libcore.aar` | Generated before app build | `libcore/build.sh` copies output here | Missing |
| `../../libneko` | Local source dependency | `libcore/go.mod` replace directive | Missing |
| `../../sing-box` | Local source dependency | `libcore/go.mod` replace directive | Missing |
| `.gitmodules` | Not required by current snapshot | no `.gitmodules` file present | Missing, but not itself a blocker |

## Local Verification Commands
The following commands were run during CP-008:

```powershell
java -version
javac -version
go version
git --version
Get-Command gomobile-matsuri,gobind-matsuri,gomobile,gobind,gradle,adb,sdkmanager
Get-Command java
Get-Command bash
where.exe javac
```

Additional file and directory checks were run for:
- environment variables: `JAVA_HOME`, `ANDROID_HOME`, `ANDROID_SDK_ROOT`, `ANDROID_NDK_HOME`, `NDK`, `GOPATH`, `GRADLE_USER_HOME`, `LOCAL_PROPERTIES`
- common Windows Android SDK directories
- `%USERPROFILE%\.gradle\wrapper\dists`
- `android/fork/local.properties`
- `android/fork/app/libs/libcore.aar`
- `android/fork/libneko`
- `android/fork/sing-box`
- `android/fork/.gitmodules`

## Observed Local State
- `JAVA_HOME` is unset.
- `ANDROID_HOME` is unset.
- `ANDROID_SDK_ROOT` is unset.
- `ANDROID_NDK_HOME` is unset.
- `NDK` is unset.
- `GOPATH` is unset.
- `GRADLE_USER_HOME` is unset.
- `LOCAL_PROPERTIES` is unset.
- `java` resolves to `C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe`.
- `java -version` reports Java `1.8.0_401`.
- `javac` is not available on `PATH`.
- `go` is not available on `PATH`.
- `gomobile-matsuri`, `gobind-matsuri`, `gomobile`, `gobind`, `gradle`, `adb`, and `sdkmanager` are not available on `PATH`.
- No Android SDK was found at `C:\Users\grUm.IGOR\AppData\Local\Android\Sdk` or `C:\Android\Sdk`.
- No Gradle wrapper cache was found under `%USERPROFILE%\.gradle\wrapper\dists`.
- `bash.exe` resolves to `C:\Windows\system32\bash.exe`, but `bash -lc 'echo BASH_OK'` fails with `execvpe(/bin/bash) failed: No such file or directory`.
- `android/fork/local.properties` is missing.
- `android/fork/app/libs/libcore.aar` is missing.
- `android/fork/libneko` is missing.
- `android/fork/sing-box` is missing.
- `android/fork/.gitmodules` is missing.

## Build-Entry Decision
No Gradle wrapper command was executed.

Reason:
- the required Gradle `8.10.2` distribution is not cached locally
- invoking `gradlew.bat` would trigger a distribution download
- downloading or installing prerequisites is outside CP-008 scope

This means the build could not be entered safely within checkpoint constraints.
The repository still has enough evidence to conclude that the current workstation is not build-ready even before wrapper execution.
The exact supported JDK version for the upstream Gradle/AGP stack was not exercised directly in CP-008 because wrapper execution would have triggered a Gradle download, but the detected Java 8 runtime is already below a usable threshold for this build.

## Blockers
Ordered from earliest to downstream:

1. Gradle wrapper bootstrap is blocked by the missing local Gradle `8.10.2` distribution cache.
2. The host has only a Java 8 runtime and no `javac`, so no usable JDK toolchain is available for this Gradle/AGP stack.
3. No Android SDK installation is present, and no SDK path is provided through `local.properties`, `ANDROID_HOME`, or `ANDROID_SDK_ROOT`.
4. No Android NDK installation is present, including the preferred `25.0.8775105` path expected by `env_ndk.sh`.
5. No Go toolchain is installed, despite `libcore/go.mod` requiring Go `1.23.1` / toolchain `go1.23.6`.
6. `gomobile-matsuri` and `gobind-matsuri` are not installed.
7. The available Bash entry point is not usable, so the `libcore` shell scripts cannot currently run.
8. The local source dependencies `../../libneko` and `../../sing-box` are absent.
9. The generated artifact `android/fork/app/libs/libcore.aar` is absent, so the Android app's `libs` input is incomplete.

## Explicit Non-Actions
The following actions were intentionally not performed in CP-008:
- no Gradle wrapper invocation that would download Gradle
- no SDK, NDK, JDK, Go, gomobile, or gobind installation
- no repository clone or dependency fetch for `libneko`, `sing-box`, or gomobile
- no upstream source modification
- no patch creation or application
- no Android feature implementation
- no per-app routing or transport work

## Outcome
CP-008 successfully established that the materialized upstream fork is not currently able to enter a build process on this workstation.
The dependency chain, missing prerequisites, and blockers are now documented for the next checkpoint.
