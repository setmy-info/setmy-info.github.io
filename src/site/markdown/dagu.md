# Dagu

## Information

Dagu is a lightweight workflow engine and job scheduler for defining and running task dependencies as DAGs on regular
servers or developer machines, without requiring Kubernetes. It is useful when you want Argo Workflows-like DAG
execution, retries, scheduling, and a web UI, but the target environment is a VM, a bare-metal host, or a small
self-hosted system rather than a Kubernetes cluster.

Typical Dagu characteristics:

* **No Kubernetes required**: workflows run directly on the host OS.
* **YAML workflows**: pipelines are described in YAML files with steps and dependencies.
* **Scheduler support**: recurring jobs can be started with cron-like schedules.
* **Web UI and CLI**: inspect runs, retry failed steps, and manage DAG definitions.
* **Shell-first execution**: steps usually run shell commands or scripts, which makes Dagu practical for automation,
  ETL, maintenance jobs, CI-like host tasks, and local orchestration.
* **Self-hosted**: suitable for single-node or small-server setups where a full workflow platform would be too heavy.

Compared with Argo Workflows, Dagu is much simpler to deploy because it does not depend on Kubernetes CRDs,
controllers, pods, or cluster networking. The trade-off is that Dagu is oriented more toward host-based automation and
small-to-medium workflow orchestration rather than large-scale container-native cluster execution.

## Installation

The most practical installation method is to use the official release binary or package for your platform.

### Docker

If you want to run Dagu in a container instead of installing the binary directly on the host, use the official image:

```bash
docker pull ghcr.io/dagucloud/dagu:latest
```

Example:

```bash
docker run --rm ghcr.io/dagucloud/dagu:latest version
```

Windows example for starting the web UI and local services with your DAG directory mounted:

```powershell
docker run -d ^
  --name dagu ^
  -p 7700:8080 ^
  -v "C:\sources\setmy.info\submodules\setmy-info-scripts\src\main\dagu:/data/dags" ^
  ghcr.io/dagucloud/dagu:latest
```

For real usage, mount your DAGs directory and Dagu home/data directories into the container, and publish the HTTP port
when running `dagu server` or `dagu start-all`.

### Linux

For Linux hosts, download the latest release archive from the Dagu GitHub releases page, extract it, and place the
binary in your `PATH`.

Typical flow:

```bash
curl -fsSL https://raw.githubusercontent.com/dagucloud/dagu/main/scripts/installer.sh | \
  bash -s -- \
    --service no \
    --no-prompt \
    --service-scope user \
    --install-dir /opt/setmy.info/bin \
    --admin-username admin \
    --admin-password 'change-me-now'
dagu version
```

If your target architecture is not `amd64`, choose the matching release asset instead.

### macOS

For macOS, Homebrew is usually the easiest installation method when available.

```bash
brew install dagu
dagu version
```

If Homebrew is not suitable, use the release tarball in the same way as on Linux and copy the binary to a directory in
your `PATH`.

### Windows

On Windows, download the release zip from GitHub, extract it, and add the folder containing `dagu.exe` to `PATH`.

Typical PowerShell flow:

```powershell
Invoke-WebRequest https://github.com/dagu-org/dagu/releases/latest/download/dagu_windows_amd64.zip -OutFile dagu.zip
Expand-Archive dagu.zip -DestinationPath dagu
$env:Path += ";$PWD\dagu"
dagu version
```

For permanent installation, place `dagu.exe` in a stable directory and update the system or user `PATH`.

## Initial setup

Dagu stores workflow definitions and run metadata in directories configured through environment variables or config.
For a small local setup, create a dedicated home directory for Dagu data and DAG files.

Example:

```bash
mkdir -p ~/.config/dagu/dags
mkdir -p ~/.local/share/dagu
```

Then create a simple DAG file such as `~/.config/dagu/dags/hello.yaml`:

```yaml
name: hello-wf
description: Hello WF
steps:
    -   id: hello
        run: echo "Hello from Dagu!"
    -   id: step_2
        run: echo "Running step 2"
        depends: hello

```

Run it:

```bash
dagu start hello.yaml
```

