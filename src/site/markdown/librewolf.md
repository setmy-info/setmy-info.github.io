# LibreWolf

## Information

### Introduction

`LibreWolf` is a free and open-source web browser, based on Firefox, with a strong focus on privacy and security. It is
designed to minimize data collection and telemetry as much as possible and to maximize user privacy.

It is community-driven and independent, providing a browser that is pre-configured with privacy-respecting settings out
of the box, making it an excellent choice for users who want to avoid the overhead of manually hardening Firefox.

### What is it for?

`LibreWolf` is used by individuals and professionals who prioritize online privacy and security. It is particularly
useful for:

* **Private Browsing**: Browsing the web without being tracked by telemetry, experiments, or adware.
* **Enhanced Security**: Protecting against common web threats and browser fingerprinting.
* **Open Source Advocacy**: Using a browser that is fully transparent and community-maintained.
* **Minimalist Experience**: A clean browser environment without unnecessary "features" that often compromise privacy.

## Main Functionalities and Features

* **No Telemetry**: All forms of telemetry, data collection, and experiments are disabled.
* **uBlock Origin Included**: Comes with the industry-leading content blocker pre-installed.
* **Private Search**: Default search engines are privacy-focused (e.g., DuckDuckGo, Searx, Qwant).
* **Enhanced Tracking Protection**: Strict tracking protection is enabled by default.
* **Fingerprinting Protection**: Includes advanced techniques to mitigate browser fingerprinting.
* **No "Pocket"**: Integrated services like Mozilla Pocket are removed.
* **Regular Updates**: Built from the latest Firefox Stable source, ensuring up-to-date security patches.

## Installation

### Windows

You can download the installer directly from the official website or use a package manager.

**Official Download**: [LibreWolf Windows Downloads](https://librewolf.net/installation/windows/)

**Via Winget**:

```powershell
winget install LibreWolf.LibreWolf
```

### macOS

`LibreWolf` is available for macOS via Homebrew or as a direct disk image download.

**Official Download**: [LibreWolf macOS Downloads](https://librewolf.net/installation/macos/)

**Via Homebrew**:

```bash
brew install --cask librewolf
```

### Linux

LibreWolf provides packages for many Linux distributions.

#### Flatpak (Recommended for most distros)

```bash
flatpak install flathub io.gitlab.librewolf-community
```

#### Fedora / Red Hat / CentOS

```bash
sudo dnf config-manager --add-repo https://common-repo.librewolf.net/librewolf.repo
sudo dnf install librewolf
```

#### Arch Linux

Available in the AUR:

```bash
# Using yay
yay -S librewolf-bin
```

#### Debian / Ubuntu / Mint

```bash
sudo apt update && sudo apt install -y wget gnupg lsb-release
distro=$(lsb_release -sc)
wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF
sudo apt update
sudo apt install librewolf
```

## Configuration

`LibreWolf` comes pre-hardened, but you can further customize it via `librewolf.overrides.cfg` for persistent settings
or through the standard `about:config` interface.

To create overrides, place a `librewolf.overrides.cfg` file in your profile directory:

```javascript
// Example librewolf.overrides.cfg
defaultPref("browser.startup.homepage", "https://start.duckduckgo.com");
defaultPref("identity.fxaccounts.enabled", true); // Enable Firefox Sync if needed
```

## Usage, tips and tricks

* **Firefox Sync**: While disabled by default for privacy, you can enable it in the settings if you need to sync
  bookmarks across devices.
* **Compatibility**: Because of strict privacy settings (like RFP - Resist Fingerprinting), some websites might behave
  unexpectedly. You can toggle specific settings in `about:config` if a critical site breaks.
* **Portable Version**: For Windows, a portable version is available that doesn't require installation.

## See also

* [LibreWolf Official Website](https://librewolf.net/)
* [LibreWolf Documentation](https://librewolf.net/docs/)
* [LibreWolf Source Code (GitLab)](https://gitlab.com/librewolf-community)
* [Firefox](firefox.md)
* [Privacy Guides](https://www.privacyguides.org/en/tools/browsers/)
