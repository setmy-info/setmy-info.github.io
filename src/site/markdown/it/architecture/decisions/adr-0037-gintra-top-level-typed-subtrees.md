# Architecture Decision Record (ADR)

ADR-0037: Gintra top-level typed subtrees Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

Gintra is broader than one organization tree. The internal namespace needs simple top-level categories so scripts,
documentation, and future ADRs can refer to stable data domains without implying that all gintra content is only about
organizations.

## 3. Decision

Use typed top-level subtrees under gintra, including `organizations/` and `persons/`, as the standard namespace model.
Organization-specific data continues under `organizations/<cc>/<org>`, and additional top-level domains may be added by
later ADRs when needed.

## 4. Rationale (Justification):

This keeps the gintra namespace simple, extensible, and easier to understand. It matches the existing `smi-*` path
concepts and prevents future confusion that gintra means only organization storage.

## 3. Consequences, Impacts & Follow-up Actions

Documentation and tooling should describe gintra as a typed namespace, not only as an organization tree. Future data
areas should be introduced as new top-level subtrees with explicit ADRs when they become standard.

---

https://adr.github.io/