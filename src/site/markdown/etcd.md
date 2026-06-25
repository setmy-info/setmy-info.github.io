# etcd

## Information

`etcd` is a distributed, strongly consistent key-value store.

It is commonly used for configuration storage, service discovery, leader election, and cluster metadata in modern
distributed systems.

### What is it for?

Typical `etcd` use cases include:

* cluster state and control-plane metadata storage
* distributed configuration storage
* leader election and distributed locking
* service discovery and endpoint registration
* coordination for container and infrastructure platforms

## Usage

`etcd` is best known as a core dependency of `Kubernetes`, but it is also used directly in distributed applications and
platform engineering setups where strong consistency and simple key-value semantics are needed.

## Similar Software

* **[HashiCorp Consul](consul.md):** Service discovery and configuration platform with broader service networking focus.
* **[Apache ZooKeeper](zookeeper.md):** Older but still widely known coordination system for distributed platforms.
* **[NATS JetStream KV](https://docs.nats.io/nats-concepts/jetstream/key-value-store):** Key-value and
  coordination-style
  patterns with a different messaging-centered architecture.

## See also

* [etcd](https://etcd.io/)
* [Kubernetes](kubernetes.md)
* [OpenTofu](opentofu.md)
* [Terraform](terraform.md)
