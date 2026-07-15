# Graylog

## Information

Graylog is a leading centralized log management solution for capturing, storing, and analyzing data. It provides a
powerful and flexible platform for log data from any source.

Key Features:

* Real-time log collection and analysis.
* Dashboards for data visualization.
* Alerting and notifications.
* Archiving for long-term storage.

## Installation

### Vanilla Machine (Linux)

Graylog requires MongoDB and Elasticsearch (or OpenSearch).

1. **Install MongoDB and OpenSearch** (Follow their respective guides).
2. **Download Graylog**:
   ```bash
   wget https://downloads.graylog.org/releases/graylog/graylog-6.0.0.tgz
   ```
3. **Extract**:
   ```bash
   tar -xzf graylog-6.0.0.tgz
   cd graylog-6.0.0
   ```
4. **Configure**: Edit `graylog.conf` to set `password_secret` and `root_password_sha2`.
5. **Run**:
   ```bash
   ./bin/graylog-server
   ```

## Setup with Docker for Developer

### Docker Compose (Recommended)

**docker-compose.yaml:**

```yaml
version: '3'
services:
  mongodb:
    image: mongo:5.0
    container_name: mongodb
  opensearch:
    image: opensearchproject/opensearch:2.15.0
    environment:
      - cluster.name=graylog
      - node.name=opensearch
      - discovery.type=single-node
      - bootstrap.memory_lock=true
      - "OPENSEARCH_JAVA_OPTS=-Xms512m -Xmx512m"
      - "OPENSEARCH_INITIAL_ADMIN_PASSWORD=mySecurePassword123!"
    ulimits:
      memlock:
        soft: -1
        hard: -1
  graylog:
    image: graylog/graylog:6.0
    container_name: graylog
    environment:
      - GRAYLOG_PASSWORD_SECRET=somepasswordpepper
      - GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
      - GRAYLOG_HTTP_EXTERNAL_URI=http://127.0.0.1:9000/
      - GRAYLOG_ELASTICSEARCH_HOSTS=https://admin:mySecurePassword123!@opensearch:9200
      - GRAYLOG_MONGODB_URI=mongodb://mongodb:27017/graylog
    ports:
      - 9000:9000
      - 1514:1514
      - 12201:12201
    depends_on:
      - mongodb
      - opensearch
```

*Note: `root_password_sha2` above is `admin`.*

## How to add users

Graylog users can be managed via the Web Interface or REST API.

1. **Web Interface**: System -> Authentication -> Users.
2. **REST API**:
   ```bash
   curl -u admin:admin -H "Content-Type: application/json" -X POST \
     http://localhost:9000/api/users \
     -d '{"username":"newuser","password":"password123","email":"user@example.com","full_name":"New User","permissions":["*"]}'
   ```

## Usage, tips and tricks

### Send test log (GELF)

```bash
echo '{"version": "1.1","host":"example.org","short_message":"A short message","level":1,"_some_info":"foo"}' | nc -w 1 -u localhost 12201
```

## See also

* [Graylog Documentation](https://docs.graylog.org/)
* [OpenSearch](opensearch.md)
