# F-Droid

F-Droid is an installable catalogue of FOSS (Free and Open Source Software) applications for the Android platform.

## Information

Unlike the Google Play Store, F-Droid is committed to privacy and freedom. Every app in the F-Droid repository must be
open source and must not contain tracking or proprietary "anti-features".

## Inclusion Criteria

To be included in the official F-Droid repository, an app must:

- Be entirely Open Source (GPL, Apache, MIT, etc.).
- Not use proprietary libraries (e.g., Google Play Services, Firebase, etc.).
- Be built from source by the F-Droid build servers.

## Build Process

F-Droid uses a `metadata` file (YAML or text) to define how an app is built. In the official repository, F-Droid builds
the app from source and signs it with their own key.

### Signing for F-Droid

- **Official Repo**: You do not sign the APK. F-Droid builds and signs it.
- **Self-Hosted Repo**: You must sign your APKs using your own release key (e.g., using `apksigner` or Gradle's
  `signingConfigs`) before adding them to the `repo/` directory.

### Metadata Example (`info.setmy.app.yml`)

```yaml
Categories:
    - Development
License: MIT
WebSite: https://setmy.info
SourceCode: https://github.com/setmy-info/my-app

RepoType: git
Repo: https://github.com/setmy-info/my-app

Builds:
    -   versionName: 1.0.0
        versionCode: 1
        commit: v1.0.0
        subdir: app
        gradle:
            - yes
```

### Local Verification

You can use the `fdroidserver` tools to verify your app locally:

1. **Install fdroidserver**:
   ```bash
   pip install fdroidserver
   ```
2. **Run Lint**:
   ```bash
   fdroid lint info.setmy.app
   ```
3. **Build Locally**:
   ```bash
   fdroid build info.setmy.app
   ```

## Handling Proprietary Dependencies

If your app uses Google Play Services, you must:

1. **Create Flavors**: Define a `foss` flavor and a `play` flavor in `build.gradle.kts`.
   ```kotlin
   productFlavors {
       create("foss") {
           dimension = "environment"
       }
       create("play") {
           dimension = "environment"
       }
   }
   ```
2. **Use Open Alternatives**: Use [MicroG](https://microg.org/) or [UnifiedNlp](https://github.com/microg/UnifiedNlp)
   for location services in the `foss` build.

## Publishing to your own Repository

You can also host your own F-Droid repository for SMI apps that don't meet the official criteria or for faster updates.

1. **Initialize Repo**:
   ```bash
   mkdir my-repo && cd my-repo
   fdroid init
   ```
2. **Add APKs**: Place your signed APKs in the `repo/` directory.
3. **Update Index**:
   ```bash
   fdroid update --create-metadata
   ```
4. **Deploy**: Sync the `repo/` directory to a web server.

## See also

* [F-Droid Official Website](https://f-droid.org/)
* [F-Droid Build Metadata Documentation](https://f-droid.org/docs/Build_Metadata_Reference/)
* [Android Development](android.md)
