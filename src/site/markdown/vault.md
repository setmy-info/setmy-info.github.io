# HashiCorp Vault

## Information

HashiCorp Vault is an identity-based secrets and encryption management system. A modern computing environment is full of secrets: API keys, passwords, certificates, etc. Vault provides a unified interface to any secret while providing tight access control and recording a detailed audit log.

### Main Functionalities and Features

* **Secrets Management**: Securely store and control access to tokens, passwords, certificates, and encryption keys.
* **Dynamic Secrets**: Generate secrets on-demand for various systems, reducing the risk of static credential leaks.
* **Data Encryption**: Transit secrets engine allows applications to encrypt/decrypt data without storing it.
* **Leasing and Renewal**: All secrets have a lease, and must be renewed to remain valid.
* **Revocation**: Built-in support for revoking secrets or entire trees of secrets.
* **Audit Logging**: Keep a detailed record of all access and changes.

### Supported Cryptographic Algorithms

Vault supports various algorithms through its different engines, most notably the **Transit** engine:

* **Symmetric Encryption**:
    * `aes128-gcm96`: AES-GCM with 128-bit key.
    * `aes256-gcm96`: AES-GCM with 256-bit key (default).
    * `chacha20-poly1305`: ChaCha20-Poly1305 with 256-bit key.
* **Asymmetric Encryption & Signing**:
    * `rsa-2048`, `rsa-3072`, `rsa-4096`: RSA for encryption and signing.
    * `ecdsa-p256`, `ecdsa-p384`, `ecdsa-p521`: ECDSA for signing.
    * `ed25519`: Ed25519 for signing.
* **Hashing & MACs**:
    * `hmac`: Hash-based Message Authentication Code.
    * `sha2-224`, `sha2-256`, `sha2-384`, `sha2-512`: SHA-2 hash functions.
* **Format-Preserving Encryption (FPE)**:
    * `aes-ff1`: AES with Format-Preserving Encryption.

### Post-Quantum Cryptography (PQC) Notes

Vault is still primarily used with classical cryptographic primitives such as AES, RSA, ECDSA, Ed25519, SHA-2, and ChaCha20-Poly1305. In practice, PQC readiness for Vault today is mostly an **architecture and migration-planning topic**, not a signal that all Vault cryptographic operations are already natively quantum-resistant.

Key points:

* **Transit key types are mainly classical**. Commonly documented Vault Transit operations still center on classical symmetric and asymmetric algorithms.
* **Transport security can evolve sooner than application crypto**. PQC or hybrid PQC is most realistically introduced first in the TLS layer around Vault, for example through a reverse proxy, ingress, load balancer, service mesh, or compatible TLS library stack.
* **Auto-unseal, KMS, and HSM integrations remain useful**. They do not make Vault natively PQC by themselves, but they can provide a cleaner crypto boundary for future upgrades.
* **PKI migration is a separate design topic**. If you issue RSA or ECDSA certificates from Vault today, making the environment PQC-ready means planning for future certificate and trust-chain rotation rather than assuming existing PKI instantly becomes quantum-safe.

### Making Vault Data PQC-Ready

The practical meaning of "make Vault data PQC ready" is usually:

* **protect traffic with a transport stack that can adopt hybrid PQC earlier**,
* **minimize long-lived exposure of sensitive plaintext and exported keys**,
* **prefer strong symmetric defaults such as AES-256 where applicable**,
* **design applications for crypto agility** so certificates, trust anchors, and key types can be rotated later,
* **classify long-retention secrets and encrypted payloads** that may be exposed to "harvest now, decrypt later" risk,
* and **track external dependencies** such as client SDKs, ingress proxies, HSMs, KMS services, and internal PKI components that will influence your migration path.

Short recommendation:

1. Keep using Vault normally for secrets, Transit, PKI, and access control.
2. Introduce PQC or hybrid PQC first at the transport / edge layer when your platform supports it.
3. Keep key rotation, certificate rotation, and application configuration automated so future migration is operationally realistic.
4. Follow Vault, OpenSSL, cloud KMS, HSM, and platform release notes for native PQC-related developments.

## Installation

### CentOS, Rocky Linux

```bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo dnf -y install vault
```

### Fedora

```bash
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install vault
```

### macOS

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/vault
```

### FreeBSD

```bash
sudo pkg install vault
```

### OpenIndiana

```bash
pfexec pkg install vault
```

## Setup with Docker for Developer

For local development, you can run Vault in development mode using Docker.

### Docker Compose

Create a `docker-compose.yaml` file:

```yaml
version: '3.8'
services:
    vault:
        image: hashicorp/vault:latest
        container_name: vault
        ports:
            - "8200:8200"
        environment:
            VAULT_DEV_ROOT_TOKEN_ID: "main-secret-token"
            VAULT_ADDR: "http://0.0.0.0:8200"
        cap_add:
            - IPC_LOCK
