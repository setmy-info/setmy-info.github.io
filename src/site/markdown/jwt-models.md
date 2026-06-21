# jwt-models

## Information

JWT (JSON Web Token) is a compact, URL-safe means of representing claims to be transferred between two parties. It is
defined in [RFC 7519](https://www.rfc-editor.org/rfc/rfc7519). JWTs are widely used for authentication and
authorization in REST APIs and web applications.

A JWT consists of three Base64URL-encoded parts separated by dots:

```
header.payload.signature
```

### Header

The header declares the token type and signing algorithm:

```json
{
    "alg": "RS256",
    "typ": "JWT"
}
```

### Payload (Claims)

The payload contains claims — statements about an entity (typically the user) and additional metadata:

```json
{
    "iss": "https://auth.example.com",
    "sub": "user:42",
    "aud": "https://api.example.com",
    "exp": 1719000000,
    "iat": 1718996400,
    "nbf": 1718996400,
    "jti": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "name": "John Doe",
    "email": "john@example.com",
    "roles": ["user", "admin"]
}
```

### Standard Claims

| Claim | Name              | Description                                          |
|-------|-------------------|------------------------------------------------------|
| `iss` | Issuer            | Who issued the token (URL of the authorization server) |
| `sub` | Subject           | Who the token is about (user ID or entity identifier) |
| `aud` | Audience          | Who the token is intended for (API or service URL)   |
| `exp` | Expiration Time   | Unix timestamp after which the token must not be accepted |
| `iat` | Issued At         | Unix timestamp when the token was issued             |
| `nbf` | Not Before        | Unix timestamp before which the token must not be accepted |
| `jti` | JWT ID            | Unique identifier for the token (used to prevent replay) |

### Signature

The signature is computed over `base64url(header) + "." + base64url(payload)` using the algorithm declared in the header. It prevents tampering with the token contents.

## Token Types

### Access Token

* Short-lived (typically 5–60 minutes).
* Sent with every API request (usually in the `Authorization: Bearer <token>` header).
* Contains claims needed to authorize the request (roles, scopes, user ID).
* Should **not** be stored in `localStorage` — prefer memory or `httpOnly` cookies.

### Refresh Token

* Long-lived (hours to weeks).
* Used only to obtain a new access token from the authorization server.
* Must be stored securely (`httpOnly` cookie or secure server-side session).
* Should be rotated on each use (rotation invalidates old refresh tokens).

### ID Token

* Defined by OpenID Connect (OIDC), not plain OAuth 2.0.
* Contains identity information about the authenticated user.
* Intended for the **client application**, not for API calls.
* Should be validated but not forwarded to resource servers.

## Signing Algorithms

| Algorithm | Type       | Description                                              | Use case                        |
|-----------|------------|----------------------------------------------------------|---------------------------------|
| `HS256`   | Symmetric  | HMAC-SHA256 — shared secret between issuer and verifier  | Single-server or internal APIs  |
| `HS384`   | Symmetric  | HMAC-SHA384                                              | Same as HS256, stronger hash    |
| `RS256`   | Asymmetric | RSA + SHA256 — private key signs, public key verifies    | Distributed systems, public APIs |
| `RS512`   | Asymmetric | RSA + SHA512                                             | Same as RS256, stronger hash    |
| `ES256`   | Asymmetric | ECDSA + P-256 + SHA256 — smaller key, similar security   | Mobile, IoT, performance-sensitive |
| `EdDSA`   | Asymmetric | Ed25519 — fast, compact, modern                          | Modern systems                  |

Prefer **RS256** or **ES256** for public-facing APIs because the public key can be published (JWKS endpoint) and
verifiers do not need the private key.

Avoid **none** algorithm — it is a security vulnerability that some libraries permit.

## Configuration

### JWKS Endpoint

Authorization servers publish their public keys at a JWKS (JSON Web Key Set) URL, conventionally:

```
https://auth.example.com/.well-known/jwks.json
```

Clients fetch this to verify token signatures without sharing a secret.

### OpenID Connect Discovery

```
https://auth.example.com/.well-known/openid-configuration
```

Returns the server metadata including `jwks_uri`, `issuer`, `token_endpoint`, and supported algorithms.

## Usage, tips and tricks

### Validation Checklist

When validating an incoming JWT:

1. Verify the signature using the correct key and algorithm.
2. Check `exp` — reject expired tokens.
3. Check `nbf` — reject tokens not yet valid.
4. Check `iss` — must match your expected issuer.
5. Check `aud` — must include your service identifier.
6. Check `jti` against a revocation list if token revocation is required.

### Security Considerations

* Never trust the `alg` header value alone — validate against an allowed-algorithms list on your server.
* Do not store sensitive data in the payload — it is Base64URL-encoded, not encrypted (use JWE for encryption).
* Set short `exp` values for access tokens and rotate refresh tokens.
* Use `httpOnly`, `Secure`, `SameSite=Strict` cookies when persisting tokens in browsers.
* Implement token revocation via JTI blocklist or refresh token rotation for logout flows.

### Decode Without Verification (debugging only)

```shell
# Decode payload (no signature check — debug use only)
echo "eyJhbGci..." | cut -d. -f2 | base64 -d 2>/dev/null | python3 -m json.tool
```

Or use [jwt.io](https://jwt.io/) for visual inspection during development.

## See also

* [RFC 7519 — JSON Web Token](https://www.rfc-editor.org/rfc/rfc7519)
* [RFC 7517 — JSON Web Key (JWK)](https://www.rfc-editor.org/rfc/rfc7517)
* [OpenID Connect Core](https://openid.net/specs/openid-connect-core-1_0.html)
* [jwt.io](https://jwt.io/)
* [keycloak.md](keycloak.md)
* [passkeys.md](passkeys.md)
* [rest.md](rest.md)
