# Nginx

## Information

## Installation

### CentOS, Rocky Linux, Fedora

```shell
# 1. Quick setup
sudo dnf install -y nginx
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

## 2.3. DEPRECATED: Firewall OPEN. We nftables
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --state
sudo firewall-cmd --list-services
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
#sudo firewall-cmd --permanent --add-service=http --zone=internal
#sudo firewall-cmd --permanent --add-service=https --zone=internal
#sudo firewall-cmd --permanent --add-port={80/tcp,443/tcp}
sudo firewall-cmd --reload

## 2.4.1
getenforce
ps -eZ | grep nginx
ls -Zd /usr/share/nginx/html
ls -lZ /usr/share/nginx/html
ls -Zd /usr/share/nginx/html/index.html
ls -lZ /usr/share/nginx/html/index.html 
sudo semanage port -l | grep '^http_port_t'
sudo firewall-cmd --list-all
sudo ss -lntp | grep ':80'
sudo ausearch -m AVC -ts recent | grep nginx
sudo journalctl -k | grep -i 'avc\|selinux'
sudo journalctl | grep -i 'avc\|selinux'
sudo semanage port -a -t http_port_t -p tcp 7070
sudo semanage port -l | grep 7070
sudo ausearch -m AVC -ts recent | audit2allow -M nginx-localhost-7070
sudo semodule -i nginx-localhost-7070.pp
sudo semodule -l | grep nginx-localhost-7070

### 2.4.2
#sudo k3s kubectl patch svc traefik -n kube-system -p '{"spec":{"type":"ClusterIP"}}'
#sudo k3s kubectl get pods -n kube-system -o wide
#sudo nft list ruleset | grep -E 'dport 80|dport 443'

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

# List all context, check specific type and bt path
semanage fcontext -l
semanage fcontext -l | grep httpd_log_t
semanage fcontext -l | grep /var/log/nginx
semanage fcontext -l | grep /usr/share/nginx
semanage fcontext -l | grep /etc/nginx
semanage port -l | grep http_port_t
ps -eZ | grep nginx

mkdir -p /var/log/nginx
chown root:root /var/log/nginx
chmod u=rwx,g=rx,o=rx /var/log/nginx
# r w x - 4 2 1
chmod 755 /var/log/nginx
restorecon -Rv /var/log/nginx

chown -R root:root /usr/share/nginx/vhosts
chmod u=rwx,g=rx,o=rx /usr/share/nginx/vhosts
chmod 755 /usr/share/nginx/vhosts
find /usr/share/nginx/vhosts -type d -exec chmod u=rwx,g=rx,o=rx {} \;
find /usr/share/nginx/vhosts -type f -exec chmod u=rw,g=r,o=r {} \;
find /usr/share/nginx/vhosts -type d -exec chmod 755 {} \;
find /usr/share/nginx/vhosts -type f -exec chmod 644 {} \;
semanage fcontext -a -t httpd_sys_content_t '/usr/share/nginx/vhosts(/.*)?'
restorecon -Rv /usr/share/nginx/vhosts
ls -laZ /usr/share/nginx/vhosts

chown -R root:root /usr/share/nginx/errors
find /usr/share/nginx/errors -type d -exec chmod u=rwx,g=rx,o=rx {} \;
find /usr/share/nginx/errors -type f -exec chmod u=rw,g=r,o=r {} \;
semanage fcontext -a -t httpd_sys_content_t '/usr/share/nginx/errors(/.*)?'
restorecon -Rv /usr/share/nginx/errors
ls -laZ /usr/share/nginx/errors

chown -R root:root /usr/share/nginx/acme
find /usr/share/nginx/acme -type d -exec chmod u=rwx,g=rx,o=rx {} \;
find /usr/share/nginx/acme -type f -exec chmod u=rw,g=r,o=r {} \;
semanage fcontext -a -t httpd_sys_content_t '/usr/share/nginx/acme(/.*)?'
restorecon -Rv /usr/share/nginx/acme
ls -laZ /usr/share/nginx/acme

systemctl list-timers | grep -i certbot
systemctl cat certbot-renew.service

# Try, not to apply, see what it woult like to change
restorecon -nRv /etc/nginx

chown -R root:root /etc/nginx
find /etc/nginx -type d -exec chmod u=rwx,g=rx,o=rx {} \;
# No files changes, some files (map) should not be changed 
restorecon -Rv /etc/nginx
ls -laZ /etc/nginx

getenforce
ss -lntp | grep nginx

grep -RniE 'listen[[:space:]]+(8080|8081|8883)' /etc/nginx
semanage port -l | grep -E '8080|8081|8883|1883'
semanage port -l | grep vhost_nginx_port_t

cd /opt/setmy.info/lib/selinux/vhost
checkmodule -M -m -o vhost_ports.mod vhost_ports.te
semodule_package -o vhost_ports.pp -m vhost_ports.mod
semodule -i vhost_ports.pp

checkmodule -M -m -o vhost_nginx.mod vhost_nginx.te
semodule_package -o vhost_nginx.pp -m vhost_nginx.mod
semodule -i vhost_nginx.pp

checkmodule -M -m -o vhost_nginx_mqtt.mod vhost_nginx_mqtt.te
semodule_package -o vhost_nginx_mqtt.pp -m vhost_nginx_mqtt.mod
semodule -i vhost_nginx_mqtt.pp

checkmodule -M -m -o vhost_haproxy.mod vhost_haproxy.te
semodule_package -o vhost_haproxy.pp -m vhost_haproxy.mod
semodule -i vhost_haproxy.pp

semanage port -a -t vhost_nginx_port_t -p tcp 8080
semanage port -a -t vhost_nginx_port_t -p tcp 8081
semanage port -a -t vhost_nginx_port_t -p tcp 8883

sesearch -A -s httpd_t -t vhost_nginx_port_t
sesearch -A -s httpd_t -t vhost_nginx_port_t
sesearch -A -s httpd_t -t vhost_mqtt_port_t

# NB! httpd_can_network_connect --> off
getsebool httpd_can_network_connect

# In Intranet, lets emulate LetsEncrypt
sudo install -d -m 0755 /etc/letsencrypt
sudo install -d -m 0750 -o root -g nginx /etc/letsencrypt/live /etc/letsencrypt/archive
sudo restorecon -RF /etc/letsencrypt
sudo ls -ldZ /etc/letsencrypt /etc/letsencrypt/live /etc/letsencrypt/archive /etc/pki /etc/pki/nginx
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
