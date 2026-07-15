# Grafana

## Information

Grafana is a multi-platform open source analytics and interactive visualization web application. It provides charts,
graphs, and alerts for the web when connected to supported data sources.

It is commonly used for:

* Visualizing infrastructure metrics (Prometheus).
* Analyzing log data (Loki, Elasticsearch).
* Business intelligence dashboards.

## Installation

### Vanilla Machine (Linux)

1. **Download and Extract**:
   ```bash
   wget https://dl.grafana.com/oss/release/grafana-11.1.0.linux-amd64.tar.gz
   tar -zxvf grafana-11.1.0.linux-amd64.tar.gz
   cd grafana-11.1.0
   ```
2. **Run**:
   ```bash
   ./bin/grafana-server web
   ```

## Setup with Docker for Developer

### Docker Run

```bash
docker run -d --name grafana -p 3000:3000 grafana/grafana:11.1.0
```

### Docker Compose

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
  grafana:
    image: grafana/grafana:11.1.0
    container_name: grafana-dev
    ports:
      - 3000:3000
    volumes:
      - grafana_data:/var/lib/grafana

volumes:
  grafana_data:
```

## How to add users

Grafana has built-in user management.

1. **Web Interface**: Login (default `admin/admin`), then go to Administration -> Users.
2. **CLI (grafana-cli)**:
   ```bash
   ./bin/grafana-cli admin reset-admin-password newpassword
   ```
3. **REST API**:
   ```bash
   curl -X POST -H "Content-Type: application/json" -d '{
     "name":"User",
     "email":"user@grafana.com",
     "login":"user",
     "password":"password"
   }' http://admin:admin@localhost:3000/api/admin/users
   ```

## Usage, tips and tricks

### Data Sources

Add Prometheus as a data source by pointing to `http://prometheus:9090` (if in the same Docker network).

## See also

* [Grafana Documentation](https://grafana.com/docs/)
* [Prometheus](prometheus.md)
