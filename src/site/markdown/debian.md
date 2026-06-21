# Debian

## Information

Debian is a free and open-source Linux distribution known for its stability, large package repository, and strict free
software guidelines. It serves as the upstream base for many other distributions including Ubuntu, Linux Mint, and
Raspberry Pi OS.

Debian uses a three-branch model:

| Branch    | Codename example | Description                                          |
|-----------|------------------|------------------------------------------------------|
| stable    | bookworm         | Thoroughly tested; recommended for production        |
| testing   | trixie           | Future stable release in preparation                 |
| unstable  | sid              | Bleeding edge; always called "sid"                   |

Current stable release codenames follow Toy Story character names (buster, bullseye, bookworm, trixie, …).

## Installation

Download the installer ISO from [debian.org/distrib](https://www.debian.org/distrib/).

After installation, update the package index and upgrade installed packages:

```shell
sudo apt update
sudo apt upgrade -y
```

## Configuration

### Package Sources

Package sources are configured in `/etc/apt/sources.list` and files under `/etc/apt/sources.list.d/`:

```
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
```

After editing sources, run `sudo apt update`.

### UFW Firewall

UFW (Uncomplicated Firewall) is a front-end for iptables:

```shell
sudo apt install ufw
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status
```

## Usage, tips and tricks

### Package Management with apt

```shell
# Update package index
sudo apt update
# Upgrade all installed packages
sudo apt upgrade -y
# Full upgrade (may add/remove packages)
sudo apt full-upgrade -y
# Install a package
sudo apt install package-name
# Remove a package (keep config files)
sudo apt remove package-name
# Remove a package and its config files
sudo apt purge package-name
# Remove unused dependencies
sudo apt autoremove -y
# Search for a package
apt search keyword
# Show package info
apt show package-name
```

### dpkg — Low-Level Package Tool

```shell
# Install a .deb file
sudo dpkg -i package.deb
# List installed packages
dpkg -l
# Check which package owns a file
dpkg -S /usr/bin/somefile
# List files installed by a package
dpkg -L package-name
```

### Service Management (systemd)

```shell
sudo systemctl start service-name
sudo systemctl stop service-name
sudo systemctl restart service-name
sudo systemctl enable service-name
sudo systemctl disable service-name
sudo systemctl status service-name
```

### Check Debian Version

```shell
cat /etc/debian_version
lsb_release -a
```

## See also

* [Debian official site](https://www.debian.org/)
* [Debian packages search](https://packages.debian.org/)
* [Debian wiki](https://wiki.debian.org/)
* [Ubuntu](https://ubuntu.com/)
* [Linux tips](linux.md)
