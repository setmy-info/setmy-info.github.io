# React

## Information

React is a JavaScript library for building user interfaces, developed and maintained by Meta (Facebook). It uses a
declarative, component-based model where the UI is described as a function of state, and React efficiently updates the
DOM when state changes via a virtual DOM diffing algorithm.

React requires **Node.js** for its development tooling (CLI scaffolding, dev server, bundler). Use a **Node.js LTS**
version for all React development and CI pipelines. See [node.md](node.md) for the LTS versioning policy.

Key React concepts:

* **Components**: reusable UI building blocks as JavaScript functions or classes.
* **JSX**: syntax extension that lets you write HTML-like markup inside JavaScript.
* **Props**: immutable data passed from parent to child component.
* **State**: mutable local data managed within a component via hooks.
* **Hooks**: functions (useState, useEffect, useContext, …) that add state and lifecycle to function components.

## Installation

### Create a New React App

Using Vite (recommended for new projects — fast, minimal config):

```shell
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

Using Create React App (older, still widely used):

```shell
npx create-react-app my-app
cd my-app
npm start
```

### Add React to an Existing Project

```shell
npm install react react-dom
```

## Preparations

### Project Structure (Vite)

```
my-app/
├── public/
│   └── vite.svg
├── src/
│   ├── App.jsx          # Root component
│   ├── App.css
│   ├── main.jsx         # Entry point — mounts App into index.html
│   └── index.css
├── index.html
├── package.json
└── vite.config.js
```

### Common Packages and Their Purpose

| Package                    | Purpose                                                        |
|----------------------------|----------------------------------------------------------------|
| `react-router-dom`         | Client-side routing for SPAs                                   |
| `@reduxjs/toolkit`         | Redux state management — simplified setup and best practices   |
| `react-redux`              | React bindings for Redux                                       |
| `zustand`                  | Lightweight alternative to Redux for local/global state        |
| `axios`                    | HTTP client for API calls                                      |
| `@tanstack/react-query`    | Server state management — fetching, caching, synchronisation   |
| `@testing-library/react`   | Utilities for testing React components from the user's perspective |
| `jest` / `vitest`          | Test runner — Jest for CRA, Vitest for Vite projects           |

## Configuration

### vite.config.js

```javascript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
    plugins: [react()],
    server: {
        port: 3000,
    },
});
```

### Environment Variables

Vite exposes env vars prefixed with `VITE_`:

```
# .env
VITE_API_URL=http://localhost:8080
```

Access in code:

```javascript
const apiUrl = import.meta.env.VITE_API_URL;
```

## Usage, tips and tricks

### Generate Project

```shell
npx create-react-app react-app
```

### JSX Basics

```jsx
function Greeting({ name }) {
    return <h1>Hello, {name}!</h1>;
}
```

### Hooks

```jsx
import { useState, useEffect } from 'react';

function Counter() {
    const [count, setCount] = useState(0);

    useEffect(() => {
        document.title = `Count: ${count}`;
    }, [count]);

    return (
        <button onClick={() => setCount(c => c + 1)}>
            Clicked {count} times
        </button>
    );
}
```

### React Router

```shell
npm install react-router-dom
```

```jsx
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';

function App() {
    return (
        <BrowserRouter>
            <nav>
                <Link to="/">Home</Link>
                <Link to="/about">About</Link>
            </nav>
            <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/about" element={<About />} />
            </Routes>
        </BrowserRouter>
    );
}
```

### Run Scripts

```shell
# Start development server
npm run dev         # Vite
npm start           # CRA
# Build for production
npm run build
# Run tests
npm test
```

## See also

* [React official documentation](https://react.dev/)
* [Vite](https://vitejs.dev/)
* [React Router](https://reactrouter.com/)
* [Redux Toolkit](https://redux-toolkit.js.org/)
* [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
* [Node.js](node.md)
* [npm](npm.md)
* [JavaScript](javascript.md)
