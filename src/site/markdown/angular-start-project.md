# angular-start-project

## Information

This page covers how to scaffold and prepare a new Angular project from scratch, including CLI setup, project
initialization, common packages, and recommended project structure.

Angular requires **Node.js LTS**. See [node.md](node.md) for the LTS versioning policy and installation instructions.
Check the [Angular version compatibility table](https://angular.dev/reference/releases) to ensure your Node.js LTS
version is supported by the Angular version you intend to use.

## Installation

### Install Node.js LTS

See [node.md](node.md). Verify:

```shell
node -v
npm -v
```

### Install Angular CLI

```shell
npm install -g @angular/cli
ng --version
```

Upgrade an existing CLI installation:

```shell
npm install -g @angular/cli@latest
```

## Preparations

### Create a New Project

```shell
# Interactive — prompts for style, SSR, routing
ng new my-app

# Non-interactive with explicit options
ng new my-app \
  --style=less \
  --ssr=false \
  --strict \
  --routing=true \
  --defaults \
  --skip-git
```

### Pin Node.js Version

```shell
node -v | sed 's/v//' > .nvmrc
```

### Start the Development Server

```shell
cd my-app
ng serve --open
```

Browse to [http://localhost:4200/](http://localhost:4200/).

### Project Directory Structure

After `ng new`, the key layout is:

```
my-app/
├── src/
│   ├── app/
│   │   ├── app.component.ts        # Root component
│   │   ├── app.component.html
│   │   ├── app.component.less
│   │   ├── app.component.spec.ts   # Unit test
│   │   ├── app.module.ts           # Root module (NgModule style)
│   │   └── app.routes.ts           # Routing (standalone style)
│   ├── assets/
│   ├── environments/
│   │   ├── environment.ts          # Development config
│   │   └── environment.prod.ts     # Production config
│   ├── index.html
│   └── main.ts
├── angular.json
├── package.json
├── package-lock.json
├── tsconfig.json
├── tsconfig.app.json
└── tsconfig.spec.json
```

### Common Packages and Their Purpose

**UI and Styling:**

| Package             | Purpose                                                             |
|---------------------|---------------------------------------------------------------------|
| `@angular/material` | Google Material Design component library for Angular               |
| `@angular/cdk`      | Component Dev Kit — layout, accessibility, drag-and-drop           |
| `less` / `sass`     | CSS preprocessors for component stylesheets                        |

**HTTP and State:**

| Package         | Purpose                                                             |
|-----------------|---------------------------------------------------------------------|
| `@angular/common`| Built-in — `HttpClientModule`, pipes, directives                   |
| `@ngrx/store`   | Redux-style state management for Angular                           |
| `@ngrx/effects` | Side-effect handling for NgRx (HTTP calls, etc.)                   |

**Testing:**

| Package                   | Purpose                                                        |
|---------------------------|----------------------------------------------------------------|
| `jasmine-core`            | Default unit test framework (bundled by Angular CLI)           |
| `karma`                   | Test runner that executes Jasmine tests in a browser           |
| `@wdio/jasmine-framework` | Jasmine adapter for WebdriverIO end-to-end tests               |
| `@wdio/local-runner`      | Runs WDIO tests locally with auto-managed browser drivers      |
| `@wdio/schematics`        | Adds WDIO config to Angular projects via `ng add`              |
| `@wdio/spec-reporter`     | Human-readable spec output for WDIO test runs                  |

**Build and Quality:**

| Package        | Purpose                                                               |
|----------------|-----------------------------------------------------------------------|
| `@angular/cli` | CLI for generating code, building, testing, and serving              |
| `typescript`   | TypeScript compiler (bundled by Angular CLI)                          |
| `eslint`       | Linter — replaces TSLint in Angular 12+                               |

### Install Additional Packages

```shell
# Angular Material
ng add @angular/material

# NgRx state management
npm install @ngrx/store @ngrx/effects

# WDIO end-to-end testing
npm install --save-dev @wdio/jasmine-framework @wdio/local-runner @wdio/schematics @wdio/spec-reporter
```

## Usage, tips and tricks

### Generate Code with the CLI

```shell
ng generate component features/user/user-list
ng generate service core/user
ng generate guard core/auth
ng generate interface models/user
```

Short form:

```shell
ng g c features/dashboard
ng g s services/auth
```

### Run Tests

```shell
# Unit tests (interactive)
ng test
# Unit tests (single CI run)
ng test --watch=false
# End-to-end with WDIO
npx wdio run wdio.conf.ts
```

### Build for Production

```shell
ng build --configuration=production
```

Output goes to `dist/my-app/` by default.

### Lint

```shell
ng lint
```

## See also

* [Angular](angular.md)
* [A2UI components](a2ui.md)
* [AG-UI protocol](ag-ui.md)
* [Angular official documentation](https://angular.dev/)
* [Angular CLI reference](https://angular.dev/tools/cli)
* [Angular version compatibility](https://angular.dev/reference/releases)
* [Node.js](node.md)
* [npm](npm.md)
* [WebdriverIO](https://webdriver.io/)
* [Lerna monorepo](lerna.md)
