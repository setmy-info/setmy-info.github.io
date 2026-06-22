# firewalld

## Information

`firewalld` is a dynamic firewall management service for Linux systems. It provides a higher-level way to manage
packet filtering rules without editing raw `iptables`, `nftables`, or legacy firewall command sets directly.

In practical infrastructure and platform work, `firewalld` is often used when you want to:

* manage host-level network access in a structured way,
* separate trust levels with zones,
* open only selected services or ports,
* apply runtime changes without rebuilding the whole ruleset manually,
* standardize server firewall operations across environments.

For `SMI`-style operational usage, `firewalld` is useful because it gives operators a consistent interface for
common firewall work while still allowing more advanced policy design when needed.

### Main functionalities and features

* **Zones**: group network interfaces or traffic sources by trust level,
* **Services**: open predefined collections of ports and protocols such as `ssh` or `http`,
* **Port rules**: allow explicit ports and protocols when no service definition fits,
* **Runtime vs permanent configuration**: test changes live and then persist them,
* **Rich rules**: express more specific allow, deny, source-based, logging, and forwarding rules,
* **Masquerading and forwarding**: support simple `NAT`, gateway, and routing scenarios,
* **Direct integration with backend firewall engines**: commonly `nftables` on modern systems.

### Typical use cases

* allow `SSH` from a management subnet only,
* open `HTTP` and `HTTPS` for a reverse proxy or web server,
* restrict database access to one application subnet,
* expose one service temporarily during testing and remove it later,
* configure a server as a simple router or `NAT` gateway,
* create layered egress and ingress controls together with proxies such as `Squid`.

## Core concepts

### Zones

Zones are one of the most important ideas in `firewalld`.

A zone represents a trust level for traffic coming from:

* a network interface,
* a source subnet,
* or another traffic origin.

Common built-in zones include:

* `public`: default for untrusted or partially trusted networks,
* `internal`: more trusted internal networks,
* `home`: home or small office environment,
* `work`: office-like trusted environment,
* `dmz`: public-facing systems separated from internal networks,
* `trusted`: traffic is broadly allowed,
* `drop`: packets are silently dropped,
* `block`: packets are rejected.

In practice, many teams use only a few zones, but understanding the model is important before opening ports broadly.

### Services versus ports

`firewalld` can open network access by:

* **service**, for example `ssh`, `http`, `https`,
* **port**, for example `8080/tcp`,
* **rich rule**, when more control is needed.

Prefer services when they match the real application because they are clearer and easier to review later.

### Runtime and permanent configuration

This is operationally critical.

`firewalld` keeps:

* a **runtime** configuration currently active in memory,
* a **permanent** configuration stored on disk.

Typical workflow:

1. add a runtime rule,
2. verify connectivity,
3. repeat the same change with `--permanent`,
4. reload when needed.

If you forget the permanent step, the rule can disappear after a reload or reboot.

### Rich rules

Rich rules are useful when simple service or port openings are too broad.

They allow patterns such as:

* allow a port only from one subnet,
* reject one source and allow another,
* log matches before dropping,
* forward traffic to another port or host.

### Backend note

Modern Linux distributions often use `nftables` as the backend while keeping `firewalld` as the management layer.

From an operator point of view, the important thing is usually not the backend syntax but that you should avoid mixing
too many management methods on the same host unless you understand the interaction very well.

## Installation

### Rocky Linux / AlmaLinux / CentOS / Fedora

`firewalld` is often installed by default, but if not:

```bash
sudo dnf install -y firewalld
```

Start and enable it:

```bash
sudo systemctl enable --now firewalld
sudo systemctl status firewalld
```

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install -y firewalld
```

Then enable it:

```bash
sudo systemctl enable --now firewalld
sudo systemctl status firewalld
```

### openSUSE

```bash
sudo zypper install -y firewalld
```

### Main commands to know first

```bash
sudo firewall-cmd --state
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --list-all
```

These commands help you inspect the current state before making changes.

## Basic setup

### Check whether `firewalld` is running

```bash
sudo firewall-cmd --state
```

Expected output is typically:

```text
running
```

### See active zones and assigned interfaces

```bash
sudo firewall-cmd --get-active-zones
```

Example output:

```text
public
  interfaces: eth0
