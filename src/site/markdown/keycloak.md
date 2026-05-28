# Keycloak

## Information

Keycloak is an open-source identity and access management platform for applications, APIs, microservices, and internal portals. In practice it is commonly used as a self-hosted alternative to managed identity platforms when teams need control over login flows, federation, client configuration, token settings, and realm-level security policies.

### Main Functionalities and Features

* **Single Sign-On (SSO)**: Users authenticate with Keycloak rather than each individual application.
* **Standard Protocols**: Supports `OpenID Connect (OIDC)`, `OAuth 2.0`, and `SAML 2.0`.
* **Identity Brokering**: Can delegate login to social providers or other `OIDC` / `SAML` identity providers.
* **User Federation**: Connects to `LDAP` and `Active Directory` for external user storage and synchronization.
* **Realms, Clients, Users, Roles, Groups**: Centralized tenant-style separation and access modeling.
* **Authorization Services**: Fine-grained policies and permissions for protected APIs and services.
* **Service Accounts / Machine-to-Machine**: Supports confidential clients and token issuance for backend services.
* **Admin Console and Admin REST API**: Web UI and automation interfaces for provisioning and operations.
* **Account Console**: End users can manage profile data, passwords, sessions, and MFA settings.
* **Required Actions and Authentication Flows**: Supports password reset, profile completion, OTP enrollment, email verification, and custom login flow design.
* **Token Exchange / Session Management / Offline Tokens**: Useful for modern web apps, mobile apps, and backend integrations.
* **Themes and Extensions**: Login pages, account pages, and providers can be customized.

### Common Developer Use Cases

* Protect a `Spring Boot` API as an `OAuth2 Resource Server`.
* Use Keycloak like an `Auth0`-style tenant for local development and internal environments.
* Issue access tokens for `SPA`, backend, CLI, and machine-to-machine clients.
* Federate enterprise users from `LDAP` / `AD` while keeping application-facing `OIDC` flows modern.
* Centralize role / scope handling for multiple microservices.

### Supported Protocols and Token Algorithms

Keycloak supports a broad set of classical cryptographic algorithms for signing and validating tokens:

* **Token Signing Algorithms**: `RS256` (common default), `RS384`, `RS512`, `PS256`, `PS384`, `PS512`, `ES256`, `ES384`, `ES512`, `HS256`, `HS384`, `HS512`, `EdDSA`.
* **Hashing Algorithms**: `SHA-256`, `SHA-384`, `SHA-512`.
* **Protocols**: `OIDC`, `OAuth 2.0`, `SAML 2.0`.

Notes:

* In many installations, `RSA`-based signing remains the most common default for compatibility.
* Algorithm availability and defaults can vary slightly by Keycloak version, realm key setup, provider configuration, and Java crypto support.
* For application teams, the most important compatibility item is usually whether downstream clients, API gateways, and frameworks can validate the selected realm signing algorithm.

### Post-Quantum Cryptography (PQC) Notes

Keycloak is still primarily deployed with classical cryptography. For Keycloak, `PQC` readiness is mainly an **edge, transport, and crypto-agility planning topic**, not a sign that realm keys and token signatures are already natively post-quantum.

Key points:

* **Realm signing keys are mainly classical today**. Typical deployments sign tokens with `RSA`, `EC`, or similar classical algorithms.
* **`PQC` will likely arrive at the transport layer first**. Reverse proxies, ingress controllers, load balancers, service meshes, and `TLS` libraries may adopt hybrid `PQC` before application-layer token standards do.
* **Application crypto agility matters**. Downstream services should validate issuer metadata dynamically and avoid assumptions that token algorithms will never change.
* **Long-retention identity data needs planning**. Session stores, exported realm configs, audit logs, and long-lived trust relationships should be documented so future migration is manageable.

### Making a Keycloak Deployment More PQC-Ready

The practical meaning of “make Keycloak PQC-ready” usually is:

1. Keep token verification logic standards-based and algorithm-agile.
2. Use modern `TLS` configurations at the reverse proxy / ingress layer and track hybrid `PQC` support there.
3. Automate key rotation, certificate rotation, and realm export / import procedures.
4. Keep inventories of which apps depend on which issuers, audiences, scopes, and signature algorithms.
5. Avoid hard-coding public keys into applications when discovery or `JWKS` endpoints can be used instead.

