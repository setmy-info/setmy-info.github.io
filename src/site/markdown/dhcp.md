# DHCP

## Information

DHCP (Dynamic Host Configuration Protocol) is a network management protocol defined in RFC 2131. It automatically
assigns IP addresses, subnet masks, default gateways, DNS servers, and other network configuration parameters to
clients on a network.

**DHCPv4** covers IPv4 address assignment. **DHCPv6** (RFC 3315) covers IPv6 and uses multicast rather than broadcast.

The ISC DHCP server (`dhcpd`) is the traditional Linux implementation. ISC Kea is the modern successor with REST API
support, database backends, and active development.

## Installation

### CentOS, Rocky Linux

```shell
sudo dnf install dhcp-server -y
sudo firewall-cmd --add-port=67/udp --permanent
sudo firewall-cmd --reload
sudo systemctl enable dhcpd
sudo systemctl start dhcpd
sudo systemctl status dhcpd
```

### Fedora

```shell
sudo dnf install dhcp-server -y
```

### FreeBSD

```shell
pkg install isc-dhcp44-server
```

## Configuration

Main configuration file: `/etc/dhcp/dhcpd.conf`

```text
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

# PXE boot support
class "pxeclients" {
    match if substring(option vendor-class-identifier, 0, 9) = "PXEClient";
    next-server 10.0.0.2;
    filename "pxelinux.0";
}

subnet 10.0.0.0 netmask 255.0.0.0 {
    range 10.0.0.100 10.0.0.254;
}

# Static lease — assigns fixed address by MAC
host fedora {
    hardware ethernet 66:FB:8B:4F:AC:3A;
    fixed-address 10.0.0.11;
}
```

Key directives:

| Directive               | Purpose                                           |
|-------------------------|---------------------------------------------------|
| `default-lease-time`    | Lease duration (seconds) if client doesn't ask    |
| `max-lease-time`        | Maximum lease duration a client can request       |
| `option routers`        | Default gateway address                           |
| `option domain-name-servers` | DNS server addresses                        |
| `subnet` + `range`      | Dynamic address pool                              |
| `host` + `fixed-address` | Static (MAC-based) address assignment            |

## Usage, tips and tricks

Renew lease on a client:

```shell
sudo dhclient -r eth0   # release current lease
sudo dhclient eth0      # request new lease
```

Check active leases on the server:

```shell
cat /var/lib/dhcpd/dhcpd.leases
```

Verify the service is listening on UDP port 67:

```shell
sudo ss -ulnp | grep :67
```

## See also

* [ISC DHCP documentation](https://www.isc.org/dhcp/)
* [ISC Kea — modern DHCP server](https://www.isc.org/kea/)
* [RFC 2131](https://datatracker.ietf.org/doc/html/rfc2131)
* [Diskless booting](diskless.md)
