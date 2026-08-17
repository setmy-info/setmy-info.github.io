# Infinispan

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

sudo nano /etc/systemd/system/infinispan.service

```
[Unit]
Description=Infinispan Server
After=network.target

[Service]
ExecStart=/opt/infinispan/bin/server.sh
User=infinispan
Group=infinispan
Restart=always
Environment=JAVA_HOME=/opt/jdk

[Install]
WantedBy=multi-user.target
```

```
sudo useradd infinispan --shell /sbin/nologin --no-create-home
sudo chown infinispan:infinispan -R /opt/infinispan/
sudo firewall-cmd --add-port=57800/tcp --permanent
sudo firewall-cmd --add-port=11222/tcp --permanent
sudo firewall-cmd --reload
# cli.sh changes needet to force to use JAVA as /opt/jdk/bin/java
sudo bin/cli.sh user create admin -p changeme -g admin
sudo systemctl enable infinispan
sudo systemctl start infinispan
```

```xml

<interfaces>
    <interface name="public">
        <!--inet-address value="${infinispan.bind.address:127.0.0.1}"/-->
        <inet-address value="${infinispan.bind.address:0.0.0.0}"/>
    </interface>
</interfaces>
```

```shell
cd ~/temp/infinispan
/opt/infinispan/bin/server.sh \
    -Dinfinispan.server.data.path=~/temp/infinispan \
    -Dinfinispan.server.log.path=~/temp/infinispan

/opt/infinispan/bin/cli.sh user create admin -p admin -g admin
```

Fails:

```cmd
cd C:\pub\infinispan-server-16.2.2
mkdir C:\pub\infinispan-server-16.2.2\data
mkdir C:\pub\infinispan-server-16.2.2\log

REM .\bin\cli.sh user create admin -p admin -g admin
REM .\bin\server.bat -Dinfinispan.server.data.path=C:\pub\infinispan-server-16.2.2\data -Dinfinispan.server.log.path=C:\pub\infinispan-server-16.2.2\log
REM .\bin\server.bat -Dinfinispan.server.data.path=C:/pub/infinispan-server-16.2.2/data -Dinfinispan.server.log.path=C:/pub/infinispan-server-16.2.2/log
```

## See also

[Home page](https://infinispan.org/)

https://docs.spring.io/spring-boot/reference/io/caching.html#io.caching.provider.infinispan

https://docs.spring.io/spring-boot/reference/io/caching.html

https://infinispan.org/docs/stable/titles/hibernate/hibernate.html

https://infinispan.org/docs/stable/titles/embedding/embedding.html

https://infinispan.org/docs/stable/titles/spring_boot/starter.html

https://infinispan.org/docs/stable/titles/encoding/encoding.html
