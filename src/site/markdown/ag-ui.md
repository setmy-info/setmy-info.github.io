# AG-UI

## Information

`AG-UI` (Agent–User Interaction Protocol) is an open, lightweight, and event-based protocol that standardizes how AI
agents connect to user-facing applications. It is designed to be the general-purpose, bi-directional connection between
a user-facing application and any agentic backend.

The project documentation is hosted at [https://docs.ag-ui.com/](https://docs.ag-ui.com/).

### Main Functionalities and Features

* **Open and Lightweight**: A standardized, event-based protocol for agentic interaction.
* **Bi-directional Communication**: Handles agent state, UI intents, and user interactions.
* **Multimodal Support**: Supports text, images, audio, and file attachments.
* **Streaming Support**: Real-time token and event streaming for responsive sessions.
* **Generative UI**: Render model output as stable, typed components under application control.
* **Shared State**: Typed store shared between agent and application with conflict resolution.
* **Interoperability**: Works alongside other protocols like MCP (Model Context Protocol) and A2A (Agent to Agent).

## Installation

### Using npm

Install the core library and client package:

```shell
npm install @ag-ui/core @ag-ui/client
```

### Using Python

```shell
pip install ag-ui-core ag-ui-client
```

### Using .NET

```shell
dotnet add package AGUI.Abstractions
dotnet add package AGUI.Client
```

## Usage, tips and tricks

### Basic Client Usage (TypeScript)

1. **Initialize the Agent**: Use `HttpAgent` to connect to a remote agent endpoint.

```typescript
import {HttpAgent} from "@ag-ui/client";

const agent = new HttpAgent({
    url: "https://api.example.com/v1/agent",
    headers: {
        Authorization: "Bearer your-api-key",
    },
});
```

2. **Run the Agent**: Execute the agent and handle the streaming results.

```typescript
const result = await agent.runAgent({
    messages: [{role: "user", content: "Hello, how can you help me today?"}]
});

console.log("Agent response:", result.result);
```

3. **Subscribe to Events**: Handle lifecycle and state events during execution.

```typescript
agent.subscribe({
    onMessage: (message) => {
        console.log("New message:", message);
    },
    onStateUpdate: (state) => {
        console.log("State updated:", state);
    }
});
```

### AG-UI and A2UI

While they have similar names, they serve different purposes:

* **AG-UI** is the **protocol** that connects the agentic frontend to the agentic backend.
* **A2UI** is a **specification** for generative UI, allowing agents to deliver UI widgets.

They are often used together to build sophisticated agentic applications.

## See also

* [AG-UI Official Documentation](https://docs.ag-ui.com/)
* [AG-UI GitHub Repository](https://github.com/ag-ui-protocol/ag-ui)
* [A2UI components](a2ui.md)
* [Angular](angular.md)
* [Lerna](lerna.md)
* [Node.js](node.md)
* [npm](npm.md)
