# PWA vs. Native vs. Desktop Comparison

Progressive Web Applications (PWAs) are our primary architectural choice as defined
in [PWA First](it/architecture/decisions/pwaFirst.md). However, while PWAs offer significant advantages in
cross-platform development and deployment, there are scenarios where they encounter obstacles or where native/hybrid
approaches become necessary.

The meaning of a PWA can vary significantly across different operating systems. On Android and Windows, a PWA can feel
nearly identical to a native application, with deep system integration and installation prompts. On iOS, it is often
treated as a "bookmarked website" with more limited capabilities due to platform restrictions.

To bridge the gap between pure PWAs and fully native apps, technologies like **Capacitor** (often referred to
as **capacitorjs**) and **Apache Cordova** (and desktop equivalents like **Tauri** or **Electron**) are used. These
"Hybrid" or "Native Shell" technologies allow developers to use the same web source code while gaining access to native
APIs that are otherwise unavailable to standard web browsers.

## Overview Comparison

| Feature                | PWA                                | Hybrid Shell (Capacitor/Cordova)   | Native Mobile (iOS/Android)      | Local Desktop App            |
|------------------------|------------------------------------|------------------------------------|----------------------------------|------------------------------|
| **Language/Stack**     | Web (HTML, CSS, JS/TS)             | Web + Native Bridge                | Swift/Kotlin/Java                | C++, C#, Java, Python        |
| **Installation**       | Direct from Browser                | App Stores                         | App Stores (App Store, Play)     | Installer / Package Manager  |
| **Distribution**       | URL / QR Code                      | App Stores / Enterprise            | App Stores                       | Website / Store              |
| **Offline Support**    | Service Workers (Good)             | Native + Web (Excellent)           | Native Storage (Excellent)       | Local FS (Excellent)         |
| **Hardware Access**    | Limited (Web APIs)                 | Full (via Plugins)                 | Full (Native APIs)               | Full (System APIs)           |
| **Cryptography**       | Web Crypto API (Software-based)    | Hardware-backed (via Plugins)      | Hardware-backed (Secure Enclave) | Hardware-backed (TPM/HSM)    |
| **Secure Storage**     | Limited (IndexedDB, WebAuthn)      | Native Secure Storage              | Native Secure Storage (Keychain) | OS-level Keyring/Vault       |
| **Performance**        | High (but restricted by JS)        | Near-Native (UI is Web)            | Native (Best)                    | Native (Best)                |
| **Updates**            | Immediate (on reload)              | Store Approval (CodePush possible) | Store Approval Process           | Varied (Manual/Auto-updater) |
| **Push Notifications** | Yes (Android/Desktop, iOS limited) | Yes (Full Native)                  | Yes (Native)                     | Yes (OS Integrated)          |
| **Discoverability**    | High (SEO/URL)                     | Low (Store search)                 | Low (Store search)               | Low (Site/Store)             |

## Obstacles to "PWA First"

Applying the [PWA First](it/architecture/decisions/pwaFirst.md) decision comes with several technical and
platform-specific hurdles:

1. **Hardware & API Limitations**: While Web APIs (WebBluetooth, WebUSB, WebNFC) are evolving, they are not supported by
   all browsers (especially Safari/WebKit). Complex hardware integrations often require native code.
2. **iOS Restrictions**: Apple restricts certain PWA features (like push notifications in older versions, background
   sync, or full access to certain sensors) to maintain its App Store ecosystem.
3. **File System Access**: Although the File System Access API exists, it is more restrictive than native file system
   access, which is often crucial for professional desktop productivity tools.
4. **Cryptography & Secure Storage**: PWAs are limited to the Web Crypto API, which often lacks access to
   hardware-backed security modules (like Secure Enclave or TPM) for key generation and storage. Secure storage in PWAs
   is also limited compared to native Keychains/Keystores.
5. **Background Processing**: PWAs are heavily throttled when not in the foreground to save battery and memory. Native
   apps have more robust background execution models.
6. **User Perception**: Some users still prefer finding and installing apps through official stores, perceiving them as
   more "official" or "secure".

## OS-Specific Problems and Limitations

### iOS (Apple)

