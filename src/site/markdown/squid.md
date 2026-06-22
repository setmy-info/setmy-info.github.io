# Squid proxy

## Information

`Squid` is a widely used open-source caching and forwarding proxy server. In practical infrastructure work it is often
used as a controlled outbound proxy for servers, build agents, developer workstations, or restricted environments where
direct internet access should be blocked or limited.

For `SMI`-style operational usage, `Squid` is especially useful when you want to:

* centralize outbound access rules,
* allow only approved external services,
* log and review proxy traffic,
* force `CLI` tools and applications through one audited egress point,
* reduce uncontrolled direct internet connectivity from internal systems.

### Main Functionalities and Features

* **Forward proxying**: route outbound `HTTP` and `HTTPS` traffic through one central proxy,
* **Access control lists (`ACL`)**: allow or deny traffic by source, destination, domain, port, time, and other rules,
* **`CONNECT` support for `HTTPS`**: tunnel `TLS` traffic to approved external endpoints,
* **Caching**: optionally cache some content to reduce bandwidth and repeated downloads,
* **Logging**: keep request-level logs for troubleshooting and operational review,
* **Authentication support**: require users or systems to authenticate before using the proxy,
* **Egress restriction**: block all outbound traffic except explicitly allowed destinations.

### Typical Use Cases

* restrict build servers so they can reach only package repositories and approved APIs,
* allow internal systems to use `OpenAI` or `Anthropic` APIs while blocking general web browsing,
* force `CLI` tools through a proxy for traceability,
* create a simple corporate outbound internet policy,
* reduce accidental data exfiltration paths from controlled environments.

## Installation

### Rocky Linux / CentOS / Fedora

```bash
sudo dnf install -y squid
```

Typical service commands:

```bash
sudo systemctl enable --now squid
sudo systemctl status squid
```

Main configuration file is commonly:

```text
/etc/squid/squid.conf
```

### Debian / Ubuntu

```bash
sudo apt update
sudo apt install -y squid
```

### macOS

`Squid` is less common on `macOS`, but for local experiments you can use `Homebrew`:

```bash
brew install squid
```

### Docker for developer testing

For local experiments or reproducible demos, a container is often the simplest approach.

```yaml
version: '3.8'
services:
    squid:
        image: ubuntu/squid:5.2-22.04_beta
        container_name: squid-dev
        ports:
            - "3128:3128"
        volumes:
            - ./squid.conf:/etc/squid/squid.conf:ro
```

Start it with:

```bash
docker-compose up -d
```

## Core concepts

### What `Squid` does in outbound control

In a restricted environment, applications do not connect directly to external services. Instead, they send requests to
the proxy. The proxy decides whether the request is allowed and, if allowed, opens the external connection on behalf of
the client.

This means the real policy is implemented in one place rather than repeated in many applications.

### Main configuration areas

In practice, the most important parts of `squid.conf` are:

* `http_port` for the listening proxy port,
* `acl` declarations for matching clients, destinations, ports, and domains,
* `http_access` rules for allow/deny logic,
* optional logging and authentication configuration,
* optional cache settings.

### Rule order matters

`Squid` processes access rules in order.

This is operationally important:

* put specific allow rules before broad deny rules,
* keep the configuration readable,
* finish with an explicit deny when building a strict allowlist policy.

## Basic setup

### Minimal local proxy configuration

This small example enables a proxy on port `3128` for a trusted local network.

```conf
http_port 3128

acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl localhost src 127.0.0.1/32 ::1

acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 443
acl CONNECT method CONNECT

http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports

http_access allow localhost
http_access allow localnet
http_access deny all
```

This is not yet a strict external allowlist. It only shows the basic structure.

### Validate configuration before restart

Always validate before a restart or reload:

```bash
sudo squid -k parse
```

Then reload or restart:

```bash
sudo systemctl reload squid
sudo systemctl restart squid
```

## Restrict all external access except selected providers

This is the practical scenario requested most often: block arbitrary internet access, but allow only approved services
such as `Anthropic` and `OpenAI`.

### Important practical note about `HTTPS`

For normal forward-proxy use without `SSL` interception, `Squid` sees the target host used in the `CONNECT` request,
but not the encrypted path such as `/v1/messages` or `/v1/chat/completions`.

So in practice you usually allow by destination host or domain, not by specific `HTTPS` URL path.

### Strict allowlist example for selected AI providers

```conf
http_port 3128

acl localhost src 127.0.0.1/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16

acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 443
acl CONNECT method CONNECT

# Approved external destinations
acl allowed_ai dstdomain .openai.com .api.openai.com .anthropic.com .api.anthropic.com

# Optional package or OS repositories if your machines need them
# acl allowed_updates dstdomain .docker.com .docker.io .github.com .githubusercontent.com

http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports

# Only trusted internal clients may use the proxy
http_access allow localhost
http_access allow localnet allowed_ai

# Example if you also want selected update sources
# http_access allow localnet allowed_updates

# Block everything else
http_access deny all
```

This configuration means:

* internal clients may use the proxy,
* only approved destination domains are reachable,
* all other external traffic is denied.

### More defensive version with separate client ACL

