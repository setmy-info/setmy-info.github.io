# ZFS

## Information

## Installation

### CentOS, Rocky Linux

Not tested!

```
sudo rpm -e --nodeps zfs-fuse
sudo dnf install https://zfsonlinux.org/epel/zfs-release-2-3$(rpm --eval "%{dist}").noarch.rpm
sudo dnf install -y epel-release
sudo dnf install -y kernel-devel
sudo dnf install -y zfs
sudo /sbin/modprobe zfs
sudo echo zfs > /etc/modules-load.d/zfs.conf
sudo reboot
sudo lsmod | grep zfs

# TEST
sudo dd if=/dev/zero of=/tmp/fake-devide-imageake-1.img bs=1M count=100
sudo dd if=/dev/zero of=/tmp/fake-devide-imageake-2.img bs=1M count=100
sudo dd if=/dev/zero of=/tmp/fake-devide-imageake-3.img bs=1M count=100
sudo zpool create testing mirror /tmp/fake-devide-imageake-1.img /tmp/fake-devide-imageake-2.img
sudo mkdir /mnt/testing
sudo zfs set mountpoint=/mnt/testing testing
sudo zpool status
sudo zpool status testing
sudo zpool list -v
sudo zpool offline testing /tmp/fake-devide-imageake-2.img
sudo zpool replace testing /tmp/fake-devide-imageake-2.img /tmp/fake-devide-imageake-3.img
sudo zpool status testing
zpool attach testing /tmp/fake-devide-imageake-3.img /tmp/fake-devide-imageake-2.img
sudo zpool status testing
sudo zpool detach testing /tmp/fake-devide-imageake-3.img
sudo zpool status testing
sudo zpool destroy testing
sudo rm /tmp/fake-devide-imageake-1.img
sudo rm /tmp/fake-devide-imageake-2.img
sudo rm /tmp/fake-devide-imageake-3.img

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
