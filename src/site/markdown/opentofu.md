# OpenTofu

## Information

### Introduction

[OpenTofu](https://opentofu.org/) is an open-source infrastructure as code (`IaC`) tool for provisioning and managing
cloud, network, platform, and Kubernetes resources.

It is a community-driven fork of `Terraform` and is designed to remain compatible with many existing `Terraform`
workflows, providers, modules, and `HCL` configurations.

In practice, `OpenTofu` is used in a very similar way to `Terraform`: define infrastructure declaratively, create a
plan, review the changes, and apply them to the target environment.

### Key Features

* **Infrastructure as Code:** Infrastructure is declared in `HCL`, versioned in `Git`, and reviewed like application
  code.
* **Execution Plans:** `OpenTofu` shows what will change before infrastructure is created, updated, or destroyed.
* **Provider Ecosystem:** It can work with many providers and APIs, including `AWS`, `Google Cloud`, `Azure`,
  `Kubernetes`, `Cloudflare`, `Hetzner`, `DigitalOcean`, `OpenStack`, and others.
* **Module Reuse:** Reusable modules make it easier to standardize `VPC`, `VPS`, `Kubernetes`, firewall, and database
  setups across environments.
* **State Management:** Infrastructure state helps `OpenTofu` track real resources and perform safe incremental
  changes.

## Installation

### Windows

Install `OpenTofu` from the official instructions or package manager for your environment.

### Linux

Install `OpenTofu` from the official package repository or by downloading a release from the project site.

For current installation instructions, see the official documentation:

* [OpenTofu install documentation](https://opentofu.org/docs/intro/install/)

## What is it for?

Typical `OpenTofu` use cases include:

* defining infrastructure declaratively
* provisioning `VPS`, virtual machines, and cloud services
* managing networks, subnets, routers, and firewall rules
* creating and operating `Kubernetes` clusters
* managing DNS, load balancers, certificates, and storage
* automating infrastructure changes in `CI/CD` pipelines
* keeping infrastructure state consistent across teams and environments

## Step-by-Step Usage Pattern

The normal `OpenTofu` workflow is close to `Terraform`:

1. Define providers and resources in `HCL`.
2. Run `tofu init` to download providers and initialize the working directory.
3. Run `tofu plan` to review what will change.
4. Run `tofu apply` to create or update the infrastructure.
5. Run `tofu destroy` when you want to tear down temporary environments.

Typical commands:

```bash
tofu init
tofu plan
tofu apply
```

## Quick Start: What You Actually Need to Do

The current page describes what `OpenTofu` can manage, but in practice most people first want a minimal path to getting
something real up and running.

The shortest practical path is usually:

1. choose one provider such as `Hetzner`, `AWS`, `Google Cloud`, or `Azure`
2. create provider credentials in that platform
3. install `OpenTofu`
4. create a small project directory with `main.tf`
5. define one provider and one or two resources
6. run `tofu init`
7. run `tofu plan`
8. run `tofu apply`
9. verify the created server, network, firewall, or cluster in the provider console

In other words, `OpenTofu` itself does not create infrastructure magically. You still need:

* an account in the target provider
* credentials or API tokens
* a region or datacenter choice
* a small `HCL` configuration
* basic understanding of what resources you want to create first

For most teams, the best first exercise is not a full `Kubernetes` platform. Start with one of these:

* one `VPS`
* one firewall rule set
* one network with subnets
* one DNS record

## Minimal Project Structure

A very small `OpenTofu` project often starts like this:

```text
my-infra/
  main.tf
  variables.tf
  outputs.tf
  terraform.tfvars
```

For a first experiment, even just `main.tf` is enough.

## Minimal Example Workflow

Create a new directory, add a `main.tf`, and then run the standard workflow:

```bash
tofu init
tofu plan
tofu apply
```

After the resources exist, later changes usually follow the same pattern:

```bash
tofu plan
tofu apply
```

And when the environment is no longer needed:

```bash
tofu destroy
```

## Concrete Starter Examples

The examples below are intentionally small. They are not full production environments, but they show what you should
actually write to get started.

### Example 1. Simple `Hetzner` VPS

This is a good first example because it is small, practical, and easy to understand.

Before using it, you typically need:

* a `Hetzner Cloud` account
* an API token
* an existing SSH public key uploaded to `Hetzner`, or a separate `OpenTofu` resource for it

Example `main.tf`:

```hcl
terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

variable "hcloud_token" {
  type      = string
  sensitive = true
}

resource "hcloud_server" "web1" {
  name        = "web1"
  image       = "ubuntu-24.04"
  server_type = "cx22"
  location    = "nbg1"
  ssh_keys    = ["default"]
}

output "web1_ipv4" {
  value = hcloud_server.web1.ipv4_address
}
```

Typical flow:

1. create `terraform.tfvars` with `hcloud_token = "..."`
2. run `tofu init`
3. run `tofu plan`
4. run `tofu apply`
5. connect with `ssh` to the created server IP from the output

This is the fastest way to understand the `provider -> resource -> plan -> apply` model.

### Example 2. `AWS` Security Group for a Small Web Server

This example is useful when you first want to understand networking and firewall logic rather than a whole platform.

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow web and SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

This does not yet create a full instance, but it gives a concrete first step for understanding repeatable access rules.

In real environments, you would usually attach this security group to `EC2`, a load balancer, or other networked
resources.

### Example 3. Small `AWS` VPC Skeleton

If your first goal is network setup, a tiny `VPC` skeleton is often more useful than jumping directly into `EKS`.

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "public-a"
  }
}
```

This gives you a simple base that can later be extended with:

* internet gateway
* route tables
* private subnets
* `NAT` gateway
* security groups
* compute instances or `Kubernetes`

## How to Move from Example to Real Setup

Once a minimal example works, the next practical step is usually:

1. move credentials out of hard-coded files into environment variables or secure secret handling
2. split configuration into `main.tf`, `variables.tf`, and `outputs.tf`
3. add separate values for `dev`, `test`, and `prod`
4. introduce remote state storage and state locking when working in a team
5. convert repeated resource groups into reusable modules

For example, a realistic growth path is:

* first one `VPS`
* then one firewall and DNS record
* then a full network module
* then a database or load balancer
* then a managed `Kubernetes` cluster

## Practical Tips for Getting Up and Running Faster

If the goal is to get something working quickly, these tips help:

* start with one provider, not all providers at once
* start with one small resource type before building a complete platform
* use provider examples from official documentation and adapt them gradually
* keep the first run disposable so `tofu destroy` is safe to use
* verify after each step in both `tofu plan` output and the provider web console
* avoid putting secrets directly into committed files
* use modules only after you understand the plain resource version first

## Common First Real-World Setups

Typical first useful projects with `OpenTofu` are:

* a single public `VPS` with SSH and web ports open
* a cloud network with public and private subnets
* DNS records for one application
* a firewall baseline shared by all environments
* a managed `Kubernetes` cluster skeleton

These are generally much better first targets than trying to automate everything in one go.

## How to Set Up Different Things with OpenTofu

`OpenTofu` is suitable for many kinds of infrastructure provisioning. Common examples include:

### 1. VPS and Virtual Machines

Typical targets:

* `AWS EC2`
* `Google Compute Engine`
* `Azure Virtual Machines`
* `DigitalOcean Droplets`
* `Hetzner Cloud Servers`
* `OpenStack` virtual machines

Typical resources managed around a `VPS`:

* machine instance or droplet
* SSH keys
* security groups or firewall rules
* public IP addresses
* block storage volumes
* DNS records

This makes `OpenTofu` useful for small single-server setups as well as larger multi-node environments.

### 2. Kubernetes Clusters

Typical targets:

* `AWS EKS`
* `Google GKE`
* `Azure AKS`
* self-managed clusters on `VPS` or bare metal

Typical resources around `Kubernetes`:

* `VPC` or virtual network
* subnets
* node pools
* load balancers
* DNS
* managed identities / `IAM`
* ingress controller related infrastructure

`OpenTofu` is often used to provision the base cluster and surrounding cloud infrastructure, while cluster workloads
are deployed later with `Helm`, `kubectl`, `Argo CD`, or similar tools.

### 3. Networks

Typical network-related setups include:

* `VPC` / virtual networks
* subnets for public and private workloads
* route tables
* internet gateways and `NAT` gateways
* peering and private connectivity
* DNS zones and records

This is one of the strongest `IaC` use cases because network design is easier to review in code than by clicking in
cloud consoles.

### 4. Firewalls and Access Rules

Typical security-related setups include:

* security groups in `AWS`
* firewall rules in `Google Cloud`
* network security groups in `Azure`
* cloud firewall policies in `Hetzner`, `DigitalOcean`, or other providers
* IP allowlists for office or partner access
* ingress rules for `HTTP`, `HTTPS`, `SSH`, `VPN`, database, and internal service ports

This is especially useful when you need repeatable policies across `dev`, `test`, and `prod` environments.

## Example Provider Scenarios

Below are typical ways `OpenTofu` is used across major providers.

### AWS

Common `AWS` targets with `OpenTofu`:

* `EC2` for virtual machines
* `VPC`, subnets, route tables, and gateways for networking
* security groups and network ACLs for access control
* `EKS` for managed `Kubernetes`
* `RDS`, `S3`, and load balancers for surrounding application infrastructure

Typical scenario:

* create a `VPC`
* add public and private subnets
* create security groups
* provision `EC2` instances or an `EKS` cluster
* attach DNS and load balancer resources

### Google Cloud

Common `Google Cloud` targets with `OpenTofu`:

* `Compute Engine` for virtual machines
* `VPC` networks and subnets
* firewall rules
* `GKE` for managed `Kubernetes`
* `Cloud DNS`, persistent disks, and load balancing

Typical scenario:

* create a custom `VPC`
* define subnets and firewall rules
* provision `Compute Engine` instances or `GKE`
* expose applications with cloud load balancing

### Azure

Common `Azure` targets with `OpenTofu`:

* resource groups
* virtual networks and subnets
* network security groups
* `Azure Virtual Machines`
* `AKS` for managed `Kubernetes`
* `Azure DNS`, public IPs, and load balancers

Typical scenario:

* create a resource group
* define the virtual network and subnets
* attach network security groups
* provision `VM`s or an `AKS` cluster
* expose applications through public IP and load balancer configuration

### Other Providers

`OpenTofu` is also practical for:

* `Hetzner Cloud` for affordable `VPS` and private networking
* `DigitalOcean` for smaller cloud environments and developer-friendly setups
* `Cloudflare` for DNS, tunnels, and edge-related configuration
* `OpenStack` for private cloud environments
* `VMware`-based environments in enterprise infrastructure

This makes it a good choice when the same team needs one `IaC` workflow across public cloud, private cloud, and hybrid
infrastructure.

## Practical Infrastructure Patterns

### VPS + Firewall + DNS

A common starter pattern is:

1. provision one or more virtual machines
2. attach SSH keys
3. open only required firewall ports such as `22`, `80`, and `443`
4. allocate a public IP
5. create DNS records pointing to the host

This works well for simple web applications, reverse proxies, and smaller backend services.

### Kubernetes + Ingress + IP Restrictions

Another common pattern is:

1. provision a managed `Kubernetes` cluster
2. create networking and node pools
3. install an ingress controller or cloud-native load balancer integration
4. restrict access with cloud firewall rules, security groups, or provider-specific policies
5. point DNS records to the ingress or load balancer

This is useful for APIs, web applications, and internal platforms.

### Reusable Modules per Environment

Teams often create reusable modules for:

* base network
* `VPS` or compute instances
* `Kubernetes` cluster
* firewall and security baseline
* DNS and certificates

Then they apply the same modules to `dev`, `test`, and `prod` with different variables.

## Relationship to Terraform

If you already know `Terraform`, the transition to `OpenTofu` is usually straightforward because:

* configuration style is similar
* many providers and modules are familiar
* the workflow still revolves around init, plan, and apply

This makes `terraform.md` directly useful as conceptual background also when working with `OpenTofu`.

## Similar Software

* **[Terraform](https://www.terraform.io/):** The original widely used infrastructure as code tool.
* **[Pulumi](https://www.pulumi.com/):** Infrastructure as code using general-purpose programming languages.
* **[Ansible](https://www.ansible.com/):** Automation and configuration management platform.

## See also

* [OpenTofu](https://opentofu.org/)
* [OpenTofu documentation](https://opentofu.org/docs/)
* [Terraform](https://www.terraform.io/)
* [Terraform](terraform.md)
* [Kubernetes](kubernetes.md)
* [AWS (Amazon Web Services)](aws.md)
* [Minikube](minikube.md)
