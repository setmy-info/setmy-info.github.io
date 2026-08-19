# Jenkins CI

## Information

Jenkins is an open-source automation server written in Java. It orchestrates build, test, and deployment pipelines and
is extensible via over 1 800 community plugins. Pipelines are defined in a `Jenkinsfile` using either the **Declarative
Pipeline** DSL (recommended) or the more flexible **Scripted Pipeline** DSL. Jenkins runs on any platform with a JDK,
from a single server to distributed agent fleets.

Key features: parallel stages, Blue Ocean UI, GitHub/GitLab/Bitbucket integration, Docker/Kubernetes agents, shared
libraries, credential management, and fine-grained role-based access control.

## Installation

### CentOS, Rocky Linux (modern — systemd)

```shell
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm-stable/jenkins.repo
sudo yum upgrade
sudo yum install fontconfig java-21-openjdk
sudo yum install jenkins
sudo systemctl daemon-reload

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

curl -sO http://localhost:7070/jnlpJars/agent.jar
java -jar agent.jar -url http://localhost:7070/ -secret xxxxxxxxxxxxxxxxxx -name "linux-1" -webSocket -workDir "/tmp/linux-1"

cd C:\pub\jenkins
set JENKINS_HOME=C:\pub\jenkins\home
java -jar jenkins.war --httpPort=7070
java -jar agent.jar -url http://localhost:7070/ -secret xxxxxxxxxxxxxxxxxx -name "windows-1" -webSocket -workDir "C:\pub\jenkins\windows-1"
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

| Path                                            | Purpose                                     |
|-------------------------------------------------|---------------------------------------------|
| `/var/lib/jenkins`                              | `$JENKINS_HOME` — jobs, workspaces, configs |
| `/var/lib/jenkins/plugins`                      | installed plugins                           |
| `/var/lib/jenkins/secrets/initialAdminPassword` | first-run unlock key                        |
| `/etc/sysconfig/jenkins`                        | service environment variables (Fedora/RHEL) |

### Recommended plugins

Mercurial, Blue Ocean, i18n for Blue Ocean, Gravatar, Avatar, Green Balls, Docker, Kubernetes, SSH, Publish Over SSH,
docker-build-step, CMake, Build Pipeline, JaCoCo, Cucumber reports

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

Another probe Jenkiinsfile

```groovy
pipeline {
    agent any

    environment {
        PATH = "/opt/python314/bin:${env.PATH}"
    }

    options {
        buildDiscarder(
            logRotator(
                numToKeepStr: '20',
                artifactNumToKeepStr: '10'
            )
        )
    }

    stages {
        stage('Test') {
            steps {
                sh '''
                    echo "PATH:"
                    echo "$PATH"

                    echo ""
                    echo "Platform Python:"
                    which python
                    python3 --version

                    echo ""
                    echo "Creating virtual environment..."
                    python3 -m venv .venv

                    echo ""
                    echo "Virtual environment:"
                    .venv/bin/python --version

                    echo ""
                    echo "Maven:"
                    mvn --version

                    echo ""
                    echo "Node: ${NODE_NAME}"

                    echo "Hello World" > hello-world.txt
                    echo "Node: ${NODE_NAME}" >> hello-world.txt
                    echo "Python: $(python --version 2>&1)" >> hello-world.txt
                    echo "Venv Python: $(.venv/bin/python --version 2>&1)" >> hello-world.txt
                    echo "Maven:" >> hello-world.txt
                    mvn --version >> hello-world.txt

                    cat hello-world.txt

                    sleep 10

                    echo "Finished on node: ${NODE_NAME}"
                '''
            }
        }
    }
}
```

## Usage, tips and tricks

**Unlock Jenkins on the first start**

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

| URL                                      | Purpose           |
|------------------------------------------|-------------------|
| `http://host:8080/`                      | Dashboard         |
| `http://host:8080/manage`                | Manage Jenkins    |
| `http://host:8080/blue`                  | Blue Ocean UI     |
| `http://host:8080/admin/docs` (JHipster) | Swagger           |
| `http://host:8080/pipeline-syntax/`      | Snippet Generator |

### Jenkins Script Console

Manage Jenkins → Script Console

```groovy
Jenkins.instance.pluginManager.plugins.each {
    println(it.shortName)
}
```

## Controlling Concurrent Builds

