# LLM

## Information

* LLaMA 3
* OLLAMA
* Qwen
* DeepSeek Coder
* Code Llama

### Tokenizers

* HuggingFace Tokenizers
* SpaCy
* NLTK
* Trankit

* SentencePiece
* Byte-Pair Encoding (BPE)
* WordPiece
* Unigram

  Pickle/JSON file
  SQL DB
  Redis

  Kiireks prototüüpimiseks – Pickle + sõnastiku klass
  LLM-de jaoks – HuggingFace Tokenizers (salvestab automaatselt)
  Eestikeelseks töötluseks – EstNLTK või spaCy et_core_news_sm
  Tootmiskeskkonnaks – Redis või PostgreSQL
  Suurte korpuste jaoks – SQLite või LevelDB

  EstNLTK on parim eestikeelseks tokeniseerimiseks
  HuggingFace'i mitmekeelsed mudelid (bert-base-multilingual, XLM-R) töötavad eesti keelega hästi
  SentencePiece on hea, kui treenite oma mudelit eesti keelel

Lihtne stack (lokaalne)
Ollama (LLM)
sentence-transformers (embeddings)
SQLite / DuckDB / Chroma / FAISS

IntelliJ
Continue.dev
Ollama + DeepSeek Coder
AGENT.md + TASKS.md

DeepSeek Coder Spetsiaalselt koodi genereerimiseks, hästi Java ja Maven + JUnit Lokaalne, CPU/GPU
Code Llama Meta mudel, optimeeritud koodi genereerimiseks 7B–34B parameetrit
Qwen-Coder Open-source, multiturn coding tasks 7B–14B parameetrit
StarCoder / StarCoderBase Suur kogemus GitHub koodist 15B, GPU soovitatav

Mudel Märkused Suurus
LLaMA 3 General reasoning, summarization 7B–65B
Mistral 7B / Mistral 7B-Instruct Fast, open instruction-following 7B
Falcon 7B / 40B Hea reasoning ja instruction-following 7B / 40B

Mudel Märkused
all-MiniLM-L6-v2 Väga kiire ja täpne lõikude embeddings
nomic-embed-text Open-source, sobib dokumentide indeksiks
bge-small / bge-large Väga hea semantic search, open-source
text-embedding-3-small / 3-large Kui tahad rohkem OpenAI stiilis, võib lokaalselt asendada

Coding Agent → DeepSeek / Code Llama / StarCoder
Review Agent → LLaMA 3 / Mistral / Falcon
Knowledge embeddings → MiniLM / nomic-embed-text / bge
Orchestrator → lihtsalt daemon või Zeebe ei vaja LLM-i

Embedding / Vector DB, FAISS, Chroma, Qdrant

| Agent                                  | Tokeniseerimine | Hind                  |
|----------------------------------------|-----------------|-----------------------|
| Pilve GPT / OpenAI                     | automaatne      | tokenipõhine          |
| Local LLM (Ollama, LLaMA)              | kohalik         | tasuta (v.a hardware) |
| Embedding teenused pilves              | automaatne      | tokenipõhine          |
| Local embedding (FAISS + transformers) | kohalik         | tasuta                |

Chip Huyen book
What is inference and what is retrieval

Local RAG PoC
1 LLM
1 vector DB
1 dokument

MCP

| Criterion            | LISP  | JSON | YAML | TOML | JS | TOON |
|----------------------|-------|------|------|------|----|------|
| Ambiguity-free       | ✅     | ⚠️   | ❌    | ⚠️   | ⚠️ | ✅    |
| Intent clarity       | ✅     | ❌    | ⚠️   | ⚠️   | ❌  | ⚠️   |
| Hierarchy            | ✅     | ✅    | ⚠️   | ⚠️   | ⚠️ | ✅    |
| AI-friendly          | ⭐⭐⭐⭐⭐ | ⭐⭐   | ⭐⭐   | ⭐    | ⭐  | ⭐⭐   |
| Risk of storytelling | ❌     | ⚠️   | ❌    | ⚠️   | ❌  | ⚠️   |
| Suitable as DSL      | ✅     | ❌    | ❌    | ❌    | ⚠️ | ❌    |

## Installation

### Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
