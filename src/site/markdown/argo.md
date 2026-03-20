# Argo Workflows

## Information

### Introduction

Argo Workflows is an open source container-native workflow engine for orchestrating parallel jobs on Kubernetes.
Argo Workflows is implemented as a Kubernetes CRD (Custom Resource Definition).

### Similar Software

* **[LangGraph](https://www.langchain.com/langgraph):** While focused on building stateful, multi-actor applications
  with LLMs, LangGraph is similar to Argo in that it uses a graph-based (specifically Directed Acyclic Graph or state
  machine) approach to orchestrate complex workflows. LangGraph is often used for AI agentic workflows.
* **[Apache Airflow](https://airflow.apache.org/):** A platform to programmatically author, schedule and monitor
  workflows. Like Argo, it uses Directed Acyclic Graphs (DAGs) to manage workflow dependencies, but typically runs on
  more traditional infrastructure or via Celery/Kubernetes executors.
* **[Tekton](https://tekton.dev/):** A powerful and flexible open-source framework for creating CI/CD systems, allowing
  developers to build, test, and deploy across cloud providers and on-premise systems. It is also Kubernetes-native.
* **[Prefect](https://www.prefect.io/):** A modern workflow orchestration tool that simplifies building, running, and
  monitoring data pipelines. It emphasizes "negative engineering" and provides a Python-first developer experience.
* **[Temporal](https://temporal.io/):** An open-source workflow engine that manages state, retries, and error handling
  for distributed applications, often used for long-running processes.

## Installation

```shell
ARGO_VERSION=4.0.2
#ARGO_VERSION=3.5.15
kubectl create namespace argo
kubectl apply --server-side -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v${ARGO_VERSION}/quick-start-minimal.yaml
#kubectl apply --server-side -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v%ARGO_VERSION%/quick-start-minimal.yaml

#?
kubectl patch deployment argo-server --namespace argo --type=json -p="[{\"op\":\"replace\",\"path\":\"/spec/template/spec/containers/0/args\",\"value\":[\"server\",\"--auth-mode=server\"]}]"
kubectl -n argo port-forward service/argo-server 2746:2746
#kubectl -n argo port-forward svc/argo-server 2746:2746
#kubectl -n argo port-forward service/argo-server 8080:2746
# Trust in Firefox Self signed certs from https://127.0.0.1
firefox --new-tab https://localhost:2746

argo submit -n argo --watch https://raw.githubusercontent.com/argoproj/argo-workflows/main/examples/hello-world.yaml

argo list -n argo
argo get hello-world-2qvr7 -n argo
argo get  hello-world-zglf9 -n argo
argo logs @latest -n argo
argo logs hello-world-2qvr7 -n argo
argo logs hello-world-zglf9 -n argo
argo delete hello-world-2qvr7 hello-world-zglf9 -n argo

#Same with kubectl:
wget -c https://raw.githubusercontent.com/argoproj/argo-workflows/main/examples/hello-world.yaml -O hello-world.yaml
kubectl create -f hello-world.yaml
kubectl get pods -n argo
kubectl get wf -n argo
kubectl get wf hello-world-2qvr7 -n argo
kubectl get wf hello-world-zglf9 -n argo
kubectl get po --selector=workflows.argoproj.io/workflow=hello-world-2qvr7 -n argo
kubectl get po --selector=workflows.argoproj.io/workflow=hello-world-zglf9 -n argo
kubectl logs hello-world-2qvr7 -c main -n argo
kubectl logs hello-world-zglf9 -c main -n argo
kubectl delete wf hello-world-2qvr7 -n argo
kubectl delete wf hello-world-zglf9 -n argo
kubectl delete pods -n argo -l workflows.argoproj.io/completed=true

argo delete --completed --all-namespaces

# Re-setup
ARGO_VERSION=4.0.2
# TODO : notes about stop, delete, ..
kubectl create namespace argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v${ARGO_VERSION}/quick-start-minimal.yaml
```

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Code Review Workflow

A specialized workflow for automated code reviews of multiple repositories can be found in the template and review directories. 
Specifically, the version in `src/site/resources/argo/review/` is pre-configured for **Minikube** with host folder sharing.

The workflow performs the following steps:
1.  **Cleanup:** Removes previous `CODE-REVIEW.md`, `TASKLIST.md`, and `diff.patch`.
2.  **Diff Generation:** Generates a `diff.patch` for a specific repository folder (`clones/{{repo-name}}`) using from/to commit hashes.
3.  **Tasklist:** Executes `smi-build-tasklist` on the manually cloned repositories in the `clones` folder to generate `TASKLIST.md`.
4.  **Review:** Performs a non-interactive code review by executing the `TASKLIST.md`, saving results to `CODE-REVIEW.md`.

#### Minikube Setup (Windows)

To use the code review workflow on Minikube with your local host folder, first mount the folder:

```powershell
minikube mount C:\pub\setmy.info\data\minikube:/var/opt/setmy.info/minikube
```

Then manually clone your repositories into `C:\pub\setmy.info\data\minikube\clones\`. You can use the provided `prepare.cmd` script to automate cloning and submission:

```cmd
cd src\site\resources\argo\review
# Usage: prepare.cmd <repo_url> <repo_name> <repo_branch> <from_commit> <to_commit>
prepare.cmd git@bitbucket.org:example/example-app.git example-app master HEAD~1 HEAD
```

If you need to clone multiple "secondary" repositories, you can create a file named `secondary-clones.cmd` in the same directory as `prepare.cmd`. If this file exists, it will be automatically called by `prepare.cmd` to perform additional cloning operations. Example `secondary-clones.cmd`:

```cmd
@echo off
call clone-repo.cmd git@bitbucket.org:example/example-app2.git example-app2 master
call clone-repo.cmd git@bitbucket.org:example/example-additional-repo.git example-additional master
```

Apply the supporting resources from `src/site/resources/argo/review/` (ensure `03-argo-secrets-map.yaml` is updated with your `anthropic-api-key`):

```shell
kubectl apply -f src/site/resources/argo/review/00-argo-namespace.yaml
kubectl apply -f src/site/resources/argo/review/01-argo-host-path-persistent-volume.yaml
kubectl apply -f src/site/resources/argo/review/02-argo-host-path-persistent-volume-claim.yaml
kubectl apply -f src/site/resources/argo/review/03-argo-secrets-map.yaml
kubectl apply -f src/site/resources/argo/review/04-argo-role.yaml
kubectl apply -f src/site/resources/argo/review/05-argo-rolebinding.yaml
```

To submit this workflow with specific parameters:

```shell
# Basic submit (uses default HEAD~1..HEAD)
argo submit -n review src/site/resources/argo/review/argo-code-review.yaml

# Submit for a specific repo and commit range
argo submit -n review src/site/resources/argo/review/argo-code-review.yaml \
  -p repo-name=my-repository \
  -p from-commit=v1.0.0 \
  -p to-commit=v1.1.0
```

The default `working-dir` is set to `/var/opt/setmy.info/minikube`.

**templates[n].nodeSelector** for selecting concrete node type (OS, platform) from K8s to run images

## See also

* [Argo Workflows Home](https://argoproj.github.io/argo-workflows/)
* [Quick Start](https://argoproj.github.io/argo-workflows/quick-start/)
* [Argo CLI](https://argoproj.github.io/argo-workflows/walk-through/argo-cli/)
* [Argo & K8s secrets](https://argoproj.github.io/argo-workflows/walk-through/secrets/)
* **[Terraform K8s Setup](terraform.md):** Guide for setting up EKS (AWS) or GKE (GCP) clusters using Terraform, ready
  for Argo Workflows.
* [Apache NiFi](https://nifi.apache.org/)
* [Apache Oozie](https://oozie.apache.org/)
* [LangChain](langchain.md)
* [AI Agent](agent.md)
* [K8s](kubernetes.md)
