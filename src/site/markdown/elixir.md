# Template

## Information

## Installation

### Rocky Linux

#### Git

```shell
cd ~/sources/others
git clone https://github.com/elixir-lang/elixir.git elixir
cd elixir

LATEST_TAG=$(git tag --sort=-version:refname \
  | grep '^v' \
  | grep -v -- '-rc' \
  | grep -v -- '-alpha' \
  | grep -v -- '-beta' \
  | head -n 1)
ELIXIR_VERSION=${LATEST_TAG#v}
echo "Latest Elixir stable tag: $LATEST_TAG ($ELIXIR_VERSION)"
git checkout "$LATEST_TAG"

make clean compile
sudo mkdir -p /opt/elixir-1.19.5
sudo cp -r . /opt/elixir-1.19.5
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```elixir
# ============================================================
# ELIXIR FUNCTIONAL PROGRAMMING PATTERNS - SINGLE BLOCK
# ============================================================

defmodule FPPatterns do
  # ==========================================================
  # 1. FUNCTION COMPOSITION
  # Idea: small functions are combined into a processing chain
  # ==========================================================

  def add1(x), do: x + 1
  def double(x), do: x * 2

  def composition_example(x) do
    x
    |> add1()    # first transformation
    |> double()  # second transformation
  end


  # ==========================================================
  # 2. HIGHER-ORDER FUNCTION
  # Idea: function that takes another function as argument
  # ==========================================================

  def apply_twice(fun, x) do
    x
    |> fun.()  # first application
    |> fun.()  # second application
  end


  # ==========================================================
  # 3. MAP / FILTER / REDUCE
  # Core FP collection operations
  # ==========================================================

  def map_filter_reduce(list) do
    list
    |> Enum.map(fn x -> x * 2 end)              # MAP: transform each element
    |> Enum.filter(fn x -> x > 4 end)           # FILTER: keep matching values
    |> Enum.reduce(0, fn x, acc -> x + acc end) # REDUCE: aggregate result
  end


  # ==========================================================
  # 4. PIPELINE PATTERN
  # Data flows step by step through functions
  # ==========================================================

  def trim(x), do: String.trim(x)
  def normalize(x), do: String.upcase(x)
  def validate(x), do: {:ok, x}
  def save(x), do: {:ok, "Saved: #{x}"}

  def pipeline(input) do
    input
    |> trim()
    |> normalize()
    |> validate()
    |> save()
  end


  # ==========================================================
  # 5. RESULT PATTERN (ok / error flow)
  # Railway-oriented programming style
  # ==========================================================

  def step1(x), do: {:ok, x + 1}
  def step2(x), do: {:ok, x * 2}
  def step3(x), do: {:ok, x - 3}

  def result_pipeline(x) do
    with {:ok, a} <- step1(x),
         {:ok, b} <- step2(a),
         {:ok, c} <- step3(b) do
      {:ok, c}
    end
  end


  # ==========================================================
  # 6. STRATEGY PATTERN
  # Function passed as argument (behavior injection)
  # ==========================================================

  def process(data, transform_fun) do
    transform_fun.(data)
  end


  # ==========================================================
  # 7. PARTIAL APPLICATION / ANONYMOUS FUNCTION
  # ==========================================================

  def replace_e(text) do
    String.replace(text, "e", "")
  end

  replace_e_fun = &String.replace(&1, "e", "")


  # ==========================================================
  # 8. FUNCTION COMPOSITION (manual implementation)
  # ==========================================================

  def compose(f, g) do
    fn x ->
      x |> f.() |> g.()
    end
  end


  # ==========================================================
  # 9. IMMUTABLE STATE TRANSFORMATION
  # ==========================================================

  def update_state(state) do
    Map.put(state, :updated, true)
  end
end


# ============================================================
# USAGE EXAMPLES
# ============================================================

defmodule MySaver do
  def save(value), do: {:ok, "Saved: #{value}"}
end

composition_result = FPPatterns.composition_example(10)
# => 22

apply_twice_result = FPPatterns.apply_twice(fn x -> x * 2 end, 5)
# => 20

map_filter_reduce_result = FPPatterns.map_filter_reduce([1, 2, 3, 4])
# => 14

pipeline_result = FPPatterns.pipeline("  hello  ")
# => {:ok, "Saved: HELLO"}

result_pipeline_result = FPPatterns.result_pipeline(10)
# => {:ok, 19}

process_result = FPPatterns.process("hello", &String.upcase/1)
# => "HELLO"

f = FPPatterns.compose(fn x -> x + 1 end, fn x -> x * 2 end)
composed_result = f.(10)
# => 22

