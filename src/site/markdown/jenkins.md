# Jenkins CI

## Information

## Installation

### CentOS, Rocky Linux

```shell
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum -y install jenkins
chkconfig --level 345 jenkins on
service jenkins start
```

From old notes (for FreeBSD or manual setup?):

```shell
mkdir /var/lib/jenkins
chown -R jenkins:jenkins /var/lib/jenkins
```

Jenkins working home directory is:

**/var/lib/jenkins**

Service execution script is:

**/etc/init.d/jenkins**

### Fedora

Fedora 21 config changes can be done in:

**nano /etc/sysconfig/jenkins**

```
#JENKINS_PORT='--httpPort=7070'\
#Should work also this\
JENKINS_PORT='7070'
daemon --user "$JENKINS_USER" --pidfile "$JENKINS_PID_FILE" $JAVA_CMD $PARAMS $JENKINS_PORT > /dev/null
```

### FreeBSD

/etc/rc.conf

```
jenkins_enable="YES"
jenkins_args="--httpPort=7070"
jenkins_java_home="/usr/local/openjdk16"
```

### OpenIndiana

## Configuration

### Plugins

Mercurial, Blue Ocean, i18n for Blue Ocean, Gravatar, Avatar, Green Balls, Docker, Kubernetes, SSH, Publish Over SSH,
docker-build-step, CMake,
Build Pipeline, JaCoCo, Cucumber reports

## Usage, tips and tricks

**Unlock Jenkins**

```shell
cat /var/lib/jenkins/secrets/initialAdminPassword
```

Run shell as Jenkins user

```shell
chsh -s /bin/sh jenkins
```

Change user to Jenkins

```shell
su -
su -l -p jenkins
```

Modules polling:

```
*/5 * * * *
```

## See also

[xxxx](http://yyyyy)
