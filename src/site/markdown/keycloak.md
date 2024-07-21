# Keycloak

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

sudo nano /etc/systemd/system/keycloak.service

```
[Unit]
Description=Keycloak Server
After=network.target

[Service]
ExecStart=/opt/keycloak/bin/kc.sh start-dev
User=keycloak
Group=keycloak
Restart=always
Environment=JAVA_HOME=/opt/jdk
Environment=KEYCLOAK_ADMIN=admin
Environment=KEYCLOAK_ADMIN_PASSWORD=changeme

[Install]
WantedBy=multi-user.target
```

```
sudo useradd keycloak --shell /sbin/nologin --no-create-home
sudo chown -R keycloak:keycloak /opt/keycloak-25.0.2/
#sudo firewall-cmd --add-port=11222/tcp --permanent
#sudo firewall-cmd --reload
sudo systemctl enable keycloak
sudo systemctl start keycloak
```

[Home page](https://www.keycloak.org/)
https://wjw465150.gitbooks.io/keycloak-documentation/content/server_admin/topics/realms/themes.html
https://www.baeldung.com/keycloak-custom-login-page
