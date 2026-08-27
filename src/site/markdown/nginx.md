# Nginx

## Information

## Installation

### CentOS, Rocky Linux, Fedora

```shell
# 1. Quick setup
sudo dnf install nginx
sudo systemctl enable --now nginx
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
curl http://localhost

# 2. Detailed
sudo dnf install nginx
nginx -v
sudo systemctl enable --now nginx
#sudo systemctl start nginx
#sudo systemctl enable nginx

## 2.1. Running checks
sudo systemctl status nginx
sudo systemctl is-active nginx
sudo systemctl is-enabled nginx
sudo ss -ltnp | grep ':80'
sudo ss -ltnp | grep ':443'
sudo journalctl -u nginx -n 50 --no-pager

## 2.2. Reconfigure: only reload if configuration is valid
sudo nginx -t && sudo systemctl reload nginx

## 2.3. Firewall OPEN
sudo firewall-cmd --state
sudo firewall-cmd --list-services
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
#sudo firewall-cmd --permanent --add-port={80/tcp,443/tcp}
sudo firewall-cmd --reload

## 2.4. Restart: only restart if configuration is valid
sudo nginx -t && sudo systemctl restart nginx

## 2.5. Firewall CLOSE
sudo firewall-cmd --permanent --remove-service=http
sudo firewall-cmd --permanent --remove-service=https
sudo firewall-cmd --reload

## 2.6. Stopping
sudo systemctl disable --now nginx
#sudo systemctl stop nginx
#sudo systemctl disable nginx
```

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

If SELinux doesn't allow to "share" at that location files. Use SELin tools for probes, to [switch off](selinux.md)
selinux etc.

```shell
ls -Z /tank
# Probably enough (or ZFS over fuze problem?)
chcon -R -t httpd_sys_content_t /tank
# If not enough try also
setsebool -P httpd_read_user_content 1
chcon -t unconfined_u:object_r:unlabeled_t:s0 /tank
```

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
