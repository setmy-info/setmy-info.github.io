# DNS, Bind

## Information

## Installation

### CentOS, Rocky Linux

```sh
sudo dnf install -y bind bind-utils
sudo systemctl enable named
sudo systemctl start named
sudo firewall-cmd --zone=trusted --add-source=10.0.0.0/8 --permanent
sudo firewall-cmd --zone=trusted --add-service=ssh --permanent
sudo firewall-cmd --zone=trusted --add-service=dns --permanen
nslookup intranet.<ZONE_NAME> 10.0.0.2
dig @10.0.0.2 intranet.<ZONE_NAME>
```

**nano /etc/named.conf**

```
options {
	listen-on port 53 { 127.0.0.1; 10.0.0.2; };
	# forward first;
	forwarders {
	    192.168.1.1;
	    10.0.0.1;
	    #127.0.0.1;
	};
	# ...
};
# ...
include "/etc/named/<ZONE_NAME>/index.zone";
```

**nano /etc/named/<ZONE_NAME>/index.zone**

```
zone "0.0.10.in-addr.arpa" {
    type master;
    allow-query { 10.0.0.0/8; };
    file "/etc/named/<ZONE_NAME>/0.0.10.in-addr.arpa";
};
zone "<ZONE_NAME>" {
    type master;
    allow-query { 10.0.0.0/8; };
    file "/etc/named/<ZONE_NAME>/<ZONE_NAME>.db";
};

```

**nano /etc/named/<ZONE_NAME>/0.0.10.in-addr.arpa**

```
;
; BIND reverse data file for 0.0.10.in-addr.arpa
;
$TTL    604800
0.0.10.in-addr.arpa.      IN      SOA     ns1.<ZONE_NAME>. root.<ZONE_NAME>. (
                          1         ; Serial
                          3h       ; Refresh after 3 hours
                          1h       ; Retry after 1 hour
                          1w       ; Expire after 1 week
                          1h )     ; Negative caching TTL of 1 day
;
0.0.10.in-addr.arpa.       IN      NS      ns1.<ZONE_NAME>.

2.0.0.10.in-addr.arpa.   IN      PTR     abcdf.<ZONE_NAME>.
```

**nano /etc/named/<ZONE_NAME>/<ZONE_NAME>.db**

```
$TTL    3H
@               IN      SOA     ns1.<ZONE_NAME>.      root.<ZONE_NAME>. (
                        2009091114 ; serial
                        3H ; refresh
                        15M ; retry
                        4W ; expire
                        3H ; Negative caching TTL of 1 hour
                        )

abcdf.<ZONE_NAME>.   3w      IN      MX  10   mail.<ZONE_NAME>.
<ZONE_NAME>.            IN      NS      ns1.<ZONE_NAME>.
router.<ZONE_NAME>.     IN      A       10.0.0.1
; intranet web
intranet.<ZONE_NAME>.   IN      A       10.0.0.2
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)

