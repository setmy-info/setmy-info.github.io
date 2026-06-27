# LLM

## Information

* LLaMA 3
* OLLAMA
* Qwen
* DeepSeek Coder
* Code Llama
* vLLM
* Text Generation Inference
* LM Studio
* Open WebUI

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

  For fast prototyping – Pickle + a dictionary class
  For LLM workflows – HuggingFace Tokenizers (saves automatically)
  For Estonian-language processing – EstNLTK or spaCy `et_core_news_sm`
  For production environments – Redis or PostgreSQL
  For large corpora – SQLite or LevelDB

  EstNLTK is one of the strongest choices for Estonian tokenization
  Hugging Face multilingual models (`bert-base-multilingual`, `XLM-R`) work well with Estonian
  SentencePiece is useful when training your own model on Estonian text

Simple stack (local)
Ollama (LLM)
sentence-transformers (embeddings)
SQLite / DuckDB / Chroma / FAISS

IntelliJ
Continue.dev
Ollama + DeepSeek Coder
AGENT.md + TASKS.md

DeepSeek Coder Specialized for code generation, strong for Java and Maven + JUnit, local CPU/GPU use
Code Llama Meta model optimized for code generation, 7B–34B parameters
Qwen-Coder Open-source model family for multiturn coding tasks, 0.5B–32B+ parameters
StarCoder / StarCoderBase Trained heavily on GitHub code, 15B, GPU recommended

Model Size Strengths
Llama 1B–405B General-purpose, large ecosystem
Qwen 0.5B–235B+ Very strong for coding and multilingual tasks
DeepSeek 1.5B–671B Good quality-to-cost ratio, strong reasoning
Mistral 3B–141B Fast and efficient
Gemma 1B–27B Smaller models for local usage
Phi 1.5B–14B Very good with limited resources
OLMo 1B–32B Fully open training data
Falcon 1B–180B Still used in some enterprises

Model Notes
all-MiniLM-L6-v2 Very fast and accurate for passage embeddings
nomic-embed-text Open-source, well suited for document indexing
bge-small / bge-large Very good for semantic search, open-source
text-embedding-3-small / 3-large If you want a more OpenAI-style option, these are common reference models

Coding Agent → DeepSeek / Code Llama / StarCoder
Review Agent → LLaMA 3 / Mistral / Falcon
Knowledge embeddings → MiniLM / nomic-embed-text / bge
Orchestrator → a simple daemon or Zeebe; no LLM required

Embedding / Vector DB, FAISS, Chroma, Qdrant

| Agent                                     | Tokenization | Cost                 |
|-------------------------------------------|--------------|----------------------|
| Cloud GPT / OpenAI                        | automatic    | token-based          |
| Local LLM (`Ollama`, `LLaMA`)             | local        | free except hardware |
| Cloud embedding services                  | automatic    | token-based          |
| Local embeddings (`FAISS` + transformers) | local        | free                 |

Chip Huyen book
What is inference and what is retrieval

Local RAG PoC
1 LLM
1 vector DB
1 document

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

