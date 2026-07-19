# Tauri

## Information

Tauri is a framework for building tiny, blazing fast binaries for all major desktop platforms. Developers can write any
frontend framework that compiles to HTML, JS and CSS for their user interface, and use Rust for the backend logic.

### Main Functionalities and Features

* **Tiny Binaries**: Tauri uses the OS's native webview (WebView2 on Windows, WebKit on macOS, and WebKitGTK on Linux),
  so it doesn't need to bundle a browser engine like Electron.
* **Security**: Tauri is designed with security in mind. It has a "deny-by-default" security posture and allows
  fine-grained access to system APIs.
* **Performance**: Rust backend ensures high performance and low memory footprint.
* **Multi-platform**: Supports Windows, macOS, and Linux. Tauri v2 adds support for mobile platforms (iOS and Android).
* **Interoperability**: Easy communication between the frontend (JS/TS) and backend (Rust) via commands and events.

## Installation

### Prerequisites

You need to have Rust installed on your system.

1. **Install Rust**:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
2. **System Dependencies**:

#### Linux (Debian/Ubuntu)

```bash
sudo apt update
sudo apt install libwebkit2gtk-4.0-dev \
    build-essential \
    curl \
    wget \
    file \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev
```

#### CentOS, Rocky Linux

```bash
sudo dnf groupinstall "Development Tools"
sudo dnf install webkit2gtk3-devel \
    openssl-devel \
    curl \
    wget \
    file \
    libappindicator-gtk3-devel \
    librsvg2-devel
```

#### Fedora

```bash
sudo dnf groupinstall "Development Tools"
sudo dnf install webkit2gtk4.1-devel \
    openssl-devel \
    curl \
    wget \
    file \
    libappindicator-gtk3-devel \
    librsvg2-devel
```

#### macOS

Xcode Command Line Tools are required:

```bash
xcode-select --install
```

#### Windows

Install **Microsoft C++ Build Tools** (usually via Visual Studio Installer).

### Mobile Setup (Tauri v2)

Tauri v2 supports mobile platforms. This requires additional setup.

#### Android

1. **Install Java**: Ensure you have JDK 17 or newer.
2. **Android Studio**: Install Android Studio and use the SDK Manager to install:
    * Android SDK Platform
    * Android SDK Platform-Tools
    * NDK (Side by side)
    * CMake
3. **Environment Variables**:
   ```bash
   export ANDROID_HOME=$HOME/Android/Sdk
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   ```

#### iOS (macOS only)

1. **Xcode**: Install Xcode from the App Store.
2. **CocoaPods**:
   ```bash
   sudo gem install cocoapods
   ```

### Node.js (Recommended for Frontend)

While not strictly required (you can use plain HTML/JS), Node.js is recommended for most modern frontend workflows.

## Fast and Efficient Way to Start Development

The fastest way to scaffold a new Tauri project is using `create-tauri-app`.

```bash
npm create tauri-app@latest
```

Follow the interactive prompts to choose:

* **Project name**
* **Frontend language** (TypeScript / JavaScript)
* **Package manager** (npm, yarn, pnpm)
* **UI template** (Vanilla, Vue, React, Svelte, Preact, Lit, Solid, Angular)

### Development Workflow

Once the project is created, navigate into the directory and run:

```bash
# Install dependencies
npm install

# Start the application in development mode
npm run tauri dev
```

The `dev` command will start the frontend dev server and the Rust backend, then open a window with your application. It
supports Hot Module Replacement (HMR) for both JS and Rust code.

## Setup for Developer

### Common Commands

* **Build for production**:
  ```bash
  npm run tauri build
  ```
  This creates optimized bundles and installers for your current platform in `src-tauri/target/release/bundle`.

* **Add Tauri to an existing project**:
  ```bash
  npx tauri init
  ```

* **Check environment**:
  ```bash
  npx tauri info
  ```

* **Generate icons**:
  ```bash
  npm run tauri icon
  ```
  This generates all necessary icons for all platforms from a single source image (usually `app-icon.png`).

## Configuration (tauri.conf.json)

The `src-tauri/tauri.conf.json` file is the heart of your Tauri application. Key configuration sections include:

