# OpenSearch

## Information

OpenSearch is a community-driven, open source search and analytics suite. It was forked from Elasticsearch and Kibana
7.10.2 following license changes. It includes a search engine (OpenSearch) and a visualization interface (OpenSearch
Dashboards).

It is used for:

* Real-time application monitoring.
* Log analytics.
* Website search.
* SIEM (Security Information and Event Management).

## Installation

### Vanilla Machine (Linux)

1. **Download**:
   ```bash
   wget https://artifacts.opensearch.org/releases/bundle/opensearch/2.15.0/opensearch-2.15.0-linux-x64.tar.gz
   ```
2. **Extract**:
   ```bash
   tar -xzf opensearch-2.15.0-linux-x64.tar.gz
   cd opensearch-2.15.0
   ```
3. **Run**:
   ```bash
   ./opensearch-tar-install.sh
   ```

## Setup with Docker for Developer

### Docker Run

```bash
docker run -d --name opensearch \
  -p 9200:9200 -p 9600:9600 \
  -e "discovery.type=single-node" \
  -e "OPENSEARCH_INITIAL_ADMIN_PASSWORD=mySecurePassword123!" \
  opensearchproject/opensearch:2.15.0
```

### Docker Compose (with Dashboards)

**docker-compose.yaml:**

```yaml
version: '3'
services:
  opensearch:
    image: opensearchproject/opensearch:2.15.0
    container_name: opensearch-node
    environment:
      - cluster.name=opensearch-cluster
      - node.name=opensearch-node
      - discovery.type=single-node
      - bootstrap.memory_lock=true
      - "OPENSEARCH_JAVA_OPTS=-Xms512m -Xmx512m"
      - "OPENSEARCH_INITIAL_ADMIN_PASSWORD=mySecurePassword123!"
    ulimits:
      memlock:
        soft: -1
        hard: -1
      nofile:
        soft: 65536
        hard: 65536
    ports:
      - 9200:9200
      - 9600:9600
    volumes:
      - opensearch_data:/usr/share/opensearch/data
  opensearch-dashboards:
    image: opensearchproject/opensearch-dashboards:2.15.0
    container_name: opensearch-dashboards
    ports:
      - 5601:5601
    environment:
      OPENSEARCH_HOSTS: '["https://opensearch:9200"]'

volumes:
  opensearch_data:
```

## How to add users

OpenSearch uses a security plugin. For local development, you can manage users via `internal_users.yml` or the REST API.

1. **REST API (Admin required)**:
   ```bash
   curl -X PUT "https://localhost:9200/_plugins/_security/api/internalusers/new_user" \
     -u "admin:mySecurePassword123!" \
     -H "Content-Type: application/json" \
     -d '{"password":"password123","backend_roles":["admin"],"attributes":{"key":"value"}}' -k
   ```

## Usage, tips and tricks

### Disable Security (Not recommended but common for local dev)

Set `plugins.security.disabled: true` in `opensearch.yml`.

### Check Health

```bash
curl -X GET "https://localhost:9200/_cluster/health?pretty" -u "admin:mySecurePassword123!" -k
```

## See also

* [OpenSearch Documentation](https://opensearch.org/docs/latest/)
* [Elasticsearch](elasticsearch.md)
