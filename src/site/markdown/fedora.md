# Fedora

## Information

Fedora is a free and open-source Linux distribution sponsored by Red Hat. It serves as the upstream development
platform for Red Hat Enterprise Linux (RHEL) and its community rebuild CentOS Stream. Fedora targets developers and
advanced users who want access to the latest software.

Key characteristics:

* **Release cycle**: approximately every 6 months; each release is supported for ~13 months.
* **Relationship to RHEL**: features that prove stable in Fedora are eventually incorporated into RHEL.
* **DNF package manager**: Fedora uses `dnf` (successor to `yum`) with RPM packages.
* **SELinux**: enabled by default in enforcing mode.
* **Flatpak**: first-class support via Flathub.
* **Editions**: Workstation (GNOME desktop), Server, IoT, CoreOS, and Spins (alternative desktops).

## Installation

Download the installer ISO from [fedoraproject.org](https://fedoraproject.org/workstation/).

After installation, update all packages:

```shell
sudo dnf update -y
```

## Configuration

### DNF Configuration

DNF is configured in `/etc/dnf/dnf.conf`. Useful options:

```ini
[main]
gpgcheck=True
installonly_limit=3
clean_requirements_on_remove=True
best=False
skip_if_unavailable=True
```

Enable faster parallel downloads:

```ini
max_parallel_downloads=10
fastestmirror=True
```

### Firewall (firewalld)

Fedora uses `firewalld` for firewall management:

```shell
sudo systemctl enable --now firewalld
sudo firewall-cmd --state
# Allow a service permanently
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-port=8080/tcp
# Reload rules
sudo firewall-cmd --reload
# List active rules
sudo firewall-cmd --list-all
```

### SELinux

Check SELinux status:

```shell
sestatus
getenforce
```

Temporarily set permissive mode for debugging:

```shell
sudo setenforce 0
```

Re-enable enforcing:

```shell
sudo setenforce 1
```

SELinux policy is configured in `/etc/selinux/config`.

## Usage, tips and tricks

### Package Management with dnf

```shell
# Update package index and upgrade all packages
sudo dnf update -y
# Install a package
sudo dnf install package-name
# Remove a package
sudo dnf remove package-name
# Search for a package
dnf search keyword
# Show package info
dnf info package-name
# List installed packages
dnf list installed
# Remove unused dependencies
sudo dnf autoremove
# Clean cache
sudo dnf clean all
# Add a repository
sudo dnf config-manager --add-repo https://example.com/repo.repo
```

### Enable RPM Fusion (extra packages)

```shell
sudo dnf install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

### Flatpak

```shell
# Install Flathub remote (if not already present)
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# Install an app
flatpak install flathub org.videolan.VLC
# Run an app
flatpak run org.videolan.VLC
# Update all Flatpaks
flatpak update
```

### Service Management (systemd)

```shell
sudo systemctl start service-name
sudo systemctl stop service-name
sudo systemctl enable --now service-name
sudo systemctl status service-name
```

### Check Fedora Version

```shell
cat /etc/fedora-release
rpm -E %fedora
```

## See also

* [Fedora official site](https://fedoraproject.org/)
* [Fedora documentation](https://docs.fedoraproject.org/)
* [RPM Fusion](https://rpmfusion.org/)
* [Flathub](https://flathub.org/)
* [CentOS / Rocky Linux](centos.md)
* [Linux tips](linux.md)
* [SELinux](selinux.md)
