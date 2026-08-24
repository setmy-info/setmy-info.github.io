# Traefik

## Information

Traefik is a modern, open-source HTTP reverse proxy and load balancer designed to make deploying microservices and web
applications effortless. It automatically routes incoming traffic, terminates SSL/TLS, and supports zero-downtime hot
reloading of configurations without restarting the service.

## Installation

Traefik is distributed as a single self-contained Go binary with no external runtime dependencies.

### CentOS, Rocky Linux, RHEL

Download the binary from GitHub releases and place it into `/usr/local/bin`:

```bash
TRAEFIK_VERSION=$(curl -s https://api.github.com/repos/traefik/traefik/releases/latest | grep tag_name | cut -d '"' -f 4)
wget https://github.com/traefik/traefik/releases/download/${TRAEFIK_VERSION}/traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz

sudo tar -xvzf traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz -C /usr/local/bin traefik
sudo chmod +x /usr/local/bin/traefik
rm -f traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz

traefik version
```

### Fedora

```bash
TRAEFIK_VERSION=$(curl -s https://api.github.com/repos/traefik/traefik/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -L -O https://github.com/traefik/traefik/releases/download/${TRAEFIK_VERSION}/traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz
sudo tar -xvzf traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz -C /usr/local/bin traefik
sudo chmod +x /usr/local/bin/traefik
rm -f traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz

traefik version
```

### Debian, Ubuntu

```bash
TRAEFIK_VERSION=$(curl -s https://api.github.com/repos/traefik/traefik/releases/latest | grep tag_name | cut -d '"' -f 4)
wget https://github.com/traefik/traefik/releases/download/${TRAEFIK_VERSION}/traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz

sudo tar -xvzf traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz -C /usr/local/bin traefik
sudo chmod +x /usr/local/bin/traefik
rm -f traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz

traefik version
```

### macOS

Install via Homebrew:

```bash
brew install traefik
traefik version
```

Or download the binary manually:

```bash
TRAEFIK_VERSION=$(curl -s https://api.github.com/repos/traefik/traefik/releases/latest | grep tag_name | cut -d '"' -f 4)
# For Apple Silicon (M1/M2/M3/M4):
curl -L -O https://github.com/traefik/traefik/releases/download/${TRAEFIK_VERSION}/traefik_${TRAEFIK_VERSION}_darwin_arm64.tar.gz
sudo tar -xvzf traefik_${TRAEFIK_VERSION}_darwin_arm64.tar.gz -C /usr/local/bin traefik
# For Intel:
# curl -L -O https://github.com/traefik/traefik/releases/download/${TRAEFIK_VERSION}/traefik_${TRAEFIK_VERSION}_darwin_amd64.tar.gz
# sudo tar -xvzf traefik_${TRAEFIK_VERSION}_darwin_amd64.tar.gz -C /usr/local/bin traefik

sudo chmod +x /usr/local/bin/traefik
traefik version
```

### Windows

Download the release zip and extract `traefik.exe` using PowerShell:

```powershell
$ProgressPreference = 'SilentlyContinue'
$version = (Invoke-RestMethod -Uri https://api.github.com/repos/traefik/traefik/releases/latest).tag_name
$targetDir = "$env:LOCALAPPDATA\Programs\traefik"

New-Item -ItemType Directory -Force -Path $targetDir
Invoke-WebRequest -Uri "https://github.com/traefik/traefik/releases/download/$version/traefik_${version}_windows_amd64.zip" -OutFile "$targetDir\traefik.zip"
Expand-Archive -Path "$targetDir\traefik.zip" -DestinationPath $targetDir -Force
Remove-Item "$targetDir\traefik.zip"

# Add to user PATH if not present
if ($env:Path -notlike "*$targetDir*") {
    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";$targetDir", [EnvironmentVariableTarget]::User)
    $env:Path += ";$targetDir"
}

traefik version
```

### FreeBSD

```bash
pkg install traefik
# Or download the binary from GitHub releases
```

### OpenIndiana

```bash
# Build from source with Go:
go install github.com/traefik/traefik/v3/cmd/traefik@latest
```

## Plain Host Service for Developer (Quick Development)

