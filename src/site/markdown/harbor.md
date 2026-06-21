# Harbor

## Information

Harbor is an open-source container image registry maintained by the CNCF (graduated project). It extends the standard
Docker Registry with enterprise features including role-based access control, image vulnerability scanning, content
trust signing, and cross-datacenter replication.

Key features:

* **RBAC** — fine-grained project and repository access control.
* **Vulnerability scanning** — integrates with Trivy or Clair to scan images on push or on demand.
* **Content trust** — image signing via Notary to ensure only trusted images are deployed.
* **Replication** — push or pull replication between Harbor instances or to/from other registries (Docker Hub, ECR,
  GCR).
* **Web UI and REST API** — manage projects, users, scan policies, and replication rules visually or programmatically.
* **Authentication** — local database, LDAP/AD, OIDC (Keycloak, Google, GitHub).
* **Helm chart storage** — Harbor can also serve as a Helm chart repository.

## Installation

Docker and Docker Compose are required before installing Harbor.

### Rocky Linux / Fedora / Debian

Download the latest online or offline installer from the
[Harbor releases page](https://github.com/goharbor/harbor/releases):

```shell
# Download online installer (requires internet at install time)
HARBOR_VERSION=v2.11.0
wget https://github.com/goharbor/harbor/releases/download/${HARBOR_VERSION}/harbor-online-installer-${HARBOR_VERSION}.tgz
tar xvzf harbor-online-installer-${HARBOR_VERSION}.tgz
cd harbor
```

Configure, then install:

```shell
cp harbor.yml.tmpl harbor.yml
# Edit harbor.yml — set hostname, HTTPS certs, admin password
./install.sh
# Or with optional components
./install.sh --with-trivy
```

### Verify

```shell
docker compose ps
# Access UI at https://<hostname>
```

## Configuration

Edit `harbor.yml` before running `install.sh`:

```yaml
hostname: registry.example.com

https:
  port: 443
  certificate: /path/to/cert.pem
  private_key: /path/to/key.pem

harbor_admin_password: ChangeMe123

database:
  password: root123

data_volume: /data
```

After changing configuration, re-run `./prepare && docker compose up -d` to apply.

## Usage, tips and tricks

### Login and Push Images

```shell
docker login registry.example.com
docker tag myapp:latest registry.example.com/myproject/myapp:latest
docker push registry.example.com/myproject/myapp:latest
docker pull registry.example.com/myproject/myapp:latest
```

### Scan an Image on Demand

Via the Harbor web UI: navigate to the repository, select a tag, click **Scan**.

Via CLI (REST API):

```shell
curl -u admin:password -X POST \
  "https://registry.example.com/api/v2.0/projects/myproject/repositories/myapp/artifacts/latest/scan"
```

### Set Up Replication

In the Harbor UI: **Administration → Replications → New Replication Rule**. Choose source/target endpoint,
filter by project or tag, and set trigger (manual, scheduled, or event-based).

### Kubernetes Integration

Configure `imagePullSecrets` in Kubernetes to authenticate against Harbor:

```shell
kubectl create secret docker-registry harbor-secret \
  --docker-server=registry.example.com \
  --docker-username=robot-account \
  --docker-password=token
```

## See also

* [Harbor official site](https://goharbor.io/)
* [Harbor documentation](https://goharbor.io/docs/)
* [Harbor GitHub](https://github.com/goharbor/harbor)
* [Docker](docker.md)
* [Kubernetes](kubernetes.md)
* [Portainer](portainer.md)
