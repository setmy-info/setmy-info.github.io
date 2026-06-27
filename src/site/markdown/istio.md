# Istio

## Information

`Istio` is a service mesh platform for managing traffic, security, and observability between services.

It is commonly used in `Kubernetes` and microservice environments to apply consistent networking policies, mutual
`TLS`, traffic routing, and telemetry without putting all of that logic directly into each application.

### What is it for?

Typical `Istio` use cases include:

* service-to-service traffic management
* mutual `TLS` between services
* retries, timeouts, circuit breaking, and fault injection
* ingress and east-west traffic control
* observability for service calls, latency, and errors

## Usage

`Istio` is typically used on top of `Kubernetes` when teams need a stronger service networking layer for
microservices. It is often chosen for environments that need secure service identity, policy enforcement, canary or
blue-green rollouts, and centralized control over traffic behavior across many services.

## Similar Software

* **[Linkerd](https://linkerd.io/):** Lightweight service mesh focused on simplicity and security.
* **[HashiCorp Consul](consul.md):** Service networking platform that also includes service mesh capabilities.
* **[Kuma](https://kuma.io/):** Service mesh built on `Envoy` for `Kubernetes` and virtual machines.

## See also

* [Istio](https://istio.io/)
* [Kubernetes](kubernetes.md)
* [Microservices](microservices.md)
* [HashiCorp Consul](consul.md)
