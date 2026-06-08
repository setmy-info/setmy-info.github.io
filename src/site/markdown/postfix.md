# Postfix

## Information

Postfix is an open-source mail transfer agent (`MTA`) used to accept, route, relay, and deliver email over `SMTP`. In many teams it is used as the local or environment-level mail relay that applications talk to when they need to send notifications, password resets, invoices, alerts, and other outbound messages.

In practice, Postfix is often chosen when teams need a lightweight and well-understood SMTP component that can:

* accept mail from local applications,
* relay mail through an upstream provider,
* apply sender and relay restrictions,
* queue mail for retry when the next hop is temporarily unavailable,
* and provide a standard submission endpoint for internal systems.

### Main Functionalities and Features

* **SMTP server and relay**: Receives mail from local clients or upstream systems and forwards it to the next hop.
* **Mail queueing**: Retries delivery automatically when the destination is temporarily unavailable.
* **Local submission**: Applications can submit mail to `localhost:25` or an authenticated submission port.
* **Upstream relay support**: Can forward outgoing mail through an ISP relay, cloud email provider, or internal smart host.
* **TLS support**: Supports opportunistic or required encryption for SMTP client and server sides.
* **SASL authentication**: Can authenticate to an upstream relay using username and password credentials.
* **Policy and restriction controls**: Supports relay restrictions, sender rules, network allow lists, and anti-open-relay configuration.
* **Compatibility with common mail tools**: Works with `mailx`, `sendmail`-compatible commands, scripts, cron jobs, and many application frameworks.

### Common Developer Use Cases

* Run a local SMTP relay for development and integration testing.
* Relay application mail through an ISP-provided SMTP server.
* Keep application code simple by letting apps send to a local Postfix instance rather than directly to the public internet.
* Capture or reroute outgoing mail in non-production environments.
* Standardize outbound email for multiple services on one machine or inside one Docker network.

### Important Delivery Notes

Postfix itself is an `SMTP` server and relay, but deliverability usually depends on the surrounding mail setup:

* **Direct internet delivery from a developer laptop or home connection is often blocked or unreliable**.
* **Many ISPs block outbound `TCP/25`** to reduce spam.
* **Many ISPs only allow sending through their own authenticated SMTP relay**.
* **`SPF`, `DKIM`, and `DMARC` usually belong to the domain and upstream mail-provider setup, not just Postfix itself.**

For that reason, developers commonly use Postfix as a **local smart relay** that forwards all outgoing mail through:

* an ISP mail relay,
* a company SMTP relay,
* or a transactional email provider.

### Estonia / ISP Relay Context

In Estonia and similar residential or SME internet environments, it is common that outbound email is accepted only when:

* you send through the ISP's own SMTP server,
* you authenticate with the mailbox username and password provided by that ISP,
* and you use the submission port such as `587` with `STARTTLS` or `465` with implicit `TLS`.

If direct external delivery does not work, assume first that your ISP expects you to use its relay credentials rather than allowing anonymous outbound mail from your connection.

## Installation

### CentOS, Rocky Linux

1. **Install Postfix**:
   ```bash
   sudo dnf install -y postfix cyrus-sasl cyrus-sasl-plain mailx
   ```
2. **Enable and start the service**:
   ```bash
   sudo systemctl enable --now postfix
   ```
3. **Check service status**:
   ```bash
   sudo systemctl status postfix
   ```

### Fedora

1. **Install Postfix**:
   ```bash
   sudo dnf install -y postfix cyrus-sasl cyrus-sasl-plain mailx
   ```
2. **Enable and start**:
   ```bash
   sudo systemctl enable --now postfix
   ```

### Debian, Ubuntu

During package installation you may be asked for a mail configuration type. For a developer relay host, `Internet Site` or `Satellite system` is the most common choice depending on whether the machine delivers directly or always relays through an upstream server.

1. **Install Postfix**:
   ```bash
   sudo apt update
   sudo apt install -y postfix libsasl2-modules bsd-mailx
   ```
