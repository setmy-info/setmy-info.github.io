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

## See also

    [xxxx](http://yyyyy)
