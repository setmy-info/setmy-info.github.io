# OpenBao

## Information

OpenBao is an open-source, community-governed secrets and encryption management platform. It is designed to centralize sensitive data handling such as application secrets, encryption keys, certificates, and machine identities while enforcing policy-based access and auditability.

At a practical level, OpenBao gives teams one place to:

* store and version secrets,
* encrypt or sign data through APIs,
* issue short-lived credentials and certificates,
* authenticate users, services, and platforms,
* and audit who accessed what and when.

### OpenBao Overview

OpenBao is commonly used as a control plane for secret lifecycle and cryptographic operations rather than as a place where applications directly embed sensitive material.

#### What it is used for

* **Application secret storage** for passwords, API tokens, connection strings, and environment-specific configuration.
* **Encryption as a service** through the Transit engine so applications can encrypt, decrypt, sign, verify, and derive keys without storing raw key material themselves.
* **Certificate and PKI workflows** for internal CAs, mTLS, and short-lived service certificates.
* **Machine authentication** through auth methods such as AppRole, Kubernetes, cloud IAM, LDAP, JWT/OIDC, and token-based access.
* **Operational security controls** such as secret leasing, renewal, revocation, policy enforcement, and audit logging.

#### Core platform characteristics

* **Open-source governance** with community-led development.
* **API-first design** suitable for CLI, REST, automation, and application integration.
* **Policy-driven access model** to scope what users and services can read or do.
* **Multiple secrets engines and auth methods** so one deployment can support several security use cases.
* **Flexible deployment options** for developer machines, containers, and live environments.

#### Compatibility notes in OpenBao context

OpenBao is frequently used through APIs, workflows, and client libraries that were originally popular in the broader Vault-compatible ecosystem. In practice, that means developers will often encounter familiar endpoint structures, policy concepts, HCL configuration style, and integration libraries.

For this page, the important point is that OpenBao can usually fit into those operational patterns while still being documented and operated as its own platform with its own binary (`bao`), environment variables (`BAO_*`), release lifecycle, and community roadmap.

#### Ecosystem support

OpenBao can be integrated with:

* **Terraform and automation tooling** for policy, auth, and secret engine provisioning.
* **Kubernetes environments** for workload authentication and secret delivery patterns.
* **Cloud platforms** such as AWS, GCP, and Azure for auth flows and auto-unseal integrations.
* **Application SDKs and HTTP clients** in Java, Python, Go, and other languages.

### Main Functionalities and Features

* **Secrets Management**: Securely store and control access to tokens, passwords, certificates, and encryption keys.
* **Dynamic Secrets**: Generate secrets on-demand for various systems, reducing the risk of static credential leaks.
* **Data Encryption (Transit)**: Allows applications to encrypt/decrypt data without storing it, offloading cryptographic operations.
* **PKI (Certificate Management)**: Manage and rotate X.509 certificates at scale.
* **Key Management**: Create, rotate, and manage cryptographic keys.
* **Leasing and Renewal**: Issue time-limited credentials and renew them only while they are still required.
* **Revocation**: Revoke a single secret, all secrets generated from a role, or an entire access tree when needed.
* **Secret Versioning (KV v2)**: Keep versions of secrets, support rollback, and implement soft delete / destroy flows.
* **Authentication Brokering**: Authenticate users and workloads through tokens, AppRole, Kubernetes, LDAP, GitHub, cloud IAM, and more.
* **Identity and Access**: Fine-grained access control based on identities and policies.
* **Audit Logging**: Keep a detailed record of all access and changes.

### What OpenBao Commonly Supports in Practice

Depending on enabled auth methods and secrets engines, OpenBao is commonly used for:

* **KV v1 / KV v2** for application secrets, environment-specific configuration, and secret rotation workflows.
* **Transit** for encrypt/decrypt, signing, verification, HMAC, data key generation, and convergent encryption use cases.
* **PKI** for internal certificate authorities, short-lived TLS certificates, and service-to-service mTLS.
* **SSH** for one-time SSH credentials or signed SSH certificates.
* **Database** for temporary database usernames/passwords for PostgreSQL, MySQL, and other supported systems.
* **TOTP** for OTP-based authentication support in selected workflows.
* **Cloud/Auth integrations** for AWS, GCP, Azure, Kubernetes, LDAP, GitHub, JWT/OIDC, and AppRole based access patterns.

### Supported Cryptographic Algorithms

OpenBao supports a wide range of algorithms, primarily through its **Transit** engine:

* **Symmetric Encryption**:
    * `aes128-gcm96`: AES-GCM with 128-bit key.
    * `aes256-gcm96`: AES-GCM with 256-bit key (default).
    * `chacha20-poly1305`: ChaCha20-Poly1305 with 256-bit key.