2. **Enable and start**:
   ```bash
   sudo systemctl enable --now postfix
   ```

### macOS

Postfix is historically included with macOS, but the platform is not ideal for running a long-term customized mail relay. For quick local experiments, the built-in binary may be enough:

```bash
postconf mail_version
sudo postfix start
```

For more controlled development work, Docker is usually the simpler choice on macOS.

### FreeBSD

FreeBSD often includes a mail stack in the base system, but if you want the ports/package version of Postfix:

```bash
pkg install postfix ca_root_nss mailx
sysrc postfix_enable="YES"
service postfix start
```

### OpenIndiana

Package names can vary by repository state, but a typical approach is:

```bash
pkg install service/network/smtp/postfix
svcadm enable postfix
```

If the package is not available in your configured repository, Docker or another container runtime is usually the faster developer path.

## Setup with Docker for Developer

For developers, the most practical setup is usually **not** a full public mail server. Instead, run Postfix as a **local relay container** and forward all outgoing mail to an upstream SMTP provider.

This approach is useful when:

* your application expects a local SMTP host,
* you want one place to configure relay credentials,
* or your ISP only permits email through its own authenticated SMTP server.

### Docker Compose

Create a `docker-compose.yaml` file:

```yaml
version: '3.8'
services:
    postfix:
        image: boky/postfix:latest
        container_name: postfix-dev
        environment:
            ALLOWED_SENDER_DOMAINS: example.com
            RELAYHOST: smtp.isp.example:587
            RELAYHOST_USERNAME: mailbox@example.com
            RELAYHOST_PASSWORD: change-this-password
        ports:
            - "2525:25"
```

Start it:

```bash
docker compose up -d
```

Developer notes:

* Map container port `25` to local port `2525` to avoid conflicts with a host mail service.
* Point applications to `localhost:2525` for outbound mail.
* This pattern is intended for **outbound relay**, not for receiving internet mail for a domain.
* Replace `smtp.isp.example` and credentials with the actual ISP or company relay values.

### Docker Compose with Environment File

For teams, it is safer to keep relay credentials outside the compose file.

`docker-compose.yaml`:

```yaml
version: '3.8'
services:
    postfix:
        image: boky/postfix:latest
        container_name: postfix-dev
        env_file:
            - .env.postfix
        ports:
            - "2525:25"
```

`.env.postfix`:

```dotenv
ALLOWED_SENDER_DOMAINS=example.com
RELAYHOST=smtp.isp.example:587
RELAYHOST_USERNAME=mailbox@example.com
RELAYHOST_PASSWORD=change-this-password
```

This is often the quickest way for developers to share a standard local mail relay setup without hard-coding credentials in source-controlled files.

### Quick Developer Flow

1. Start the Postfix relay container.
2. Configure your application to use `localhost` port `2525` as SMTP host and port.
3. Let Postfix relay mail through the configured ISP or company SMTP server.
4. Check container logs if a message is rejected.

Example application settings:

```properties
smtp.host=localhost
smtp.port=2525
smtp.username=
smtp.password=
smtp.starttls.enable=false
```

In this model, the **application does not authenticate to the upstream ISP**. Instead, the application sends locally to Postfix, and Postfix performs the authenticated upstream relay.

## Configuration

### Live Environment Setup

For live or shared environments, Postfix should be configured as either:

* a **local relay / smart host client** that sends through an upstream provider, or
* a **proper mail server** with DNS, anti-spam, and domain authentication controls.

For most application teams, the first option is simpler and safer.

### Minimum Smart-Relay Configuration

Typical `/etc/postfix/main.cf` entries:

```ini
myhostname = app01.example.internal
myorigin = example.com
inet_interfaces = all
inet_protocols = ipv4
mydestination = localhost
relayhost = [smtp.isp.example]:587

smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous

smtp_use_tls = yes
smtp_tls_security_level = encrypt
smtp_tls_note_starttls_offer = yes

mynetworks = 127.0.0.0/8 [::1]/128 172.16.0.0/12
```

