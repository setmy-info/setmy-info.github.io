# Aider

## Information

Aider is an AI pair programming tool that runs in the terminal and edits your code files directly. It is git-aware —
it can read your repository, understand context, and commit changes automatically. Aider supports multiple LLM
providers including Ollama (local), OpenAI, Anthropic, Google Gemini, and any OpenAI-compatible API.

Key features:

* Edits existing files in your codebase rather than only generating snippets.
* Architect mode separates the planning model from the coding model for better results.
* Works with local models via Ollama for fully private, no-cost operation.
* Automatic git commits with meaningful messages after each change.

## Installation

```bash
pip install aider-chat
aider --version
```

## Setup with Ollama (Local AI)

```bash
export OLLAMA_API_BASE=http://localhost:11434
export OLLAMA_MODEL=deepseek-coder:6.7b
```

## Running Aider

```bash
aider --model ollama/deepseek-coder:6.7b
```

Open a specific project file:

```bash
cd your-project
aider main.py
```

## Architect / Agent Mode

```bash
aider \
  --model ollama/deepseek-coder:6.7b \
  --architect \
  --auto-commits \
  --dirty-commits
```

## Separate Planner and Coder Models (Recommended)

```bash
aider \
  --model ollama/deepseek-coder:6.7b \
  --architect-model ollama/llama3:8b \
  --architect \
  --auto-commits
```

## Context Awareness

```bash
aider --map-tokens 2048
```

## Model Configurations

### Balanced

* Planner: llama3:8b
* Coder: deepseek-coder:6.7b

### Lightweight

* Planner: mistral
* Coder: deepseek-coder:6.7b

### High Performance

* Planner: llama3:70b
* Coder: deepseek-coder:33b

### Alternative

* Planner: llama3
* Coder: codellama:13b

## Full Recommended Command

```bash
aider \
  --model ollama/deepseek-coder:6.7b \
  --architect-model ollama/llama3:8b \
  --architect \
  --auto-commits \
  --dirty-commits \
  --map-tokens 2048
```

## Notes

* Local models depend on your hardware.
* GPU recommended for best performance.
* Fully private, no API costs when using Ollama.

## Supported Model Providers

### OpenAI (GPT)

```bash
export OPENAI_API_KEY=your_key_here
aider --model gpt-4o
```

Models: gpt-4o, gpt-4o-mini, gpt-4.1

### Anthropic (Claude)

```bash
export ANTHROPIC_API_KEY=your_key_here
aider --model claude-3-5-sonnet
```

Models: claude-3-5-sonnet, claude-3-opus, claude-3-haiku

### Google (Gemini)

```bash
export GEMINI_API_KEY=your_key_here
aider --model gemini/gemini-1.5-pro
```

Models: gemini-1.5-pro, gemini-1.5-flash

### OpenRouter (Multi-model gateway)

```bash
export OPENROUTER_API_KEY=your_key_here
export OPENAI_API_BASE=https://openrouter.ai/api/v1
aider --model openrouter/deepseek/deepseek-coder
```

Supports: DeepSeek, Mixtral, Claude, GPT, and many others.

### Local via Ollama

```bash
export OLLAMA_API_BASE=http://localhost:11434
aider --model ollama/deepseek-coder:6.7b
```

Models: deepseek-coder, codellama, llama3, mistral

### Custom / OpenAI-compatible APIs

```bash
export OPENAI_API_KEY=your_key_here
export OPENAI_API_BASE=https://your-endpoint.com/v1
aider --model your-model-name
```

Examples: Together.ai, Fireworks.ai, Groq, local proxies.

## Multi-Model Setup

```bash
aider \
  --model openrouter/deepseek/deepseek-coder \
  --architect-model claude-3-5-sonnet \
  --architect \
  --auto-commits
```

## Usage, tips and tricks

* Use strong reasoning models for planning (Claude, GPT, Gemini).
* Use coding-specialised models for implementation (DeepSeek, CodeLlama).
* Combine local + cloud for best performance/cost balance.
* OpenRouter provides the most flexibility across providers.

Aider is model-agnostic and works with cloud models (GPT, Claude, Gemini), local models (Ollama), and any
OpenAI-compatible API.

| Model                 | Size | RAM (Q4)  | VRAM (Q4) | Notes                    |
|-----------------------|------|-----------|-----------|--------------------------|
| `mistral`             | 7B   | ~4–6 GB   | ~4 GB     | Very good lightweight    |
| `llama3:8b`           | 8B   | ~6–8 GB   | ~6 GB     | Best general-purpose     |
| `deepseek-coder:6.7b` | 6.7B | ~5–7 GB   | ~5 GB     | Good for coding          |
| `codellama:13b`       | 13B  | ~10–14 GB | ~10 GB    | Decent for coding        |
| `deepseek-coder:33b`  | 33B  | ~24–32 GB | ~24 GB    | Very powerful            |
| `llama3:70b`          | 70B  | ~48–64 GB | ~40+ GB   | Server-level requirement |

## See also

* [Aider official documentation](https://aider.chat/)
* [Aider GitHub repository](https://github.com/paul-gauthier/aider)
* [Ollama](oolama.md)
* [LLM](llm.md)
