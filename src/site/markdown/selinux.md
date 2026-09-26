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

semanage fcontext -a -t httpd_sys_content_t "/some/folder/www(/.*)?"
restorecon -Rv /some/folder/www

ls -Z /etc/nginx
ls -Z /var/log/nginx
restorecon -Rv /var/log/nginx

```

* httpd_sys_content_t
* httpd_sys_rw_content_t
* httpd_log_t
* httpd_can_network_connect
* httpd_can_sendmail
* httpd_can_network_memcache
* httpd_read_user_content

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
