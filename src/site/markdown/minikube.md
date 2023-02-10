# Minikube

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

```shell
mkdir -p ~/temp/minikube
cd ~/temp/minikube
wget -c https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube
chmod +x minikube
sudo install minikube /usr/local/bin/minikube
rm ./minikube
```

#### Alternative way

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
```

#### Reinstall

```shell
docker container stop minikube
docker container rm minikube
docker volume rm minikube
docker network rm minikube
minikube start
```

## Deinstall

```shell
kubectl get namespace
docker container list --all
docker container stop minikube
docker container rm minikube
docker volume rm minikube
docker network rm minikube
```

### FreeBSD

### OpenIndiana

## Configuration

Ports (minukube):

* 57030:22
* 57031:2376
* 57032:32443
* 57028:5000
* 57029:8443

## Start Minikube

```shell
minikube start
# minikube start --vm-driver=none
# minikube docker-env # ?
```

## Usage, tips and tricks

### Load image into K8s

```shell
minikube image rm gihub.io/ORGNAME/IMAGENAME:VERSION
minikube image load gihub.io/ORGNAME/IMAGENAME:VERSION --overwrite
# minikube cache add gihub.io/ORGNAME/IMAGENAME:VERSION (DEPRECATED)
# also in Argo: spec.templates.container.imagePullPolicy: Never
minikube image ls
minikube addons enable ingress
```

## See also

[Minikube](https://minikube.sigs.k8s.io)

[Quick start](https://minikube.sigs.k8s.io/docs/start/)

[Some docs](https://minikube.sigs.k8s.io/docs/)