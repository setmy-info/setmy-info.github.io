# Docker

## Information

## Installation

### CentOS

```sh
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker USERNAME
docker run hello-world

# Example
docker run \
    --name jenkins-docker \
    --rm \
    --detach \
    --privileged \
    --network jenkins \
    --network-alias docker \
    --env DOCKER_TLS_CERTDIR=/certs \
    --volume jenkins-docker-certs:/certs/client \
    --volume jenkins-data:/var/jenkins_home \
    --publish 2376:2376 \
    docker:dind \
    --storage-driver overlay2

```

### Build image

```sh
docker build .
```

### Debian

### Windows

https://docs.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package

1. WSL2 Linux kernel update package for x64
   machines : https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
2. https://docs.docker.com/desktop/windows/install/

### Build example

```
set BUILDKIT_PROGRESS=plain
set DOCKER_BUILDKIT=0
set IMAGE_NAME=xyz-api
set IMAGE_VERSION=1.0.0-SNAPSHOT
cd C:\sources\xyz-api
# Remove all, that is not under source controll
git clean -fdx
docker build -t "docker.hub.io/setmy-info/%IMAGE_NAME%:%IMAGE_VERSION%" -f ./Dockerfile .
docker image tag "docker.hub.io/setmy-info/%IMAGE_NAME%:%IMAGE_VERSION%" docker.hub.io/setmy-info/%IMAGE_NAME%:latest
docker container rm %IMAGE_NAME%
docker run --name %IMAGE_NAME% --network="minikube"  -p 7080:8080 -d docker.hub.io/setmy-info/%IMAGE_NAME%:latest
```

## Configuration

## Docker compose

Possibly not needed anymore, because it is integrated into docker.

[Docker compose](https://docs.docker.com/compose)

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

To run docker compose:
    docker-compose up
    Option --file can be used.
To scale:
    docker-compose up --scale microservice-xyz=3
```

## Docker Ignore

.dockerignore

```
node_modules
```

## Portainer

```
docker volume create portainer_data
docker run --name portainer -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
firefox --new-tab http://localhost:9000/#/init/admin
For example: User: admin, Password: adminadmin
```

## Docker Registry

```
docker run -d -p 5000:5000 --restart=always --name registry registry:2
docker run -d -p 5000:5000 --restart=always --name registry -v /mnt/registry:/var/lib/registry registry:2
```

## Dockerize Postgresql

[Dockerize Postgresql](https://docs.docker.com/v17.09/engine/examples/postgresql_service/)

## Usage, tips and tricks

```
docker pull centos
docker image list
docker image rm 41e53a126a5d

docker container list -a
docker container stop aa467bdcd223
docker container rm aa467bdcd223

docker system prune -a
docker container prune
docker volume prune
docker network prune
docker system prune
docker images -f dangling=true

docker container list --all
docker image list --all
docker image ls
docker volume ls
docker network ls
docker info

docker container stop minikube
docker container rm minikube
docker volume rm minikube
docker network rm minikube

docker volume create pg-data
# docker volume create pg-data:/var/lib/postgresql/data

docker run --name postgis -p 5432:5432 --restart always -v pg-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=g6p8 -d postgis/postgis

docker run --gpus all --name IMAGE_NAME -v "${DOCKER_HOST_DIR}":/var/opt/setmy.info/data --rm docker.hub/setmy.info/IMAGE:VERSION

docker run -d --name jenkins -p 2376:8080 -v jenkins-data:/var/lib/jenkins setmyinfo/setmy-info-rocky-java-jenkins:latest
docker exec -u root -it jenkins /bin/sh
docker cp jenkins:/var/lib/jenkins.tar.gz ./jenkins.tar.gz
```

**sudo nano /etc/systemd/system/docker.service.d/http-proxy.conf**

```
[Service]
Environment="HTTP_PROXY=http://cache.example.com:8080/"
Environment="HTTPS_PROXY=http://cache.example.com:8080/"
Environment="NO_PROXY=localhost,127.0.0.1,0.0.0.0"
```

**nano ~/.docker/config.json**

```json
{
    "proxies": {
        "default": {
            "httpProxy": "http://127.0.0.1:3001",
            "httpsProxy": "http://127.0.0.1:3001",
            "noProxy": "*.test.example.com,.example2.com"
        }
    }
}
```

Composer

## Saved previous examples

**docker-compose.yml**

```yaml
version: '0.0.1'
services:
    db:
    image: postgis/postgis
    restart: always
    environment:
        POSTGRES_PASSWORD: 'g6p8'
    volumes:
        - pg-data:/var/lib/postgresql/data
    ports:
        - '5432:5432'
volumes:
    pg-data:
```

```shell
docker compose start
docker compose stop
```

```shell
psql -h localhost -p 5432 -U postgres -d postgres -W
# P: g6p8
```

## Docker connection problem

```sh
[has@robot ~]$ docker run hello-world
docker: Cannot connect to the Docker daemon at tcp://localhost:2375. Is the docker daemon running?.
See 'docker run --help'.
[has@robot ~]$ unset DOCKER_HOST
[has@robot ~]$ docker run hello-world

Hello from Docker!
...
```

Export to tar.gz and import from tar.gz

```sh
docker save -o image.tar image_name:tag
gzip image.tar
docker load -i image.tar.gz
docker images
docker tag <image_id> image_name:tag
```

## See also

[User usage](https://docs.ansible.com/ansible/2.7/user_guide/become.html)

[docker run options](https://docs.docker.com/engine/reference/run/)

[Docker Registry](https://docs.docker.com/registry/)

[Harbor](https://goharbor.io/)
