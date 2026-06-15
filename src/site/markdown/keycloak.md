# Keycloak

## Information

Keycloak is an open-source identity and access management platform for applications, APIs, microservices, and internal
portals. In practice it is commonly used as a self-hosted alternative to managed identity platforms when teams need
control over login flows, federation, client configuration, token settings, and realm-level security policies.

When it is deployed with a persistent database, proper `TLS`, reverse proxy or ingress protection, controlled secrets,
and operational monitoring, Keycloak is a reasonable choice for live production use, including public-facing identity
services reachable by users and applications from the public internet.

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
* **Required Actions and Authentication Flows**: Supports password reset, profile completion, OTP enrollment, email
  verification, and custom login flow design.
* **Token Exchange / Session Management / Offline Tokens**: Useful for modern web apps, mobile apps, and backend
  integrations.
* **Themes and Extensions**: Login pages, account pages, and providers can be customized.

### Common Developer Use Cases

* Protect a `Spring Boot` API as an `OAuth2 Resource Server`.
* Use Keycloak like an `Auth0`-style tenant for local development and internal environments.
* Issue access tokens for `SPA`, backend, CLI, and machine-to-machine clients.
* Federate enterprise users from `LDAP` / `AD` while keeping application-facing `OIDC` flows modern.
* Centralize role / scope handling for multiple microservices.

### Supported Protocols and Token Algorithms

Keycloak supports a broad set of classical cryptographic algorithms for signing and validating tokens:

* **Token Signing Algorithms**: `RS256` (common default), `RS384`, `RS512`, `PS256`, `PS384`, `PS512`, `ES256`, `ES384`,
  `ES512`, `HS256`, `HS384`, `HS512`, `EdDSA`.
* **Hashing Algorithms**: `SHA-256`, `SHA-384`, `SHA-512`.
* **Protocols**: `OIDC`, `OAuth 2.0`, `SAML 2.0`.

Notes:

* In many installations, `RSA`-based signing remains the most common default for compatibility.
* Algorithm availability and defaults can vary slightly by Keycloak version, realm key setup, provider configuration,
  and Java crypto support.
* For application teams, the most important compatibility item is usually whether downstream clients, API gateways, and
  frameworks can validate the selected realm signing algorithm.

### Post-Quantum Cryptography (PQC) Notes

Keycloak is still primarily deployed with classical cryptography. For Keycloak, `PQC` readiness is mainly an **edge,
transport, and crypto-agility planning topic**, not a sign that realm keys and token signatures are already natively
post-quantum.

Key points:

* **Realm signing keys are mainly classical today**. Typical deployments sign tokens with `RSA`, `EC`, or similar
  classical algorithms.
* **`PQC` will likely arrive at the transport layer first**. Reverse proxies, ingress controllers, load balancers,
  service meshes, and `TLS` libraries may adopt hybrid `PQC` before application-layer token standards do.
* **Application crypto agility matters**. Downstream services should validate issuer metadata dynamically and avoid
  assumptions that token algorithms will never change.
* **Long-retention identity data needs planning**. Session stores, exported realm configs, audit logs, and long-lived
  trust relationships should be documented so future migration is manageable.

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

If a suitable package is available in your environment, a package-manager install may be convenient, but many teams
still prefer the official distribution archive for version-pinned setups.

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

For developer machines, the simplest path is usually a disposable `start-dev` deployment. This is ideal for local
testing, login flow experiments, CLI automation, and app integration work.

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
* `ports: "8080:8080"` publishes Keycloak on the Docker host network interfaces. If the host is publicly reachable and
  firewall rules allow it, the service may be reachable from the public internet.
* For local-only development on the same machine, prefer `127.0.0.1:8080:8080` instead of `8080:8080`.
* For throwaway local testing, the default in-container database is often good enough.
* If you want to preserve realm changes across restarts, prefer mounting data only when the selected image / setup
  explicitly supports your intended persistence model, or use an external `PostgreSQL` container even in local
  development.
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

This pattern is useful if developers want to keep local realms, clients, groups, users, themes, and test data between
restarts.