Open the web UI and local runtime services with the all-in-one startup command:

```powershell
dagu start-all --dagu-home C:\sources\temp\dagu --dags C:\sources\setmy.info\submodules\setmy-info-scripts\src\main\dagu --port 7700 --host 127.0.0.1
```

Then browse to `http://127.0.0.1:7700`.

This startup form is the relevant local setup for our ADR-like usage because it keeps Dagu state under
`C:\sources\temp\dagu`, reads DAG definitions from
`C:\sources\setmy.info\submodules\setmy-info-scripts\src\main\dagu`, and exposes the UI/API only on local
loopback at port `7700`.

`dagu server` is only the web/API process. `dagu start-all` is the local all-in-one startup command, so it is the
better choice when you want a single process that serves the UI and also runs scheduled workflows on the same machine.

### Can `dagu server` start workflows directly?

Not by itself. `dagu server` starts the web/API server so it can show the DAGs it knows from the configured DAGs
directory, but it is not the CLI command used to launch a workflow run from the terminal.

If you want to start a workflow that the server knows about, use one of these approaches:

* start it explicitly from CLI with `dagu start <dag-file>`;
* start it from the web UI after `dagu server` is running;
* let `dagu scheduler` or `dagu start-all` run scheduled workflows automatically.

In practice, think of the service commands like this:

* `dagu server` = UI/API only;
* `dagu scheduler` = scheduler only;
* `dagu start-all` = local all-in-one mode that starts the server, scheduler, and executor together.

Example:

```powershell
dagu start-all --dagu-home C:\sources\temp\dagu --dags C:\sources\setmy.info\submodules\setmy-info-scripts\src\main\dagu --host 127.0.0.1 --port 7700
dagu start --dags C:\sources\setmy.info\submodules\setmy-info-scripts\src\main\dagu hello.yaml
```

In other words, the server can know and display available DAGs, but starting a run is still a separate action.

### Using another DAGs directory

If your workflow YAML files live in a different standard location, point Dagu at that directory instead of moving the
files.

Typical reasons to do this include:

* your DAG YAML files are already stored under an application repo such as `/srv/apps/my-pipeline/dags`;
* operations keeps workflows in a shared directory such as `/srv/workflows/dagu`;
* you want the server, scheduler, and ad hoc CLI runs to all use the same non-default DAG location.

The most direct way is to set `DAGU_DAGS_DIR`:

```bash
export DAGU_DAGS_DIR=/srv/workflows/dagu
dagu start my-pipeline
```

If you want to change the DAG location only for one CLI call, use `--dags` and pass the directory explicitly:

```bash
dagu start --dags=/srv/workflows/dagu my-pipeline
dagu server --dags=/srv/workflows/dagu --host=127.0.0.1 --port=7700
dagu scheduler --dags=/srv/workflows/dagu
dagu start-all --dags=/srv/workflows/dagu
```

This is the safest approach when you do not want to change your shell environment or global config, but you want a
specific command to use another DAG directory.

If you prefer one-off CLI overrides instead of exporting environment variables, use command-line flags. Dagu applies
configuration in this order: CLI flags, then environment variables, then `~/.config/dagu/config.yaml`.

```bash
dagu start --dags=/srv/workflows/dagu my-pipeline
dagu start-all --dags=/srv/workflows/dagu
```

On Windows PowerShell:

```powershell
$env:DAGU_DAGS_DIR = "C:\workflows\dagu"
dagu start my-pipeline
```

For a permanent setup, put it in `~/.config/dagu/config.yaml`:

```yaml
paths:
    dagsDir: /srv/workflows/dagu
```

This is useful when your workflow YAML files are already stored in a shared operations directory, a mounted data disk,
or another location such as `/var/opt/...` instead of the default `~/.config/dagu/dags`.

#### Quick guideline: change DAG location and run it from CLI

When you want to move or keep DAG YAML files somewhere else and run them from CLI, use this sequence:

1. put the DAG YAML files into the target directory, for example `/srv/workflows/dagu`;
2. run Dagu commands with `--dags=/srv/workflows/dagu`;
3. use the same `--dags` value consistently for `dagu start`, `dagu server`, `dagu scheduler`, or `dagu start-all`;
4. only switch to `DAGU_DAGS_DIR` or `config.yaml` when that location should become your default.

Example:

```bash
dagu server --dags=/srv/workflows/dagu --host=127.0.0.1 --port=7700
dagu start --dags=/srv/workflows/dagu nightly-import.yaml
dagu status --dags=/srv/workflows/dagu nightly-import
```

That way, the server knows the same DAG directory that your CLI run uses, and you avoid confusion caused by starting a
workflow from one location while the UI points to another.

### Using another working directory

By default, Dagu runs a workflow from the directory where that DAG YAML file is stored. If your scripts, relative file
paths, or generated artifacts should run from somewhere else, set the workflow `working_dir` explicitly.

Unlike host, port, or DAGs directory selection, this is not normally a global Dagu server CLI option. It belongs in
the DAG YAML itself because it controls where that specific workflow executes.

Example:

```yaml
name: sample-pipeline
working_dir: /srv/workflows/runtime
steps:
    -   name: prepare
        command: ./scripts/prepare.sh
```

That is useful when the DAG definition is stored in one directory, but the actual runtime files live somewhere else,
such as `/srv/apps/my-pipeline`, a mounted project checkout, or a separate data volume.

If you also keep the DAG files themselves in a non-default location, combine it with the earlier `DAGU_DAGS_DIR`
setting.

### Starting Dagu on another port

The web UI bind address and HTTP port can also be overridden. For example, to run Dagu on port `7700`:

```bash
export DAGU_PORT=7700
dagu server
```

For a single command without changing your shell environment, use CLI flags:

```bash
dagu server --host=127.0.0.1 --port=7700
```

If you also want to listen on all interfaces instead of only `127.0.0.1`:

```bash
export DAGU_HOST=0.0.0.0
export DAGU_PORT=7700
dagu server
```

CLI equivalent:

```bash
dagu server --host=0.0.0.0 --port=7700
```

To start all local Dagu services together on that port, use:

```bash
export DAGU_DAGS_DIR=/srv/workflows/dagu
export DAGU_HOST=0.0.0.0
export DAGU_PORT=7700
dagu start-all
```

Or entirely through CLI options:

```powershell
dagu start-all --dagu-home C:\sources\temp\dagu --dags C:\sources\setmy.info\submodules\setmy-info-scripts\src\main\dagu --host 127.0.0.1 --port 7700
```

`dagu start-all` is the easiest single-process mode for a normal server because it starts the HTTP server, scheduler,
and executor together. If you prefer separate processes, `dagu server` starts only the web/API server and `dagu
scheduler` starts only the scheduler.

## CLI guide

The Dagu CLI is the main terminal interface for managing workflows, scheduler processes, and the web/API server.
Use it when you want fast local control from a shell, scripting in CI or automation, or one-shot administration
without opening the web UI.

The official docs separate the CLI into overview/reference material, but for daily usage the most important idea is
that the CLI covers both workflow execution commands and local service-management commands.

### DAG name vs file path

Many Dagu commands accept either the DAG name from the YAML `name` field or the DAG file path, but not all commands
behave the same way.

Typical rule of thumb:

* commands such as `start`, `stop`, `status`, and `retry` can usually work with either a DAG name or a DAG file path;
* commands such as `dry` and `enqueue` are more file-oriented and are safer to use with the DAG file path;
* some management commands operate on the local Dagu installation itself rather than on one DAG.

For example, these are the kinds of patterns shown in the official CLI docs:

```bash
dagu start hello.yaml
dagu status hello-wf
dagu retry hello-wf
dagu stop hello-wf
```

If you keep DAG files outside the default directory, combine the command with `--dags` or `DAGU_DAGS_DIR` as shown
earlier in this page.

### Global CLI options

The CLI reference documents global options that apply before the subcommand. The most practically useful ones are:

* `--config` or `-c` to point to a specific Dagu config file;
* `--dags` to override the workflows directory for a single command;
* `--host` and `--port` for commands that expose the HTTP server;
* profile-related commands when you want to switch between local Dagu setups.

