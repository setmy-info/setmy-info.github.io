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
kubectl config set-context --current --namespace=xyz-dev
kubectl --context=CONTEXTNAME cluster-info

kubectl config use-context context-xyz

# It's known, that the secret map doesn't exist, but since it is similar to a config map, we will use a similar syntax and terminology.

# -n NAMESPACE can be appended
kubectl apply -f xyz-namespace.yaml
kubectl apply -f xyz-config-map.yaml
kubectl apply -f xyz-secrets-map.yaml
kubectl apply -f xyz-deployment.yaml
kubectl apply -f xyz-service.yaml
kubectl apply -f xyz-ingress.yaml

kubectl describe configmaps xyz-config-map
kubectl describe secret xyz-secrets-map

kubectl edit xyz-deployment
kubectl get pods
kubectl logs -f xyz-deployment-596744778-dcgtz
kubectl logs xyz-deployment-596744778-dcgtz -c containername --previous
kubectl describe pod xyz-deployment-596744778-dcgtz
# Restarts
kubectl delete pod xyz-deployment-596744778-dcgtz
kubectl proxy
kubectl port-forward xyz-deployment-596744778-dcgtz LOCALPORT:REMOTEPORT
kubectl exec -it xyz-deployment-596744778-dcgtz -- /bin/sh
kubectl get endpoints
kubectl get service

kubectl describe pv <persistent_volume_name>
kubectl describe pvc <persistent_volume_claim_name>

kubectl delete service xyz-service
kubectl delete deployment xyz-deployment
kubectl delete secrets xyz-secrets-map
kubectl delete configmap xyz-config-map
kubectl delete namespace xyz-namespace

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

# Persistent volumes
kubectl get pv
# Persistent volume claims
kubectl get pvc

# POD data as yaml
kubectl get pod -o yaml
```

### Volumes

**nfs-pv.yaml**

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    server: nfs.intra
    path: /tank/nfs/peristent-volumes
```

**nfs-pvc.yaml**

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
  storageClassName: ""
  volumeName: nfs-pv
```

### Namespace

**xyz-namespace.yaml**

```yaml
apiVersion: v1
kind: Namespace
metadata:
    name: xyz-dev
```

### Config map

xyz-config-map.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
    name: xyz-config-map
    namespace: xyz-dev
    # <pod-name>.<service-name>.<namespace>.svc.cluster.local
    # By default:                  .default.svc.cluster.local
    pg-host: postgresql-1.postgresql-service.default.svc.cluster.local
data:
    variable: "Value in quotations"
immutable: true
```

### Secrets map

**xyz-secrets-map.yaml**

```yaml
apiVersion: v1
kind: Secret
metadata:
    name: xyz-secrets-map
    namespace: xyz-dev
data:
    secret-variable: U2VjcmV0IHZhbHVl
immutable: true
```

### Deployment

**xyz-deployment.yaml**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    name: xyz-deployment
    namespace: xyz-dev
    labels:
        app: xyz-deployment
spec:
    replicas: 3
    selector:
        matchLabels:
            app: xyz-deployment
    template:
        metadata:
            labels:
                app: xyz-deployment
        spec:
            containers:
                -   name: xyz
                    image: xyz:latest
                    # For example, not needed in Minikube
                    # imagePullPolicy: Never
                    ports:
                        -   name: xyz-port
                            containerPort: 8080
                    env:
                        # For Spring boot
                        -   name: PROFILES_LIST
                            value: "dev,api-docs"
                        ## From config-map
                        -   name: VARIABLE
                            valueFrom:
                                configMapKeyRef:
                                    name: xyz-config-map
                                    key: variable
                                    optional: false
                        ## From secrets
                        -   name: SECRET_VARIABLE
                            valueFrom:
                                secretKeyRef:
                                    name: xyz-secrets-map
                                    key: secret-variable
                                    optional: false
          volumeMounts:
            - name: nfs-volume
              mountPath: /app/data
      volumes:
        - name: nfs-volume
          persistentVolumeClaim:
            claimName: nfs-pvc
```

### Service

**xyz-service.yaml**

```yaml
apiVersion: v1
kind: Service
metadata:
    name: xyz-service
    namespace: xyz-dev
spec:
    selector:
        app.kubernetes.io/name: xyz
    ports:
        -   protocol: TCP
            port: 80
            targetPort: xyz-port
```

### Ingress

**xyz-ingress.yaml**

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
    name: xyz-ingress
    namespace: xyz-dev
    annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /
spec:
    ingressClassName: nginx-example
    rules:
        -   http:
                paths:
                    -   path: /testpath
                        pathType: Prefix
                        backend:
                            service:
                                name: test
                                port:
                                    number: 80

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