The same network-exposure warning applies here: `8080:8080` publishes the port on the Docker host. For local-only use,
bind explicitly to `127.0.0.1:8080:8080`.

## Configuration

### Live Environment Setup

For live environments, Keycloak should run against a persistent external database, behind proper `TLS`, with explicit
hostname configuration, controlled secrets handling, and repeatable deployment automation.

#### Storage Requirements (`PostgreSQL`)

Keycloak supports several databases, but `PostgreSQL` is commonly the preferred live choice for stability, performance,
and operational familiarity.

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
* `ports: "8080:8080"` publishes the raw Keycloak HTTP port on the host. In live environments, do not expose this port
  directly to the public internet unless that is an explicitly approved design.
* Prefer exposing Keycloak through an approved reverse proxy, load balancer, or ingress, and restrict direct node access
  with firewall rules, private networking, or interface-specific binding.

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

### IAM Delivery Planning Checklist

Before building or changing a Keycloak-based IAM landscape, decide the target operating model first. Many production
issues do not come from Keycloak itself, but from unclear ownership, incomplete client onboarding rules, inconsistent
role design, or missing recovery processes.

Plan at least the following:

* **Ownership model**: Identify who owns the platform, who approves realm changes, who manages clients, and who is
  on-call for incidents.
* **Environment split**: Define separate `dev`, `test`, `staging`, and `production` realms or clusters and document what
  may be promoted between them.
* **Realm strategy**: Decide whether to use one realm per product area, one realm per business domain, or a shared
  enterprise realm with strong naming conventions.
* **Naming standards**: Standardize realm names, client IDs, group names, role names, scopes, and protocol mappers
  before onboarding many teams.
* **Secrets lifecycle**: Define where client secrets, SMTP credentials, external IdP secrets, and admin recovery
  material are stored and rotated.
* **Compliance and audit scope**: Document retention, access review cadence, logging scope, and whether personal data
  synchronization from external directories is allowed.
* **Disaster recovery target**: Set `RPO` and `RTO` targets and design database, backup, and failover procedures
  accordingly.
* **Knowledge transfer expectations**: Prepare runbooks, onboarding guides, and architecture diagrams so internal teams
  can operate the platform without tribal knowledge.

### High-Availability and Platform Architecture Notes

Keycloak itself is stateless enough to run multiple application instances, but overall availability depends on the full
stack: reverse proxy / ingress, `PostgreSQL`, DNS, certificates, secrets, monitoring, and restore procedures.

#### High-Availability Design Basics

For a live `HA` deployment, aim for:

* at least two Keycloak instances,
* a resilient reverse proxy or ingress layer,
* highly available `PostgreSQL` or a managed database service,
* shared observability for application and database health,
* tested backup and restore workflows,
* and documented operational procedures for node replacement, upgrade, and rollback.

Important considerations:

* **Do not treat Keycloak nodes as state silos**. User and realm state belongs in the database, while node-local
  customizations should be reproducible from version control or image builds.
* **Plan rolling updates carefully**. Themes, provider extensions, and custom authentication components must be
  compatible across all nodes during rollout.
* **Protect the database path**. In many real environments the database is the true availability bottleneck, so database
  design is as important as Keycloak replication count.
* **Make session behavior explicit**. Validate login, logout, refresh token rotation, and admin session handling when
  traffic moves between nodes.

#### Reverse Proxy, Load Balancer, and Network Expectations

When deploying behind `Nginx`, `HAProxy`, `Traefik`, a cloud load balancer, or Kubernetes ingress:

* Ensure `KC_HOSTNAME` and proxy header handling match the public URL exactly.
* Terminate `TLS` only at trusted layers and preserve the required forwarded headers.
* Restrict direct node exposure; users and applications should reach Keycloak via the approved public endpoint only.
* Decide whether session affinity is needed for your specific flows, extensions, and proxy behavior, then validate with
  real browsers and multi-step login flows.
* Protect admin endpoints with network controls, separate ingress, `VPN`, or zero-trust access patterns where
  appropriate.

#### Upgrade and Maintenance Strategy

For long-lived IAM platforms, document upgrade practice up front:

