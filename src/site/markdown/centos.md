# CentOS and Rocky Linux

## Information

**CentOS** was a free, community-maintained rebuild of Red Hat Enterprise Linux (RHEL). In December 2020, Red Hat
shifted CentOS to **CentOS Stream**, which is a rolling release that sits upstream of RHEL rather than a downstream
rebuild.

**Rocky Linux** is the community-maintained, binary-compatible RHEL rebuild that replaced CentOS as the primary
free RHEL alternative. It is maintained by the Rocky Enterprise Software Foundation (RESF), founded by CIQ.

Rocky Linux 9.x is the current production release and tracks RHEL 9. Rocky Linux 10.x tracks RHEL 10.

Both use **DNF** as the package manager (replacing YUM in newer versions) and follow the RHEL package ecosystem
including SELinux, firewalld, and systemd.

## Software Installation

### EPEL

```shell
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

### Development machine preparation

```shell
dnf group list --available

sudo dnf groupinstall "Server with GUI"
sudo systemctl set-default graphical.target
sudo systemctl set-default multi-user.target

dnf -y install mc ansible nano make yum-utils rpmdevtools rpm-build git mercurial meld openssl-devel \
                sqlite sqlite-devel cpp gcc g++ boost-test dos2unix rpmlint
dnf -y install java-1.8.0-openjdk
```

Install postgres tools from Postgre guide.

Install docker by docker guide.

Install nginx by Nginx guide.

### Rocky Linux

Install and enable EPEL repository:

```shell
dnf install epel-release
dnf --enablerepo=epel group

dnf config-manager --set-enabled crb
dnf config-manager --set-enabled plus
dnf config-manager --set-enabled rt
dnf update
# Video codecs
dnf install gstreamer1-libav
```

Some more tips:

```shell
dnf config-manager --set-enabled powertools
systemctl list-units
```

Install Xfce:

```shell
dnf groupinstall "Xfce" "base-x"
```

Set graphical interface as default:

```shell
systemctl set-default graphical
```

Install SSH web console:

```shell
systemctl enable --now cockpit.socket
```

## Configuration

## Usage, tips and tricks

Get full locales list:

```shell
localectl list-locales
```

### Disks

```shell
lsblk
sudo fdisk -l
```

### Hostname

```shell
sudo hostnamectl set-hostname HOSTNAME
```

### Video Card info

```shell
lspci | grep -i vga
```

### Install source rpm

Example with bc (command line calculator):

```shell
sudo dnf install -y rpmdevtools rpmlint rpm-build
rpmdev-setuptree

# Download and install into different rpmbuild folders
cd ~/rpmbuild/SRPMS/
dnf info bc
dnf download --source bc
rpm -Uvh bc-*.src.rpm
cd ~

# Unpack source packages into original and changed folder
cd ~/rpmbuild/BUILD/
tar -xvzf ~/rpmbuild/SOURCES/bc-1.07.1.tar.gz
mkdir ~/rpmbuild/BUILD/bc-1.07.1-changed
tar -xvzf ~/rpmbuild/SOURCES/bc-1.07.1.tar.gz --strip-components=1 -C ~/rpmbuild/BUILD/bc-1.07.1-changed
cd ~

# Make changes in changed folder, then create patch
cd ~/rpmbuild/BUILD/
diff -urN bc-1.07.1 bc-1.07.1-changed > ~/rpmbuild/SOURCES/bc-1.07.1-changed.patch
cd ~

# Edit spec to add patch file
nano ~/rpmbuild/SPECS/bc.spec
# Add: Patch3: bc-1.07.1-changed.patch

# Install build deps for package
sudo dnf builddep bc

# Spec file build
rpmbuild -ba ~/rpmbuild/SPECS/bc.spec

# YUM/DNF repo creation
sudo dnf install -y createrepo
mkdir /var/www/repo/rockylinux/10/{SRPMS,x86_64}
mkdir ${REPO_PATH}
cp /from/build/path/abc-1.2.3-4.noarch.rpm ${REPO_PATH}
cd ${REPO_PATH}
createrepo .
# After adding new versions:
createrepo --update .
```

### CUDA install

```shell
# Nvidia Drivers
sudo dnf groupinstall "Development Tools"
sudo dnf install kernel-devel kernel-headers
sudo dnf config-manager --add-repo=https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo
sudo dnf clean expire-cache
sudo dnf install nvidia-driver nvidia-driver-libs nvidia-kmod
sudo reboot

# CUDA tools
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo
sudo dnf clean all
sudo dnf -y install cuda-toolkit-12-6

# Open kernel module flavor
sudo dnf -y module install nvidia-driver:open-dkms
# Legacy kernel module flavor
sudo dnf -y module install nvidia-driver:latest-dkms
```

### Misc

```shell
sudo dnf list
sudo dnf list installed
sudo dnf list installed package-name\*
sudo dnf repoquery -l package-name
sudo dnf repoquery --whatprovides '*nginx.conf*'
sudo dnf repoquery -i package-name
sudo dnf repoquery -s package-name

# All installed packages
sudo rpm -qa
sudo rpm -qa --qf '(%{INSTALLTIME:date}): %{NAME}-%{VERSION}\n'
sudo rpm -qi package-name
sudo rpm -ql package-name
```

## See also

* [Rocky Linux](https://rockylinux.org/)
* [CentOS Stream](https://centos.org/centos-stream/)
* [EPEL](https://docs.fedoraproject.org/en-US/epel/)
* [CUDA downloads](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Rocky&target_version=9&target_type=rpm_network)
* [RPM packaging](rpm.md)
* [Fedora](fedora.md)
