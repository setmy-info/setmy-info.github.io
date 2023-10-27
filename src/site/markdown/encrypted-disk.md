# Encrypted disk

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```shell
# Shows /dev/loop1
sudo losetup -Pf --show /home/has/temp/cd-images/cd-01.07.2006.img
ls /dev/loop*

#sudo cryptsetup open --type luks /dev/loop1 decrypted_loop
sudo cryptsetup open --type plain /dev/loop1 decrypted_loop
#sudo cryptsetup open --type dm-crypt /dev/loop1 decrypted_loop

sudo mount /dev/mapper/decrypted_loop /mnt/cd-image

# crypto release
sudo cryptsetup luksClose decrypted_loop

# Release loop
sudo losetup -d /dev/loop1
```

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
