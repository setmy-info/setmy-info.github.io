# Amazon Web Services (AWS)

## Information

### Introduction

[Amazon Web Services (AWS)](https://aws.amazon.com/) is a comprehensive, evolving cloud computing platform provided by
Amazon. It includes a mixture of infrastructure-as-a-service (IaaS), platform-as-a-service (PaaS), and packaged
software-as-a-service (SaaS) offerings.

### Registration

Registering for an AWS account is the first step to accessing its services.

1. **Visit AWS Website:** Go to [aws.amazon.com](https://aws.amazon.com/).
2. **Create an AWS Account:** Click on the "Create an AWS Account" button.
3. **Provide Information:** Enter your email address, password, and an AWS account name.
4. **Verify Email:** Follow the link sent to your email to verify it.
5. **Contact Information:** Provide your contact details (Personal or Business).
6. **Payment Information:** You must provide a credit or debit card. AWS will not charge you for the registration
   itself, but they may perform a small temporary authorization charge (usually $1) to verify the card.
7. **Identity Verification:** Confirm your identity via a phone call or SMS.
8. **Select Support Plan:** Choose the "Basic Support - Free" plan to avoid monthly support fees.
9. **Complete Sign Up:** Once completed, you can log in to the AWS Management Console.

**Note:** Simply having an account registered does not incur costs. You only pay for the services you use beyond
the [AWS Free Tier](https://aws.amazon.com/free/).

## Setup

### 1. Install AWS CLI

To interact with AWS from your command line, install the AWS CLI:

* **Windows:** Download and run the [AWS CLI MSI installer](https://awscli.amazonaws.com/AWSCLIV2.msi).
* **Linux/macOS:** Follow
  the [official installation guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

### 2. Configure AWS CLI

After installation, configure your credentials:

```bash
aws configure
```

You will be prompted for:

* **AWS Access Key ID**
* **AWS Secret Access Key**
* **Default region name** (e.g., `eu-central-1`)
* **Default output format** (e.g., `json`)

You can create Access Keys in the AWS Console under **IAM > Users > [Your User] > Security credentials**.

### 3. SSO Configuration

For organizations, it is common to use AWS SSO (IAM Identity Center):

```shell
aws configure sso --profile profilex
# SSO start URL [https://oursuperconpany.awsapps.com/start]:
# SSO Region [eu-central-1]:
# Select account from CLI menu

aws configure list-profiles
aws s3 ls --profile profilex
```

Example configuration file **~/.aws/config**:

```ini
[profile MyProfile-Developers]
sso_start_url = https://mycompany.awsapps.com/start
sso_region = eu-central-1
sso_account_id = 123456789012
sso_role_name = Developers

[default]
sso_start_url = https://mycompany.awsapps.com/start
sso_region = eu-central-1
region = eu-central-1
sso_account_id = 123456789012
sso_role_name = Developers
```

## Managing Kubernetes (EKS) Costs

If you have set up a Kubernetes cluster (EKS) for a Proof of Concept (PoC) as described in
the [Terraform guide](terraform.md), it is important to shut it down when not in use to avoid ongoing charges.

### Stopping the Cluster (Saving Money)

In AWS, EKS (Elastic Kubernetes Service) has two main cost components:

1. **Cluster Control Plane:** AWS charges ~$0.10 per hour for the managed control plane.
2. **Worker Nodes (EC2):** You pay for the EC2 instances running your workloads.

#### Option 1: Scaling Down (Partial Savings)

If you want to keep the cluster configuration but stop paying for the worker nodes, you can scale the node group to
zero.

**Using Terraform:**
Update your `main.tf`:

```hcl
  eks_managed_node_groups = {
    general = {
      desired_size = 0 # Set to 0
      min_size     = 0 # Set to 0
      max_size     = 3
      # ...
    }
  }
```

Then run:

```bash
terraform apply
```

**Note:** You will still be charged ~$0.10/hour for the EKS Control Plane.

#### Option 2: Destroying the Infrastructure (Total Savings)

To stop **all** charges related to your PoC, you must delete the resources. Since you used Terraform, this is easy.

```bash
terraform destroy
```

This command will:

1. Terminate all EC2 worker nodes.
2. Delete the EKS cluster control plane.
3. Delete the VPC, subnets, and NAT Gateways (NAT Gateways also cost money hourly!).

**Recommendation:** For a PoC, always `terraform destroy` when you are finished for the day. You can always
`terraform apply` again tomorrow to bring it back up in minutes.

## See also

* [AWS Documentation](https://docs.aws.amazon.com/)
* [Terraform K8s Setup](terraform.md)
* [Kubernetes (K8s)](kubernetes.md)
* [Argo Workflows](argo.md)
