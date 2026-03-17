# Minikube

## Information

## Installation

### CentOS, Rocky Linux

```shell
sudo useradd minikube
sudo passwd minikube
sudo usermod -a -G docker minikube wheel
```

```shell
mkdir ~/temp && cd ~/temp && curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
sudo rpm -Uvh minikube-latest.x86_64.rpm
```

### Fedora

```shell
mkdir -p ~/temp/minikube
cd ~/temp/minikube
wget -c https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube
chmod +x minikube
sudo install minikube /usr/local/bin/minikube
rm ./minikube
```

### Windows

Download `https://storage.googleapis.com/minikube/releases/latest/minikube-installer.exe`

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
sudo usermod -a -G libvirt USERNAME
```

#### Reinstall

```shell
docker container stop minikube
docker container rm minikube
docker volume rm minikube
docker network rm minikube
minikube start
minikube dashboard
```

Minikube starting after reboot

```shell
export VISUAL=nano
sudo crontab -u minikube -e
```

    @reboot /usr/bin/minikube start

Remove

```shell
sudo crontab -r -u minikube
sudo crontab -l -u minikube
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
# For peristent volumes
# minikube start --mount --mount-string="/path/on/host:/path/on/minikube"
# minikube start --mount --mount-string="hostpath=/tank/peristent-volumes,nfs-server=YOUR_NFS_SERVER_IP,nfs-share=YOUR_NFS_SHARE"
# Mounted to Kubernetes host
# minikube start --mount --mount-string="hostpath=/tank/peristent-volumes,nfs-server=nfs.intra,nfs-share=/tank/nfs/peristent-volumes"
# Munted directly to virtual machine
# minikube start --mount --mount-string="type=nfs,source=nfs.intra:/tank/nfs/peristent-volumes,target=/tank/peristent-volume"
# minikube docker-env # ?
# Minikube klaster IP, use for services
minikube ip
minikube dashboard
#minikube dashboard &
# http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
# pgrep -f "minikube dashboard" | xargs kill
```

### Mounting host folders

To use a host folder (e.g., `/var/opt/setmy.info/gintra`) in a Minikube pod via `hostPath`, the folder must be
accessible within the Minikube virtual machine.

#### Option 1: Using `minikube start` with mount flag

```shell
minikube start --mount --mount-string="/var/opt/setmy.info/gintra:/var/opt/setmy.info/gintra"
```

#### Option 2: Using `minikube mount` command

While Minikube is running, use the `mount` command to map a host folder:

```shell
# In a separate terminal
minikube mount /var/opt/setmy.info/gintra:/var/opt/setmy.info/gintra
```

This makes `/var/opt/setmy.info/gintra` on your host available as `/var/opt/setmy.info/gintra` inside the Minikube node,
which allows the `xyz-nfs-server` deployment to use it via its `hostPath` volume.

## Usage, tips and tricks

### Load image into K8s

```shell
minikube image rm gihub.io/ORGNAME/IMAGENAME:VERSION_OR_TAG
minikube image load gihub.io/ORGNAME/IMAGENAME:VERSION_OR_TAG --overwrite
# Local images can be like that (minikube image list can show these: docker.io/ORGNAME/IMAGENAME:VERSION_OR_TAG)
minikube image load ORGNAME/IMAGENAME:VERSION_OR_TAG
# DEPRECATED
minikube cache add gihub.io/ORGNAME/IMAGENAME:VERSION
# In kubernetes deployment config should be: spec.templates.container.imagePullPolicy: Never
minikube image ls
minikube image ls --format table
minikube image rm aa11bb22cc334
minikube addons enable ingress

minikube tunnel
```

## See also

[Minikube](https://minikube.sigs.k8s.io)

[Quick start](https://minikube.sigs.k8s.io/docs/start/)

[Some docs](https://minikube.sigs.k8s.io/docs/)