* **Asymmetric Encryption & Signing**:
    * `rsa-2048`, `rsa-3072`, `rsa-4096`: RSA with various bit lengths (PSS or PKCS#1v1.5).
    * `ecdsa-p256`, `ecdsa-p384`, `ecdsa-p521`: Elliptic Curve Digital Signature Algorithm.
    * `ed25519`: Edwards-curve Digital Signature Algorithm.
* **Hashing & HMAC**:
    * `sha2-224`, `sha2-256`, `sha2-384`, `sha2-512`: SHA-2 hashing.
    * `hmac`: Hash-based Message Authentication Code.
* **Format-Preserving Encryption (FPE)**:
    * `ff31`: NIST SP 800-38G compliant format-preserving encryption.

### Post-Quantum Cryptography (PQC) Notes

OpenBao is primarily used today with classical cryptographic primitives such as AES, RSA, ECDSA, Ed25519, SHA-2, and ChaCha20-Poly1305. In practice, you should treat PQC support as **architecture and integration guidance**, not as a built-in guarantee that all OpenBao cryptographic operations are already quantum-resistant.

What to keep in mind:

* **Transit engine algorithms**: The commonly documented Transit key types are classical algorithms. PQC KEM/signature types are not typically exposed in the same way as `rsa-*`, `ecdsa-*`, or `ed25519` keys.
* **TLS layer**: If you want PQC or hybrid PQC protection for client-to-OpenBao traffic, this is usually handled by the TLS stack in front of or around OpenBao, for example via a reverse proxy, load balancer, service mesh, or a custom build of TLS libraries supporting hybrid groups such as ML-KEM/Kyber combinations.
* **Auto-unseal / HSM / KMS**: A future-ready design can place OpenBao together with external KMS or HSM systems. In that model, OpenBao still manages secrets and policy, while the external crypto boundary may evolve faster toward hardware-backed or PQC-capable services.
* **PKI impact**: Most current internal PKI deployments with OpenBao still issue classical RSA or ECDSA certificates. If your environment is planning for PQC migration, certificate issuance and trust-chain design should be reviewed separately from secret storage.
* **Hybrid migration**: For most teams, the practical approach is hybrid migration: keep OpenBao for secret lifecycle and access control, while introducing PQC first at transport, edge, VPN, or application protocol level.

Practical recommendation:

1. Use OpenBao normally for secrets, Transit, PKI, and access control.
2. Terminate TLS with a component that can adopt modern hybrid PQC ciphersuites or key exchange earlier than your application stack.
3. Keep cryptographic agility in application design so that key types, certificates, and transport security can be replaced as standards and product support mature.
4. Track OpenBao release notes and the surrounding crypto library ecosystem for native PQC-related enhancements.

### Making OpenBao Deployment PQC-Ready

If your goal is to make OpenBao data handling more future-ready against quantum-era risks, the practical focus should be on **crypto agility, transport protection, and key-lifecycle planning**, not on assuming current stored Raft data is magically converted into a PQC format.

Recommended approach:

* **Protect data in transit first** by using TLS endpoints, reverse proxies, service meshes, VPNs, or ingress components that can adopt hybrid PQC key exchange before OpenBao itself exposes native PQC primitives.
* **Prefer strong symmetric settings now**. Symmetric encryption such as `AES-256` remains comparatively resilient in a post-quantum model relative to many classical public-key schemes, so using strong symmetric defaults is still sensible.
* **Reduce long-lived plaintext exposure**. Keep secrets encrypted at rest, avoid uncontrolled exports, and minimize the number of places where secret material is decrypted outside OpenBao.
* **Plan certificate agility**. Internal PKI hierarchies, service certificates, and trust bundles should be designed so they can be rotated or replaced when PQC-capable PKI standards and tooling mature.
* **Classify long-retention sensitive data**. Secrets or encrypted payloads that must remain confidential for many years deserve earlier migration planning because "harvest now, decrypt later" is mainly a risk for long-lived confidentiality.
* **Use external KMS / HSM boundaries where appropriate**. If your organization expects earlier PQC or hardware-backed crypto changes outside OpenBao itself, keep a clean architecture boundary so those systems can evolve independently.
* **Document algorithm dependencies**. Track where you rely on RSA, ECDSA, Ed25519, TLS certificate types, client libraries, and external trust anchors so migration work is not blocked later by hidden dependencies.

Short version: make the **surrounding architecture** PQC-ready now, and be ready to adopt native PQC features in OpenBao and its ecosystem later.

## Installation

### CentOS, Rocky Linux

OpenBao can be installed by downloading the binary from the official releases.

1. **Download and Install**:
   ```bash
   BAO_VER="2.0.0"
   wget https://github.com/openbao/openbao/releases/download/v${BAO_VER}/openbao_${BAO_VER}_linux_amd64.zip
   unzip openbao_${BAO_VER}_linux_amd64.zip
   sudo mv bao /usr/local/bin/
   ```

### macOS

Install via Homebrew (check for official tap or community formulas):

```bash
brew install openbao
```

### FreeBSD

```bash
pkg install openbao
```

### Fedora

OpenBao is often installed the same way as on Rocky Linux: download the release archive and place the `bao` binary into a directory on `PATH`.

```bash
BAO_VER="2.0.0"
wget https://github.com/openbao/openbao/releases/download/v${BAO_VER}/openbao_${BAO_VER}_linux_amd64.zip
unzip openbao_${BAO_VER}_linux_amd64.zip
sudo mv bao /usr/local/bin/
```

### OpenIndiana

If no native package is available in your repository set, install from the upstream release archive and place the binary in a system path similarly to Linux or use a containerized deployment.

## Setup with Docker for Developer

For local development, you can start OpenBao in "Dev Mode". This mode is unsealed and stores data in-memory.

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
    openbao:
        image: quay.io/openbao/openbao:2.0.0
        container_name: openbao-dev
        environment:
            - BAO_DEV_ROOT_TOKEN_ID=main-secret
            - BAO_ADDR=http://0.0.0.0:8200
        ports:
            - "8200:8200"
        cap_add:
            - IPC_LOCK
        command: server -dev
```

Start with:

```bash
docker-compose up -d
```

Useful developer checks:

```bash
docker-compose logs -f openbao
docker exec -it openbao-dev bao status
docker exec -it openbao-dev bao secrets list
```

Developer notes:

* **Root token**: In this example the development root token is `main-secret`.
* **Persistence**: Dev mode is intentionally ephemeral. Restarting the container resets in-memory data unless you move to a non-dev server configuration.
* **CLI in container**: The container already includes the `bao` CLI, so `docker exec` is convenient for quick learning and troubleshooting.

## Learning Examples (Step-by-Step)

Follow these steps to explore core functionalities using `curl`.

### 0. Environment Setup

```bash
export BAO_ADDR='http://127.0.0.1:8200'
export BAO_TOKEN='main-secret'
```

Quick health check:

```bash
curl $BAO_ADDR/v1/sys/health
curl --header "X-Bao-Token: $BAO_TOKEN" $BAO_ADDR/v1/sys/seal-status
```

Optional CLI login:

```bash
bao login $BAO_TOKEN
bao status
```

### 0.1 Enable KV v2 for Simple Secret Storage

Before using advanced engines, it is helpful to verify the basic read/write flow.

1. **Enable KV v2**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"type":"kv-v2"}' \
        $BAO_ADDR/v1/sys/mounts/secret
   ```

2. **Write a secret**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"data":{"username":"demo","password":"s3cr3t"}}' \
        $BAO_ADDR/v1/secret/data/my-app
   ```

3. **Read the secret**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        $BAO_ADDR/v1/secret/data/my-app
   ```

