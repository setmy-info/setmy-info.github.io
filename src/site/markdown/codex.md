# Codex CLI

## Information

OpenAI Codex CLI is a terminal coding agent for the ChatGPT/OpenAI models. Non-interactive
execution: `codex exec --dangerously-bypass-approvals-and-sandbox "prompt"`.

## Installation

```sh
curl -fsSL https://chatgpt.com/codex/install.sh | sh
# or
smi-install-package codex
```

## Passing a logged-in session to another machine

After `codex login` with a ChatGPT account, the credentials are stored in `~/.codex/auth.json`.
Copy that file to the same path on the target machine and the CLI is logged in there without a
second login.

The headless alternative is an API key, read from stdin so it never appears in the process list:

```sh
printenv OPENAI_API_KEY | codex login --with-api-key
```

For a CLI executor such as [Argo Workflows](argo.md) or [Dagu](dagu.md), a pre step exports the
key into the process environment, then starts the agent, for example through `smi-agent`.
Distributing the secret itself is planned later through a secret tool such as
[OpenBao](openbao.md): the pre step reads the current key from there.

## See also

* [Codex CLI GitHub](https://github.com/openai/codex)
* [AI Tools](aitools.md)
