# Qemu

## Information

## Installation

### CentOS, Rocky Linux

```shell
dnf install qemu-kvm qemu-img libvirt virt-manager virt-install virt-viewer libvirt-client
lsmod | grep kvm
systemctl enable libvirt
systemctl start libvirt
systemctl status libvirtd
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

```shell
qemu-img create -f qcow2 freebsd.qcow2 20G
qemu-system-x86_64 -m 2048 -hda freebsd.qcow2 -cdrom /download/freebsd-install.iso -boot d
```

## See also

[xxxx](http://yyyyy)
