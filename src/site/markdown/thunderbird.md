# Thunderbird

## Information

**Mozilla Thunderbird** is a free, open-source email client, news reader, RSS aggregator, and calendar application
developed by the Mozilla Foundation (and the MZLA Technologies Corporation subsidiary). It runs on Linux, macOS, and
Windows.

Key features:
* IMAP and POP3 email account support with offline mode.
* Built-in **OpenPGP** email encryption and signing (since Thunderbird 78, using the RNP library — no Enigmail needed).
* **Calendar** via the built-in Lightning/Calendar extension.
* Message filters and tags for automated organisation.
* RSS/Atom feed reader.
* Add-on ecosystem for additional functionality.

## Installation

### Rocky Linux / Fedora

```shell
sudo dnf install -y thunderbird
```

### Debian / Ubuntu

```shell
sudo apt install -y thunderbird
```

### FreeBSD

```shell
pkg install -y thunderbird
```

### Windows / macOS

Download the installer from [thunderbird.net](https://www.thunderbird.net/).

## Configuration

### Account setup

On first launch, Thunderbird auto-discovers IMAP/SMTP settings for many providers. For manual configuration:

* **IMAP** (recommended over POP3): port 993 with SSL/TLS.
* **POP3**: port 995 with SSL/TLS. Downloads and optionally removes messages from server.
* **SMTP**: port 587 with STARTTLS (or 465 with SSL/TLS).

### OpenPGP encryption

Thunderbird includes OpenPGP support since version 78:

1. Generate a key: **Account Settings → End-To-End Encryption → Add Key**.
2. Share your public key with correspondents.
3. Import recipient public keys to send encrypted mail.
4. Messages signed or encrypted using OpenPGP are indicated by a shield icon.

### Calendar setup

The Calendar tab is built in. To add a CalDAV calendar:

1. Open Calendar → New Calendar → On the Network → CalDAV.
2. Enter the CalDAV URL and credentials.

## Usage, tips and tricks

### POP3 double-download fix

If POP3 downloads duplicate messages:

```shell
# Delete the POP state file (Thunderbird will re-check from server)
rm /home/${USER}/.thunderbird/*/Mail/hostname.com/popstate.dat
```

Then let Thunderbird reconnect — it will re-download and deduplicate.

### Message filters

**Tools → Message Filters** — create rules to auto-file, tag, forward, or delete messages on arrival. Filters can
match sender, subject, headers, or body text and apply multiple actions.

### Tags / Labels

Use tags (`1` through `5` keys for quick tagging) to mark messages for follow-up. Tags are searchable and can be
used in filter rules.

### Quick Filter bar

Press `F8` to toggle the Quick Filter bar. Filter current folder by sender, subject, tags, or message body in real
time without opening a search dialog.

### Compact folders

IMAP folders accumulate deleted-message tombstones. Run **File → Compact Folders** periodically to reclaim disk
space.

### Profile backup

The entire Thunderbird profile is in `~/.thunderbird/` (Linux/macOS) or
`%APPDATA%\Thunderbird\Profiles\` (Windows). Back up this directory to preserve accounts, filters, and local mail.

## See also

* [Thunderbird official site](https://www.thunderbird.net/)
* [Thunderbird support](https://support.mozilla.org/en-US/products/thunderbird)
* [OpenPGP in Thunderbird](https://support.mozilla.org/en-US/kb/openpgp-thunderbird-howto-and-faq)
* [GPG](gpg.md)
