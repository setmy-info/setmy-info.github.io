# Kubernetes (k8s)

## Preparations

```sh
egrep --color 'vmx|svm' /proc/cpuinfo
```

## Installation

### kubectl CLI installation

```sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
```

### minikube installation

```sh
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo cp minikube /usr/local/bin && rm minikube
```

OR

```sh
cat <<EOF > /etc/yum.repos.d/antonpatsev-minikube-rpm-epel-7.repo
[antonpatsev-minikube-rpm]
name=Copr repo for minikube-rpm owned by antonpatsev
baseurl=https://copr-be.cloud.fedoraproject.org/results/antonpatsev/minikube-rpm/epel-7-$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/antonpatsev/minikube-rpm/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOF
yum install -y minikube-rpm

minikube start --vm-driver=none
```

Install

## Usage, tips and tricks

```sh
kubectl config set-credentials USERNAME --token=USERTOKEN
kubectl config set-cluster CLUSTERNAME --server=https://URL --insecure-skip-tls-verify=true
kubectl config set-context CONTEXTNAME --cluster=CLUSTERNAME --user=USERNAME
kubectl --context=CONTEXTNAME cluster-info

kubectl config use-context context-xyz

kubectl apply -f xyz-secrets.yml
kubectl apply -f xyz-configmap.yml
kubectl apply -f xyz-service.yml
kubectl apply -f xyz-deployment.yml

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
kubectl config view --minify
    # kubectl config view --minify --output 'jsonpath={..namespace}'; echo
kubectl config set-context --current --namespace=NAMESPACE


```

## See also

[Kubernetes](https://kubernetes.io)

[kubectl installation](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

[minikube](https://kubernetes.io/docs/setup/minikube/)
