# Zeebe

## Information

## Installation

### CentOS

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### In Docker manually

```shell
docker network create zeebe-network
docker run -p 26500:26500 --network=zeebe-network camunda/zeebe:latest broker
docker run -p 26501:26501 --network=zeebe-network camunda/zeebe:latest broker
docker run -p 26502:26502 --network=zeebe-network camunda/zeebe:latest broker
docker exec -e ZEEBE_LOG_LEVEL=debug -e ZEEBE_BROKER_CLUSTER_HOST=0.0.0.0 -e ZEEBE_BROKER_CLUSTER_PORT=26502 -e ZEEBE_BROKER_CLUSTER_CONTACTPOINT=broker:26502 -it <CONTAINER ID> broker
```

### Docker compose

```yaml
version: '3'
services:
    zeebe1:
        image: camunda/zeebe:latest
        ports:
            - 26500:26500
        networks:
            - zeebe-network
    zeebe2:
        image: camunda/zeebe:latest
        ports:
            - 26501:26501
        networks:
            - zeebe-network
    zeebe3:
        image: camunda/zeebe:latest
        ports:
            - 26502:26502
        networks:
            - zeebe-network

networks:
    zeebe-network:
```

Start Zeebe cluster

```shell
docker-compose up
# OR
docker-compose up -d
```

### Kubernetes

```shell
minikube start
```

**zeebe.yaml**

```yaml
apiVersion: v1
kind: Namespace
metadata:
    name: zeebe

---
apiVersion: apps/v1
kind: StatefulSet
metadata:
    name: zeebe
    namespace: zeebe
spec:
    serviceName: "zeebe-gateway"
    replicas: 3
    selector:
        matchLabels:
            app: zeebe
    template:
        metadata:
            labels:
                app: zeebe
        spec:
            containers:
                -   name: zeebe
                    image: camunda/zeebe:latest
                    ports:
                        -   containerPort: 26500
                            name: gateway
                            protocol: TCP
                        -   containerPort: 9600
                            name: monitoring
                            protocol: TCP

```

start zeebe:

```shell
kubectl apply -f zeebe.yaml
kubectl get pods -n zeebe
```

Or

**zeebe-cluster.yaml**

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
    name: zeebe-cluster
spec:
    serviceName: zeebe
    replicas: 3
    selector:
        matchLabels:
            app: zeebe
    template:
        metadata:
            labels:
                app: zeebe
        spec:
            containers:
                -   name: zeebe
                    image: camunda/zeebe:latest
                    ports:
                        -   containerPort: 26500
                            name: gateway
                        -   containerPort: 9600
                            name: monitoring
```

Start cluster

```shell
kubectl apply -f zeebe-cluster.yaml
```

### PostgreSQL as Zeebe backend

## See also

[BPMN DRaw online](https://demo.bpmn.io/new)

[flowable](https://github.com/flowable/flowable-engine)

[activiti](https://www.activiti.org/documentation)

[jbpm](https://www.jbpm.org/)
