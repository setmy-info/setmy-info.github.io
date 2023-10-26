# TFTP

## Information

## Installation

### CentOS, Rocky Linux

```shell
sudo dnf install -y tftp-server
sudo systemctl enable --now tftp
sudo systemctl restart tftp
sudo systemctl enable tftp
sudo systemctl status tftp
sudo lsof -i :69

sudo cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
cd /var/lib/tftpboot
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/boot.msg
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/grub.conf
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/initrd.img
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/isolinux.bin
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/isolinux.cfg
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/ldlinux.c32
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/libcom32.c32
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/libutil.c32
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/memtest
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/splash.png
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/vesamenu.c32
sudo wget https://download.rockylinux.org/pub/rocky/9.2/BaseOS/x86_64/kickstart/isolinux/vmlinuz
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
