# Helm

## Information

`Helm` is a package manager for `Kubernetes`. It is used to define, install, upgrade, and manage applications with
reusable charts.

It helps teams package `Kubernetes` resources such as deployments, services, ingress rules, config maps, and secrets
into one versioned unit that can be installed in different environments with different values.

### What is it for?

Typical `Helm` use cases include:

* packaging and reusing `Kubernetes` application manifests
* installing third-party software into clusters
* managing configuration differences between `dev`, `test`, and `production`
* simplifying upgrades and rollbacks
* standardizing deployments across teams and environments

## Usage

`Helm` is commonly used in `Kubernetes` platforms where applications or infrastructure components need repeatable and
parameterized deployment. It is often used for both internal application charts and external components such as
`Ingress NGINX`, `Prometheus`, `Grafana`, databases, message brokers, and operators.

Typical workflow:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo nginx
helm install my-nginx bitnami/nginx
helm upgrade my-nginx bitnami/nginx
helm uninstall my-nginx
```

## Similar Software

* **[Kustomize](https://kustomize.io/):** Native `Kubernetes` configuration customization without a chart package model.
* **[OpenTofu](opentofu.md):** Infrastructure as code tool that can also provision `Kubernetes` resources and `Helm`
  releases.
* **[Ansible](ansible.md):** Automation tool that can deploy applications and infrastructure, including `Kubernetes`
  workloads.

## See also

* [Helm](https://helm.sh/)
* [Kubernetes](kubernetes.md)
* [Istio](istio.md)
* [OpenTofu](opentofu.md)
