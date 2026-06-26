# Zeebe

## Information

Zeebe is a cloud-native workflow engine for microservices orchestration, the core engine of Camunda 8. It is designed to
be horizontally scalable, fault-tolerant, and high-performance. Zeebe uses BPMN 2.0 to define workflows and gRPC for
client communication.

### Main Functionalities and Features

* **Scalability**: Horizontally scalable through partitioning.
* **Fault Tolerance**: Replicates logs across a cluster using the Raft consensus algorithm.
* **BPMN 2.0 Support**: Execute standard workflow diagrams directly.
* **Message Correlation**: Correlation of asynchronous messages to running process instances.
* **Language Agnostic**: Clients available in Java, Node.js, Python, Go, Rust, etc.
* **Reactive and Event-Driven**: High throughput and low latency.

## Installation

Zeebe requires Java (JRE 21+ recommended).

### CentOS, Rocky Linux

1. **Install Java**:
   ```bash
   sudo dnf install java-21-openjdk-devel
   ```
2. **Download and Install**:
   ```bash
   wget https://github.com/camunda/camunda/releases/download/8.5.0/zeebe-8.5.0.tar.gz
   sudo mkdir -p /opt/zeebe
   sudo tar -xvzf zeebe-8.5.0.tar.gz -C /opt/zeebe --strip-components=1
   ```

### Fedora

```bash
sudo dnf install java-21-openjdk-devel
# Then download and extract as above
```

### macOS

For most developers, Docker Desktop is the easiest way to run Zeebe locally on macOS.

If you want native CLI tooling such as `zbctl`, download the matching release binary from the Camunda releases page and
place it in your `PATH`.

### FreeBSD

```bash
pkg install openjdk21
# Download and extract tarball to /usr/local/share/zeebe
```

### OpenIndiana

```bash
pkg install jdk-21
# Download and extract tarball
```

## Setup with Docker for Developer

For local development, the quickest reliable setup is a single-node Zeebe broker. If you also want Operate, Tasklist,
Identity, and the other Camunda 8 components, prefer the official Camunda self-managed Docker Compose bundle because
those services need additional configuration.

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
    zeebe:
        image: camunda/zeebe:8.5.0
        container_name: zeebe-dev
        environment:
            - ZEEBE_BROKER_CLUSTER_PARTITIONSCOUNT=1
            - ZEEBE_BROKER_CLUSTER_REPLICATIONFACTOR=1
            - ZEEBE_BROKER_CLUSTER_CLUSTERSIZE=1
            - ZEEBE_BROKER_GATEWAY_ENABLE=true
        ports:
            - "26500:26500"
            - "9600:9600"
        volumes:
            - zeebe_data:/usr/local/zeebe/data

volumes:
    zeebe_data:
```

Start the stack:

```bash
docker-compose up -d
```

* **Zeebe Gateway**: `localhost:26500`
* **Metrics / management port**: `localhost:9600`

If you need Operate or the full Camunda 8 stack locally, use the official Camunda self-managed Docker Compose examples
instead of trying to wire only one or two components manually.

## CLI Tools (zbctl)

`zbctl` is the official CLI for interacting with Zeebe.

### Common Commands

* **Status**: `zbctl status --address localhost:26500`
* **Deploy**: `zbctl deploy my-process.bpmn`
* **Create Instance**: `zbctl create instance my-process --variables '{"orderId": 123}'`
* **Cancel Instance**: `zbctl cancel instance <INSTANCE_KEY>`

## Code Integration Examples

### Java Spring Boot

Using `spring-zeebe-starter`.

**Maven Dependency**:

```xml

<dependency>
    <groupId>io.camunda</groupId>
    <artifactId>spring-zeebe-starter</artifactId>
    <version>8.5.0</version>
</dependency>
```

**Application**:

```java

@SpringBootApplication
@EnableZeebeClient
public class MyZeebeApp {
    public static void main(String[] args) {
        SpringApplication.run(MyZeebeApp.class, args);
    }

    @ZeebeWorker(type = "process-payment")
    public void handlePayment(final JobClient client, final ActivatedJob job) {
        // Business logic here
        client.newCompleteCommand(job.getKey())
            .variables("{\"status\": \"paid\"}")
            .send().join();
    }
}
```

### JavaScript (Node.js)

Using `zeebe-node`.

```bash
npm install zeebe-node
```

```javascript
const {ZBClient} = require('zeebe-node');

const zbc = new ZBClient('localhost:26500');

zbc.createWorker({
    taskType: 'process-payment',
    taskHandler: (job) => {
        console.log(`Processing job ${job.key}`);
        job.complete({status: 'paid'});
    }
});
```

### Python

Using `pyzeebe`.

```bash
pip install pyzeebe
```

```python
import asyncio
from pyzeebe import ZeebeWorker, create_insecure_channel


async def main():
    channel = create_insecure_channel(hostname="localhost", port=26500)
    worker = ZeebeWorker(channel)

    @worker.task(task_type="process-payment")
    async def process_payment(orderId: int):
        print(f"Processing payment for {orderId}")
        return {"status": "paid"}

    await worker.work()