For local development without Docker, run Traefik directly on the host machine. Traefik separates configuration into:

1. **Static Configuration** (`traefik.yml`): Entrypoints, providers, logging, and dashboard/API setup. Loaded once on
   startup.
2. **Dynamic Configuration** (`dynamic.yml` or watched directory): Routers, middlewares, and services. Watched and
   hot-reloaded instantly when modified without restarting Traefik.

### Quick Start with CLI Flags

For an immediate test without configuration files:

```bash
traefik \
  --api.insecure=true \
  --api.dashboard=true \
  --entrypoints.web.address=:80 \
  --providers.file.directory=./dynamic \
  --providers.file.watch=true
```

### Developer File-Based Configuration

Create a local configuration workspace:

```bash
mkdir -p ~/.config/traefik/dynamic
```

**Static Configuration (`~/.config/traefik/traefik.yml`):**

```yaml
# Global settings
global:
    checkNewVersion: false
    sendAnonymousUsage: false

# Traefik Web UI Dashboard and API (insecure mode enables dev dashboard on port 8080)
api:
    dashboard: true
    insecure: true

# Entry points on the host
entryPoints:
    web:
        address: ":80"
    websecure:
        address: ":443"

# File provider to watch dynamic configuration files
providers:
    file:
        directory: "~/.config/traefik/dynamic"
        watch: true

# Logging
log:
    level: INFO
    format: common

accessLog:
    format: common
```

**Dynamic Configuration (`~/.config/traefik/dynamic/dev-routes.yml`):**

```yaml
http:
    # Routers match incoming requests and connect them to services
    routers:
        # Route http://localhost or http://app.localhost to frontend dev server
        frontend-router:
            rule: "Host(`app.localhost`) || (Host(`localhost`) && !PathPrefix(`/api`))"
            entryPoints:
                - web
            service: frontend-service

        # Route http://api.localhost or http://localhost/api to backend service
        backend-router:
            rule: "Host(`api.localhost`) || PathPrefix(`/api`)"
            entryPoints:
                - web
            middlewares:
                - strip-api-prefix
                - dev-cors
            service: backend-service

        # Route http://mock.localhost to mock server
        mock-router:
            rule: "Host(`mock.localhost`)"
            entryPoints:
                - web
            service: mock-service

    # Middlewares customize request/response handling
    middlewares:
        strip-api-prefix:
            stripPrefix:
                prefixes:
                    - "/api"

        dev-cors:
            headers:
                accessControlAllowMethods:
                    - "GET"
                    - "POST"
                    - "PUT"
                    - "DELETE"
                    - "OPTIONS"
                accessControlAllowOriginList:
                    - "*"
                accessControlAllowHeaders:
                    - "*"

    # Services define backend destinations on the local host
    services:
        frontend-service:
            loadBalancer:
                servers:
                    -   url: "http://127.0.0.1:3000" # E.g. Vite, Next.js, or Angular dev server

        backend-service:
            loadBalancer:
                servers:
                    -   url: "http://127.0.0.1:8000" # E.g. FastAPI, Spring Boot, or Express backend

        mock-service:
            loadBalancer:
                servers:
                    -   url: "http://127.0.0.1:9090" # E.g. WireMock or mock API
```

### Running Directly on Host

Start Traefik with the static configuration:

```bash
traefik --configfile=~/.config/traefik/traefik.yml
```

Access developer endpoints:

* **Developer Web Dashboard**: `http://localhost:8080/dashboard/`
* **Dynamic API Info**: `http://localhost:8080/api/rawdata`
* **Proxied Applications**:
    * `http://localhost/` -> Proxies to frontend (`127.0.0.1:3000`)
    * `http://localhost/api/users` -> Proxies to backend (`127.0.0.1:8000/users`)
    * `http://app.localhost/` -> Proxies to frontend (`127.0.0.1:3000`)
    * `http://api.localhost/` -> Proxies to backend (`127.0.0.1:8000`)

### Running as a Systemd Host Service (Linux)

To run Traefik permanently in the background on your developer machine:

**`/etc/systemd/system/traefik.service`:**

