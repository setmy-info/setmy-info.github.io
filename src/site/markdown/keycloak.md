# Keycloak

## Information

Keycloak is an open-source identity and access management solution for modern applications and services. It provides a comprehensive set of features to manage user authentication, authorization, and single sign-on (SSO).

### Main Functionalities and Features

*   **Single Sign-On (SSO)**: Users authenticate with Keycloak rather than individual applications.
*   **Standard Protocols**: Support for OpenID Connect (OIDC), OAuth 2.0, and SAML 2.0.
*   **Identity Brokering**: Login with social networks (Google, GitHub, Facebook) or other SAML/OIDC identity providers.
*   **User Federation**: Integration with LDAP and Active Directory servers to sync user data.
*   **Admin Console**: Centralized management for realms, clients, users, and roles.
*   **Account Management Console**: Allows users to manage their own profiles, passwords, and two-factor authentication.
*   **Authorization Services**: Fine-grained authorization policies to secure services and resources.

### Supported Protocols and Token Algorithms

Keycloak supports a wide range of cryptographic algorithms for signing and encrypting tokens:
*   **Signing Algorithms**: RS256 (default), RS384, RS512, ES256, ES384, ES512, HS256, HS384, HS512, PS256, PS384, PS512, EdDSA.
*   **Hashing Algorithms**: SHA-256, SHA-384, SHA-512.

## Installation

### CentOS, Rocky Linux

1.  **Install Java**:
    ```bash
    sudo dnf install java-21-openjdk-devel
    ```
2.  **Download Keycloak**:
    ```bash
    wget https://github.com/keycloak/keycloak/releases/download/25.0.2/keycloak-25.0.2.tar.gz
    tar -xvzf keycloak-25.0.2.tar.gz
    sudo mv keycloak-25.0.2 /opt/keycloak
    ```

### Fedora

1.  **Install Java**:
    ```bash
    sudo dnf install java-21-openjdk-devel
    ```
2.  Download and install Keycloak similarly to CentOS/Rocky.

### macOS

Install via Homebrew:
```bash
brew install keycloak
```

### FreeBSD

1.  **Install Java**:
    ```bash
    pkg install openjdk21
    ```
2.  Download and extract the Keycloak tarball to `/usr/local/share/keycloak`.

### OpenIndiana

1.  **Install Java**:
    ```bash
    pkg install jdk-21
    ```
2.  Download and extract the Keycloak tarball.

## Setup with Docker for Developer

For local development, you can start Keycloak in "Dev Mode" using Docker Compose.

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
  keycloak:
    image: quay.io/keycloak/keycloak:25.0.2
    container_name: keycloak-dev
    environment:
      - KC_BOOTSTRAP_ADMIN_USERNAME=admin
      - KC_BOOTSTRAP_ADMIN_PASSWORD=admin
    ports:
      - "8080:8080"
    command: start-dev
```

Start with:
```bash
docker-compose up -d
```

## Configuration

### Live Environment Setup

For production, Keycloak should use a persistent database and run in "Production Mode".

#### Storage Requirements (PostgreSQL)

Keycloak supports several databases. PostgreSQL is highly recommended for stability and performance.

**Production Docker Setup (`docker-compose.prod.yaml`):**

```yaml
version: '3.8'
services:
  postgres:
    image: postgres:16
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: keycloak
      POSTGRES_USER: keycloak
      POSTGRES_PASSWORD: password

  keycloak:
    image: quay.io/keycloak/keycloak:25.0.2
    depends_on:
      - postgres
    environment:
      KC_DB: postgres
      KC_DB_URL: jdbc:postgresql://postgres:5432/keycloak
      KC_DB_USERNAME: keycloak
      KC_DB_PASSWORD: password
      KC_HOSTNAME: sso.example.com
      KC_BOOTSTRAP_ADMIN_USERNAME: admin
      KC_BOOTSTRAP_ADMIN_PASSWORD: changeme
    ports:
      - "8080:8080"
    command: start

volumes:
  postgres_data:
```

#### Rocky Linux (systemd service)

1.  **Create a dedicated user**:
    ```bash
    sudo useradd -r -s /sbin/nologin keycloak
    sudo chown -R keycloak: /opt/keycloak
    ```

2.  **Create the service file**:
    `sudo nano /etc/systemd/system/keycloak.service`

    ```ini
    [Unit]
    Description=Keycloak Server
    After=network.target

    [Service]
    Type=simple
    User=keycloak
    Group=keycloak
    WorkingDirectory=/opt/keycloak
    Environment=JAVA_HOME=/usr/lib/jvm/java-21-openjdk
    Environment=KC_DB=postgres
    # Add other KC_ variables for production here
    ExecStart=/opt/keycloak/bin/kc.sh start --optimized
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

