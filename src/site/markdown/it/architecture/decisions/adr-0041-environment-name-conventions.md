# Architecture Decision Record (ADR)

ADR-0041: Environment name conventions Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

setmy.info documentation already defines an environment list in `it/architecture/index.md`, but not all documents use
the same names. Current Markdown uses a mix of `local`, `prelive`, `pre-live`, `stage`, `live`, `prod`,
`production`, `ci`, and `atest`, and some places omit `local` even though developers also use it for local services
such as MQTT. Without one canonical naming decision, topic names, configuration keys, branch-to-environment mappings,
deployment pipelines, and documentation drift apart.

## 3. Decision

Use the following canonical environment names for setmy.info environments:

* `local` - developer local machine
* `dev` - developer and team playground
* `ci` - automatic test environment
* `test` - user and acceptance test environment with fake data
* `prelive` - user and acceptance test environment with real data
* `live` - end-user and production environment

The names `stage`, `staging`, `pre-live`, `prod`, and `production` are not canonical environment identifiers in
setmy.info documents, topics, profiles, configuration names, or automation naming. `atest` may be kept only as a
legacy explanatory alias for `ci` in old text, but new material must use `ci`. The `local` environment is part of the
canonical list and may be used in local-only MQTT topics, local profiles, and local developer automation.

## 4. Rationale (Justification):

The canonical list already exists in `it/architecture/index.md`, so the safest decision is to align other documents to
that established vocabulary instead of introducing more synonyms. Using one spelling per environment simplifies branch
mapping, naming conventions, profiles, topic structures, access rules, deployment automation, and documentation review.
It also resolves the concrete inconsistency where one ADR used `stage` and `prod` while the rest of the architecture
documents used `prelive` and `live`, and it makes explicit that `local` is also a first-class environment for
developer-hosted services.

## 3. Consequences, Impacts & Follow-up Actions

All new architecture, process, deployment, infrastructure, topic, and configuration documentation must use `local`,
`dev`, `ci`, `test`, `prelive`, and `live` as the canonical environment list. Existing Markdown that uses `stage`,
`staging`, `pre-live`, `prod`, or `production` as environment identifiers should be updated gradually to the canonical
names unless it is explicitly describing an external product's own terminology. Reviews of new naming conventions must
check environment terms for compliance with `ADR-0041`.

https://adr.github.io/

[Architecture](../index.md)
