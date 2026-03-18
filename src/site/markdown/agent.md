# AI Agent

## Information

### Introduction

An AI agent is an autonomous or semi-autonomous system that uses artificial intelligence (primarily Large Language
Models) to achieve specific goals by interacting with its environment. Unlike traditional AI models that simply respond
to prompts, an AI agent can reason, plan, and execute actions using external tools to complete complex tasks.

### How it works

AI agents typically operate in a loop, often referred to as a **Reasoning-Action (ReAct)** cycle:

1. **Perception:** The agent receives a task or environment state (input/prompt).
2. **Reasoning:** The agent analyzes the task, breaks it down into sub-tasks, and decides what to do next.
3. **Planning:** The agent selects the appropriate tools or steps to achieve the goal.
4. **Action:** The agent executes the plan (e.g., calling an API, searching the web, or writing code).
5. **Observation:** The agent observes the results of its action and updates its context.
6. **Iteration:** The loop continues until the goal is achieved or a termination condition is met.

### Model Interaction & Modalities

How models are called and what information they can process:

* **Textual Input:** The most common method, using structured text prompts (Markdown, JSON).
* **Multimodal Input:** Modern models can also process images (OCR, visual analysis), audio (transcription, emotion
  detection), and video.
* **Structured Output:** Models can be instructed to return data in specific formats like JSON or XML, which is crucial
  for tool calling and automation.
* **Function/Tool Calling:** Instead of just generating text, models can "call" functions by outputting the function
  name and required arguments.
* **API-Based:** Most models are accessed via REST APIs or specialized SDKs (like OpenAI, Anthropic, or LangChain).

### Functionality & Usage

What AI agents usually do inside ecosystems like **Model Context Protocol (MCP)** or similar:

* **Tool Use:** Agents can call functions, query databases (via MCP servers), and interact with APIs.
* **File Interaction:** Reading, writing, and modifying files in a local or remote file system.
* **Web Research:** Searching the internet and synthesizing information from multiple sources.
* **Code Execution:** Writing and running code to solve mathematical problems or automate tasks.
* **Cross-Platform Integration:** Bridging the gap between different software services and data silos.

### Key Characteristics & Features

* **Autonomy:** The ability to make decisions without constant human intervention.
* **Memory:** Maintaining short-term (context window) and long-term (vector database) memory of past interactions.
* **Goal-Oriented:** Focused on achieving a specific outcome rather than just generating text.
* **Adaptive:** Capable of correcting its own errors and changing its strategy based on feedback.
* **Tool-Augmented:** Leveraging external software (calculators, browsers, databases) to extend its capabilities.

## Installation

### Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [AI](ai.md)
* [AI Tools](aitools.md)
* [Model Context Protocol (MCP)](mcp.md)
* [LangChain](langchain.md)
* [VectorDB](vectordb.md)
* [OpenVPN](openvpn.md)
* [Don't learn AI Agents without Learning these Fundamentals](https://www.youtube.com/watch?v=ZaPbP9DwBOE)