* Keep a tested path for patch upgrades and major-version upgrades.
* Validate custom providers, themes, and protocol mappers against the target version before production rollout.
* Rehearse rollback steps, including image rollback and database restore decision points.
* Freeze non-essential realm changes during critical upgrades.
* Record which teams must re-test their applications after IAM changes.

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

For local testing only, some teams temporarily use direct username / password token requests. Avoid this flow for real
frontend design unless you explicitly understand the security and standards implications.

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

Keycloak supports `RFC 7009` token revocation, typically applied to refresh tokens. Revoking a refresh token usually
invalidates the associated session path.

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
   Spring Security will automatically use the realm `.well-known/openid-configuration` and `JWKS` endpoint to validate
   incoming `JWT`s.

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

## IAM Design and Integration Guidance

### Roles, Groups, Permissions, and Client Scope Design

Keycloak can become difficult to operate if teams mix business meaning, application entitlements, and technical scopes
without structure. A simple design model prevents later cleanup work.

Recommended approach:

* **Realm roles**: Use for broadly shared cross-application capabilities, such as `platform-admin`, `helpdesk`, or
  `employee`.
* **Client roles**: Use for application-specific permissions such as `orders.read`, `orders.write`, or
  `billing.approver`.
* **Groups**: Use for user assignment convenience, organization structure, or coarse policy mapping. Groups should
  usually collect role mappings instead of duplicating permission logic manually per user.
* **Authorization Services**: Use only when you truly need fine-grained policy evaluation and can operate the extra
  complexity.
* **Client scopes and mappers**: Use to control which claims are released to tokens and to avoid oversized or
  inconsistent tokens.

Practical rules:

1. Do not assign most permissions directly to users; prefer group membership and role mapping.
2. Keep role names stable, explicit, and automation-friendly.
3. Separate human-user permissions from service-account permissions.
4. Minimize token claims to what downstream services actually need.
5. Document which teams are allowed to create new roles, scopes, and protocol mappers.

#### Example Access-Modeling Pattern

One maintainable pattern is:

* groups represent organizational or operational membership such as `team-payments`, `team-analytics`, or
  `contractor-support`,
* client roles represent application permissions such as `payments-api.read` or `payments-api.refund`,
* realm roles represent broadly shared capabilities such as `sso-admin`, `auditor`, or `employee`,
* and protocol mappers release only the required claims to each client.

This keeps the assignment model understandable for auditors, platform engineers, and application teams.

### Secure Authentication and Authorization Flow Choices

In Keycloak projects, selecting the correct flow matters more than simply making login work.

Use these defaults unless there is a strong reason not to:

* **Browser-based frontend / SPA**: Prefer `Authorization Code Flow` with `PKCE`.
* **Traditional server-rendered web app**: Use standard `OIDC` authorization code flow with confidential client
  settings.
* **Backend service to backend service**: Use `client_credentials` with confidential clients and tightly scoped
  service-account permissions.
* **Mobile applications**: Prefer authorization code flow with `PKCE` and platform-native redirect handling.
* **Machine or batch job acting on behalf of a real user**: Explicitly document whether token exchange, delegated
  access, or a service account is appropriate.

Avoid or tightly restrict:

* password grant patterns for real application design,
* excessive use of long-lived offline tokens,
* wide wildcard redirect URIs in production,
* over-broad token audiences,
* and client secrets stored in frontend code or distributed scripts.

Security review checklist:

* Are redirect URIs exact and environment-specific?
* Is `PKCE` enabled where public clients are used?
* Are scopes minimal?
* Are service accounts prevented from inheriting unnecessary admin roles?
* Are `MFA`, required actions, and brute-force protections enabled where the risk model requires them?
* Are logout, session timeout, and refresh token settings aligned with UX and security requirements?

### User Federation and Directory Integration Guidance

Keycloak often sits in front of enterprise directories rather than replacing them. In those setups, federation design
must be explicit because it affects onboarding, attribute quality, group mapping, and incident handling.

Common federation questions to decide early:

* Will users be imported into Keycloak or resolved only on login?
* Which source is authoritative for usernames, email, display name, groups, and disablement state?
* How will leavers be disabled quickly?
* How often will synchronization run, and what is the operational impact?
* Which attributes are allowed to flow into tokens or downstream applications?