iOS is currently the most restrictive platform for PWAs due to Apple's control over the browser engine (WebKit) and the
App Store ecosystem.

* **Browser Engine Lock-in**: All browsers on iOS (Chrome, Firefox, Edge) are forced to use the WebKit engine. This
  means a bug or missing feature in WebKit affects all PWAs regardless of the user's browser choice.
* **Push Notifications**: While supported since iOS 16.4, they require the app to be added to the Home Screen first and
  have several UX hurdles compared to Android.
* **Storage Eviction**: iOS may aggressively delete PWA storage (indexedDB, LocalStorage) if the app is not used for a
  certain period (usually 7 days of inactivity), which is problematic for offline-heavy apps.
* **Hardware Access**: Lack of support for WebBluetooth, WebUSB, and WebNFC. No access to FaceID/TouchID via Web APIs (
  limited to WebAuthn).
* **Cryptography & Security**: No access to the Secure Enclave for hardware-backed key storage. PWAs are limited to
  WebAuthn for device-bound keys, which does not allow general-purpose application data encryption via hardware keys.
  PWAs cannot use system-level VPNs or specialized networking hardware.
* **Installation UX**: Users must manually "Add to Home Screen" via the Share menu. There is no "Install" prompt similar
  to Android/Chrome.
* **Background Tasks**: Extremely limited background sync and no support for long-running background processes.
* **In-App Purchases**: PWAs cannot easily integrate with Apple's IAP system, forcing developers to use external payment
  processors which may conflict with Apple's policies if the app is also in the Store.

### Android (Google)

Android is the most PWA-friendly mobile OS, but still has limitations compared to native apps.

* **Fragmentation**: Different manufacturers (Samsung, Xiaomi, etc.) may have different default browsers or battery
  optimization settings that throttle PWAs.
* **App Store Parity**: While PWAs can be packaged as TWA (Trusted Web Activity) for the Play Store, they still feel
  slightly different from native apps (e.g., splash screen behavior, transition animations).
* **API Availability**: Some advanced APIs (like Contact Picker or File System Access) are supported in Chrome but might
  not work in "lite" browsers or WebViews.
* **Secure Storage**: While Android's Keystore is powerful, PWAs can only interact with it indirectly via WebAuthn,
  missing features like hardware-backed encryption of local data blobs.
* **Deep Linking**: While supported, configuring Web App Manifest "scope" to handle all deep links correctly can be
  complex compared to native intent filters.

### Windows (Microsoft)

Windows provides good PWA support via Edge (Chromium), but desktop-specific expectations are high.

* **File System Access**: The File System Access API is powerful but requires user permission for every session/file,
  which can be annoying for professional IDEs or media editors.
* **Registry & System Hooks**: PWAs cannot access the Windows Registry, global hotkeys, or low-level system hooks (e.g.,
  for specialized hardware monitoring).
* **Hardware & Security**: No direct access to TPM (Trusted Platform Module) for cryptographic operations or hardware
  attestation. Limited integration with Windows Hello beyond basic WebAuthn.
* **Legacy Integration**: Difficult to interact with legacy COM/ActiveX components or local Win32/.NET services without
  a hybrid bridge (like a local websocket server).
* **Multi-window Management**: PWAs have limited control over opening and managing multiple windows compared to native
  Win32/WPF apps.

### macOS (Apple)

Similar to iOS, but with the added complexity of Safari vs. Chrome.

* **Safari Restrictions**: Safari on macOS often lags behind Chrome in supporting modern Web APIs.
* **System Integration**: PWAs lack deep integration with Menu Bar (top of screen), Dock badges (limited support), and
  system-wide services.
* **Secure Enclave & TouchID**: Native apps can use the Secure Enclave for advanced cryptography; PWAs are restricted to
  standard web-based authentication.
* **Code Signing & Security**: While PWAs don't need signing, hybrid versions (Tauri/Electron) must go through Apple's
  complex Notarization process to avoid "Unidentified Developer" warnings.

### Linux

Linux support varies greatly depending on the distribution and desktop environment.

* **Browser Dependency**: PWA support depends entirely on whether the user has a Chromium-based browser installed.
  Firefox's PWA support is currently non-existent or experimental. Chromium-based PWAs on Linux can integrate with
  desktop menus using `.desktop` files, but behavior varies by desktop environment (GNOME, KDE, etc.).
