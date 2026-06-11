# Hetzner Cloud

## Information

[Hetzner Cloud](https://www.hetzner.com/cloud) is the public cloud offering from Hetzner, a European infrastructure
provider known for cost-effective virtual servers, dedicated servers, storage, and data center services. It is often
used by developers, hosting providers, startups, and platform engineers who want straightforward infrastructure with a
strong price-to-performance ratio, especially in Europe.

### Main Functionalities and Features

* **Cloud Servers**: Virtual machines for web applications, APIs, batch workers, VPNs, and general Linux workloads.
* **Volumes and Backups**: Persistent block storage and instance backup options.
* **Load Balancers and Networking**: Private networks, floating IPs, firewalls, and managed load balancers.
* **Images and Snapshots**: Useful for standardized server rollout and repeatable environments.
* **Placement Groups**: Help distribute nodes for better availability.
* **Simple API and Automation Model**: Popular with teams that prefer direct infrastructure control.

### Common Use Cases

* Host Linux servers for applications and internal tools.
* Run self-managed container platforms such as `Docker`, `k3s`, or full Kubernetes.
* Build lower-cost development, staging, and edge-oriented environments.
* Operate infrastructure in a more hands-on way than with higher-level managed cloud platforms.

### Registration

To start using Hetzner Cloud, register at:

* [Hetzner Cloud console](https://console.hetzner.cloud/)

Typical registration and project setup flow:

1. Open the Hetzner Cloud console and create an account.
2. Complete email and identity verification steps if requested.
3. Add billing information because cloud resource creation usually requires it.
4. Create a first Hetzner Cloud project; projects are the main boundary for servers, networks, and API tokens.
5. Generate an API token for CLI usage and automation.

Practical notes:

* Review current region availability, pricing, and verification requirements in the console because they can change.
* Enable MFA on your Hetzner account before exposing services publicly.
* Create separate API tokens for personal CLI usage and CI or automation workloads.

## CLI

Yes. The main Hetzner Cloud CLI is [`hcloud`](https://github.com/hetznercloud/cli).

Typical use cases for `hcloud`:

* authenticate with the Hetzner Cloud API,
* create and manage servers, networks, volumes, firewalls, and load balancers,
* inspect locations, server types, and images,
* and automate cluster node creation for self-managed Kubernetes.

## Installation

### Download and install `hcloud`

Use the official project and documentation when possible:

* [Hetzner Cloud CLI repository](https://github.com/hetznercloud/cli)
* [Hetzner Cloud API documentation](https://docs.hetzner.cloud/)

Common installation methods depend on platform and package manager. Typical options include:

* **Windows**: install with `winget` if the package is available in your environment, or download the official release
  binary.
* **macOS**: `brew install hcloud`
* **Linux**: install from package manager if available or download the release binary from GitHub releases.

After installation, verify the CLI:

```bash
hcloud version
```

### Authentication

Create a Hetzner Cloud API token in the console and configure the CLI:

```bash
hcloud context create my-project
```

Representative inspection commands:

```bash
hcloud server-type list
hcloud location list
hcloud image list
hcloud network list
```

## Usage, tips and tricks

### Basic workflow

Typical workflow with Hetzner Cloud:

1. Create a project and API token.
2. Define private networks, firewall policy, and naming conventions.
3. Create servers or automation templates.
4. Attach volumes, load balancers, floating IPs, and backups as required.
5. Keep everything reproducible with `Terraform`, Ansible, cloud-init, or image-based provisioning.

### Representative `hcloud` commands

```bash
hcloud server list
hcloud network list
hcloud firewall list
hcloud load-balancer list
```

### Practical tips

* Treat private networking as a default for node-to-node communication.
* Use placement groups for multi-node clusters or highly available services.
* Standardize bootstrap with cloud-init; avoid rebuilding servers manually over SSH.
* Double-check data location, backups, and compliance expectations if your workload is regulated.
* Monitor bandwidth, snapshots, volumes, and load balancers because the cheapest VM is not always the whole bill.
* Test server types against your real workload; Hetzner is cost-effective, but instance fit still matters.

## Kubernetes usage

Hetzner Cloud is widely used for Kubernetes, but the usual approach is **self-managed Kubernetes on Hetzner
infrastructure** rather than a long-standing first-party managed Kubernetes control plane like `DOKS`, `EKS`, or `GKE`.

Common approaches include:

* `k3s` on multiple Hetzner Cloud servers,
* `kubeadm`-based clusters,
* Talos Linux-based Kubernetes clusters,
* Cluster API providers for Hetzner,
* and automation modules or Terraform blueprints maintained by the community or vendors.

### Why teams choose Hetzner for Kubernetes

* strong price-to-performance for worker nodes,
* straightforward server and networking model,
* load balancers and volumes usable with Kubernetes integrations,
* and a good fit for teams comfortable operating their own cluster lifecycle.

### Typical Kubernetes flow on Hetzner Cloud

1. Provision control-plane and worker nodes with `hcloud`, `Terraform`, or both.
2. Create private networks and firewall rules before cluster bootstrap.
3. Install Kubernetes using `k3s`, `kubeadm`, Talos, or another chosen distribution.
4. Install CSI/CCM integrations for Hetzner where required.
5. Configure ingress, load balancing, storage classes, observability, backup, and upgrade procedures.

### Step-by-step example to create and start using a first cluster

For many small and medium workloads on Hetzner Cloud, `k3s` is the simplest starting point.

1. Register in the Hetzner Cloud console and create a project.
2. Create an API token and configure `hcloud` with `hcloud context create my-project`.
3. Decide on a location, server type, private network range, and firewall policy.
4. Provision one control-plane node and at least one worker node.
5. Install `k3s` on the control-plane node.
6. Join worker nodes with the cluster token from the control-plane node.
7. Install the Hetzner Cloud Controller Manager and CSI driver if your chosen distribution requires them.
8. Copy the kubeconfig to your workstation and verify access with `kubectl get nodes`.
9. Deploy a test workload, ingress, and persistent storage before onboarding real applications.

Representative infrastructure commands:

```bash
hcloud network create --ip-range 10.0.0.0/16 k3s-network
hcloud firewall create --name k3s-fw
hcloud server create --name k3s-cp-1 --type cpx21 --image ubuntu-24.04 --location nbg1
hcloud server create --name k3s-worker-1 --type cpx21 --image ubuntu-24.04 --location nbg1
```

Representative cluster bootstrap pattern:

```bash
curl -sfL https://get.k3s.io | sh -
sudo cat /var/lib/rancher/k3s/server/node-token
curl -sfL https://get.k3s.io | K3S_URL=https://CONTROL_PLANE_IP:6443 K3S_TOKEN=YOUR_NODE_TOKEN sh -
```

Representative first checks from your workstation after copying kubeconfig:

```bash
kubectl get nodes
kubectl get pods -A
kubectl create namespace demo
kubectl create deployment demo-nginx --image=nginx:stable
kubectl expose deployment demo-nginx --port=80 --type=LoadBalancer
kubectl get svc
```

This gives you a usable first cluster, but production readiness still requires backup, upgrade, ingress, monitoring,
secrets handling, and disaster recovery planning.

### Using private Docker Hub images with a Docker Hub token

If your Hetzner-hosted Kubernetes cluster needs private images from Docker Hub, authenticate with a Docker Hub token
through a Kubernetes image pull secret.

Create the secret:

```bash
kubectl create secret docker-registry dockerhub-pull \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=YOUR_DOCKERHUB_USERNAME \
  --docker-password=YOUR_DOCKERHUB_TOKEN \
  --docker-email=YOUR_EMAIL
```

Reference it in workloads:

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
        - name: dockerhub-pull
      containers:
        - name: app
          image: yourorg/your-private-image:1.0.0
```

Notes:

* Keep the secret in the same namespace as the workload.
* Rotate Docker Hub tokens and avoid embedding them directly in manifests committed to Git.
* If image pulls are central to your platform, consider a mirrored internal registry or another registry strategy to
  reduce external dependency and rate-limit risk.

### Kubernetes tips and tricks

* Do not treat infrastructure creation and Kubernetes bootstrap as the same concern; automate both separately.
* Verify the Hetzner Cloud Controller Manager and CSI driver compatibility with your Kubernetes version.
* Use private networking for east-west traffic and limit public exposure to ingress or load balancers.
* Plan node replacement and upgrade procedures before production; self-managed clusters require operational discipline.
* For smaller workloads, `k3s` is often easier than a heavier full-distribution cluster.
* Keep etcd, persistent volume backup, and disaster recovery procedures documented and tested.

### When Hetzner Kubernetes is a good fit

Hetzner Cloud works especially well when you want cost-efficient infrastructure and you are comfortable managing more of
the Kubernetes operational stack yourself. If your team wants the cloud provider to handle more of the cluster control
plane lifecycle, a first-party managed Kubernetes platform from another provider may be simpler.

## See also

* [Hetzner Cloud](https://www.hetzner.com/cloud)
* [Hetzner Cloud API Documentation](https://docs.hetzner.cloud/)
* [Hetzner Cloud CLI](https://github.com/hetznercloud/cli)
* [Terraform](terraform.html)
* [Kubernetes (K8s)](kubernetes.html)
