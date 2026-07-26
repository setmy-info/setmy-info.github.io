# Scaleway

## Information

### Introduction

[Scaleway](https://www.scaleway.com/) is a leading European cloud provider offering a wide range of infrastructure
services, including virtual instances, bare metal servers, managed Kubernetes, and object storage. It is known for its
strong presence in Europe (with data centers in Paris, Amsterdam, and Warsaw) and its commitment to sustainable and
sovereign cloud solutions.

### Main Functionalities and Features

* **Instances:** Scalable virtual machines (VCPU) for various workloads.
* **Elastic Metal:** Dedicated physical servers with cloud-like flexibility.
* **Kubernetes (Kapsule & Kosmos):** Managed Kubernetes services for container orchestration.
* **Managed Databases:** Fully managed PostgreSQL, MySQL, and Redis instances.
* **Object Storage:** S3-compatible storage for large amounts of data.
* **Serverless:** Functions and Containers for event-driven architectures.
* **Networking:** Private networks, load balancers, and VPC support.

### Common Use Cases

* Hosting web applications and APIs in European data centers for GDPR compliance and low latency.
* Running containerized workloads using managed Kubernetes (Kapsule).
* High-performance computing and data processing using Elastic Metal servers.
* Building scalable and resilient storage solutions with Object Storage.
* Hybrid and multi-cloud deployments using Kosmos to manage nodes outside Scaleway.

### Registration

To start using Scaleway, register at:

* [Scaleway Console](https://console.scaleway.com/)

Typical registration flow:

1. **Create an account:** Provide your email and set a password.
2. **Verify email:** Confirm your account through the verification link.
3. **Complete profile:** Provide contact and billing information.
4. **Identity verification:** You may need to provide identification documents for security and compliance.
5. **Add payment method:** A valid credit/debit card is required to activate the account.

## CLI

Scaleway provides a powerful command-line interface called `scw` to manage your resources.

* [Scaleway CLI GitHub](https://github.com/scaleway/scaleway-cli)

## Installation

### Install Scaleway CLI (`scw`)

#### macOS (Homebrew)

```bash
brew install scaleway
```

#### Linux

```bash
curl -s https://raw.githubusercontent.com/scaleway/scaleway-cli/master/scripts/get.sh | sh
```

#### Windows (Scoop)

```powershell
scoop install scw
```

### Configuration

After installation, initialize the CLI and follow the prompts to authenticate:

```bash
scw init
```

You will need an **Access Key** and a **Secret Key**, which you can generate in the Scaleway Console under **Identity
and Access Management (IAM) > API Keys**.

## Usage, tips and tricks

### Basic Commands

```bash
# List all instances
scw instance server list

# Create a new instance
scw instance server create type=DEV1-S image=ubuntu_focal name=my-server

# List managed Kubernetes clusters
scw k8s cluster list
```

### Practical Tips

* **IAM:** Use IAM users and policies to manage access instead of sharing root API keys.
* **Project Management:** Use Scaleway Projects to isolate resources for different environments (e.g., prod, staging,
  dev).
* **VPC:** Leverage Private Networks for secure communication between your instances and databases.
* **Object Storage:** Use the S3-compatible API with standard tools like `rclone` or `aws-cli` (with a custom endpoint).

## See also

* [Scaleway Documentation](https://www.scaleway.com/en/docs/)
* [Scaleway API Documentation](https://developers.scaleway.com/)
* [Terraform Scaleway Provider](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs)
* [AWS](aws.md)
* [Hetzner Cloud](hetzner-cloud.md)