## Installation

### CentOS, Rocky Linux

1. **Install Java**:
   ```bash
   sudo dnf install -y java-21-openjdk-devel
   ```
2. **Download Keycloak**:
   ```bash
   curl -L -o keycloak-25.0.2.tar.gz https://github.com/keycloak/keycloak/releases/download/25.0.2/keycloak-25.0.2.tar.gz
   tar -xzf keycloak-25.0.2.tar.gz
   sudo mv keycloak-25.0.2 /opt/keycloak
   ```
3. **Optional first run check**:
   ```bash
   /opt/keycloak/bin/kc.sh --help
   ```

### Fedora

1. **Install Java**:
   ```bash
   sudo dnf install -y java-21-openjdk-devel
   ```
2. Download and extract the Keycloak tarball similarly to `CentOS` / `Rocky Linux`.

### macOS

If a suitable package is available in your environment, a package-manager install may be convenient, but many teams still prefer the official distribution archive for version-pinned setups.

Example with Homebrew:

```bash
brew install keycloak
```

If you need a version that exactly matches your server estate, download the official archive and run it locally instead.

### FreeBSD

1. **Install Java**:
   ```bash
   pkg install openjdk21
   ```
2. Download and extract the Keycloak tarball to a suitable path such as `/usr/local/share/keycloak`.

### OpenIndiana

1. **Install Java**:
   ```bash
   pkg install jdk-21
   ```
2. Download and extract the Keycloak tarball.

## Setup with Docker for Developer

For developer machines, the simplest path is usually a disposable `start-dev` deployment. This is ideal for local testing, login flow experiments, CLI automation, and app integration work.

### Docker Compose

Create a `docker-compose.yaml` file:

```yaml
version: '3.8'
services:
    keycloak:
        image: quay.io/keycloak/keycloak:25.0.2
        container_name: keycloak-dev
        environment:
            KC_BOOTSTRAP_ADMIN_USERNAME: admin
            KC_BOOTSTRAP_ADMIN_PASSWORD: admin
        ports:
            - "8080:8080"
        command:
            - start-dev
```

Start it:

```bash
docker compose up -d
```

Developer notes:

* `start-dev` is intentionally simplified and is **not** a live / production profile.
* For throwaway local testing, the default in-container database is often good enough.
* If you want to preserve realm changes across restarts, prefer mounting data only when the selected image / setup explicitly supports your intended persistence model, or use an external `PostgreSQL` container even in local development.
* After first start, open `http://localhost:8080` and sign in with the bootstrap admin credentials.

### Developer Setup with PostgreSQL

If you want a local environment that behaves more like production, use a separate `PostgreSQL` container:

```yaml
version: '3.8'
services:
    postgres:
        image: postgres:16
        environment:
            POSTGRES_DB: keycloak
            POSTGRES_USER: keycloak
            POSTGRES_PASSWORD: keycloak-dev-password
        volumes:
            - postgres_data:/var/lib/postgresql/data

    keycloak:
        image: quay.io/keycloak/keycloak:25.0.2
        depends_on:
            - postgres
        environment:
            KC_BOOTSTRAP_ADMIN_USERNAME: admin
            KC_BOOTSTRAP_ADMIN_PASSWORD: admin
            KC_DB: postgres
            KC_DB_URL: jdbc:postgresql://postgres:5432/keycloak
            KC_DB_USERNAME: keycloak
            KC_DB_PASSWORD: keycloak-dev-password
        ports:
            - "8080:8080"
        command:
            - start-dev

volumes:
    postgres_data:
```

This pattern is useful if developers want to keep local realms, clients, groups, users, themes, and test data between restarts.

## Configuration

### Live Environment Setup

For live environments, Keycloak should run against a persistent external database, behind proper `TLS`, with explicit hostname configuration, controlled secrets handling, and repeatable deployment automation.

#### Storage Requirements (`PostgreSQL`)

Keycloak supports several databases, but `PostgreSQL` is commonly the preferred live choice for stability, performance, and operational familiarity.

Typical live requirements:

