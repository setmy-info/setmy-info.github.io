# FastMCP

## Information

### Introduction

[FastMCP](https://github.com/jiggy-ai/fastmcp) is a high-level Python framework for building
[Model Context Protocol (MCP)](mcp.md) servers quickly and easily. Inspired by [FastAPI](fastapi.md),
it provides a clean, decorator-based API that simplifies the process of creating MCP tools, resources, and prompts.

### What is it for?

FastMCP is designed to:

* **Simplify MCP Development:** Use Python decorators to define tools and resources, much like defining routes in
  FastAPI.
* **Rapid Prototyping:** Build and test MCP servers in minutes with minimal boilerplate.
* **Auto-Documentation:** Automatically generate the necessary JSON schemas for tools, making it easy for AI models to
  understand how to use them.
* **Type Safety:** Leverage Python's type hints to define the inputs and outputs of your tools, which FastMCP uses to
  generate correct schemas.
* **Rich Features:** Supports tools, resources, and dynamic prompts out of the box.

## Installation

### Prerequisites

* Python 3.10 or higher.
* A virtual environment (`venv`) is recommended.

### Setup Project

```bash
# Create and activate virtual environment
python -m venv .venv
source .venv/bin/activate  # On Windows use: .venv\Scripts\activate

# Install FastMCP
pip install fastmcp
```

## Usage

### Basic Server Example

Create a file named `server.py`:

```python
from fastmcp import FastMCP

# Create a server instance
mcp = FastMCP("My Awesome Server")


# Define a tool with a decorator
@mcp.tool()
def calculate_area(width: float, height: float) -> float:
    """Calculate the area of a rectangle."""
    return width * height


# Define a resource
@mcp.resource("config://settings")
def get_settings() -> str:
    """Return application settings."""
    return "theme=dark\nlanguage=python"


if __name__ == "__main__":
    mcp.run()
```

### Advanced Usage with FastAPI

FastMCP can be integrated into a [FastAPI](fastapi.md) application, allowing you to serve both a web API and an MCP
interface from the same codebase, or to use FastAPI's dependency injection and background tasks.

While FastMCP primarily runs over `stdio` for local use (Claude Desktop, Junie), it also supports `SSE` (Server-Sent
Events) which is perfect for web-based MCP clients.

```python
from fastapi import FastAPI
from fastmcp import FastMCP

app = FastAPI()
mcp = FastMCP("Hybrid Server")


# FastAPI endpoint
@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI"}


# MCP Tool
@mcp.tool()
def greet(name: str) -> str:
    return f"Hello, {name}!"

# To run as SSE with FastAPI, you would typically use an MCP SSE transport 
# (Requires additional configuration, see FastMCP docs for the latest SSE patterns)
```

### Adding MCP to an Existing FastAPI Microservice

If you have an existing [FastAPI](fastapi.md) service (e.g., a microservice for software management), you can easily add 
MCP support to it. This allows AI agents to interact with your service's logic directly.

#### 1. Integration Strategy

There are two main ways to integrate MCP into your existing service:

*   **Co-located:** Run both the FastAPI web server and the MCP interface in the same process (using SSE for MCP).
*   **Sidecar / Wrapper:** Create a small `mcp_server.py` that imports your existing service logic and exposes it via `stdio`.

#### 2. Example: Software Management Microservice

Suppose you have an existing service that manages software versions:

**`service.py` (Existing Code):**

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Software(BaseModel):
    name: str
    version: str

# Existing business logic
def get_software_info(name: str):
    # Mock database call
    database = {"fastapi": "0.100.0", "fastmcp": "0.4.1"}
    version = database.get(name.lower(), "unknown")
    return {"name": name, "version": version}

@app.get("/software/{name}")
async def read_software(name: str):
    return get_software_info(name)
```

**`mcp_server.py` (Adding MCP Support):**

```python
from fastmcp import FastMCP
from service import get_software_info

# Create an MCP server instance
mcp = FastMCP("Software Manager MCP")

# Expose existing logic as an MCP Tool
@mcp.tool()
def get_version(software_name: str) -> str:
    """Check the current version of a software component."""
    info = get_software_info(software_name)
    return f"The version of {info['name']} is {info['version']}."

if __name__ == "__main__":
    mcp.run()
```

#### 3. Serving via SSE (Server-Sent Events)

If you want your MCP server to be accessible over the network (like your FastAPI app), you can use SSE.

```python
from fastapi import FastAPI
from fastmcp import FastMCP

app = FastAPI()
mcp = FastMCP("Networked MCP")

@mcp.tool()
def some_tool(x: int) -> int:
    return x * 2

# Mount MCP SSE endpoints onto your FastAPI app
mcp.set_sse_hooks(app)

# Now your MCP server is available at:
# SSE endpoint: /sse
# Message endpoint: /messages
```

## How to use it in AI Hosts

### Claude Desktop

To use your FastMCP server in Claude Desktop, add it to your `claude_desktop_config.json`:

**Windows:** `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
    "mcpServers": {
        "my-fastmcp-server": {
            "command": "python",
            "args": [
                "C:/path/to/your/project/server.py"
            ]
        }
    }
}
```

### Junie (JetBrains AI Assistant)

1. Open **Settings** > **AI Assistant** > **Model Context Protocol (MCP)**.
2. Click **+** to add a new server.
3. **Name:** My FastMCP Server
4. **Command:** `python` (or the path to your `.venv/Scripts/python.exe`)
5. **Arguments:** `C:\path\to\your\project\server.py`
6. Click **Apply**.

### Claude CLI

If you are using the Claude CLI, you can often run the server directly via `stdio`:

```bash
claude-cli --mcp-server "python server.py"
```

## See also

* [FastMCP GitHub Repository](https://github.com/jiggy-ai/fastmcp)
* [Model Context Protocol (MCP)](mcp.md)
* [FastAPI](fastapi.md)
* [Python](python.md)
* [AI Tools](aitools.md)