```

This is important because opening a port in the wrong zone is a common mistake.

### List the current rules of one zone

```bash
sudo firewall-cmd --zone=public --list-all
```

### Open `SSH`, `HTTP`, and `HTTPS`

Runtime only:

```bash
sudo firewall-cmd --zone=public --add-service=ssh
sudo firewall-cmd --zone=public --add-service=http
sudo firewall-cmd --zone=public --add-service=https
```

Permanent:

```bash
sudo firewall-cmd --zone=public --add-service=ssh --permanent
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --zone=public --add-service=https --permanent
sudo firewall-cmd --reload
```

### Open one custom application port

```bash
sudo firewall-cmd --zone=public --add-port=8080/tcp
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

### Remove a service or port

```bash
sudo firewall-cmd --zone=public --remove-service=http
sudo firewall-cmd --zone=public --remove-port=8080/tcp
```

Permanent removal:

```bash
sudo firewall-cmd --zone=public --remove-service=http --permanent
sudo firewall-cmd --zone=public --remove-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

## Practical examples

### Allow `SSH` only from a management subnet

This is a common hardening step.

```bash
sudo firewall-cmd --permanent --zone=public \
  --add-rich-rule='rule family="ipv4" source address="10.20.30.0/24" service name="ssh" accept'

sudo firewall-cmd --permanent --zone=public \
  --add-rich-rule='rule family="ipv4" service name="ssh" drop'

sudo firewall-cmd --reload
```

Operational note:

* test carefully through another session before locking down remote access,
* keep console access or an emergency path available,
* confirm that your real management subnet is correct.

### Allow application traffic only from one backend subnet

Example for `PostgreSQL` on port `5432`:

```bash
sudo firewall-cmd --permanent --zone=public \
  --add-rich-rule='rule family="ipv4" source address="10.50.0.0/24" port port="5432" protocol="tcp" accept'

sudo firewall-cmd --reload
```

This is safer than opening `5432/tcp` to every source.

### Publish a reverse proxy host

Typical minimal setup for a web entry point:

```bash
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
```

Often this server would expose only:

* `80/tcp` for redirect or plain `HTTP`,
* `443/tcp` for `HTTPS`,
* `22/tcp` only if remote administration is required.

### Temporary change for incident response or short testing

Sometimes you need to test access without committing to the permanent ruleset.

```bash
sudo firewall-cmd --zone=public --add-port=8443/tcp
sudo firewall-cmd --zone=public --list-ports
```

If the test is successful and the change should stay:

```bash
sudo firewall-cmd --zone=public --add-port=8443/tcp --permanent
sudo firewall-cmd --reload
```

If not, remove the runtime rule again.

### Forward one port to another local port

This can be useful when exposing one external port that should map to a local application listener.

```bash
sudo firewall-cmd --permanent --zone=public --add-forward-port=port=80:proto=tcp:toport=8080
sudo firewall-cmd --reload
```

### Enable masquerading for a simple gateway host

If a server acts as a router or outbound gateway:

```bash
sudo firewall-cmd --permanent --zone=public --add-masquerade
sudo firewall-cmd --reload
```

This is only one part of the setup. Routing, interface settings, and kernel forwarding also need to be correct.

## Zones in practice

### Assign an interface to a zone

```bash
sudo firewall-cmd --permanent --zone=public --add-interface=eth0
sudo firewall-cmd --reload
```

### Bind a source subnet to a zone

```bash
sudo firewall-cmd --permanent --zone=internal --add-source=10.10.0.0/16
sudo firewall-cmd --reload
```

This can be useful when different traffic origins should get different policy treatment.

### Create a more structured host policy

One practical pattern:

* `public` zone for the internet-facing interface,
* `internal` zone for trusted east-west traffic,
* only selected services exposed in `public`,
* broader administration or backend access in `internal`.

This keeps intent clearer than placing every rule in one default zone.

## Rich rules and logging

### Log before dropping traffic

If you need more visibility during troubleshooting:

```bash
sudo firewall-cmd --permanent --zone=public \
  --add-rich-rule='rule family="ipv4" port port="8080" protocol="tcp" log prefix="fw-deny-8080 " level="info" drop'