### 1. Data Encryption and Decryption

Use the **Transit** engine to encrypt data.

1. **Enable Transit engine**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"type":"transit"}' \
        $BAO_ADDR/v1/sys/mounts/transit
   ```

2. **Create an encryption key**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        $BAO_ADDR/v1/transit/keys/my-key
   ```

3. **Encrypt data**: (Data must be base64 encoded)
   ```bash
   # Plaintext: "Hello OpenBao" -> Base64: "SGVsbG8gT3BlbkJhbw=="
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"plaintext": "SGVsbG8gT3BlbkJhbw=="}' \
        $BAO_ADDR/v1/transit/encrypt/my-key
   ```

4. **Decrypt data**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"ciphertext": "bao:v1:..."}' \
        $BAO_ADDR/v1/transit/decrypt/my-key
   ```

5. **Generate a data key**:
   This is useful when your application wants to encrypt locally but still have key generation controlled by OpenBao.
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"bits":256}' \
        $BAO_ADDR/v1/transit/datakey/plaintext/my-key
   ```

### 2. Digital Signing and Verification

1. **Create a signing key**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"type": "ecdsa-p256"}' \
        $BAO_ADDR/v1/transit/keys/signing-key
   ```

2. **Sign a message**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"input": "SGVsbG8gT3BlbkJhbw=="}' \
        $BAO_ADDR/v1/transit/sign/signing-key
   ```

3. **Verify signature**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"input": "SGVsbG8gT3BlbkJhbw==", "signature": "bao:v1:..."}' \
        $BAO_ADDR/v1/transit/verify/signing-key
   ```

### 3. Key Pair Generation (Asymmetric)

1. **Create an asymmetric key**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"type": "rsa-4096", "exportable": true}' \
        $BAO_ADDR/v1/transit/keys/asymmetric-key
   ```

2. **Read Public Key**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        $BAO_ADDR/v1/transit/keys/asymmetric-key
   ```

3. **Export key material if the key was marked exportable**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        $BAO_ADDR/v1/transit/export/encryption-key/asymmetric-key
   ```

### 4. Certificate Generation (PKI)

1. **Enable PKI engine**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"type":"pki"}' \
        $BAO_ADDR/v1/sys/mounts/pki
   ```

2. **Generate Root CA**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"common_name": "example.com", "ttl": "87600h"}' \
        $BAO_ADDR/v1/pki/root/generate/internal
   ```

3. **Create a Role**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"allowed_domains": "example.com", "allow_subdomains": true, "max_ttl": "72h"}' \
        $BAO_ADDR/v1/pki/roles/web-certs
   ```

4. **Issue Certificate**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"common_name": "test.example.com"}' \
        $BAO_ADDR/v1/pki/issue/web-certs
   ```

### 5. AppRole for Machine-to-Machine Access

AppRole is one of the most common ways to let applications authenticate without interactive login.

1. **Enable AppRole auth**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"type":"approle"}' \
        $BAO_ADDR/v1/sys/auth/approle
   ```

2. **Create a role**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"token_ttl":"1h","token_max_ttl":"4h"}' \
        $BAO_ADDR/v1/auth/approle/role/my-service
   ```

3. **Read the Role ID**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        $BAO_ADDR/v1/auth/approle/role/my-service/role-id
   ```

4. **Generate a Secret ID**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --request POST \
        $BAO_ADDR/v1/auth/approle/role/my-service/secret-id
   ```

5. **Login using Role ID and Secret ID**:
   ```bash
   curl --header "Content-Type: application/json" \
        --request POST \
        --data '{"role_id":"ROLE_ID","secret_id":"SECRET_ID"}' \
        $BAO_ADDR/v1/auth/approle/login
   ```

## Live Environment Setup

### Storage Requirements (Integrated Storage)

OpenBao supports **Integrated Storage (Raft)**, which is recommended for high availability without external dependencies.

Before going live, plan for:

* **Persistent disk** with low latency and enough IOPS for audit logs, Raft data, and snapshots.
* **TLS certificates** for API and cluster traffic. Avoid `tls_disable = 1` outside labs.
* **Time synchronization** through NTP/chrony to reduce TLS and token validation issues.
* **Backups / snapshots** for Raft storage and secure offline storage for initialization material.
* **Access policy design** so workloads receive least-privilege tokens rather than the root token.

**Configuration (`bao.hcl`):**

```hcl
storage "raft" {
  path    = "./bao/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 0
  tls_cert_file = "/etc/bao/tls/bao.crt"
  tls_key_file  = "/etc/bao/tls/bao.key"
}

api_addr = "https://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
ui = true
```

Recommended directory ownership example:

```bash
sudo mkdir -p /etc/bao /etc/bao/tls /var/lib/bao
sudo chown -R openbao:openbao /etc/bao /var/lib/bao
sudo chmod 750 /etc/bao /var/lib/bao
```

### Rocky Linux (systemd service)

