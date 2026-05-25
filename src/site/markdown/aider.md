# aider.md

## Aider Setup with Ollama (Local AI Coding Agent)

---

# 1. Install Aider

```bash
pip install aider-chat
```

Verify:

```bash
aider --version
```

---

# 2. Connect to Ollama

```bash
export OLLAMA_API_BASE=http://localhost:11434
export OLLAMA_MODEL=deepseek-coder:6.7b
```

---

# 3. Run Aider

```bash
aider --model ollama/deepseek-coder:6.7b
```

Open project:

```bash
cd your-project
aider main.py
```

---

# 4. Enable Agent Mode

```bash
aider \
  --model ollama/deepseek-coder:6.7b \
  --architect \
  --auto-commits \
  --dirty-commits
```

---

# 5. Use Separate Models (Recommended)

```bash
aider \
  --model ollama/deepseek-coder:6.7b \
  --architect-model ollama/llama3:8b \
  --architect \
  --auto-commits
```

---

# 6. Improve Context Awareness

```bash
aider --map-tokens 2048
```

---

# Model Configurations

## Balanced

* Planner: llama3:8b
* Coder: deepseek-coder:6.7b

## Lightweight

* Planner: mistral
* Coder: deepseek-coder:6.7b

## High Performance

* Planner: llama3:70b
* Coder: deepseek-coder:33b

## Alternative

* Planner: llama3
* Coder: codellama:13b

---

# Full Recommended Command

```bash
aider \
  --model ollama/deepseek-coder:6.7b \
  --architect-model ollama/llama3:8b \
  --architect \
  --auto-commits \
  --dirty-commits \
  --map-tokens 2048
```

# ⚠️ Notes

* Local models depend on your hardware
* GPU recommended for best performance
* Fully private, no API costs

# 🔌 Additional Model Integrations

Aider supports multiple AI providers and can be configured to work with different models beyond Ollama.

---

## Supported Model Providers

### OpenAI (GPT)

```bash
export OPENAI_API_KEY=your_key_here
aider --model gpt-4o
```

Models:

* gpt-4o
* gpt-4o-mini
* gpt-4.1

---

### Anthropic (Claude)

```bash
export ANTHROPIC_API_KEY=your_key_here
aider --model claude-3-5-sonnet
```

Models:

* claude-3-5-sonnet
* claude-3-opus
* claude-3-haiku

---

### Google (Gemini)

```bash
export GEMINI_API_KEY=your_key_here
aider --model gemini/gemini-1.5-pro
```

Models:

* gemini-1.5-pro
* gemini-1.5-flash
* gemini-2.0 (if available)

---

### OpenRouter (Multi-model gateway)

```bash
export OPENROUTER_API_KEY=your_key_here
export OPENAI_API_BASE=https://openrouter.ai/api/v1
aider --model openrouter/deepseek/deepseek-coder
```

Supports:

* DeepSeek
* Mixtral
* Claude
* GPT
* many others

---

### Local via Ollama

```bash
export OLLAMA_API_BASE=http://localhost:11434
aider --model ollama/deepseek-coder:6.7b
```

Models:

* deepseek-coder
* codellama
* llama3
* mistral

---

### ⚙️ Custom / OpenAI-compatible APIs

Any provider that supports OpenAI API format:

```bash
export OPENAI_API_KEY=your_key_here
export OPENAI_API_BASE=https://your-endpoint.com/v1
aider --model your-model-name
```

Examples:

* Together.ai
* Fireworks.ai
* Groq
* Local proxies

---

## Multi-Model Setup (Best Practice)

Use different models for planning and coding:

```bash
aider \
  --model openrouter/deepseek/deepseek-coder \
  --architect-model claude-3-5-sonnet \
  --architect \
  --auto-commits
```

---

## Tips

* Use **strong reasoning models** for planning (Claude, GPT, Gemini)
* Use **coding models** for implementation (DeepSeek, CodeLlama)
* Combine local + cloud for best performance/cost balance
* OpenRouter is best for flexibility across providers

---

# Summary

Aider is model-agnostic and can work with:

* Cloud models (GPT, Claude, Gemini)
* Local models (Ollama)
* Multi-provider gateways (OpenRouter)
* Any OpenAI-compatible API

This makes it highly flexible for building custom AI coding workflows.

| Model                 | Size | RAM (Q4)  | VRAM (Q4) | Notes                    |
|-----------------------|------|-----------|-----------|--------------------------|
| `mistral`             | 7B   | ~4–6 GB   | ~4 GB     | Very good lightweight    |
| `llama3:8b`           | 8B   | ~6–8 GB   | ~6 GB     | Best general-purpose     |
| `deepseek-coder:6.7b` | 6.7B | ~5–7 GB   | ~5 GB     | Good for coding          |
| `codellama:13b`       | 13B  | ~10–14 GB | ~10 GB    | Decent for coding        |
| `deepseek-coder:33b`  | 33B  | ~24–32 GB | ~24 GB    | Very powerful            |
| `llama3:70b`          | 70B  | ~48–64 GB | ~40+ GB   | Server-level requirement |
