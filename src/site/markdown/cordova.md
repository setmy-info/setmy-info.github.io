# Cordova

## Information

Apache Cordova is a mobile application development framework that allows you to build cross-platform apps for iOS,
Android, and other platforms using HTML, CSS, and JavaScript. It wraps your web application in a native WebView shell
and provides a JavaScript bridge to access native device APIs (camera, geolocation, storage, contacts, etc.) via
plugins.

Node.js **LTS** is required to use the Cordova CLI. See [node.md](node.md).

**Note:** For new projects, consider [CapacitorJS](capacitorjs.md) — the modern successor to Cordova, maintained by
the Ionic team. Capacitor treats the web app as a first-class citizen and has better ecosystem support.

## Installation

Install the Cordova CLI globally:

```shell
npm install -g cordova
cordova --version
```

## Usage, tips and tricks

### Start project

```shell
cordova create MyApp
cd MyApp
cordova platform add browser
cordova platform add android
cordova run browser
# Android SDK needed for the following:
# ANDROID_HOME must be set
cordova run android
```

### Useful commands

```shell
# List installed platforms
cordova platform ls
# Add iOS platform (macOS only)
cordova platform add ios
# List available plugins
cordova plugin ls
# Add a plugin
cordova plugin add cordova-plugin-camera
# Build for production
cordova build android --release
```

### Project structure

```
MyApp/
├── config.xml        # App configuration (ID, name, version, permissions)
├── www/              # Web assets (HTML, CSS, JS)
│   └── index.html
├── platforms/        # Generated native projects (do not edit manually)
└── plugins/          # Installed Cordova plugins
```

## See also

* [Apache Cordova official site](https://cordova.apache.org/)
* [Cordova plugin registry](https://cordova.apache.org/plugins/)
* [CapacitorJS (modern alternative)](capacitorjs.md)
* [Node.js](node.md)
* [npm](npm.md)
* [Android](android.md)
* [iOS](ios.md)
