# Solaris

## Information

About Solaris, OpenIndiana, OpenSolaris etc OS

Solaris is a Unix-based operating system originally developed by Sun Microsystems, now maintained by Oracle as Oracle
Solaris. The open-source fork OpenSolaris was discontinued in 2010, but the community continued development as
**illumos**, which forms the basis of **OpenIndiana**, OmniOS, SmartOS, and other distributions.

Key Solaris/illumos characteristics:

* **ZFS**: advanced filesystem with copy-on-write, snapshots, built-in RAID, and data integrity checking. See [zfs.md](zfs.md).
* **Zones**: lightweight OS-level virtualisation (similar to Linux containers but predating Docker).
* **SMF**: Service Management Facility — a robust service supervisor replacing init scripts.
* **DTrace**: dynamic tracing framework for kernel and application performance analysis.
* **IPS**: Image Packaging System — the native package manager on OpenIndiana and OmniOS.

## Installation

Download OpenIndiana from [openindiana.org](https://www.openindiana.org/download/).

After installation, update the system:

```shell
pkg update
```

## Configuration

### IPS Package Manager

The Image Packaging System (`pkg`) manages software on OpenIndiana:

```shell
# Update package list and upgrade all packages
pkg update
# Search for a package
pkg search keyword
# Install a package
pkg install package/name
# Remove a package
pkg uninstall package/name
# List installed packages
pkg list
# Show package info
pkg info package/name
# Add a publisher (repository)
pkg set-publisher -g https://pkg.openindiana.org/hipster openindiana.org
```

### Service Management (SMF)

SMF replaces traditional init scripts with a dependency-aware service supervisor:

```shell
# List all services
svcs
# List all services including disabled
svcs -a
# Show service status
svcs service-name
# Start a service
svcadm enable service-name
# Stop a service
svcadm disable service-name
# Restart a service
svcadm restart service-name
# Show service log
svcs -l service-name
# Show service manifest properties
svcprop service-name
```

## Usage, tips and tricks

### Zones

Zones provide lightweight OS-level virtualisation:

```shell
# List zones
zoneadm list -v
# Create a zone config
zonecfg -z myzone
# Install a zone
zoneadm -z myzone install
# Boot a zone
zoneadm -z myzone boot
# Log into a zone console
zlogin myzone
# Halt a zone
zoneadm -z myzone halt
```

### ZFS

ZFS is the primary filesystem. See [zfs.md](zfs.md) for full documentation. Quick reference:

```shell
# List pools
zpool list
# List datasets
zfs list
# Create a snapshot
zfs snapshot pool/dataset@snapname
# List snapshots
zfs list -t snapshot
# Roll back to snapshot
zfs rollback pool/dataset@snapname
```

### DTrace

DTrace is a dynamic tracing framework for performance analysis and debugging:

```shell
# Trace system calls for a process
dtrace -n 'syscall:::entry /pid == $target/ { @[probefunc] = count(); }' -p PID
# One-liner: count syscalls by name
dtrace -n 'syscall:::entry { @[probefunc] = count(); }'
```

## See also

* [OpenIndiana official site](https://www.openindiana.org/)
* [illumos project](https://illumos.org/)
* [Oracle Solaris documentation](https://docs.oracle.com/en/operating-systems/solaris/)
* [ZFS](zfs.md)
* [Linux](linux.md)
* [FreeBSD](freebsd.md)
