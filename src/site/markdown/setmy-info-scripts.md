# setmy-info-scripts

## Information

## Installation and usage

### CentOS

### Fedora

### FreeBSD

    make clear && rm -Rf CMakeFiles/ Makefile

    echo DEVELOPER=yes >> /etc/make.conf

    sudo make dist

    make makesum

    sudo make install-dist

    sudo make dist makesum install-dist

    sudo make

    sudo make clean-dist

    sudo make clean-dist dist makesum install-dist && sudo make && sudo make install

    sudo make deinstall

### OpenIndiana

## Configuration

## TODO

1. Makefile build without C/C++ check, add bash check instead
2. Add FreeBSD package build.
3. pre scripts to add for install and uninstall
4. DONE: Add Changelog file. Add some other fields too for RPM information.
5. DONE: clean target
6. DONE: etc profile.d
7. Try .term then in installation location profiles
8. make remove or deinstall to uninstall files
9. Set of commands

smi-init
smi-network-add
Network segments: Networks addresses and routers, short name
smi-domain-add
DNS, DHCP, xyx.ee, xyz.lan, zones,
https://www.quackit.com/domain-names/reserved_top-level_domains.cfm
smi-company-add
name, reg, code and other, contacts: certs generation, NFS pools, qotas,etc etc,
smi-node-add
machine name, network(s), domain name(s), IPs/DHCP, MAC, software and sw.groups (dev, office, minimal), services
smi-jail-create
smi-backup
smi-timestamp
smi-uuid
uuidgen
smi-person-add
first, last, birth, email, GPG, etc

smi-vcs-type or -command
smi-vcs-pull
smi-vcs-update
smi-vcs-add
smi-vcs-commit

term -> smi-term
Kubernetes
Docker
Docker compose

Fix man pages: /opt/xyz/share/man

10.

https://www.openca.org/
https://www.openca.org/projects/ocspd/
kerberos

## Usage, tips and tricks

## See also

[xxxx](http://yyyyy)
