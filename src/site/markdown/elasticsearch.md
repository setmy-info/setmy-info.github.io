# Elasticsearch

## Information

Elasticsearch is a distributed, RESTful search and analytics engine capable of addressing a growing number of use cases.
As the heart of the Elastic Stack, it centrally stores your data for lightning fast search, fine‑tuned relevancy, and
powerful analytics that scale with ease.

It is commonly used for:

* Log analytics and observability.
* Full-text search.
* Security intelligence (SIEM).
* Business analytics.

## Installation

### Vanilla Machine (Linux)

1. **Download**:
   ```bash
   wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.14.1-linux-x86_64.tar.gz
   ```
2. **Extract**:
   ```bash
   tar -xzf elasticsearch-8.14.1-linux-x86_64.tar.gz
   cd elasticsearch-8.14.1
   ```
3. **Run**:
   ```bash
   ./bin/elasticsearch
   ```

### macOS

1. **Download and Extract** as above, or use Homebrew:
   ```bash
   brew tap elastic/tap
   brew install elastic/tap/elasticsearch-full
   ```
2. **Run**:
   ```bash
   elasticsearch
   ```

## Setup with Docker for Developer

The easiest way to start Elasticsearch for development is using Docker.

### Docker Run (Single Node)

```bash
docker run -d --name elasticsearch \
  -p 9200:9200 \
  -e "discovery.type=single-node" \
  -e "xpack.security.enabled=false" \
  docker.elastic.co/elasticsearch/elasticsearch:8.14.1
```

### Docker Compose

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.14.1
    container_name: elasticsearch-dev
    environment:
      - node.name=elasticsearch
      - cluster.name=es-docker-cluster
      - discovery.type=single-node
      - xpack.security.enabled=false
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    ports:
      - 9200:9200
    volumes:
      - es_data:/usr/share/elasticsearch/data

volumes:
  es_data:
```

Start with:

```bash
docker-compose up -d
```

## How to add users

For local development, security is often disabled (`xpack.security.enabled=false`). If you need to test with users:

1. **Enable Security**: Set `xpack.security.enabled=true`.
2. **Generate Passwords** (Built-in users):
   ```bash
   ./bin/elasticsearch-setup-passwords interactive
   ```
3. **Add Custom User**:
   ```bash
   ./bin/elasticsearch-users useradd my_user -p my_password -r superuser
   ```

## Usage, tips and tricks

### Check Health

```bash
curl -X GET "localhost:9200/_cluster/health?pretty"
```

### List Indices

```bash
curl -X GET "localhost:9200/_cat/indices?v"
```

## See also

* [Elasticsearch Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
* [OpenSearch](opensearch.md)
* [Installing Elasticsearch](https://www.elastic.co/docs/deploy-manage/deploy/self-managed/installing-elasticsearch)