Practical guidance:

* Keep directory schema mapping documented and version-controlled where possible.
* Test user rename, disable, lockout, and group-removal scenarios, not just successful login.
* Avoid assuming `LDAP` / `AD` group structures are already suitable for application authorization.
* Prefer a deliberate mapping layer between enterprise groups and application-facing roles.
* Decide whether emergency break-glass admins are local to Keycloak or federated from the enterprise directory.

### `SSSD` Considerations

`SSSD` is usually relevant on Linux hosts and platform operations rather than inside Keycloak itself. The important
design point is to understand where identity is being consumed.

Typical pattern:

* Keycloak manages user authentication for applications via `OIDC` / `SAML`.
* `SSSD` provides host-level identity integration for Linux systems, often backed by `LDAP`, `AD`, or another
  centralized identity source.
* Both may depend on the same enterprise directory, but they solve different access layers.

What to check when `SSSD` appears in the architecture:

* Whether Linux administrators need centralized identities for shell access, `sudo`, or host policies.
* Whether the same source of truth is used by both Keycloak federation and `SSSD`.
* Whether account disablement propagates consistently to both application login and host login paths.
* Whether group names and entitlement semantics are being reused safely across application and infrastructure layers.
* Whether offline caching in `SSSD` introduces delay or edge cases during lockout and incident response.

Do not assume Keycloak replaces `SSSD`, or vice versa. Usually they are adjacent components in the same IAM landscape.

### Kubernetes Deployment Guidance

Running Keycloak on Kubernetes is common, but the hard part is not just creating pods. The hard part is designing a
secure, reproducible, observable identity platform.

Recommended baseline:

* run multiple replicas for the Keycloak deployment,
* use external persistent `PostgreSQL` rather than ephemeral in-cluster storage for important environments,
* store secrets in Kubernetes secrets backed by your approved secret-management process,
* use ingress with correct hostname and `TLS` configuration,
* and define probes, resource limits, and rollout rules explicitly.

Operational considerations:

* **Readiness / liveness probes** should reflect actual service availability, not only JVM process existence.
* **Resource sizing** should be tested under realistic login and token traffic.
* **Pod disruption handling** should allow rolling updates without dropping the whole IAM service.
* **Extension delivery** should come from immutable images or clearly controlled mounted artifacts.
* **Network policies** should restrict database and admin-path access.
* **Ingress and service annotations** must be reviewed so the public hostname, `TLS`, and forwarded headers remain
  correct.

#### Using `OpenBao` for Kubernetes Secrets

If Keycloak is deployed to live Kubernetes environments, document explicitly how secrets are sourced. Keycloak usually
does **not** read secrets directly from `OpenBao` by itself. The normal production pattern is that Kubernetes receives
the secret from `OpenBao` through an approved integration and then exposes it to the Keycloak container.

Typical patterns:

* **External secret controller**: a controller reads from `OpenBao` and creates a Kubernetes `Secret` consumed by the
  Keycloak deployment.
* **Agent or sidecar injection**: an `OpenBao` agent authenticates using the pod identity, fetches secret material, and
  writes it to files or environment input before Keycloak starts.
* **CSI-mounted secret delivery**: secret values are mounted into the pod filesystem and then referenced by the startup
  process.

For Keycloak, this is especially relevant for:

* `KC_BOOTSTRAP_ADMIN_USERNAME`
* `KC_BOOTSTRAP_ADMIN_PASSWORD`
* `KC_DB_USERNAME`
* `KC_DB_PASSWORD`
* SMTP credentials
* external identity-provider client secrets

Important operational note:

* `KC_BOOTSTRAP_ADMIN_USERNAME` and `KC_BOOTSTRAP_ADMIN_PASSWORD` are mainly **bootstrap-time** settings. Treat them as
  first-start secrets only. After the initial admin account exists, ongoing admin credential handling should follow the
  normal operational access model rather than depending on permanent reuse of bootstrap values.

