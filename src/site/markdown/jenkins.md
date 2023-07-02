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

## GitHub

### Insert GitHub Blue Ocean pipeline

1. Create GitHub token: GitHub profile picture -> Settings -> Developer settings
   -> Personal access tokens -> Tokens (classic) -> Generate new token
2. Add credentials to Jenkins: Manage Jenkins -> Credentials -> System (Global) -> Add Credentials:
   Kind: Username with password; Username: GITHUBUSERNAME; Password: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
   ID: github; Description Token information.
3. In Jenkins: Open Blue Ocean -> GitHub -> Insert token
4. Fix build settings: open build -> Configure -> Add GitHub credentials from dropdown

NB! **github** is used by default for registering new pipelines.

Also some options for docker:

-e GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-e GITHUB_USERNAME=e@mail.com

Don't forget set polling option inside config for pipeline.

### Create SSH keys

1. Start Jenkins docker:

```
docker run -d --name jenkins -p 2376:8080 -v jenkins-data:/var/lib/jenkins setmyinfo/setmy-info-rocky-java-jenkins:latest
```

2. Create SSH keys and get public key:

```
docker exec -it jenkins /bin/sh -c "ssh-keygen -t ed25519 -b 4096 -C 'e@mail.com' -N '' -f /var/lib/jenkins/.ssh/id_ed25519"
docker exec -it jenkins /bin/sh -c "cat /var/lib/jenkins/.ssh/id_ed25519.pub"
```

3. Add public key to GitHub: GitHub profile picture -> Settings
   -> SSH and GPG keys -> New SSH key. Set title: Docker Jenkins GitHub Token

### Problems

```
Branch indexing
Connecting to https://api.github.com with no credentials, anonymous access
Jenkins-Imposed API Limiter: Current quota for Github API usage has 46 remaining (1 over budget). Next quota of 60 in 49 min. Sleeping for 4 min 30 sec.
Jenkins is attempting to evenly distribute GitHub API requests. To configure a different rate limiting strategy, such as having Jenkins restrict GitHub API requests only when near or above the GitHub rate limit, go to "GitHub API usage" under "Configure System" in the Jenkins settings.
Jenkins-Imposed API Limiter: Still sleeping, now only 1 min 28 sec remaining.
Jenkins-Imposed API Limiter: Current quota for Github API usage has 42 remaining (2 over budget). Next quota of 60 in 45 min. Sleeping for 6 min 8 sec.
Jenkins is attempting to evenly distribute GitHub API requests. To configure a different rate limiting strategy, such as having Jenkins restrict GitHub API requests only when near or above the GitHub rate limit, go to "GitHub API usage" under "Configure System" in the Jenkins settings.
Jenkins-Imposed API Limiter: Still sleeping, now only 3 min 6 sec remaining.
Jenkins-Imposed API Limiter: Still sleeping, now only 5.1 sec remaining.
...

```

Use Jenkins inside docker as **jenkins** user

```
docker exec -it jenkins /bin/sh
```

Use Jenkins inside docker as **root** user

```
docker exec -u root -it jenkins /bin/sh
```

Use Jenkins image and start shell

```
docker run -it setmyinfo/setmy-info-rocky-java-jenkins:latest /bin/sh
```

## See also

[xxxx](http://yyyyy)
