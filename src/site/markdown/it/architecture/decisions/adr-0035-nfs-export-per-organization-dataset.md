# Architecture Decision Record (ADR)

ADR-0035: NFS export per organization dataset path Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

Some workloads need shared access to organization data over the network, including multi-node scenarios. The export
model must be compatible with the ZFS-backed gintra layout and with NFS requirements that operate on real filesystem
paths rather than dataset identifiers.

## 3. Decision

Export each organization using its real filesystem path `/mnt/gintra/organizations/<cc>/<org>` in `/etc/exports`. Do not
export ZFS dataset names such as `tank/organizations/<cc>/<org>`, and do not create a separate NFS export for
`operations/packages` because it is covered by the organization export.

## 4. Rationale (Justification):

This keeps the NFS boundary aligned with the per-organization data unit and matches how clients mount shared storage. It
also avoids invalid export definitions based on ZFS dataset names and keeps package-cache access inside the same
exported organization root. It also matches the operational rule that package consumers may use read-only client mounts
even when the server export stays writable for controlled download steps.

## 3. Consequences, Impacts & Follow-up Actions

NFS configuration and validation must use the real mount path under `/mnt/gintra`. Changes to `/etc/exports` must be
reloaded and verified, and client integrations should mount the organization export while using read-only mounts where
workloads only consume cached content. `operations/packages` stays inside the same exported organization path, so no
second export should be added for it.

---

https://adr.github.io/
