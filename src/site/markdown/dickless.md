# Diskless

Diskless node, dumb terminal, diskless workstation (thin clients ?).

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```shell
sudo mkdir -p /var/opt/setmy.info/diskless/chroot
sudo dnf --releasever=9.2 --disablerepo=docker-ce-stable,epel,nginx,nginx-stable,nginx-mainline,pgAdmin4,pgdg-common,pgdg16,pgdg15,pgdg14,pgdg13,pgdg12,pgdg11 --installroot=/var/opt/setmy.info/diskless/chroot -y install @core kernel
sudo mkdir /var/opt/setmy.info/diskless/home
sudo chmod 777 /var/opt/setmy.info/diskless/home

sudo mkdir /var/opt/setmy.info/diskless/var
sudo chmod 777 /var/opt/setmy.info/diskless/var

sudo chroot /var/opt/setmy.info/diskless/chroot
sudo chroot /var/opt/setmy.info/diskless/chroot /bin/sh
exit
sudo nano /etc/exports
/var/opt/setmy.info/diskless/chroot *(ro,sync,no_root_squash)
/var/opt/setmy.info/diskless/home
 *(rw,sync,no_root_squash)
/var/opt/setmy.info/diskless/var
 *(rw,sync,no_root_squash)

exportfs -r
exportfs -v


sudo dnf install -y tftp-server
 systemctl enable --now tftp
sudo systemctl restart tftp
sudo systemctl enable tftp
sudo systemctl status tftp
sudo lsof -i :69

sudo cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
sudo mkdir -p /var/lib/tftpboot/pxelinux.cfg/
sudo nano /var/lib/tftpboot/pxelinux.cfg/default

DEFAULT linux
LABEL linux
KERNEL /boot/vmlinuz-5.14.0-284.30.1.el9_2.x86_64
APPEND initrd=initramfs-5.14.0-284.30.1.el9_2.x86_64.img root=/dev/nfs nfsroot=nfs.has.ee.gintra:/var/opt/setmy.info/diskless/chroot ip=dhcp rw

sudo dnf install -y dhcp-server
sudo nano /etc/dhcp/dhcpd.conf
```

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
