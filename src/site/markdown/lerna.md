# Lerna

## Information

Lerna is a tool for managing JavaScript/TypeScript monorepos. It optimizes workflow around managing multi-package
repositories with git and npm (or yarn/pnpm), handling versioning, changelog generation, and publishing of multiple
packages from a single repository.

Lerna works on top of Node.js and npm workspaces. It is most commonly used with even-numbered **LTS** Node.js versions
for production monorepos. See [node.md](node.md) for the Node.js LTS versioning policy.

Lerna currently ships as two modes:

* **Independent mode** — each package in the monorepo has its own version number.
* **Fixed/locked mode** — all packages share a single version number (Babel-style).

Since Lerna v5, it is maintained by Nx and integrates with the Nx task runner optionally.

## Installation

### Global (legacy usage)

```shell
npm install --global lerna
lerna --version
```

### Local (recommended)

Install Lerna as a dev dependency in the monorepo root:

```shell
npm install --save-dev lerna
npx lerna --version
```

## Preparations

### Initialize a New Monorepo

```shell
mkdir my-monorepo
cd my-monorepo
git init
npx lerna init
```

This creates a `lerna.json` and a root `package.json`. The default structure places packages under `packages/`.

### lerna.json

Minimal `lerna.json` for independent versioning:

```json
{
    "$schema": "node_modules/lerna/schemas/lerna-schema.json",
    "version": "independent",
    "npmClient": "npm"
}
```

For fixed versioning, replace `"independent"` with a version string such as `"0.1.0"`.

### Root package.json with Workspaces

```json
{
    "name": "my-monorepo",
    "private": true,
    "workspaces": [
        "packages/*"
    ],
    "scripts": {
        "build": "lerna run build",
        "test": "lerna run test",
        "lint": "lerna run lint"
    },
    "devDependencies": {
        "lerna": "^8.0.0"
    }
}
```

### Add a Package

```shell
cd packages
mkdir my-package
cd my-package
npm init -y
```

Or using the Lerna create command:

```shell
npx lerna create my-package packages
```

### Angular Workspace inside Lerna (legacy)

```shell
cd packages
ng new has-web-app-new-ng
```

## Usage, tips and tricks

### Run a Script in All Packages

```shell
# Run "build" in every package that defines it
npx lerna run build
# Run "serve" with streaming output
npx lerna run serve --stream
# Run in a specific package
npx lerna run test --scope=my-package
```

### Versioning and Publishing

```shell
# Bump versions interactively (independent mode)
npx lerna version
# Publish packages that changed since last release
npx lerna publish from-git
# Publish with conventional commits changelog
npx lerna version --conventional-commits
```

### Bootstrap (Lerna v4 and below)

In older Lerna versions (before npm workspaces were the default), `lerna bootstrap` was used to link local packages:

```shell
npx lerna bootstrap
```

In modern Lerna (v5+) with npm/yarn workspaces enabled, `npm install` from the root is sufficient.

### Check Changed Packages

```shell
npx lerna changed
npx lerna diff
```

## See also

* [Lerna documentation](https://lerna.js.org/)
* [Lerna GitHub repository](https://github.com/lerna/lerna)
* [npm workspaces](npm.md)
* [Node.js](node.md)
* [Angular](angular.md)
* [A2UI components](a2ui.md)
* [AG-UI protocol](ag-ui.md)