user = %{
  name: "Mari",
  age: 30,
  greet: fn u -> "Hello " <> u.name end,
  bye: fn u -> "Bye " <> u.name end
}

greet_result = user.greet.(user)
# => "Hello Mari"
bye_result = user.bye.(user)
# => "Bye Mari"

user = %{}
user = Map.put(user, :name, "Mari")
user = Map.put(user, :age, 30)
# => %{name: "Mari", age: 30}

registry = %{
  trim: &String.trim/1,
  upcase: &String.upcase/1,
  save: &MySaver.save/1
}

config = [:trim, :upcase, :save]
input = "  hello  "

pipeline =
  Enum.map(config, fn step ->
    registry[step]
  end)

registry_pipeline_result =
  Enum.reduce(pipeline, input, fn fun, acc ->
    fun.(acc)
  end)
# => {:ok, "Saved: HELLO"}

%{
  composition_result: composition_result,
  apply_twice_result: apply_twice_result,
  map_filter_reduce_result: map_filter_reduce_result,
  pipeline_result: pipeline_result,
  result_pipeline_result: result_pipeline_result,
  process_result: process_result,
  composed_result: composed_result,
  greet_result: greet_result,
  bye_result: bye_result,
  updated_user: user,
  registry_pipeline_result: registry_pipeline_result
}

defmodule Person do
  defstruct first_name_fn: nil,
            last_name_fn: nil

  def new(f, l) when is_function(f, 0) and is_function(l, 0) do
    %Person{
      first_name_fn: f,
      last_name_fn: l
    }
  end
end


defmodule SetMyInfo.Gap do

  def as_first_name(value) do
    fn -> value end
  end

  def as_last_name(value) do
    fn -> value end
  end

  def data_builder(first_name, last_name) do
    first = first_name.()
    last = last_name.()

    transform(first) <> " " <> transform(last)
  end

  defp transform(value) when is_binary(value) do
    case rem(:rand.uniform(100), 2) do
      0 -> String.upcase(value)
      1 -> String.downcase(value)
    end
  end

  def person_data_builder(%Person{} = person) do
    first = person.first_name_fn.()
    last  = person.last_name_fn.()

    transform(first) <> " " <> transform(last)
  end
end

result =
  SetMyInfo.Gap.data_builder(
    SetMyInfo.Gap.as_first_name("John"),
    SetMyInfo.Gap.as_last_name("Doe")
  )

person =
  Person.new(
    SetMyInfo.Gap.as_first_name("John"),
    SetMyInfo.Gap.as_last_name("Doe")
  )

person_string =
  SetMyInfo.Gap.person_data_builder(person)