sudo firewall-cmd --reload
```

Be careful with high-volume logging because it can create noise or performance overhead.

### Reject versus drop

In many cases you must decide whether unwanted traffic should be:

* **dropped**: silently ignored,
* **rejected**: denied with an error response.

Operationally:

* `drop` is quieter and sometimes preferred for hostile traffic,
* `reject` can be easier for internal troubleshooting because the client fails faster and more clearly.

### List rich rules

```bash
sudo firewall-cmd --zone=public --list-rich-rules
```

## Runtime, permanent, reload, and panic mode

### Reload behavior matters

```bash
sudo firewall-cmd --reload
```

Reload applies permanent configuration into the active runtime state.

This means:

* unpersisted runtime-only changes may disappear,
* manual testing changes can be lost,
* you should know whether a rule was added runtime-only or permanently.

### Copy runtime configuration into permanent rules

If you intentionally built the runtime state and want to save it:

```bash
sudo firewall-cmd --runtime-to-permanent
```

Use this carefully. It can also persist temporary rules you forgot about.

### Panic mode

`firewalld` supports panic mode to block almost all traffic immediately.

Enable:

```bash
sudo firewall-cmd --panic-on
```

Disable:

```bash
sudo firewall-cmd --panic-off
```

This can be useful in emergencies, but use it carefully because it can also lock out legitimate administration.

## Operational tips and tricks

### Always inspect before changing

Do not blindly open ports. First check:

* active zones,
* default zone,
* current services,
* current ports,
* existing rich rules.

This avoids duplicating rules or editing the wrong zone.

### Prefer services where possible

`--add-service=https` is usually clearer than `--add-port=443/tcp`.

It is easier for later reviewers to understand the intent.

### Use source restrictions for sensitive services

Databases, administration endpoints, message brokers, and internal dashboards should rarely be opened to all sources.

Prefer patterns such as:

* source subnet + port,
* source subnet + service,
* dedicated internal zone.

### Be careful on remote systems

Before changing access on a remote server:

* keep the current session open,
* open a second test session if possible,
* confirm out-of-band access exists,
* apply restrictive `SSH` changes only after testing.

### Keep firewall policy documented

Document why a rule exists, not only what it does.

Examples:

* public reverse proxy ingress,
* monitoring subnet access,
* database traffic from application nodes only,
* temporary migration window.

This makes cleanup and audits much easier.

### Combine host firewall and upstream controls

`firewalld` should often be only one layer.

A stronger security design can also include:

* cloud security groups,
* upstream network firewalls,
* reverse proxies,
* service mesh or application-level authentication,
* egress proxies such as `Squid`.

### Know when not to use the host firewall as the only control

For large-scale multi-host policy, central network policy tooling may be more maintainable than managing very complex
host-local rules everywhere.

Still, host firewalls remain valuable as a last-mile protection layer.

## Common issues

### The port was opened but access still fails

Possible causes:

* the application is not listening on the expected address or port,
* the rule was added to the wrong zone,
* the interface is bound to a different zone,
* upstream cloud or network firewalls still block the traffic,
* the service listens only on `127.0.0.1`.

Check both firewall state and listening sockets.

### A rule worked, then disappeared after reboot

Most likely the change was added only to runtime configuration.

Fix:

* repeat the change with `--permanent`, or
* use `--runtime-to-permanent` intentionally,
* then reload and verify.

### Locked out after changing `SSH` rules

This is a classic operational risk.

Mitigation:

* test from another session before closing the current one,
* avoid broad deny rules until allow rules are verified,
* use console or recovery access when available.

### Mixing tools creates confusion

If you manage the same host with raw `iptables`, manual `nft` commands, cloud-init snippets, and `firewalld`
together, troubleshooting can become confusing quickly.

Prefer one primary management approach unless you have a clear reason and strong operational discipline.

### `NetworkManager`, containers, and virtualization add complexity

Hosts running container platforms, virtual bridges, or advanced routing can require additional planning.

Examples:

* container port publishing may insert separate rules,
* bridge interfaces may belong to different zones,
* forwarding and masquerade behavior may need explicit configuration.

Always verify on the actual host topology, not only from a simplified example.

## When developers and operators should know this

From a practical backend, infrastructure, and platform perspective:

* junior engineers should understand zones, services, and the difference between runtime and permanent rules,
* mid-level engineers should be able to open, restrict, inspect, and troubleshoot service exposure safely,
* senior engineers should understand layered network policy, segmentation, egress and ingress design, and operational
  risk.

## See also

* [HAProxy](haproxy.md)
* [Squid proxy](squid.md)
* [Togglz](togglz.md)
* [GitHub CI/CD Tips](ci-github.md)
* [firewalld official documentation](https://firewalld.org/)
* [Red Hat firewalld documentation](https://docs.redhat.com/)
