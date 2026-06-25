# Apache ZooKeeper

## Information

`Apache ZooKeeper` is a centralized coordination service for distributed systems.

It is used to manage configuration information, naming, synchronization, leader election, and other coordination tasks
for clustered applications.

### What is it for?

Typical `ZooKeeper` use cases include:

* distributed coordination and cluster state management
* leader election
* service naming and discovery
* configuration storage for clustered systems
* distributed locks and synchronization primitives

## Usage

`ZooKeeper` has traditionally been used with systems such as `Apache Kafka`, `HBase`, `Solr`, and custom distributed
Java systems. In newer stacks, some of its historical roles are often replaced by `etcd`, `Consul`, or built-in
coordination layers in newer platforms.

## Similar Software

* **[etcd](etcd.md):** Strongly consistent distributed key-value store.
* **[HashiCorp Consul](consul.md):** Service discovery and distributed configuration platform.
* **[Apache Curator](https://curator.apache.org/):** Client framework often used on top of `ZooKeeper`.

## See also

* [Apache ZooKeeper](https://zookeeper.apache.org/)
* [Apache Kafka](kafka.md)
* [Java](java.md)
* [Microservices](microservices.md)
