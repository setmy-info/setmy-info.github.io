# Claude

Claude CLI

Claude CLI is a powerful command-line interface tool that allows developers to interact with Anthropic's Claude models
directly from their terminal. It supports various tasks, including code generation, analysis, and execution.

## Installation

### Linux

```sh
curl -L https://github.com/anthropic-ai/claude-code/releases/latest/download/claude-linux -o /usr/local/bin/claude
chmod +x /usr/local/bin/claude
```

### macOS

```sh
curl -L https://github.com/anthropic-ai/claude-code/releases/latest/download/claude-macos -o /usr/local/bin/claude
chmod +x /usr/local/bin/claude
```

## Configuration

To use Claude CLI, you need an Anthropic API key. You can obtain one from
the [Anthropic Console](https://console.anthropic.com/).

Set the API key as an environment variable:

```sh
export ANTHROPIC_API_KEY=sk-ant-XXXXXXXXXXXXXXXX
```

You can also store your credentials in `~/.claude/.credentials.json`.

## Usage, tips and tricks

Claude CLI can be used for a variety of tasks. Here is a basic example:

```sh
# From ~/.claude/.credentials.json
export ANTHROPIC_API_KEY=sk-ant-XXXXXXXXXXXXXXXX

claude --dangerously-skip-permissions "Start executing newly written tasklist TASKLIST.md"
```

### Coding tips and tricks

* Use `--dangerously-skip-permissions` only when you trust the commands it will execute.
* You can pipe content into Claude for analysis: `cat code.py | claude "Explain this code"`
* Use clear and concise prompts for better results.

## See also

* [Anthropic Documentation](https://docs.anthropic.com/claude/docs)
* [Claude Console](https://console.anthropic.com/)
* [Model Context Protocol (MCP)](https://modelcontextprotocol.io/)
