# Fluent Bit

## Information

Fluent Bit is a super fast, lightweight, and highly scalable logging and metrics processor and forwarder. It is the
preferred choice for cloud-native and containerized environments like Kubernetes.

It is designed for:

* High performance with low memory and CPU footprint.
* Collecting data from different sources.
* Processing and filtering data.
* Forwarding data to various destinations (OpenSearch, Prometheus, etc.).

## Installation

### Vanilla Machine (Linux)

1. **Download and Extract**:
   ```bash
   wget https://fluentbit.io/releases/3.1/fluent-bit-3.1.4.tar.gz
   tar -zxvf fluent-bit-3.1.4.tar.gz
   # Building from source is often required for vanilla installs,
   # but binary packages are available for most distros.
   ```

### Ubuntu/Debian

```bash
curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh
```

### Run (Binary)

```bash
/opt/fluent-bit/bin/fluent-bit -i cpu -o stdout
```

## Setup with Docker for Developer

### Docker Run

```bash
docker run -d --name fluent-bit -p 24224:24224 fluent/fluent-bit:3.1.4
```

### Docker Compose

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
  fluent-bit:
    image: fluent/fluent-bit:3.1.4
    container_name: fluent-bit-dev
    ports:
      - 24224:24224
      - 24224:24224/udp
    volumes:
      - ./fluent-bit.conf:/fluent-bit/etc/fluent-bit.conf
```

**fluent-bit.conf:**

```ini
[SERVICE]
    Flush        1
    Daemon       Off
    Log_Level    info

[INPUT]
    Name         cpu
    Tag          cpu.local

[OUTPUT]
    Name         stdout
    Match        *
```

## How to add users

Fluent Bit itself does not have a user management system as it is a data pipeline tool. Authentication is usually
handled
per-plugin (e.g., when sending to OpenSearch with Basic Auth).

## Usage, tips and tricks

### Test configuration

```bash
fluent-bit -c fluent-bit.conf
```

## See also

* [Fluent Bit Documentation](https://docs.fluentbit.io/)
* [Vector](vector.md)
