# OpenCode

## Information

OpenCode is an open-source AI coding assistant and autonomous agent designed to accelerate software development across terminal and IDE workflows. It inspects repository structure and context to generate code, execute refactorings, write tests, and resolve development tasks using various LLM backends.

### Key Features

* **Agentic Software Development**: Executes autonomous multi-step coding plans, tool execution, and code modifications directly on local files.
* **Codebase Context Awareness**: Indexes and navigates repository context to ensure accurate, project-aligned code generation and modifications.
* **Multi-LLM Support**: Connects to multiple LLM providers including OpenAI, Anthropic Claude, Google Gemini, DeepSeek, and local models via Ollama.
* **Interactive Terminal & Git Integration**: Operates seamlessly within developer shells, automatically managing git diffs, reviews, and commits.
* **Open Source & Extensible**: Offers full transparency and control over local data, telemetry, tool plugins, and model routing.

## Use Cases

* **Autonomous Feature Implementation**: Developing new modules, API endpoints, and UI components from high-level user specifications.
* **Codebase Refactoring & Modernization**: Performing multi-file refactoring, framework migrations, and architecture cleanups across large repositories.
* **Automated Bug Fixing & Diagnostics**: Analyzing runtime or test failure logs, identifying root causes, and applying verified patches.
* **Test Suite Generation**: Writing unit, integration, and end-to-end tests for uncovered code paths and regression scenarios.
* **Interactive Pair Programming**: Assisting developers in real time with syntax, documentation lookup, shell commands, and git operations.

## Installation

Install OpenCode via npm or installation script:

```shell
# Using npm
npm install -g @opencode-ai/cli

# Or using the installer script
curl -fsSL https://opencode.ai/install.sh | bash
```

## Usage

### Starting OpenCode in a Project

```shell
cd /path/to/project
opencode
```

### Passing Direct Tasks

```shell
# Run a specific task
opencode "Refactor the authentication middleware to use JWT tokens"

# Run tests and fix failures
opencode "Run test suite and fix any failing test cases"
```

### Configuring LLM Providers

Configure environment variables for cloud or local model providers:

```shell
# Cloud providers
export OPENAI_API_KEY="your-api-key"
export ANTHROPIC_API_KEY="your-api-key"

# Local models via Ollama
export OPENCODE_LLM_PROVIDER="ollama"
export OLLAMA_BASE_URL="http://localhost:11434"
```

## Passing a logged-in session to another machine

After `opencode auth login`, the credentials are stored in `~/.local/share/opencode/auth.json`.
Copy that file to the same path on the target machine and the CLI is logged in there without a
second login. The headless alternative is a provider API key in the environment, for example
`ANTHROPIC_API_KEY` or `OPENAI_API_KEY`, as shown above. Non-interactive execution:
`opencode run "prompt"`.

For a CLI executor such as [Argo Workflows](argo.md) or [Dagu](dagu.md), a pre step exports the
key into the process environment, then starts the agent, for example through `smi-agent`.
Distributing the secret itself is planned later through a secret tool such as
[OpenBao](openbao.md): the pre step reads the current key from there.

## See also

* [OpenCode Website](https://opencode.ai/)
* [AI Tools](aitools.md)
* [Aider](aider.md)
* [AI Agent](agent.md)
* [CrewAI](crewai.md)
* [AgentKit](agentkit.md)
