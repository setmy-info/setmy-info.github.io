# Electron

## Information

`Electron` is a framework for building cross-platform desktop applications with web technologies such as `HTML`, `CSS`,
and `JavaScript` / `TypeScript`. It combines `Chromium` for rendering with `Node.js` for local system access, which
makes it useful for internal tools, developer utilities, offline-first business applications, and desktop wrappers
around existing web products.

### Main Functionalities and Features

* **Cross-platform desktop runtime**: One codebase can target `Windows`, `macOS`, and `Linux`.
* **Browser + local APIs**: Combines a browser UI with local filesystem, process, and OS integration.
* **Main and renderer processes**: Separates desktop shell responsibilities from UI rendering.
* **Tray, menu, notifications, dialogs**: Supports common desktop application patterns.
* **Packaging ecosystem**: Works with tools such as `electron-builder` and `Electron Forge`.
* **Web technology reuse**: Good fit when a team already has strong frontend skills or an existing web application.

### Common Developer Use Cases

* Build an internal desktop tool with local filesystem access.
* Turn an existing web app into a desktop client with tray and auto-start support.
* Ship a cross-platform offline-capable business application.
* Wrap a local service, daemon, or background workflow with a graphical desktop shell.

## Installation

### Prerequisites

* `Node.js` LTS is recommended.
* `npm` comes with `Node.js`.
* For production packaging, install the platform-specific signing and build tools later as needed.

### Create a minimal Electron project

Initialize the project:

```bash
npm init --yes
npm install --save-dev electron
```

If the desktop app is intended to wrap a Windows background service or service-like integration, additional packages may
be useful depending on architecture:

```bash
npm install --save node-windows winston
```

Update `package.json`:

```json
{
    "name": "my-electron-app",
    "version": "1.0.0",
    "main": "main.js",
    "scripts": {
        "start": "electron ."
    }
}
```

Create `main.js`:

```js
const {app, BrowserWindow, Menu, Tray} = require('electron')
const path = require('node:path')

let tray = null

const createWindow = () => {
    const mainWindow = new BrowserWindow({
        width: 1000,
        height: 700,
        show: false,
        webPreferences: {
            preload: path.join(__dirname, 'preload.js'),
            contextIsolation: true,
            nodeIntegration: false
        }
    })

    mainWindow.loadFile('index.html')

    tray = new Tray(path.join(__dirname, 'tray-icon.png'))

    const contextMenu = Menu.buildFromTemplate([
        {
            label: 'Open window',
            click: () => mainWindow.show()
        },
        {
            label: 'Exit',
            click: () => app.quit()
        }
    ])

    tray.setToolTip('My Electron App')
    tray.setContextMenu(contextMenu)

    tray.on('click', () => {
        mainWindow.isVisible() ? mainWindow.hide() : mainWindow.show()
    })
}

app.whenReady().then(() => {
    createWindow()

    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow()
    })
})

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit()
})
```

Optional `preload.js`:

```js
const {contextBridge} = require('electron')

contextBridge.exposeInMainWorld('appInfo', {
    platform: process.platform
})
```

Create `index.html`:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self'">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electron App</title>
</head>
<body>
<h1>Hello from Electron</h1>
<p>This UI runs in Chromium, but the app behaves like a desktop application.</p>
</body>
</html>
```

Run it:

```bash
npm start
```

## Configuration

Typical Electron configuration topics:

* entry point in `package.json` via `main`,
* secure `BrowserWindow` configuration,
* `preload.js` for controlled renderer access to native capabilities,
* tray, menu, icon, notifications, deep links, and file associations,
* development vs production URLs,
* code signing and packaging settings,
* auto-start or background behavior if the app should live in tray.

### Main process vs renderer process

Electron applications usually have at least two responsibility layers:

* **Main process**: Owns app lifecycle, menus, tray, windows, dialogs, native integrations, and IPC wiring.
* **Renderer process**: Displays the user interface, often using `React`, `Vue`, plain `HTML`, or other frontend stacks.

Keep privileged logic in the main process or behind a secure preload boundary, not directly inside the renderer.

### Security baseline

For most real projects, prefer:

* `contextIsolation: true`
* `nodeIntegration: false`
* a minimal `preload.js`
* explicit IPC channels instead of exposing raw Node APIs
* a restrictive `Content-Security-Policy`

Do not enable `nodeIntegration` in renderer windows unless there is a strong and reviewed reason.

## Preparations for Developers

### Suggested project structure

One practical structure is:

```text
my-app/
├── main.js
├── preload.js
├── index.html
├── package.json
├── assets/
└── src/
```

For bigger apps, separate:

* desktop shell code,
* frontend UI code,
* shared DTOs / message contracts,
* packaging config,
* environment-specific assets.

### Development workflow

Common workflow:

1. Start a frontend development server if you use an SPA framework.
2. Start Electron and point it either to local built files or a dev server URL.
3. Keep main-process logs visible during development.
4. Test tray behavior, window restoration, and shutdown flow manually.

If the app wraps a backend or local daemon, also test startup ordering and failure handling.

## Preparation for Release and Live

### Packaging

Electron apps are usually packaged with tools such as:

* `electron-builder`
* `Electron Forge`

Typical release outputs:

* `Windows`: installer such as `NSIS` or `MSI`
* `macOS`: `.dmg` or signed app bundle
* `Linux`: `AppImage`, `.deb`, or `.rpm`

### Release considerations

Before release, review:

* application icons and metadata,
* auto-update strategy,
* code signing,
* environment-specific endpoints,
* crash logging,
* local data storage location,
* uninstall / cleanup expectations.

### Auto-start and tray-style apps

If the application is intended to run mostly in the tray:

* define whether closing the window exits or minimizes to tray,
* define how auto-start behaves after login,
* make background behavior visible to the user,
* document where logs and configuration files are stored.

## Usage, tips, and tricks

* Use Electron when you need desktop behavior and web team productivity, not because it is always the smallest runtime.
* For sensitive applications, treat Electron security hardening as a first-class requirement.
* Keep IPC contracts explicit and versionable.
* Avoid mixing too much business logic directly into UI code.
* Validate packaging on all target operating systems, not only on the main development machine.

### Coding tips and tricks

* Put OS integrations in the main process.
* Expose only a narrow, reviewed API through `preload.js`.
* Prefer async IPC patterns for file or process operations.
* Keep tray and window lifecycle behavior predictable.
* If you embed an existing web app, decide clearly whether the source of truth is local bundled files or a remote
  server.

### Debugging

Useful approaches:

* open Chromium DevTools for renderer debugging,
* log from both main and renderer processes,
* test startup from a packaged build, not only from `npm start`,
* verify that file paths, icons, and bundled assets still resolve after packaging.

### Common issues

* **Works in dev, fails in packaged app**: Often caused by wrong relative paths or missing bundled assets.
* **Blank window**: Check console errors, `CSP`, and whether the renderer points to the correct file or URL.
* **Tray icon missing**: Verify image format, path, and platform-specific icon requirements.
* **Security warnings**: Review Electron security checklist and remove unsafe renderer access.
* **High memory usage**: Remember that Electron ships a browser runtime; measure before adding more background windows.

## See also

* [Official Electron Website](https://www.electronjs.org/)
* [Electron Security Tutorial](https://www.electronjs.org/docs/latest/tutorial/security)
* [Node.js](nodejs.md)
* [npm Development](npm.md)
* [PWA vs. Native vs. Desktop Comparison](pwa-comparison.md)
* [CapacitorJS (capacitorjs)](capacitorjs.md)
* [Qt](qt.md)
