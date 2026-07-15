# Vector

## Information

Vector is a high-performance observability data pipeline that puts you in control of your observability data. It
collects, transforms, and routes all your logs, metrics, and traces to any vendor or tool.

Key advantages:

* Extreme performance and reliability (written in Rust).
* Unified logs and metrics.
* Programmable transformations using VRL (Vector Remap Language).
* Vendor agnostic.

## Installation

### Vanilla Machine (Linux)

1. **Download and Install**:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.vector.dev | sh
   ```
2. **Run**:
   ```bash
   vector --config vector.yaml
   ```

### macOS

```bash
brew install vector
```

## Setup with Docker for Developer

### Docker Run

```bash
docker run -d --name vector \
  -p 8383:8383 \
  timberio/vector:0.39.0-debian
```

### Docker Compose

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
  vector:
    image: timberio/vector:0.39.0-debian
    container_name: vector-dev
    ports:
      - 8383:8383
    volumes:
      - ./vector.yaml:/etc/vector/vector.yaml:ro
```

**vector.yaml:**

```yaml
sources:
  in:
    type: "stdin"

sinks:
  out:
    inputs:
      - "in"
    type: "console"
    encoding:
      codec: "json"
```

## How to add users

Vector does not have internal user management. Authentication for its APIs or sinks is configured in the `vector.yaml`
file (e.g., configuring Basic Auth for an HTTP source or sink).

## Usage, tips and tricks

### Validate configuration

```bash
vector validate vector.yaml
```

### Visualizing topology

Vector provides a built-in GraphQL API and top command to see how data flows through the pipeline.

## See also

* [Vector Documentation](https://vector.dev/docs/)
* [Fluent Bit](fluent-bit.md)
