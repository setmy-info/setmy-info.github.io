# iOS Development

iOS development within the SMI ecosystem follows the "PWA First" strategy, but utilizes native shells (
Capacitor/Cordova) or pure native code (Swift) when platform-specific limitations are encountered.

## Information

iOS is a mobile operating system created and developed by Apple Inc. exclusively for its hardware. It is the operating
system that powers many of the company's mobile devices, including the iPhone and iPad.

## Installation

iOS development requires **macOS**.

1. **Xcode**: Install the latest version of [Xcode](https://developer.apple.com/xcode/) from the Mac App Store.
2. **Xcode Command Line Tools**:
   ```bash
   xcode-select --install
   ```
3. **Homebrew**: Recommended for managing dependencies.
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
4. **CocoaPods**: (If using Cordova or older plugins)
   ```bash
   sudo gem install cocoapods
   ```

## Configuration

### Project Settings

Most configuration is done within Xcode (`.xcodeproj` or `.xcworkspace`).

- **Info.plist**: Used to define app metadata and request permissions (Camera, Location, etc.).
- **Build Settings**: Configure compiler flags, search paths, and target versions.
- **Deployment Target**: The minimum iOS version supported (similar to `minSdk` in Android).

## Multi-SDK and Environment Support

- **Base SDK**: The version of the iOS SDK used to build the app (latest stable).
- **Deployment Target**: Defines the minimum OS version required to run the app.
- **Docker Integration**: iOS builds **cannot** be run in standard Linux Docker containers because they require macOS
  and Xcode. Use macOS-based runners (GitHub Actions macOS runners, Mac minis, or specialized services like Codemagic)
  for CI/CD.

## CLI Usage

### Building

- **List Targets/Schemes**:
  ```bash
  xcodebuild -list
  ```
- **Build for Simulator**:
  ```bash
  xcodebuild -scheme YourApp -project YourApp.xcodeproj -sdk iphonesimulator -configuration Debug
  ```
- **Clean Build**:
  ```bash
  xcodebuild clean -project YourApp.xcodeproj -scheme YourApp
  ```

### Testing Execution

- **Unit and UI Tests**:
  ```bash
  xcodebuild test -project YourApp.xcodeproj -scheme YourApp -destination 'platform=iOS Simulator,name=iPhone 15'
  ```

## Cryptography and Secure Storage

- **Keychain Services**: Use the system Keychain to store small bits of sensitive data (passwords, keys).
- **Secure Enclave**: For hardware-backed cryptographic operations and biometric authentication (FaceID/TouchID).
- **CryptoKit**: Apple's modern framework for cryptographic operations.

## CI/CD Integration

iOS CI/CD requires macOS environments and typically uses Fastlane for automation.

### Runner Requirements

- **macOS Runners**: GitHub Actions must use `macos-latest` (or specific versions like `macos-13`). Be aware of the
  higher cost and limited concurrency of macOS runners.
- **Xcode Version**: Ensure the runner has the correct Xcode version installed and selected using `xcode-select` or
  `xcversion`.

### GitHub Actions Example

Using `ruby/setup-ruby` with `bundler-cache` is the recommended way to manage Fastlane and its dependencies.

```yaml
jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.2'
          bundler-cache: true
      - name: Build and Sign
        run: bundle exec fastlane build_and_sign
        env:
          MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
          APP_STORE_CONNECT_API_KEY_ID: ${{ secrets.ASC_KEY_ID }}
          APP_STORE_CONNECT_API_KEY_ISSUER_ID: ${{ secrets.ASC_ISSUER_ID }}
          APP_STORE_CONNECT_API_KEY_CONTENT: ${{ secrets.ASC_KEY_CONTENT }}
```

### Signing and Provisioning

For CI, use Fastlane **match** to manage certificates and provisioning profiles. It ensures all developers and CI
runners use the same identities.

- **Match Read-only**: Always use `match(type: "appstore", readonly: true)` in CI to prevent the runner from creating
  new certificates.
- **App Store Connect API Key**: Use API keys instead of Apple ID 2FA for smoother CI integration.

### Xcode Selection

Pin Xcode to a specific version to avoid unexpected toolchain changes:

```yaml
- name: Select Xcode
  run: sudo xcode-select -s "/Applications/Xcode_15.3.app/Contents/Developer"
```

### Caching

Cache CocoaPods, Swift Package Manager (SPM), and DerivedData to reduce build times:

```yaml
- name: Cache CocoaPods
  uses: actions/cache@v4
  with:
    path: Pods
    key: ${{ runner.os }}-pods-${{ hashFiles('**/Podfile.lock') }}
    restore-keys: |
      ${{ runner.os }}-pods-

- name: Cache SPM
  uses: actions/cache@v4
  with:
    path: |
      ~/Library/Caches/org.swift.swiftpm
      ~/.swiftpm
    key: ${{ runner.os }}-spm-${{ hashFiles('**/Package.resolved') }}
    restore-keys: |
      ${{ runner.os }}-spm-

- name: Cache DerivedData
  uses: actions/cache@v4
  with:
    path: ~/Library/Developer/Xcode/DerivedData
    key: ${{ runner.os }}-deriveddata-${{ github.sha }}
    restore-keys: |
      ${{ runner.os }}-deriveddata-
```

### App Store Connect API Key and Match Access

- Store the App Store Connect API key as secrets: `ASC_KEY_ID`, `ASC_ISSUER_ID`, and `ASC_KEY_CONTENT` (base64 of the p8
  file or the raw JSON when using fastlane `app_store_connect_api_key`).
- Ensure the CI has read access to the Match repository (SSH deploy key or PAT) and use `readonly: true` in CI.

## Release Notes and Metadata

Managing release notes for the App Store is handled through App Store Connect.

### Automated Release Notes (Fastlane)

If using [Fastlane Deliver](https://docs.fastlane.tools/actions/deliver/), release notes are managed in the
`fastlane/metadata` directory:

```text
fastlane/metadata/en-US/release_notes.txt
```

Each language has its own folder. The file `release_notes.txt` contains the "What's New in This Version" text.

### Manual Release Notes

In **App Store Connect**:

1. Select your app.
2. Go to **TestFlight** > **Test Information** (for beta notes).
3. Go to **App Store** > **Version** > **What's New in This Version** (for production notes).

## Signing and App Store Process

iOS apps must be signed by Apple-issued certificates.

1. **Certificates**: Managed in the Apple Developer Portal (Development vs. Distribution).
2. **Provisioning Profiles**: Links your App ID, Certificates, and Devices.
3. **Fastlane**: Recommended for automating the signing and submission process.
   ```bash
   fastlane match # Manage certificates
   fastlane release # Build and upload to TestFlight
   ```

## Usage, tips and tricks

* **SwiftUI**: Preferred modern UI framework.
* **Combine**: Reactive framework for handling asynchronous events.
* **Memory Management**: Use **ARC** (Automatic Reference Counting). Watch for retain cycles (use `[weak self]`).

### Coding tips and tricks

- **Instruments**: Use the Instruments tool in Xcode for profiling performance and finding memory leaks.
- **CocoaPods vs. SPM**: Prefer **Swift Package Manager (SPM)** for modern dependencies.

## See also

* [Swift.org](https://swift.org/)
* [Apple Developer Documentation](https://developer.apple.com/documentation/)
* [Android Development](android.md)
* [CapacitorJS](capacitorjs.md)
* [PWA Comparison](pwa-comparison.md)
