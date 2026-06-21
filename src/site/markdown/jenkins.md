# Jenkins CI

## Information

Jenkins is an open-source automation server written in Java. It orchestrates build, test, and deployment pipelines
and is extensible via over 1 800 community plugins. Pipelines are defined in a `Jenkinsfile` using either the
**Declarative Pipeline** DSL (recommended) or the more flexible **Scripted Pipeline** DSL. Jenkins runs on any
platform with a JDK, from a single server to distributed agent fleets.

Key features: parallel stages, Blue Ocean UI, GitHub/GitLab/Bitbucket integration, Docker/Kubernetes agents, shared
libraries, credential management, and fine-grained role-based access control.

## Installation

### CentOS, Rocky Linux (modern — systemd)

```shell
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf install -y java-21-openjdk jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```

### CentOS, Rocky Linux (legacy — SysV init, older notes)

```shell
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum -y install jenkins
chkconfig --level 345 jenkins on
service jenkins start
```

From old notes (manual home directory setup):

```shell
mkdir /var/lib/jenkins
chown -R jenkins:jenkins /var/lib/jenkins
```

Jenkins working home directory: **/var/lib/jenkins**

Service execution script: **/etc/init.d/jenkins**

### Fedora

Fedora 21 config changes can be done in:

**nano /etc/sysconfig/jenkins**

```
#JENKINS_PORT='--httpPort=7070'
#Should work also this
JENKINS_PORT='7070'
daemon --user "$JENKINS_USER" --pidfile "$JENKINS_PID_FILE" $JAVA_CMD $PARAMS $JENKINS_PORT > /dev/null
```

### FreeBSD

**/etc/rc.conf**

```
jenkins_enable="YES"
jenkins_args="--httpPort=7070"
jenkins_java_home="/usr/local/openjdk16"
```

## Configuration

### Key directories

| Path | Purpose |
|------|---------|
| `/var/lib/jenkins` | `$JENKINS_HOME` — jobs, workspaces, configs |
| `/var/lib/jenkins/plugins` | installed plugins |
| `/var/lib/jenkins/secrets/initialAdminPassword` | first-run unlock key |
| `/etc/sysconfig/jenkins` | service environment variables (Fedora/RHEL) |

### Recommended plugins

Mercurial, Blue Ocean, i18n for Blue Ocean, Gravatar, Avatar, Green Balls, Docker, Kubernetes, SSH,
Publish Over SSH, docker-build-step, CMake, Build Pipeline, JaCoCo, Cucumber reports

### Declarative Jenkinsfile skeleton

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            when { branch 'main' }
            steps {
                sh './deploy.sh'
            }
        }
    }
    post {
        always { junit '**/target/surefire-reports/*.xml' }
    }
}
```

## Usage, tips and tricks

**Unlock Jenkins on first start**

```shell
cat /var/lib/jenkins/secrets/initialAdminPassword
```

**Run shell as Jenkins user**

```shell
chsh -s /bin/sh jenkins
su -l -p jenkins
```

**Polling interval (every 5 minutes)**

```
*/5 * * * *
```

**Key URLs**

| URL | Purpose |
|-----|---------|
| `http://host:8080/` | Dashboard |
| `http://host:8080/manage` | Manage Jenkins |
| `http://host:8080/blue` | Blue Ocean UI |
| `http://host:8080/admin/docs` (JHipster) | Swagger |

## GitHub

### Insert GitHub Blue Ocean pipeline

1. Create GitHub token: GitHub profile picture -> Settings -> Developer settings
   -> Personal access tokens -> Tokens (classic) -> Generate new token
2. Add credentials to Jenkins: Manage Jenkins -> Credentials -> System (Global) -> Add Credentials:
   Kind: Username with password; Username: GITHUBUSERNAME; Password: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
   ID: github; Description Token information.
3. In Jenkins: Open Blue Ocean -> GitHub -> Insert token
4. Fix build settings: open build -> Configure -> Add GitHub credentials from dropdown
5. Manage Jenkins -> In-process Script Approval -> Method Signatures -> hudson.plugins.git.GitChangeSet getPaths

NB! **github** is used by default for registering new pipelines.

Docker environment variables:

```
-e GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-e GITHUB_USERNAME=e@mail.com
```

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

### Docker exec shortcuts

```shell
# Enter as jenkins user
docker exec -it jenkins /bin/sh

# Enter as root
docker exec -u root -it jenkins /bin/sh

# Start a fresh shell from the image
docker run -it setmyinfo/setmy-info-rocky-java-jenkins:latest /bin/sh
```

### Kubernetes service account

```
kubectl create sa jenkins
kubectl create clusterrolebinding jenkins-cluster-admin --clusterrole=cluster-admin --serviceaccount=default:jenkins
kubectl get secret
```

## Jenkinsfile starter project

Workflows for **master**, **release/x**, **develop**, **feature/y** branches

Publication — package sending to file server/storage/package management system.

Deploy — deploy package to environment (**dev**, **testing**, **prelive**, **live**).

Tagging — make tag for released (**tested/verified**, **published** and **deployed**) software into VCS.

![Image](../resources/images/jenkinsfile-starter/master.png)

![Image](../resources/images/jenkinsfile-starter/release_1.0.0.png)

![Image](../resources/images/jenkinsfile-starter/develop.png)

![Image](../resources/images/jenkinsfile-starter/feature_something.png)

## See also

* [Jenkins official documentation](https://www.jenkins.io/doc/)
* [Jenkins Pipeline syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)
* [Blue Ocean](https://www.jenkins.io/doc/book/blueocean/)
* [Jenkins plugin index](https://plugins.jenkins.io/)
