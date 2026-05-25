# HAProxy

## Information

HAProxy (High Availability Proxy) is a free, very fast and reliable open-source solution offering high availability, load balancing, and proxying for TCP and HTTP-based applications. It is particularly suited for very high traffic web sites and powers quite a number of the world's most visited ones.

### Main Functionalities and Features

*   **Layer 4 (TCP) and Layer 7 (HTTP) Load Balancing**: Efficiently distribute traffic at both transport and application layers.
*   **SSL/TLS Termination**: Handle SSL handshake and decryption to offload work from backend servers.
*   **Post-Quantum Cryptography (PQC)**: Support for quantum-resistant key exchange algorithms (requires OpenSSL 3.2+).
*   **Health Checking**: Automatically detect and remove failed backend servers from the rotation.
*   **High Availability**: Support for VRRP (via keepalived) and other mechanisms to ensure the proxy itself is not a single point of failure.
*   **Sticky Sessions**: Ensure a user stays connected to the same backend server (Persistence).
*   **Content Switching**: Route requests based on URL, headers, or other request attributes.
*   **DDoS Protection & Rate Limiting**: Built-in mechanisms to limit request rates and block abusive traffic.
*   **Detailed Metrics**: Real-time statistics via a dedicated stats page or API.

### Supported Load Balancing Algorithms

*   `roundrobin`: Each server is used in turns, according to their weights.
*   `leastconn`: The server with the lowest number of connections receives the request.
*   `first`: The first server with available connection slots receives the connection.
*   `source`: The source IP address is hashed and divided by the total weight of the running servers.
*   `uri`: The left part of the URI (before the question mark) is hashed.
*   `hdr(name)`: The HTTP header `name` is looked up in each request and hashed.
*   `random`: A random number is used as a hash key.

## Installation

### CentOS, Rocky Linux

```bash
sudo dnf install haproxy
```

### Fedora

```bash
sudo dnf install haproxy
```

### macOS

Install via Homebrew:
```bash
brew install haproxy
```

### FreeBSD

```bash
pkg install haproxy
```

### OpenIndiana

```bash
pkg install haproxy
```

## Setup with Docker for Developer

For local development, you can run HAProxy with a simple configuration to proxy to your local services and serve small static files.

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
  haproxy:
    image: haproxy:2.9
    container_name: haproxy-dev
    ports:
      - "80:80"
      - "8404:8404" # Stats page
    volumes:
      - ./haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro
      - ./static:/var/www/static:ro
```

**haproxy.cfg:**

```haproxy
global
    stats socket /var/run/api.sock user haproxy group haproxy mode 660 level admin
    stats timeout 30s

defaults
    mode http
    timeout connect 5000ms
    timeout client  50000ms
    timeout server  50000ms

frontend http-in
    bind *:80
    
    # Stats page
    stats enable
    stats uri /stats
    stats refresh 10s

    # Define ACLs for routing
    acl is_static path_beg /static/
    acl is_api path_beg /api/

    # Serving small static files directly (HAProxy 2.2+)
    # Note: For larger file sets, proxying to a web server is recommended.
    http-request return status 200 content-type "text/html" file /var/www/static/index.html if { path / }
    
    use_backend static_backend if is_static
    use_backend api_backend if is_api

backend static_backend
    # Example: Proxying to a simple local file server or another service
    server static_server 127.0.0.1:8080 check

backend api_backend
    balance roundrobin
    # Proxying to local network API servers
    server api_server_1 192.168.1.10:8080 check
    server api_server_2 192.168.1.11:8080 check
```

## Configuration

### Serving Static Files

While HAProxy is primarily a load balancer, it can serve static content in a few ways:

1.  **Native `http-request return`**: Suitable for small files (index, maintenance pages, robot.txt).
    ```haproxy
    http-request return status 200 content-type "text/plain" string "Hello World" if { path /hello }
    ```
2.  **Proxying to a Backend**: The standard way for production. HAProxy sits in front of a lightweight server like Nginx, Apache, or a dedicated static file server.

### Proxying to Local Network API Servers

HAProxy excels at routing traffic to internal services.

```haproxy
frontend api_gateway
    bind *:80
    acl host_api hdr(host) -i api.local
    use_backend local_apis if host_api

backend local_apis
    option httpchk GET /health
    http-check expect status 200
    server app1 10.0.0.5:8080 check
    server app2 10.0.0.6:8080 check
```

### SSL/TLS Termination

HAProxy is commonly used to terminate SSL/TLS connections, offloading the cryptographic work from backend servers.

1.  **Combined PEM**: HAProxy requires the certificate, any intermediate certificates, and the private key to be combined into a single `.pem` file.
    ```bash
    cat cert.crt intermediate.crt key.key > mysite.pem
    ```

2.  **Basic Configuration**:
    ```haproxy
    frontend https-in
        bind *:443 ssl crt /etc/ssl/certs/mysite.pem
        http-request set-header X-Forwarded-Proto https
        default_backend api_backend
    ```

3.  **Global Security Settings**:
    ```haproxy
    global
        # Modern security profile
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
        ssl-default-bind-options no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets
    ```

### Post-Quantum Cryptography (PQC)

Post-Quantum Cryptography (PQC) aims to be secure against attacks by quantum computers. HAProxy supports PQC when compiled with compatible libraries like **OpenSSL 3.2+** or **WolfSSL**.

To enable PQC hybrid key exchange (e.g., combining X25519 with Kyber/ML-KEM):

```haproxy
global
    # Enabling PQC curves (Requires OpenSSL 3.2+ or OQS provider)
    # x25519_kyber768 is a common hybrid group (ML-KEM)
    ssl-default-bind-curves x25519_kyber768:x25519:P-256
```

*Note: Client support is also required (e.g., modern Chrome/Firefox versions or specialized libraries).*

## Live Environment Setup

### Rocky Linux (systemd service)

1.  **Configure HAProxy**: Edit `/etc/haproxy/haproxy.cfg`.
2.  **Validate Configuration**:
    ```bash
    haproxy -c -f /etc/haproxy/haproxy.cfg
    ```
3.  **Enable and Start**:
    ```bash
    sudo systemctl enable --now haproxy
    ```

### Production Docker Setup

**docker-compose.prod.yaml:**

```yaml
version: '3.8'
services:
  haproxy:
    image: haproxy:2.9-alpine
    restart: always
    network_mode: "host" # Better performance for high traffic
    volumes:
      - /etc/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro
      - /etc/ssl/certs/mysite.pem:/etc/ssl/certs/mysite.pem:ro
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

## Usage, tips and tricks

### Coding tips and tricks

*   **Config Validation**: Always run `haproxy -c -f <file>` before restarting the service to catch syntax errors.
*   **Zero-Downtime Reloads**: Use `systemctl reload haproxy` which sends a `SIGUSR2` signal for seamless transition to the new configuration.
*   **Logging**: Use `option httplog` in the `defaults` or `frontend` section to get detailed request logs.
*   **Debugging Headers**: Add headers to responses to see which backend handled the request:
    ```haproxy
    http-response set-header X-Backend %s
    ```
*   **SSL termination**: Combine your certificate and private key into a single `.pem` file for HAProxy.
    ```bash
    cat cert.crt key.key > mysite.pem
    ```

## See also

* [HAProxy Official Website](https://www.haproxy.org/)
* [HAProxy Documentation](https://docs.haproxy.org/)
* [HAProxy Starter Guide](https://www.haproxy.com/blog/the-four-essential-sections-of-an-haproxy-configuration)
* [Serving Static Content with HAProxy](https://www.haproxy.com/blog/haproxy-2-2-adds-native-response-generation)