* **Installation Hurdles**: No standard "Install" experience across GNOME, KDE, and other environments.
* **Hardware Permissions**: Interfacing with hardware (USB/Bluetooth) often requires complex udev rule configurations by
  the user, which native apps can sometimes handle via package managers.

## When to Consider Non-PWA (Native/Hybrid)

We should deviate from the PWA-only path when:

* **Deep Hardware Integration**: Requirements for low-latency Bluetooth, complex NFC interactions, custom USB
  drivers, or direct access to specialized sensors (e.g., LiDAR, high-frequency IMUs).
* **Advanced Security & Cryptography**: Applications requiring hardware-backed key storage (Secure Enclave, TPM),
  custom cryptographic provider integrations, or system-level secure storage (Keychain/Keystore).
* **Heavy Performance Requirements**: 3D rendering (beyond WebGL capabilities), complex video processing, or
  high-performance computing that JS cannot handle efficiently.
* **App Store Presence**: When the business model requires visibility in the Apple App Store or Google Play Store.
* **OS-Level Features**: Deep integration with OS features like Widgets, App Shortcuts (beyond basic manifest support),
  or specialized system hooks.

## Solving Problems Softly (The Hybrid Approach)

To maintain the "PWA First" spirit while overcoming its limitations, we use a hybrid approach. This allows us to use the
same web source code while "wrapping" it in a native shell that provides access to native APIs.

### Recommended Tools & Frameworks

| Tool               | Focus   | PWA Relationship | Description                                                                                                                |
|--------------------|---------|------------------|----------------------------------------------------------------------------------------------------------------------------|
| **Capacitor**      | Mobile  | Native Bridge    | Modern replacement for Cordova (capacitorjs). Bridges Web App to Native iOS/Android APIs. Ideal for PWA-to-Native porting. |
| **Apache Cordova** | Mobile  | Native Bridge    | The "classic" hybrid tool. Uses a plugin-based architecture to access native features.                                     |
| **Tauri**          | Desktop | Native Bridge    | Lightweight alternative to Electron. Uses Rust for the backend and the system's native webview for the frontend.           |
| **Electron**       | Desktop | Bundled Browser  | The industry standard for cross-platform desktop apps using Chromium and Node.js. High memory usage but very mature.       |
| **Android Native** | Mobile  | Native Target    | Traditional native development using Kotlin/Java. See [Android Native Know-how](android.md).                               |
| **iOS Native**     | Mobile  | Native Target    | Traditional native development using Swift. See [iOS Native Know-how](ios.md).                                             |
| **F-Droid**        | Mobile  | Distribution     | Alternative FOSS App Store for Android. See [F-Droid Know-how](fdroid.md).                                                 |

### PWA vs. Capacitor vs. Cordova

While all three allow using web technologies for mobile, they differ in philosophy and implementation:

* **PWA**: Runs directly in the browser. Zero friction for the user (no store), but limited by what the browser (and the
  OS manufacturer) allows. Updates are instant.
* **Capacitor**: A modern bridge (capacitorjs) that treats the web app as a first-class citizen. It provides a standard
  set of APIs that work across Web, iOS, and Android. It is designed to be added to any existing web project and is the
  recommended way to "native-ify" an SMI PWA. See [CapacitorJS Know-how](capacitorjs.md) for detailed setup and tips.
* **Cordova**: The predecessor to Capacitor. It relies heavily on a specialized CLI and a rigid project structure. While
  still functional, it is increasingly being replaced by Capacitor due to better developer experience and more modern
  native integration.

### Strategy for Portability

1. **Core Logic**: Keep business logic in framework-agnostic JS/TS.
2. **Abstraction Layer**: Use an abstraction for features that differ between Web and Native (e.g., a
   `NotificationService` that uses Web Push in PWA and Native Push in Capacitor).
3. **Conditional Loading**: Detect the environment at runtime to enable/disable specific native-only features.
4. **SMI Ecosystem Integration**: Ensure that sub-apps can be bundled into a single native "Root App" shell if needed,
   while still functioning as individual PWAs.
