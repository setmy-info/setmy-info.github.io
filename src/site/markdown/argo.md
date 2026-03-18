# Argo Workflows

## Information

## Installation

```shell
ARGO_VERSION=4.0.2
kubectl create namespace argo
kubectl apply --server-side -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v${ARGO_VERSION}/quick-start-minimal.yaml

#?
kubectl patch deployment argo-server --namespace argo --type=json -p="[{\"op\":\"replace\",\"path\":\"/spec/template/spec/containers/0/args\",\"value\":[\"server\",\"--auth-mode=server\"]}]"
kubectl -n argo port-forward service/argo-server 2746:2746
# Trust in Firefox Self signed certs from https://127.0.0.1
firefox --new-tab https://localhost:2746

argo submit -n argo --watch https://raw.githubusercontent.com/argoproj/argo-workflows/main/examples/hello-world.yaml

argo list -n argo
argo get hello-world-2qvr7 -n argo
argo get  hello-world-zglf9 -n argo
argo logs @latest -n argo
argo logs hello-world-2qvr7 -n argo
argo logs hello-world-zglf9 -n argo
argo delete hello-world-2qvr7 hello-world-zglf9 -n argo

#Same with kubectl:
wget -c https://raw.githubusercontent.com/argoproj/argo-workflows/main/examples/hello-world.yaml -O hello-world.yaml
kubectl create -f hello-world.yaml
kubectl get pods -n argo
kubectl get wf -n argo
kubectl get wf hello-world-2qvr7 -n argo
kubectl get wf hello-world-zglf9 -n argo
kubectl get po --selector=workflows.argoproj.io/workflow=hello-world-2qvr7 -n argo
kubectl get po --selector=workflows.argoproj.io/workflow=hello-world-zglf9 -n argo
kubectl logs hello-world-2qvr7 -c main -n argo
kubectl logs hello-world-zglf9 -c main -n argo
kubectl delete wf hello-world-2qvr7 -n argo
kubectl delete wf hello-world-zglf9 -n argo
kubectl delete pods -n argo -l workflows.argoproj.io/completed=true

argo delete --completed --all-namespaces

# Re-setup
ARGO_VERSION=4.0.2
# TODO : notes about stop, delete, ..
kubectl create namespace argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v${ARGO_VERSION}/quick-start-minimal.yaml
```

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

**templates[n].nodeSelector** for selecting concrete node type (OS, platform) from K8s to run images

## See also

[Home](https://argoproj.github.io/argo-workflows/)

[Quick Start](https://argoproj.github.io/argo-workflows/quick-start/)

[Argo CLI](https://argoproj.github.io/argo-workflows/walk-through/argo-cli/)

[Argo & K8s secrets](https://argoproj.github.io/argo-workflows/walk-through/secrets/)

[Argo CLI](https://argoproj.github.io/argo-workflows/cli/argo/)

[xxx](https://nifi.apache.org/)

[xxx](https://oozie.apache.org/)

[xxx](yyyy)

[xxx](yyyy)