Example pattern with a Kubernetes `Secret` populated from `OpenBao`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    name: keycloak
spec:
    replicas: 2
    template:
        spec:
            containers:
                -   name: keycloak
                    image: quay.io/keycloak/keycloak:25.0.2
                    env:
                        -   name: KC_BOOTSTRAP_ADMIN_USERNAME
                            valueFrom:
                                secretKeyRef:
                                    name: keycloak-bootstrap-admin
                                    key: username
                        -   name: KC_BOOTSTRAP_ADMIN_PASSWORD
                            valueFrom:
                                secretKeyRef:
                                    name: keycloak-bootstrap-admin
                                    key: password
                        -   name: KC_DB
                            value: postgres
                        -   name: KC_DB_USERNAME
                            valueFrom:
                                secretKeyRef:
                                    name: keycloak-db
                                    key: username
                        -   name: KC_DB_PASSWORD
                            valueFrom:
                                secretKeyRef:
                                    name: keycloak-db
                                    key: password
                    args:
                        - start
```

Planning and security checks for `OpenBao` integration:

1. authenticate Kubernetes workloads to `OpenBao` with a controlled workload identity or service account mapping,
2. decide whether secrets may be copied into Kubernetes `Secret` objects or must stay ephemeral,
3. limit which namespaces and service accounts can read the secret material,
4. document bootstrap behavior for multi-replica startup,
5. define how secret rotation is handled for database credentials, client secrets, and break-glass accounts,
6. and audit who can read or update the `OpenBao` paths used by the Keycloak platform.

#### Kubernetes Pre-Go-Live Checklist

Before calling a Kubernetes deployment ready, verify:

1. ingress resolves to the correct public hostname,
2. certificates renew correctly,
3. replica loss does not break login,
4. database failover behavior is understood and tested as far as feasible,
5. logs and metrics are collected centrally,
6. admin access is limited and audited,
7. realm import / bootstrap automation is repeatable,
8. `OpenBao` integration for bootstrap, database, and client secrets works on clean pod startup,
9. secret rotation procedures are documented and tested where feasible,
10. and backup plus restore procedures work outside the cluster.

## Usage, tips and tricks

### Coding Tips and Tricks

* **Token inspection**: Use [jwt.io](https://jwt.io) or a local decoder to inspect issued tokens and verify claims,
  roles, scopes, issuer, and audience.
* **CORS**: Ensure client `Web Origins` include the frontend URL such as `http://localhost:3000`.
* **Token lifespan**: Adjust realm and client token lifespans carefully to balance security and UX.
* **Blacklisting / Not-Before Policy**: To invalidate previously issued tokens, use the realm revocation settings and
  set the realm `not-before` time.
* **Service account roles**: Remember that `client_credentials` tokens usually get permissions from the service account
  role mappings, not from end-user assignments.
* **Issuer correctness matters**: Mismatched hostname or reverse-proxy settings frequently break token validation in
  downstream apps.
* **Themes and extensions**: Keep custom themes and providers under version control and test them against each Keycloak
  upgrade.

### Operational Tips and Common Pitfalls

* **Do not let every team design clients differently**: publish standards for redirect URIs, naming, claim release, and
  logout settings.
* **Keep admin access small and review it regularly**: avoid giving broad realm-admin rights to application teams when
  narrower delegation or automation is enough.
* **Treat realm changes like application changes**: use review, promotion, and rollback practices instead of editing
  production manually whenever possible.
* **Watch for token bloat**: too many groups, roles, and custom claims can create oversized tokens and downstream header
  problems.
* **Test both happy-path and deprovisioning behavior**: disable users, remove groups, rotate secrets, revoke sessions,
  and confirm expected access loss.
* **Separate break-glass identities from day-to-day administration**: emergency access must exist, but should be tightly
  protected and audited.
* **Document external dependencies**: SMTP, DNS, certificates, reverse proxy, `LDAP` / `AD`, secret management, and
  databases are all part of IAM reliability.

### Handover and Coaching Checklist

If the goal is to enable internal teams to work independently, make sure the final documentation package includes:

* a platform overview diagram showing Keycloak, proxy / ingress, database, directory, and applications,
* a client onboarding guide for application teams,
* a role and group modeling guide with examples,
* an operations runbook for startup, incident handling, upgrade, backup, and restore,
* a federation troubleshooting guide,
* a Kubernetes or infrastructure deployment guide,
* and named owners for platform administration, directory integration, and application support.

Recommended coaching topics for internal teams:

1. how to choose the right client type and flow,
2. how to request roles and scopes correctly,
3. how to debug issuer, audience, and token-claim problems,
4. how to onboard new applications safely,
5. and how to respond to user-lockout, federation, and certificate incidents.

### Backup and Restore Notes

Unlike `Vault` / `OpenBao`, Keycloak is usually not backed up by taking application-level snapshots of an internal
encrypted storage engine. In most real deployments, the critical backup scope is the **database plus configuration and
custom artifacts**.

#### Developer / Local Machine Backups

For local environments, first decide whether the setup is disposable:

* **Simple `start-dev` lab**: often disposable and may not need backup.
* **Developer setup with persistent `PostgreSQL`**: should be backed up if it contains reusable realm definitions, test
  users, client secrets, or custom themes/providers.

Recommended local backup scope:

* Database dump of the local `PostgreSQL` instance if used.
* Exported realm configuration for important local realms.
* Custom themes, provider `JAR`s, scripts, and environment files.
* Notes about test users, client IDs, redirect URIs, and any external identity-provider credentials used for
  development.

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
4. Secure custody of bootstrap material, admin recovery process, and any secrets required for external identity
   providers.
5. Infrastructure-as-code or deployment manifests so the service can be rebuilt consistently.

Recommended planning decisions before backing up a live Keycloak database:

* Define the required `RPO` and `RTO` first so the team knows whether daily dumps, hourly dumps, `WAL` archiving, or
  storage snapshots are needed.
* Decide whether the main recovery method is **logical backup** (`pg_dump`), **physical backup** / managed snapshot, or
  a combination of both.
* Make backup ownership explicit: who runs it, who verifies it, where it is stored, who can access it, and who is
  allowed to restore it.
* Encrypt backup storage and transfer paths because Keycloak databases contain sensitive identity and authorization
  data.
* Keep backup retention, off-site copy, and immutability requirements aligned with compliance and incident-response
  expectations.

#### Recommended Live Backup Workflow for `PostgreSQL`

For most Keycloak installations, a good operational baseline is:

1. run scheduled logical backups with `pg_dump`,
2. back up global roles with `pg_dumpall --globals-only` when self-managing the database cluster,
3. use storage or managed-service snapshots where available for faster large-scale recovery,
4. archive `WAL` if point-in-time recovery is required,
5. and test restore regularly in a separate environment.

This combination gives teams both a portable logical backup and a faster infrastructure-level recovery path.

#### Pre-Backup Checklist for Live Databases

Before running a production backup, check at least the following:

1. the database host, port, database name, and backup target path are correct,
2. the backup account has the required read permissions,
3. there is enough free space locally and on the remote backup target,
4. the destination is protected with correct filesystem and access-control permissions,
5. retention cleanup will not accidentally delete the new backup,
6. the Keycloak and database versions are recorded with the backup metadata,
7. and alerts exist for failed, incomplete, or unusually small backup files.

#### Preferred Logical Backup Commands

For live environments, prefer a timestamped file name and explicit output format.

Custom-format backup:

```bash
export BACKUP_TS=$(date +%F-%H%M)
pg_dump \
  -h db.example.internal \
  -p 5432 \
  -U keycloak \
  -d keycloak \
  -Fc \
  -f /secure-backup/keycloak-${BACKUP_TS}.dump
```

Plain SQL backup:

```bash
export BACKUP_TS=$(date +%F-%H%M)
pg_dump \
  -h db.example.internal \
  -p 5432 \
  -U keycloak \
  -d keycloak \
  --no-owner \
  --no-privileges \
  -f /secure-backup/keycloak-${BACKUP_TS}.sql
```

Why teams often prefer `-Fc` for live backups:

* it is compressed,
* it works well with `pg_restore`,
* individual objects can be inspected or selectively restored,
* and restore parallelization is easier for larger datasets.