* **Variant 1: Allow only one build at a time (simplest)**: Use `disableConcurrentBuilds()` option in the pipeline.
* **Variant 2: Allow up to N parallel builds**: Use slots with
  the [Throttle Concurrent Builds Plugin](https://plugins.jenkins.io/throttle-concurrent-builds/) (most suitable).
* **Variant 3: Advanced throttling**: Use
  the [Lockable Resources Plugin](https://plugins.jenkins.io/lockable-resources/) for managing shared resources.

## GitHub

### Insert GitHub Blue Ocean pipeline

1. Create GitHub token: GitHub profile picture -> Settings -> Developer settings -> Personal access tokens -> Tokens
   (classic) -> Generate new token
2. Add credentials to Jenkins: Manage Jenkins -> Credentials -> System (Global) -> Add Credentials:
   Kind: Username with password; Username: GITHUBUSERNAME; Password: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx; ID:
   github; Description Token information.
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

3. Add public key to GitHub: GitHub profile picture -> Settings -> SSH and GPG keys -> New SSH key. Set title: Docker
   Jenkins GitHub Token

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

**NB!** These are just for quick developer setup, in production al need to be changed 

```
admin : bf69e89292704227868d15617de7e802
linux-0 :   0f79d1def5385b2a00dfe1c6ff0144155396ea9ca2973cd36732391b07c59d1b
            MGY3OWQxZGVmNTM4NWIyYTAwZGZlMWM2ZmYwMTQ0MTU1Mzk2ZWE5Y2EyOTczY2QzNjczMjM5MWIwN2M1OWQxYg==
linux-1 :   f56d068ca0ba7324d77667cb05f850572ae01355aa1e3de0b173ab0992066f5f
            ZjU2ZDA2OGNhMGJhNzMyNGQ3NzY2N2NiMDVmODUwNTcyYWUwMTM1NWFhMWUzZGUwYjE3M2FiMDk5MjA2NmY1Zg==
linux-2 :   0b94561ad7ce952fabfb1438fa2f3d8cb9e9261d35c2d4f5d48be92732e5e1f8
            MGI5NDU2MWFkN2NlOTUyZmFiZmIxNDM4ZmEyZjNkOGNiOWU5MjYxZDM1YzJkNGY1ZDQ4YmU5MjczMmU1ZTFmOA==
linux-3 :   0cc0f4ac954867af5a8c1dcc2732e76a96699f885bad58cb8761f8e761ebdee1
            MGNjMGY0YWM5NTQ4NjdhZjVhOGMxZGNjMjczMmU3NmE5NjY5OWY4ODViYWQ1OGNiODc2MWY4ZTc2MWViZGVlMQ==
linux-4 :   c3512f2137fe9a231576b5af2f435308f30aced3b2fa4993c60dd7ecbe389314
            YzM1MTJmMjEzN2ZlOWEyMzE1NzZiNWFmMmY0MzUzMDhmMzBhY2VkM2IyZmE0OTkzYzYwZGQ3ZWNiZTM4OTMxNA==
linux-5 :   27269d5306892af86c41f4d8d649e9259e70a0f6e9f3d996142d0a29b6c2059c
            MjcyNjlkNTMwNjg5MmFmODZjNDFmNGQ4ZDY0OWU5MjU5ZTcwYTBmNmU5ZjNkOTk2MTQyZDBhMjliNmMyMDU5Yw==
linux-6 :   3b6a8e053a5ae3da3589ec1d6c2604321daf10b77639b55a7317edef186093d2
            M2I2YThlMDUzYTVhZTNkYTM1ODllYzFkNmMyNjA0MzIxZGFmMTBiNzc2MzliNTVhNzMxN2VkZWYxODYwOTNkMg==
linux-7 :   60b6a21e1238ebc2473b60f21d27176c9c6068af55067e331fa48801a5dc2321
            NjBiNmEyMWUxMjM4ZWJjMjQ3M2I2MGYyMWQyNzE3NmM5YzYwNjhhZjU1MDY3ZTMzMWZhNDg4MDFhNWRjMjMyMQ==
linux-8 :   21a3fc302a962505ddd98ff9d746baf4006834eafc7301e7b246bb1a35accd3e 
            MjFhM2ZjMzAyYTk2MjUwNWRkZDk4ZmY5ZDc0NmJhZjQwMDY4MzRlYWZjNzMwMWU3YjI0NmJiMWEzNWFjY2QzZQ==
linux-9 :   92a9b1d3f154b34d0e85367f558905c8abbf31bcbab7f59ac1268294b4808b13 
            OTJhOWIxZDNmMTU0YjM0ZDBlODUzNjdmNTU4OTA1YzhhYmJmMzFiY2JhYjdmNTlhYzEyNjgyOTRiNDgwOGIxMw==
```

```
smi-jenkins-controller --host 0.0.0.0
# Or
docker run -it --name jenkins-controller -e SMI_JENKINS_ROLE=controller -p 7070:7070 setmyinfo/setmy-info-rocky-java-jenkins:latest

# In co
export SMI_JENKINS_SECRET=0f79d1def5385b2a00dfe1c6ff0144155396ea9ca2973cd36732391b07c59d1b
smi-jenkins-node --name linux-0 --workdir /home/SOME_USER/.setmy.info/.jenkins/nodes/linux-0

# Better to use: --env-file jenkins-node.env
docker run --name linux-0 \
    -e SMI_JENKINS_SECRET=0f79d1def5385b2a00dfe1c6ff0144155396ea9ca2973cd36732391b07c59d1b \
    -e SMI_JENKINS_ROLE=node \
    -e SMI_JENKINS_CONTROLLER_HOST=192.168.0.10 \
    -e SMI_JENKINS_CONTROLLER_PORT=7070 \
	-e SMI_JENKINS_WORKDIR=/var/lib/jenkins \
    -e SMI_JENKINS_NODE_NAME=linux-0 \
    -d setmyinfo/setmy-info-rocky-java-jenkins:latest
```

![Image](../resources/images/jenkinsfile-starter/master.png)

![Image](../resources/images/jenkinsfile-starter/release_1.0.0.png)

![Image](../resources/images/jenkinsfile-starter/develop.png)

![Image](../resources/images/jenkinsfile-starter/feature_something.png)

## See also

* [Jenkins official documentation](https://www.jenkins.io/doc/)
* [Jenkins Pipeline syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)
* [Blue Ocean](https://www.jenkins.io/doc/book/blueocean/)
* [Jenkins plugin index](https://plugins.jenkins.io/)
* [plugin-installation-manager-tool](https://github.com/jenkinsci/plugin-installation-manager-tool/releases?utm_source=chatgpt.com)
