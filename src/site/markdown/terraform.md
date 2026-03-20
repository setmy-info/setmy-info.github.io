# Terraform

## Information

### Introduction

[Terraform](https://www.terraform.io/) is an open-source infrastructure as code (IaC) software tool created by
Hashicorp.
Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp
Configuration Language (HCL), or optionally JSON.

### Key Features

* **Infrastructure as Code:** Infrastructure is described using a high-level configuration syntax. This allows a
  blueprint of your data center to be versioned and treated as you would any other code.
* **Execution Plans:** Terraform has a "planning" step where it generates an execution plan. The execution plan shows
  what Terraform will do when you call apply.
* **Resource Graph:** Terraform builds a graph of all your resources, and parallelizes the creation and modification
  of any non-dependent resources.
* **Change Automation:** Complex changesets can be applied to your infrastructure with minimal human interaction.

## Installation

### Windows (Chocolatey)

```powershell
choco install terraform
```

### Linux (Ubuntu/Debian)

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform
```

## Step-by-Step Guide: Setting up Kubernetes (K8s) Cluster

This guide provides a step-by-step approach to setting up a production-ready Kubernetes cluster on AWS and GCP using
Terraform, up to the point where it is ready for [Argo Workflows](argo.md).

### 1. AWS (Elastic Kubernetes Service - EKS)

#### A. Prerequisites & Registration

1. **Create an AWS Account:** Register at [aws.amazon.com](https://aws.amazon.com/).
2. **Install AWS CLI:** [Install guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
3. **Configure Credentials:** Run `aws configure` and provide your Access Key, Secret Key, and default region.
4. **IAM Permissions:** Ensure your user has sufficient permissions (AdministratorAccess is easiest for setup).

#### B. Terraform Configuration

Create a directory for your EKS project and add a `main.tf` file:

```hcl
provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.27"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    general = {
      desired_size = 2
      min_size     = 1
      max_size     = 3

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }
}
```

#### C. Deployment

```bash
terraform init
terraform plan
terraform apply
```

#### D. Verify Readiness for Argo WF

Update your `kubeconfig`:

```bash
aws eks update-kubeconfig --region eu-central-1 --name my-eks-cluster
kubectl get nodes
```

Your cluster is now ready for [Argo Workflows installation](argo.md#installation).

**Important:** To avoid unnecessary costs in AWS after your PoC, remember to shut down your cluster. See [AWS Cost Management](aws.md#managing-kubernetes-eks-costs).

---

### 2. Google Cloud (Google Kubernetes Engine - GKE)

#### A. Prerequisites & Registration

1. **Create a GCP Account:** Register at [cloud.google.com](https://cloud.google.com/).
2. **Create a Project:** In the GCP Console, create a new project (e.g., `my-k8s-project`).
3. **Enable APIs:** Enable the Compute Engine API and Kubernetes Engine API.
4. **Install Google Cloud SDK:** [Install guide](https://cloud.google.com/sdk/docs/install).
5. **Authenticate:** Run `gcloud auth application-default login`.

#### B. Terraform Configuration

Create a directory for your GKE project and add a `main.tf` file:

```hcl
provider "google" {
  project = "your-gcp-project-id"
  region  = "europe-west1"
}

resource "google_compute_network" "vpc" {
  name                    = "gke-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "gke-subnet"
  region        = "europe-west1"
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "europe-west1-b"

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "my-node-pool"
  location   = "europe-west1-b"
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
```

#### C. Deployment

```bash
terraform init
terraform plan
terraform apply
```

#### D. Verify Readiness for Argo WF

Get cluster credentials:

```bash
gcloud container clusters get-credentials my-gke-cluster --zone europe-west1-b
kubectl get nodes
```

Your cluster is now ready for [Argo Workflows installation](argo.md#installation).

---

## Step-by-Step Guide: Exposing Applications and IP Whitelisting

When deploying a REST API and an Angular web SPA to a Kubernetes cluster, you need to expose them to the internet while ensuring security. A common approach is to use an **Ingress Controller** with a **Load Balancer**.

To restrict access to specific companies with fixed IP addresses, you can use **IP Whitelisting**.

### 1. AWS (Using AWS Load Balancer Controller)

In AWS, the recommended way is to use the **AWS Load Balancer Controller**, which provisions an Application Load Balancer (ALB).

#### A. Install AWS Load Balancer Controller (Terraform)

You can use the `helm_release` resource to install the controller:

```hcl
resource "helm_release" "aws_lb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
}
```

#### B. Ingress Configuration with IP Whitelisting

Use the `alb.ingress.kubernetes.io/inbound-cidrs` annotation to specify the allowed IP ranges (whitelisting).

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app-ingress
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    # IP Whitelisting: Only these IPs can access the app
    alb.ingress.kubernetes.io/inbound-cidrs: "203.0.113.0/24, 1.2.3.4/32"
spec:
  rules:
    - http:
        paths:
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: rest-api-service
                port:
                  number: 80
          - path: /
            pathType: Prefix
            backend:
              service:
                name: angular-spa-service
                port:
                  number: 80
```

### 2. Google Cloud (Using GKE Ingress & Cloud Armor)

In GCP, the GKE Ingress controller uses Google Cloud Load Balancing (GCLB). For IP whitelisting, you should use **Google Cloud Armor**.

#### A. Terraform: Cloud Armor Security Policy

Create a security policy that denies all traffic except for the whitelisted IPs:

```hcl
resource "google_compute_security_policy" "policy" {
  name = "allow-fixed-ips"

  # Default rule: Deny all
  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default deny rule"
  }

  # Whitelist rule: Allow specific companies
  rule {
    action   = "allow"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["203.0.113.0/24", "1.2.3.4/32"]
      }
    }
    description = "Allow whitelisted IPs"
  }
}
```

#### B. Link Cloud Armor to Ingress (Kubernetes)

1. Create a `BackendConfig` in K8s to reference the Cloud Armor policy:

```yaml
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: my-backend-config
spec:
  securityPolicy:
    name: "allow-fixed-ips"
```

2. Annotate your **Service** to use the `BackendConfig`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: rest-api-service
  annotations:
    cloud.google.com/backend-config: '{"default": "my-backend-config"}'
spec:
  type: NodePort
  ...
```

3. Your **Ingress** will then automatically use the Cloud Armor policy via the linked services.

## See also

* [Terraform Documentation](https://www.terraform.io/docs)
* [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Terraform Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
* [Kubernetes](kubernetes.md)
* [Argo Workflows](argo.md)
* [Minikube](minikube.md)
* [AWS (Amazon Web Services)](aws.md)
