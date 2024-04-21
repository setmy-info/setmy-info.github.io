# Qemu

## Information

## Installation

### CentOS, Rocky Linux

```shell
dnf group list --available
sudo dnf groupinstall -y "Server with GUI" "Virtualization Host"
sudo dnf install qemu-kvm qemu-img libvirtd libvirt virt-manager virt-install virt-viewer libvirt-client
sudo usermod -aG libvirt $(whoami)
lsmod | grep kvm
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd
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