Typical `/etc/postfix/sasl_passwd` file:

```ini
[smtp.isp.example]:587 mailbox@example.com:change-this-password
```

Then build the lookup database and lock down permissions:

```bash
sudo postmap /etc/postfix/sasl_passwd
sudo chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
sudo chmod 600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
sudo systemctl restart postfix
```

### What Credentials to Set for Outgoing Email Servers

When your ISP provides the outgoing mail server, Postfix usually needs these values:

* **SMTP relay hostname**: for example `smtp.your-isp.example`
* **Port**: usually `587` for `STARTTLS` or `465` for implicit `TLS`
* **Username**: often the full mailbox address such as `user@isp-domain.example`
* **Password**: the mailbox password or an app-specific password
* **TLS mode**: `STARTTLS` on `587` is the most common pattern
* **Allowed sender address**: some providers only allow `From:` addresses that belong to the authenticated mailbox or domain

Before configuring Postfix, confirm these provider-specific details:

1. Whether authentication is mandatory for all outbound mail.
2. Whether the username must be the full email address or just the mailbox name.
3. Whether the provider requires `587`, `465`, or another submission port.
4. Whether the mailbox password is allowed or an application password is required.
5. Whether the provider rewrites or rejects sender addresses outside the authenticated domain.

### Estonia-Focused Setup Advice

If you are on an Estonian ISP connection and outbound email is restricted, a common working approach is:

1. Ask the ISP for the official outgoing SMTP server name.
2. Confirm the submission port, usually `587`.
3. Confirm whether the login name is the full email address.
4. Store that mailbox username and password in `/etc/postfix/sasl_passwd` or container environment variables.
5. Route all application mail through that relay instead of trying direct delivery to recipient domains.

Example values:

```ini
relayhost = [smtp.isp.example]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_use_tls = yes
smtp_tls_security_level = encrypt
```

```ini
[smtp.isp.example]:587 developer@isp.example:change-this-password
```

If your ISP only allows mail from its own address space, also make sure your application sends using a matching `From:` address such as `developer@isp.example` or another address explicitly permitted by the provider.

### Rocky Linux (`systemd` service)

1. **Install packages**:
   ```bash
   sudo dnf install -y postfix cyrus-sasl cyrus-sasl-plain
   ```
2. **Edit `/etc/postfix/main.cf`** with your relay settings.
3. **Create `/etc/postfix/sasl_passwd`** with the SMTP relay credentials.
4. **Build the password map and restart**:
   ```bash
   sudo postmap /etc/postfix/sasl_passwd
   sudo systemctl enable --now postfix
   sudo systemctl restart postfix
   ```
5. **Review logs**:
   ```bash
   sudo journalctl -u postfix -f
   ```

### Post-Startup Checks for Relay Environments

After Postfix is configured, confirm at least the following:

1. Local applications can connect to the SMTP port you expose.
2. The upstream relay accepts authentication.
3. `TLS` negotiation succeeds with the relay server.
4. Test mail reaches a real mailbox.
5. Sender-address restrictions from the upstream provider do not reject your messages.
6. Queue growth does not indicate repeated relay authentication failures.

## Use Cases and CLI Tools

### Sending a Test Email from the Host

If `mailx` is installed:

```bash
echo "Postfix test body" | mail -s "Postfix test" user@example.com
```

If the system provides a `sendmail`-compatible interface:

```bash
printf "Subject: Postfix test\n\nHello from Postfix\n" | sendmail user@example.com
```

### Sending a Test Email to a Dockerized Postfix Relay

If the container listens on local port `2525`, you can test with `swaks`:

```bash
swaks --server 127.0.0.1 --port 2525 --to user@example.com --from developer@example.com --header "Subject: Docker Postfix test"
```

`swaks` is especially useful because it shows SMTP conversation details and makes relay troubleshooting easier.

### Application Integration Example (`Spring Boot`)

