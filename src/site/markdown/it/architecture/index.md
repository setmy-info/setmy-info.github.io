# Architecture

Why predefined architecture?

1. Most of the important is that decisions are made (you like it or not) that means some kind of plan are made.

2. More time - no need to spend time to argue, where opposite sides should prove something, prepare for proving,
   search information for proving, reading and listening to each-other, misunderstanding, etc etc

3. Bad plan is a better than no plan.

## Principles

1. *Same version*. All components should have a same version, simple to remember and add as dependency.

2. *POM similarity*. java-model, java-service and springboot-start-project are made as base and other should follow
   these structures 1:1 as much as possible.

3. *Standardizing and stability as mush as possible*. So third partys (private companies etc) should have possibility to
   make tool top on all project
   possibilities - component locations in folder structure, module/component folder structure, libraries and modules,
   tools, frameworks used.

## Environments

* **local** - developer local machine
* **dev** - developers and teams playground
* **ci** (also atest) - Automatic tests playground
* **test** - user and acceptance test playground with fake data. Keyword 'test' is Spring Boot test profile. Not to mix
  with them.
* **prelive** - user and acceptance test playground with real data
* **live** - endusers playground and production

## Standard profiles

Profiles for Maven, Spring, Micronaut etc profiles are per environment one to one. Name it as mentioned in environments
list.

## Hybrid architecture (cloud + )

## Architecture levels 1-5

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
| K8S ready                                                   | Yes, Minikube                    |                      | ...     |                      | Yes                    |
| Service communication over TLS                              | No                               |                      | ...     |                      | Yes                    |
| PKI, Key management                                         | Minimal, for public web          |                      | ...     |                      | Yes                    |
| Monitoring                                                  | No (Manual)                      |                      | ...     |                      | Yes                    |
| SSH File server                                             | Yes, Single, In-house, in CI     |                      | ...     |                      | Yes                    |
| SMTP server per environment                                 | Yes                              |                      | ...     |                      | Yes                    |
| IM (Keycloak)                                               | No                               |                      | ...     |                      | Yes                    |
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

## Feature switches levels

Complexity grows with level.

1. Compiled into code, changed in some classes as boolean (only) values and compiled again.
2. Configuration compiled into final package (like Java jar), but overloaded by external configuration (file) with
   boolean values only.
3. Like previous, but also DB holds boolean values. Overload order: db is overwritten by config all that overwritten by
   command line. DB is replacing fancy switches UI.
4. External library used, not anymore boolean values, string values, more control elements/functions.
5. Like previous, but with UI.