* **`package`**: Application name and version.
* **`tauri`**:
    * **`allowlist`**: Defines which system APIs the frontend is allowed to call (Security).
    * **`bundle`**: Configuration for creating installers (identifiers, icons, etc.).
    * **`window`**: Default window settings (size, title, resizable, etc.).
    * **`security`**: Content Security Policy (CSP) and other security settings.
* **`build`**: Commands to run before and during build (e.g., frontend build command).

## Usage, Tips and Tricks

### Project Structure

A typical Tauri project has two main parts:

* **Root directory**: Contains your frontend code (e.g., `src/`, `package.json`).
* **`src-tauri/`**: Contains the Rust backend code (`src/main.rs`), Tauri configuration (`tauri.conf.json`), and Cargo
  manifest (`Cargo.toml`).

### Calling Rust from JS (Commands)

**Rust (`src-tauri/src/main.rs`):**

```rust
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![greet])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
```

**JavaScript/TypeScript:**

```javascript
import {invoke} from '@tauri-apps/api/tauri'

// Now we can call our Command!
invoke('greet', {name: 'World'})
    .then((response) => console.log(response))
```

### Auto-updating

Tauri has a built-in updater that can be configured to check for updates from a JSON endpoint.

## Troubleshooting

### Linux: `webkit2gtk` not found

If the application fails to start on Linux with an error related to `libwebkit2gtk`, ensure the library is installed. On
some distributions, you might need `webkit2gtk-4.1` or `webkit2gtk-4.0`.

### Build: `pkg-config` errors

If you see `pkg-config` errors during `cargo build`, it usually means a `-dev` package is missing. Check the **System
Dependencies** section for your OS.

### macOS: `xcrun` error

If you encounter `xcrun: error: invalid active developer path`, run:

```bash
xcode-select --install
```

## CI/CD with GitHub Actions

You can automate your builds using the official `tauri-action`.

**`.github/workflows/release.yml`:**

```yaml
name: Release
on:
    push:
        tags:
            - 'v*'

jobs:
    release:
        strategy:
            fail-fast: false
            matrix:
                platform: [ macos-latest, ubuntu-22.04, windows-latest ]
        runs-on: ${{ matrix.platform }}
        steps:
            -   uses: actions/checkout@v4
            -   name: setup node
                uses: actions/setup-node@v4
                with:
                    node-version: 20
            -   name: install Rust
                uses: dtolnay/rust-toolchain@stable
            -   name: install dependencies (ubuntu only)
                if: matrix.platform == 'ubuntu-22.04'
                run: |
                    sudo apt-get update
                    sudo apt-get install -y libwebkit2gtk-4.0-dev build-essential curl wget file libssl-dev libgtk-3-dev libayatana-appindicator3-dev librsvg2-dev
            -   uses: tauri-apps/tauri-action@v0
                env:
                    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
                with:
                    tagName: v__VERSION__ # the action automatically replaces this
                    releaseName: 'App v__VERSION__'
                    releaseBody: 'See the assets below for download'
                    releaseDraft: true
                    prerelease: false
```

## Build Lifecycle (ADR-0045)

To align with the organization's standardized build lifecycles
(see [ADR-0045](it/architecture/decisions/adr-0045-software-build-lifecycles.html)), a Tauri project should map its
commands as follows:

| Phase     | Command               | Description                              |
|-----------|-----------------------|------------------------------------------|
| Bootstrap | `npm install`         | Install both JS and Rust dependencies.   |
| Clean     | `npm run clean`       | Should run `cargo clean` in `src-tauri`. |
| Format    | `npm run format`      | Should run `prettier` and `cargo fmt`.   |
| Lint      | `npm run lint`        | Should run `eslint` and `cargo clippy`.  |
| Build     | `npm run tauri build` | Compiles the Rust backend and frontend.  |
| Test      | `npm test`            | Runs frontend tests and `cargo test`.    |

## See also

[Tauri Official Website](https://tauri.app/)

[Tauri Documentation](https://tauri.app/v1/guides/)

[Rust Programming Language](https://www.rust-lang.org/)

[WebView2 (Windows)](https://developer.microsoft.com/en-us/microsoft-edge/webview2/)
