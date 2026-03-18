# Model Context Protocol (MCP)

## Information

### Introduction

The Model Context Protocol (MCP) is an open standard that enables developers to build secure, two-way connections
between their data sources and AI models. It provides a universal way for AI models (like Claude, ChatGPT, or Gemini) to
access local and remote data, tools, and prompts without needing custom integrations for every single data source.

### What is it for?

MCP solves the problem of "context fragmentation" by allowing AI assistants to:

* **Access Local Data:** Read files, query databases, and interact with local development environments.
* **Use Remote Tools:** Connect to APIs (like GitHub, Slack, or Google Drive) through standardized server
  implementations.
* **Maintain Security:** Keep data under your control while providing the model only with the context it needs.
* **Standardize Integrations:** Replace multiple one-off integrations with a single, interoperable protocol.

### Key Components

* **MCP Hosts:** AI applications (like Claude Desktop, IDEs, or custom agents) that want to access data.
* **MCP Servers:** Lightweight programs that expose data and tools via the protocol.
* **MCP Clients:** Protocol implementations inside hosts that communicate with servers.

### Development Tools & SDKs

To build your own MCP servers or clients, you can use the following SDKs and libraries:

#### Python

* **[MCP Python SDK](https://github.com/modelcontextprotocol/python-sdk):** The official Python implementation of the
  Model Context Protocol.
* **[FastMCP](https://github.com/jiggy-ai/fastmcp):** A high-level framework for building MCP servers quickly with
  Python, inspired by FastAPI.
* **[MCP-Server-Template](https://github.com/modelcontextprotocol/python-sdk/tree/main/examples):** Official examples
  and templates for Python-based servers.

#### Java / Kotlin

* **[MCP Java SDK](https://github.com/modelcontextprotocol/java-sdk):** The official Java implementation of the Model
  Context Protocol.
* **[Spring AI MCP](https://github.com/spring-projects/spring-ai):** Integration of MCP within the Spring AI ecosystem
  for building AI-powered Java applications.
* **[MCP Client CLI (Java)](https://github.com/modelcontextprotocol/java-sdk/tree/main/mcp-client):** Tools for testing
  and interacting with MCP servers using Java.

#### Node.js / TypeScript

* **[MCP TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk):** The official TypeScript/Node.js
  implementation.

## Building an MCP Server

Building an MCP server involves defining **tools**, **resources**, and **prompts** that an AI host can use.

### Python (FastMCP)

[FastMCP](https://github.com/jiggy-ai/fastmcp) is a high-level framework that makes it easy to build MCP servers with
Python.

**1. Installation:**

```bash
pip install fastmcp
```

**2. Create a server (`server.py`):**

```python
from fastmcp import FastMCP

# Create an MCP server
mcp = FastMCP("My Server")


# Add a tool
@mcp.tool()
def add(a: int, b: int) -> int:
    """Add two numbers"""
    return a + b


# Add a resource
@mcp.resource("echo://{message}")
def echo_resource(message: str) -> str:
    """Echo a message as a resource"""
    return f"Resource content: {message}"


if __name__ == "__main__":
    mcp.run()
```

**3. Running:**

```bash
python server.py
```

### TypeScript (Official SDK)

**1. Installation:**

```bash
npm install @modelcontextprotocol/sdk
```

**2. Create a server (`index.ts`):**

```typescript
import {Server} from "@modelcontextprotocol/sdk/server/index.js";
import {StdioServerTransport} from "@modelcontextprotocol/sdk/server/stdio.js";
import {
    CallToolRequestSchema,
    ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";

const server = new Server(
    {
        name: "my-server",
        version: "1.0.0",
    },
    {
        capabilities: {
            tools: {},
        },
    }
);

server.setRequestHandler(ListToolsRequestSchema, async () => {
    return {
        tools: [
            {
                name: "calculate_sum",
                description: "Add two numbers together",
                inputSchema: {
                    type: "object",
                    properties: {
                        a: {type: "number"},
                        b: {type: "number"},
                    },
                    required: ["a", "b"],
                },
            },
        ],
    };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
    if (request.params.name === "calculate_sum") {
        const {a, b} = request.params.arguments as { a: number; b: number };
        return {
            content: [{type: "text", text: String(a + b)}],
        };
    }
    throw new Error("Tool not found");
});

const transport = new StdioServerTransport();
await server.connect(transport);
```

## Installation

### General

To use MCP, you typically need an **MCP Host** (the AI assistant) and one or more **MCP Servers**.

### Local Server Setup (Node.js/Python)

Most MCP servers are written in Node.js or Python. You can install them globally or run them directly using tools like
`npx` (Node.js) or `uvx` (Python).

```bash
# Example: Installing an MCP server via npm
npm install -g @modelcontextprotocol/server-github

# Example: Running an MCP server with uv (Python)
uvx mcp-server-sqlite --db-path ./my-database.db
```

## Configuration

To start using MCP servers, you need to configure your AI host to recognize and connect to them.

### Claude Desktop Configuration

Claude Desktop is one of the primary hosts for MCP.

1. **Locate Configuration File:**
    * **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
    * **macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
2. **Edit Configuration:** Add your MCP servers to the `mcpServers` object.

**Example configuration:**

```json
{
    "mcpServers": {
        "sqlite": {
            "command": "uvx",
            "args": [
                "mcp-server-sqlite",
                "--db-path",
                "C:/path/to/your/db.sqlite"
            ]
        },
        "github": {
            "command": "npx",
            "args": [
                "-y",
                "@modelcontextprotocol/server-github"
            ],
            "env": {
                "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
            }
        }
    }
}
```

3. **Restart Claude:** Close and reopen the Claude Desktop application for changes to take effect.

### Junie (JetBrains AI Assistant) Configuration

Junie (the JetBrains AI Assistant) can also act as an MCP host, allowing it to interact with your local tools and data
directly within your IDE.

1. **Open Settings:** Go to `Settings` (Windows/Linux) or `Settings` (macOS) in your JetBrains IDE (IntelliJ IDEA,
   WebStorm, PyCharm, etc.).
2. **Navigate to AI Assistant:** Select `AI Assistant` in the sidebar.
3. **MCP Settings:** Look for the **Model Context Protocol (MCP)** or **Tools** section.
4. **Add Server:**
    * Click the **+** (Add) button.
    * Choose a **Name** for your server (e.g., "Postgres").
    * Specify the **Command** (e.g., `npx` or `uvx`).
    * Add **Arguments** as separate items (e.g., `-y`, `@modelcontextprotocol/server-postgres`).
    * Set **Environment Variables** if required by the server (e.g., database connection strings or API keys).
5. **Apply and Save:** Click `OK` or `Apply`.

## How to start using it

Once configured, the AI assistant will automatically detect the available tools from the MCP server.

### With Claude Desktop

* You will see a small "hammer" or "tool" icon in the input field when tools are available.
* The assistant will automatically call tools when it thinks they are needed to answer your query.
* **Example:** "List the files in my current directory" or "What are the tables in my SQLite database?".

### With Junie (JetBrains AI)

* Junie will have access to the configured MCP tools during chat sessions.
* You can explicitly ask Junie to use a tool, or it might suggest using one to complete a task.
* **Example:** "Analyze the project structure using the file-system server" or "Query the database to find the latest
  user records".

## Usage, tips and tricks

### Coding tips and tricks

* **Tool Discovery:** Hosts can dynamically discover what tools an MCP server provides.
* **Resource Templates:** Servers can provide URI-based templates for models to access specific data.
* **Sampling:** MCP allows servers to request completions from the model, enabling complex multi-step workflows.

### Community & Ecosystem

* **[MCP Servers GitHub Repo](https://github.com/modelcontextprotocol/servers):** A community-driven repository with
  dozens of open-source MCP servers (Postgres, Google Drive, Slack, etc.).
* **[MCP Registry](https://mcp-registry.org/):** An unofficial but useful directory for finding available MCP servers.

## See also

* [Model Context Protocol Official Website](https://modelcontextprotocol.io/)
* [MCP GitHub Organization](https://github.com/modelcontextprotocol)
* [Claude MCP Documentation](https://docs.anthropic.com/en/docs/build-with-claude/mcp)
* [AI](ai.md)
* [AI Agent](agent.md)
* [AI Tools](aitools.md)
* [VectorDB](vectordb.md)
* [LangChain](langchain.md)
* [OpenVPN](openvpn.md)
