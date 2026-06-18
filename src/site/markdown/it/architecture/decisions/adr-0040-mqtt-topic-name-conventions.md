# Architecture Decision Record (ADR)

ADR-0040: MQTT topic name conventions Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

setmy.info already has MQTT transport requirements in `adr-0028-mqtt-requirements.md`, but there is no explicit architecture decision that
defines how MQTT topic names themselves must be structured. Without one naming convention, producers, consumers,
authorization rules, and monitoring become inconsistent across teams and tenants.

## 3. Decision

Use one canonical MQTT topic structure for application traffic:

`<env>/<cc>/<org>/<domain>/<entity>/<event>/<version>`

Topic segments must be lowercase ASCII and use kebab-case when a segment contains multiple words. Topic names must not
encode secrets, personal data, timestamps, random identifiers, or business payload values. Wildcards (`+`, `#`) are
allowed only in subscriptions, ACL patterns, and monitoring rules, never in published topic names.

Required segment meanings:

* `env` - deployment environment, for example `local`, `dev`, `test`, `prelive`, `live`
* `cc` - ISO-like lowercase country code segment of the organization identity, for example `ee`, `lv`
* `org` - lowercase organization identifier inside the country scope, for example `acme`, `setmy-info`
* `domain` - bounded context or top-level capability, for example `billing`, `iot`, `identity`
* `entity` - aggregate, device class, or resource type, for example `invoice`, `sensor`, `user`
* `event` - business or technical event name in past-tense or imperative style, for example `created`, `updated`,
  `command`
* `version` - topic contract version, for example `v1`, `v2`

The organization identity always occupies the two topic segments immediately after `env`, for example
`live/ee/acme/...`. Do not include extra container prefixes such as `organizations` in MQTT application topics unless a
later ADR defines them as part of the MQTT taxonomy.

Examples:

* `local/ee/acme/iot/sensor/reading/v1`
* `live/ee/acme/iot/sensor/reading/v1`
* `live/ee/acme/billing/invoice/created/v1`
* `test/ee/setmy-info/identity/user/updated/v1`
* `prelive/lv/demo/iot/device/command/v1`

Reserved prefixes:

* `_sys/...` for broker or platform internal topics
* `_ops/...` for operations, monitoring, or administrative topics

Application topics must not use the `_sys` or `_ops` prefixes.

## 4. Rationale (Justification):

The chosen structure keeps routing dimensions stable and predictable: environment first, then tenant identity, then
business classification, then event contract version. Using `&lt;cc&gt;/&lt;org&gt;` directly as explicit topic segments
keeps tenant
routing explicit and avoids ambiguous one-segment aliases that hide country and organization scope. This makes ACL
definitions, subscriber filtering, observability, and cross-team integration simpler. A fixed version segment allows
topic-level contract evolution without overloading one topic with incompatible payload meanings.

## 5. Consequences, Impacts & Follow-up Actions

All new MQTT producers, consumers, ACL definitions, dashboards, and documentation must use `ADR-0040` as the canonical
topic naming convention. Existing topic names that do not follow this structure should be migrated gradually or mapped
through compatibility subscriptions and bridges. `adr-0028-mqtt-requirements.md` should continue to define transport-level MQTT requirements,
while this ADR defines naming only. Future topic reviews must check segment meaning, casing, tenant placement, and
version suffix consistency. Reviews must also verify that MQTT application topics use the exact segment order
`<env>/<cc>/<org>/<domain>/<entity>/<event>/<version>`.

https://adr.github.io/

[MQTT requirements](adr-0028-mqtt-requirements.md)
