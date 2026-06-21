# setmy-info-docker

## Information

This page documents Docker conventions used in setmy.info projects — image naming, Dockerfile patterns, registry
usage, and docker-compose conventions.

For general Docker usage see [docker.md](docker.md).

## Image Naming

Images follow the pattern:

```
docker.hub.io/setmy-info/<image-name>:<version>
```

Example:

```
docker.hub.io/setmy-info/xyz-api:1.0.0-SNAPSHOT
docker.hub.io/setmy-info/xyz-api:latest
```

Tag both the versioned and `latest` tag when publishing a release.

## Dockerfile Conventions

### Java / Spring Boot

```dockerfile
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY target/my-app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### Node.js

```dockerfile
FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .
EXPOSE 3000
CMD ["node", "src/index.js"]
```

### Multi-stage build (Node.js)

```dockerfile
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:22-alpine AS runtime
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

## Build and Tag

```shell
set IMAGE_NAME=xyz-api
set IMAGE_VERSION=1.0.0-SNAPSHOT
docker build -t "docker.hub.io/setmy-info/%IMAGE_NAME%:%IMAGE_VERSION%" -f ./Dockerfile .
docker image tag "docker.hub.io/setmy-info/%IMAGE_NAME%:%IMAGE_VERSION%" docker.hub.io/setmy-info/%IMAGE_NAME%:latest
```

Linux/macOS:

```shell
IMAGE_NAME=xyz-api
IMAGE_VERSION=1.0.0-SNAPSHOT
docker build -t "docker.hub.io/setmy-info/${IMAGE_NAME}:${IMAGE_VERSION}" -f ./Dockerfile .
docker image tag "docker.hub.io/setmy-info/${IMAGE_NAME}:${IMAGE_VERSION}" "docker.hub.io/setmy-info/${IMAGE_NAME}:latest"
```

## Docker Compose Conventions

Services are named after the application module. Internal ports are mapped to non-conflicting host ports. The
`network` is set to `minikube` when the service is expected to participate in a local Kubernetes-like dev environment.

```yaml
services:
  xyz-api:
    image: docker.hub.io/setmy-info/xyz-api:latest
    container_name: xyz-api
    ports:
      - "7080:8080"
    networks:
      - minikube
    environment:
      - SPRING_PROFILES_ACTIVE=dev
    restart: unless-stopped

networks:
  minikube:
    external: true
```

## Usage, tips and tricks

### Clean Build (no cache)

```shell
git clean -fdx
docker build --no-cache --progress=plain -t "docker.hub.io/setmy-info/${IMAGE_NAME}:${IMAGE_VERSION}" .
```

### Run Locally

```shell
docker container rm xyz-api || true
docker run --name xyz-api --network="minikube" -p 7080:8080 -d docker.hub.io/setmy-info/xyz-api:latest
```

### View Logs

```shell
docker logs -f xyz-api
```

## See also

* [docker.md](docker.md)
* [kubernetes.md](kubernetes.md)
* [minikube.md](minikube.md)
* [setmy-info-scripts.md](setmy-info-scripts.md)
