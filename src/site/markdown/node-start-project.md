# node-start-project

## Information

This page describes how to scaffold and prepare a new Node.js project from scratch, covering project initialization,
directory structure, typical package choices and what they are for, and a minimal working setup.

Before creating a project, install Node.js (preferably the latest Active LTS version). See [node.md](node.md) for
installation details, including LTS vs non-LTS version selection.

## Preparations

### Initialize a New Project

```shell
mkdir my-project
cd my-project
git init
# Pin the Node.js version for the project
node -v | sed 's/v//' > .nvmrc
npm init -y
```

The `npm init -y` command creates a `package.json` with default values. Edit it to fill in the actual project name,
version, description, and author fields.

### Minimal package.json

```json
{
    "name": "my-project",
    "version": "0.1.0",
    "description": "Short project description",
    "main": "src/index.js",
    "type": "module",
    "scripts": {
        "start": "node src/index.js",
        "dev": "nodemon src/index.js",
        "test": "mocha",
        "lint": "eslint ."
    },
    "author": "Your Name",
    "license": "ISC"
}
```

### Project Directory Structure

```
my-project/
├── src/
│   └── index.js           # Application entry point
├── test/
│   └── index.test.js      # Tests
├── .env                   # Environment variables (never commit to git)
├── .env.example           # Template for .env (always commit this)
├── .eslintrc.json         # ESLint configuration
├── .gitignore             # Git ignore patterns
├── .nvmrc                 # Pinned Node.js version
├── package.json           # Project metadata and dependencies
└── package-lock.json      # Locked dependency tree (always commit)
```

### .gitignore Template

```
node_modules/
.env
dist/
coverage/
*.log
```

## Installation

### Common Packages and Their Purpose

These packages are commonly added when starting a new Node.js project. Understand what each one does before adding it.

**Development tools:**

| Package    | Purpose                                                                    |
|------------|----------------------------------------------------------------------------|
| `nodemon`  | Watches for file changes and auto-restarts the Node.js process in dev mode |
| `eslint`   | JavaScript/TypeScript linter — enforces code style and catches common bugs |
| `prettier` | Code formatter — keeps consistent code style across the team               |
| `dotenv`   | Loads environment variables from `.env` into `process.env` at startup      |

**Testing:**

| Package        | Purpose                                                              |
|----------------|----------------------------------------------------------------------|
| `mocha`        | Test framework — discovers and runs test suites                      |
| `chai`         | Assertion library — expressive `expect`/`assert`/`should` interface  |
| `sinon`        | Test spies, stubs, and mocks for isolating units under test          |
| `c8` / `nyc`   | Code coverage — measures which lines are exercised by tests          |

**HTTP / API:**

| Package    | Purpose                                                                  |
|------------|--------------------------------------------------------------------------|
| `express`  | Minimal, flexible web framework for building REST APIs and web apps      |
| `fastify`  | Fast, low-overhead web framework — good alternative to Express           |
| `axios`    | Promise-based HTTP client for calling external REST APIs                 |

**Utilities:**

| Package              | Purpose                                                          |
|----------------------|------------------------------------------------------------------|
| `lodash`             | Utilities for common operations on arrays, objects, and strings  |
| `uuid`               | Generates RFC-compliant UUIDs (v4 random, v5 namespace-based)   |
| `dayjs` / `date-fns` | Immutable date manipulation — lightweight alternatives to Moment |
| `winston` / `pino`   | Structured logging with configurable transports and log levels   |

### Install Dev Dependencies

```shell
npm install --save-dev nodemon eslint prettier
npm install --save-dev mocha chai sinon c8
```

### Install Production Dependencies

```shell
npm install express dotenv
```

### ESLint Initialization

```shell
npx eslint --init
```

This runs an interactive wizard that creates `.eslintrc.json` (or `.eslintrc.cjs`) configured for your module type,
environment, and style preferences.

## Usage, tips and tricks

### Running the Project

```shell
# Start in production mode
npm start
# Start in development mode with auto-restart on file changes
npm run dev
# Run tests
npm test
# Run tests with coverage report
npx c8 npm test
```

### Environment Variables with dotenv

Create a `.env` file (not committed to git):

```
PORT=3000
DATABASE_URL=postgres://localhost/mydb
```

Create `.env.example` (committed to git) with placeholder values:

```
PORT=3000
DATABASE_URL=postgres://localhost/mydb_placeholder
```

Load in code at the top of your entry point:

```javascript
import dotenv from 'dotenv';
dotenv.config();

const port = process.env.PORT || 3000;
```

### Minimal Entry Point

```javascript
// src/index.js
import express from 'express';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
    res.json({ message: 'Hello, World!' });
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
```

### Minimal Test

```javascript
// test/index.test.js
import { strict as assert } from 'assert';

describe('example', () => {
    it('should pass a basic assertion', () => {
        assert.equal(1 + 1, 2);
    });
});
```

Run with:

```shell
npm test
```

### package-lock.json

Always commit `package-lock.json` to version control. It records the exact dependency tree so that `npm ci` on CI
servers installs identical versions to what was tested locally. See [npm.md](npm.md) for the difference between
`npm install` and `npm ci`.

## See also

* [Node.js](node.md)
* [npm](npm.md)
* [JavaScript](javascript.md)
* [Node.js official documentation](https://nodejs.org/en/docs)
* [Express.js](https://expressjs.com/)
* [Mocha test framework](https://mochajs.org/)
* [ESLint](https://eslint.org/)
