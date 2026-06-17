# Architecture Decision Record (ADR)

ADR-0042: Runtime and build-time profile name conventions Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

`it/architecture/index.md` already states that Maven, Spring, Micronaut, and similar profiles should map one-to-one to
environment names, and `ADR-0041` defines the canonical environment names as `local`, `dev`, `ci`, `test`,
`prelive`, and `live`. In practice those profile names are used both at build time and at runtime. Without a dedicated
ADR covering both scopes, some teams could incorrectly assume that extra profile names such as `staging`, `prod`,
`docker`, `k8s`, `debug`, `customer-x`, or technology-specific aliases are acceptable. They are not allowed, because
they drift away from environment naming and make configuration, builds, deployment, and support harder.

## 3. Decision

Use the canonical environment names from `ADR-0041` as the only allowed build-time and runtime profile names:

* `local`
* `dev`
* `ci`
* `test`
* `prelive`
* `live`

Profile systems must stay one-to-one with environments at both build time and runtime. This applies to Maven profiles,
Spring profiles, Micronaut environments or profiles, and equivalent profile mechanisms in other frameworks and tools.

Other build-time or runtime profile names are not allowed in setmy.info application configuration. In particular, do
not introduce extra profiles for infrastructure style, deployment shape, feature state, customer identity, tenant,
developer initials, region, debugging, or technology choices. Those concerns must be handled with other mechanisms
such as normal configuration properties, feature switches, tenant configuration, or separate build or deployment
parameters.

Non-canonical names such as `stage`, `staging`, `pre-live`, `prod`, and `production` remain forbidden for build-time
and runtime profiles for the same reason they are forbidden as environment names in `ADR-0041`.

## 4. Rationale (Justification):

Keeping build-time and runtime profiles identical to environment names removes ambiguity across builds, startup,
operations, and documentation. One shared vocabulary makes it easier to understand which configuration is active,
compare deployments, review automation, and troubleshoot incidents. It also prevents profile sprawl where teams start
encoding unrelated concerns into profile names and end up with incompatible combinations that are difficult to test and
maintain.

## 3. Consequences, Impacts & Follow-up Actions

All new build-time and runtime profile definitions, startup commands, build commands, examples, and documentation must
use only `local`, `dev`, `ci`, `test`, `prelive`, and `live`. Existing profile names outside that list should be
renamed gradually to the canonical environment names unless they are describing an external product's own terminology.
Architecture and code reviews must reject new profiles that are not direct environment names. If there is a future
need for an additional profile name, it requires an explicit new ADR instead of an ad hoc exception.

https://adr.github.io/

[Environment name conventions](adr-0041-environment-name-conventions.md)