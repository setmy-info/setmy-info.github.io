# SELinux

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```shell
# Ge longer overview
sestatus
# Get enforcing level
getenforce
# Disable it for temporarily
sudo setenforce 0
# Set it back
sudo setenforce 1

sudo ausearch -m AVC -ts recent

sudo semanage port -l
sudo semanage port -l | grep http_port_t
sudo semanage port -l | grep '^http_port_t'

# Add to type http_port_t
sudo semanage port -a -t http_port_t -p tcp 5002
sudo semanage port -l | grep '^http_port_t'
sudo semanage port -l | grep 5002

# Delete port from type: http_port_t
sudo semanage port -d -t http_port_t -p tcp 5002
sudo semanage port -l | grep '^http_port_t'

```

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
