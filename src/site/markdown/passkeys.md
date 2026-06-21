# Passkeys

## Information

**Passkeys** are a FIDO2/WebAuthn-based passwordless authentication mechanism. They replace passwords with
public-key cryptography: a key pair is created per account, the private key stays on the user's device (never
transmitted), and the public key is stored on the server.

### How they work

1. Registration: the authenticator (device/platform) generates a key pair. The public key is sent to and stored by
   the relying party (server). The private key never leaves the device.
2. Authentication: the server sends a challenge. The authenticator signs it with the private key. The server verifies
   the signature with the stored public key.
3. User verification: the device requires biometric (Face ID, Touch ID, fingerprint) or PIN before releasing the
   private key for signing.

### Advantages over passwords

* **Phishing-resistant** — private key is bound to the specific origin (domain); cannot be used on fake sites.
* **No password reuse** — each passkey is unique per account and site.
* **No credential stuffing** — no server-side password hash to steal and crack.
* **Biometric binding** — device-level user verification.
* **Synchronisation** — platform passkeys (iCloud Keychain, Google Password Manager) sync across user's devices.

### Platform support

| Platform             | Authenticator                               |
|----------------------|---------------------------------------------|
| iOS / iPadOS 16+     | Face ID, Touch ID (iCloud Keychain sync)    |
| Android 9+           | Fingerprint/PIN (Google Password Manager sync) |
| Windows 10/11        | Windows Hello (PIN, face, fingerprint)      |
| macOS / Safari       | Touch ID (iCloud Keychain sync)             |
| Hardware keys        | YubiKey, FIDO2 security keys                |
| Cross-device         | QR code flow — phone authenticates desktop  |

### Types

* **Synced (platform) passkeys** — private key syncs via cloud (iCloud Keychain, Google PM). Convenient, survives
  device loss, but key leaves device.
* **Device-bound passkeys** — private key locked to one hardware key (FIDO2 security key) or device TPM/Secure
  Enclave. Higher security, no sync.

## Configuration

Key parameters for a relying party implementation:

| Parameter       | Description                                            | Example              |
|-----------------|--------------------------------------------------------|----------------------|
| `rpId`          | Relying Party ID — the domain the credential is bound to | `example.com`       |
| `rpName`        | Human-readable name shown to the user                  | `My Application`     |
| `origin`        | Full origin of the web app (must match `rpId`)         | `https://example.com`|
| `challenge`     | Random bytes (≥16 bytes) sent per authentication request | crypto random       |
| `userVerification` | Require device PIN/biometric (`required`/`preferred`/`discouraged`) | `preferred` |
| `attestation`   | Level of device attestation required (`none`/`indirect`/`direct`) | `none` (most sites) |

## Usage, tips and tricks

### Server-side libraries

| Library           | Language   | Notes                              |
|-------------------|------------|------------------------------------|
| `SimpleWebAuthn`  | TypeScript | Well-maintained, browser + server  |
| `py_webauthn`     | Python     | Flask/Django integration           |
| `java-webauthn-server` | Java  | Yubico's reference implementation  |
| `webauthn4j`      | Java       | Spring Boot integration available  |

### Browser API (registration)

```javascript
const credential = await navigator.credentials.create({
    publicKey: {
        challenge: crypto.getRandomValues(new Uint8Array(32)),
        rp: { name: "My App", id: "example.com" },
        user: { id: userId, name: "user@example.com", displayName: "User" },
        pubKeyCredParams: [{ type: "public-key", alg: -7 }], // ES256
        authenticatorSelection: { userVerification: "preferred" }
    }
});
```

### Practical notes

* Always validate `rpId` and `origin` on the server — this is the anti-phishing guarantee.
* Store the full `credentialId`, `publicKey`, and `signCount` per credential per user.
* Increment `signCount` check prevents cloned credential replay attacks.
* Offer passkeys alongside (not instead of) a password + 2FA option during transition.

## See also

* [passkeys.io](https://www.passkeys.io/)
* [passkeys.dev](https://passkeys.dev/)
* [WebAuthn specification](https://www.w3.org/TR/webauthn-3/)
* [FIDO Alliance](https://fidoalliance.org/)
* [Hanko](https://www.hanko.io/)
* [SimpleWebAuthn](https://simplewebauthn.dev/)
