# Text Generation Inference

## Information

`Text Generation Inference` (`TGI`) is a scalable inference server for serving transformer-based language models through
an API.

It is commonly associated with the `Hugging Face` ecosystem and is used to expose production-oriented text generation
services.

### What is it for?

Typical `Text Generation Inference` use cases include:

* serving open models behind a scalable API server
* deploying LLM inference workloads in containers or Kubernetes
* handling production text generation with batching and streaming
* running internal model endpoints for applications and tools
* standardizing self-hosted model serving in platform teams

## Usage

`TGI` is useful when teams want a dedicated API server for self-hosted inference and need better scalability than a
desktop-oriented runtime provides. It fits well into containerized and platform-engineering workflows.

## Similar Software

* **[vLLM](vllm.md):** High-performance LLM inference engine often chosen for production serving.
* **[Ollama](ollama.md):** Easier local runtime for development and lighter self-hosted use.
* **[KServe](https://kserve.github.io/website/):** Kubernetes-based model serving platform.

## See also

* [Text Generation Inference](https://github.com/huggingface/text-generation-inference)
* [Hugging Face](https://huggingface.co/)
* [LLM](llm.md)
* [AI](ai.md)
