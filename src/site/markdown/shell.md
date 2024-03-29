# shell scripting

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```shell
PROJECT_NAME_BIN_DIR=${0}
PROJECT_NAME_BIN_DIR=${PROJECT_NAME_BIN_DIR%/*}
PROJECT_NAME_LIB_DIR=${PROJECT_NAME_BIN_DIR%/*}/lib
```

To avoid package suggestions for typos, edit **nano ~/.bashrc** and add the following line:

```shell
unset command_not_found_handle
```

Or remove [PackageKitCommandNotFound](https://fedoraproject.org/wiki/Features/PackageKitCommandNotFound)

```shell
sudo dnf remove PackageKit-command-not-found
```

```shell
source ~/.bashrc
```

```shell
# Recursive change folder reading
sudo find /run/media/has/d9ed8f72-bf7f-4fee-a246-41d2f6a49b3d -type d -exec chmod ugo+rwx {} \;
sudo find /run/media/has/d9ed8f72-bf7f-4fee-a246-41d2f6a49b3d -type f -exec chmod ugo+r {} \;
```

## See also

* [jq](https://jqlang.github.io/jq/)
* [yq](https://github.com/mikefarah/yq)
* [xxx](xxxx)
* [xxx](xxxx)
* [xxx](xxxx)
* [xxx](xxxx)

