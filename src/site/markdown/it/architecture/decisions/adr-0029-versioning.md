# Architecture Decision Record (ADR)

ADR-0029: Versioning in semantic versioning Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

setmy.info components need one consistent software versioning format for builds, releases, and deployment artifacts.
Without one shared versioning rule, teams may publish incompatible version strings, mix different suffix styles, or use
alphabetic qualifiers that make automation, dependency handling, and release comparison harder.

## 3. Decision

Use Semantic Versioning 2.0.0 as the versioning scheme.

Development and testing versions must use the `-SNAPSHOT` suffix. Released versions must not use the `-SNAPSHOT`
suffix. Only numeric version parts are used. Alphabetic prefixes or suffixes are not used as version qualifiers.

Examples:

* At development time: `1.2.3-SNAPSHOT` and after release: `1.2.3`
* At development time, with build number: `1.2.3-54321-SNAPSHOT` and after release: `1.2.3`

## 4. Rationale (Justification):

Semantic Versioning 2.0.0 is a widely known and well-supported versioning model, so it is the safest common rule for
build tools, repositories, dependency resolution, and release communication. Restricting versions to numeric parts and
the `-SNAPSHOT` suffix keeps artifact naming predictable and easy to validate in automation.

## 3. Consequences, Impacts & Follow-up Actions

All new build, release, and artifact version strings in setmy.info should follow Semantic Versioning 2.0.0. Development
and test artifacts should use `-SNAPSHOT`, while released artifacts should use plain release numbers. Reviews of build
and release configuration should reject alphabetic qualifiers or other non-standard version suffixes unless a later ADR
explicitly changes this rule.

https://semver.org/

https://adr.github.io/

[Architecture](../index.md)
