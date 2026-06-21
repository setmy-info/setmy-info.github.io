# Diskless

Diskless node, dumb terminal, diskless workstation (thin clients ?).

## Information

A diskless workstation (thin client) is a computer that boots entirely from the network — it has no local disk and
mounts its root filesystem over the network from a server. This simplifies maintenance: the OS image is managed
centrally and client nodes contain no persistent local state.

Core technologies:

| Technology | Role                                                              |
|------------|-------------------------------------------------------------------|
| PXE        | Pre-eXecution Environment — firmware-level network boot protocol  |
| TFTP       | Delivers the initial bootloader (`pxelinux.0`) and kernel images  |
| DHCP       | Assigns an IP address and points to the TFTP server               |
| NFS        | Serves the root filesystem read-only (and writable overlays)      |

## Installation

### CentOS, Rocky Linux

```shell
# Build the diskless root filesystem
sudo mkdir -p /var/opt/setmy.info/diskless/chroot
sudo dnf --releasever=9.2 \
  --disablerepo=docker-ce-stable,epel,nginx,nginx-stable,nginx-mainline,pgAdmin4,pgdg-common,pgdg16,pgdg15,pgdg14,pgdg13,pgdg12,pgdg11 \
  --installroot=/var/opt/setmy.info/diskless/chroot \
  -y install @core kernel nfs-utils dbus

# Writable overlay directories
sudo mkdir /var/opt/setmy.info/diskless/home
sudo chmod 777 /var/opt/setmy.info/diskless/home

sudo mkdir /var/opt/setmy.info/diskless/var
sudo chmod 777 /var/opt/setmy.info/diskless/var

sudo mkdir -p /var/opt/setmy.info/diskless/chroot/proc
sudo chmod 555 /var/opt/setmy.info/diskless/chroot/proc

# Install TFTP server
sudo dnf install -y tftp-server
sudo systemctl enable --now tftp
sudo systemctl restart tftp
sudo lsof -i :69

# Install DHCP server (for PXE boot)
sudo dnf install -y dhcp-server
```

## Configuration

### NFS exports

Edit `/etc/exports`:

```text
/var/opt/setmy.info/diskless/chroot *(ro,sync,no_root_squash)
/var/opt/setmy.info/diskless/home   *(rw,sync,no_root_squash)
/var/opt/setmy.info/diskless/var    *(rw,sync,no_root_squash)
```

Apply and restart:

```shell
sudo exportfs -r
sudo exportfs -v
sudo systemctl restart nfs-server.service
```

### fstab inside chroot

```shell
NFS_ROOT_SERVER_IP=10.0.0.2
sudo echo "proc /proc proc defaults 0 0" \
    > /var/opt/setmy.info/diskless/chroot/etc/fstab
sudo echo "${NFS_ROOT_SERVER_IP}:/var/opt/setmy.info/diskless/home /home nfs defaults 0 0" \
    >> /var/opt/setmy.info/diskless/chroot/etc/fstab
sudo echo "${NFS_ROOT_SERVER_IP}:/var/opt/setmy.info/diskless/var  /var  nfs defaults 0 0" \
    >> /var/opt/setmy.info/diskless/chroot/etc/fstab
```

### PXE boot configuration

```shell
sudo cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
sudo mkdir -p /var/lib/tftpboot/pxelinux.cfg/
sudo nano /var/lib/tftpboot/pxelinux.cfg/default
```

`/var/lib/tftpboot/pxelinux.cfg/default`:

```text
DEFAULT linux
    LABEL linux
    KERNEL /boot/vmlinuz-5.14.0-284.30.1.el9_2.x86_64
    APPEND initrd=initramfs-5.14.0-284.30.1.el9_2.x86_64.img root=/dev/nfs nfsroot=nfs.has.ee.gintra:/var/opt/setmy.info/diskless/chroot ip=dhcp rw
```

## Usage, tips and tricks

Enter the chroot to configure users:

```shell
sudo sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' \
    /var/opt/setmy.info/diskless/chroot/etc/selinux/config

getenforce
setenforce 0
sudo chroot /var/opt/setmy.info/diskless/chroot /bin/sh
sudo useradd USERNAME
sudo passwd USERNAME
exit
setenforce 1
```

## See also

* [DHCP](dhcp.md)
* [NFS](nfs.md)
* [ISC DHCP](https://www.isc.org/dhcp/)
* [Syslinux PXE](https://wiki.syslinux.org/wiki/index.php?title=PXELINUX)
