# Cloud

## Information

Cloud computing is the on-demand delivery of IT resources — compute, storage, databases, networking, software — over
the internet with pay-as-you-go pricing. Instead of owning and operating physical infrastructure, organizations
provision resources from cloud providers.

### Service Models

| Model    | Description                                                           | Examples                              |
|----------|-----------------------------------------------------------------------|---------------------------------------|
| **IaaS** | Infrastructure as a Service — raw compute, storage, networking        | AWS EC2, Azure VMs, GCP Compute       |
| **PaaS** | Platform as a Service — managed runtime, databases, middleware        | AWS Elastic Beanstalk, Heroku, GCP App Engine |
| **SaaS** | Software as a Service — fully managed application                     | Gmail, Salesforce, GitHub             |
| **FaaS** | Function as a Service — event-driven serverless execution             | AWS Lambda, Azure Functions, GCP Cloud Functions |

### Deployment Models

* **Public cloud** — resources shared across tenants, operated by the provider (AWS, Azure, GCP).
* **Private cloud** — dedicated infrastructure operated by or for a single organization.
* **Hybrid cloud** — combination of public and private cloud connected by network and APIs.
* **Multi-cloud** — using two or more public cloud providers, often to avoid vendor lock-in.

### Cloud Native

Cloud-native applications are designed from the ground up to run in cloud environments. They leverage:

* **Containers** — portable, lightweight deployment units (Docker, OCI).
* **Microservices** — small, independently deployable services with well-defined APIs.
* **CI/CD** — automated build, test, and deployment pipelines.
* **Dynamic orchestration** — workloads managed by platforms like Kubernetes that handle scaling, self-healing, and
  placement.
* **Observability** — metrics, logs, and traces as first-class concerns.

## Usage, tips and tricks

### 12-Factor App Principles

The [12-Factor App](https://12factor.net/) methodology defines principles for building portable, cloud-friendly
applications:

1. One codebase tracked in version control.
2. Explicitly declare and isolate dependencies.
3. Store config in environment variables.
4. Treat backing services as attached resources.
5. Separate build, release, and run stages.
6. Execute the app as stateless processes.
7. Export services via port binding.
8. Scale out via the process model.
9. Maximize robustness with fast startup and graceful shutdown.
10. Keep development, staging, and production as similar as possible.
11. Treat logs as event streams.
12. Run admin tasks as one-off processes.

### Cloud-First Strategy

A cloud-first strategy means evaluating cloud-hosted solutions before on-premises alternatives for new projects.
Considerations:

* Reduced infrastructure management overhead.
* Elastic scaling to match demand.
* Data sovereignty and residency requirements may constrain provider choice.
* Egress costs can be significant for data-heavy workloads.

### CNCF Landscape

The Cloud Native Computing Foundation (CNCF) maintains a landscape of cloud-native tools and projects categorized by
function: runtime, orchestration, observability, security, storage, etc.

## See also

* [AWS Cloud Native description](https://aws.amazon.com/what-is/cloud-native/)
* [Google Cloud Native description](https://cloud.google.com/learn/what-is-cloud-native)
* [MS Cloud Native description](https://learn.microsoft.com/en-us/dotnet/architecture/cloud-native/definition)
* [Oracle Cloud Native description](https://www.oracle.com/cloud/cloud-native/what-is-cloud-native/)
* [IBM Cloud Native description](https://www.ibm.com/topics/cloud-native)
* [Cloud-first definition CIO](https://cloud.cio.gov/strategy/)
* [Cloud-first PC Mag](https://www.pcmag.com/encyclopedia/term/cloud-first)
* [Cloud First](https://resources.boomi.com/resources/resources-library/cloud-first-what-does-it-mean-and-how-does-it-work)
* [12-Factor App](https://12factor.net/)
* [CNCF Landscape](https://landscape.cncf.io/)
