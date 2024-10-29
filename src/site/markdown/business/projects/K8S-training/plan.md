# Plan

## Agenda

## Overview

## Installation

## API Creation

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

app = FastAPI()


@app.get("/")
def read_root():
    k8s_variables = {key: value for key, value in os.environ.items() if key.startswith("K8S")}
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

```sh
docker build -t imret/k8s-training .
```

```sh
docker run -p 8222:8111 -t imret/k8s-training
docker run -p 8222:8111 -e K8S_CONFIG=abcd -e K8S_SECRET=abcd1234 -t imret/k8s-training
docker run --name k8s-training -p 8222:8111 -e K8S_CONFIG=abcd -e K8S_SECRET=abcd1234 -t imret/k8s-training
```

## Docker

## Docker hub

## Namespaces

## Configuration map

## Secrets map

## Volume claims

## Volume

## Deployment

## Service

## Ingress

## Usage, tips and tricks

## See also

[xxxx](http://yyyyy)

https://setmy-info.github.io/src/site/markdown/kubernetes.html

Possible learning path (minikube):

1) Namespace creation
2) Config map creation
3) Secret creation (similal to configmap)
4) Volume and volume claims creation
5) Deployment creation (find some image with web page - perhaps gcr.io/google-samples/node-hello:1.0 ?)
6) Service creation
7) Ingress creation

https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
https://kubernetes.io/docs/concepts/configuration/configmap/
https://kubernetes.io/docs/concepts/configuration/secret/
https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
https://kubernetes.io/docs/concepts/services-networking/service/
https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/


Kubernetes course:
https://www.youtube.com/watch?v=XltFOyGanYE
FastAPI
