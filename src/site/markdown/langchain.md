# LangChain

## Information

### Introduction

LangChain is an open-source framework designed to simplify the creation of applications using large language models
(LLMs). It provides a standard interface for chains, many integrations with other tools, and end-to-end chains for
common
applications. LangChain allows developers to build applications that are:

* **Data-aware:** Connect a language model to other sources of data.
* **Agentic:** Allow a language model to interact with its environment.

### What is it for?

LangChain provides several modules that address different aspects of building LLM applications:

* **Model I/O:** Manage prompts, language models, and output parsers.
* **Retrieval:** Interact with your application-specific data (RAG - Retrieval Augmented Generation).
* **Composition:** Higher-level components that combine other modules into "chains".
* **Agents:** Allow the model to choose which tools to use to accomplish a task.
* **Memory:** Persist state between calls of a chain.

## Usage

### Python

LangChain's original and most feature-complete implementation is in Python.

**Installation:**

```bash
pip install langchain
# or for a more modular installation
pip install langchain-core langchain-community
```

**Basic Example:**

```python
from langchain_openai import OpenAI
from langchain_core.prompts import PromptTemplate

llm = OpenAI(temperature=0.9)
prompt = PromptTemplate.from_template("What is a good name for a company that makes {product}?")
chain = prompt | llm

print(chain.invoke({"product": "colorful socks"}))
```

### Node.js / TypeScript

LangChain.js brings the power of the LangChain framework to the JavaScript/TypeScript ecosystem, enabling LLM
applications in the browser or on the server with Node.js.

**Installation:**

```bash
npm install langchain @langchain/core @langchain/community
```

**Basic Example:**

```typescript
import {OpenAI} from "@langchain/openai";
import {PromptTemplate} from "@langchain/core/prompts";

const model = new OpenAI({temperature: 0.9});
const template = "What is a good name for a company that makes {product}?";
const prompt = PromptTemplate.fromTemplate(template);

const chain = prompt.pipe(model);

const res = await chain.invoke({product: "colorful socks"});
console.log(res);
```

### Java

In the Java ecosystem, the most prominent implementation inspired by LangChain is **LangChain4j**.

For Spring Boot projects, another important option is **Spring AI**. A practical rule of thumb is:

* use `LangChain4j` when you want Java-centric LangChain-style abstractions and AI service patterns
* use `Spring AI` when you want Spring Boot native configuration and integrations
* use direct SDKs when you need raw provider-specific control

**Installation (Maven):**

```xml

<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-open-ai</artifactId>
    <version>0.35.0</version>
</dependency>
```

**Basic Example:**

```java
import dev.langchain4j.model.openai.OpenAiChatModel;

public class Main {
    public static void main(String[] args) {
        OpenAiChatModel model = OpenAiChatModel.withApiKey("your-api-key");
        String response = model.generate("What is a good name for a company that makes colorful socks?");
        System.out.println(response);
    }
}
```

### Spring Boot and Java notes

#### LangChain vs LangChain4j vs Spring AI

* **LangChain:** Originally the Python ecosystem framework, with a JavaScript implementation as well.
* **LangChain4j:** The Java ecosystem framework most closely aligned with LangChain ideas.
* **Spring AI:** The Spring ecosystem abstraction for integrating AI models, embeddings, vector stores, and tools in
  Spring Boot applications.

In practice, Java teams often choose between `LangChain4j` and `Spring AI` rather than using Python LangChain
directly.

#### When to choose LangChain4j

`LangChain4j` is a good choice if you need:

* Java-first APIs for chat, embeddings, and moderation-like workflows
* AI services mapped to annotated Java interfaces
* memory, retrieval, and tool support in a Java style
* framework usage that is not limited to Spring Boot only

#### When to choose Spring AI instead

`Spring AI` is often the better fit if your application is already heavily based on Spring Boot and you want:

* starter-based autoconfiguration
* property-driven setup in `application.yml`
* Spring-friendly abstractions around model providers and vector stores
* easier alignment with the rest of the Spring ecosystem

#### Spring Boot integration tips

* Wrap model access in a service instead of calling providers directly from controllers.
* Keep prompts versioned and testable.
* Return structured outputs for business workflows where possible.
* Use Spring profiles to switch between local and cloud-backed models.
* Add observability around latency, token usage, failures, and retries.

#### Related Java ecosystem tools

Useful tools often combined with `LangChain4j` or `Spring AI`:

* `Ollama` for local model execution
* vector databases such as `pgvector`, `Milvus`, `Weaviate`, or `Qdrant`
* Spring Boot scheduling and batch processing for document ingestion
* Spring Security for protecting AI-backed APIs

## Similar Software

Several other frameworks and libraries offer similar capabilities for building LLM-powered applications:

* **[LlamaIndex](https://www.llamaindex.ai/):** Specifically focused on data retrieval and indexing (RAG).
* **[Haystack](https://haystack.deepset.ai/):** An open-source NLP framework by Deepset for building search and RAG
  pipelines.
* **[Semantic Kernel](https://github.com/microsoft/semantic-kernel):** Microsoft's SDK for integrating LLMs with
  conventional programming languages like C#, Python, and Java.
* **[AutoGPT](https://github.com/Significant-Gravitas/AutoGPT):** Focused on autonomous AI agents.
* **[CrewAI](https://www.crewai.com/):** A framework for orchestrating role-playing, collaborative AI agents.
* **[Spring AI](https://spring.io/projects/spring-ai):** Provides a Spring-friendly API for interacting with various AI
  models and vector stores.

## Configuration

Configuration typically involves setting environment variables for API keys (e.g., `OPENAI_API_KEY`) or using
provider-specific configuration objects in code.

## See also

* [LangChain Official Website](https://www.langchain.com/)
* [LangChain Python Documentation](https://python.langchain.com/)
* [LangChain.js Documentation](https://js.langchain.com/)
* [LangChain4j (Java) GitHub](https://github.com/langchain4j/langchain4j)
* [AI](ai.md)
* [AI Agent](agent.md)
* [AI Tools](aitools.md)
* [Model Context Protocol (MCP)](mcp.md)
* [VectorDB](vectordb.md)
* [OpenVPN](openvpn.md)
