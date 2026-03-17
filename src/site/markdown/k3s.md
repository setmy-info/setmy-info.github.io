# K3S

## Information

## Installation

```shell
# Asks password for sudo
curl -sfL https://get.k3s.io | sh -

sudo firewall-cmd --permanent --add-port=6443/tcp #apiserver
sudo firewall-cmd --permanent --zone=trusted --add-source=10.42.0.0/16 #pods
sudo firewall-cmd --permanent --zone=trusted --add-source=10.43.0.0/16 #services
sudo firewall-cmd --reload

sudo mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown -R USER:USER ~/.kube

kubectl get pods -A
```

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Mounting host folders

Since K3s typically runs directly on the Linux host, any folder on the host system (e.g., `/var/opt/setmy.info/gintra`) is already accessible to the K3s node.

In your `xyz-nfs-server` deployment, the `hostPath` volume can point directly to the host directory:

```yaml
volumes:
    -   name: nfs-exports
        hostPath:
            path: /var/opt/setmy.info/gintra
            type: DirectoryOrCreate
```

Ensure that:
1.  The folder exists on the host (or use `DirectoryOrCreate`).
2.  The user running K3s has read/write permissions for that folder.
3.  On systems with SELinux (like CentOS/Rocky/Fedora), you may need to set the correct context or use the `:z` or `:Z` mount options if using raw container engines, but K3s `hostPath` usually works if permissions are correct.

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
