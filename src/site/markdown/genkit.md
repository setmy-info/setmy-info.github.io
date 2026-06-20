# Genkit

## Information

Firebase Genkit is an open-source framework by Google for building AI-powered features and flows in Node.js/TypeScript
applications. It provides a unified API for model access, structured input/output schemas, streaming, observability, and
a local developer UI. Genkit integrates with Angular through Angular SSR (server-side rendering), exposing AI flows as
Express HTTP endpoints consumed by Angular components.

### Main Functionalities and Features

* **Flow definitions**: Typed AI pipelines with input/output schemas validated by Zod.
* **Streaming**: Chunk-by-chunk output via `generateStream` and `streamFlow` client API.
* **Multi-model support**: Google AI (Gemini), Vertex AI, and other providers through plugins.
* **Express integration**: `@genkit-ai/express` exposes flows as HTTP handlers.
* **Developer UI**: Local inspector for running and debugging flows interactively.
* **Angular SSR compatibility**: Flows run inside the Angular SSR Node.js server process.

## Installation

### Prerequisites

LTS Node.js is required. Angular CLI must be installed.

```shell
npm upgrade -g npm
npm install -g @angular/cli
npm install -g genkit-cli
```

### Install project dependencies

```shell
npm install genkit
npm install @genkit-ai/google-genai
npm install @genkit-ai/express
npm install --save-dev tsx
```

For Vertex AI instead of Google AI:

```shell
npm install @genkit-ai/vertexai
```

## Project Setup

### Create new Angular project with SSR

```shell
ng new my-app --ssr --server-routing
```

### Add SSR to an existing Angular project

```shell
ng add @angular/ssr --server-routing
```

### Directory layout

Place flow definitions under `src/genkit/`:

```
src/
  genkit/
    menuSuggestionFlow.ts
  server.ts          ← Angular SSR server (add Express routes here)
  app/
    app.component.ts
```

## Code Integration Examples

### Flow Definition

`src/genkit/menuSuggestionFlow.ts`

```typescript
import { genkit, z } from 'genkit';
import { googleAI } from '@genkit-ai/google-genai';

const ai = genkit({ plugins: [googleAI()] });

export const menuSuggestionFlow = ai.defineFlow(
    {
        name: 'menuSuggestionFlow',
        inputSchema: z.object({ theme: z.string() }),
        outputSchema: z.object({ menuItem: z.string() }),
        streamSchema: z.string(),
    },
    async ({ theme }, { sendChunk }) => {
        const { stream, response } = ai.generateStream({
            model: googleAI.model('gemini-flash-latest'),
            prompt: `Invent a menu item for a ${theme} themed restaurant.`,
        });

        for await (const chunk of stream) {
            sendChunk(chunk.text);
        }

        const { text } = await response;
        return { menuItem: text };
    },
);
```

### Server Route Registration

Add to `src/server.ts` (Angular SSR entry point):

```typescript
import express from 'express';
import { expressHandler } from '@genkit-ai/express';
import { menuSuggestionFlow } from './genkit/menuSuggestionFlow';

// existing Angular SSR app setup ...
app.use(express.json());
app.post('/api/menuSuggestion', expressHandler(menuSuggestionFlow));
```

### Angular Component — Non-Streaming

```typescript
import { Component, signal, resource } from '@angular/core';
import { runFlow } from 'genkit/beta/client';

@Component({
    selector: 'app-menu',
    template: `
        <input [(ngModel)]="theme" placeholder="Restaurant theme"/>
        <p>{{ menuResource.value()?.menuItem }}</p>
    `,
})
export class MenuComponent {
    theme = signal('');

    menuResource = resource({
        request: () => this.theme(),
        loader: ({ request }) =>
            runFlow({
                url: 'http://localhost:4200/api/menuSuggestion',
                input: { theme: request },
            }),
    });
}
```

### Angular Component — Streaming

```typescript
import { Component, signal } from '@angular/core';
import { streamFlow } from 'genkit/beta/client';

@Component({
    selector: 'app-menu-stream',
    template: `
        <button (click)="streamMenuItem()">Generate</button>
        <p>{{ streamedText() }}</p>
    `,
})
export class MenuStreamComponent {
    streamedText = signal('');

    async streamMenuItem() {
        const theme = 'Italian';
        const result = streamFlow({
            url: 'http://localhost:4200/api/menuSuggestion',
            input: { theme },
        });

        for await (const chunk of result.stream) {
            this.streamedText.update((prev) => prev + chunk);
        }

        await result.output;
    }
}
```

### Authenticated Requests

```typescript
runFlow({
    url: 'http://localhost:4200/api/menuSuggestion',
    headers: {
        Authorization: 'Bearer your-token-here',
    },
    input: { theme: 'Japanese' },
});
```

## Usage, tips and tricks

### Local development with Google AI

```shell
export GEMINI_API_KEY=<your-api-key>
ng serve
```

### Local development with Vertex AI

```shell
export GCLOUD_PROJECT=<your-gcp-project-id>
export GCLOUD_LOCATION=us-central1
gcloud auth application-default login
ng serve
```

### Start Genkit developer UI

The developer UI lets you run and inspect flows interactively without the Angular frontend.

```shell
genkit start -- npx tsx --watch src/genkit/menuSuggestionFlow.ts
```

### Architecture pattern summary

```
Angular Component
      ↓ HTTP POST /api/<flow>
Angular SSR server.ts (Express)
      ↓ expressHandler(flow)
Genkit Flow (src/genkit/)
      ↓ ai.generateStream / ai.generate
Google AI / Vertex AI model
```

* Keep flow files under `src/genkit/` and import them only from `server.ts`.
* Components call flows through HTTP — they never import flow files directly.
* Use `streamFlow` for long-running generation and `runFlow` for short responses.
* Disable developer service exposure (window object) in production builds (see ADR-0030).

## Control questions

    What is the difference between runFlow and streamFlow?
    Where should flow definitions be placed in an Angular SSR project?
    Why do Angular components call flows through HTTP and not by direct import?

## See also

[Genkit Angular integration](https://genkit.dev/docs/js/frameworks/angular/)

[Genkit documentation](https://genkit.dev/docs/)

[Angular SSR](https://angular.dev/guide/ssr)

[Angular](angular.md)
