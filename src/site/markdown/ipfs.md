# IPFS

## Information

## Installation

### Windows

Download Kubo CLI

```shell
wget https://dist.ipfs.tech/kubo/v0.32.1/kubo_v0.32.1_windows-amd64.zip
```

Un-back to **C:\pub\kubo-0.32.1**

Add to **PATH**

## Configuration

## Usage, tips and tricks

### Init user environment and secrets

Only once

```shell
ipfs init
```

### Start serving node

```shell
ipfs daemon
```

### Operations

Some test contents:

* QmYNrtuvXECajriTPY89mcRjjYu17NEfW9NATQAKuHv8hY
* QmZhuP4Y7kjUwGrRWHbZ5k4YxCYGZkK2dHs81gAQW84Rmq
* QmaZcQpDQKmC8cBqkCZF4n84cJXmiQumPCfL7bDTSWEJZx

```shell
ipfs add ipfs.txt

ipfs get QmZhuP4Y7kjUwGrRWHbZ5k4YxCYGZkK2dHs81gAQW84Rmq

ipfs cat QmZhuP4Y7kjUwGrRWHbZ5k4YxCYGZkK2dHs81gAQW84Rmq

ipfs pin add QmYNrtuvXECajriTPY89mcRjjYu17NEfW9NATQAKuHv8hY
ipfs pin add QmZhuP4Y7kjUwGrRWHbZ5k4YxCYGZkK2dHs81gAQW84Rmq
ipfs pin add QmaZcQpDQKmC8cBqkCZF4n84cJXmiQumPCfL7bDTSWEJZx

ipfs pin ls

ipfs pin rm HASH
ipfs repo gc

ipfs files stat /ipfs/QmZhuP4Y7kjUwGrRWHbZ5k4YxCYGZkK2dHs81gAQW84Rmq

ipfs swarm peers
```

## See also

* [Kubo install](https://docs.ipfs.tech/how-to/kubo-basic-cli/#install-kubo)
* [Kubo CLI](https://docs.ipfs.tech/reference/kubo/cli/)
* [Java Client](https://github.com/ipfs-shipyard/java-ipfs-http-client)
