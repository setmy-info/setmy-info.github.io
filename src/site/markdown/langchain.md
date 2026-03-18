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
