# Architecture Decision Record (ADR)

ADR-0038: AWS S3 bucket and key naming derived from gintra Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

Gintra already defines a stable internal namespace with typed top-level subtrees such as `organizations/` and
`persons/`, and organization data is identified by `<cc>/<org>`. If AWS S3 is used for gintra-related storage, object
names should follow the same structure instead of inventing a separate cloud-only naming model.

## 3. Decision

Use S3 bucket names as coarse infrastructure boundaries and use S3 object keys for the real gintra namespace. Keep
bucket names short, lowercase, and provider-scoped, for example `setmy-info-gintra-<scope>`, and put gintra structure
into keys such as `organizations/<cc>/<org>/...` and `persons/<person-hash>/...`. For example, with country code `ee`
and organization short name `has`, the logical gintra organization path is
`/var/opt/setmy.info/gintra/organizations/ee/has`,
the matching S3 key prefix is `organizations/ee/has/`, and a suitable bucket set is `setmy-info-gintra-dev`,
`setmy-info-gintra-test`, `setmy-info-gintra-ci`, and `setmy-info-gintra-live`.

## 4. Rationale (Justification):

This keeps the business namespace in one consistent form across filesystem, ZFS, NFS, and S3 usage. It avoids creating
too many buckets for country or organization splits and makes tooling simpler because key prefixes can be derived
directly from the existing gintra path model.

## 3. Consequences, Impacts & Follow-up Actions

Tooling should map gintra-managed S3 content by preserving the typed subtree and identity parts in the key prefix. New
gintra domains added by later ADRs should follow the same S3 key rule. Split data into separate buckets only when there
is an explicit operational reason such as account boundary, region boundary, lifecycle policy, or security isolation.
Environment separation may use coarse bucket names such as `setmy-info-gintra-dev`, `setmy-info-gintra-test`,
`setmy-info-gintra-ci`, and `setmy-info-gintra-live`, while keeping country and organization identity only in the key
prefix.

---

https://adr.github.io/
