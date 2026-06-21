# tomcat-start-project

## Information

Apache Tomcat is an open-source Java Servlet container and HTTP server maintained by the Apache Software Foundation.
It implements the Java Servlet, JavaServer Pages (JSP), and WebSocket specifications and is used to deploy Java web
applications packaged as WAR (Web Application Archive) files.

Typical use cases include standalone Java web application hosting, API backends, and legacy Java EE web projects that
do not require a full application server (JBoss/WildFly).

## Installation

### CentOS / Rocky Linux (package)

```shell
sudo dnf install -y tomcat
sudo systemctl enable --now tomcat
```

### CentOS / Rocky Linux (manual, for a specific version)

```shell
sudo useradd microservice --shell /sbin/nologin --no-create-home

export ANT_OPTS='-Dhttp.proxyHost=cache.example -Dhttp.proxyPort=8080 -Dhttps.proxyHost=cache.example -Dhttps.proxyPort=8080'

ant download.tomcat
sudo tar xvzf ./download/apache-tomcat-9.0.17.tar.gz -C /opt
sudo chown microservice:microservice \
    /opt/apache-tomcat-9.0.17/temp \
    /opt/apache-tomcat-9.0.17/webapps \
    /opt/apache-tomcat-9.0.17/work
```

### Fedora

```shell
sudo dnf install -y tomcat
```

### Debian / Ubuntu

```shell
sudo apt-get install -y tomcat10
```

## Configuration

Key configuration files under `$CATALINA_HOME/conf/`:

**server.xml** — connector ports, SSL, virtual hosts:

```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
```

**context.xml** — data sources and session persistence shared across all applications.

**web.xml** — global servlet and filter defaults.

### Systemd service

When running as a systemd service, a unit file manages startup and shutdown. See the
[Tomcat systemd guide](https://technet.sector19.net/linux/create-systemd-service-for-tomcat/) for a complete example.

## Usage, tips and tricks

### Deploy a WAR

Copy or symlink a WAR file into the `webapps/` directory; Tomcat auto-deploys on startup or after a hot-deploy scan:

```shell
cp myapp.war $CATALINA_HOME/webapps/
```

### Start and stop

```shell
$CATALINA_HOME/bin/catalina.sh start
$CATALINA_HOME/bin/catalina.sh stop
$CATALINA_HOME/bin/catalina.sh run    # foreground (useful for containers)
```

### Docker

```shell
docker build -t tomcat-start-project .
docker run -p 8030:8080 -d tomcat-start-project
```

### Manager web app

The `/manager/html` web UI allows deploying, undeploying, and restarting applications without restarting Tomcat.
Enable it in `tomcat-users.xml` by adding a `manager-gui` role and a user.

## See also

* [Apache Tomcat official documentation](https://tomcat.apache.org/tomcat-10.1-doc/)
* [Tomcat systemd service setup](https://technet.sector19.net/linux/create-systemd-service-for-tomcat/)
* [Apache Maven](maven.md)
* [Spring Boot](springboot.md)