if __name__ == "__main__":
    asyncio.run(main())
```

## Usage, tips and tricks

### Simple Workflow Example (BPMN)

1. **Start Event**: Receive Order.
2. **Service Task**: "Process Payment" (Type: `process-payment`).
3. **End Event**: Order Completed.

Save as `order.bpmn` and deploy:

```bash
zbctl deploy order.bpmn
```

### In Docker manually

```shell
docker network create zeebe-network
docker run --name zeebe \
  -p 26500:26500 -p 9600:9600 \
  --network=zeebe-network \
  -e ZEEBE_BROKER_CLUSTER_PARTITIONSCOUNT=1 \
  -e ZEEBE_BROKER_CLUSTER_REPLICATIONFACTOR=1 \
  -e ZEEBE_BROKER_CLUSTER_CLUSTERSIZE=1 \
  -e ZEEBE_BROKER_GATEWAY_ENABLE=true \
  camunda/zeebe:8.5.0
```

For a real multi-node cluster, use the official Helm chart or official multi-node Docker examples. A Zeebe cluster needs
consistent broker IDs, cluster settings, networking, and persistent storage on every node.

### Docker compose

```yaml
version: '3'
services:
    zeebe:
        image: camunda/zeebe:8.5.0
        ports:
            - 26500:26500
            - 9600:9600
        environment:
            - ZEEBE_BROKER_CLUSTER_PARTITIONSCOUNT=1
            - ZEEBE_BROKER_CLUSTER_REPLICATIONFACTOR=1
            - ZEEBE_BROKER_CLUSTER_CLUSTERSIZE=1
            - ZEEBE_BROKER_GATEWAY_ENABLE=true
        volumes:
            - zeebe_data:/usr/local/zeebe/data

volumes:
    zeebe_data:
```

Start Zeebe locally

```shell
docker-compose up
# OR
docker-compose up -d
```

### Kubernetes (Self-Managed)

For Kubernetes, the recommended production-style path is the official Camunda Helm chart. A plain `StatefulSet` example
without services, persistent volumes, cluster settings, and identity/configuration is not enough for a correct live
installation.

```shell
minikube start
```

Typical flow:

```shell
helm repo add camunda https://helm.camunda.io
helm repo update
helm install camunda camunda/camunda-platform \
  --namespace camunda \
  --create-namespace
```

Then check the pods and services:

```shell
kubectl get pods -n camunda
kubectl get svc -n camunda
```

If you only want Zeebe for a local test cluster, disable the components you do not need in the Helm values file instead
of hand-writing an incomplete `StatefulSet`.

**Minimal example values (`values-zeebe-only.yaml`)**

```yaml
operate:
    enabled: false
tasklist:
    enabled: false
optimize:
    enabled: false
identity:
    enabled: false
connectors:
    enabled: false
webModeler:
    enabled: false
zeebeGateway:
    replicas: 1
zeebe:
    clusterSize: 1
    partitionCount: 1
    replicationFactor: 1
```

Install it with:

```shell
helm install camunda camunda/camunda-platform \
  --namespace camunda \
  --create-namespace \
  -f values-zeebe-only.yaml
```

### Live Environment Setup

For production, Zeebe should be run as a cluster (at least 3 nodes) with dedicated storage.

#### Storage Requirements

* **Disk**: Fast SSDs are mandatory for production throughput.
* **I/O**: Zeebe is an event-log based system; disk latency directly affects latency.
* **Replication**: Raft replication factor should be at least 3.
* **Persistent volumes**: Every broker needs its own persistent storage.
* **Networking**: Brokers must be able to resolve and reach each other consistently.

#### Rocky Linux (systemd service)

1. **Create User**:

```bash
sudo useradd --system --shell /sbin/nologin zeebe
sudo chown -R zeebe: /opt/zeebe
   ```

2. **Service**: `/etc/systemd/system/zeebe.service`

```ini
[Unit]
Description=Zeebe Broker
After=network.target

[Service]
User=zeebe
Group=zeebe
WorkingDirectory=/opt/zeebe
ExecStart=/opt/zeebe/bin/broker
Restart=always
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```

3. **Enable**:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now zeebe
```

### PostgreSQL as Zeebe Exporter

Zeebe does not use PostgreSQL as its primary broker state backend. Its broker state is stored in Zeebe's own log and
state storage.

If you need PostgreSQL in a Camunda 8 environment, it is usually for surrounding platform components or custom reporting
pipelines, not as a drop-in broker storage replacement. For export/reporting use cases, verify the exact exporter or
downstream pipeline you plan to use instead of assuming a built-in PostgreSQL backend.

## See also

[Camunda 8 Self-Managed documentation](https://docs.camunda.io/docs/self-managed/about-self-managed/)

[Camunda 8 Helm chart](https://artifacthub.io/packages/helm/camunda/camunda-platform)

[BPMN Draw online](https://demo.bpmn.io/new)

[flowable](https://github.com/flowable/flowable-engine)

[activiti](https://www.activiti.org/documentation)

[jbpm](https://www.jbpm.org/)