1. **Create a dedicated service account and directories**:
   ```bash
   sudo useradd --system --home /etc/bao --shell /sbin/nologin openbao
   sudo mkdir -p /etc/bao /etc/bao/tls /var/lib/bao
   sudo chown -R openbao:openbao /etc/bao /var/lib/bao
   ```

2. **Create a service file**: `/etc/systemd/system/openbao.service`
   ```ini
   [Unit]
   Description=OpenBao Server
   Requires=network-online.target
   After=network-online.target

   [Service]
   User=openbao
   Group=openbao
   ExecStart=/usr/local/bin/bao server -config=/etc/bao/bao.hcl
   ExecReload=/bin/kill --signal HUP $MAINPID
   KillMode=process
   Restart=on-failure
   LimitNOFILE=65536

   [Install]
   WantedBy=multi-user.target
   ```

3. **Enable and Start**:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now openbao
   ```

### Production Docker Setup

For a small self-managed environment, you can also run OpenBao in a persistent containerized setup.

**docker-compose.prod.yaml:**

```yaml
version: '3.8'
services:
    openbao:
        image: quay.io/openbao/openbao:2.0.0
        container_name: openbao-prod
        restart: always
        ports:
            - "8200:8200"
            - "8201:8201"
        volumes:
            - ./config:/etc/bao
            - ./data:/var/lib/bao
            - ./tls:/etc/bao/tls:ro
        cap_add:
            - IPC_LOCK
        command: server -config=/etc/bao/bao.hcl
```

Start with:

```bash
docker-compose -f docker-compose.prod.yaml up -d
```

### Post-Startup: Initialization and Unsealing

After starting a new non-dev instance, initialize it once and securely store the generated keys.

1. **Initialize**:
   ```bash
   export BAO_ADDR='https://127.0.0.1:8200'
   bao operator init
   ```
   Save the unseal keys and root token in a secure offline location or a dedicated secure bootstrap process.

2. **Unseal**:
   ```bash
   bao operator unseal
   ```
   Repeat until the configured threshold is reached.

3. **Login**:
   ```bash
   bao login
   ```

4. **Create an initial admin policy rather than using root everywhere**:
   ```bash
   cat > admin-policy.hcl <<'EOF'
   path "*" {
     capabilities = ["create", "read", "update", "delete", "list", "sudo"]
   }
   EOF
   bao policy write admin admin-policy.hcl
   ```

### Backup and Restore Notes

OpenBao backup planning should cover more than just the Raft data directory. A restorable deployment typically requires **data snapshots, configuration, TLS material references, audit configuration, and secure custody of bootstrap / recovery material**.

#### Developer / Local Machine Backups

For developers, the first question is whether the local setup is **ephemeral** or **worth preserving**:

* **`server -dev` / dev-mode container**: normally do **not** back it up. It is intended for throwaway learning and quick experiments.
* **Local non-dev server with Raft storage**: back it up if it contains useful policies, Transit keys, PKI state, or test data you want to keep between restarts.

Practical developer backup scope:

* The local **Raft snapshot**.
* The local **`bao.hcl`** and any referenced environment files.
* Local **TLS certs/keys** used for the test deployment.
* Any important **policy files**, bootstrap scripts, and test-role definitions stored outside OpenBao.

Example developer snapshot command:

```bash
export BAO_ADDR='https://127.0.0.1:8200'
bao operator raft snapshot save ./backup/openbao-dev-$(date +%F).snap
```

Developer tips:

* Do not keep snapshots in the same directory as the live Raft data only.
* Protect local snapshot files because they may contain highly sensitive encrypted state.
* If the machine is just a disposable lab, documenting how to recreate it can be more useful than preserving every snapshot.

#### Live / Production Backups

For live environments, define a repeatable backup set:

1. **Raft snapshot** on a schedule.
2. **Configuration backup** for `bao.hcl`, systemd unit overrides, container manifests, and auth/audit-related environment configuration.
3. **TLS asset backup or reproducible certificate issuance process**.
4. **Recovery key custody records** and bootstrap documentation stored separately and securely.
5. **Policy / automation / infrastructure-as-code backup** so the control plane can be rebuilt consistently.

Typical Raft snapshot command:

```bash
export BAO_ADDR='https://bao.example.internal:8200'
bao operator raft snapshot save /secure-backup/openbao-$(date +%F-%H%M).snap
```

Important live backup notes:

* **Do not rely on filesystem copies of the live Raft directory as your main backup strategy** when OpenBao is running. Prefer supported snapshots.
* **Auto-unseal does not replace backups**. Even with AWS KMS or another seal mechanism, you still need restorable snapshots.
* **Store backups off-host and off-cluster** so ransomware, host loss, or operator mistakes do not destroy both production and backup copies.
* **Encrypt backup storage and restrict access** to the minimum set of operators or backup services.
* **Test restore regularly** in a non-production environment. A backup is only proven after a successful restore drill.

#### What to Test During Restore

At minimum, verify that you can:

* start a clean OpenBao node with the intended configuration,
* restore a snapshot into the correct storage backend,
* unseal or auto-unseal successfully,
* authenticate with a recovery/admin path,
* read a known KV secret,
* use a known Transit key,
* and issue or inspect a known PKI object if PKI is in use.

#### Backup and PQC Readiness Together

If you are preparing for long-term PQC migration, backup design should also support future cryptographic transitions:

* keep enough metadata and documentation to know **which key types and certificate styles were in use**,
* retain **policy and automation definitions** so you can re-issue keys/certs with newer algorithms later,
* and avoid undocumented manual steps that would make a future migration or re-encryption project difficult.

### AWS KMS Auto-Unseal

AWS KMS auto-unseal lets OpenBao automatically decrypt the internal seal material during startup. In practical terms, OpenBao still protects all data with its internal barrier and master key hierarchy, but it no longer requires operators to manually enter unseal key shards after every restart.

How it works at a high level:

1. During initialization, OpenBao generates the internal root/master material used to protect the barrier.
2. Instead of relying only on manual Shamir unseal operations, OpenBao encrypts the seal-wrapping material with the AWS KMS key you configure.
3. On restart, OpenBao calls AWS KMS to decrypt that seal-wrapping material and automatically becomes unsealed if it can access KMS successfully.
4. Recovery keys are still important in auto-unseal deployments because they replace the old manual unseal workflow for disaster recovery and certain privileged operations.

Important clarifications:

* **Auto-unseal does not store all secrets in AWS KMS**. Your OpenBao data still lives in Raft or another storage backend; KMS protects the seal process, not every secret read/write operation.
* **Auto-unseal is not a substitute for backups**. You still need Raft snapshots, configuration backup, TLS asset backup, and a tested restore process.
* **Auto-unseal is not a substitute for access control**. Root token hygiene, audit devices, least-privilege policies, and short-lived workload authentication still matter.
* **KMS availability matters**. If OpenBao cannot reach AWS KMS during startup, it may remain sealed until KMS access is restored.

#### When AWS KMS Auto-Unseal Fits Well

Typical good-fit scenarios:

* **Production VMs or cloud instances** that must restart unattended after patching, scaling events, or host maintenance.
* **Containerized live environments** where manual operator unseal on every pod or container restart would be operationally painful.
* **Multi-node Raft clusters** where consistent startup automation is important.
* **Teams already using AWS IAM, CloudTrail, and KMS governance** for centralized key control.

Typical non-goals:

* Replacing HSM-backed Transit cryptography.
* Avoiding the need to protect recovery keys and bootstrap credentials.
* Making a laptop or throwaway lab deployment more secure than a simple local dev mode setup.

#### Production / Live Prerequisites

Before enabling AWS KMS auto-unseal, prepare:

* **An AWS KMS symmetric key** in the same region where your OpenBao nodes can reach it.
* **IAM permissions** allowing `kms:Encrypt`, `kms:Decrypt`, `kms:DescribeKey`, and typically `kms:GenerateDataKey*` for the OpenBao runtime identity.
* **Network egress** from the host/container to AWS KMS endpoints, whether directly, through NAT, or through a private VPC endpoint.
* **CloudTrail logging** for KMS operations so key usage is auditable.
* **Recovery key handling process** because recovery keys still need secure offline custody.
* **A plan for IAM credential delivery** such as EC2 instance profiles, ECS task roles, EKS IRSA, or another short-lived AWS credential source.

#### Example `bao.hcl` for AWS KMS Auto-Unseal

This example keeps Raft as the storage backend and uses AWS KMS only for auto-unseal:

```hcl
storage "raft" {
  path    = "/var/lib/bao"
  node_id = "node1"
}

listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable     = 0
  tls_cert_file   = "/etc/bao/tls/bao.crt"
  tls_key_file    = "/etc/bao/tls/bao.key"
}

seal "awskms" {
  region     = "eu-central-1"
  kms_key_id = "arn:aws:kms:eu-central-1:123456789012:key/11111111-2222-3333-4444-555555555555"
  endpoint   = "https://kms.eu-central-1.amazonaws.com"
}

api_addr     = "https://bao.example.internal:8200"
cluster_addr = "https://bao.example.internal:8201"
ui           = true
```

Notes:

* Prefer the full **KMS key ARN** rather than a short alias when you want configuration to be explicit across accounts and environments.
* `endpoint` is optional for normal AWS public-region use, but it can be useful when documenting a fixed region or using interface endpoints / special routing.
* Avoid hardcoding `access_key` and `secret_key` in `bao.hcl`. Prefer IAM roles or environment-based short-lived credentials.

#### Example IAM Policy for OpenBao Runtime

Attach a least-privilege IAM policy to the role used by the OpenBao process:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "OpenBaoKmsAutoUnseal",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:DescribeKey",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext"
            ],
            "Resource": "arn:aws:kms:eu-central-1:123456789012:key/11111111-2222-3333-4444-555555555555"
        }
    ]
}
```

If you also restrict usage in the KMS key policy, ensure the runtime role is explicitly allowed there too.

#### Rocky Linux / systemd Example with IAM-Friendly Configuration

If the server runs on EC2, the cleanest pattern is usually:

1. Attach an **instance profile / IAM role** to the VM.
2. Keep AWS credentials out of `bao.hcl` and out of the systemd unit.
3. Let OpenBao use the instance metadata credentials automatically.

The service file can remain simple:

```ini
[Unit]
Description=OpenBao Server
Requires=network-online.target
After=network-online.target

[Service]
User=openbao
Group=openbao
ExecStart=/usr/local/bin/bao server -config=/etc/bao/bao.hcl
ExecReload=/bin/kill --signal HUP $MAINPID
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```

If you are not on EC2 and must pass AWS settings through environment variables, prefer an environment file with restricted permissions, for example `/etc/openbao/openbao.env`:

```bash
AWS_REGION=eu-central-1
AWS_ROLE_ARN=arn:aws:iam::123456789012:role/openbao-prod-role
AWS_WEB_IDENTITY_TOKEN_FILE=/var/run/secrets/eks.amazonaws.com/serviceaccount/token
```

Then reference it in systemd:

```ini
EnvironmentFile=/etc/openbao/openbao.env
```

Ensure only the service user and administrators can read that file.

#### Production Docker Example with AWS KMS Auto-Unseal

For containers, the preferred production pattern is again to avoid static access keys and rely on the platform's IAM integration.

**docker-compose.prod.yaml:**

