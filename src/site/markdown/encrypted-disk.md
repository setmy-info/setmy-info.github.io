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
SUFFIX=19.06.2005
OUT_DIR=~/temp/cd-images
CD_IMAGE_FILE_NAME=cd-${SUFFIX}.img
CD_IMAGE_FILE_PATH=${OUT_DIR}/${CD_IMAGE_FILE_NAME}
mkdir -p ${OUT_DIR}
dd if=/dev/cdrom of=${CD_IMAGE_FILE_PATH}
sudo mkdir -p /mnt/cd-image
sudo mount -o loop,ro ${PREFIX}/${CD_NAME}.img /mnt/cd-image
sudo umount /mnt/cd-image
```

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
