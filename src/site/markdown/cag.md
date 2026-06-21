# Cache Augmented Generation (CAG)

## Information

Cache Augmented Generation (CAG) is an alternative to Retrieval-Augmented Generation (RAG) where the entire knowledge
source is pre-processed and loaded directly into the LLM's extended context window at inference time, rather than
retrieved on demand from a vector database.

**How it differs from RAG:**

| Aspect             | RAG                                              | CAG                                                  |
|--------------------|--------------------------------------------------|------------------------------------------------------|
| Knowledge loading  | Retrieved at query time (top-k chunks)           | Loaded upfront into context window                   |
| Retrieval step     | Required (embedding + vector search)             | Not needed                                           |
| Latency            | Higher (retrieval adds round-trip)               | Lower (no retrieval step)                            |
| Accuracy           | Depends on retrieval quality and chunking        | No chunking errors — full source is available        |
| Context limit      | Can handle large knowledge bases                 | Bounded by the model's context window size           |
| Infrastructure     | Requires vector DB (Chroma, Qdrant, Weaviate...) | No vector DB needed — simpler deployment             |
| Token cost         | Only relevant chunks sent per query              | Full knowledge source sent with every query          |

**When to use CAG:**

* The knowledge base fits within the model's context window (e.g., 128k–1M tokens).
* Low latency is more important than per-query token cost.
* You want to avoid the complexity of a vector database and retrieval pipeline.
* The knowledge source changes infrequently (cache can be pre-computed via KV cache).

**Limitations:**

* Context window limits cap the knowledge base size — not suitable for very large document collections.
* Higher token cost per query compared to RAG where only relevant chunks are sent.
* Some models perform less reliably with very long contexts (lost-in-the-middle problem).

## Usage, tips and tricks

* Use KV cache (key-value cache) features of your inference server to avoid re-processing the knowledge context on
  every query — this is the "cache" in CAG.
* Pre-process and structure the knowledge document for clarity — the model reads the whole thing, so headings and
  organization matter.
* For models with large context windows (Gemini 1.5, Claude 3, GPT-4 Turbo), CAG is a practical choice for
  knowledge bases up to a few hundred pages.
* Combine with system prompt instructions to guide how the model uses the cached knowledge.

## See also

* [RAG (Retrieval-Augmented Generation)](rag.md)
* [LLM](llm.md)
* [VectorDB](vectordb.md)
* [AI Agent](agent.md)
