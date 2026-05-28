# HashiCorp Vault

## Information

HashiCorp Vault is an identity-based secrets and encryption management system. A modern computing environment is full of secrets: API keys, passwords, certificates, etc. Vault provides a unified interface to any secret while providing tight access control and recording a detailed audit log.

### Main Functionalities and Features

*   **Secrets Management**: Securely store and control access to tokens, passwords, certificates, and encryption keys.
*   **Dynamic Secrets**: Generate secrets on-demand for various systems, reducing the risk of static credential leaks.
*   **Data Encryption**: Transit secrets engine allows applications to encrypt/decrypt data without storing it.
*   **Leasing and Renewal**: All secrets have a lease, and must be renewed to remain valid.
*   **Revocation**: Built-in support for revoking secrets or entire trees of secrets.
*   **Audit Logging**: Keep a detailed record of all access and changes.

### Supported Cryptographic Algorithms

Vault supports various algorithms through its different engines, most notably the **Transit** engine:

*   **Symmetric Encryption**:
    *   `aes128-gcm96`: AES-GCM with 128-bit key.
    *   `aes256-gcm96`: AES-GCM with 256-bit key (default).
    *   `chacha20-poly1305`: ChaCha20-Poly1305 with 256-bit key.
*   **Asymmetric Encryption & Signing**:
    *   `rsa-2048`, `rsa-3072`, `rsa-4096`: RSA for encryption and signing.
    *   `ecdsa-p256`, `ecdsa-p384`, `ecdsa-p521`: ECDSA for signing.
    *   `ed25519`: Ed25519 for signing.
*   **Hashing & MACs**:
    *   `hmac`: Hash-based Message Authentication Code.
    *   `sha2-224`, `sha2-256`, `sha2-384`, `sha2-512`: SHA-2 hash functions.
*   **Format-Preserving Encryption (FPE)**:
    *   `aes-ff1`: AES with Format-Preserving Encryption.

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
*   **Persistent Storage**: A local directory with high-performance I/O (e.g., SSD).
*   **Permissions**: The `vault` user (or container user) must have read/write access to the data directory.
*   **Networking**: Nodes must be able to communicate over the cluster port (default `8201`) for replication and HA.

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

1.  **Configure**: Edit `/etc/vault.d/vault.hcl` with your storage and listener settings.
2.  **Data Directory**: Ensure the directory exists and has correct permissions:
    ```bash
    sudo mkdir -p /opt/vault/data
    sudo chown -R vault:vault /opt/vault/data
    ```
3.  **Start and Enable**:
    ```bash
    sudo systemctl enable --now vault
    ```
4.  **Verify**:
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

1.  **Initialize**:
    ```bash
    export VAULT_ADDR='http://127.0.0.1:8200'
    vault operator init
    ```
    *Important: Save the generated Unseal Keys and Root Token in a secure, offline location.*

2.  **Unseal**:
    Vault requires a quorum of unseal keys (default 3 of 5) to start:
    ```bash
    vault operator unseal # Repeat until Unseal Progress reaches the threshold
    ```

3.  **Login**:
    ```bash
    vault login
    ```

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
1.  **Main Secret (Seal)**: Use **AWS KMS** for Auto-Unseal. This handles the protection of the master key.
2.  **Hardware Encryption**: Use **CloudHSM** for **Entropy Augmentation** (improving random number generation quality) or as a backend for the **Transit engine** (requires Vault Enterprise for Managed Keys) to perform AES hardware-accelerated encryption.

This setup allows Vault to boot automatically via KMS while ensuring the highest level of cryptographic security for data operations via HSM.

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

*   **Token Management**: Use `VAULT_TOKEN` environment variable for local development.
*   **Error Handling**: Always check for `403 Forbidden` errors, which usually indicate expired tokens or insufficient policies.
*   **Leases**: Implement logic to renew leases for dynamic secrets.

## See also

* [HashiCorp Vault Documentation](https://developer.hashicorp.com/vault/docs)
* [Vault API Reference](https://developer.hashicorp.com/vault/api-docs)
