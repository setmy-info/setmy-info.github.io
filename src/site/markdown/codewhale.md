# Codewhale

## Information

Codewhale is a terminal coding agent with multiple model providers. Non-interactive execution:
`codewhale exec --auto --output-format stream-json "prompt"`.

## Installation

```sh
npm install -g codewhale
# or
smi-install-package codewhale
```

## Passing a logged-in session to another machine

`codewhale login` uses a browser device flow, so on a headless machine save a provider API key
instead, read from stdin so it never appears in the process list:

```sh
printenv CODEWHALE_API_KEY | codewhale auth set --api-key-stdin
codewhale auth status
```

`codewhale auth list` shows every provider's auth state without revealing credentials, and
`codewhale auth clear` removes a saved key.

For a CLI executor such as [Argo Workflows](argo.md) or [Dagu](dagu.md), a pre step exports the
key into the process environment, then starts the agent, for example through `smi-agent`.
Distributing the secret itself is planned later through a secret tool such as
[OpenBao](openbao.md): the pre step reads the current key from there.

## See also

* [AI Tools](aitools.md)
