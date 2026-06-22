# Ceph

`Ceph` is an open-source distributed storage platform that provides object, block, and file storage from one broader
storage system.

Website:

* [ceph.io](https://ceph.io/)
* [Ceph documentation](https://docs.ceph.com/)

## Information

`Ceph` is often chosen when teams need scalable storage with strong flexibility across several access models.

It is relevant for:

* infrastructure platforms,
* `OpenStack` environments,
* `Kubernetes` storage backends,
* object storage services,
* private cloud storage,
* large on-premise or hybrid storage clusters.

### Main functionalities and features

* **Object storage**: `RADOS Gateway` can expose object storage interfaces,
* **Block storage**: `RBD` is often used for virtual machines and containers,
* **File storage**: `CephFS` provides distributed file system capabilities,
* **Scale-out design**: built for distributed clusters,
* **Self-healing orientation**: designed for replication and recovery behavior,
* **Open ecosystem**: commonly integrated with other open infrastructure stacks.

### Important concepts

#### RADOS

`RADOS` is the underlying distributed object store foundation of `Ceph`.

#### RBD

`RBD` provides block devices that are commonly consumed by virtualization or container platforms.

#### CephFS

`CephFS` exposes a distributed file system when a shared file-oriented access model is needed.

#### RADOS Gateway

The gateway exposes object storage access, often with `S3`-compatible patterns in practical environments.

## When it can be useful

`Ceph` can be a strong fit when:

* you need one storage platform for several access styles,
* storage should scale horizontally,
* the environment is open-infrastructure oriented,
* workloads include `VM`, container, and object-storage needs,
* teams are ready for serious storage operations.

Typical use cases:

* `OpenStack` block and object storage,
* `Kubernetes` dynamic volumes,
* internal object storage,
* large distributed storage clusters,
* infrastructure platforms that need flexibility instead of only one storage interface.

## Getting started

For a practical first step:

1. define whether the real need is object, block, file, or a combination,
2. start with a small lab or non-critical environment,
3. validate hardware, networking, and failure-domain design,
4. test performance, replication, recovery, and operational procedures,
5. document ownership for upgrades, balancing, capacity, and incident handling.

Early evaluation questions:

* which access type matters most,
* what failure tolerance is required,
* how many nodes and disks are realistic,
* what latency and throughput targets exist,
* how backup and disaster recovery work,
* whether the team is prepared for storage-platform operations.

## Tips and tricks

* Treat `Ceph` as a storage platform, not a quick checkbox feature.
* Keep hardware, network, and capacity design explicit from the beginning.
* Validate recovery and rebalance behavior, not only happy-path throughput.
* Separate experimental and production expectations.
* Monitor storage health, latency, capacity growth, placement behavior, and recovery pressure continuously.
* Use it where its flexibility matters; avoid unnecessary complexity for small simple environments.

## Things to watch

* `Ceph` can be excellent, but it is not lightweight to operate.
* Storage failures surface under pressure, so design and testing quality matter.
* Performance depends heavily on hardware, network, and workload profile.
* Capacity planning and repair workflows should be rehearsed before production dependence grows.

## Where it fits best

`Ceph` fits best for:

* larger open infrastructure platforms,
* private cloud storage,
* environments that need object, block, and file capabilities,
* teams with strong operational discipline.

It is less ideal when:

* storage needs are small and simple,
* the team lacks storage operations ownership,
* a simpler managed storage option is acceptable.

## See also

* [OpenStack](openstack.md)
* [Kubernetes](kubernetes.md)
* [MinIO](minio.md)
* [Terraform](terraform.md)
* [Ceph](https://ceph.io/)
