# LangGraph

## Information

`LangGraph` is a framework for building stateful, graph-based LLM and agent workflows.

It is commonly used when simple chains are not enough and you need explicit control over workflow steps, branching,
loops, retries, checkpoints, or multi-agent orchestration.

### What is it for?

Typical `LangGraph` use cases include:

* agent workflows with multiple steps and decision points
* long-running tasks with persisted state
* human-in-the-loop approvals
* tool-calling flows with retries and fallback paths
* multi-agent systems where specialized agents cooperate

## Usage

`LangGraph` is closely related to the `LangChain` ecosystem and is typically used when you want a graph/state-machine
approach rather than only linear chains.

## Similar Software

* **[LangChain](https://www.langchain.com/):** General framework for LLM applications and chains.
* **[CrewAI](https://www.crewai.com/):** Role-based multi-agent orchestration.
* **[Haystack](https://haystack.deepset.ai/):** Search, retrieval, and RAG pipelines.

## See also

* [LangGraph](https://www.langchain.com/langgraph)
* [LangChain](langchain.md)
* [AI Agent](agent.md)
* [AI](ai.md)
* [LLM](llm.md)