* Persistent `PostgreSQL` storage with tested backup / restore procedures.
* Stable `DNS` name for the externally visible Keycloak hostname.
* `TLS` termination either directly in front of Keycloak or at a trusted reverse proxy / ingress.
* Explicit handling of admin bootstrap credentials, database credentials, and any external identity-provider secrets.
* Monitoring for JVM health, startup failures, database reachability, and login / token endpoint behavior.

#### Production Docker Setup (`docker-compose.prod.yaml`)

```yaml
version: '3.8'
services:
    postgres:
        image: postgres:16
        restart: unless-stopped
        environment:
            POSTGRES_DB: keycloak
            POSTGRES_USER: keycloak
            POSTGRES_PASSWORD: change-this-db-password
        volumes:
            - postgres_data:/var/lib/postgresql/data

    keycloak:
        image: quay.io/keycloak/keycloak:25.0.2
        restart: unless-stopped
        depends_on:
            - postgres
        environment:
            KC_DB: postgres
            KC_DB_URL: jdbc:postgresql://postgres:5432/keycloak
            KC_DB_USERNAME: keycloak
            KC_DB_PASSWORD: change-this-db-password
            KC_HOSTNAME: sso.example.com
            KC_PROXY_HEADERS: xforwarded
            KC_HTTP_ENABLED: true
            KC_BOOTSTRAP_ADMIN_USERNAME: admin
            KC_BOOTSTRAP_ADMIN_PASSWORD: change-this-admin-password
        ports:
            - "8080:8080"
        command:
            - start

volumes:
    postgres_data:
```

Production notes:

* Replace inline passwords with environment files, container secrets, or a separate secret-management system.
* If `TLS` terminates at a reverse proxy, ensure forwarded headers and hostname settings are correct.
* Treat bootstrap admin credentials as installation-time secrets; rotate or restrict them after initial setup.

#### Rocky Linux (`systemd` service)

1. **Create a dedicated user**:
   ```bash
   sudo useradd -r -s /sbin/nologin keycloak
   sudo chown -R keycloak:keycloak /opt/keycloak
   sudo mkdir -p /etc/keycloak
   sudo chown root:keycloak /etc/keycloak
   ```

2. **Create an environment file**:
   `sudo nano /etc/keycloak/keycloak.conf`

   ```bash
   KC_DB=postgres
   KC_DB_URL=jdbc:postgresql://db.example.internal:5432/keycloak
   KC_DB_USERNAME=keycloak
   KC_DB_PASSWORD=change-this-db-password
   KC_HOSTNAME=sso.example.com
   KC_PROXY_HEADERS=xforwarded
   KC_HTTP_ENABLED=true
   KC_BOOTSTRAP_ADMIN_USERNAME=admin
   KC_BOOTSTRAP_ADMIN_PASSWORD=change-this-admin-password
   ```

3. **Create the service file**:
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
   EnvironmentFile=/etc/keycloak/keycloak.conf
   ExecStart=/opt/keycloak/bin/kc.sh start --optimized
   Restart=always
   RestartSec=10
   LimitNOFILE=65536

   [Install]
   WantedBy=multi-user.target
   ```

4. **Enable and start**:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now keycloak
   ```

5. **Review startup logs**:
   ```bash
   sudo journalctl -u keycloak -f
   ```

#### Post-Startup Checks for Live Environments

After the service is up, confirm at least the following:

1. The login page resolves at the expected public hostname.
2. Admin login works with the intended credentials.
3. The configured realm issuer matches the externally visible URL.
4. `/.well-known/openid-configuration` is reachable for the realm.
5. Token issuance works for at least one test client.
6. Reverse-proxy and forwarded-header behavior does not generate wrong redirect URLs.

## Use Cases and CLI Tools

### Setting up Auth0-like functionality with `kcadm.sh`

Keycloak provides the `kcadm.sh` CLI tool in the `bin` directory for server automation and scripting.

#### 1. Authenticate CLI

```bash
/opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password admin
```

#### 2. Create a New Realm (like an Auth0 Tenant)

```bash
/opt/keycloak/bin/kcadm.sh create realms -s realm=my-webapp -s enabled=true
```

#### 3. Create a Web App Client (Public)

