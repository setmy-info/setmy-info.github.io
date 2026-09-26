# firewald

## Information

## Installation

### Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

```shell
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --list-all-zones
sudo ip link show
# wlp3s0
sudo firewall-cmd --get-zone-of-interface=wlp3s0

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
#sudo firewall-cmd --permanent --add-port={80/tcp,443/tcp}
sudo firewall-cmd --reload

sudo firewall-cmd --permanent --remove-service=http
sudo firewall-cmd --permanent --remove-service=https
sudo firewall-cmd --reload

# --zone=public

```

## See also

* [xxxx](http://yyyyy)