```yaml
version: '3.8'
services:
    openbao:
        image: quay.io/openbao/openbao:2.0.0
        container_name: openbao-prod
        restart: always
        ports:
            - "8200:8200"
            - "8201:8201"
        environment:
            - AWS_REGION=eu-central-1
        volumes:
            - ./config:/etc/bao:ro
            - ./data:/var/lib/bao
            - ./tls:/etc/bao/tls:ro
        cap_add:
            - IPC_LOCK
        command: server -config=/etc/bao/bao.hcl
```

In real orchestrated environments, map that idea to:

* **ECS** with a task role.
* **EKS** with IRSA.
* **Kubernetes outside AWS** with short-lived credentials from a secure broker rather than long-lived static keys.

#### Step-by-Step Live Setup Flow

1. **Create or select the KMS key** in AWS KMS.
2. **Create an IAM role** for the OpenBao nodes/containers with the minimum KMS permissions.
3. **Enable CloudTrail** and, if applicable, KMS key rotation according to your policy.
4. **Update `bao.hcl`** to include the `seal "awskms"` block.
5. **Deploy the configuration** and start OpenBao.
6. **Initialize once**:
   ```bash
   export BAO_ADDR='https://bao.example.internal:8200'
   bao operator init
   ```
7. **Securely store the recovery keys and initial root token** in an offline or separately controlled bootstrap process.
8. **Restart OpenBao and verify** that it comes back unsealed automatically.

#### How to Verify Auto-Unseal Is Working

After initialization, test a controlled restart.

Useful checks:

```bash
bao status
curl --silent $BAO_ADDR/v1/sys/seal-status
```

For systemd:

```bash
sudo systemctl restart openbao
sudo journalctl -u openbao -n 50 --no-pager
bao status
```

For Docker:

```bash
docker restart openbao-prod
docker logs --tail 50 openbao-prod
docker exec -it openbao-prod bao status
```

What you want to see:

* OpenBao starts successfully after restart.
* `Sealed` is `false` in status output.
* There is no need to run `bao operator unseal` manually.
* AWS KMS usage is visible in CloudTrail logs.

#### Developer Workstation Best Practices

For developer laptops and local machines, the best practice is usually **not** to use AWS KMS auto-unseal by default.

Recommended approach for most developers:

* Use **`server -dev`** for learning, demos, and throwaway local testing.
* Use a **local non-prod server config** only when you specifically need to learn initialization, sealing, policies, or production-like behavior.
* Avoid sharing a long-lived AWS account key across developer machines just to make local OpenBao start automatically.

If a developer truly needs to test AWS KMS auto-unseal locally:

* Use a **separate development AWS account or sandbox**.
* Use **temporary credentials** via AWS SSO, `aws-vault`, or another short-lived credential flow.
* Use a **dedicated dev KMS key** with tightly scoped IAM permissions.
* Keep the local environment clearly separated from live/prod naming, DNS, tokens, and policies.
* Expect startup to fail when offline or when AWS credentials expire, and document that behavior for the team.

Practical developer pattern:

1. Learn OpenBao features in `-dev` mode first.
2. Learn production concepts such as init/recovery/TLS with a local non-prod config next.
3. Test AWS KMS auto-unseal only in a dedicated sandbox when you specifically need to validate IAM, KMS, or restart automation.

#### Security and Operational Best Practices

* Prefer **IAM roles** over static `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`.
* Keep **KMS key administration** separate from day-to-day OpenBao administration when possible.
* Enable **CloudTrail** and review KMS access patterns.
* Keep **recovery keys offline** and split custody among trusted operators.
* Use **TLS for API and cluster traffic** even though KMS protects auto-unseal.
* Test **restart behavior**, **restore procedures**, and **regional failure assumptions** before going live.
* Consider **VPC endpoints for KMS** when you want tighter network control in AWS-hosted environments.
* Do not confuse **auto-unseal** with **hardware-backed Transit encryption**. If you need HSM-style cryptographic boundaries for data operations, that is a separate design topic.

#### Common Pitfalls

* Putting long-lived AWS secrets directly into `bao.hcl` or committed files.
* Forgetting that **initialization is still required once** even with auto-unseal enabled.
* Assuming auto-unseal removes the need for **recovery key custody**.
* Testing only first boot, but not testing a real restart after initialization.
* Ignoring AWS network reachability and DNS resolution from the OpenBao host.
* Using production KMS keys from unmanaged personal developer laptops.

## Payment / PIN System Notes

### Payment Systems, PIN Protection, and Chip & PIN Considerations

For payment environments, especially where **PIN data**, **PIN blocks**, **cardholder data**, or **EMV / Chip & PIN** related keys are involved, the answer is nuanced:

* **OpenBao can support surrounding key-management workflows**, secret distribution, application encryption services, certificate issuance, and access control.
* **It is not, by itself, automatically equivalent to a certified payment HSM** for all payment-network, issuer, acquirer, or card-personalization use cases.
* **PIN processing is a special domain**: real payment PIN handling usually requires dedicated controls around PIN block formats, cryptographic device certification, dual control, split knowledge, tamper resistance, and strict operational procedures.

In practical terms:

* For **application-level encryption of payment-adjacent secrets** or internal service credentials, OpenBao can be a strong fit.
* For **true online PIN encryption / translation / verification workflows**, organizations often still require a **dedicated payment HSM** or a service built on certified HSM infrastructure.
* For **EMV / Chip & PIN** ecosystems, OpenBao may help manage non-PIN secrets, certificates, service credentials, and some key-lifecycle automation, but the most sensitive issuer/acquirer cryptographic operations are commonly kept in specialized HSM platforms.

### Is OpenBao Supported for PIN Encryption?

OpenBao is technically capable of cryptographic operations and key management, but whether it is "supported" depends on the type of support you mean:

* **Technically possible for general encryption**: Yes, OpenBao Transit can encrypt/decrypt application data and manage keys.
* **Suitable as the only control for payment PIN operations**: Usually **not enough on its own** for serious PCI PIN / card-payment environments.
* **Suitable as part of a broader payment architecture**: Yes, potentially, when paired with certified HSMs, tightly scoped policies, auditing, and network segmentation.

