# ZFSe

## Information

## Installation

### CentOS, Rocky Linux

Not tested!

```
sudo dnf install -y zfs
/sbin/modprobe zfs
sudo zpool create gintra mirror /dev/sda /dev/sdb
sudo zfs set mountpoint=/mnt/gintra gintra
sudo zpool status gintra

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
