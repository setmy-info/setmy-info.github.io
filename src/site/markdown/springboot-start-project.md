# springboot-start-project

## Information

## Installation

### CentOS

    Preparations
        sudo mkdir -p /opt/has/bin
        sudo mkdir -p /opt/has/lib
        sudo mkdir -p /opt/has/doc
        sudo mkdir -p /opt/has/info
        sudo mkdir -p /opt/has/man
        sudo mkdir -p /var/opt/has
        sudo mkdir -p /var/opt/has/springboot-start-project
        sudo chown -R microservice:microservice /var/opt/has/springboot-start-project
        sudo useradd microservice --shell /sbin/nologin --no-create-home
        sudo mkdir -p /etc/systemd/system/springboot-start-project.service.d

    (New) software installation
        sudo cp -f ./src/main/sh/springboot-start-project.service /etc/systemd/system
        sudo cp -f ./src/main/sh/environment.conf /etc/systemd/system/springboot-start-project.service.d
        sudo cp -f ./src/main/sh/springboot-start-project /opt/has/bin
        sudo cp -f ./target/springboot-start-project-1.2.0-SNAPSHOT.jar /opt/has/lib
        sudo systemctl daemon-reload

        sudo nano /etc/systemd/system/springboot-start-project.service.d/secrets.conf
        ---
        [Service]
        Environment="DB_PASSWORD=dbuser"
        Environment="DB_USER_NAME=secret1234"
        ---
        sudo systemctl daemon-reload

    Starting and stoping
        sudo systemctl start springboot-start-project.service
        sudo systemctl stop springboot-start-project.service

    Analysing service
        sudo systemctl cat springboot-start-project
        sudo journalctl -u springboot-start-project

    sudo /opt/has/bin/springboot-start-project

## Configuration

    https://docs.spring.io/spring-boot/docs/current/reference/html/deployment-install.html

## Usage

## See also

    https://wiki.linuxfoundation.org/lsb/start
    https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html
    https://www.freedesktop.org/software/systemd/man/systemd.service.html
    https://dataandtechnology.wordpress.com/2018/03/01/systemd-service-and-script-example/
    https://unix.stackexchange.com/questions/47695/how-to-write-startup-script-for-systemd#47715
