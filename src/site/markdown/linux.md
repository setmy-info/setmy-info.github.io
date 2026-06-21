# Linux

## Information

Linux is an open-source, UNIX-like operating system kernel written by Linus Torvalds in 1991. Combined with the GNU
userland tools, it forms what is commonly called GNU/Linux — the foundation of a diverse ecosystem of distributions
including RHEL/Rocky Linux, Fedora, Debian, Ubuntu, Arch Linux, openSUSE, and many others.

Linux is used across servers, desktops, embedded systems, mobile devices (Android), and cloud infrastructure.

## Installation

Linux is installed as part of a distribution. Refer to the specific distro documentation for installation details.

### CentOS, Rocky Linux

See [Rocky Linux documentation](https://docs.rockylinux.org/).

### Fedora

See [Fedora documentation](https://docs.fedoraproject.org/).

### FreeBSD

FreeBSD is not Linux but a related UNIX-like system. See [FreeBSD documentation](https://www.freebsd.org/doc/).

## Configuration

### Example .desktop file

Desktop entry files allow applications to appear in the system menu. Locations:

```
/usr/share/applications
/usr/local/share/applications
```

Specs:
* [freedesktop.org Menu Specification](https://standards.freedesktop.org/menu-spec/latest/)
* [Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-1.1.html)

```ini
[Desktop Entry]
Comment[en_US]=Example application konsole
Comment=Example application konsole
Exec=term exampleApp
GenericName[en_US]=Example application konsole
GenericName=Example application konsole
Icon=utilities-terminal
MimeType=
Name[en_US]=Example application konsole
Name=Example application konsole
Path=
StartupNotify=true
Terminal=false
TerminalOptions=
Type=Application
X-DBUS-ServiceName=
X-DBUS-StartupType=
X-KDE-SubstituteUID=false
X-KDE-Username=
```

### SSH Key Generation

```shell
ssh-keygen -t ed25519 -a 1000
ssh-keygen -t rsa -b 4096 -a 1000
```

## Usage, tips and tricks

### systemctl

```shell
systemctl status sshd
sudo systemctl start sshd
sudo systemctl enable sshd
sudo systemctl stop sshd
```

### journalctl

```shell
journalctl -u sshd -f
journalctl --since "1 hour ago"
```

### Package management

```shell
# Fedora / Rocky
sudo dnf install package-name
sudo dnf remove package-name
sudo dnf update

# Debian / Ubuntu
sudo apt install package-name
sudo apt remove package-name
sudo apt update && sudo apt upgrade
```

### Locale

```shell
localectl list-locales
localectl set-locale LANG=en_US.UTF-8
```

### User management

```shell
sudo useradd NEW_USER --shell /sbin/nologin --no-create-home
```

### zip

```shell
zip -r filename.zip ./somefolder
```

### rsync

Sync directories from source to destination:

```shell
rsync -av --exclude 'exclude.file.txt' ./source/ ./destination/
```

Mirror and delete files removed from source:

```shell
rsync -av --delete --exclude 'exclude.file.txt' ./source/ ./destination/
```

## See also

* [kernel.org](https://www.kernel.org/)
* [GNU Project](https://www.gnu.org/)
* [freedesktop.org Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-1.1.html)
* [Fedora documentation](https://docs.fedoraproject.org/)
* [Rocky Linux documentation](https://docs.rockylinux.org/)