```ini
[Unit]
Description=Traefik Edge Router & Reverse Proxy
Documentation=https://doc.traefik.io/traefik/
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=traefik
Group=traefik
ExecStart=/usr/local/bin/traefik --configfile=/etc/traefik/traefik.yml
Restart=on-failure
RestartSec=3s
LimitNOFILE=65536
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
```

Setup and start the service:

```bash
sudo useradd -r -s /bin/false traefik
sudo mkdir -p /etc/traefik/dynamic
sudo cp ~/.config/traefik/traefik.yml /etc/traefik/traefik.yml
sudo cp ~/.config/traefik/dynamic/dev-routes.yml /etc/traefik/dynamic/dev-routes.yml
sudo chown -R traefik:traefik /etc/traefik

sudo systemctl daemon-reload
sudo systemctl enable --now traefik
sudo systemctl status traefik
```

### Running as a User Systemd Service (Rootless / Non-Root)

For developers without root privileges, configure Traefik on unprivileged ports (e.g. `8080` for web, `8443` for TLS,
`9000` for dashboard):

**`~/.config/traefik/traefik.yml` (Rootless):**

```yaml
api:
    dashboard: true
    insecure: true

entryPoints:
    web:
        address: ":8088"
    traefik:
        address: ":9000"

providers:
    file:
        directory: "%h/.config/traefik/dynamic"
        watch: true
```

**`~/.config/systemd/user/traefik.service`:**

```ini
[Unit]
Description=Traefik Developer User Service
After=default.target

[Service]
ExecStart=%h/bin/traefik --configfile=%h/.config/traefik/traefik.yml
Restart=always
RestartSec=3s

[Install]
WantedBy=default.target
```

Enable and start user service:

```bash
systemctl --user daemon-reload
systemctl --user enable --now traefik
systemctl --user status traefik
```

### Developer SSL/TLS Setup with `mkcert` (Local HTTPS)

To test secure routes locally without browser certificate warnings:

1. **Install and generate certificates with `mkcert`**:
   ```bash
   mkcert -install
   mkdir -p ~/.config/traefik/certs
   cd ~/.config/traefik/certs
   mkcert localhost "*.localhost" 127.0.0.1 ::1
   ```

2. **Add TLS configuration (`~/.config/traefik/dynamic/tls.yml`)**:
   ```yaml
   tls:
     certificates:
       - certFile: /home/username/.config/traefik/certs/localhost+3.pem
         keyFile: /home/username/.config/traefik/certs/localhost+3-key.pem
     stores:
       default:
         defaultCertificate:
           certFile: /home/username/.config/traefik/certs/localhost+3.pem
           keyFile: /home/username/.config/traefik/certs/localhost+3-key.pem
   ```

3. **Attach `tls: true` to your routers**:
   ```yaml
   http:
     routers:
       secure-app:
         rule: "Host(`app.localhost`)"
         entryPoints:
           - websecure
         service: frontend-service
         tls: {}
   ```

## Useful Middlewares for Development

### Basic Authentication Middleware

```yaml
http:
    middlewares:
        dev-auth:
            basicAuth:
                # User: admin, Password: password (generated via htpasswd -nb admin password)
                users:
                    - "admin:$apr1$9z2t7x1.$oKzN28W9TfVz2Jc0V8Qy7."
```

### Rate Limiting Middleware

```yaml
http:
    middlewares:
        dev-rate-limit:
            rateLimit:
                average: 100
                burst: 50
```

### HTTP to HTTPS Redirect

```yaml
http:
    middlewares:
        dev-redirect-https:
            redirectScheme:
                scheme: https
                permanent: true
```

## Useful CLI Commands

* **Print Version**:
  ```bash
  traefik version
  ```
* **Verify Configuration Syntax**:
  ```bash
  traefik --configfile=~/.config/traefik/traefik.yml
  ```
* **Check Traefik Health**:
  ```bash
  traefik healthcheck
  ```

## See also

* [HAProxy](haproxy.md)
* [Nginx](nginx.md)
* [Squid](squid.md)
* [Zeebe](zeebe.md)
* [Dagu](dagu.md)
* [Hosts and Ports](it/architecture/enterprise-architecture/hosts-ports.md)
* [Official Traefik Documentation](https://doc.traefik.io/traefik/)
* [Traefik GitHub Repository](https://github.com/traefik/traefik)
