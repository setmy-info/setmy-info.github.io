# Encrypted disk

## Information

Disk encryption protects data at rest. Even if storage media is physically removed, encrypted data is unreadable
without the correct passphrase or key.

**LUKS** (Linux Unified Key Setup) is the standard full-disk encryption mechanism for Linux. It uses dm-crypt under
the hood and supports multiple key slots (up to 8 passphrases or key files per device).

Two common use cases:

- **Full-disk / partition encryption**: encrypt a block device at setup time.
- **Image file encryption**: encrypt a disk image file (loopback device), useful for portable encrypted containers.

## Installation

### CentOS, Rocky Linux

`cryptsetup` is typically pre-installed. Verify:

```shell
cryptsetup --version
```

Install if missing:

```shell
sudo dnf install -y cryptsetup
```

### Fedora

```shell
sudo dnf install -y cryptsetup
```

### Debian

```shell
sudo apt install -y cryptsetup
```

### FreeBSD

FreeBSD uses GELI instead of LUKS:

```shell
pkg install geli
```

## Configuration

### LUKS on a block device

```shell
# Format a device (destroys all data)
sudo cryptsetup luksFormat /dev/sdX

# Open (map to /dev/mapper/my_volume)
sudo cryptsetup luksOpen /dev/sdX my_volume

# Create filesystem
sudo mkfs.ext4 /dev/mapper/my_volume

# Mount
sudo mount /dev/mapper/my_volume /mnt/data

# Close
sudo cryptsetup luksClose my_volume
```

### Automounting with /etc/crypttab

`/etc/crypttab` format: `<name> <device> <keyfile> <options>`

```text
my_volume  /dev/sdX  none  luks
```

Pair with `/etc/fstab`:

```text
/dev/mapper/my_volume  /mnt/data  ext4  defaults  0 2
```

## Usage, tips and tricks

Open a loop-mounted disk image (plain dm-crypt):

```shell
# Attach image as loop device
sudo losetup -Pf --show /home/has/temp/cd-images/cd-01.07.2006.img
ls /dev/loop*

# Open the loop device
sudo cryptsetup open --type plain /dev/loop1 decrypted_loop
# For LUKS: sudo cryptsetup open --type luks /dev/loop1 decrypted_loop

# Mount
sudo mount /dev/mapper/decrypted_loop /mnt/cd-image

# Close and release
sudo cryptsetup luksClose decrypted_loop
sudo losetup -d /dev/loop1
```

Check LUKS header info:

```shell
sudo cryptsetup luksDump /dev/sdX
```

Add a second passphrase (key slot):

```shell
sudo cryptsetup luksAddKey /dev/sdX
```

## See also

* [cryptsetup documentation](https://gitlab.com/cryptsetup/cryptsetup)
* [LUKS specification](https://gitlab.com/cryptsetup/cryptsetup/-/wikis/LUKS-standard)
* [dm-crypt wiki](https://wiki.archlinux.org/title/dm-crypt)
