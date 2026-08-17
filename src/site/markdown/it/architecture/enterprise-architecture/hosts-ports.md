# Hosts and ports

This page gives a simple naming and port planning convention so a developer can quickly check which host name and port
to use locally or in live, `dev`, and `test` environments.

## Host naming convention

Use the pattern `main-name.<SUFFIX>` where `<SUFFIX>` is the environment or DNS suffix, for example `corp.example`,
`lab.example`, or `local`.

### Core infrastructure host names

| Main name   | Example FQDN         | Service                                                                  |
|-------------|----------------------|--------------------------------------------------------------------------|
| `dns1`      | `dns1.<SUFFIX>`      | Primary `DNS` server                                                     |
| `dns2`      | `dns2.<SUFFIX>`      | Secondary `DNS` server                                                   |
| `dhcp1`     | `dhcp1.<SUFFIX>`     | Primary `DHCP` server                                                    |
| `dhcp2`     | `dhcp2.<SUFFIX>`     | Secondary `DHCP` server                                                  |
| `nfs`       | `nfs.<SUFFIX>`       | `NFS` file server                                                        |
| `samba`     | `samba.<SUFFIX>`     | `Samba` / `SMB` file sharing                                             |
| `mqtt`      | `mqtt.<SUFFIX>`      | `MQTT` broker                                                            |
| `mq`        | `mq.<SUFFIX>`        | Message queue broker                                                     |
| `wf`        | `wf.<SUFFIX>`        | Workflow orchestration service, for example `ArgoWF`, `Dagu`, or `Zeebe` |
| `ci`        | `ci.<SUFFIX>`        | Continuous integration server, for example `Jenkins`                     |
| `db1`       | `db1.<SUFFIX>`       | Primary `PostgreSQL` database server                                     |
| `graph`     | `graph.<SUFFIX>`     | Graph database server, for example `Neo4j`                               |
| `cache`     | `cache.<SUFFIX>`     | Distributed cache service, for example `Infinispan`                      |
| `iam`       | `iam.<SUFFIX>`       | Identity and access management, for example `Keycloak`                   |
| `pki`       | `pki.<SUFFIX>`       | Secrets, key management, and `PKI`, for example `OpenBao`                |
| `selenium`  | `selenium.<SUFFIX>`  | Browser automation and UI test service, for example `Selenium Grid`      |
| `elk`       | `elk.<SUFFIX>`       | Central log ingestion, search, and visualization with `ELK` stack        |
| `portainer` | `portainer.<SUFFIX>` | Container management UI, for example `Portainer`                         |
| `proxy`     | `proxy.<SUFFIX>`     | Reverse proxy / ingress                                                  |
| `vpn`       | `vpn.<SUFFIX>`       | General `VPN` gateway                                                    |
| `openvpn`   | `openvpn.<SUFFIX>`   | `OpenVPN` server                                                         |
| `wireguard` | `wireguard.<SUFFIX>` | `WireGuard` server                                                       |
| `mail`      | `mail.<SUFFIX>`      | Mail server / test mail server, for example `Postfix` or `GreenMail`     |
| `smtp`      | `smtp.<SUFFIX>`      | `SMTP` mail service                                                      |
| `imap`      | `imap.<SUFFIX>`      | `IMAP` mail service                                                      |
| `pop3`      | `pop3.<SUFFIX>`      | `POP3` mail service                                                      |
| `greenmail` | `greenmail.<SUFFIX>` | `GreenMail` test mail server and mock suite                              |
| `monitor`   | `monitor.<SUFFIX>`   | Monitoring and observability                                             |
| `backup`    | `backup.<SUFFIX>`    | Backup service                                                           |

## Service and port table

Prefer the same service ports on developer machines and in live environments whenever possible. This reduces
configuration drift, makes container setups easier to reuse, and avoids environment-specific surprises. The most common
exception is when a reverse proxy maps an internal application port such as `8080` to external `80` or `443`.

Reserve the `8080` to `8179` range for application or service backends. A practical convention is to reserve blocks of
10 ports per application so each service can scale from node `1` to node `10` without changing the base pattern.
Examples: app 1 uses `8080` to `8089`, app 2 uses `8090` to `8099`, app 3 uses `8100` to `8109`, and so on up to app 10
using `8170` to `8179`.

