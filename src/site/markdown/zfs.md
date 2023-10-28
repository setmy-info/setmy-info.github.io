# ZFS

## Information

## Installation

### CentOS, Rocky Linux

Not tested!

```
rpm -e --nodeps zfs-fuse
sudo rpm -e --nodeps zfs-fuse
sudo dnf install https://zfsonlinux.org/epel/zfs-release-2-3$(rpm --eval "%{dist}").noarch.rpm
sudo dnf install -y epel-release
dnf install -y kernel-devel
sudo dnf install -y kernel-devel
sudo dnf install -y zfs
sudo echo zfs > /etc/modules-load.d/zfs.conf
sudo reboot
sudo lsmod | grep zfs

sudo dnf install -y zfs
/sbin/modprobe zfs
sudo zpool create gintra mirror /dev/sda /dev/sdb
sudo zfs set mountpoint=/mnt/gintra gintra
sudo zpool status gintra

# To see possible ZFS disks and stauses, in use, ID-s
zpool import
# Import By id. Importing ONLINE disk.
zpool import 3433150060417765046
zpool import -f 3433150060417765046

zpool list -v
zpool status
# Replacing unavailable 15767932045028996555 disk with /dev/sdb
zpool replace -f tank 15767932045028996555 /dev/sdb

# /dev/sdb is broken, then...
sudo zpool status gintra
sudo zpool offline gintra /dev/sdb
sudo zpool replace gintra /dev/sdb /dev/new
sudo zpool status gintra
```

Check disk to use


```
lsblk
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
