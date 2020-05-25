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
```

### Build image

```sh
docker build .
```

#### kubectl

### Debian

## Configuration

## Docker compose

```
    [Docker compose](https://docs.docker.com/compose)
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

```
    [Dockerize Postgresql](https://docs.docker.com/v17.09/engine/examples/postgresql_service/)
```

## Usage, tips and tricks

```
    docker pull centos
    docker image list
    docker image rm 41e53a126a5d

    docker container list -a
    docker container stop aa467bdcd223
    docker container rm aa467bdcd223

    docker system prune -a
    docker images -f dangling=true

    Option san be used:
        -n namespacename

    sudo nano /etc/systemd/system/docker.service.d/http-proxy.conf
    [Service]
    Environment="HTTP_PROXY=http://cache.example.com:8080/"
    Environment="HTTPS_PROXY=http://cache.example.com:8080/"
    Environment="NO_PROXY=localhost,127.0.0.1,0.0.0.0"

    nano ~/.docker/config.json
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

## Saved previous examples

```
FROM setmyinfo/setmy-info-centos-java:latest

MAINTAINER Imre Tabur "imre.tabur@eesti.ee"

LABEL org.label-schema.name="Docker HUB CentOS Spring boot micro service base" \
      org.label-schema.version="1.2.0-SNAPSHOT" \
      org.label-schema.description="setmy.info Docker HUB Centos Spring boot micro service base" \
      org.label-schema.vendor="Hear And See Systems LLC" \
      org.label-schema.url="https://www.hearandseesystems.com" \
      org.label-schema.license="MIT" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE

#ENV http_proxy http://cache.example.com:8080
#ENV https_proxy http://cache.example.com:8080

# docker run -p 8080:8080 setmyinfo/setmy-info-java-microservice:v1.0.0
# docker run -e "SPRING_PROFILES_ACTIVE=dev" setmyinfo/setmy-info-java-microservice:v1.0.0

# TODO : move that into base images with user creation etc
COPY target/springboot-start-project-1.0.0-SNAPSHOT.jar /opt/has/lib/app.jar
#RUN chown -R root:root                  /opt/has/lib/app.jar
RUN chown -R microservice:microservice                  /opt/has/lib/app.jar
RUN ls -la /opt/has/lib/app.jar
RUN java -version
RUN ls /dev/urandom

# Can add -Djavax.net.ssl.trustStore=/opt/has/lib/store.jks -Djavax.net.ssl.keyStorePassword=secretpass
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/urandom"

WORKDIR /var/opt/has/microservice

EXPOSE 8080/tcp
EXPOSE 8443/tcp

#CMD ["/bin/sh"]
CMD java ${JAVA_OPTS} -jar /opt/has/lib/app.jar
```


## See also

    [User usage](https://docs.ansible.com/ansible/2.7/user_guide/become.html)