If your application uses a local Postfix relay, the app configuration can stay simple:

```yaml
spring:
    mail:
        host: localhost
        port: 2525
        properties:
            mail.smtp.auth: false
            mail.smtp.starttls.enable: false
```

In this pattern, `Spring Boot` talks only to local Postfix, and Postfix handles upstream authentication.

### Python Example with `smtplib`

```python
import smtplib
from email.message import EmailMessage

message = EmailMessage()
message["Subject"] = "Postfix relay test"
message["From"] = "developer@example.com"
message["To"] = "user@example.com"
message.set_content("Hello from a local Postfix relay.")

with smtplib.SMTP("localhost", 2525, timeout=30) as smtp:
    smtp.send_message(message)
```

### Direct Application-to-ISP SMTP vs Local Postfix Relay

Developers usually have two choices:

1. **Application authenticates directly to the ISP SMTP server**.
2. **Application sends locally to Postfix, and Postfix authenticates to the ISP SMTP server**.

The second option is often easier when:

* multiple apps share one environment,
* you want one place to rotate credentials,
* you want queueing and retry behavior,
* or some older tools only support unauthenticated local SMTP submission.

## Usage, tips and tricks

### Coding Tips and Tricks

* **Use Postfix as a relay, not as a full mail platform, unless you also manage DNS and domain email authentication.**
* **Prefer port `587` with `STARTTLS`** for upstream submission unless your provider explicitly requires `465`.
* **Do not expose an open relay**: keep `mynetworks` narrow and do not permit unrestricted relaying.
* **Keep relay credentials out of source control** by using environment files, secret stores, or protected host files.
* **Watch the mail queue** with `mailq` or `postqueue -p` when delivery looks delayed.
* **Use `postconf -n`** to inspect the active non-default configuration quickly.
* **Use `swaks`** to test SMTP behavior before blaming application code.
* **Match the sender address to the ISP account rules** because some providers reject or rewrite mail from unrelated domains.

### Troubleshooting Notes

Common symptoms and likely causes:

* **`Relay access denied`**: wrong relay policy, sender restriction, or missing authentication.
* **`SASL authentication failed`**: wrong username, wrong password, wrong submission port, or the provider expects the full email address as username.
* **`Connection timed out` on port `25`**: your ISP may block direct outbound SMTP.
* **`Sender address rejected`**: your upstream provider may only allow sender identities from the authenticated mailbox or domain.
* **Messages remain in queue**: inspect logs and confirm upstream hostname, credentials, and TLS settings.

Useful commands:

```bash
postconf -n
postqueue -p
mailq
tail -f /var/log/maillog
```

On `systemd`-based systems, logs are often easier to inspect with:

```bash
journalctl -u postfix -f
```

### Backup and Restore Notes

For Postfix relay setups, the most important backup scope is usually **configuration and credentials**, not large mailbox stores.

Recommended backup scope:

* `/etc/postfix/main.cf`
* `/etc/postfix/master.cf`
* `/etc/postfix/sasl_passwd` and its protected source of truth
* any container environment files such as `.env.postfix`
* notes about which ISP or provider relay is in use, ports, usernames, and allowed sender addresses

Example backup:

```bash
sudo tar -czf postfix-config-$(date +%F).tar.gz /etc/postfix
```

Important backup notes:

* Protect backups because relay credentials are sensitive.
* If using containerized Postfix, keep compose files and environment templates under version control, but keep real passwords outside the repository.
* After restore, always validate that `postmap` has been regenerated if needed and that the relay credentials still work.

## See also

* [Postfix Official Site](https://www.postfix.org/)
* [Postfix Documentation](https://www.postfix.org/documentation.html)
* [Postfix Basic Configuration README](https://www.postfix.org/BASIC_CONFIGURATION_README.html)
* [Postfix SASL Howto](https://www.postfix.org/SASL_README.html)
* [Postfix TLS Support](https://www.postfix.org/TLS_README.html)