IO.inspect(result, label: "Result")
IO.inspect(person_string, label: "Person Result")
```

## Most Common Production Technologies in the Elixir Ecosystem (2026)

This is a clean, production-focused overview of the most commonly used Elixir ecosystem technologies, including web,
data, authentication (Keycloak + JWT), APIs, observability, and infrastructure.

### 📦 Core Data & Database Layer

| Name                      | Description                                                                                        |
|---------------------------|----------------------------------------------------------------------------------------------------|
| Ecto                      | Standard database toolkit in Elixir. Provides query building, schemas, changesets, and migrations. |
| PostgreSQL                | Primary relational database used in most Elixir production systems.                                |
| Bolt.Sips                 | Neo4j driver for Elixir, used to connect Elixir applications to Neo4j over the Bolt protocol.      |
| ETS (Erlang Term Storage) | High-performance in-memory key-value store for caching and state.                                  |
| Mnesia                    | Erlang distributed database, used in niche distributed systems and internal state management.      |

### 🌐 Web, API & Framework Layer

| Name              | Description                                                                    |
|-------------------|--------------------------------------------------------------------------------|
| Phoenix Framework | Main web framework for building APIs, MVC applications, and real-time systems. |
| Plug              | HTTP middleware layer used to compose request/response pipelines.              |
| Bandit            | Modern HTTP server for Elixir, used in newer Phoenix deployments.              |
| Phoenix LiveView  | Real-time server-rendered UI without requiring a JavaScript SPA.               |
| Phoenix Channels  | WebSocket-based real-time communication layer.                                 |

### 🔐 Authentication, Identity & Security (Keycloak + JWT)

| Name                 | Description                                                                              |
|----------------------|------------------------------------------------------------------------------------------|
| Keycloak             | Identity and access management system (SSO, OAuth2, OpenID Connect, M2M authentication). |
| OAuth 2.0            | Standard authorization framework used for delegated and machine-to-machine access.       |
| OpenID Connect       | Identity layer on top of OAuth2 for authentication and identity verification.            |
| JWT (JSON Web Token) | Stateless token format used for authentication and service-to-service communication.     |
| Joken                | Elixir library for encoding and verifying JWT tokens.                                    |
| JOSE                 | Low-level cryptographic library for signing and verifying JWT/JWS/JWE.                   |
| Guardian             | Authentication library for Phoenix applications using JWT pipelines and guards.          |

### ⚙️ Background Jobs & Async Processing

| Name      | Description                                             |
|-----------|---------------------------------------------------------|
| Oban      | Production job processing library built on PostgreSQL.  |
| GenServer | Core OTP abstraction for stateful concurrent processes. |
| Quantum   | Cron-style scheduler for periodic tasks.                |

### 🔌 API Communication & Microservices

| Name             | Description                                                                                                    |
|------------------|----------------------------------------------------------------------------------------------------------------|
| gRPC             | High-performance RPC framework for service-to-service communication.                                           |
| GraphQL          | API query language used in Elixir via libraries like Absinthe.                                                 |
| Broadway         | Data ingestion and streaming pipeline (Kafka, SQS, etc.).                                                      |
| AMQP             | Elixir client library commonly used to communicate with RabbitMQ over the AMQP protocol.                       |
| :eldap           | Built-in Erlang/OTP LDAP client that Elixir applications can use for LDAP authentication and directory access. |
| Tortoise         | De facto standard MQTT client for Elixir.                                                                      |
| EMQX ExMQTT      | Elixir wrapper around the `emqtt` MQTT client from EMQX.                                                       |
| Phoenix Channels | Real-time WebSocket communication layer.                                                                       |

### 📄 API Documentation (Swagger / OpenAPI Equivalent)

| Name                  | Description                                                                       |
|-----------------------|-----------------------------------------------------------------------------------|
| OpenAPI Specification | Standard format for describing REST APIs (Swagger equivalent in Java ecosystems). |
| OpenApiSpex           | Elixir library for generating and validating OpenAPI specifications from code.    |
| Phoenix Framework     | Often used to expose OpenAPI JSON endpoints and integrate API documentation.      |

### 🧠 Architecture & Domain Design

| Name             | Description                                                                           |
|------------------|---------------------------------------------------------------------------------------|
| Ash Framework    | High-level domain-driven framework for APIs, policies, and business logic automation. |
| Phoenix Contexts | Recommended pattern for structuring business logic into domain boundaries.            |
| Protocols        | Elixir language feature enabling polymorphism similar to interfaces in OOP languages. |

### 📡 Observability & Monitoring

| Name       | Description                                                        |
|------------|--------------------------------------------------------------------|
| Telemetry  | Standard instrumentation library for metrics and events.           |
| Prometheus | Metrics collection and alerting system widely used in production.  |
| Grafana    | Visualization and dashboarding for metrics and observability data. |
| Sentry     | Error tracking and monitoring platform for production systems.     |

### 🧪 Testing

| Name       | Description                                            |
|------------|--------------------------------------------------------|
| ExUnit     | Built-in testing framework in Elixir.                  |
| Mox        | Mocking library based on behaviours and contracts.     |
| StreamData | Property-based testing library inspired by QuickCheck. |

### 📦 Build & Development Tools

| Name | Description                                                          |
|------|----------------------------------------------------------------------|
| Mix  | Build tool for dependency management, compilation, and task running. |
| Hex  | Package manager and registry for Elixir dependencies.                |
| IEx  | Interactive Elixir shell (REPL) for debugging and development.       |

### 🚀 Deployment & Infrastructure

| Name       | Description                                                       |
|------------|-------------------------------------------------------------------|
| Docker     | Containerization platform used for deploying Elixir applications. |
| Kubernetes | Container orchestration system for scalable distributed systems.  |
| Fly.io     | Popular hosting platform for Elixir and Phoenix applications.     |
| Gigalixir  | Managed platform specifically designed for Elixir deployments.    |
| Nerves     | Framework and platform for building embedded systems with Elixir. |

### 🧩 Summary

A typical modern Elixir production stack looks like:

- **Phoenix** → web & APIs
- **Ecto + PostgreSQL** → data layer
- **OTP (GenServer)** → concurrency & state
- **Oban** → background jobs
- **Keycloak + JWT** → authentication & M2M security
- **OpenAPI + OpenApiSpex** → API documentation
- **Telemetry + Prometheus** → observability

Elixir's ecosystem is intentionally small but highly composable, relying on a few strong primitives rather than large
monolithic frameworks.

### Coding tips and tricks

## See also

* [Nerves Project](https://nerves-project.org/)
* [Tortoise](https://github.com/gausby/tortoise)
* [EMQX ExMQTT](https://github.com/emqx/exmqtt)
* [xxxx](http://yyyyy)
* [Erlang Package Repo](https://hex.pm/)
