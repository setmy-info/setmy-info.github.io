# Knative

`Knative` is an open-source platform layer on top of `Kubernetes` for serverless-style application serving and
event-driven workloads.

Website:

* [knative.dev](https://knative.dev/)
* [Knative docs](https://knative.dev/docs/)

## Information

`Knative` helps teams build request-driven services and event-driven flows on `Kubernetes` without starting from raw
cluster primitives alone.

It is usually discussed through two major areas:

* `Knative Serving`,
* `Knative Eventing`.

### Main functionalities and features

* **Serving**: deploy and route containerized applications with serverless-style behavior,
* **Autoscaling**: scale workloads up and down, including toward very low usage,
* **Revisions**: keep versioned immutable snapshots of deployments,
* **Traffic splitting**: send percentages of traffic to different revisions,
* **Eventing**: route events between producers and consumers,
* **`Kubernetes` foundation**: good fit for teams that want open serverless building blocks on their own clusters.

### Core concepts

#### Knative Serving

`Serving` focuses on request-driven workloads. It helps expose containerized applications while handling routing,
revisions, scaling, and rollout patterns.

#### Revisions and traffic management

A revision represents a version of the service configuration. This is useful for canary rollout, quick rollback, and
controlled traffic migration.

#### Autoscaling

`Knative` is known for request-aware scaling behavior, which is valuable when workloads are bursty or idle for long
periods.

#### Knative Eventing

`Eventing` provides building blocks such as brokers, triggers, and event delivery patterns so systems can exchange
events in a more structured way.

## When it can be useful

`Knative` can be a strong fit when:

* your team already runs `Kubernetes`,
* you want more than basic container deployment,
* serverless-style routing and autoscaling are important,
* you need version-aware rollout and traffic splitting,
* request-driven services and event-driven flows should use a consistent platform model.

Typical use cases:

* internal platform engineering,
* `API` backends with bursty demand,
* event consumers,
* canary rollout with traffic percentages,
* platforms that want a base for higher-level developer workflows.

## Getting started

For a safe evaluation path:

1. confirm your `Kubernetes` environment and ingress approach,
2. start with `Serving` before introducing all eventing patterns,
3. deploy one simple containerized service,
4. test scaling, revision creation, and traffic splitting,
5. add `Eventing` only when there is a real producer-consumer need.

Useful early questions:

* whether your cluster networking and ingress model are ready,
* how service exposure should work,
* whether workloads tolerate scale-to-low or scale-from-low behavior,
* what observability is required,
* how event delivery and retry semantics should work,
* who owns the platform layer operationally.

## Tips and tricks

* Keep the first rollout simple and focus on one real application.
* Use revisions and traffic splitting intentionally instead of treating them as only optional extras.
* Validate startup time, concurrency, and scaling behavior with realistic traffic.
* Define platform standards for `TLS`, ingress, logging, and metrics early.
* Use `Eventing` for clear event contracts, not as a replacement for all messaging or workflow design.

## Things to watch

* `Knative` adds platform capability, but also operational complexity.
* Networking and ingress choices matter a lot.
* Scale behavior and cold-start characteristics must be validated with real workloads.
* Event-driven systems need careful contract, retry, and idempotency design.
* Teams should avoid installing it only because it is popular; it should solve a real platform need.

## Where it fits best

`Knative` fits best for:

* platform teams on `Kubernetes`,
* request-driven services with variable load,
* canary and progressive delivery patterns,
* event-driven services that benefit from shared platform abstractions.

## See also

* [Kubernetes](kubernetes.md)
* [OpenFaaS](openfaas.md)
* [Apache OpenWhisk](openwhisk.md)
* [Terraform](terraform.md)
* [Knative](https://knative.dev/docs/)
