# Architecture Decision Record (ADR)

ADR-0036: Logical gintra path mapped to physical storage mount Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

The gintra design uses one stable path for software and another path for the real storage mount. Scripts and
applications need a stable location that follows FHS, while infrastructure must stay free to mount storage on the most
practical backend path.

## 3. Decision

Use `/var/opt/setmy.info/gintra` as the canonical logical gintra path for applications and `smi-*` scripts. Mount the
real storage at a physical path such as `/mnt/gintra` and bridge the two paths during system setup, for example by
symlink.

## 4. Rationale (Justification):

This keeps application-facing paths stable and FHS-aligned while allowing storage implementation details to change
without changing scripts. It separates software contracts from infrastructure mounting details.

## 3. Consequences, Impacts & Follow-up Actions

Tooling and documentation should treat `/var/opt/setmy.info/gintra` as the canonical path and should not hardcode the
physical mount path. Infrastructure setup must create and maintain the mapping to the active physical storage mount.

---

https://adr.github.io/