If only a small subnet or one build server should reach these APIs, narrow the client source too:

```conf
http_port 3128

acl ai_clients src 10.20.30.0/24
acl SSL_ports port 443
acl Safe_ports port 443
acl CONNECT method CONNECT
acl allowed_ai dstdomain .openai.com .api.openai.com .anthropic.com .api.anthropic.com

http_access deny CONNECT !SSL_ports
http_access allow ai_clients allowed_ai
http_access deny all
```

This is safer than allowing a whole office or datacenter range if only one application tier needs the access.

## Example: use with `CLI` tools and API clients

Many tools respect one or more of these environment variables:

```bash
export HTTP_PROXY=http://proxy.internal.example:3128
export HTTPS_PROXY=http://proxy.internal.example:3128
export http_proxy=http://proxy.internal.example:3128
export https_proxy=http://proxy.internal.example:3128
```

For one-off command testing:

```bash
HTTPS_PROXY=http://proxy.internal.example:3128 curl https://api.openai.com/v1/models
```

Typical operational pattern:

* set proxy environment variables for the service account or container,
* keep direct outbound firewall rules closed,
* allow only the proxy host to open internet connections.

### `Anthropic` and `OpenAI` usage note

If a vendor `CLI` or SDK uses standard `HTTP` / `HTTPS` proxy environment variables, `Squid` can usually control it
without code changes.

Still verify each tool in practice because some clients:

* ignore proxy variables,
* use additional telemetry or update endpoints,
* contact authentication or browser-based login domains beyond the main API domain.

That means a strict allowlist may need a little real-world adjustment after observing logs.

## Practical service and logging setup

### Useful files

Common paths on Linux systems:

```text
/etc/squid/squid.conf
/var/log/squid/access.log
/var/log/squid/cache.log
```

Use logs when testing allow and deny behavior.

Example:

```bash
sudo tail -f /var/log/squid/access.log
```

This helps you see whether requests are:

* allowed,
* denied,
* sent to an unexpected host,
* failing because of port or method rules.

### Basic troubleshooting commands

```bash
sudo squid -k parse
sudo systemctl status squid
sudo journalctl -u squid -n 100 --no-pager
```

## Tips and tricks

### Start with a minimal allowlist

Do not begin by allowing half the internet. Start with the smallest possible set of domains and add more only when logs
show a real operational need.

### Keep policy separate from assumptions

Document why a domain is allowed. For example:

* production AI inference,
* vendor authentication,
* package downloads,
* source control access.

This makes later cleanup easier.

### Prefer destination allowlists over broad port-only rules

Allowing all outbound `443` is usually too broad for controlled environments. Pair allowed ports with destination
domains or client restrictions.

### Combine `Squid` with network firewalls

`Squid` should not be the only control layer if the environment is sensitive.

A stronger pattern is:

* internal clients cannot reach the public internet directly,
* only the proxy host has outbound internet access,
* proxy rules decide which destinations are allowed.

### Validate vendor endpoint changes

Cloud vendors sometimes add or change subdomains. A previously working strict allowlist may fail later if the service
starts using another hostname.

Review logs and update the policy intentionally.

## Common issues

### Requests are denied even for approved APIs

Possible causes:

* the client is not actually using the proxy,
* the client connects to a different hostname than expected,
* `CONNECT` or `SSL_ports` rules are too strict,
* the allowed domain list is incomplete.

Fix:

* verify proxy environment variables,
* inspect `access.log`,
* test with `curl` through the proxy first,
* add the exact required hostnames only after verification.

### Too-broad `dstdomain` patterns

Allowing `.openai.com` or `.anthropic.com` may be acceptable operationally, but it is broader than allowing one exact
subdomain.

If you need stricter control, prefer explicit hosts such as:

* `api.openai.com`
* `api.anthropic.com`

and expand only when logs prove it is necessary.

### `HTTPS` inspection expectations

A standard forward proxy without `SSL bump` does not see encrypted request paths or payloads.

That means:

* you can often control destination host access,
* you cannot reliably filter normal `HTTPS` API usage by detailed path without more invasive interception,
* `SSL bump` adds complexity, trust-distribution requirements, and privacy/security considerations.

For many infrastructure cases, host-based allowlisting is the right balance.

### Authentication and browser login flows

Some tools may use login domains, device authorization flows, or browser-based authentication steps that are different
from the main API endpoint.

If the API works but login fails, inspect which extra hosts are contacted and decide whether they should also be
allowed.

## When developers and operators should know this

From a practical backend, infrastructure, and platform perspective:

* junior engineers should understand what a forward proxy is and how proxy environment variables work,
* mid-level engineers should be able to configure destination allowlists and troubleshoot denied traffic,
* senior engineers should understand policy design, layered egress control, logging implications, and operational risk.

## See also

* [HAProxy](haproxy.md)
* [Togglz](togglz.md)
* [GitHub CI/CD Tips](ci-github.md)
* [Spring Boot](springboot.md)
* [OpenAI](https://platform.openai.com/docs/)
* [Anthropic documentation](https://docs.anthropic.com/)
* [Squid official documentation](https://wiki.squid-cache.org/)
