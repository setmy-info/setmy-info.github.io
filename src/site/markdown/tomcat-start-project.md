# tomcat-start-project

## Information

## Installation

### CentOS

    sudo useradd microservice --shell /sbin/nologin --no-create-home
    export ANT_OPTS='-Dhttp.proxyHost=cache.example -Dhttp.proxyPort=8080 -Dhttps.proxyHost=cache.example -Dhttps.proxyPort=8080'

    ant download.tomcat
    sudo tar xvzf ./download/apache-tomcat-9.0.17.tar.gz -C /opt
    sudo chown microservice:microservice /opt/apache-tomcat-9.0.17/temp /opt/apache-tomcat-9.0.17/webapps /opt/apache-tomcat-9.0.17/work

## Configuration

https://technet.sector19.net/linux/create-systemd-service-for-tomcat/

## Usage

    docker build -t tomcat-start-project .
    docker run -p 8030:8080 -d tomcat-start-project

## See also

    [xxxx](http://yyyyy)