If your requirement is specifically "store or process PIN-related keys and PIN blocks in a way acceptable for production card-payment operations," the safer guidance is:

1. Use **OpenBao** for orchestration, secret distribution, application auth, certificates, and possibly non-PIN encryption.
2. Use a **certified HSM or payment HSM** for actual PIN generation, PIN translation, PIN verification, Zone PIN Key handling, and other card-scheme-sensitive cryptographic operations.
3. Document the boundary very clearly so developers and auditors can distinguish **general secret management** from **payment cryptographic processing**.

### PCI-DSS and Related Compliance Considerations

PCI-DSS is broader than just encryption. Using OpenBao does not itself make an environment PCI-compliant. You still need architecture, process, and operational controls.

Typical expectations include:

* **Strong access control** with the least privilege and unique identities.
* **Audit logging** for all administrative and sensitive data access.
* **Key rotation and lifecycle management** with clear ownership and procedures.
* **Network segmentation** between cardholder data environments and less trusted zones.
* **TLS everywhere** for service-to-service and administrative access.
* **Secure backup and recovery procedures** for encrypted storage, initialization material, and recovery keys.
* **Separation of duties** so one operator does not control the entire cryptographic lifecycle alone.
* **Monitoring and alerting** for unusual access patterns, failed authentication, policy changes, and key-management events.

If PIN data is involved, you may also need to consider requirements beyond general PCI-DSS, such as **PCI PIN Security** expectations and the payment-network rules applicable to your role.

### What Should Be Done in Practice

If you want to use OpenBao in a payment environment, a practical approach is:

1. **Classify the data and operations**:
    * Are you protecting ordinary application secrets?
    * Are you handling PAN data?
    * Are you handling actual PIN blocks or issuer/acquirer PIN keys?
2. **Keep payment-HSM responsibilities separate** when PIN processing is in scope.
3. **Use Transit carefully** for application encryption use cases, but do not assume it replaces a certified payment cryptographic module.
4. **Enable audit devices early** and ship logs to a protected central system.
5. **Use auto-unseal carefully**:
    * Good for operational startup automation.
    * Not a replacement for HSM-backed payment cryptography.
6. **Apply strict policy design**:
    * Separate admin, operator, application, and auditor roles.
    * Avoid the use of root tokens outside the bootstrap.
    * Prefer short-lived auth methods such as AppRole, Kubernetes auth, or cloud IAM.
7. **Document compensating controls** for auditors:
    * Where keys live.
    * Which component performs encryption.
    * Which component is certified or not certified.
    * How key rotation, revocation, and incident response are handled.
8. **Validate with your QSA / compliance team** before go-live if the system will touch cardholder data or payment cryptography.

### Short Recommendation

* **OpenBao**: good for secrets management, application encryption, auth, PKI, and supporting controls.
* **Certified HSM / payment HSM**: preferred or required for sensitive PIN-centric cryptographic operations in real payment ecosystems.
* **PCI-DSS alignment**: achievable only with the full operating model, not just by deploying the product.

## Usage, tips and tricks

### Importing Key or Key Pairs via REST/curl

OpenBao Transit can import externally generated keys, but the imported material must first be wrapped with the Transit wrapping key.

1. **Fetch the Wrapping Key**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        $BAO_ADDR/v1/transit/wrapping_key
   ```

2. **Create an import-capable target key**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"type":"rsa-4096","imported_key":true}' \
        $BAO_ADDR/v1/transit/keys/imported-rsa
   ```

3. **Wrap the external key material**:
   The private key or symmetric key must be wrapped outside OpenBao using the previously fetched wrapping key. The exact wrapping procedure depends on the key type and the helper tooling you use.

4. **Import wrapped key**:
   Submit the wrapped key blob to the import endpoint.
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        --header "Content-Type: application/json" \
        --request POST \
        --data '{"ciphertext":"BASE64_WRAPPED_KEY","hash_function":"sha256"}' \
        $BAO_ADDR/v1/transit/keys/imported-rsa/import
   ```

5. **Verify imported key metadata**:
   ```bash
   curl --header "X-Bao-Token: $BAO_TOKEN" \
        $BAO_ADDR/v1/transit/keys/imported-rsa
   ```

Typical use cases for import:

* Migrating application keys from another HSM or KMS-backed workflow.
* Preserving an existing certificate authority or signing identity.
* Bringing externally generated symmetric keys under centralized access control.

### Policy Example for an Application

Example policy that allows an application to read one KV path and use one Transit key:

```hcl
path "secret/data/my-app" {
  capabilities = ["read"]
}

path "transit/encrypt/my-key" {
  capabilities = ["update"]
}