3.  **Enable and start**:
    ```bash
    sudo systemctl daemon-reload
    sudo systemctl enable --now keycloak
    ```

## Use Cases and CLI Tools

### Setting up Auth0-like functionality with `kcadm.sh`

Keycloak provides a CLI tool `kcadm.sh` (located in `bin` directory) to manage the server from the command line.

#### 1. Authenticate CLI
```bash
/opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password admin
```

#### 2. Create a new Realm (e.g., Auth0 Tenant)
```bash
/opt/keycloak/bin/kcadm.sh create realms -s realm=my-webapp -s enabled=true
```

#### 3. Create a Web App Client (Public)
Equivalent to a "Single Page Application" in Auth0.
```bash
/opt/keycloak/bin/kcadm.sh create clients -r my-webapp -s clientId=frontend -s publicClient=true -s 'redirectUris=["http://localhost:3000/*"]' -s enabled=true
```

#### 4. Create a Machine-to-Machine (M2M) Client
For microservices communication without a user.
```bash
/opt/keycloak/bin/kcadm.sh create clients -r my-webapp -s clientId=microservice-client -s serviceAccountsEnabled=true -s secret=my-client-secret -s enabled=true
```

#### 5. Get M2M Token (via curl)
```bash
curl --request POST \
  --url http://localhost:8080/realms/my-webapp/protocol/openid-connect/token \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data grant_type=client_credentials \
  --data client_id=microservice-client \
  --data client_secret=my-client-secret
```

#### 6. Revoke Token (Blacklist) via curl
Keycloak supports RFC 7009 to revoke tokens (typically refresh tokens). Revoking a refresh token also invalidates the associated session.

```bash
curl --request POST \
  --url http://localhost:8080/realms/my-webapp/protocol/openid-connect/revoke \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data token=YOUR_REFRESH_TOKEN \
  --data client_id=microservice-client \
  --data client_secret=my-client-secret
```

#### 7. Logout (End Session) via curl
To explicitly log out a user/session using a refresh token:

```bash
curl --request POST \
  --url http://localhost:8080/realms/my-webapp/protocol/openid-connect/logout \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data refresh_token=YOUR_REFRESH_TOKEN \
  --data client_id=microservice-client \
  --data client_secret=my-client-secret
```

### Spring Boot Integration (JWT)

To use Keycloak as an OAuth2 Resource Server in a Spring Boot application:

1.  **Add Dependency**:
    ```xml
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-oauth2-resource-server</artifactId>
    </dependency>
    ```

2.  **Configuration (`application.yml`)**:
    ```yaml
    spring:
      security:
        oauth2:
          resourceserver:
            jwt:
              issuer-uri: http://localhost:8080/realms/my-webapp
    ```

3.  **Security Logic**:
    Spring Security will automatically fetch the public keys from Keycloak's `.well-known/openid-configuration` and validate incoming JWTs.

## Usage, tips and tricks

### Coding tips and tricks

*   **Token Inspection**: Use [jwt.io](https://jwt.io) to inspect tokens issued by Keycloak to check roles and scopes.
*   **CORS**: Ensure "Web Origins" settings in your Client configuration include your frontend URL (e.g., `http://localhost:3000`).
*   **Token Lifespan**: Adjust "Access Token Lifespan" in Realm settings to balance security and user experience.
*   **Blacklisting (Revocation Policy)**: To immediately invalidate all tokens issued before a certain time, use the "Revocation" tab in the Realm settings and click "Set to now" then "Push". This effectively "blacklists" all currently active JWTs by setting a `not-before` policy.
*   **Custom Themes**: Keycloak allows customizing login, account, and admin pages via the `themes` directory.

## See also

* [Keycloak Home Page](https://www.keycloak.org/)
* [Keycloak Documentation](https://www.keycloak.org/documentation)
* [Keycloak Guides](https://www.keycloak.org/guides)
* [Customizing Themes Guide](https://wjw465150.gitbooks.io/keycloak-documentation/content/server_admin/topics/realms/themes.html)
* [Baeldung: Keycloak Custom Login Page](https://www.baeldung.com/keycloak-custom-login-page)
