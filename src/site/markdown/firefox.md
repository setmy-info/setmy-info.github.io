# Firefox

## Information

Firefox is an open-source web browser developed by Mozilla. It is available for Linux, macOS, Windows, Android,
and iOS. Firefox is notable for its strong privacy defaults, extension ecosystem, and developer tools.

For automated testing and CI use, Firefox supports a headless mode (`--headless`) that runs without a display.

## Installation

### CentOS, Rocky Linux

```shell
sudo dnf install -y firefox
```

### Fedora

```shell
sudo dnf install -y firefox
```

### Debian

```shell
sudo apt install -y firefox-esr
```

### FreeBSD

```shell
pkg install firefox
```

### Windows

Download the installer from [mozilla.org/firefox](https://www.mozilla.org/firefox/).

Or via winget:

```shell
winget install Mozilla.Firefox
```

## Configuration

Create a named profile (useful for Selenium/WebDriver isolation):

```shell
firefox -CreateProfile "selenium-test"
```

Start with a specific profile:

```shell
firefox -P "selenium-test" -no-remote
```

`about:config` in the address bar exposes all internal preferences. For scripted configuration, create a `user.js`
file in the profile directory:

```javascript
// user.js — loaded on each Firefox start, overrides prefs.js
user_pref("browser.startup.homepage", "about:blank");
user_pref("dom.webnotifications.enabled", false);
```

Profile directory location: `~/.mozilla/firefox/<profile-id>/`

## Usage, tips and tricks

```shell
# Open headless and take a screenshot
firefox --headless --screenshot https://example.com
/opt/firefox/firefox --headless --screenshot https://example.com

# Open a local HTML file
/opt/firefox/firefox --new-tab "$(pwd)/src/site/resources/static.html"
/opt/firefox/firefox --new-tab "$(pwd)/target/site/index.html"

# Run with a named profile, allowing multiple instances
firefox -P "selenium-test" -no-remote
```

## See also

* [Mozilla Firefox](https://www.mozilla.org/firefox/)
* [Firefox developer tools documentation](https://firefox-source-docs.mozilla.org/devtools-user/)
* [Firefox release notes](https://www.mozilla.org/firefox/releases/)
* [WebDriver (geckodriver)](https://github.com/mozilla/geckodriver)
