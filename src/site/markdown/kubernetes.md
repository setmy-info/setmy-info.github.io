# Kubernetes (k8s)

## Preparations

```sh
egrep --color 'vmx|svm' /proc/cpuinfo
```

## Installation

### kubectl CLI installation

```sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
# cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
sudo yum install -y kubectl
```

Or:

```shell
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

## Usage, tips and tricks

User config file: **~/.kube/config**

```sh
kubectl config set-credentials USERNAME --token=USERTOKEN
kubectl config set-cluster CLUSTERNAME --server=https://URL --insecure-skip-tls-verify=true
kubectl config set-context CONTEXTNAME --cluster=CLUSTERNAME --user=USERNAME
kubectl --context=CONTEXTNAME cluster-info

kubectl config use-context context-xyz

# -n NAMESPACE can be appended
kubectl apply -f xyz-secrets.yml
kubectl apply -f xyz-configmap.yml
kubectl apply -f xyz-service.yml
kubectl apply -f xyz-deployment.yml

kubectl describe configmaps xyz-configmap
kubectl describe secret xyz-secrets

kubectl edit xyz-deployment
kubectl get pods
kubectl logs -f xyz-deployment-596744778-dcgtz
kubectl logs xyz-deployment-596744778-dcgtz -c containername --previous
kubectl describe pod xyz-deployment-596744778-dcgtz
kubectl delete pod xyz-deployment-596744778-dcgtz
kubectl proxy
kubectl port-forward xyz-deployment-596744778-dcgtz LOCALPORT:REMOTEPORT
kubectl exec -it xyz-deployment-596744778-dcgtz -- /bin/sh
kubectl get endpoints
kubectl get service

kubectl delete secrets xyz-secrets
kubectl delete configmap xyz-configmap
kubectl delete service xyz-service
kubectl delete deployment xyz-deployment

kubectl exec --stdin --tty some-pod-596744778-dcgtz -- /bin/bash

# Kubernetes config update
aws sso login
# Or
AWS_DEFAULT_PROFILE=profilex
aws sso login
aws eks update-kubeconfig --region REGION --name OURSUPERCLUSTER
# Like: aws eks update-kubeconfig --region eu-central-1 --name xyzcluster

kubectl get pods --all-namespaces
kubectl get namespaces
# kubectl get ns
kubectl get namespace
kubectl config view --minify
# kubectl config view --minify --output 'jsonpath={..namespace}'; echo
kubectl config set-context --current --namespace=NAMESPACE


```

## See also

[Kubernetes](https://kubernetes.io)

[kubectl installation](https://kubernetes.io/docs/tasks/tools/#kubectl)

[minikube](https://kubernetes.io/docs/setup/minikube/)

[kubectl cli usage](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)

[Deployment](https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/)

[Service](https://kubernetes.io/docs/concepts/services-networking/service/)

[Config maps](ttps://kubernetes.io/docs/concepts/configuration/configmap/)

[Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)

[xxxx](cccc)

[xxxx](cccc)

[xxxx](cccc)
