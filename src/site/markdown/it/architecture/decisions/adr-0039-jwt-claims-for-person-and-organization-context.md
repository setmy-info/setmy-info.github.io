# Architecture Decision Record (ADR)

ADR-0039: JWT claims for person and organization context Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

A person may belong to zero or more organizations. Zero memberships mean the person acts privately. When one or more
memberships exist, the system must know which organization and role the person has selected for the current session,
because the same person holds different permissions in different contexts. JWT is the token format. Claims must align
with RFC 7519 and OIDC Core so that Keycloak can set or populate them without custom workarounds.

## 3. Decision

Use the following claim set. Standard OIDC claims carry a person's identity; two extended claims carry the active
organization context chosen at session start. Absent or null `org_id` is the explicit marker for private or
no-organization context.

RFC 7519 registered claims (token lifecycle and routing, Keycloak sets these by default):

* `iss` - Issuer
* `sub` - Subject; stable unique person identifier (Keycloak UUID); this is the authoritative primary key that all
  systems must use when linking records, accounts, or audit entries to a person — it never changes even when the
  person updates their name, email, or username in Keycloak
* `aud` - Audience
* `jti` - JWT ID
* `iat` - Issued At
* `nbf` - Not Before
* `exp` - Expiration

OIDC Core standard claims (person identity, Keycloak sets these by default from realm user attributes):

* `given_name` - First name
* `middle_name` - Middle name
* `family_name` - Family name
* `email` - Email address
* `preferred_username` - Login username

Extended claims (populated via Keycloak protocol mappers or session-aware token enrichment; Keycloak 26+ supports
organization context natively):

* `orgs` - String array of all organization identifiers the person belongs to; empty array means the person has no
  organization memberships; present in every token regardless of which context is active, allowing systems and UIs
  to know upfront whether the person has any memberships at all
* `org_id` - Identifier of the organization the person has selected for this session; absent when acting privately
* `org_role` - Roles within the selected organization as a string array; absent when no organization is active; a
  person may hold multiple roles in one organization simultaneously, for example `["DEVELOPER", "TEAM_LEAD"]`

The non-standard short-name claims `uid`, `rls`, `fnm`, `mnm`, `lnm` are deprecated and must not appear in new tokens.

| Deprecated claim | Standard replacement | Source              |
|------------------|----------------------|---------------------|
| `uid`            | `sub`                | RFC 7519            |
| `rls`            | `realm_access.roles` | Keycloak convention |
| `fnm`            | `given_name`         | OIDC Core           |
| `mnm`            | `middle_name`        | OIDC Core           |
| `lnm`            | `family_name`        | OIDC Core           |

### Example token claim values

The following table shows how claims are filled for a person who is an employee of setmy.info (the company that owns
the Keycloak realm and all managed systems) and is currently acting in an organizational context, versus acting
privately.

| Claim                | Organizational context example         | Private context example                |
|----------------------|----------------------------------------|----------------------------------------|
| `iss`                | `https://auth.setmy.info/realms/main`  | `https://auth.setmy.info/realms/main`  |
| `sub`                | `a3f1c2d4-...` (Keycloak UUID)         | `a3f1c2d4-...` (Keycloak UUID)         |
| `preferred_username` | `john.doe`                             | `john.doe`                             |
| `given_name`         | `John`                                 | `John`                                 |
| `middle_name`        | _(absent)_                             | _(absent)_                             |
| `family_name`        | `Doe`                                  | `Doe`                                  |
| `email`              | `john.doe@example.com`                 | `john.doe@example.com`                 |
| `aud`                | `["frontend", "api"]`                  | `["frontend", "api"]`                  |
| `orgs`               | `["setmy.info", "other.org"]`          | `[]`                                   |
| `org_id`             | `setmy.info`                           | _(absent)_                             |
| `org_role`           | `["DEVELOPER", "TEAM_LEAD"]`           | _(absent)_                             |
| `iat`                | `1718445600` (2024-06-15 10:00:00 UTC) | `1718445600` (2024-06-15 10:00:00 UTC) |
| `exp`                | `1718446500` (2024-06-15 10:15:00 UTC) | `1718446500` (2024-06-15 10:15:00 UTC) |
| `nbf`                | `1718445600` (2024-06-15 10:00:00 UTC) | `1718445600` (2024-06-15 10:00:00 UTC) |
| `jti`                | `afad8212-27da-46cd-a90b-ce7c2502b953` | `afad8212-27da-46cd-a90b-ce7c2502b953` |

## 4. Rationale (Justification):

OIDC standard claim names are interoperable, recognized by Keycloak without extra mappers, and understood by downstream
libraries. A dedicated `org_id` field makes the selected-context intent explicit and avoids encoding organization
identity inside role strings. Absence of `org_id` is a clear zero-organization or private-person signal that requires no
special sentinel value. Keycloak 26+ organization support can populate `org_id` directly; earlier versions use a
session-note protocol mapper.

## 3. Consequences, Impacts & Follow-up Actions

`ExtendedJWTToken` must replace `fnm`, `mnm`, `lnm` with `given_name`, `middle_name`, `family_name` and add `org_id`
and `org_role` fields. The `uid` field should be removed in favor of `sub`. The `rls` field should be replaced by
`realm_access.roles` for realm-level roles. Keycloak realm configuration must include protocol mappers for `org_id`
and `org_role`. The login or session-start flow must capture the person's selected organization and role and embed them
in the issued token. Systems consuming tokens must treat absent `org_id` as the private-person context and must not
require an organization to be present. If the person switches organization or role during an active session, the current
token must be discarded and a new token issued for the new context; `org_id` and `org_role` are baked in at token
issuance time and cannot change without re-issuance.

### Design notes

`sub` is the sole authoritative identity key. Systems must store and look up persons by `sub`. The human-readable
claims `preferred_username`, `given_name`, `family_name`, and `email` are display and contact data only; they may be
updated in Keycloak at any time and must not be used as primary keys or foreign keys in persistent storage.

`orgs` is always present in the token and reflects all organization memberships of the person at token issuance time.
An empty `orgs` array means the person has no memberships and can only act privately; a non-empty `orgs` array means
the person has memberships but may still choose to act privately for a given session (absent `org_id`). This allows
UIs to show or hide the organization selection screen without an extra API call.

https://adr.github.io/

[Keycloak notes](../../../keycloak.md)
