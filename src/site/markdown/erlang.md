# Erlang

## Information

Erlang is a concurrent, fault-tolerant, distributed functional programming language originally developed by
Ericsson for telecommunications systems. It runs on the BEAM (Bogdan/Björn's Erlang Abstract Machine) virtual
machine, which provides lightweight processes, message passing (actor model), hot code swapping (upgrade running
systems without downtime), and built-in distribution across nodes. Erlang systems are known for achieving
nine-nines (99.9999999%) uptime in production.

Key concepts:

- **Processes**: Lightweight BEAM processes (not OS threads); millions can run concurrently with low memory overhead.
- **Message passing**: Processes communicate by sending immutable messages to each other's mailboxes.
- **OTP**: Open Telecom Platform — reusable libraries and design principles (gen_server, supervisor, application).
- **Hot code swapping**: Deploy new code to a running system without stopping it.
- **Let it crash**: Supervisors restart failed processes rather than defensive error handling in every function.

Elixir is a modern language that also runs on BEAM and interoperates with Erlang libraries. See [elixir.md](elixir.md).

## Installation

### Rocky Linux / CentOS

```shell
sudo dnf install erlang
```

#### Build from source (latest version)

```shell
sudo dnf groupinstall "Development Tools" -y
sudo dnf install -y \
  gcc gcc-c++ make perl wget tar xz unzip git \
  ncurses-devel \
  openssl-devel \
  unixODBC-devel \
  wxWidgets \
  wxGTK-devel \
  libxslt

cd ~/sources/others
git clone https://github.com/erlang/otp.git erlang
cd erlang

LATEST_TAG=$(git tag --sort=-version:refname | grep '^OTP-' | grep -v -- '-rc' | head -n 1)
ERLANG_VERSION=${LATEST_TAG#OTP-}
echo "Latest OTP tag: $LATEST_TAG ($ERLANG_VERSION)"
git checkout "$LATEST_TAG"

# https://github.com/erlang/otp/issues/7694
export KERL_CONFIGURE_OPTIONS="--without-wx --without-debugger --without-observer --without-et --without-javac"
./configure --prefix=/opt/erlang-$ERLANG_VERSION --without-wx --without-debugger --without-observer --without-et --without-javac

make
sudo make install
```

### Fedora

```shell
sudo dnf install erlang
```

### Debian / Ubuntu

```shell
sudo apt install erlang
```

### FreeBSD

```shell
pkg install erlang
```

## Configuration

### rebar3

`rebar3` is the standard Erlang build tool. Install it:

```shell
wget https://s3.amazonaws.com/rebar3/rebar3
chmod +x rebar3
sudo mv rebar3 /usr/local/bin/
```

Create a new OTP application:

```shell
rebar3 new app myapp
```

Key `rebar.config` settings:

```erlang
{erl_opts, [debug_info]}.
{deps, [
    {jsx, "3.1.0"}
]}.
```

### Distributed node cookie

Erlang distributed nodes authenticate via a shared `.erlang.cookie` file:

```shell
echo "mysecretcookie" > ~/.erlang.cookie
chmod 400 ~/.erlang.cookie
```

All nodes in a cluster must have the same cookie value.

## Usage, tips and tricks

### Interactive REPL

```shell
erl
```

Exit with `q().` or `Ctrl+C`. Example session:

```erlang
1> lists:map(fun(X) -> X * 2 end, [1, 2, 3]).
[2,4,6]
2> erlang:node().
nonode@nohost
```

### Compile and run a module

```erlang
% hello.erl
-module(hello).
-export([world/0]).

world() ->
    io:format("Hello, world!~n").
```

```shell
erlc hello.erl
erl -noshell -s hello world -s init stop
```

### OTP gen_server skeleton

```erlang
-module(my_server).
-behaviour(gen_server).

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    {ok, #{}}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.
```

### Key OTP behaviors

| Behavior      | Purpose                                             |
|---------------|-----------------------------------------------------|
| `gen_server`  | Client-server pattern with synchronous/async calls  |
| `gen_statem`  | Finite state machine                                |
| `supervisor`  | Monitors child processes and restarts on failure    |
| `application` | Top-level OTP application component                 |

### Coding tips and tricks

- Prefer pattern matching in function heads over `if` / `case` for clarity.
- Use `supervisor:start_link/3` at the top of each subsystem; let the supervisor handle restarts.
- `observer:start()` opens a GUI for live inspection of processes, memory, and message queues.

## See also

* [Erlang Home page](https://www.erlang.org/)
* [Erlang Source Code](https://github.com/erlang/otp)
* [Erlang VSCode Plugin](https://open-vsx.org/extension/elixir-lsp/elixir-ls)
* [Erlang Package Repo](https://hex.pm/)
* [rebar3 build tool](https://rebar3.org/)
* [Erlang Solutions](https://www.erlang-solutions.com/)
* [Elixir (runs on BEAM)](elixir.md)
