# FreeBSD

## Information

## Installation

## Usage, tips and tricks

### sudo

    nano /usr/local/etc/sudoers
    %webteam   ALL=(ALL)       /usr/sbin/service webservice *
    or
    %wheel ALL=(ALL) ALL

### Mercurial

    Problem ;
    ESC[0;34;1mM ESC[0mESC[0;34;1mpf.confESC[0m
    echo $PAGER
	more
    PAGER=more
    nano ~/.profile
    export PAGER='less -X'

### Services

    https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/configtuning-starting-services.html

## DHCP

    Install:

    pkg install isc-dhcp44-server

## DNS

    Install:

    pkg install bind914

## /etc/rc.d file

Changing values in that file.

```bash
sysrc nginx_enable="YES"
```

## Nologin user adding

```bash
pw user add -n microservice -c 'microservice user' -d /nonexistent -s /usr/sbin/nologin
```

## Undeletable chroot files

```bash
chflags -R noschg ./*
```

## Jail

```bash
export FREE_BSD_VERSION=13.0-RELEASE
export JAILS_DIR=/var/jails
export BASE_JAIL_DIR=${JAILS_DIR}/base
export PAGER=cat

mkdir -p ${BASE_JAIL_DIR}
cd /var/jails

wget -c https://download.freebsd.org/ftp/releases/amd64/amd64/${FREE_BSD_VERSION}/base.txz
wget -c https://download.freebsd.org/ftp/releases/amd64/amd64/${FREE_BSD_VERSION}/ports.txz
wget -c https://download.freebsd.org/ftp/releases/amd64/amd64/${FREE_BSD_VERSION}/src.txz

tar -xf base.txz -C ${BASE_JAIL_DIR}
tar -xf ports.txz -C ${BASE_JAIL_DIR}
tar -xf src.txz -C ${BASE_JAIL_DIR}

freebsd-update -b ${BASE_JAIL_DIR} fetch
freebsd-update -b ${BASE_JAIL_DIR} install

pkg -c ${BASE_JAIL_DIR} update -q
pkg -c ${BASE_JAIL_DIR} upgrade -y
pkg -c ${BASE_JAIL_DIR} install -y bash mc nano ca_root_nss
pw -R ${BASE_JAIL_DIR} addgroup -n microservice
pw -R ${BASE_JAIL_DIR} adduser microservice -g microservice -d /nonexistent -s /usr/sbin/nologin -c "Microserice nologin user"
cp /etc/resolv.conf ${BASE_JAIL_DIR}/etc/resolv.conf
echo "sendmail_enable=NONE" > ${BASE_JAIL_DIR}/etc/rc.conf
echo "syslogd_flags=-ss" >> ${BASE_JAIL_DIR}/etc/rc.conf
echo "rpcbind_enable=NO" >> ${BASE_JAIL_DIR}/etc/rc.conf

cp /etc/resolv.conf ${BASE_JAIL_DIR}/etc/resolv.conf

cd ${JAILS_DIR} && tar cvzf base.tar.gz -C base .
```

Creating new jail from prepared base package

```bash
JAIL_NAME=newjail
export JAILS_DIR=/var/jails
mkdir -p ${JAILS_DIR}/${JAIL_NAME} && cd ${JAILS_DIR} && tar xvzf base.tar.gz -C ${JAILS_DIR}/${JAIL_NAME}
```

Add jail config

```bash
nano /etc/jail.conf
```

Content

```bash
newjail {
    host.hostname = newjail.intranet;
    ip4.addr = 10.0.0.10;
    interface = em0;
    path = "/var/jails/newjail";
    mount.devfs;
    exec.start = "/bin/sh /etc/rc";
    exec.stop = "/bin/sh /etc/rc.shutdown";
}
```

Start new jail

```bash
sysrc jail_enable=\"YES\"
sysrc jail_list=\"newjail\"
service jail start newjail
```

## NTPD leap seconds out of date

```sh
sysrc daily_ntpd_leapfile_enable=YES         # Fetch NTP leapfile
sysrc daily_ntpd_avoid_congestion=NO         # Avoid congesting leapfile sources
```

Alos fetch new:

```sh
service ntpd onefetch
```

## See also

    [xxxx](http://yyyyy)
