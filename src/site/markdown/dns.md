# DNS, Bind

## Information

## Installation

### CentOS, Rocky Linux

```sh
sudo dnf install -y bind bind-utils
sudo systemctl enable named
sudo systemctl start named
sudo systemctl status named

sudo firewall-cmd --get-zones
sudo firewall-cmd --get-active-zones
ip -br addr
#TCP/53 - AXFR/IXFR;  UDP/53 - DNS
#sudo firewall-cmd --permanent --zone=internal --change-interface=eno1
#sudo firewall-cmd --permanent --zone=internal --remove-interface=enp1s0
# OR
sudo firewall-cmd --permanent --zone=internal --add-source=192.168.1.0/24
sudo firewall-cmd --permanent --zone=internal --add-service=dns
sudo firewall-cmd --reload
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=internal --list-all

nslookup intranet.<ZONE_NAME> 10.0.0.2
dig @10.0.0.2 intranet.<ZONE_NAME>

systemd-resolve --status
sudo systemctl reload named
# For primary
dig @192.168.1.10 tenant1.gintra +short
dig @192.168.1.10 tenant1.test +short
# For secondary, after primary changes, to check is names getting over to secondary
dig @192.168.1.15 tenant2.gintra +short
dig @192.168.1.15 tenant2.test +short
resolvectl status
resolvectl dns


```

**sudo nano /etc/named.conf**

```
options {
	listen-on port 53 { 127.0.0.1; 10.0.0.2; 192.168.1.10; };
	# forward first;
	forwarders {
	    192.168.1.1;
	    10.0.0.1;
	    #127.0.0.1;
	};
	forward only;
	# ...
	allow-query     { localhost; 10.0.0.0/8; 192.168.1.0/24;};
	# ...
};
# ...
include "/etc/named/<ZONE_NAME>/index.zone";
```

**NB! /etc/named/<ZONE_NAME>/ is outdated form**

**sudo nano /etc/named/<ZONE_NAME>/index.zone**

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

**sudo nano /etc/named/<ZONE_NAME>/0.0.10.in-addr.arpa**

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

**sudo nano /etc/named/<ZONE_NAME>/<ZONE_NAME>.db**

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

**sudo nano /etc/named.conf**

```
    recursion yes;
	forwarders {
        192.168.1.1;
	};
	forward only;
    . . .
zone "gintra" IN {
    //type master;
    type primary;
    file "/var/named/gintra.zone";
    allow-transfer {
        192.168.1.15;
    };
    also-notify {
        192.168.1.15;
    };
};
zone "test" IN {
    //type master;
    type primary;
    file "/var/named/test.zone";
        allow-transfer {
        192.168.1.15;
    };
    also-notify {
        192.168.1.15;
    };
};
zone "1.168.192.in-addr.arpa" IN {
    //type master;
    type primary;
    file "/var/named/192.168.1.rev";
    allow-transfer {
        192.168.1.15;
    };
    also-notify {
        192.168.1.15;
    };
};

# FOR SLAVE
/*
zone "gintra" IN {
    type secondary;
    primaries {
        192.168.1.10;
    };
    file "/var/named/slaves/gintra.zone";
};
zone "test" IN {
    type secondary;
    primaries {
        192.168.1.10;
    };
    file "/var/named/slaves/test.zone";
};
zone "1.168.192.in-addr.arpa" IN {
    type secondary;
    primaries {
        192.168.1.10;
    };
    file "/var/named/slaves/192.168.1.rev";
};
*/
zone "." IN {
    type hint;
    file "/etc/named.ca";
};

include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";
```

**sudo nano /var/named/gintra.zone**

```
$TTL 3600
@       IN      SOA     ns1.gintra. admin.gintra. (
                        2026091601 ; serial
                        3600       ; refresh
                        900        ; retry
                        604800     ; expire
                        3600       ; minimum
                        )

        IN      NS      ns1.gintra.
        IN      NS      ns2.gintra.

ns1     IN      A       192.168.1.10
ns2     IN      A       192.168.1.15

tenant1 IN      A       192.168.1.10
tenant2 IN      A       192.168.1.10
```

**sudo nano /var/named/test.zone**

```
$TTL 3600
@       IN      SOA     ns1.test. admin.test. (
                        2026091601 ; serial
                        3600       ; refresh
                        900        ; retry
                        604800     ; expire
                        3600       ; minimum
                        )

        IN      NS      ns1.test.
        IN      NS      ns2.test.

ns1     IN      A       192.168.1.10
ns2     IN      A       192.168.1.15

tenant1 IN      A       192.168.1.10
tenant2 IN      A       192.168.1.10
```

**sudo nano /var/named/192.168.1.rev**

```
$TTL 3600
@       IN      SOA     ns1.gintra. admin.gintra. (
                        2026091601 ; serial
                        3600       ; refresh
                        900        ; retry
                        604800     ; expire
                        3600       ; minimum
                        )

        IN      NS      ns1.gintra.
        IN      NS      ns2.gintra.

10      IN      PTR     ns1.gintra.
15      IN      PTR     ns2.gintra.
```

* **sudo named-checkzone gintra /var/named/gintra.zone**
* **sudo named-checkzone test /var/named/test.zone**
* **sudo named-checkzone 1.168.192.in-addr.arpa /var/named/192.168.1.rev**
* **sudo named-checkconf**
* **sudo systemctl reload named**
* **dig @192.168.1.10 tenant1.gintra +short**
* **dig @192.168.1.10 tenant2.test +short**

* **sudo nano /etc/systemd/resolved.conf**

    [Resolve]
    DNS=127.0.0.1 192.168.1.10
    FallbackDNS=192.168.1.1
    Domains=~.

sudo systemctl restart systemd-resolved

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)

