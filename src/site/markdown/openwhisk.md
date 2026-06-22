# Apache OpenWhisk

`Apache OpenWhisk` is an open-source `serverless` platform for running event-driven functions and composing them into
larger workflows.

Website:

* [openwhisk.apache.org](https://openwhisk.apache.org/)
* [OpenWhisk documentation](https://openwhisk.apache.org/documentation.html)

## Information

`OpenWhisk` is useful when you want to execute short-lived logic in response to events without managing every service as
a long-running application.

In practical platform work, it is commonly relevant for:

* event-driven backend tasks,
* `API`-triggered automation,
* scheduled jobs,
* lightweight integrations between systems,
* serverless experiments on `Kubernetes` or other infrastructure.

### Main functionalities and features

* **Actions**: deploy individual functions in supported runtimes,
* **Triggers and rules**: react to events and connect them to actions,
* **Packages**: group related actions and metadata,
* **Sequences**: compose multiple actions into one flow,
* **Web actions**: expose functions through `HTTP`,
* **Event-driven model**: good fit for asynchronous or reactive automation.

### Core concepts

#### Actions

An action is the executable unit in `OpenWhisk`. It can be written in languages such as `JavaScript`, `Python`, `Java`,
or other supported runtimes.

#### Triggers

Triggers represent events. A trigger can be fired explicitly or by an integration that observes something happening in
another system.

#### Rules

Rules connect triggers to actions. This makes it possible to create event-driven flows without writing a full custom
dispatcher service.

#### Packages

Packages help organize actions and can also expose reusable integrations.

#### Sequences

Sequences allow you to build larger workflows from smaller actions, which is useful when one function should stay small
and focused.

## When it can be useful

`OpenWhisk` can be a strong fit when:

* you want to process events instead of running a full application permanently,
* you need small units of backend logic with clear triggers,
* you want to prototype integrations quickly,
* you are building automation around messages, schedules, or webhooks,
* your team wants more control than a fully managed cloud-only serverless product provides.

Typical use cases:

* webhook receivers,
* file-processing tasks,
* scheduled maintenance jobs,
* event enrichment,
* notification and integration flows.

## Getting started

A practical adoption path is usually:

1. define one narrow event-driven use case,
2. choose the runtime and deployment model,
3. create a small action that accepts clear input and returns simple output,
4. connect it to an `HTTP` request, trigger, or scheduled event,
5. observe logs, failures, and retry behavior before broadening usage.

Early evaluation questions:

* what events should start execution,
* how long can the function run,
* where state should live,
* how secrets are provided,
* how invocation history and failures are observed,
* how function packaging and deployment fit the current platform.

## Operational tips and tricks

* Keep actions small and stateless where possible.
* Put durable state in external systems such as databases, queues, or object storage.
* Design payloads and contracts carefully, because event-driven systems become hard to debug when inputs are unclear.
* Use sequences for composition, but avoid building very large opaque chains.
* Watch cold-start behavior, timeout limits, and retry behavior for real production workloads.
* Track observability early: logs, invocation metrics, error rates, and event throughput matter.

## Things to watch

* Serverless does not remove the need for architecture and operations.
* Debugging cross-function event flows can be harder than debugging one service.
* Vendor-neutral open platforms still need strong packaging, security, and monitoring practices.
* Long-running or highly stateful workloads may fit a service model better than a function model.
* Event contracts should be versioned carefully when many producers and consumers exist.

## Where it fits best

`Apache OpenWhisk` fits best for teams that want:

* open-source `serverless` concepts,
* event-driven backend automation,
* function composition,
* more platform control than fully managed cloud-only offerings.

It is less ideal when:

* workloads are long-running and state-heavy,
* the team has weak event and observability practices,
* deployment and runtime simplicity are more important than flexibility.

## See also

* [Kubernetes](kubernetes.md)
* [Knative](knative.md)
* [OpenFaaS](openfaas.md)
* [Terraform](terraform.md)
* [Apache OpenWhisk](https://openwhisk.apache.org/)