Equivalent to a typical `SPA` / browser-based frontend client:

```bash
/opt/keycloak/bin/kcadm.sh create clients -r my-webapp -s clientId=frontend -s publicClient=true -s 'redirectUris=["http://localhost:3000/*"]' -s 'webOrigins=["http://localhost:3000"]' -s enabled=true
```

#### 4. Create a Machine-to-Machine (`M2M`) Client

For backend services communicating without an end-user session:

```bash
/opt/keycloak/bin/kcadm.sh create clients -r my-webapp -s clientId=microservice-client -s serviceAccountsEnabled=true -s secret=my-client-secret -s enabled=true
```

#### 5. Get `M2M` Token via `curl`

```bash
curl --request POST \
  --url http://localhost:8080/realms/my-webapp/protocol/openid-connect/token \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data grant_type=client_credentials \
  --data client_id=microservice-client \
  --data client_secret=my-client-secret
```

#### 6. Get User Token via Password Grant for Testing

For local testing only, some teams temporarily use direct username / password token requests. Avoid this flow for real frontend design unless you explicitly understand the security and standards implications.

```bash
curl --request POST \
  --url http://localhost:8080/realms/my-webapp/protocol/openid-connect/token \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data grant_type=password \
  --data client_id=frontend \
  --data username=test.user \
  --data password=test-password \
  --data scope=openid
```

#### 7. Revoke Token (Blacklist) via `curl`

Keycloak supports `RFC 7009` token revocation, typically applied to refresh tokens. Revoking a refresh token usually invalidates the associated session path.

```bash
curl --request POST \
  --url http://localhost:8080/realms/my-webapp/protocol/openid-connect/revoke \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data token=YOUR_REFRESH_TOKEN \
  --data client_id=microservice-client \
  --data client_secret=my-client-secret
```

#### 8. Logout (End Session) via `curl`

```bash
curl --request POST \
  --url http://localhost:8080/realms/my-webapp/protocol/openid-connect/logout \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data refresh_token=YOUR_REFRESH_TOKEN \
  --data client_id=microservice-client \
  --data client_secret=my-client-secret
```

#### 9. Export a Realm

For migration, backup, or local promotion workflows, realm export is often useful:

```bash
/opt/keycloak/bin/kc.sh export --dir /tmp/keycloak-export --realm my-webapp
```

### Simple Microservice-Oriented Setup Flow

A common local workflow for `Spring Boot` or other API teams is:

1. Start local Keycloak.
2. Create a realm such as `my-webapp`.
3. Create a public frontend client.
4. Create a confidential backend / service-account client.
5. Create realm roles such as `user`, `admin`, `service-api`.
6. Assign roles to test users or service accounts.
7. Configure backend applications with the realm issuer URL.
8. Call the token endpoint and test protected APIs with the resulting bearer tokens.

### Spring Boot Integration (`JWT`)

To use Keycloak as an `OAuth2 Resource Server` in a `Spring Boot` application:

1. **Add dependency**:
   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-oauth2-resource-server</artifactId>
   </dependency>
   ```

2. **Configure issuer (`application.yml`)**:
   ```yaml
   spring:
     security:
       oauth2:
         resourceserver:
           jwt:
             issuer-uri: http://localhost:8080/realms/my-webapp
   ```

3. **Security logic**:
   Spring Security will automatically use the realm `.well-known/openid-configuration` and `JWKS` endpoint to validate incoming `JWT`s.

### Java Example with `WebClient`

```java
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

public class KeycloakClientCredentialsExample {
    public static void main(String[] args) {
        WebClient client = WebClient.builder()
            .baseUrl("http://localhost:8080")
            .build();

        String tokenResponse = client.post()
            .uri("/realms/my-webapp/protocol/openid-connect/token")
            .contentType(MediaType.APPLICATION_FORM_URLENCODED)
            .body(BodyInserters
                .fromFormData("grant_type", "client_credentials")
                .with("client_id", "microservice-client")
                .with("client_secret", "my-client-secret"))
            .retrieve()
            .bodyToMono(String.class)
            .block();

        System.out.println(tokenResponse);
    }
}
```

### Python Example with `requests`

```python
import requests