| Topic                                  | What it is                                             | Why it matters                  | Practical insights / pro tips                              |
|----------------------------------------|--------------------------------------------------------|---------------------------------|------------------------------------------------------------|
| **— Model fundamentals —**             |                                                        |                                 |                                                            |
| LLM (Large Language Model)             | Neural network that predicts next tokens in text       | Core AI intelligence layer      | Not human reasoning — output depends on prompt + context   |
| Model                                  | Trained neural network                                 | Core engine behind AI systems   | Stateless unless external memory is added                  |
| Token                                  | Smallest unit of text                                  | Cost + context limitation unit  | More tokens = higher cost + slower responses               |
| Context window                         | Maximum text model can process at once                 | Limits working memory           | Old info is dropped → use RAG or summarization             |
| Inference                              | Running the model to generate output                   | Actual usage phase              | Every response is an inference call                        |
| Training                               | Building a model from scratch                          | Creates foundation models       | Done only by large labs                                    |
| Pretraining                            | First phase of training on general data                | Learns language + patterns      | Base capability layer                                      |
| Fine-tuning                            | Training on specific dataset                           | Specializes model behavior      | Used for domain adaptation                                 |
| Supervised fine-tuning (SFT)           | Fine-tuning on labeled prompt-response pairs           | Teaches desired task behavior   | Standard first alignment step before preference training   |
| Instruction tuning                     | Training on instruction-following examples             | Improves usability              | Better prompt adherence                                    |
| Autonomous Learning (AL)               | Model improves through self-directed data or tasks     | Reduces manual supervision need | Quality depends heavily on feedback loops and safeguards   |
| ICM (Internal Coherence Maximization)  | Approach that pushes outputs toward internal harmony   | Improves consistency            | Useful concept for reasoning stability, but verify claims  |
| UPFT (Unsupervised Prefix Fine-Tuning) | Prefix-based adaptation without full supervised labels | Lightweight specialization      | Useful when labels are limited and prompt prefixes matter  |
| RLHF                                   | Human feedback training                                | Alignment & safety              | Improves helpfulness and reduces harmful outputs           |
| Reinforcement (RLHF/DPO)               | Preference-based optimization after SFT                | Aligns model behavior           | Often used to improve helpfulness, style, or policy fit    |
| DPO (Direct Preference Optimization)   | Optimizes preferred answers directly from comparisons  | Simpler alignment alternative   | Often easier than full RLHF pipelines                      |
| State vs stateless LLM                 | Whether memory exists internally                       | Architecture constraint         | Most LLMs are stateless                                    |
| Hallucination                          | Model generates incorrect info                         | Reliability risk                | Reduce with RAG, tools, validation                         |
| KV cache                               | Cached attention keys/values during inference          | Performance optimization        | Avoids recomputing tokens already seen in context          |
| Context compression / compaction       | Summarizing or pruning conversation history            | Extends effective context       | Prevents context overflow in long sessions                 |
| **— Inference parameters —**           |                                                        |                                 |                                                            |
| Temperature                            | Controls randomness of output                          | Output variability              | 0 = deterministic, 1+ = creative; use low for code         |
| Top-p (nucleus sampling)               | Samples from smallest token set covering p% prob mass  | Balances diversity + coherence  | Usually 0.9–0.95; combine with temperature                 |
| Top-k                                  | Limits sampling to k most likely tokens                | Reduces incoherence             | Alternative to top-p; k=1 is greedy                        |
| Max tokens                             | Maximum output length                                  | Cost + latency control          | Set per-request; affects truncation                        |
| Stop sequences                         | Tokens that terminate generation                       | Output boundary control         | Useful for structured output parsing                       |
| Streaming                              | Returning tokens as generated                          | Perceived responsiveness        | Essential for interactive UIs                              |
| **— Model optimization —**             |                                                        |                                 |                                                            |
| Quantization                           | Reducing model weight precision (e.g. Q4, Q8)          | Smaller size, faster inference  | Trade-off: lower quality at extreme compression            |
| GGUF                                   | File format for quantized local models                 | Enables local LLM deployment    | Used by llama.cpp and Ollama                               |
| LoRA (Low-Rank Adaptation)             | Lightweight fine-tuning via rank decomposition         | Efficient specialization        | Trains <1% of parameters; composable                       |
| QLoRA                                  | Quantized LoRA fine-tuning                             | Fine-tuning on consumer GPU     | Combines 4-bit quant with LoRA adapters                    |
| **— Prompting —**                      |                                                        |                                 |                                                            |
| Prompt                                 | Input instructions to model                            | Direct control interface        | Structure strongly affects output                          |
| Prompt engineering                     | Designing effective prompts                            | Improves output quality         | role → goal → constraints → examples                       |
| System prompt                          | Hidden high-priority instructions                      | Controls behavior               | Defines rules, tone, identity                              |
| Rules                                  | System constraints on behavior                         | Safety + consistency layer      | Includes safety, tool, formatting rules                    |
| Skills                                 | Reusable prompt/tool capability units                  | Modularity                      | Composable behaviors triggered by user or system           |
| Zero-shot prompting                    | Task given with no examples                            | Tests raw model capability      | Works well for simple tasks; fails on complex ones         |
| Few-shot prompting                     | Task given with a few examples in prompt               | Improves output format/accuracy | 3–5 examples usually sufficient                            |
| Role prompting                         | Assigning model a persona                              | Shapes response style           | "You are a senior Java engineer…"                          |
| Chain-of-thought (CoT)                 | Model reasons step-by-step before answering            | Improves complex reasoning      | Add "think step by step" or use structured scratchpad      |
| Context engineering                    | Crafting exactly what goes into the context window     | Output quality multiplier       | More impactful than prompt wording alone                   |
| Context stuffing                       | Overloading prompt with irrelevant data                | Degrades performance            | Keep input structured and minimal                          |
| **— Memory & retrieval —**             |                                                        |                                 |                                                            |
| Context (short-term memory)            | Active input window                                    | Immediate reasoning             | Limited by token window                                    |
| Memory (persistent)                    | External stored knowledge                              | Long-term continuity            | Usually vector DB + retrieval                              |
| Conversational memory                  | Session-only memory                                    | Dialogue coherence              | Lost when context fills                                    |
| Agent memory                           | Structured long-term memory                            | Enables agent intelligence      | Built via RAG + embeddings                                 |
| Episodic memory                        | Stored past interactions/events                        | Continuity across sessions      | Indexed by time or event type                              |
| Semantic memory                        | Stored facts and knowledge                             | Domain knowledge layer          | Backed by vector DB or knowledge graph                     |
| Procedural memory                      | Stored skills and workflows                            | Behavior reuse                  | Encoded as tool definitions or prompt templates            |
| RAG (Retrieval-Augmented Generation)   | Retrieves external knowledge before answering          | Extends model knowledge         | Core modern AI architecture                                |
| Embeddings                             | Vector representation of text meaning                  | Enables semantic search         | Finds meaning, not keywords                                |
| Vector database                        | Stores embeddings for retrieval                        | Retrieval system backbone       | Powers RAG and memory; FAISS, Chroma, Qdrant, pgvector     |
| Chunking                               | Splitting data into pieces for indexing                | Enables retrieval               | Required for large documents                               |
| Semantic chunking                      | Splitting by meaning boundaries, not fixed size        | Better retrieval accuracy       | Preferred over fixed-size chunks                           |
| Hybrid search                          | Combining keyword (BM25) + semantic (vector) search    | Best retrieval recall           | Standard production RAG pattern                            |
| BM25                                   | Classical keyword ranking algorithm                    | Exact-match retrieval           | Complements vector search in hybrid setups                 |
| Reranking                              | Secondary scoring of retrieved results                 | Precision improvement           | Cross-encoder models re-score top-k candidates             |
| RAG filtering                          | Filtering retrieved data before injection              | Security + correctness          | Prevent malicious or irrelevant data                       |
| **— Agentic patterns —**               |                                                        |                                 |                                                            |
| Agent                                  | LLM + tools + memory + loop                            | Turns model into actor          | Can execute tasks autonomously                             |
| Agent loop                             | plan → act → observe → refine                          | Core agent behavior             | Bad loops cause instability                                |
| ReAct (Reason + Act)                   | Interleaves reasoning traces with tool actions         | Transparent decision-making     | Standard agentic pattern; reduces hallucination            |
| Tree-of-thought (ToT)                  | Explores multiple reasoning branches                   | Better complex problem solving  | Higher token cost; use for hard planning tasks             |
| Reflection / self-correction           | Agent critiques and revises its own output             | Quality improvement             | Add a critic step after executor                           |
| Human-in-the-loop (HITL)               | Human approval at key decision points                  | Safety + oversight              | Required for irreversible or high-risk actions             |
| Planner                                | Creates step-by-step plan                              | Structure                       | Breaks tasks into actions                                  |
| Executor                               | Executes actions                                       | Action layer                    | Uses tools, APIs, code                                     |
| Critic / reviewer                      | Evaluates outputs                                      | Quality control                 | Enables self-correction                                    |
| Router agent                           | Dispatches tasks to specialized sub-agents             | Scalable multi-agent design     | Routes by intent, domain, or capability                    |
| Supervisor / worker pattern            | Central agent coordinates worker agents                | Parallel workload decomposition | Worker agents are stateless; supervisor manages state      |
| Sub-agent                              | Specialized internal agent                             | Modular architecture            | e.g. coder / tester / planner                              |
| Multi-agent system                     | Multiple cooperating AI agents                         | Parallelism + specialization    | Harder to debug; needs tracing                             |
| Agent-to-Agent (A2A)                   | Protocol for direct agent-to-agent communication       | Interoperability standard       | Google-led standard; complements MCP                       |
| Feedback loop (agentic)                | Agent output becomes next input                        | Iterative refinement            | Can diverge — add termination conditions                   |
| Looping failure modes                  | Agent stuck in infinite or oscillating loop            | Stability risk                  | Add step limits, progress checks, and human escalation     |
| Tool use / function calling            | LLM calls external functions                           | Real-world interaction          | Essential for agents                                       |
| Structured output                      | Model returns JSON/schema-constrained response         | Reliable parsing                | Use tool-calling or guided generation                      |
| Orchestration                          | Coordination of agents/tools                           | System control                  | Manages workflows                                          |
| Workflow (agentic)                     | Structured AI process                                  | Production reliability          | Hybrid deterministic + AI                                  |
| Planning vs execution separation       | Split reasoning and action                             | Improves reliability            | Standard agent pattern                                     |
| Autonomy level                         | Degree of independence                                 | Capability measure              | chatbot → full autonomous system                           |
| Hooks                                  | Event-based triggers in systems                        | Automation layer                | Trigger actions on events like file change or tool call    |
| **— MCP (Model Context Protocol) —**   |                                                        |                                 |                                                            |
| MCP (Model Context Protocol)           | Open standard for AI model ↔ data source connections   | Universal integration layer     | Replaces per-service custom integrations                   |
| MCP Host                               | AI application consuming MCP servers                   | Integration entry point         | Claude Desktop, IDEs, custom agents                        |
| MCP Server                             | Exposes tools/resources/prompts via MCP                | Capability provider             | One server per data source or API                          |
| MCP Client                             | Protocol implementation inside the host                | Communication layer             | Handles discovery, calls, and responses                    |
| MCP Transport                          | How host and server communicate                        | Deployment flexibility          | stdio for local; HTTP+SSE for remote                       |
| MCP Tools                              | Callable functions exposed by MCP server               | Action surface                  | Model decides when to call them                            |
| MCP Resources                          | URI-addressed data exposed by MCP server               | Data access layer               | Files, DB rows, API results                                |
| MCP Prompts                            | Reusable prompt templates from MCP server              | Standardized instructions       | Server-side prompt management                              |
| MCP Sampling                           | Server requests a completion from the host model       | Server-initiated reasoning      | Enables complex server-side workflows                      |
| **— Security —**                       |                                                        |                                 |                                                            |
| Guardrails                             | Constraints on outputs/actions                         | Safety layer                    | Prevent unsafe or invalid actions                          |
| Jailbreak                              | Attempt to bypass safety rules                         | Security risk                   | Requires filtering and guardrails                          |
| Prompt injection                       | Malicious input manipulation                           | Major AI security risk          | Treat all external input as untrusted                      |
| Sandboxing                             | Isolated execution environment                         | Safe tool use                   | Prevents system damage from agent actions                  |
| Least privilege                        | Minimal permissions granted                            | Risk reduction                  | Core security principle for agents                         |
| Zero Trust                             | Nothing trusted by default                             | Security foundation             | Verify every action, every call                            |
| Zero Retention                         | No data stored after processing                        | Privacy protection              | Used in enterprise AI systems                              |
| Content filtering                      | Blocking unsafe inputs or outputs                      | Harm prevention                 | Pre- and post-generation filtering                         |
| Red teaming                            | Adversarial testing of AI systems                      | Finds safety gaps               | Standard before production deployment                      |
| Model output validation                | Checking model response against schema/rules           | Correctness + safety            | Reject or retry on schema violations                       |
| PII                                    | Personal identifiable data                             | Privacy risk                    | Must be protected; redact before sending to model          |
| Audit logs                             | Action history                                         | Debugging + compliance          | Required for traceability in agentic systems               |
| Secure tool use                        | Safe function execution with input/output validation   | Prevents abuse                  | Validate before and after every tool call                  |
| Policy engine                          | Rule system for behavior                               | Central control layer           | Separates logic from model                                 |
| Encryption                             | Securing data at rest and in transit                   | Security baseline               | Required everywhere                                        |
| Authentication                         | Identity verification                                  | Access control                  | User/system identity                                       |
| Authorization                          | Permission control                                     | Limits actions                  | Critical for agents acting on behalf of users              |
| Data retention policy                  | Rules for storing data                                 | Compliance                      | Defines storage duration                                   |
| Data minimization                      | Collect minimal data                                   | Privacy compliance              | Reduces risk surface                                       |
| Redaction                              | Removing sensitive data from logs or prompts           | Privacy protection              | Apply before storing or training                           |
| Rate limiting                          | Limits request volume                                  | Abuse prevention                | API protection and cost control                            |
| Multi-tenancy isolation                | User data separation                                   | Data safety                     | SaaS requirement                                           |
| Model governance                       | AI oversight policies and approvals                    | Enterprise control              | Policies and change approvals                              |
| Compliance (GDPR etc.)                 | Legal data rules                                       | Mandatory requirement           | Impacts storage, training, and data sharing                |
| **— Observability —**                  |                                                        |                                 |                                                            |
| Observability                          | Monitoring system behavior                             | Debugging                       | Logs, metrics, traces                                      |
| Tracing                                | Step-by-step execution logs                            | Agent debugging                 | Critical for multi-agent systems                           |
| **— Frameworks & tools —**             |                                                        |                                 |                                                            |
| Ollama                                 | Local LLM serving runtime                              | Run models without cloud        | Supports Llama, Mistral, DeepSeek, etc.                    |
| LangChain                              | Framework for chaining LLM calls and tools             | Rapid agent prototyping         | Large ecosystem; can become complex                        |
| LangGraph                              | Graph-based multi-agent workflow framework             | Stateful agent workflows        | Built on LangChain; supports cycles                        |
| LlamaIndex                             | RAG and data ingestion framework                       | Document-based AI systems       | Strong ingestion pipeline; many connectors                 |
| CrewAI                                 | Role-based multi-agent framework                       | Structured team-of-agents       | Easy to define roles; opinionated                          |
| AutoGen                                | Microsoft multi-agent conversation framework           | Automated agent collaboration   | Agents converse to solve tasks                             |
| Semantic Kernel                        | Microsoft SDK for LLM + plugin integration             | Enterprise .NET/Python AI apps  | Strong Azure + OpenAI integration                          |
| **— Agent state & task management —**  |                                                        |                                 |                                                            |
| Scratchpad / working memory            | Temporary reasoning space within a single run          | Intermediate computation        | Invisible to user; used for CoT and planning steps         |
| Agent state machine                    | Explicit states + transitions for agent lifecycle      | Predictable behavior            | States: idle → planning → executing → verifying → done     |
| Checkpoint / resume                    | Saving agent progress for recovery or continuation     | Fault tolerance                 | Required for long-running tasks exceeding context window   |
| Task decomposition                     | Breaking a goal into ordered sub-tasks                 | Manageability                   | Planner output; enables parallelism                        |
| Parallelism vs sequential execution    | Running agent tasks concurrently vs in order           | Performance vs correctness      | Use parallel for independent tasks; sequential for deps    |
| Task queue                             | Ordered list of pending agent tasks                    | Load management                 | Decouple producer from consumer; use priority queues       |
| Dead letter queue (agent)              | Queue for failed/unresolvable tasks                    | Failure isolation               | Prevents silent drops; enables human review                |
| Priority queue                         | Task ordering by urgency or importance                 | Resource allocation             | High-priority tasks preempt lower ones                     |
| Token budget                           | Maximum tokens allocated per task or session           | Cost + stability control        | Enforce per-request and per-session limits                 |
| Shared memory (multi-agent)            | Writable memory accessible by all agents in a system   | Coordination                    | Needs locking or versioning to prevent conflicts           |
| Blackboard pattern                     | Shared data structure agents read/write to coordinate  | Decoupled multi-agent design    | Classic AI architecture; producer–consumer per agent       |
| **— Reliability & resilience —**       |                                                        |                                 |                                                            |
| Retry strategy                         | Re-attempting failed calls with rules                  | Transient fault tolerance       | Use exponential backoff + jitter; cap max attempts         |
| Exponential backoff                    | Increasing delay between retries                       | Prevents thundering herd        | Double delay each retry; add random jitter                 |
| Circuit breaker                        | Stops calls to failing service after threshold         | Failure containment             | Open → half-open → closed state machine                    |
| Idempotency                            | Same operation produces same result when repeated      | Safe retries                    | Design all tool calls to be idempotent                     |
| Timeout handling                       | Aborting calls that exceed a time limit                | Prevents infinite waits         | Set per-tool and per-agent-loop timeouts                   |
| Graceful degradation / fallback        | Reduced functionality when component fails             | Availability                    | Fallback to simpler model or cached response               |
| Compensation / rollback                | Undoing effects of a failed multi-step action          | Data consistency                | Required for agents that write to external systems         |
| Saga pattern                           | Distributed transaction via compensating steps         | Consistency without locking     | Each agent step has a compensating undo step               |
| Error classification                   | Distinguishing transient vs fatal errors               | Correct retry logic             | Transient: retry; fatal: escalate to human                 |
| Step limit / max iterations            | Hard cap on agent loop cycles                          | Prevents runaway agents         | Always set; log and escalate when hit                      |
| **— Evaluation & testing —**           |                                                        |                                 |                                                            |
| Evals (evaluation framework)           | Systematic testing of LLM / agent output quality       | Measures real capability        | Define before building; run on every change                |
| LLM-as-judge                           | Using another LLM to score outputs                     | Scalable quality assessment     | Use stronger model as judge; watch for self-serving bias   |
| Golden dataset                         | Curated input/expected-output pairs                    | Regression test baseline        | Must be representative; update as system evolves           |
| Hallucination detection                | Checking if output contradicts source or facts         | Reliability assurance           | Compare against retrieved context or known ground truth    |
| Retrieval recall / precision           | Measures how well RAG finds the right chunks           | RAG quality                     | Low recall → missed answers; low precision → noise         |
| Regression testing (agents)            | Re-running evals after any model or prompt change      | Prevent quality degradation     | Automate in CI/CD pipeline                                 |
| A/B testing (model versions)           | Comparing two model or prompt variants in production   | Data-driven decisions           | Route % of traffic; measure task success rate              |
| Benchmarking                           | Running standard tasks to compare models               | Model selection                 | MMLU, HumanEval, SWE-bench are common benchmarks           |
| Shadow mode testing                    | Running new agent in parallel without acting           | Safe validation                 | Compare shadow vs production outputs before cutover        |
| **— Cost & performance —**             |                                                        |                                 |                                                            |
| Prompt caching                         | Reusing computed prefix context across requests        | Significant cost reduction      | Supported by Anthropic, OpenAI; cache system prompts       |
| Batch API / async inference            | Submitting many requests processed offline             | Lower cost, higher throughput   | 50% cost reduction typically; not for real-time            |
| Model routing                          | Directing requests to cheap vs powerful models         | Cost optimization               | Simple tasks → small model; complex → large model          |
| Token cost tracking                    | Accounting for input + output tokens per operation     | Budget management               | Track per agent, per user, per workflow                    |
| Latency SLA                            | Maximum acceptable response time                       | User experience                 | First-token latency vs full-response latency differ        |
| Caching (semantic)                     | Reusing answers for semantically similar queries       | Speed + cost                    | Use embedding similarity to detect cache hits              |
| **— Deployment & infrastructure —**    |                                                        |                                 |                                                            |
| LLM proxy / model gateway              | Middleware routing and managing LLM API calls          | Centralized control             | Handles routing, auth, logging, fallback; e.g. LiteLLM     |
| Agent registry / catalog               | Inventory of available agents and their capabilities   | Discoverability                 | Enables dynamic routing and composition                    |
| Model versioning                       | Tracking deployed model versions                       | Rollback + reproducibility      | Pin model version per use-case; test before upgrade        |
| Canary release (agents)                | Gradual rollout of new agent/model version             | Risk reduction                  | Start at 1–5% traffic; monitor evals before full rollout   |
| Blue/green deployment (models)         | Two live environments for instant model switchover     | Zero-downtime updates           | Keep old version hot during cutover                        |
| Sidecar agent                          | Agent running alongside a service to assist it         | Transparent augmentation        | e.g. auto-generates docs, tests, or logs alongside service |
| Event-driven agent                     | Agent triggered by events rather than polling          | Reactive architecture           | Subscribe to queues/topics; act on arrival                 |
| Message queue / event bus              | Async communication channel between agent components   | Decoupling                      | RabbitMQ, Kafka, Zeebe; enables retry and dead-letter      |
| **— Advanced RAG & knowledge —**       |                                                        |                                 |                                                            |
| Self-RAG                               | Agent decides when and what to retrieve                | Adaptive retrieval              | Avoids unnecessary retrieval on simple queries             |
| Corrective RAG (CRAG)                  | Evaluates retrieved docs and corrects if poor quality  | Retrieval quality guard         | Falls back to web search if local retrieval scores low     |
| GraphRAG                               | RAG over knowledge graphs instead of flat vectors      | Relational knowledge retrieval  | Better for interconnected facts; higher setup cost         |
| Knowledge graph                        | Graph of entities and relationships                    | Structured domain knowledge     | Enables reasoning over relationships, not just similarity  |
| Document understanding                 | Extracting structured info from PDFs, tables, images   | Ingestion quality               | Pre-process before chunking; use vision models for images  |
| Data lineage                           | Tracking data origin and transformations               | Auditability + compliance       | Know what source backs every generated fact                |
| **— Protocols & standards —**          |                                                        |                                 |                                                            |
| JSON-RPC                               | Lightweight RPC protocol using JSON                    | MCP underlying transport        | Stateless; request/response + notification patterns        |
| SSE (Server-Sent Events)               | Server pushes events to client over HTTP               | Real-time streaming             | Used by MCP HTTP transport; one-directional                |
| OpenAPI / Swagger                      | Standard for describing REST API schemas               | Tool definition format          | Agents can consume OpenAPI specs to discover tools         |
| JSON Schema                            | Vocabulary for describing JSON data structures         | Structured output validation    | Define expected output shape; validate before parsing      |
| gRPC                                   | High-performance RPC framework using Protobuf          | Agent microservice comms        | Faster than REST; schema-first; streaming support          |
| **— Multimodal —**                     |                                                        |                                 |                                                            |
| Multimodal input                       | Model processes text, images, audio, or video          | Richer context                  | Vision models can read screenshots, diagrams, documents    |
| Vision / image understanding           | Model analyzes image content                           | Document + UI automation        | Enables agents to read screenshots, charts, OCR text       |
| Audio transcription                    | Converting speech to text                              | Voice-driven agents             | Whisper and similar models; feed transcript to LLM         |
| **— AI-assisted development —**        |                                                        |                                 |                                                            |
| CLAUDE.md / AGENT.md                   | Project-level instructions file for AI agents          | Persistent agent context        | Defines rules, structure, conventions for the codebase     |
| Codebase indexing                      | Semantic project mapping                               | Global code understanding       | Without it AI is file-local                                |
| AI pair programming                    | Developer + AI collaborating on code in real time      | Speed + quality                 | Best with short tasks and human review                     |
| Spec-driven development                | Build from formal specifications                       | Reduces AI chaos                | Best practice for agentic coding projects                  |
| Vibe coding                            | Intuitive AI-assisted coding without formal specs      | Fast prototyping                | Risk: technical debt accumulation                          |
| Iteration loop                         | build → test → fix cycle with AI                       | Core agentic dev cycle          | Iteration beats perfect prompting                          |
| Claude Code / agent mode               | Agentic coding system by Anthropic                     | Repo-level automation           | Reads, edits, runs, and verifies code end-to-end           |
| Cursor                                 | AI-first IDE                                           | Codebase-aware AI               | Strong refactoring + multi-file context                    |

## See also

* [xxxx](http://yyyyy)
