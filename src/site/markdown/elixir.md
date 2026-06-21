# Elixir

## Information

Elixir is a functional, concurrent, and fault-tolerant programming language built on the Erlang VM (BEAM). It was
created by José Valim and first released in 2012. Elixir inherits Erlang's actor-model concurrency, distributed
system capabilities, and legendary fault tolerance, while providing a modern Ruby-inspired syntax and a rich
macro system.

Common use cases: web APIs (Phoenix framework), real-time systems (Phoenix Channels / LiveView), embedded systems
(Nerves), data pipelines (Broadway), IoT (Tortoise MQTT).

## Installation

### Rocky Linux

Package manager:

```shell
sudo dnf install -y elixir erlang
elixir --version
```

Build from source (latest stable):

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
sudo mkdir -p /opt/elixir-${ELIXIR_VERSION}
sudo cp -r . /opt/elixir-${ELIXIR_VERSION}
```

### Fedora

```shell
sudo dnf install -y elixir erlang
```

### Debian

```shell
sudo apt install -y elixir erlang
```

### FreeBSD

```shell
pkg install elixir
```

## Configuration

Elixir projects are managed with **Mix** (the build tool bundled with Elixir):

```shell
mix new my_project          # create a new project
cd my_project
mix deps.get                # install dependencies (from mix.exs)
mix compile                 # compile
mix test                    # run tests
```

`mix.exs` is the project manifest — defines dependencies (`deps/0`), application name, and version.

`hex` is the package manager:

```shell
mix hex.info                # check hex is available
mix hex.search phoenix      # search packages
```

`.iex.exs` in your home directory or project root is loaded when starting `iex` — use it for convenience aliases
and module imports:

```elixir
# ~/.iex.exs
IEx.configure(inspect: [limit: 50])
```

## Usage, tips and tricks

Interactive shell:

```shell
iex          # start REPL
iex -S mix   # start REPL with project loaded
```

Create and run a Phoenix project:

```shell
mix archive.install hex phx_new
mix phx.new my_web_app
cd my_web_app
mix deps.get
mix phx.server
```

Functional programming patterns with the pipe operator:

```elixir
defmodule FPPatterns do
  def add1(x), do: x + 1
  def double(x), do: x * 2

  def composition_example(x) do
    x
    |> add1()
    |> double()
  end

  def map_filter_reduce(list) do
    list
    |> Enum.map(fn x -> x * 2 end)
    |> Enum.filter(fn x -> x > 4 end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end
end
```

Result/error flow (railway-oriented programming):

```elixir
def result_pipeline(x) do
  with {:ok, a} <- step1(x),
       {:ok, b} <- step2(a),
       {:ok, c} <- step3(b) do
    {:ok, c}
  end
end
```

## Most Common Production Technologies (2026)

### Core Data & Database Layer

| Name      | Description                                                          |
|-----------|----------------------------------------------------------------------|
| Ecto      | Standard database toolkit — query building, schemas, migrations      |
| PostgreSQL | Primary relational database in most Elixir production systems       |
| ETS       | High-performance in-memory key-value store for caching and state     |

### Web, API & Framework Layer

| Name             | Description                                                     |
|------------------|-----------------------------------------------------------------|
| Phoenix Framework | Main web framework for APIs, MVC apps, and real-time systems  |
| Phoenix LiveView | Real-time server-rendered UI without a JavaScript SPA           |
| Phoenix Channels | WebSocket-based real-time communication layer                   |

### Authentication & Security

| Name    | Description                                                          |
|---------|----------------------------------------------------------------------|
| Joken   | Elixir library for encoding and verifying JWT tokens                 |
| Guardian | Authentication library for Phoenix using JWT pipelines             |
| Keycloak | SSO / OAuth2 / OpenID Connect identity provider                   |

### Background Jobs & Messaging

| Name    | Description                                                      |
|---------|------------------------------------------------------------------|
| Oban    | Production job processing library built on PostgreSQL            |
| Broadway | Data ingestion and streaming pipeline (Kafka, SQS, etc.)       |
| Tortoise | MQTT client for IoT and messaging                              |

### Testing

| Name       | Description                                               |
|------------|-----------------------------------------------------------|
| ExUnit     | Built-in testing framework                                |
| Mox        | Mocking library based on behaviours                       |
| StreamData | Property-based testing (QuickCheck style)                 |

## See also

* [Elixir official documentation](https://elixir-lang.org/)
* [Hex package manager](https://hex.pm/)
* [HexDocs](https://hexdocs.pm/)
* [Phoenix Framework](https://www.phoenixframework.org/)
* [Nerves Project](https://nerves-project.org/)
* [Tortoise MQTT](https://github.com/gausby/tortoise)
* [EMQX ExMQTT](https://github.com/emqx/exmqtt)
* [Erlang](erlang.md)
