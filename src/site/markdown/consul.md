# HashiCorp Consul

## Information

`HashiCorp Consul` is a service networking, service discovery, and distributed configuration platform.

It is commonly used to register services, resolve service locations, perform health checks, distribute key-value
configuration, and support service-to-service communication in dynamic environments.

### What is it for?

Typical `Consul` use cases include:

* service discovery for microservices and infrastructure services
* health checking and removal of unhealthy service instances
* distributed key-value configuration storage
* service mesh features with `Consul Connect`
* multi-datacenter service networking and coordination

## Usage

`Consul` is often used in environments with `Nomad`, `Vault`, `Kubernetes`, virtual machines, or traditional
microservice deployments when teams need a central registry for services and a lightweight distributed coordination
layer.

## Similar Software

* **[etcd](etcd.md):** Distributed key-value store often used for cluster coordination and configuration.
* **[Apache ZooKeeper](zookeeper.md):** Coordination service for distributed systems.
* **[Eureka](https://github.com/Netflix/eureka):** Service registry from the Netflix OSS ecosystem.

## See also

* [HashiCorp Consul](https://developer.hashicorp.com/consul)
* [HashiCorp Vault](vault.md)
* [Kubernetes](kubernetes.md)
* [Microservices](microservices.md)
