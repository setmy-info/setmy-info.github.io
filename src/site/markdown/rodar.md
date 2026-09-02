# Rodar

## Information

Rodar is an open-source, lightweight BPMN 2.0 workflow execution engine built natively in Elixir for the BEAM ecosystem. It enables systems to parse and execute standard business process models directly within Elixir and Phoenix applications with high concurrency, fault tolerance, and low latency.

### Key Features

* **BPMN 2.0 Execution**: Executes standard BPMN XML models natively on BEAM.
* **OTP Concurrency & Fault Tolerance**: Isolates process instances into lightweight BEAM processes with supervision trees.
* **Embedded Architecture**: Eliminates the overhead of external JVM-based workflow engines when building Elixir-native architectures.
* **Asynchronous & Event-Driven**: Seamlessly integrates with message queues, Phoenix PubSub, and external APIs.

## Use Cases

* **Microservices & API Orchestration**: Coordinating multi-step service interactions, compensation flows, and distributed transactions using visual workflow definitions.
* **Long-Running Business Processes**: Managing stateful workflows such as user onboarding, KYC verification, order processing, and subscription lifecycle management.
* **Event-Driven Automation**: Executing high-throughput, reactive pipelines that respond to real-time events and telemetry data.
* **Human-in-the-Loop Workflows**: Handling approval chains, manual reviews, and user task assignments combined with automated background processing.
* **Elixir-Native BPMN Integration**: Running executable business workflows directly inside Elixir/Phoenix applications without maintaining external Java/Camunda/Zeebe clusters.

## Installation

Add `rodar` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rodar, "~> 0.1"}
  ]
end
```

Then fetch the dependencies:

```shell
mix deps.get
```

## Usage

### Loading and Executing a BPMN Process

```elixir
# Load a BPMN XML definition
bpmn_xml = File.read!("priv/workflows/order_fulfillment.bpmn")

# Start a process instance with initial variables
{:ok, process_instance} = Rodar.start_process(bpmn_xml, %{
  "order_id" => "ORD-12345",
  "amount" => 99.95,
  "customer_email" => "user@example.com"
})

# Complete tasks or handle events
Rodar.complete_task(process_instance, "validate_payment", %{"payment_status" => "approved"})
```

## See also

* [Elixir](elixir.md)
* [Zeebe](zeebe.md)
* [Argo Workflows](argo.md)
* [Process](process.md)
* [BPMN 2.0 Specification](https://www.omg.org/spec/BPMN/2.0/)
