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

## Command Availability

The following table presents common tools and their availability across various environments and distributions by
default.

| Tool         | POSIX | FreeBSD | Rocky Linux | Debian minimal | OpenIndiana | Recommendation  |
|:-------------|:-----:|:-------:|:-----------:|:--------------:|:-----------:|:----------------|
| `sh`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `bash`       |  ❌   |   🟡    |     🟢      |       🟢       |     🟡      | Check           |
| `vi`         |  ❌   |   🟢    |     🟢      |       🟡       |     🟢      | Check           |
| `vim`        |  ❌   |   🔴    |     🟡      |       🔴       |     🟡      | Check           |
| `nano`       |  ❌   |   🔴    |     🔴      |       🔴       |     🔴      | Don't assume    |
| `awk`        |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `sed`        |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `grep`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `cat`        |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `echo`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `printf`     |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `test` / `[` |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `true`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `false`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `ls`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `cp`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `mv`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `rm`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `mkdir`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `rmdir`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `pwd`        |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `chmod`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `chown`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `chgrp`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `ln`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `touch`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `read`       | shell |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `export`     | shell |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `command`    | shell |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `uname`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `hostname`   |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | Assume          |
| `id`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `date`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `sleep`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `kill`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `ps`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | Assume          |
| `find`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `head`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `tail`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `wc`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `sort`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `uniq`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `cut`        |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `tr`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `tee`        |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `xargs`      |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | Assume          |
| `basename`   |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `dirname`    |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `od`         |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | Assume          |
| `expr`       |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | Assume          |
| `env`        |  ✅   |   🟢    |     🟢      |       🟢       |     🟢      | **Assume**      |
| `tar`        |  ❌   |   🟢    |     🟢      |       🟢       |     🟢      | Check           |
| `gzip`       |  ❌   |   🟡    |     🟢      |       🟢       |     🟢      | Check           |
| `xz`         |  ❌   |   🟡    |     🟡      |       🟡       |     🟡      | Check           |
| `bzip2`      |  ❌   |   🟡    |     🟡      |       🟡       |     🟡      | Check           |
| `curl`       |  ❌   |   🟡    |     🟡      |       🟡       |     🟡      | **Check**       |
| `wget`       |  ❌   |   🟡    |     🟡      |       🟡       |     🟡      | **Check**       |
| `ssh`        |  ❌   |   🟢    |     🟢      |       🟢       |     🟢      | Check           |
| `scp`        |  ❌   |   🟢    |     🟢      |       🟢       |     🟢      | Check           |
| `openssl`    |  ❌   |   🟢    |     🟢      |       🟢       |     🟢      | Check           |
| `git`        |  ❌   |   🔴    |     🔴      |       🔴       |     🔴      | Don't assume    |
| `python3`    |  ❌   |   🔴    |     🔴      |       🔴       |     🔴      | Don't assume    |
| `perl`       |  ❌   |   🟡    |     🟡      |       🟡       |     🟡      | Don't assume    |
| `java`       |  ❌   |   🔴    |     🔴      |       🔴       |     🔴      | Don't assume    |
| `systemctl`  |  ❌   |   🔴    |     🟢      |       🟢       |     🔴      | **OS-specific** |
| `service`    |  ❌   |   🟢    |     🟡      |       🟡       |     🟢      | OS-specific     |
| `sudo`       |  ❌   |   🟡    |     🟡      |       🟡       |     🟡      | Check           |

Legend:

- ✅: POSIX standard requirement
- ❌: Not defined by POSIX
- `shell`: Shell built-in command
- 🟢: Available/Installed by default
- 🟡: May be available or requires check
- 🔴: Usually not available by default

### Portable Toolset

The following tools are highly portable and can be assumed to be available in almost any POSIX-compliant or UNIX-like
environment:

`sh`, `awk`, `sed`, `grep`, `cat`, `echo`, `printf`, `test`, `true`, `false`, `ls`, `cp`, `mv`, `rm`, `mkdir`, `rmdir`,
`pwd`, `chmod`, `chown`, `chgrp`, `ln`, `touch`, `uname`, `id`, `date`, `sleep`, `kill`, `find`, `head`, `tail`, `wc`,
`sort`, `uniq`, `cut`, `tr`, `tee`, `basename`, `dirname`, `env`.

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
* [LibreWolf](librewolf.md)
* [Raspberry Pi](rasberry-pi.md)
* [ESP32](esp32.md)
* [3D Printers](3dprinters.md)
