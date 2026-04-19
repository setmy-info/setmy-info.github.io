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

## Terms

| Topic                                      | What it is                                       | Why it matters                 | Practical insights / pro tips                            |
|--------------------------------------------|--------------------------------------------------|--------------------------------|----------------------------------------------------------|
| LLM (Large Language Model)                 | Neural network that predicts next tokens in text | Core AI intelligence layer     | Not human reasoning — output depends on prompt + context |
| Model                                      | Trained neural network                           | Core engine behind AI systems  | Stateless unless external memory is added                |
| Token                                      | Smallest unit of text                            | Cost + context limitation unit | More tokens = higher cost + slower responses             |
| Context window                             | Maximum text model can process at once           | Limits working memory          | Old info is dropped → use RAG or summarization           |
| Inference                                  | Running the model to generate output             | Actual usage phase             | Every response is an inference call                      |
| Training                                   | Building a model from scratch                    | Creates foundation models      | Done only by large labs                                  |
| Pretraining                                | First phase of training on general data          | Learns language + patterns     | Base capability layer                                    |
| Fine-tuning                                | Training on specific dataset                     | Specializes model behavior     | Used for domain adaptation                               |
| Instruction tuning                         | Training on instruction-following examples       | Improves usability             | Better prompt adherence                                  |
| RLHF                                       | Human feedback training                          | Alignment & safety             | Improves helpfulness and reduces harmful outputs         |
| Prompt                                     | Input instructions to model                      | Direct control interface       | Structure strongly affects output                        |
| Prompt engineering                         | Designing effective prompts                      | Improves output quality        | role → goal → constraints → examples                     |
| System prompt                              | Hidden high-priority instructions                | Controls behavior              | Defines rules, tone, identity                            |
| Rules                                      | System constraints on behavior                   | Safety + consistency layer     | Includes safety, tool, formatting rules                  |
| Skills                                     | Learned capabilities of model                    | Determines usefulness          | Emergent from training data                              |
| State vs stateless LLM                     | Whether memory exists internally                 | Architecture constraint        | Most LLMs are stateless                                  |
| Hallucination                              | Model generates incorrect info                   | Reliability risk               | Reduce with RAG, tools, validation                       |
| Guardrails                                 | Constraints on outputs/actions                   | Safety layer                   | Prevent unsafe or invalid actions                        |
| Jailbreak                                  | Attempt to bypass safety rules                   | Security risk                  | Requires filtering and guardrails                        |
| Prompt injection                           | Malicious input manipulation                     | Major AI security risk         | Treat all external input as untrusted                    |
| Context (short-term memory)                | Active input window                              | Immediate reasoning            | Limited by token window                                  |
| Memory (persistent)                        | External stored knowledge                        | Long-term continuity           | Usually vector DB + retrieval                            |
| Conversational memory                      | Session-only memory                              | Dialogue coherence             | Lost when context fills                                  |
| Agent memory                               | Structured long-term memory                      | Enables agent intelligence     | Built via RAG + embeddings                               |
| RAG (Retrieval-Augmented Generation)       | Retrieves external knowledge before answering    | Extends model knowledge        | Core modern AI architecture                              |
| Embeddings                                 | Vector representation of text meaning            | Enables semantic search        | Finds meaning, not keywords                              |
| Vector database                            | Stores embeddings                                | Retrieval system backbone      | Powers RAG and memory                                    |
| Chunking                                   | Splitting data into pieces                       | Enables retrieval              | Required for large documents                             |
| Context stuffing                           | Overloading prompt                               | Degrades performance           | Keep input structured                                    |
| RAG filtering                              | Filtering retrieved data                         | Security + correctness         | Prevent malicious or irrelevant data                     |
| Agent                                      | LLM + tools + memory + loop                      | Turns model into actor         | Can execute tasks autonomously                           |
| Agent loop                                 | plan → act → observe → refine                    | Core agent behavior            | Bad loops cause instability                              |
| Planner                                    | Creates step-by-step plan                        | Structure                      | Breaks tasks into actions                                |
| Executor                                   | Executes actions                                 | Action layer                   | Uses tools, APIs, code                                   |
| Critic / reviewer                          | Evaluates outputs                                | Quality control                | Enables self-correction                                  |
| Sub-agent                                  | Specialized internal agent                       | Modular architecture           | e.g. coder/tester/planner                                |
| Tool use / function calling                | LLM calls external functions                     | Real-world interaction         | Essential for agents                                     |
| Orchestration                              | Coordination of agents/tools                     | System control                 | Manages workflows                                        |
| Workflow (agentic)                         | Structured AI process                            | Production reliability         | Hybrid deterministic + AI                                |
| Planning vs execution separation           | Split reasoning and action                       | Improves reliability           | Standard agent pattern                                   |
| Autonomy level                             | Degree of independence                           | Capability measure             | chatbot → full autonomous system                         |
| Hooks                                      | Event-based triggers in systems                  | Automation layer               | Trigger actions on events like file change or tool call  |
| Vibe coding                                | Intuitive AI-assisted coding                     | Fast prototyping               | Risk: technical debt                                     |
| Spec-driven development                    | Build from formal specs                          | Reduces chaos                  | Best practice for AI coding                              |
| Iteration loop                             | build → test → fix                               | Core dev cycle                 | Iteration > perfect prompt                               |
| Cursor                                     | AI-first IDE                                     | Codebase-aware AI              | Strong refactoring + context                             |
| Claude                                     | Long-context AI assistant                        | Deep reasoning                 | Excellent for large files                                |
| Claude Code / agent mode                   | Agentic coding system                            | Automation                     | Repo-level changes                                       |
| Codebase indexing                          | Semantic project mapping                         | Global code understanding      | Without it AI is file-local                              |
| Embeddings (infra)                         | Text → vector representation                     | Semantic understanding         | Core retrieval building block                            |
| Vector database (infra)                    | Stores embeddings                                | Memory engine                  | Enables RAG systems                                      |
| Zero Trust                                 | Nothing trusted by default                       | Security foundation            | Verify every action                                      |
| Zero Retention                             | No data stored after processing                  | Privacy protection             | Used in enterprise AI systems                            |
| Data retention policy                      | Rules for storing data                           | Compliance                     | Defines storage duration                                 |
| PII                                        | Personal identifiable data                       | Privacy risk                   | Must be protected                                        |
| Encryption                                 | Securing data                                    | Security baseline              | Required everywhere                                      |
| Authentication                             | Identity verification                            | Access control                 | User/system identity                                     |
| Authorization                              | Permission control                               | Limits actions                 | Critical for agents                                      |
| Sandboxing                                 | Isolated execution                               | Safe tool use                  | Prevents system damage                                   |
| Least privilege                            | Minimal permissions                              | Risk reduction                 | Core security principle                                  |
| Audit logs                                 | Action history                                   | Debugging + compliance         | Required for traceability                                |
| Secure tool use                            | Safe function execution                          | Prevents abuse                 | Validate inputs and outputs                              |
| Policy engine                              | Rule system for behavior                         | Central control layer          | Separates logic from model                               |
| Observability                              | Monitoring system behavior                       | Debugging                      | Logs, metrics, traces                                    |
| Tracing                                    | Step-by-step execution logs                      | Agent debugging                | Critical for multi-agent systems                         |
| Rate limiting                              | Limits request volume                            | Abuse prevention               | API protection                                           |
| Multi-tenancy isolation                    | User separation                                  | Data safety                    | SaaS requirement                                         |
| Data minimization                          | Collect minimal data                             | Privacy compliance             | Reduces risk                                             |
| Redaction                                  | Removing sensitive data                          | Privacy protection             | Used in logs and training                                |
| Model governance                           | AI oversight system                              | Enterprise control             | Policies and approvals                                   |
| Compliance (GDPR etc.)                     | Legal data rules                                 | Mandatory requirement          | Impacts storage and usage                                |
| Skills                                     | Learned capabilities of model                    | Determines usefulness          | Emergent from training                                   |
| System prompt (behavioral control overlap) | Hidden instructions controlling behavior         | Ensures consistency            | Defines rules and identity                               |
| looping failure modes                      |                                                  |                                |                                                          |

## See also

* [xxxx](http://yyyyy)
