# Prometheus

## Information

Prometheus is an open-source systems monitoring and alerting toolkit originally built at SoundCloud. It is now a
Cloud Native Computing Foundation project.

It collects and stores its metrics as time series data, i.e. metrics information is stored with the timestamp at which
it was recorded, alongside optional key-value pairs called labels.

## Installation

### Vanilla Machine (Linux)

1. **Download**:
   ```bash
   wget https://github.com/prometheus/prometheus/releases/download/v2.53.0/prometheus-2.53.0.linux-amd64.tar.gz
   ```
2. **Extract**:
   ```bash
   tar -xzf prometheus-2.53.0.linux-amd64.tar.gz
   cd prometheus-2.53.0.linux-amd64
   ```
3. **Run**:
   ```bash
   ./prometheus --config.file=prometheus.yml
   ```

## Setup with Docker for Developer

### Docker Run

```bash
docker run -d --name prometheus \
    -p 9090:9090 \
    prom/prometheus
```

### Docker Compose

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
  prometheus:
    image: prom/prometheus:v2.53.0
    container_name: prometheus-dev
    ports:
      - 9090:9090
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus

volumes:
  prometheus_data:
```

**prometheus.yml:**

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
```

## How to add users

Prometheus does not have built-in user management. It is typically handled via a reverse proxy (like Nginx) with Basic
Auth or by using a tool like Prometheus Basic Auth.

For local development, it is usually run without authentication.

## Usage, tips and tricks

### Check Status

Access the web UI at `http://localhost:9090`.

### Common Queries (PromQL)

* `up`: Check which targets are up.
* `rate(http_requests_total[5m])`: Rate of HTTP requests over the last 5 minutes.

## See also

* [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
* [Grafana](grafana.md)
