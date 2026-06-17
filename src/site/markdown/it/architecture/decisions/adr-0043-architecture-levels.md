# Architecture Decision Record (ADR)

ADR-0043: Architecture levels 1-5 Ultra-light Architecture Decision Record (ADR)

## 1. Status:

**Accepted**

## 2. Context

`it/architecture/index.md` contained a large `Architecture levels 1-5` table directly in the overview page. The table
is a concrete architecture decision and reference model, not just introductory index text. Keeping it only in the index
page makes the decision harder to reference, review, and evolve in the same way as other accepted architecture rules.

## 3. Decision

Keep the architecture capability matrix as a dedicated ADR and use the following `Architecture levels 1-5` table as
the current reference:

| Tool                                                        | Level 1                          | Level 2<br/>Reserved | Level 3 | Level 4<br/>Reserved | Level 5                |
|-------------------------------------------------------------|----------------------------------|----------------------|---------|----------------------|------------------------|
| Standard prog. language set                                 | All                              |                      | ...     |                      | All+                   |
| Jenkins CI                                                  | Yes, Single, In-house            |                      | ...     |                      | Yes, Multi, ?          |
| Docker Registry/Harbor                                      | No (?), in CI                    |                      | ...     |                      | Yes                    |
| SeleniumHQ cluster (Hub, Nodes)                             | Yes, Single                      |                      | ...     |                      | Yes. Multi             |
| Multi/Single API/ APPs                                      | Single                           |                      | ...     |                      | Multi, HA              |
| Multi/Single DBs                                            | Single                           |                      | ...     |                      | Multi, HA              |
| Multi/Single Queues (RabbitMQ, Mosquitto)                   | Single                           |                      | ...     |                      | Multi, HA              |
| Multi/Single process engine (Zeebe, Camunda)                | Single                           |                      | ...     |                      | Multi, HA              |
| Profiles                                                    | All                              |                      | ...     |                      | All                    |
| Poor man's Wiki (mvn site, .md)                             | Yes                              |                      | ...     |                      | No                     |
| Poor man's Issue Management (Wiki)                          | Yes                              |                      | ...     |                      | No                     |
| Poor man's SonarQube (or similar) - wiki, mvn site          | Yes                              |                      | ...     |                      | No                     |
| Poor man's Log systems                                      | Yes                              |                      | ...     |                      | No                     |
| Poor man's DB (H2/Derby file)                               | Yes                              |                      | ...     |                      | No, Multi, HA          |
| Poor man's Intra server (Nginx)                             | Yes                              |                      | ...     |                      | No, Multi, HA          |
| Poor man's CDN (http(s) File server, Nginx)                 | Yes                              |                      | ...     |                      | No, Multi, HA          |
| Poor man's AI training process loop                         | Yes (existing Jenkins Ci, Zeebe) |                      | ...     |                      | No                     |
| Poor man's manual test management (Wiki)                    | Yes                              |                      | ...     |                      | No                     |
| K8S ready                                                   | Yes, K3S                         |                      | ...     |                      | Yes                    |
| Service communication over TLS                              | No                               |                      | ...     |                      | Yes                    |
| PKI, Key management                                         | Minimal, for public web          |                      | ...     |                      | Yes                    |
| Monitoring                                                  | No (Manual)                      |                      | ...     |                      | Yes                    |
| SSH File server                                             | Yes, Single, In-house, in CI     |                      | ...     |                      | Yes                    |
| SMTP server per environment                                 | Yes                              |                      | ...     |                      | Yes                    |
| IAM (Keycloak)                                              | No                               |                      | ...     |                      | Yes                    |
| Cloud, Cloud-Hybrid, Private comp. env.                     | Cloud-Hybrid                     |                      | ...     |                      | Self made Cloud-Hybrid |
| Feature switches  level                                     | 2                                |                      | 3       |                      | 5                      |
| Multi tenant                                                | Yes                              |                      | ...     |                      | Yes                    |
| Management tools (Ansible, ...)                             | No                               |                      | ...     |                      | Yes                    |
| In-house DNS                                                | Yes                              |                      | ...     |                      | Yes                    |
| In-house DHCP                                               | Yes                              |                      | ...     |                      | Yes                    |
| In-house LDAP (OpenLDAP)                                    | Yes                              |                      | ...     |                      | Yes                    |
| In-house SMTP (Sendmail, Postfix, ...)                      | Yes                              |                      | ...     |                      | ...                    |
| Admin tools (b/w simple html, static, SPA, in existing APP) | Yes                              |                      | ...     |                      | No (Full featured?)    |
| Monolith (backend reuse, ...)                               | Yes                              |                      | ...     |                      | No (μS)                |
| ...                                                         | ...                              |                      | ...     |                      | ...                    |
| ...                                                         | ...                              |                      | ...     |                      | ...                    |
| ...                                                         | ...                              |                      | ...     |                      | ...                    |
| ...                                                         | ...                              |                      | ...     |                      | ...                    |

## 4. Rationale (Justification):

Placing the level matrix into its own ADR makes it an explicit architecture baseline instead of a hidden subsection in
an overview page. That improves reuse in later ADRs, lets reviews cite one stable decision, and keeps the architecture
index shorter and more focused on navigation.

## 3. Consequences, Impacts & Follow-up Actions

Future updates to architecture maturity levels should modify this ADR instead of reintroducing the table into
`it/architecture/index.md`. The architecture index may link to this ADR, but the normative content for levels 1-5 now
lives here.

https://adr.github.io/

[Architecture](../index.md)
