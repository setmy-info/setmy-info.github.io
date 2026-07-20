# CrewAI

## Information

`CrewAI` is a framework for orchestrating collaborative, role-based AI agents. It allows you to create teams of agents
that work together to complete complex tasks, mimicking a human organization.

### Main Functionalities and Features

* **Role-Based Agents**: Define agents with specific roles, goals, and backstories.
* **Autonomous Delegation**: Agents can decide to delegate tasks to other agents.
* **Process-Driven**: Supports sequential, hierarchical, and consensual processes.
* **Tool Integration**: Easily add custom tools or use existing ones from LangChain.
* **Output Validation**: Ensure the output of one agent meets the requirements for the next.
* **Memory**: Short-term, long-term, and entity memory for agents.

## Installation

### Python (Universal)

CrewAI requires Python 3.10 to 3.13. It is recommended to use a virtual environment.

```bash
pip install crewai crewai-tools
```

### macOS / Linux

Ensure you have Python installed. You may need to use `pip3`.

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install crewai crewai-tools
```

### Windows

Using PowerShell:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install crewai crewai-tools
```

## Setup for Developer

The fastest way to start a new `CrewAI` project is using the CLI.

1.  **Create a new project**:
    ```bash
    crewai create crew my_cool_crew
    ```
2.  **Install dependencies**:
    ```bash
    cd my_cool_crew
    crewai install
    ```
3.  **Configure environment**:
    Update the `.env` file with your LLM API keys:
    ```env
    OPENAI_API_KEY=sk-...
    ```

4.  **Run the crew**:
    ```bash
    crewai run
    ```

## Setup with Docker for Developer

Using Docker ensures a consistent environment for all team members.

**docker-compose.yaml:**

```yaml
version: '3.8'
services:
  crew:
    image: python:3.11-slim
    volumes:
      - .:/app
    working_dir: /app
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
    command: sh -c "pip install crewai crewai-tools && python main.py"
```

## Usage, tips and tricks

### Basic Code Example

```python
from crewai import Agent, Task, Crew, Process

# Define Agents
researcher = Agent(
  role='Senior Research Analyst',
  goal='Uncover cutting-edge developments in AI',
  backstory='You are an expert at identifying emerging trends.'
)

writer = Agent(
  role='Content Strategist',
  goal='Write engaging technical articles',
  backstory='You specialize in simplifying complex AI topics.'
)

# Define Tasks
research_task = Task(description='Analyze 2024 AI trends', agent=researcher)
write_task = Task(description='Write a blog post based on research', agent=writer)

# Form the Crew
my_crew = Crew(
  agents=[researcher, writer],
  tasks=[research_task, write_task],
  process=Process.sequential
)

result = my_crew.kickoff()
print(result)
```

### Tips
* **Backstories**: The more detailed the backstory, the better the agent performs.
* **Hierarchical Process**: Use a Manager agent for complex projects with many agents.
* **Local Models**: Use `Ollama` with `CrewAI` by setting the `base_url` or using the `LLM` class.

## Similar Software

* **[AgentKit](agentkit.md):** Blockchain interaction for AI agents.
* **[LangGraph](langgraph.md):** Graph-based orchestration for stateful agent workflows.
* **[AutoGen](https://github.com/microsoft/autogen):** Microsoft framework for multi-agent conversations.
* **[PydanticAI](pydanticai.md):** Python framework for building LLM applications with strong typed inputs and outputs.

## See also

* [CrewAI Official Website](https://www.crewai.com/)
* [CrewAI Documentation](https://docs.crewai.com/)
* [AI Agent](agent.md)
* [AI](ai.md)
* [LLM](llm.md)