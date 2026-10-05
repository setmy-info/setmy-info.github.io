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
sudo journalctl -t setroubleshoot --since "1 hour ago"

sudo semanage port -l
sudo semanage port -l | grep http_port_t
sudo semanage port -l | grep '^http_port_t'

# Add to type http_port_t web server with other ports also
sudo semanage port -a -t http_port_t -p tcp 5002
sudo semanage port -l | grep '^http_port_t'
sudo semanage port -l | grep 5002

# Delete port from type: http_port_t
sudo semanage port -d -t http_port_t -p tcp 5002
sudo semanage port -l | grep '^http_port_t'

ps axfZ

# List all context, check specific type and bt path
# For example: httpd_t - nginx process; httpd_log_t - log folder;
semanage fcontext -l
semanage fcontext -l | grep httpd_log_t
semanage fcontext -l | grep /var/log/nginx

semanage fcontext -a -t httpd_sys_content_t "/some/folder/www(/.*)?"
restorecon -Rv /some/folder/www

# httpd_config_t
ls -Z /etc/nginx
# httpd_log_t
# semanage fcontext -a -t httpd_log_t '/var/log/nginx(/.*)?'
ls -Z /var/log/nginx
# httpd_sys_content_t
ls -Z /usr/share/nginx/html
restorecon -Rv /var/log/nginx

sudo semanage port -a -t http_port_t -p tcp 8080
sudo semanage port -a -t http_port_t -p tcp 8081

# Try, not to apply, see what it woult like to change
restorecon -nRv /etc/nginx

ss -lntp | grep nginx

ausearch -m AVC -ts recent | grep -E 'nginx|httpd_t'
ausearch -c 'ps' --raw | audit2allow -M my-ps
semodule -X 300 -i my-ps.pp

```

* httpd_t
* httpd_config_t
* httpd_sys_content_t
* httpd_sys_rw_content_t
* httpd_log_t
* httpd_can_network_connect
* httpd_can_sendmail
* httpd_can_network_memcache
* httpd_read_user_content

* ssh_port_t

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