General form:

```bash
dagu [global options] command [command options] [arguments...]
```

This fits the same precedence already described above: CLI flags override environment variables, and environment
variables override `~/.config/dagu/config.yaml`.

### Contexts and API keys

If you run more than one Dagu server, or you protect the API/UI with an API key, use CLI contexts so you do not have
to repeat the server URL on every command.

For example, after starting a localhost server on port `7700`, you can register it as a named context:

```bash
dagu context add localhost --server http://127.0.0.1:7700 --api-key dagu_XXXXXXXX
dagu context list
dagu context use localhost
# Or
dagu context use dev7700
dagu context remove localhost
```

After that, context-aware CLI commands use the selected server and API key automatically. This is useful when you
switch between a localhost lab instance, a test server, and a production-like Dagu environment.

Practical tips:

* use `dagu context add ...` once per environment and give each context a clear name such as `local`, `test`, or `prod`;
* use `dagu context use <name>` before CLI operations that should target a specific Dagu server;
* combine contexts with the earlier `--host`, `--port`, and `--dags` examples when you are both starting a server and
  administering it from the CLI.

### Common workflow commands

For normal workflow operations, these are the most useful commands to know first:

* `dagu start <dag>` starts a workflow immediately;
* `dagu stop <dag>` stops a running workflow;
* `dagu status <dag>` shows the current run state;
* `dagu retry <dag>` retries a failed workflow or failed steps depending on context;
* `dagu dry <dag-file>` validates or previews a DAG definition without fully running it.

Example:

```bash
dagu start --dags=/srv/workflows/dagu nightly-import.yaml
dagu status nightly-import
dagu retry nightly-import
dagu stop nightly-import
```

This is the quickest way to operate workflows from scripts or remote shells.

### Service-management commands

Dagu also uses the CLI to manage the local runtime services around your workflows.

Typical commands include:

* `dagu server` to start the web UI and REST API server;
* `dagu scheduler` to run scheduled workflows;
* `dagu start-all` to run the server, scheduler, and executor together;
* profile or local administration commands when operating multiple Dagu environments.

Example:

```bash
dagu server --host=127.0.0.1 --port=7700 --dags=/srv/workflows/dagu
dagu scheduler --dags=/srv/workflows/dagu
dagu start-all --host=127.0.0.1 --port=7700 --dags=/srv/workflows/dagu
```

On a simple single-host setup, `dagu start-all` is usually the easiest operational command. In a more explicit or
service-managed deployment, run `dagu server` and `dagu scheduler` separately.

### Practical CLI tips

* Use `dagu start <dag>` for one-off manual execution and `dagu scheduler` for cron-like recurring runs.
* Prefer `--dags` on ad hoc administration commands so you do not accidentally target the wrong workflow directory.
* Use the CLI when scripting automation and the web UI when you need to inspect runs, logs, and retry behavior
  interactively.
* When documentation or examples show a DAG file like `hello.yaml`, keep the actual YAML file name handy because some
  commands are clearer when you pass the file explicitly.

## REST API

Dagu also exposes a REST API through the same HTTP server started by `dagu server` or `dagu start-all`. This is the
programmatic option when shelling out to the CLI is not ideal and you want to integrate workflow control into another
application, script runner, or internal operations tool.

In practice, the API is tied to the Dagu web server endpoint you expose locally or behind a reverse proxy. If your
server is started with the defaults, the API is served from the same host and port as the web UI. If you bind Dagu to
another host or port, the API moves with it.

Typical usage areas include:

* listing known DAGs;
* starting or stopping workflow runs remotely;
* checking workflow and step execution state;
* building internal dashboards, wrappers, or automation hooks around Dagu.

Example with a custom server port:

```bash
dagu server --host=127.0.0.1 --port=7700 --dags=/srv/workflows/dagu
curl http://127.0.0.1:7700/api/v1/dags
```

Example requests for the local ADR-style setup with the API token masked:

