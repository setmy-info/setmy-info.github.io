# Gemini CLI

## Information

Google Gemini CLI is a terminal coding agent for the Gemini models. Non-interactive execution:
`gemini -p "prompt" --yolo`.

## Installation

```sh
npm install -g @google/gemini-cli
# or
smi-install-package gemini
```

## Passing a logged-in session to another machine

After `gemini` login with a Google account, the OAuth credentials are stored in
`~/.gemini/oauth_creds.json`. Copy that file to the same path on the target machine and the CLI
is logged in there without a second login.

The headless alternative is an API key from [Google AI Studio](https://aistudio.google.com/):

```sh
export GEMINI_API_KEY=...
gemini -p "prompt" --yolo
```

For a CLI executor such as [Argo Workflows](argo.md) or [Dagu](dagu.md), a pre step exports the
key into the process environment, then starts the agent, for example through `smi-agent`.
Distributing the secret itself is planned later through a secret tool such as
[OpenBao](openbao.md): the pre step reads the current key from there.

## See also

* [Gemini CLI GitHub](https://github.com/google-gemini/gemini-cli)
* [AI Tools](aitools.md)
