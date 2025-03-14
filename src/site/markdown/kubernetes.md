# Kubernetes (k8s)

## Preparations

```sh
egrep --color 'vmx|svm' /proc/cpuinfo
```

## Installation

### kubectl CLI installation

```sh
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
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

kubectl create user USER_NAME
kubectl create role ROLE_NAME --verb=RIGHTS --resource=RESOURCE
kubectl create rolebinding BINDING_NAME --role=ROLE_NAME --user=USERNAME

kubectl cluster-info

# It's known, that the secret map doesn't exist, but since it is similar to a config map, we will use a similar syntax and terminology.

# -n NAMESPACE can be appended
kubectl create namespace xyz-namespace
kubectl apply -f xyz-namespace.yaml
kubectl apply -f xyz-config-map.yaml
kubectl apply -f xyz-secrets-map.yaml
kubectl apply -f xyz-nfs-persistent-volume.yaml
kubectl apply -f xyz-nfs-persistent-volume-claim.yaml
kubectl apply -f xyz-deployment.yaml
kubectl apply -f xyz-service.yaml
kubectl apply -f xyz-ingress.yaml

kubectl edit xyz-deployment
kubectl get pods
kubectl logs -f xyz-deployment-596744778-dcgtz
kubectl logs xyz-deployment-596744778-dcgtz -c containername --previous
kubectl logs -l app=xyz-deployment --all-containers=true --follow
kubectl logs -n ingress-nginx ingress-nginx-controller-596744778-dcgtz -f

# Restarts
kubectl delete pod xyz-deployment-596744778-dcgtz
kubectl proxy
kubectl port-forward xyz-deployment-596744778-dcgtz LOCALPORT:REMOTEPORT
kubectl exec -it xyz-deployment-596744778-dcgtz -- /bin/sh
kubectl get endpoints
kubectl get service
kubectl get pv
kubectl get pvc
kubectl get ingress
kubectl get endpoints xyz-service -n xyz-local

kubectl describe configmaps xyz-config-map
kubectl describe secret xyz-secrets-map
kubectl describe pod xyz-deployment-596744778-dcgtz
kubectl describe deployment xyz-deployment
kubectl describe service xyz-service
kubectl describe pv xyz-nfs-persistent-volume
kubectl describe pvc xyz-nfs-persistent-volume-claim
kubectl describe ingress xyz-ingress

kubectl delete ingress xyz-ingress
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

# Working with seales secrets
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.18.0/controller.yaml

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
    # <service-name>.<namespace>.svc.cluster.local
    # <pod-name>.<service-name>.<namespace>.svc.cluster.local
    # postgresql-1.postgres-service.microservice-local.svc.cluster.local
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

### Volumes

**xyz-nfs-persistent-volume.yaml**

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
    name: xyz-nfs-persistent-volume
    namespace: xyz-dev
spec:
    capacity:
        storage: 10Gi
    accessModes:
        - ReadWriteMany
    persistentVolumeReclaimPolicy: Retain
    nfs:
        server: 127.0.0.1 # nfs.gintra
        path: /var/opt/setmy.info/gintra
```

**xyz-nfs-persistent-volume-claim.yaml**

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
    name: xyz-nfs-persistent-volume-claim
    namespace: xyz-dev
spec:
    accessModes:
        - ReadWriteMany
    resources:
        requests:
            storage: 5Gi
    storageClassName: ""
    volumeName: xyz-nfs-persistent-volume
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
                    #image: docker.io/setmyinfo/springboot-start-project:latest
                    #image: setmyinfo/springboot-start-project:latest
                    image: xyz:latest
                    # For example, not needed in Minikube
                    # imagePullPolicy: Never
                    #command: [ "java-execute" ]
                    #args: ["echo 'Hello World'; exec myapp --start"]
                    ports:
                        -   name: ms-port
                            containerPort: 8080
                    env:
                        # For Spring boot
                        -   name: APPLICATION_PROFILES
                            value: "dev,api-docs"
                        ## From config-map
                        -   name: VARIABLE
                            valueFrom:
                                configMapKeyRef:
                                    name: xyz-config-map
                                    key: variable
                                    optional: false
                        -   name: POD_NAMESPACE
                            valueFrom:
                                fieldRef:
                                    fieldPath: metadata.namespace
                        -   name: POD_NAME
                            valueFrom:
                                fieldRef:
                                    fieldPath: metadata.name
                        -   name: NODE_NAME
                            valueFrom:
                                fieldRef:
                                    fieldPath: spec.nodeName
                        ## From secrets
                        -   name: SECRET_VARIABLE
                            valueFrom:
                                secretKeyRef:
                                    name: xyz-secrets-map
                                    key: secret-variable
                                    optional: false
                    volumeMounts:
                        -   name: nfs-volume
                            mountPath: /mnt/gintra
            volumes:
                -   name: nfs-volume
                    persistentVolumeClaim:
                        claimName: xyz-nfs-persistent-volume-claim
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
            # Port where Ingress forwards to
            port: 80
            # Deployment or POD port in container port
            #targetPort: 8080
            targetPort: ms-port
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
    #ingressClassName: nginx-example
    ingressClassName: nginx
    rules:
        -   host: xyz-dev
            http:
                paths:
                    #-   path: /testpath
                    -   path: /xyz-dev
                        pathType: Prefix
                        backend:
                            service:
                                #name: test
                                name: xyz-service
                                port:
                                    number: 80
```

## Kind complete list

```yaml
kind: Pod
---
kind: Deployment
---
kind: Service
---
kind: Namespace
---
kind: ConfigMap
---
kind: Secret
---
kind: StatefulSet
---
kind: DaemonSet
---
kind: Ingress
---
kind: PersistentVolume
---
kind: PersistentVolumeClaim
---
kind: VolumeClaimTemplate
---
kind: Job
---
kind: CronJob
---
kind: HorizontalPodAutoscaler
---
kind: ServiceAccount
---
kind: Role
---
kind: RoleBinding
---
kind: PodDisruptionBudget
---
kind: Endpoint
---
kind: LimitRange
---
kind: NetworkPolicy
---
kind: StorageClass
---
kind: PodSecurityPolicy
---
kind: ReplicaSet
---
kind: PodTemplate
---
kind: ReplicationController
---
kind: ClusterRole
---
kind: ClusterRoleBinding
---
kind: ServiceMonitor
---
kind: VolumeSnapshot
---
kind: VolumeSnapshotClass
---
kind: VolumeSnapshotContent
---
kind: VolumeSnapshotDataSource
---
kind: VolumeAttachment
---
kind: StorageVersion
---
kind: TokenReview
---
kind: SelfSubjectAccessReview
---
kind: SelfSubjectRulesReview
---
kind: SubjectAccessReview
---
kind: PriorityClass
---
kind: PodSecurityPolicyReview
---
```

## See also

* [Kubernetes](https://kubernetes.io)
* [kubectl installation](https://kubernetes.io/docs/tasks/tools/#kubectl)
* [minikube](https://kubernetes.io/docs/setup/minikube/)
* [kubectl cli usage](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
* [Deployment](https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/)
* [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
* [Config maps](ttps://kubernetes.io/docs/concepts/configuration/configmap/)
* [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
* [Sealed secrets](https://github.com/bitnami-labs/sealed-secrets/releases)
* [PCI-DSS](https://raesene.github.io/blog/2022/10/01/PCI-Kubernetes-Section1-Authentication/)
