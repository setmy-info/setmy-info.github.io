# FastAPI

## Information

### Introduction

FastAPI is a modern, fast (high-performance), web framework for building APIs with Python 3.8+ based on standard Python
type hints. It is one of the fastest Python frameworks available, only slower than Starlette and Uvicorn themselves.

### Key Features

* **Fast:** Very high performance, on par with Node.js and Go (thanks to Starlette and Pydantic).
* **Fast to code:** Increase the speed to develop features by about 200% to 300%.
* **Fewer bugs:** Reduce about 40% of human (developer) induced errors.
* **Intuitive:** Great editor support. Completion everywhere. Less time debugging.
* **Easy:** Designed to be easy to use and learn. Less time reading docs.
* **Short:** Minimize code duplication. Multiple features from each parameter declaration. Fewer bugs.
* **Robust:** Get production-ready code. With automatic interactive documentation.
* **Standards-based:** Based on (and fully compatible with) the open standards for APIs: OpenAPI (previously known as
  Swagger) and JSON Schema.

### Similar Frameworks

* **[FastMCP](fastmcp.md):** A high-level framework for building [Model Context Protocol (MCP)](mcp.md) servers,
  directly inspired by FastAPI's design and decorator-based API.

## Installation

### Prerequisites

FastAPI requires Python 3.8+.

### Development Environment Setup (venv)

Following the standard usage in this project, it is recommended to use a virtual environment (`venv`) to isolate your
project dependencies.

**Windows:**

```commandline
REM Create a virtual environment
py -m venv .venv

REM Activate the virtual environment
.venv\Scripts\activate
```

**Unix/Linux/macOS:**

```bash
# Create a virtual environment
python3 -m venv .venv

# Activate the virtual environment
source .venv/bin/activate
```

### Installing FastAPI and Uvicorn

Once the virtual environment is activated, install FastAPI and `uvicorn` (which serves as the ASGI server).

```bash
pip install fastapi
pip install "uvicorn[standard]"
```

## Usage, tips and tricks

### Basic REST API Example

Create a file named `main.py`:

```python
from typing import Union
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}
```

### Running the API

Run the server with:

```bash
uvicorn main:app --reload
```

* `main`: the file `main.py` (the Python "module").
* `app`: the object created inside of `main.py` with the line `app = FastAPI()`.
* `--reload`: make the server restart after code changes. Only use for development.

### Integrating MCP support

If you are developing a microservice with FastAPI, you can easily add [Model Context Protocol (MCP)](mcp.md) support using [FastMCP](fastmcp.md). This allows AI models to interact with your service logic.

See the [FastMCP guide: Adding MCP to an Existing FastAPI Microservice](fastmcp.md#adding-mcp-to-an-existing-fastapi-microservice) for a complete example and configuration.

### Interactive API Documentation

Once the server is running, you can access the automatic interactive API documentation:

* **Swagger UI:** [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)
* **ReDoc:** [http://127.0.0.1:8000/redoc](http://127.0.0.1:8000/redoc)

## See also

* [FastAPI Official Website](https://fastapi.tiangolo.com/)
* [FastAPI GitHub Repository](https://github.com/tiangolo/fastapi)
* [Python](python.md)
* [AI](ai.md)
* [FastMCP](fastmcp.md)
* [Model Context Protocol (MCP)](mcp.md) (FastMCP is inspired by FastAPI)
