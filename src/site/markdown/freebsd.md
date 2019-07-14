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

## See also

    [xxxx](http://yyyyy)
