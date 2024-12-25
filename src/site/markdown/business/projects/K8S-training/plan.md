# Plan

## Agenda

## Overview

## Installation

## API Creation

C:\sources\setmy.info\incubation\k8s-training

```sh
mkdir k8s-training
cd k8s-training

# Win
py -m venv ./.venv
# *nix
python -m venv ./.venv

# Win
.\.venv\Scripts\activate
# *nix
source ./.venv/bin/activate
# deactivate

python -m pip install --upgrade pip

pip install fastapi
pip install uvicorn
# Or
pip install -r requirements.txt
```

Or **requirements.txt**

```text
annotated-types==0.7.0
anyio==4.6.2.post1
click==8.1.7
colorama==0.4.6
fastapi==0.115.4
h11==0.14.0
idna==3.10
pydantic==2.9.2
pydantic_core==2.23.4
sniffio==1.3.1
starlette==0.41.2
typing_extensions==4.12.2
uvicorn==0.32.0
```

PyCharm

**app/main.py**

```python
from fastapi import FastAPI
import os
from datetime import datetime

LOG_DIR_PATH = "/mnt/data"
LOG_FILE_PATH = os.path.join(LOG_DIR_PATH, "request_log.txt")

app = FastAPI()


@app.get("/")
def read_root():
    k8s_variables = {key: value for key, value in os.environ.items() if key.startswith("K8S")}

    timestamp = datetime.now().isoformat()
    pod_name = os.environ.get("K8S_POD_NAME")
    log_file_name = f"{pod_name}_request_log.txt" if pod_name else "default_request_log.txt"
    log_file_path = os.path.join(LOG_DIR_PATH, log_file_name)
    if os.path.isdir(LOG_DIR_PATH):
        with open(log_file_path, "a") as log_file:
            log_file.write(f"{timestamp} - {k8s_variables}\n")

    return k8s_variables
```

```sh
# Win
set K8S_CONFIG=abcd
set K8S_SECRET=abcd1234
# *nix
export K8S_CONFIG=abcd
export K8S_SECRET=abcd1234
uvicorn app.main:app --reload --port 8111
```

http://127.0.0.1:8111
http://127.0.0.1:8111/docs

## Docker

```Dockerfile
FROM python:3.12

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app /code/app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8111"]
```

```sh
docker build -t labseeker/k8s-training .
```

```sh
docker run -p 8222:8111 -e K8S_CONFIG=abcd -e K8S_SECRET=abcd1234 -t labseeker/k8s-training
```

## Docker hub

* Register to Docker Hub.
* Get Access token R/W/D.

Login

```sh
docker login -u labseeker
```

Push image

```sh
docker push labseeker/k8s-training:latest
```

## Minikube

```sh
minikube start
```

## Namespaces

* Create ns creation yaml.
* Make kubectl use new ns as default.
* Create another ns with cli only, without yaml
* Make it default.
* Check ~/.kube/config file changes

```sh
kubectl apply -f ./k8s/namespace.yaml
kubectl config set-context --current --namespace=training
```

## Configuration map

* Create yaml for config map.
* Check the content.

```sh
kubectl apply -f ./k8s/config.yaml
kubectl get configmaps
kubectl describe configmaps training-config-map
```

## Secrets map

* Create yaml for secrets.
* Check the content.

```sh
kubectl apply -f ./k8s/secrets.yaml
kubectl get secret
kubectl describe secret training-secrets-map
```

## Volume

* Create yaml for volume.
* Check the content.

```sh
kubectl apply -f ./k8s/pv.yaml
kubectl get pv
kubectl describe pv training-persistent-volume
```

## Volume claims

* Create yaml for volume claim.
* Check the content.

```sh
kubectl apply -f ./k8s/pvc.yaml
kubectl get pvc
kubectl describe pvc training-persistent-volume-claim
```

## Deployment

* Create yaml for deployment.
* Check the content.

```sh
kubectl apply -f ./k8s/deployment.yaml
kubectl get pods
kubectl get deployment
kubectl describe deployment training-deployment
kubectl logs -f training-deployment-7d78d4c46c-mc6mp
kubectl port-forward training-deployment-7d78d4c46c-mc6mp 8222:8111
kubectl exec -it training-deployment-7d78d4c46c-mc6mp -- /bin/sh
# Stop
kubectl delete deployment training-deployment
```

## Service

* Create yaml for service.
* Check the content.

POD-NAME.SERVICE-NAME.NAMESPACE.svc.cluster.local

```sh
kubectl apply -f ./k8s/service.yaml
kubectl get service
kubectl describe service training-service
kubectl get endpoints training-service
kubectl port-forward svc/training-service 8111:8111
```

http://127.0.0.1:8222
http://localhost:8001/api/v1/namespaces/training/pods

## Ingress

*
* Create yaml for ingress.
* Check the content.

```sh
minikube addons enable ingress
kubectl apply -f ./k8s/ingress.yaml
kubectl get ingress
kubectl describe ingress training-ingress
minikube tunnel
```

## Argo

Install Argo CLI.

```sh
set ARGO_WORKFLOWS_VERSION="v3.5.12"
kubectl apply -n argo -f "https://github.com/argoproj/argo-workflows/releases/download/%ARGO_WORKFLOWS_VERSION%/quick-start-minimal.yaml"
kubectl -n argo port-forward service/argo-server 2746:2746
kubectl apply -f argo/role.yaml
kubectl apply -f argo/account.yaml
kubectl get rolebindings -n training
argo submit argo/argo.yaml
```

## Usage, tips and tricks

## See also

* [K8S](https://setmy-info.github.io/src/site/markdown/kubernetes.html)
* [NS](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
* [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/)
* [Secret](https://kubernetes.io/docs/concepts/configuration/secret/)
* [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
* [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
* [Cluster](https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/)
* [Similar video](https://www.youtube.com/watch?v=XltFOyGanYE)