```powershell
curl http://localhost:7700/api/v1/health
curl http://localhost:7700/api/v1/openapi.json
curl -H "Authorization: Bearer dagu_********" -H "Accept: application/json" http://localhost:7700/api/v1/dags
curl -H "Authorization: Bearer dagu_********" -H "Accept: application/json" "http://localhost:7700/api/v1/dags?sort=name&order=desc"
curl -H "Authorization: Bearer dagu_********" -H "Accept: application/json" http://localhost:7700/api/v1/dags/hello-wf
curl -X POST -H "Authorization: Bearer dagu_********" -H "Accept: application/json" -H "Content-Type: application/json" -d "{}" http://localhost:7700/api/v1/dags/hello-wf/start
```

When you already have the UI running, think of the REST API as the HTTP equivalent of the CLI for automation and
remote control.

### REST API tips

* Keep the API behind authentication or a reverse proxy in shared environments, just like the web UI.
* Treat the API and UI as the same security surface because both are exposed by the Dagu server.
* Prefer the CLI for quick local admin tasks, and prefer the REST API when another service needs structured HTTP-based
  access.
* For the complete endpoint list and request/response details, use the official Dagu REST API reference rather than
  relying only on summary examples.

## Workflow example

A more realistic Dagu workflow can express dependencies between steps:

```yaml
name: sample-pipeline
schedule: "0 * * * *"
steps:
    -   name: prepare
        command: ./scripts/prepare.sh

    -   name: process
        command: ./scripts/process.sh
        depends:
            - prepare

    -   name: report
        command: ./scripts/report.sh
        depends:
            - process
```

This makes Dagu suitable for recurring host-side workflows such as backups, report generation, data imports, local AI
agent pipelines, deployment helpers, and maintenance tasks.

## Configuration

Common configuration topics for Dagu include:

* DAG definitions directory,
* data directory for execution state and logs,
* web UI bind address and port,
* scheduler enablement,
* authentication or reverse-proxy protection for the UI,
* environment variables passed to tasks,
* retry policy and timeout behavior.

For shared or internet-reachable environments, put the Dagu UI behind a reverse proxy and authentication layer instead
of exposing it directly without protection.

Useful environment variables include:

* `DAGU_DAGS_DIR` for the workflow definitions directory,
* `DAGU_HOME` to relocate the whole Dagu home layout,
* `DAGU_HOST` for the bind address,
* `DAGU_PORT` for the HTTP server port.

The matching one-shot CLI options are typically `--dags`, `--host`, and `--port`, which are useful when you do not
want to persist those values in your shell profile or config file.

For execution context inside a workflow file, `working_dir` changes the current directory used by relative commands and
paths. If you leave it unset, Dagu uses the DAG file location as the working directory.

## Usage, tips and tricks

### Coding tips and tricks

* Use Dagu when you need DAG orchestration on a normal host and Kubernetes would be unnecessary overhead.
* Keep workflow steps idempotent so retries are safe.
* Prefer small shell scripts checked into version control instead of very long inline commands.
* Store DAG YAML files in Git and review them like application code.
* Use explicit step names and dependency chains so failures are easier to understand in the UI.
* Separate workflow definition from secrets; inject secrets through environment variables or a secret manager.
* Run the web UI behind a reverse proxy if the service is not local-only.
* For production-like usage, use `systemd` or another service manager to keep the Dagu server and scheduler running.
* If you are comparing Dagu with Argo Workflows, think of Dagu as the simpler host-based option and Argo as the
  Kubernetes-native option.

### When Dagu fits well

Dagu is a good fit for:

* VM or bare-metal automation,
* homelab and self-hosted orchestration,
* local development workflows,
* cron replacement with dependencies and better visibility,
* lightweight ETL or maintenance pipelines.

It is less suitable when you specifically need Kubernetes pod orchestration, cluster autoscaling, or cloud-native
workflow isolation per task.

## See also

* [Dagu documentation](https://docs.dagu.sh/)
* [Dagu GitHub repository](https://github.com/dagu-org/dagu)
* [Dagu examples](https://docs.dagu.sh/writing-workflows/examples)
* [Dagu installation guide](https://docs.dagu.sh/getting-started/installation)
* [Argo Workflows](argo.md)
* [Zeebe](zeebe.md)