If you manage the full PostgreSQL cluster yourself, also consider backing up globals:

```bash
export BACKUP_TS=$(date +%F-%H%M)
pg_dumpall \
  -h db.example.internal \
  -p 5432 \
  -U postgres \
  --globals-only \
  > /secure-backup/postgres-globals-${BACKUP_TS}.sql
```

This is useful for cluster-level roles and grants that may matter during full-environment recovery.

Typical live database backup example:

```bash
pg_dump -h db.example.internal -U keycloak -d keycloak > /secure-backup/keycloak-$(date +%F-%H%M).sql
```

#### Example Backup Script Pattern

For repeated operations, use a small non-interactive script rather than ad-hoc terminal history.

```bash
#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR=/secure-backup
BACKUP_TS=$(date +%F-%H%M)
BACKUP_FILE="${BACKUP_DIR}/keycloak-${BACKUP_TS}.dump"

mkdir -p "${BACKUP_DIR}"

pg_dump \
  -h db.example.internal \
  -p 5432 \
  -U keycloak \
  -d keycloak \
  -Fc \
  -f "${BACKUP_FILE}"

pg_restore --list "${BACKUP_FILE}" > "${BACKUP_FILE}.manifest"
sha256sum "${BACKUP_FILE}" > "${BACKUP_FILE}.sha256"
```

This pattern helps because it produces the backup, a quick-readable manifest, and an integrity hash in one run.

#### Kubernetes and Container-Oriented Notes

If Keycloak runs on Kubernetes, the preferred backup target is still the external `PostgreSQL` service rather than the
Keycloak pod itself.

Operational rules:

* run `pg_dump` from a controlled backup job, admin workstation, or operations container with network access to the
  database,
* do not assume backing up a Keycloak pod filesystem is enough,
* and if the database runs in Kubernetes, ensure volume snapshots and logical dumps are both evaluated against your
  restore objectives.

Example Kubernetes job-style command from a toolbox pod:

```bash
PGPASSWORD='strong-password' pg_dump \
  -h postgres.database.svc.cluster.local \
  -U keycloak \
  -d keycloak \
  -Fc \
  -f /backup/keycloak-$(date +%F-%H%M).dump
```

If credentials are delivered through `OpenBao`, Kubernetes secrets, or mounted files, make sure the backup job follows
the same approved secret-handling path as the main service.

#### What to Record Together with Each Backup

Each production backup should have enough context so another engineer can restore it correctly later. Record at least:

* timestamp and timezone,
* source host and database name,
* PostgreSQL version,
* Keycloak version,
* backup format used,
* checksum or integrity hash,
* retention class,
* and the operator, automation job, or pipeline that created it.

#### Immediate Post-Backup Validation

Do not stop at "command finished successfully". Validate that:

1. the backup file exists and is non-trivially sized,
2. the checksum was generated,
3. the dump can be listed or inspected,
4. backup logs show no permission or connection warnings,
5. and the backup was copied to the intended off-host or off-cluster location.

Example quick validation commands:

```bash
ls -lh /secure-backup/keycloak-2026-06-11-0100.dump
pg_restore --list /secure-backup/keycloak-2026-06-11-0100.dump | head
sha256sum -c /secure-backup/keycloak-2026-06-11-0100.dump.sha256
```

Important live backup notes:

* **The database is usually the main source of truth** for users, realms, clients, sessions, and configuration state.
* **Realm export is useful but not always a complete disaster-recovery substitute** for full database backup.
* **Custom extensions must be backed up separately** because they are commonly deployed as files outside the database.
* **Store copies off-host and off-cluster** and protect them as sensitive identity data.
* **Run restore drills** to confirm applications can still log in and validate tokens after recovery.
* **Prefer a dedicated backup account and automated execution** instead of running manual backups from a personal shell.
* **If point-in-time recovery matters, `pg_dump` alone is not enough**; combine it with `WAL` archiving or managed
  database recovery features.

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
* [ADR-0039: JWT claims for person and organization context](it/architecture/decisions/adr-0039-jwt-claims-for-person-and-organization-context.md)