| Service                           | Common ports                                                                       | Notes                                                                                                                                                                       |
|-----------------------------------|------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `DNS`                             | `53/tcp`, `53/udp`                                                                 | Name resolution                                                                                                                                                             |
| `DHCP`                            | `67/udp`, `68/udp`                                                                 | Address assignment                                                                                                                                                          |
| `NFS`                             | `2049/tcp`, `2049/udp`                                                             | Main `NFS` traffic                                                                                                                                                          |
| `Samba` / `SMB`                   | `137/udp`, `138/udp`, `139/tcp`, `445/tcp`                                         | Windows and mixed-network file sharing                                                                                                                                      |
| `MQTT`                            | `1883/tcp`, `8883/tcp`                                                             | Plain and `TLS`                                                                                                                                                             |
| Message queue                     | `5672/tcp`, `5671/tcp`, `15672/tcp`                                                | Typical `RabbitMQ` AMQP, `TLS`, and management UI                                                                                                                           |
| Workflow orchestration            | `2746/tcp`, `9090/tcp`, `26500/tcp`, `26501/tcp`, `26502/tcp`, `9600/tcp`          | Plan `ArgoWF` server on `2746`, keep `Dagu` UI outside the `8080` to `8179` app range, and reserve `Zeebe` gateway, internal, and monitoring ports                          |
| `CI` / `Jenkins`                  | `7070/tcp`, `50000/tcp`                                                            | Usual in-house `Jenkins` web UI and agent port                                                                                                                              |
| Database `PostgreSQL`             | `5432/tcp`                                                                         | Common relational database port                                                                                                                                             |
| Graph database `Neo4j`            | `7474/tcp`, `7473/tcp`, `7687/tcp`                                                 | HTTP UI, HTTPS UI, and `Bolt` protocol                                                                                                                                      |
| Cache `Infinispan`                | `11222/tcp`, `7800/tcp`                                                            | Client access plus cluster transport                                                                                                                                        |
| `Selenium` / `Selenium Grid`      | `4444/tcp`, `4442/tcp`, `4443/tcp`, `7900/tcp`                                     | Router / hub, event bus publish and subscribe, optional noVNC                                                                                                               |
| `ELK` stack                       | `5044/tcp`, `5601/tcp`, `9200/tcp`, `9300/tcp`                                     | Typical `Logstash` beats input, `Kibana`, and `Elasticsearch` HTTP and transport                                                                                            |
| `Portainer`                       | `9443/tcp`, `9000/tcp`, `8000/tcp`                                                 | Prefer `9443` for current deployments; `9000` is legacy UI and collides with `Keycloak`, `8000` is for edge agent tunnel use                                                |
| HTTP                              | `80/tcp`                                                                           | Plain web traffic                                                                                                                                                           |
| HTTPS                             | `443/tcp`                                                                          | Encrypted web traffic                                                                                                                                                       |
| `IAM` / `Keycloak`                | `8180/tcp`, `8543/tcp`, `9000/tcp`                                                 | Avoids collision with reserved backend range; app and admin                                                                                                                 |
| `PKI` / `OpenBao`                 | `8200/tcp`, `8201/tcp`                                                             | API / UI and cluster or internal communication                                                                                                                              |
| `OpenVPN`                         | `1194/udp`, `1194/tcp`, `943/tcp`                                                  | Standard OpenVPN tunnel traffic (UDP preferred, TCP fallback) and Access Server admin UI                                                                                    |
| `WireGuard`                       | `51820/udp`                                                                        | Default WireGuard VPN tunnel traffic                                                                                                                                        |
| `Mail` (`SMTP` / `IMAP` / `POP3`) | `25/tcp`, `465/tcp`, `587/tcp`, `143/tcp`, `993/tcp`, `110/tcp`, `995/tcp`         | Standard mail delivery and retrieval (`SMTP`, `SMTPS`, submission, `IMAP`, `IMAPS`, `POP3`, `POP3S`)                                                                        |
| `GreenMail` / Mail mock           | `3025/tcp`, `3465/tcp`, `3143/tcp`, `3993/tcp`, `3110/tcp`, `3995/tcp`, `8025/tcp` | Test mail server: `SMTP` (3025), `SMTPS` (3465), `IMAP` (3143), `IMAPS` (3993), `POP3` (3110), `POP3S` (3995), and Web GUI / API (`8025/tcp` to avoid `8080` backend range) |
| Reverse proxy admin               | `18081/tcp` or custom                                                              | Optional internal management; keep outside app ranges                                                                                                                       |
| Application backend app 1 nodes   | `8080/tcp` to `8089/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |
| Application backend app 2 nodes   | `8090/tcp` to `8099/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |
| Application backend app 3 nodes   | `8100/tcp` to `8109/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |
| Application backend app 4 nodes   | `8110/tcp` to `8119/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |
| Application backend app 5 nodes   | `8120/tcp` to `8129/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |
| Application backend app 6 nodes   | `8130/tcp` to `8139/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |
| Application backend app 7 nodes   | `8140/tcp` to `8149/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |
| Application backend app 8 nodes   | `8150/tcp` to `8159/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |
| Application backend app 9 nodes   | `8160/tcp` to `8169/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |
| Application backend app 10 nodes  | `8170/tcp` to `8179/tcp`                                                           | Reserve 10 ports for one service across up to 10 nodes                                                                                                                      |

## Notes

* Keep host main names stable across environments.
* Change only the suffix when moving between environments.
* Prefer the same ports in local development and live environments when possible.
* If ports differ, keep the difference at the proxy or ingress layer rather than inside the application.
* Keep infrastructure and admin ports outside the reserved application backend ranges to avoid accidental collisions.
* A common pattern is to run an application on `8080` or `8443` internally and expose it through a reverse proxy on `80`
  or `443`.
* Use a reverse proxy when several services need a consistent external entry point.