```

Start it with:

```bash
docker-compose up -d
```

## Configuration

Vault is configured using HCL (HashiCorp Configuration Language). In production, a persistent storage backend is required.

### Storage Backend (Raft)

HashiCorp recommends **Integrated Storage (Raft)** for most production environments as it eliminates the need for external dependencies like Consul.

**Requirements:**

* **Persistent Storage**: A local directory with high-performance I/O (e.g., SSD).
* **Permissions**: The `vault` user (or container user) must have read/write access to the data directory.
* **Networking**: Nodes must be able to communicate over the cluster port (default `8201`) for replication and HA.

**Example Raft Configuration (`vault.hcl`):**

```hcl
storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true" # Set to "false" and provide certs for production!
}

api_addr      = "http://127.0.0.1:8200"
cluster_addr  = "https://127.0.0.1:8201"
ui            = true
```

## Live Environment Startup

### Rocky Linux (systemd)

When installed via `dnf`, Vault includes a systemd service unit.

1. **Configure**: Edit `/etc/vault.d/vault.hcl` with your storage and listener settings.
2. **Data Directory**: Ensure the directory exists and has correct permissions:
   ```bash
   sudo mkdir -p /opt/vault/data
   sudo chown -R vault:vault /opt/vault/data
   ```
3. **Start and Enable**:
   ```bash
   sudo systemctl enable --now vault
   ```
4. **Verify**:
   ```bash
   sudo systemctl status vault
   ```

### Docker (Live)

For a live environment, avoid "Dev Mode". Instead, mount configuration and data volumes.

**docker-compose.prod.yaml:**

```yaml
version: '3.8'
services:
    vault:
        image: hashicorp/vault:latest
        container_name: vault-prod
        ports:
            - "8200:8200"
            - "8201:8201"
        volumes:
            - ./config:/vault/config
            - ./data:/vault/data
        cap_add:
            - IPC_LOCK
        command: server
