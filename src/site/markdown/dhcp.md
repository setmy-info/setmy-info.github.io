# DHCP

## Information

## Installation

```shell
sudo dnf install dhcp-server -y
sudo firewall-cmd --add-port=67/udp --permanent
sudo firewall-cmd --reload
sudo systemctl enable dhcpd
sudo systemctl start dhcpd
sudo systemctl status dhcp-server
```

Example file:

    default-lease-time 600;
    max-lease-time 7200;
    option subnet-mask 255.0.0.0;
    option broadcast-address 10.255.255.255;
    option routers 10.0.0.1;
    option domain-name-servers 10.0.0.2, 10.0.0.2;
    option domain-search "has.ee.gintra";
    next-server 10.0.0.2;

    # Interface where DHCP should work
    #interface eth0;

    # Probalby PXE boot works without these
    #allow booting;
    #allow bootp;

    class "pxeclients" {
    match if substring(option vendor-class-identifier, 0, 9) = "PXEClient";
    next-server 10.0.0.2;
    filename "pxelinux.0";
    }

    subnet 10.0.0.0 netmask 255.0.0.0 {
    range 10.0.0.100 10.0.0.254;
    }

    host fedora {
    hardware ethernet 66:FB:8B:4F:AC:3A;
    fixed-address 10.0.0.11;
    }

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
