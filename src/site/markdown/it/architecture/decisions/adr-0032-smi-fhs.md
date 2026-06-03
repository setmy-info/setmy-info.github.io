# Architecture Decision Record (ADR)

ADR-0032: SMI FHS Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

setmy.info needs one simple Linux filesystem standard based on FHS. The standard must clearly say where program files
go, where changing data goes, and where host-specific configuration goes. It should also say in simple words how the
main software tree under `/opt/setmy.info` relates to `/var/opt/setmy.info`, `/etc/opt/setmy.info`, and native OS
integration files in `/etc`.

## 3. Decision

Use `/opt/setmy.info` for the software tree, `/var/opt/setmy.info` for variable data, and `/etc/opt/setmy.info` for
host-specific configuration of the `/opt/setmy.info` software tree. Put executable scripts and programs in
`/opt/setmy.info/bin`, libraries in `/opt/setmy.info/lib`, and manual pages in `/opt/setmy.info/man`. Keep native OS
integration files in their standard `/etc` locations, for example `/etc/exports`.

## 4. Rationale (Justification):

This follows the FHS layout in simple and consistent form. It gives one standard place for installed software, one
standard place for mutable data, and one standard place for machine-local configuration. It also says in simple words
where common software parts such as binaries, libraries, and manual pages belong inside the software tree. It keeps
configuration for `/opt/setmy.info` in the FHS-defined `/etc/opt/setmy.info` area while still leaving system-wide OS
files in normal `/etc` paths.

## 3. Consequences, Impacts & Follow-up Actions

Documentation and tooling should use `ADR-0032` as the canonical Linux FHS decision for setmy.info. Put software under
`/opt/setmy.info`, with scripts and programs in `/opt/setmy.info/bin`, libraries in `/opt/setmy.info/lib`, and manual
pages in `/opt/setmy.info/man`; put changing data under `/var/opt/setmy.info`, configuration under
`/etc/opt/setmy.info/localhost/...`, and OS integration files in native `/etc` locations. `smi-*` tooling should
resolve locations from this FHS structure.

https://adr.github.io/
