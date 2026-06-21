# python-start-project

## Information

This page describes how to scaffold and prepare a new Python project from scratch, including virtual environment
setup, project structure, dependency management, and the standard test workflow.

See [python.md](python.md) for Python installation instructions and version management.

## Preparations

### Create Project Directory and Virtual Environment

```shell
mkdir my-project
cd my-project
git init
python3 -m venv .venv
source .venv/bin/activate   # Linux/macOS
# .venv\Scripts\activate    # Windows
```

Always activate the virtual environment before working on the project.

### Minimal Project Structure (src layout)

The `src/` layout avoids import-path confusion between installed and local packages:

```
my-project/
├── src/
│   └── my_project/
│       ├── __init__.py
│       └── main.py
├── tests/
│   ├── __init__.py
│   └── test_main.py
├── .gitignore
├── .env                   # Environment variables (never commit)
├── .env.example           # Template for .env (always commit)
├── pyproject.toml         # Project metadata and dependencies
├── requirements.txt       # Pinned production dependencies (optional)
├── requirements-dev.txt   # Pinned dev dependencies (optional)
└── Makefile
```

### pyproject.toml (modern, recommended)

```toml
[build-system]
requires = ["setuptools>=68", "wheel"]
build-backend = "setuptools.backends.legacy:build"

[project]
name = "my-project"
version = "0.1.0"
description = "Short project description"
readme = "README.md"
requires-python = ">=3.11"
dependencies = [
    "requests>=2.31",
    "pydantic>=2.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=8.0",
    "pytest-cov",
    "ruff",
    "mypy",
]

[tool.pytest.ini_options]
testpaths = ["tests"]

[tool.ruff]
line-length = 100
```

### Install the Project in Editable Mode

```shell
pip install -e ".[dev]"
```

This installs the project and its dev dependencies. The `-e` flag makes the source editable in place.

### .gitignore Template

```
.venv/
__pycache__/
*.pyc
*.pyo
dist/
build/
*.egg-info/
.env
.coverage
htmlcov/
.mypy_cache/
.ruff_cache/
```

### Makefile

```makefile
.PHONY: install test lint format typecheck clean

install:
	pip install -e ".[dev]"

test:
	pytest

lint:
	ruff check src tests

format:
	ruff format src tests

typecheck:
	mypy src

clean:
	rm -rf dist build *.egg-info .coverage htmlcov
```

## Installation

Ensure Python 3.11+ is installed. See [python.md](python.md).

```shell
python3 --version
pip --version
```

## Configuration

### requirements.txt (alternative/legacy approach)

Freeze the current environment state:

```shell
pip freeze > requirements.txt
```

Install from frozen file:

```shell
pip install -r requirements.txt
```

Use separate files for production and development:

```
requirements.txt        # production deps only
requirements-dev.txt    # -r requirements.txt + dev tools
```

### Environment Variables with python-dotenv

```shell
pip install python-dotenv
```

`.env`:

```
DATABASE_URL=postgresql://localhost/mydb
SECRET_KEY=change-me
```

In code:

```python
from dotenv import load_dotenv
import os

load_dotenv()
db_url = os.getenv("DATABASE_URL")
```

## Usage, tips and tricks

### Running the Project

```shell
# Activate environment first
source .venv/bin/activate
# Run module
python -m my_project.main
# Or entry point defined in pyproject.toml
my-project
```

### Running Tests

```shell
# Basic
pytest
# With coverage
pytest --cov=src --cov-report=html
# Verbose
pytest -v
```

### Minimal Test

```python
# tests/test_main.py
def test_addition():
    assert 1 + 1 == 2
```

### Linting and Formatting with Ruff

```shell
# Check lint issues
ruff check src tests
# Auto-fix
ruff check --fix src tests
# Format
ruff format src tests
```

### Type Checking with mypy

```shell
mypy src
```

Add to `pyproject.toml`:

```toml
[tool.mypy]
strict = true
```

## See also

* [Python](python.md)
* [venv](venv.md)
* [conda](conda.md)
* [FastAPI](fastapi.md)
* [PyPI](pypi.md)
* [Python Packaging User Guide](https://packaging.python.org/)
* [pytest documentation](https://docs.pytest.org/)
* [Ruff linter](https://docs.astral.sh/ruff/)