response = requests.post(
    "http://localhost:8080/realms/my-webapp/protocol/openid-connect/token",
    headers={"Content-Type": "application/x-www-form-urlencoded"},
    data={
        "grant_type": "client_credentials",
        "client_id": "microservice-client",
        "client_secret": "my-client-secret",
    },
    timeout=30,
)

response.raise_for_status()
print(response.json())
```

## Usage, tips and tricks

### Coding Tips and Tricks

* **Token inspection**: Use [jwt.io](https://jwt.io) or a local decoder to inspect issued tokens and verify claims, roles, scopes, issuer, and audience.
* **CORS**: Ensure client `Web Origins` include the frontend URL such as `http://localhost:3000`.
* **Token lifespan**: Adjust realm and client token lifespans carefully to balance security and UX.
* **Blacklisting / Not-Before Policy**: To invalidate previously issued tokens, use the realm revocation settings and set the realm `not-before` time.
* **Service account roles**: Remember that `client_credentials` tokens usually get permissions from the service account role mappings, not from end-user assignments.
* **Issuer correctness matters**: Mismatched hostname or reverse-proxy settings frequently break token validation in downstream apps.
* **Themes and extensions**: Keep custom themes and providers under version control and test them against each Keycloak upgrade.

### Backup and Restore Notes

Unlike `Vault` / `OpenBao`, Keycloak is usually not backed up by taking application-level snapshots of an internal encrypted storage engine. In most real deployments, the critical backup scope is the **database plus configuration and custom artifacts**.

#### Developer / Local Machine Backups

For local environments, first decide whether the setup is disposable:

* **Simple `start-dev` lab**: often disposable and may not need backup.
* **Developer setup with persistent `PostgreSQL`**: should be backed up if it contains reusable realm definitions, test users, client secrets, or custom themes/providers.

Recommended local backup scope:

* Database dump of the local `PostgreSQL` instance if used.
* Exported realm configuration for important local realms.
* Custom themes, provider `JAR`s, scripts, and environment files.
* Notes about test users, client IDs, redirect URIs, and any external identity-provider credentials used for development.

Example local database backup:

```bash
pg_dump -h 127.0.0.1 -U keycloak -d keycloak > keycloak-dev-$(date +%F).sql
```

Example local realm export:

```bash
/opt/keycloak/bin/kc.sh export --dir ./backup/keycloak-export --realm my-webapp
```

#### Live / Production Backups

For live environments, define a standard backup set:

1. Scheduled `PostgreSQL` backups or storage snapshots with tested consistency.
2. Realm export procedures for important realms where operationally appropriate.
3. Backup of custom themes, providers, startup configuration, environment files, and reverse-proxy configuration.
4. Secure custody of bootstrap material, admin recovery process, and any secrets required for external identity providers.
5. Infrastructure-as-code or deployment manifests so the service can be rebuilt consistently.

Typical live database backup example:

```bash
pg_dump -h db.example.internal -U keycloak -d keycloak > /secure-backup/keycloak-$(date +%F-%H%M).sql
```

Important live backup notes:

* **The database is usually the main source of truth** for users, realms, clients, sessions, and configuration state.
* **Realm export is useful but not always a complete disaster-recovery substitute** for full database backup.
* **Custom extensions must be backed up separately** because they are commonly deployed as files outside the database.
* **Store copies off-host and off-cluster** and protect them as sensitive identity data.
* **Run restore drills** to confirm applications can still log in and validate tokens after recovery.

#### What to Verify During Restore Tests

At minimum, verify that you can:

* restore the database into a clean environment,
* start Keycloak successfully against the restored state,
* log in with an administrative recovery path,
* obtain a token from a known realm and client,
* validate `/.well-known/openid-configuration` and `JWKS` responses,
* and confirm at least one protected application can authenticate correctly.

## See also

* [Keycloak Home Page](https://www.keycloak.org/)
* [Keycloak Documentation](https://www.keycloak.org/documentation)
* [Keycloak Guides](https://www.keycloak.org/guides)
* [Securing Apps and Services Guide](https://www.keycloak.org/guides#securing-apps)
* [Server Configuration Guide](https://www.keycloak.org/server/configuration)
