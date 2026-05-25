# ollama.md

## Ollama Setup Guide (Local LLM Runtime)

This guide covers installing, running, and managing models with Ollama for local AI workflows.

---

# 1. Install Ollama

### Linux / macOS:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### Verify installation:

```bash
ollama --version
```

---

# ▶️ 2. Start Ollama Server

```bash
ollama serve
```

By default, Ollama runs at:

```
http://localhost:11434
```

---

# 3. Download Models

Use `ollama pull` to download models.

## 🔹 Popular Models

```bash
# General reasoning
ollama pull llama3:8b
ollama pull mistral

# Coding models
ollama pull deepseek-coder:6.7b
ollama pull codellama:13b

# Larger / more powerful (requires strong GPU)
ollama pull llama3:70b
ollama pull deepseek-coder:33b
```

---

# 4. Run a Model

Start an interactive session:

```bash
ollama run llama3:8b
```

Example prompt:

```
Explain how a REST API works
```

---

# 5. Use Ollama as an API

Ollama exposes an OpenAI-compatible API.

### Example request:

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3:8b",
  "prompt": "Write a Python function to reverse a string"
}'
```

---

# 6. List Installed Models

```bash
ollama list
```

---

# 7. Remove a Model

```bash
ollama rm llama3:8b
```

---

# 8. Update a Model

```bash
ollama pull llama3:8b
```

(Re-pulling updates the model)

---

# 9. Environment Variables (Optional)

```bash
export OLLAMA_HOST=0.0.0.0
export OLLAMA_PORT=11434
```

---

# 10. Recommended Models by Use Case

## 🟢 General Use

* llama3:8b
* mistral

## Coding

* deepseek-coder:6.7b
* codellama:13b

## High Performance

* llama3:70b
* deepseek-coder:33b

---

# Notes

* Larger models require more RAM/VRAM
* CPU works but is slower
* GPU strongly recommended for >13B models
* All processing is local (no API cost, full privacy)
