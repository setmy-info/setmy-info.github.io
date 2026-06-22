# OpenFaaS

`OpenFaaS` is an open-source framework for building and running functions on top of `Kubernetes` and related
container-based platforms.

Website:

* [openfaas.com](https://www.openfaas.com/)
* [OpenFaaS docs](https://docs.openfaas.com/)

## Information

`OpenFaaS` gives teams a practical way to run functions while still using familiar container and `Kubernetes`
operations. It is often used when a team wants serverless-style packaging and scaling without giving up cluster-level
control.

### Main functionalities and features

* **Function packaging**: create functions from templates and container images,
* **Gateway model**: route requests and manage deployments through the gateway,
* **Autoscaling**: scale functions based on demand,
* **Queue-based async execution**: support asynchronous invocation patterns,
* **Template ecosystem**: accelerate adoption across several runtimes,
* **`Kubernetes` integration**: good fit for teams already operating clusters.

### Core building blocks

#### Gateway

The gateway is the main entry point for deployment and invocation workflows.

#### Functions

Functions are usually packaged as container images and deployed with metadata such as environment variables, secrets,
and scaling behavior.

#### Templates

Templates help standardize how functions are written and built in different languages.

#### Async and queue workers

`OpenFaaS` supports queue-based patterns so workloads do not need to be handled only as direct synchronous requests.

## When it can be useful

`OpenFaaS` is useful when:

* the team already uses `Kubernetes`,
* you want practical serverless patterns in your own cluster,
* functions should be deployed like containers,
* synchronous and asynchronous execution are both important,
* developers want a straightforward path from code to function image.

Typical use cases:

* webhook handlers,
* lightweight `API` backends,
* file or image processing,
* asynchronous background jobs,
* automation around internal tools.

## Getting started

A practical adoption path usually looks like this:

1. start with one low-risk function,
2. install `OpenFaaS` in a development cluster,
3. pick a function template and deploy a simple `HTTP` function,
4. validate logging, secrets, and scaling behavior,
5. test one asynchronous use case before wider rollout.

Useful evaluation questions:

* whether all target workloads fit the function model,
* how secrets and configuration are handled,
* whether cold starts are acceptable,
* how much traffic variability must be absorbed,
* how the gateway is exposed and secured,
* what build pipeline should produce and scan function images.

## Tips and tricks

* Use `OpenFaaS` for small, well-bounded functions instead of replacing every service with functions.
* Treat images, templates, and secrets as part of the platform contract.
* Measure scaling and startup time under realistic load.
* Keep observability in place from day one: request rate, latency, failures, queue depth, and function execution time.
* If the cluster hosts many workloads, define resource limits carefully so bursty functions do not starve other
  services.

## Things to watch

* Function platforms still require operational ownership.
* Not every workload benefits from serverless packaging.
* Queue-based execution needs explicit retry and idempotency design.
* Teams should avoid mixing too many deployment styles without clear standards.
* Security of the gateway, function images, and secret handling must be reviewed carefully.

## Where it fits best

`OpenFaaS` fits best for:

* `Kubernetes`-oriented teams,
* internal serverless platforms,
* function-style automation,
* event and webhook processing,
* teams that prefer open tooling over fully managed cloud-only function services.

## See also

* [Kubernetes](kubernetes.md)
* [Knative](knative.md)
* [Apache OpenWhisk](openwhisk.md)
* [Terraform](terraform.md)
* [OpenFaaS](https://www.openfaas.com/)
