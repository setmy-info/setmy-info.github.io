# Architecture Decision Record (ADR)

ADR-0033: Gintra as group intranet directory structure under setmy.info Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

The setmy.info internal directory structure needs a named standard for group intranet data. `gintra` means group
intranet: a file structure and data layout for a multi-tenant system organized by country code and organization short
name under the setmy.info FHS root. The source design also distinguishes the stable logical gintra path used by
software from the active physical storage mount used by infrastructure.

## 3. Decision

Use `gintra` as the standard directory name for the setmy.info group intranet file structure under
`/var/opt/setmy.info`. Use `/var/opt/setmy.info/gintra` as the logical root for gintra-managed data such as
`organizations/` and `persons/`, and map it to the active physical storage mount, currently `/mnt/gintra`, during
system setup.

## 4. Rationale (Justification):

This keeps the FHS top-level decision separate from the group intranet structure decision. It also gives `gintra` a
clear meaning as a named internal standard for grouped tenant and organization data, while allowing the physical
implementation to stay independent. Scripts and applications can keep using one stable logical path even if storage
administrators change the physical backend mount.

## 3. Consequences, Impacts & Follow-up Actions

Documentation and tooling may refer to `gintra` specifically when they mean the group intranet file structure and data
area, not the generic FHS top-level root. System setup may continue to map `/var/opt/setmy.info/gintra` to the active
physical mount, currently `/mnt/gintra`, for example by symlink. Scripts should use the logical gintra path instead of
hardcoding the physical mount path.

---

https://adr.github.io/
