# Centos and Rocky Linux

## Information

## Software Installation

### EPEL

    yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

### Development machine preparation

    dnf group list --available

    sudo dnf groupinstall "Server with GUI"
    sudo systemctl set-default graphical.target
    sudo systemctl set-default multi-user.target

    dnf -y install mc ansible nano make yum-utils rpmdevtools rpm-build git mercurial meld openssl-devel \
                    sqlite sqlite-devel cpp gcc g++ boost-test dos2unix rpmlint
    dnf -y install java-1.8.0-openjdk

Install postgres tools from Postgre guide.

Install docker by docker guide.

Install nginx by Nginx guide.

### Rocky linux

Install and enable EPEL repository

```sh
dnf install epel-release
dnf --enablerepo=epel group

dnf config-manager --set-enabled crb
dnf config-manager --set-enabled plus
dnf config-manager --set-enabled rt
dnf update
# Video codecs
dnf install gstreamer1-libav
```

Some more tips

```sh
dnf config-manager --set-enabled powertools
systemctl list-units
```

Install Xfce

```sh
dnf groupinstall "Xfce" "base-x"
```

Set graphical interface as default

```sh
systemctl set-default graphical
```

Install SSH web console

```sh
systemctl enable --now cockpit.socket
```

## Configuration

## Usage, tips and tricks

Get full locales list

    localectl list-locales

### Disks

    lsblk or sudo fdisk -l

### Hostname

    sudo hostnamectl set-hostname HOSTNAE

### Vide Card info

    lspci | grep -i vga

### Install source rpm

Example with bc (command line calculator)

```sh
sudo dnf install -y rpmdevtools rpmlint rpm-build
rpmdev-setuptree

# Download and install into different rpmbuild folders
cd ~/rpmbuild/SRPMS/
dnf info bc
dnf download --source bc
# rpm -ivh bc-*.src.rpm
rpm -Uvh bc-*.src.rpm
cd ~

# Unpack source packages into original and changed folder
cd ~/rpmbuild/BUILD/
tar -xvzf ~/rpmbuild/SOURCES/bc-1.07.1.tar.gz
mkdir ~/rpmbuild/BUILD/bc-1.07.1-changed
tar -xvzf ~/rpmbuild/SOURCES/bc-1.07.1.tar.gz --strip-components=1 -C ~/rpmbuild/BUILD/bc-1.07.1-changed
cd ~

# Here make changes in changed folder

# Creating patch (diff) for later use by spec build
cd ~/rpmbuild/BUILD/
diff -urN bc-1.07.1 bc-1.07.1-changed > ~/rpmbuild/SOURCES/bc-1.07.1-changed.patch
cd ~

# Edit spec to add one or more patch files, created earlier
nano ~/rpmbuild/SPECS/bc.spec
# Add one more patch (bc-1.07.1-changed.patch)
# PatchN: bc-1.07.1-changed.patch[web-components.html](../../../../../../../Users/ImreTabur/Documents/personal/temp/web-components.html)
[mikrofrontend-web-components.html](../../../../../../../Users/ImreTabur/Documents/personal/temp/mikrofrontend-web-components.html)
![placeholder.svg](../../../../../../../Users/ImreTabur/Documents/personal/temp/placeholder.svg)
# Example:
# Patch3: bc-1.07.1-changed.patch

# Install build deps for package
sudo dnf builddep bc

# Direct src.rpm build
#rpmbuild --rebuild ~/rpmbuild/SRPMS/bc-1.07.1-14.el9.src.rpm

# Spec file build
rpmbuild -ba ~/rpmbuild/SPECS/bc.spec

# YUM/DNF repo creation

sudo dnf install -y createrepo
mkdir /var/www/repo/rockylinux/10/{SRPMS,x86_64}
mkdir ${REPO_PATH}
cp /from/build/path/abc-1.2.3-4.noarch.rpm ${REPO_PATH}
cd ${REPO_PATH}
createrepo .
# after new versions
cp /from/build/path/abc-1.3.0-1.noarch.rpm ${REPO_PATH}
createrepo --update .
```

### CUDA install

```
# Nvidia Drivers
sudo dnf groupinstall "Development Tools"
sudo dnf install kernel-devel kernel-headers
sudo dnf config-manager --add-repo=https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo
sudo dnf clean expire-cache
sudo dnf install nvidia-driver nvidia-driver-libs nvidia-kmod
sudo reboot

# CUDA tools
sudo dnf config-manager --add-repo=https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo
sudo dnf install cuda
echo 'export PATH=/usr/local/cuda-12.0/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.0/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
tar -xzvf cudnn-linux-x86_64-8.x.x.x_cuda12-archive.tar.xz
sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
sudo cp cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
nvidia-smi
nvcc --version



sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo
sudo dnf clean all
sudo dnf -y install cuda-toolkit-12-6

# To install the open kernel module flavor:
sudo dnf -y module install nvidia-driver:open-dkms
# To install the legacy kernel module flavor:
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

# All isntalled packages
sudo rpm -qa
sudo rpm -qa --qf '(%{INSTALLTIME:date}): %{NAME}-%{VERSION}\n'
sudo sudo rpm -qi package-name
sudi rpm -ql setmy-info-scripts
```

## See also

[xxxx](http://yyyyy)

[cUDA](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Rocky&target_version=9&target_type=rpm_network)
