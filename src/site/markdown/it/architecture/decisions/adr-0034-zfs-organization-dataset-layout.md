# Architecture Decision Record (ADR)

ADR-0034: ZFS organization dataset layout for gintra Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

setmy.info needs a consistent physical storage model for organization data on the current Linux host. The source design
defines a ZFS-backed gintra tree that must encode country and organization identity while keeping structural levels
separate from actual data-holding datasets. The layout also needs a clear default rule for when data stays in normal
directories and when an extra ZFS sub-dataset is justified.

## 3. Decision

Use ZFS pool `gintra` mounted at `/var/opt/setmy.info/gintra` with the dataset hierarchy `gintra/organizations/<cc>/<org>` as the standard
physical namespace for organization data. Treat `gintra`, `gintra/organizations`, and `gintra/organizations/<cc>` as
structural containers, and store actual organization data in the leaf dataset `gintra/organizations/<cc>/<org>`, where
`<cc>` is the ISO 3166-1 alpha-2 country code and `<org>` is the organization short name.

## 4. Rationale (Justification):

This creates a clear, scalable namespace based on ISO country code and organization short name, while keeping
per-organization data isolated at dataset level. It aligns the physical layout with the path convention used by the
`smi-*` scripts. It also keeps the normal case simple: `development/` and `operations/` stay plain directories inside
one organization dataset unless there is a specific operational reason to split part of the tree into an extra
sub-dataset.

## 3. Consequences, Impacts & Follow-up Actions

Within each organization dataset, use `development/` for long-lived configuration and `operations/` for runtime
workloads such as `ai/`, `packages/`, and `workflows/`. New organizations should be provisioned as new leaf datasets
under `gintra/organizations/<cc>/<org>`, where `<cc>` is the country code and `<org>` is the organization short name,
and documentation/scripts should continue to assume `/var/opt/setmy.info/gintra/organizations/<cc>/<org>` as the physical path.
Optional child datasets may be created only for explicit needs such as separate quotas or snapshot policies.

---

https://adr.github.io/
