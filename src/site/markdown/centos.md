# centos and Rocky Linux

## Information

## Software Installation

### EPEL

    yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

### Development machine preparation

    dnf group list --available

    sudo dnf groupinstall "Server with GUI"
    sudo systemctl set-default graphical.target

    dnf -y install mc ansible nano make yum-utils rpmdevtools rpm-build git mercurial meld
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
``

## See also

    [xxxx](http://yyyyy)
