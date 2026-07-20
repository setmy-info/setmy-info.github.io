# AgentKit

## Information

`AgentKit` (specifically Coinbase AgentKit) is a framework designed to enable AI agents to interact with the blockchain.
It provides tools for wallet management, on-chain transactions, and integration with Large Language Models (LLMs) to
create autonomous agents capable of performing financial operations.

### Main Functionalities and Features

* **Wallet Management**: Create and manage MPC (Multi-Party Computation) wallets.
* **On-chain Actions**: Perform transfers, swaps, and other blockchain interactions.
* **CDP Integration**: Native integration with Coinbase Developer Platform (CDP).
* **Multi-language Support**: Available for Python and Node.js.
* **Tool Calling**: Easily integrated into Agent frameworks like LangChain or CrewAI.

## Installation

### Python (Universal)

Recommended for most AI/Data use cases. Requires Python 3.10+.

```bash
pip install cdp-agentkit-python
```

### Node.js

Recommended for web-centric or enterprise integrations.

```bash
npm install @coinbase/cdp-agentkit-nodejs
```

### macOS / Linux

Ensure you have Python and `venv` installed.

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install cdp-agentkit-python
```

### Windows

Using PowerShell:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install cdp-agentkit-python
```

## Setup for Developer

To start development fast, you need a Coinbase Developer Platform (CDP) API key.

1.  **Get CDP API Key**: Register at [Coinbase Cloud](https://cloud.coinbase.com/) and create an API key.
2.  **Set Environment Variables**:
    ```bash
    export CDP_API_KEY_NAME="your_key_name"
    export CDP_API_KEY_PRIVATE_KEY="your_private_key"
    export OPENAI_API_KEY="your_openai_key"
    ```

### Quick Start Example (Python)

```python
from cdp_agentkit_python.utils import CdpAgentkitWrapper

# Initialize the agentkit wrapper
agentkit = CdpAgentkitWrapper()

# Example action: Get wallet details
print(f"Wallet address: {agentkit.wallet_address}")
```

## Setup with Docker for Developer

Using Docker ensures a consistent environment across different machines.

**Dockerfile:**

```dockerfile
FROM python:3.11-slim

WORKDIR /app

RUN pip install cdp-agentkit-python

COPY . .

CMD ["python", "my_agent.py"]
```

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
  agent:
    build: .
    environment:
      - CDP_API_KEY_NAME=${CDP_API_KEY_NAME}
      - CDP_API_KEY_PRIVATE_KEY=${CDP_API_KEY_PRIVATE_KEY}
      - OPENAI_API_KEY=${OPENAI_API_KEY}
```

## Usage, tips and tricks

* **Faucets**: Use Base Sepolia testnet faucets to get test ETH for your agent.
* **Persisting Wallets**: Save the wallet data to a file or database to reuse the same agent address.
* **Security**: Never hardcode your private keys. Use environment variables or a secret manager.

## Similar Software

* **[CrewAI](crewai.md):** Orchestration for multi-agent teams.
* **[LangChain](langchain.md):** General purpose framework for LLM apps.
* **[Agent.xyz](https://agent.xyz/):** Platform for hosting AI agents.

## See also

* [Coinbase AgentKit GitHub](https://github.com/coinbase/cdp-agentkit-python)
* [Coinbase Developer Platform](https://cloud.coinbase.com/)
* [AI Agent](agent.md)
* [AI](ai.md)
* [LLM](llm.md)