path "transit/decrypt/my-key" {
  capabilities = ["update"]
}
```

Load it with:

```bash
bao policy write my-app-policy my-app-policy.hcl
```

### Libraries for Application Integration

If you want to integrate OpenBao into application code instead of using only `curl`, the most practical approach is to use Vault-compatible clients because OpenBao keeps strong API compatibility with Vault 1.14-style APIs.

#### Java

Common library choices for Java applications:

* **Spring Vault** (`org.springframework.vault:spring-vault-core`) for Spring Boot / Spring Framework applications that need KV, Transit, token authentication, AppRole, or certificate workflows.
* **BetterCloud Vault Java Driver** (`com.bettercloud:vault-java-driver`) for non-Spring Java services that want a lightweight Vault/OpenBao client.
* **Plain HTTP clients** such as Spring `RestTemplate`, Spring `WebClient`, or `OkHttp` when you want direct control over OpenBao REST API calls.

Typical Java use cases:

* **Spring Boot secret loading** from KV for configuration and credentials.
* **Transit encryption/decryption** in microservices without storing raw key material in the application.
* **AppRole login flows** for machine-to-machine services.
* **PKI automation** for requesting certificates from internal platforms.

#### Python

Common library choices for Python applications:

* **HVAC** (`hvac`) is the main Python client for Vault-compatible APIs and is usually the first choice for OpenBao integrations.
* **Requests** (`requests`) is a good option when you want to call OpenBao REST endpoints directly and keep the integration very explicit.
* **HTTPX** (`httpx`) can be useful for async or modern HTTP-based integrations when building Python services.

Typical Python use cases:

* **Reading and rotating secrets** from KV for backend services, scripts, and automation.
* **Transit-based encryption, signing, and verification** in Python APIs and workers.
* **Operational automation** for policies, auth methods, and engine enablement.
* **PKI workflows** for issuing certificates or handling service bootstrap tasks.

#### Library Selection Tips

* Use **Spring Vault** when your application is already based on Spring Boot and you want higher-level integration.
* Use **vault-java-driver** or direct HTTP if you want a smaller dependency surface in Java.
* Use **HVAC** for most Python cases because it already maps many Vault/OpenBao features into Python methods.
* Use direct REST calls when you need a brand-new endpoint, want exact request control, or are documenting platform-neutral examples.

### Java Example (Using Spring Vault/OpenBao compatible client)

While `curl` is preferred for demonstration, Java applications can use standard libraries and Vault-compatible clients.

#### Java Example: Read KV Secret with Spring Vault

This example reads a KV v2 secret from `secret/data/my-app`.

```java
import java.util.Map;

import org.springframework.vault.authentication.TokenAuthentication;
import org.springframework.vault.client.VaultEndpoint;
import org.springframework.vault.core.VaultTemplate;
import org.springframework.vault.support.VaultResponseSupport;

public class OpenBaoSpringVaultKvExample {

    public static void main(String[] args) {
        VaultEndpoint endpoint = VaultEndpoint.create("127.0.0.1", 8200);
        endpoint.setScheme("http");

        VaultTemplate vaultTemplate = new VaultTemplate(
            endpoint,
            new TokenAuthentication("main-secret")
        );

        VaultResponseSupport<Map> response = vaultTemplate.read("secret/data/my-app", Map.class);
        System.out.println(response);
    }
}
```

Typical Maven dependency:

```xml

<dependency>
    <groupId>org.springframework.vault</groupId>
    <artifactId>spring-vault-core</artifactId>
</dependency>
```

#### Java Example: Transit Encrypt via REST API

This example calls the Transit engine directly and keeps the request format very close to the earlier `curl` examples.

```java
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

public class OpenBaoTransitEncryptExample {

    public static void main(String[] args) {
        RestTemplate restTemplate = new RestTemplate();

        String plaintext = Base64.getEncoder()
            .encodeToString("Hello OpenBao".getBytes(StandardCharsets.UTF_8));

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("X-Bao-Token", "main-secret");

        HttpEntity<Map<String, String>> request = new HttpEntity<>(
            Map.of("plaintext", plaintext),
            headers
        );

        ResponseEntity<Map> response = restTemplate.postForEntity(
            "http://127.0.0.1:8200/v1/transit/encrypt/my-key",
            request,
            Map.class
        );

        System.out.println(response.getBody());
    }
}
```

#### Python Example: Read KV Secret with HVAC

This example uses the common `hvac` client.

```python
import hvac

client = hvac.Client(url="http://127.0.0.1:8200", token="main-secret")

secret = client.secrets.kv.v2.read_secret_version(path="my-app", mount_point="secret")
print(secret["data"]["data"])
```

Install dependency:

```bash
pip install hvac
```

#### Python Example: Transit Encrypt via REST API

This example uses `requests` and mirrors the earlier REST flow.

```python
import base64
import requests

bao_addr = "http://127.0.0.1:8200"
bao_token = "main-secret"

plaintext = base64.b64encode(b"Hello OpenBao").decode("utf-8")

response = requests.post(
    f"{bao_addr}/v1/transit/encrypt/my-key",
    headers={
        "X-Bao-Token": bao_token,
        "Content-Type": "application/json",
    },
    json={"plaintext": plaintext},
    timeout=30,
)

response.raise_for_status()
print(response.json())
```

#### Python Example: AppRole Login

This is a common machine-to-machine bootstrap flow for Python services.

```python
import requests

bao_addr = "http://127.0.0.1:8200"

response = requests.post(
    f"{bao_addr}/v1/auth/approle/login",
    headers={"Content-Type": "application/json"},
    json={
        "role_id": "ROLE_ID",
        "secret_id": "SECRET_ID",
    },
    timeout=30,
)

response.raise_for_status()
client_token = response.json()["auth"]["client_token"]
print(client_token)
```

### Tips

* **Dev Mode**: Always use `-dev` for testing, never for production.
* **Base64**: Remember that the Transit engine always expects `plaintext` to be base64-encoded.
* **Unsealing**: In production, OpenBao starts "Sealed". Use `bao operator init` and `bao operator unseal`.
* **Root Token Hygiene**: Use the initial root token only for bootstrap tasks. Create scoped policies and auth roles for daily use.
* **Audit Logs**: Enable at least one audit device early in any live environment so access history is preserved from the beginning.
* **TLS Everywhere**: Use HTTPS for API access outside localhost development. Protect both `api_addr` and cluster communication.
* **Token TTLs**: Prefer short-lived child tokens or AppRole/Kubernetes auth over long-lived manually copied tokens.
* **Backups**: For Raft storage, schedule snapshots and test restore procedures before you need them.

## See also

* [OpenBao Official Website](https://openbao.org/)
* [OpenBao GitHub Repository](https://github.com/openbao/openbao)
* [OpenBao API Documentation](https://openbao.org/api-docs/)
