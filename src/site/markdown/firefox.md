# Firefox

Firefox is Mozilla's open-source web browser. It is widely used for web development, testing, automation,
privacy-focused
browsing, and `WebExtension` development.

## Information

Firefox is an open-source web browser developed by Mozilla. It is available for Linux, macOS, Windows, Android,
and iOS. Firefox is notable for its strong privacy defaults, extension ecosystem, and developer tools.

For automated testing and CI use, Firefox supports a headless mode (`--headless`) that runs without a display.

`Firefox` is relevant not only as a browser but also as a platform for:

- web development and debugging
- cross-browser testing
- automated browser testing with tools such as `Selenium`
- browser extension development and publishing

Mozilla documentation is mainly split between:

- `MDN` for browser APIs, `WebExtensions`, CSS, JavaScript, and browser behavior
- `Firefox Extension Workshop` for extension development and publishing guidance
- `AMO` (`addons.mozilla.org`) Developer Hub for registration, submission, and release management

## Installation

### CentOS, Rocky Linux

Install `Firefox` from the distribution repositories when available, or use Mozilla-provided binaries if you need a
newer version than the OS package offers.

```shell
sudo dnf install -y firefox
```

### Fedora

`Firefox` is usually available directly from the standard Fedora repositories.

```shell
sudo dnf install -y firefox
```

### Debian

```shell
sudo apt install -y firefox-esr
```

### FreeBSD

Use the package manager or ports collection depending on your normal FreeBSD workflow.

```shell
pkg install firefox
```

### OpenIndiana

Check the distribution package repositories or use vendor binaries if package versions are too old for your use case.

### Windows

Download the installer from [mozilla.org/firefox](https://www.mozilla.org/firefox/).

Or via winget:

```shell
winget install Mozilla.Firefox
```

## Configuration

Useful configuration areas include:

- profiles for separate test and automation environments
- headless execution for CI pipelines
- `about:config` for advanced browser settings
- developer tools for network, CSS, JavaScript, storage, and performance debugging

For extension development, the most important configuration topics are:

- enabling temporary loading of unsigned extensions during development
- using a dedicated browser profile for testing
- checking the extension manifest and permissions carefully

Useful Mozilla resources:

- `MDN WebExtensions`: architecture, APIs, manifests, permissions, examples
- `Extension Workshop`: publishing, signing, distribution, and policies

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

Start headless

```shell
firefox --headless --url https://example.com
```

```shell
# screenshot.png
/opt/firefox/firefox --headless --screenshot https://example.com
/opt/firefox/firefox --new-tab `pwd`/src/site/resources/static.html
/opt/firefox/firefox --new-tab `pwd`/target/site/index.html

# Open a local HTML file
/opt/firefox/firefox --new-tab "$(pwd)/src/site/resources/static.html"
/opt/firefox/firefox --new-tab "$(pwd)/target/site/index.html"

# Run with a named profile, allowing multiple instances
firefox -P "selenium-test" -no-remote
```

### Coding tips and tricks

- Use a dedicated profile for automation and extension testing so normal browsing data is not mixed with test state.
- For extension development, use `about:debugging` to load a temporary extension during development.
- Validate your `manifest.json` early, especially permissions, host permissions, background scripts, and content
  scripts.
- Check `MDN` first for Firefox-specific support and compatibility details for extension APIs.
- Test in a clean profile before publishing so hidden local settings do not mask packaging or permission issues.

## Firefox extension publishing overview

If you build a Firefox extension or plugin-like browser add-on, the normal publication path is through Mozilla's add-on
ecosystem.

In practice, the typical flow is:

1. build the extension as a standard `WebExtension`
2. test it locally with temporary loading in `Firefox`
3. create an `AMO` developer account
4. prepare metadata, icons, screenshots, privacy details, and support links
5. upload the packaged extension to `addons.mozilla.org`
6. go through automated checks and, when needed, manual review
7. publish the add-on and manage future versions through the developer dashboard

### Basic development model

Modern Firefox add-ons are usually built as `WebExtensions`.

That normally means:

- a `manifest.json`
- JavaScript or TypeScript extension code
- optional popup, options, sidebar, or background scripts
- explicit permissions for the browser capabilities the extension needs

`MDN` is the main reference for API support, manifests, permissions, and examples.

### Local development and testing

During development, a common workflow is:

1. open `about:debugging`
2. choose the option to load a temporary add-on
3. select the extension `manifest.json`
4. test the add-on in a dedicated profile
5. inspect background pages, extension logs, network requests, and content scripts

This is usually the fastest way to iterate before packaging a release.

### Registration and developer account

To publish publicly, you normally need an account in the Mozilla add-on ecosystem:

- create or use a Mozilla account
- sign in to the `AMO` Developer Hub
- set up your developer profile information
- provide contact and support information for the add-on when needed

The `AMO` Developer Hub is the main place where you submit new add-ons, manage releases, and track review status.

### Packaging and submission

Before submission, prepare at least:

- the extension package, usually a `.zip` or `.xpi` build artifact depending on the workflow
- `manifest.json`
- add-on name and summary
- full description
- icons
- screenshots if you want a better store listing
- privacy policy or data handling explanation if the extension processes user data
- support site, source repository, or homepage links when available

Mozilla reviews both technical and policy aspects. In practice, the review typically looks at:

- requested permissions
- remote code usage restrictions
- privacy and data collection behavior
- security issues
- misleading functionality or policy violations

### Signing and distribution

Firefox extensions normally need Mozilla signing for standard distribution in Firefox.

Common distribution approaches are:

- public listing on `AMO`
- unlisted distribution for controlled sharing in smaller groups or internal use
- temporary unsigned loading during development only

The exact rules can differ by Firefox channel and deployment model, so the Mozilla signing and distribution
documentation
should be checked before deciding how you want to ship the add-on.

### High-level publishing process

The publication process is typically:

1. implement and test the extension locally
2. prepare a clean release package
3. register or log in to the `AMO` Developer Hub
4. create a new add-on submission
5. upload the package
6. fill in store listing details and policy-related information
7. wait for validation and review
8. publish after approval
9. upload updated versions for later releases

### Practical tips

- Keep permissions minimal because broad permissions increase review attention and user distrust.
- Avoid remote executable code patterns unless Mozilla explicitly allows the chosen approach.
- Write a clear add-on description that explains exactly what the extension does.
- Prepare icons, screenshots, and support links before submission so the release process is smoother.
- If the extension handles personal data, document that clearly and provide a privacy policy.
- Test upgrades from an older version to a newer version, not only fresh installs.
- Check compatibility notes in `MDN` if the same extension is also meant for Chromium-based browsers.

## See also

* [Firefox Browser](https://www.mozilla.org/firefox/)
* [MDN: Your first extension](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Your_first_WebExtension)
* [MDN: WebExtensions](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions)
* [Firefox Extension Workshop](https://extensionworkshop.com/)
* [Extension Workshop: Signing and distribution overview](https://extensionworkshop.com/documentation/publish/signing-and-distribution-overview/)
* [Extension Workshop: Submitting an add-on](https://extensionworkshop.com/documentation/publish/submitting-an-add-on/)
* [AMO Developer Hub](https://addons.mozilla.org/developers/)
* [Firefox developer tools documentation](https://firefox-source-docs.mozilla.org/devtools-user/)
* [Firefox release notes](https://www.mozilla.org/firefox/releases/)
* [WebDriver (geckodriver)](https://github.com/mozilla/geckodriver)
