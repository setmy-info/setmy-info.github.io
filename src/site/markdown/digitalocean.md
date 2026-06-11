# DigitalOcean

## Information

[DigitalOcean](https://www.digitalocean.com/) is a cloud infrastructure provider focused on developer-friendly virtual
machines, managed databases, object storage, networking, and managed Kubernetes. It is commonly used by individuals,
startups, small teams, and platform engineers who want a simpler cloud than the largest hyperscalers while still
getting production-ready building blocks.

### Main Functionalities and Features

* **Droplets**: Virtual machines for general workloads, APIs, web applications, workers, and jump hosts.
* **Managed Databases**: Hosted `PostgreSQL`, `MySQL`, `Redis`, and similar services with backups and operational help.
* **Spaces**: S3-compatible object storage for assets, backups, artifacts, and static files.
* **VPC and Networking**: Private networking, reserved IPs, DNS, firewalls, load balancers, and IPv6 support.
* **Managed Kubernetes**: `DOKS` (`DigitalOcean Kubernetes`) for running containerized workloads without managing the
  control plane yourself.
* **App Platform and Platform Services**: Higher-level options for web applications, background workers, and static
  sites.

### Common Use Cases

* Host small to medium production web applications.
* Run developer sandboxes, CI helpers, and test environments.
* Deploy containers on virtual machines or on `DOKS`.
* Build cost-conscious Kubernetes environments for internal tools, APIs, and side projects.

### Registration

To start using DigitalOcean, register at:

* [DigitalOcean signup](https://cloud.digitalocean.com/registrations/new)

Typical registration flow:

1. Open the signup page and create an account with email, Google, GitHub, or another offered identity provider.
2. Verify your email address if DigitalOcean asks for confirmation.
3. Complete billing setup; cloud providers usually require payment details before you can provision resources.
4. Log in to the control panel and create a project so your future resources are grouped clearly.
5. Generate a personal access token for CLI and automation usage.

Practical notes:

* Review current free credit, promotions, or verification requirements directly on the signup page because they can
  change.
* Enable MFA on the account before you start creating production-facing resources.
* Create a separate personal access token for automation instead of reusing one token everywhere.

## CLI

Yes. The main DigitalOcean CLI is [`doctl`](https://docs.digitalocean.com/reference/doctl/).

Typical use cases for `doctl`:

* authenticate to your account,
* manage Droplets, databases, firewalls, and load balancers,
* create and inspect Kubernetes clusters,
* and export cluster access configuration for `kubectl`.

## Installation

### Download and install `doctl`

Use the official installation documentation when possible:

* [DigitalOcean `doctl` install guide](https://docs.digitalocean.com/reference/doctl/how-to/install/)

Typical installation options:

* **Windows**: install with `winget` if the package is available in your environment, or download the official release.
* **macOS**: `brew install doctl`
* **Linux**: download the release archive or install through the package manager if your distribution provides it.

After installation, verify the binary:

```bash
doctl version
```

### Authentication

Create a personal access token in the DigitalOcean control panel and initialize the CLI:

```bash
doctl auth init
```

Useful follow-up commands:

```bash
doctl account get
doctl compute region list
doctl compute size list
doctl kubernetes options versions
```

## Usage, tips and tricks

### Basic workflow

Typical workflow with DigitalOcean:

1. Create a project and define the target region.
2. Create networking and firewall rules first, not last.
3. Provision a `Droplet`, managed database, load balancer, or `DOKS` cluster.
4. Store infrastructure definitions in `Terraform` or another reproducible tool instead of relying only on clickops.
5. Tag resources so cleanup, billing review, and automation stay easy.

### Representative `doctl` commands

```bash
doctl compute droplet list
doctl compute image list-distribution
doctl kubernetes cluster list
doctl kubernetes options regions
```

### Practical tips

* Prefer projects, tags, and naming conventions from day one; cleanup is much easier later.
* Watch transfer, managed database, backup, and load-balancer costs, not only VM cost.
* Use cloud-init or configuration management for Droplet bootstrap instead of manual SSH-only setup.
* Restrict inbound access with DigitalOcean Cloud Firewalls and avoid leaving SSH open to the world.
* Use monitoring, backups, and snapshots intentionally; they are useful, but they also change cost.
* If production reliability matters, choose regions and instance types after testing disk, CPU, and network behavior for
  your actual workload.

## Kubernetes usage

DigitalOcean has a first-party managed Kubernetes offering called `DOKS`.

### Why `DOKS` is attractive

* managed Kubernetes control plane,
* simple cluster creation flow,
* integration with load balancers, block storage, and container registry,
* and a relatively small operational surface compared with self-managing everything on raw virtual machines.

### Basic `DOKS` flow

One practical first-run workflow looks like this:

1. Register and log in to DigitalOcean.
2. Create a project and choose the region where the cluster should run.
3. Install `doctl`, `kubectl`, and optionally `helm` on your workstation.
4. Create a personal access token and run `doctl auth init`.
5. Review available Kubernetes versions, regions, and node sizes.
6. Create a small starter cluster.
7. Save the kubeconfig locally and confirm node access with `kubectl`.
8. Create namespaces, secrets, ingress, storage, and deployment tooling before loading real workloads.

Create a cluster:

```bash
doctl kubernetes cluster create my-cluster --region fra1 --version latest
```

Fetch local `kubectl` configuration:

```bash
doctl kubernetes cluster kubeconfig save my-cluster
kubectl get nodes
```

Useful follow-up commands:

```bash
kubectl get namespaces
kubectl create namespace demo
kubectl config current-context
kubectl get storageclass
```

Example first application rollout:

```bash
kubectl create deployment demo-nginx --image=nginx:stable
kubectl expose deployment demo-nginx --port=80 --type=LoadBalancer
kubectl get pods -n default
kubectl get svc
```

At that stage, you have a basic running cluster and a public service backed by a managed load balancer. Afterward,
move toward `Helm`, GitOps, or manifests stored in version control rather than relying on ad-hoc commands.

### Using private Docker Hub images with a Docker Hub token

If your Kubernetes workloads need private images from Docker Hub, use a Docker Hub access token instead of your normal
account password.

General flow:

1. In Docker Hub, create a personal access token for the account or organization that owns the image.
2. In the cluster, create an image pull secret that uses your Docker Hub username and the token.
3. Reference that secret from the target namespace or directly from your `Deployment` / `StatefulSet`.

Create the secret:

```bash
kubectl create secret docker-registry dockerhub-pull \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=YOUR_DOCKERHUB_USERNAME \
  --docker-password=YOUR_DOCKERHUB_TOKEN \
  --docker-email=YOUR_EMAIL
```

Use it in a workload:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    name: private-app
spec:
    replicas: 1
    selector:
        matchLabels:
            app: private-app
    template:
        metadata:
            labels:
                app: private-app
        spec:
            imagePullSecrets:
                -   name: dockerhub-pull
            containers:
                -   name: app
                    image: yourorg/your-private-image:1.0.0
```

Notes:

* Create the secret in every namespace that needs to pull the private image, unless you automate namespace bootstrap.
* Prefer least-privilege tokens and rotate them intentionally.
* If you hit Docker Hub rate limits or want tighter platform integration, evaluate DigitalOcean Container Registry as an
  alternative.

### Kubernetes tips and tricks

* Start with a small non-production cluster and test ingress, storage classes, upgrades, and backup procedures early.
* Use a separate namespace strategy and tagging/labeling standard from the beginning.
* Prefer `Helm` or GitOps-style deployment flows instead of manual `kubectl apply` for everything.
* Confirm which load balancer annotations, storage classes, and CSI features are supported by your target `DOKS`
  version.
* Plan cluster upgrades explicitly; do not treat managed Kubernetes as no-ops Kubernetes.
* For cost control, review node pool sizes, autoscaling, load balancers, persistent volumes, and idle environments.

### When not to start with Kubernetes

If your application is still small, a few containers on one or two `Droplets` may be easier and cheaper than `DOKS`.
Move to Kubernetes when you truly need rolling deployments, stronger scheduling, self-healing, or multi-service
operations at scale.

## See also

* [DigitalOcean Documentation](https://docs.digitalocean.com/)
* [doctl](https://docs.digitalocean.com/reference/doctl/)
* [Terraform](terraform.html)
* [Kubernetes (K8s)](kubernetes.html)
