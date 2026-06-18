# CapacitorJS (capacitorjs)

Capacitor is a cross-platform native runtime for building Web Native apps. It allows you to create a single web-based
application that runs natively on iOS, Android, and the Web (as a PWA).

## Introduction

Capacitor (capacitorjs) acts as a "bridge" or "native shell" for your web application. Unlike Cordova, which used a set
of custom-built plugins and a rigid CLI, Capacitor treats your web app as a first-class citizen. It provides a standard
set of APIs that work across all platforms and allows you to easily drop down into native code (Swift or Kotlin) when
needed.

For SMI projects, Capacitor is the recommended way to "native-ify" a PWA when browser-level limitations (like hardware
access or iOS backgrounding) are encountered.

## Installation

### Prerequisites

- **Node.js**: LTS version recommended.
- **Web App**: An existing web project (Angular, Vue, or pure JS).
- **Native Tools**:
    - **iOS**: macOS with the latest version of Xcode.
    - **Android**: Android Studio with the latest Android SDK and Build Tools.

### Adding Capacitor to your Project

1. Initialize Capacitor in your web project root:
   ```bash
   npm install @capacitor/core @capacitor/cli
   npx cap init
   ```
   *Follow the prompts to enter your App Name and Package ID (e.g., info.setmy.app).*

2. Build your web project (e.g., `npm run build` or `ng build`). Ensure your build output directory matches the `webDir`
   in `capacitor.config.ts` (usually `dist` or `www`).

3. Install and add native platforms:
   ```bash
   npm install @capacitor/ios @capacitor/android
   npx cap add ios
   npx cap add android
   ```

## Preparations for Developers

### Synchronization

Whenever you make changes to your web code and build it, you must sync those changes to the native platforms:

```bash
npx cap copy
```

If you install new Capacitor plugins, use `sync` instead:

```bash
npx cap sync
```

### Running the App

Open the native IDEs to run the app on simulators or real devices:

```bash
npx cap open ios
npx cap open android
```

### Native Bridge & Plugins

- **Official Plugins**: Use `@capacitor/camera`, `@capacitor/storage`, etc., for common native features.
- **Custom Native Code**: You can write native Swift/Kotlin code directly in the generated Xcode/Android Studio projects
  and call it from JS using `Capacitor.Plugins`.
- **Environment Detection**: Use the `Device` plugin to detect if the app is running as a PWA, on iOS, or on Android.

## Preparation for Release and Live

### General

- **Icons & Splash Screens**: Use the `@capacitor/assets` tool to generate all required sizes from a single source file.
- **Configuration**: Review `capacitor.config.ts`. Set `bundledWebRuntime: false` for production.
- **Environment Variables**: Use different `.env` files for your web build to point to production APIs.

### iOS Release

1. In Xcode, set the **Bundle Identifier** and **Version**.
2. Configure **Code Signing** with a valid Apple Developer certificate.
3. Perform an **Archive** and upload to App Store Connect / TestFlight.

### Android Release

1. In Android Studio, generate a **Signed App Bundle (AAB)** or APK.
2. Use **ProGuard** if needed to minify and obfuscate your web assets (though web code is usually already minified).
3. Upload the AAB to the Google Play Console.

## Tips and Tricks

### Debugging

- **Web Inspector**: You can debug the web portion of your Capacitor app using Chrome DevTools (for Android) or Safari
  Web Inspector (for iOS) while the device is connected.
- **Console Logs**: Use `npx cap run ios --list` to see logs in the terminal, or watch the console in the native IDEs.
- **Port Forwarding**: On Android, use `adb reverse tcp:8100 tcp:8100` (or your local dev port) to access a local API
  server running on your development machine.

### Performance

- **Lazy Loading**: Ensure your web app uses lazy loading for routes to keep the initial boot time fast.
- **Splash Screen Delay**: Don't hide the splash screen too early. Use the `SplashScreen` plugin to hide it only after
  your web app is fully hydrated.

### Common Issues

- **CORS**: Native apps are served from `capacitor://localhost` (iOS) or `http://localhost` (Android). Ensure your
  backend API allows these origins. Centralize allowed origins via environment-based backend configuration (e.g., a
  single
  ALLOWED_ORIGINS setting populated per environment).
- **Keyboard Overlays**: Use the `Keyboard` plugin to handle UI adjustments when the on-screen keyboard appears.
- **Hardware Back Button**: On Android, handle the hardware back button using the `App` plugin to avoid exiting the app
  unexpectedly.

## See also

* [Official CapacitorJS Website](https://capacitorjs.com/)
* [npm Development](npm.md)
* [Android Development](android.md)
* [iOS Development](ios.md)
* [F-Droid](fdroid.md)
* [GitHub CI/CD Tips](ci-github.md)
* [PWA vs. Native vs. Desktop Comparison](pwa-comparison.md)
