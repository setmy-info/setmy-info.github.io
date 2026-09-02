# Cursor

## Information

[Cursor](https://www.cursor.com/) is an AI code editor. Its terminal agent is `cursor-agent`.
Non-interactive execution: `cursor-agent -p --force "prompt"`.

## Installation

```sh
curl https://cursor.com/install -fsS | bash
```

## Passing a logged-in session to another machine

After `cursor-agent login`, the CLI state is stored in `~/.cursor` (`cli-config.json`,
`agent-cli-state.json`). Copy that directory to the same path on the target machine.

The headless alternative is an API key from the Cursor dashboard:

```sh
export CURSOR_API_KEY=...
cursor-agent -p --force "prompt"
```

For a CLI executor such as [Argo Workflows](argo.md) or [Dagu](dagu.md), a pre step exports the
key into the process environment, then starts the agent, for example through `smi-agent`.
Distributing the secret itself is planned later through a secret tool such as
[OpenBao](openbao.md): the pre step reads the current key from there.

## See also

* [Cursor](https://www.cursor.com/)
* [AI Tools](aitools.md)
