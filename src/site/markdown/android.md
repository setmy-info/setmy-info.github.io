# Android

Android development within the SMI ecosystem focuses on both pure native development (Kotlin/Java) and the "Native
Shell" approach using Capacitor or Cordova.

## Information

Android is a mobile operating system based on a modified version of the Linux kernel and other open-source software,
designed primarily for touchscreen mobile devices such as smartphones and tablets.

## Installation

### Windows

1. **Java Development Kit (JDK)**: Install JDK 17 or newer (e.g., via [Adoptium](https://adoptium.net/)).
2. **Android Studio**: Download and install [Android Studio](https://developer.android.com/studio).
3. **Android SDK**: Through Android Studio SDK Manager, install:
    - Android SDK Platform-Tools
    - Android SDK Build-Tools
    - A recent Android SDK Platform (e.g., API 34)
4. **Environment Variables**:
    - Set `JAVA_HOME` to your JDK path.
    - Set `ANDROID_HOME` to your Android SDK path (e.g., `%LOCALAPPDATA%\Android\Sdk`).
    - Add `%ANDROID_HOME%\platform-tools` and `%ANDROID_HOME%\cmdline-tools\latest\bin` to your `PATH`.

### Linux (CentOS, Rocky Linux, Fedora)

1. **Java Development Kit (JDK)**:
   ```bash
   sudo dnf install java-17-openjdk-devel
   ```
2. **Android SDK Command Line Tools**:
   Download the command line tools from the Android Studio website. Unpack to `/opt/android-sdk`.
3. **Environment Variables**:
   Add to `~/.bashrc` or `~/.bash_profile`:
   ```bash
   export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
   export ANDROID_HOME=/opt/android-sdk
   export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin
   ```
4. **Permissions**:
   Ensure your user has write access to `/opt/android-sdk` or use a local directory like `~/android-sdk`.

### FreeBSD, OpenIndiana

Android development is primarily supported on Windows, macOS, and Linux. For FreeBSD and OpenIndiana, use Linux
emulation layers or cross-compilation if absolutely necessary, but it is not officially supported for the full build
pipeline.

## Configuration

### Gradle Configuration

Use `build.gradle` (Groovy) or `build.gradle.kts` (Kotlin DSL). Standardize on Kotlin DSL for new projects.

```kotlin
android {
    namespace = "info.setmy.app"
    compileSdk = 34

    defaultConfig {
        applicationId = "info.setmy.app"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
}
```

## Multi-SDK Development

Managing multiple SDK versions is critical for Android.

- **compileSdk**: The version used to compile your app. Always use the latest stable version to access new APIs.
- **targetSdk**: The version that the app is tested against. It tells the system you have tested the app on this version
  and it should behave as expected.
- **minSdk**: The minimum version of Android required to run the app. This determines your app's reach.
  Use [Android Distribution Dashboard](https://apilevels.com/) to make an informed decision (usually API 24 or 26 for
  modern SMI apps).

### SDK Management in CLI

Use `sdkmanager` to manage versions:

```bash
sdkmanager --list
sdkmanager "platforms;android-34" "build-tools;34.0.0"
```

## Docker and CI/CD Integration

Using Docker ensures a consistent build environment across developer machines (local) and CI/CD pipelines (GitHub
Actions, Jenkins).

### Official and Standard Images

Note: Keep `cimg/android` tags reasonably fresh (e.g., update quarterly to a recent `YYYY.MM` tag) and verify builds
before rollout.

- **No "Official" Google SDK Image**: Google does not provide a pre-built Docker image with the Android SDK.
- **CircleCI Android Images**: The most widely accepted community standard for CI is `cimg/android` (e.g.,
  `cimg/android:2024.01`).
- **SMI Recommendation**: Developers should build their own organization-specific images based on their preferred OS (
  e.g., Rocky Linux) using the template below to ensure full control over security and versions.

### Standard SMI Docker Template

This Dockerfile can be used both for local development containers and as a base for CI runners.

```dockerfile
FROM rockylinux:9
RUN dnf install -y java-17-openjdk-devel wget unzip git

ENV ANDROID_HOME /opt/android-sdk
ENV PATH $PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin

ARG CMD_TOOLS_ZIP=commandlinetools-linux-11076708_latest.zip
# IMPORTANT: Replace the placeholder below with the official SHA256 for the ZIP you use.
ARG CMD_TOOLS_SHA256=<FILL-IN-OFFICIAL-SHA256>
RUN mkdir -p $ANDROID_HOME/cmdline-tools \
    && wget https://dl.google.com/android/repository/${CMD_TOOLS_ZIP} -O tools.zip \
    && echo "${CMD_TOOLS_SHA256}  tools.zip" | sha256sum -c - \
    && unzip tools.zip -d $ANDROID_HOME/cmdline-tools \
    && mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest \
    && rm tools.zip

RUN yes | sdkmanager --licenses
RUN sdkmanager "platforms;android-34" "build-tools;34.0.0" "platform-tools"
```

### Building Locally with Docker

To build your app locally using the Docker image:

```bash
# Linux/macOS shells
docker build -t smi-android-build .
docker run --rm -v "$(pwd)":/home/app -w /home/app smi-android-build bash -lc "chmod +x ./gradlew && ./gradlew assembleDebug"

# PowerShell (Windows)
docker run --rm -v "${PWD}":/home/app -w /home/app smi-android-build powershell -Command "bash -lc 'chmod +x ./gradlew && ./gradlew assembleDebug'"
```

## CI/CD Integration

### GitHub Actions

When using GitHub Actions, you can either use the `cimg/android` image or your custom SMI image.

```yaml
jobs:
    build:
        runs-on: ubuntu-latest
        container:
            # Option A: Use community standard
            image: cimg/android:2024.01
            # Option B: Use your organization's image (Recommended)
            # image: your-registry/smi-android:34-jdk17
        steps:
            -   uses: actions/checkout@v4
            -   name: Build with Gradle
                run: |
                    chmod +x gradlew
                    ./gradlew assembleRelease
            -   name: Run Unit Tests
                run: ./gradlew test

    emulator-tests:
        runs-on: ubuntu-latest
        steps:
            -   uses: actions/checkout@v4
            -   name: Run Instrumented Tests (Emulator)
                uses: reactivecircus/android-emulator-runner@v2
                with:
                    api-level: 30
                    script: ./gradlew connectedDebugAndroidTest
```

### Caching

To speed up builds, cache the Gradle home directory:

```yaml
-   name: Cache Gradle packages
    uses: actions/cache@v4
    with:
        path: |
            ~/.gradle/caches
            ~/.gradle/wrapper
        key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}
        restore-keys: |
            ${{ runner.os }}-gradle-
```

## Release Notes and Metadata

Managing release notes is a crucial part of the release process.

### Automated Release Notes (Fastlane)

If using [Fastlane Supply](https://docs.fastlane.tools/actions/supply/), release notes are managed in the
`fastlane/metadata` directory:

```text
fastlane/metadata/android/en-US/changelogs/default.txt
fastlane/metadata/android/en-US/changelogs/[versionCode].txt
```

### Manual Release Notes

When uploading an AAB to the Google Play Console manually:

1. Navigate to **Production** > **Releases**.
2. Under **Release notes**, enter the changes for this version.
3. You can use HTML-like tags for formatting (e.g., `<b>`, `<li>`).

## Signing Process for Google Play Store

To upload to the Play Store, the app must be signed with a release key.

1. **Generate Upload Key**:
   ```bash
   keytool -genkey -v -keystore my-upload-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
   ```
2. **Configure Gradle**: Store credentials in `~/.gradle/gradle.properties` (NEVER in the repo).
   ```properties
   MYAPP_RELEASE_STORE_FILE=my-upload-key.keystore
   MYAPP_RELEASE_KEY_ALIAS=my-key-alias
   MYAPP_RELEASE_STORE_PASSWORD=*****
   MYAPP_RELEASE_KEY_PASSWORD=*****
   ```
3. **Update `build.gradle.kts`**:
   ```kotlin
   signingConfigs {
       create("release") {
           storeFile = file(project.properties["MYAPP_RELEASE_STORE_FILE"] as String)
           storePassword = project.properties["MYAPP_RELEASE_STORE_PASSWORD"] as String
           keyAlias = project.properties["MYAPP_RELEASE_KEY_ALIAS"] as String
           keyPassword = project.properties["MYAPP_RELEASE_KEY_PASSWORD"] as String
       }
   }
   buildTypes {
       getByName("release") {
           signingConfig = signingConfigs.getByName("release")
       }
   }
   ```

## F-Droid Release and Signing

F-Droid has a unique model where they typically build apps from source on their own servers using their own signing
keys. However, you can also maintain your own F-Droid repository.

### Official F-Droid Repository

For the official F-Droid repository, you do **not** sign the APK yourself. F-Droid's build server:

1. Clones your repository.
2. Builds the app from source.
3. Signs the resulting APK with the F-Droid key.

**Requirements**:

- The app must be entirely Open Source.
- No proprietary dependencies or blobs.
- Provide a `metadata` file in the F-Droid Data repository or include it in your repo.

### Self-Hosted F-Droid Repository

If you host your own repository (see [F-Droid Know-how](fdroid.md)), you **must** sign the APKs yourself.

1. **Sign the APK**: Use your standard release signing process (same as Google Play Store) using `apksigner`.
2. **Add to Repo**: Place the signed APK in the `repo/` folder of your F-Droid server setup.
3. **Update Index**: F-Droid tools will read your APK's signature and include it in the `index.xml` or `index-v1.jar`.

### Signing for F-Droid (Reproducible Builds)

F-Droid encourages **Reproducible Builds**. This allows F-Droid to verify that their build from your source matches your
official APK.

1. Use the same version of JDK and Android Gradle Plugin as F-Droid's build server.
2. Ensure no non-deterministic elements (like timestamps) are in the APK. Use `SOURCE_DATE_EPOCH` where applicable.
3. Provide necessary metadata and build environment details to match the F-Droid build environment.

## CLI Usage (Windows and Linux)

Developers should be comfortable using the Gradle Wrapper (`gradlew`) for building and testing.

### Building

- **Assemble Debug APK**:
    - Windows: `.\gradlew.bat assembleDebug`
    - Linux: `./gradlew assembleDebug`
- **Build Release Bundle (AAB)**:
    - Windows: `.\gradlew.bat bundleRelease`
    - Linux: `./gradlew bundleRelease`
- **Clean Build**:
    - `.\gradlew clean assembleDebug`

### Testing Execution

- **Unit Tests (Local JVM)**:
    - Run all unit tests: `./gradlew test`
    - Run specific test class: `./gradlew test --tests "info.setmy.app.MyUnitTest"`
- **Instrumentation Tests (on Device/Emulator)**:
    - Run all instrumentation tests: `./gradlew connectedAndroidTest`
- **E2E Tests (Appium/Espresso)**:
    - Espresso tests are typically run via `connectedAndroidTest`.
    - Appium tests are run as a separate process (usually Node.js) against the installed APK.

## Cryptography and Secure Storage

- **Android Keystore System**: Use it to store cryptographic keys so they are difficult to extract from the device.
- **EncryptedSharedPreferences**: Part of the Jetpack Security library. Use it for small key-value pairs.
- **Biometric Authentication**: Integrate with `BiometricPrompt` for secure user authentication.

## Usage, tips and tricks

* **HttpURLConnection vs. OkHttp**: Prefer **OkHttp** for networking as it is more robust and widely used.
* **Architecture**: Follow the **MVVM** (Model-View-ViewModel) pattern with **Jetpack Compose** for the UI.
* **Coroutines**: Use Kotlin Coroutines for asynchronous programming instead of Threads or RxJava.

### Coding tips and tricks

- **Memory Leaks**: Use `LeakCanary` to detect memory leaks during development.
- **Build Speed**: Enable Gradle caching and parallel execution in `gradle.properties`:
  ```properties
  org.gradle.caching=true
  org.gradle.parallel=true
  ```

## See also

* [Dagger 2 DI](https://dagger.dev/dev-guide/grpc)
* [Koin DI](https://insert-koin.io/)
* [Apache Cordova](https://cordova.apache.org/)
* [CapacitorJS](capacitorjs.md)
* [F-Droid](fdroid.md)
* [PWA Comparison](pwa-comparison.md)