```

Start with:

```bash
docker-compose -f docker-compose.prod.yaml up -d
```

### Post-Startup: Initialization and Unsealing

After starting a new live instance, it will be in a "Sealed" state and must be initialized.

1. **Initialize**:
   ```bash
   export VAULT_ADDR='http://127.0.0.1:8200'
   vault operator init
   ```
   *Important: Save the generated Unseal Keys and Root Token in a secure, offline location.*

2. **Unseal**:
   Vault requires a quorum of unseal keys (default 3 of 5) to start:
   ```bash
   vault operator unseal # Repeat until Unseal Progress reaches the threshold
   ```

3. **Login**:
   ```bash
   vault login
   ```

### Backup and Restore Notes

Whether the deployment is a developer sandbox or a live environment, backup planning should include more than just the data directory. A usable Vault backup strategy usually includes **Raft snapshots, configuration, TLS references, audit setup, and secure handling of bootstrap materials**.

#### Developer / Local Machine Backups

For developer machines, decide first whether the instance is ephemeral:

* **Dev mode (`-dev` or the simple Docker dev setup)** is usually disposable and normally does **not** need backup.
* **Local non-dev Vault with persistent Raft storage** should be backed up if it contains reusable policies, Transit keys, PKI state, or demo data you want to keep.

Recommended developer backup scope:

* **Raft snapshot** of the local instance.
* Local **`vault.hcl`** and any companion environment files.
* Local **TLS certificates / keys** if the instance is running with HTTPS.
* Any external **policy files**, helper scripts, and example bootstrap material stored outside Vault.

Example developer snapshot:

```bash
export VAULT_ADDR='https://127.0.0.1:8200'
vault operator raft snapshot save ./backup/vault-dev-$(date +%F).snap
```

Developer notes:

* Do not store the only backup copy in the same directory as the active data files.
* Treat snapshot files as sensitive because they represent the protected state of the Vault cluster.
* For throwaway labs, documented rebuild steps may be more valuable than preserving every local backup.

#### Live / Production Backups

For live environments, define a standard backup set:

1. **Scheduled Raft snapshots**.
2. **Configuration backup** for `vault.hcl`, systemd overrides, container manifests, seal configuration references, and environment files.
3. **TLS asset backup** or a tested process to re-issue the same server certificates and trust chain.
4. **Unseal / recovery material custody process** kept offline or in a separately controlled secure system.
5. **Policy and infrastructure-as-code backup** so the platform can be recreated consistently.

Typical production snapshot command:

```bash
export VAULT_ADDR='https://vault.example.internal:8200'
vault operator raft snapshot save /secure-backup/vault-$(date +%F-%H%M).snap
```

Important live backup notes:

* **Prefer supported Raft snapshots over ad-hoc filesystem copies** of a running cluster.
* **Auto-unseal is not a backup feature**. AWS KMS or HSM seal integration helps startup and key protection, but it does not replace snapshots.
* **Store copies off-host and off-cluster** to survive node loss, operator error, ransomware, or storage corruption.
* **Protect access to backups** with encryption, least privilege, retention rules, and auditability.
* **Run restore drills** in a non-production environment so the team knows the process actually works.

#### What to Verify During Restore Tests

At minimum, validate that you can:

* restore the snapshot to a clean Vault environment,
* unseal or auto-unseal the instance successfully,
* authenticate with the intended administrative recovery path,
* read a known KV secret,
* use a known Transit key,
* and verify expected PKI or auth-method state if those features are in scope.

#### Backups and PQC Readiness Together

If you are also preparing for long-term PQC migration, backups should help future algorithm transitions rather than block them:

* keep documentation of **which algorithms, key types, and certificate chains** are currently in use,
* keep **policy and automation definitions** under version control so re-issuance and rotation can be repeated later,
* and avoid undocumented manual crypto workflows that would make future migration or re-encryption efforts much harder.

## AWS Integration (KMS & CloudHSM)

Vault integrates deeply with AWS to provide automated unsealing and hardware-backed cryptography.

### AWS KMS Auto-Unseal

Instead of manual unsealing with key shards, Vault can use **AWS KMS** to automatically encrypt and decrypt its master key.

**Configuration (`vault.hcl`):**

```hcl
seal "awskms" {
  region     = "us-east-1"
  access_key = "AWS_ACCESS_KEY"    # Recommended: Use IAM Roles instead
  secret_key = "AWS_SECRET_KEY"    # Recommended: Use IAM Roles instead
  kms_key_id = "your-kms-key-id"
}
```

### AWS CloudHSM (Hardware Security Module)

For FIPS 140-2 Level 3 compliance or high-performance hardware-backed encryption, Vault can offload cryptographic operations to **AWS CloudHSM** using the PKCS#11 provider.

**Configuration for HSM Seal (PKCS#11):**

```hcl
seal "pkcs11" {
  lib            = "/opt/cloudhsm/lib/libcloudhsm_pkcs11.so"
  slot           = "1"
  pin            = "HSM_USER:HSM_PASSWORD"
  key_label      = "vault-hsm-key"
  hmac_key_label = "vault-hsm-hmac-key"
}
```

### Combining KMS and HSM

It is possible to architect a solution using both:

1. **Main Secret (Seal)**: Use **AWS KMS** for Auto-Unseal. This handles the protection of the master key.
2. **Hardware Encryption**: Use **CloudHSM** for **Entropy Augmentation** (improving random number generation quality) or as a backend for the **Transit engine** (requires Vault Enterprise for Managed Keys) to perform AES hardware-accelerated encryption.

This setup allows Vault to boot automatically via KMS while ensuring the highest level of cryptographic security for data operations via HSM.

## OpenBao Compatibility and Payment / PIN System Notes

If you are comparing Vault with its open-source fork, also see [OpenBao Documentation](openbao.md).

### OpenBao Compatibility

For many common secrets-management and Transit use cases, OpenBao is broadly compatible with HashiCorp Vault 1.14-style APIs and workflows:

* **Transit API compatibility**: Basic encrypt/decrypt, sign/verify, key creation, key import, and policy-driven access patterns are largely intended to remain compatible.
* **Operational model**: Initialization, sealing/unsealing, Raft storage, auth methods, and most day-to-day API concepts are very similar.
* **Migration mindset**: Existing Vault scripts and clients often need only endpoint, binary, or environment-variable adjustments.

That said, for regulated payment workloads you should validate exact version behavior, support expectations, audit requirements, and external integrations in a controlled environment before treating OpenBao as a drop-in replacement for an already qualified Vault deployment.

### Payment Systems, PIN Protection, and Chip & PIN Considerations

For payment environments, especially where **PIN data**, **PIN blocks**, **cardholder data**, or **EMV / Chip & PIN** related keys are involved, the answer is nuanced:

* **OpenBao / Vault can support surrounding key-management workflows**, secret distribution, application encryption services, certificate issuance, and access control.
* **They are not, by themselves, automatically equivalent to a certified payment HSM** for all payment-network, issuer, acquirer, or card-personalization use cases.
* **PIN processing is a special domain**: real payment PIN handling usually requires dedicated controls around PIN block formats, cryptographic device certification, dual control, split knowledge, tamper resistance, and strict operational procedures.

In practical terms:

* For **application-level encryption of payment-adjacent secrets** or internal service credentials, Vault/OpenBao can be a strong fit.
* For **true online PIN encryption / translation / verification workflows**, organizations often still require a **dedicated payment HSM** or a service built on certified HSM infrastructure.
* For **EMV / Chip & PIN** ecosystems, Vault/OpenBao may help manage non-PIN secrets, certificates, service credentials, and some key-lifecycle automation, but the most sensitive issuer/acquirer cryptographic operations are commonly kept in specialized HSM platforms.

### Is OpenBao Supported for PIN Encryption?

OpenBao is technically capable of cryptographic operations and key management similar to Vault, but whether it is "supported" depends on the type of support you mean:

* **Technically possible for general encryption**: Yes, OpenBao Transit can encrypt/decrypt application data and manage keys.
* **Suitable as the only control for payment PIN operations**: Usually **not enough on its own** for serious PCI PIN / card-payment environments.
* **Suitable as part of a broader payment architecture**: Yes, potentially, when paired with certified HSMs, tightly scoped policies, auditing, and network segmentation.

If your requirement is specifically "store or process PIN-related keys and PIN blocks in a way acceptable for production card-payment operations," the safer guidance is:

1. Use **Vault/OpenBao** for orchestration, secret distribution, application auth, certificates, and possibly non-PIN encryption.
2. Use a **certified HSM or payment HSM** for actual PIN generation, PIN translation, PIN verification, Zone PIN Key handling, and other card-scheme-sensitive cryptographic operations.
3. Document the boundary very clearly so developers and auditors can distinguish **general secret management** from **payment cryptographic processing**.

### PCI-DSS and Related Compliance Considerations

PCI-DSS is broader than just encryption. Using Vault or OpenBao does not itself make an environment PCI-compliant. You still need architecture, process, and operational controls.

Typical expectations include:

* **Strong access control** with least privilege and unique identities.
* **Audit logging** for all administrative and sensitive data access.
* **Key rotation and lifecycle management** with clear ownership and procedures.
* **Network segmentation** between cardholder data environments and less trusted zones.
* **TLS everywhere** for service-to-service and administrative access.
* **Secure backup and recovery procedures** for encrypted storage, initialization material, and recovery keys.
* **Separation of duties** so one operator does not control the entire cryptographic lifecycle alone.
* **Monitoring and alerting** for unusual access patterns, failed authentication, policy changes, and key-management events.

If PIN data is involved, you may also need to consider requirements beyond general PCI-DSS, such as **PCI PIN Security** expectations and the payment-network rules applicable to your role.

### What Should Be Done in Practice

If you want to use Vault or OpenBao in a payment environment, a practical approach is:

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
    * Avoid use of root tokens outside bootstrap.
    * Prefer short-lived auth methods such as AppRole, Kubernetes auth, or cloud IAM.
7. **Document compensating controls** for auditors:
    * Where keys live.
    * Which component performs encryption.
    * Which component is certified or not certified.
    * How key rotation, revocation, and incident response are handled.
8. **Validate with your QSA / compliance team** before go-live if the system will touch cardholder data or payment cryptography.

### Short Recommendation

* **Vault / OpenBao**: good for secrets management, application encryption, auth, PKI, and supporting controls.
* **Certified HSM / payment HSM**: preferred or required for sensitive PIN-centric cryptographic operations in real payment ecosystems.
* **PCI-DSS alignment**: achievable only with the full operating model, not just by deploying the product.

## Usage, tips and tricks

### Importing Key or Key Pairs via REST/curl

Vault allows importing external keys into the Transit engine. This requires a "wrapping" process for security.

#### 1. Fetch the Wrapping Key

First, get the public wrapping key from Vault.

```bash
curl --header "X-Vault-Token: $VAULT_TOKEN" \
     $VAULT_ADDR/v1/transit/wrapping_key
```

#### 2. Wrap the External Key

The external key must be wrapped (encrypted) using the wrapping key fetched in the previous step (typically using RSA-OAEP).

#### 3. Import to Vault

Submit the wrapped key to Vault.

```bash
curl --header "X-Vault-Token: $VAULT_TOKEN" \
     --request POST \
     --data '{
       "type": "rsa-2048",
       "ciphertext": "BASE64_WRAPPED_KEY",
       "hash_function": "sha256"
     }' \
     $VAULT_ADDR/v1/transit/keys/my-imported-key/import
```

### Coding tips and tricks

* **Token Management**: Use `VAULT_TOKEN` environment variable for local development.
* **Error Handling**: Always check for `403 Forbidden` errors, which usually indicate expired tokens or insufficient policies.
* **Leases**: Implement logic to renew leases for dynamic secrets.

## See also

* [HashiCorp Vault Documentation](https://developer.hashicorp.com/vault/docs)
* [Vault API Reference](https://developer.hashicorp.com/vault/api-docs)
* [OpenBao Documentation (Open Source Fork)](openbao.md)
