# Angular

## Information

Angular is a TypeScript-based, open-source front-end web application framework developed and maintained by Google.
It provides a comprehensive platform for building scalable single-page applications (SPAs), including a component
model, dependency injection, reactive forms, routing, and HTTP client out of the box.

Angular requires **Node.js** to run its CLI tooling and development server. Always use an **LTS** Node.js version for
Angular development and CI pipelines. Each Angular major version specifies a minimum Node.js LTS version in its
compatibility matrix — check the [Angular version compatibility table](https://angular.dev/reference/releases) before
upgrading either Angular or Node.js. See [node.md](node.md) for LTS versioning details.

## Installation

LTS Node.js is required. Install the Angular CLI globally:

Upgrade npm before installing to avoid resolver warnings:

```shell
npm install -g npm
npm install -g @angular/cli
ng --version
```

## Preparations

### Initialize a New Application

```shell
# Interactive
ng new my-app

# Non-interactive with preset choices
ng new my-app \
  --style=less \
  --ssr=false \
  --ai-config=agents \
  --ai-config=gemini \
  --ai-config=jetbrains \
  --ai-config=claude \
  --ai-config=cursor \
  --strict \
  --routing=true \
  --defaults \
  --skip-git
```

### Run the Development Server

```shell
cd my-app
ng serve --open
```

Browse to [http://localhost:4200/](http://localhost:4200/).

```shell
# Or open directly in Firefox
/opt/firefox/firefox --new-tab http://localhost:4200/
```

```shell
### Run Tests

# Interactive watch mode
ng test
# Single run (useful for CI)
ng test --watch=false
```

### WebdriverIO (WDIO) End-to-End Testing Packages

These packages are commonly added when setting up end-to-end tests with WDIO in an Angular project:

| Package                   | Purpose                                                                 |
|---------------------------|-------------------------------------------------------------------------|
| `@wdio/jasmine-framework` | Jasmine test framework adapter for WDIO                                 |
| `@wdio/local-runner`      | Runs WebdriverIO tests locally (launches browser drivers automatically) |
| `@wdio/schematics`        | Angular schematics to add WDIO configuration to an existing Angular app |
| `@wdio/spec-reporter`     | Prints test results to the terminal in a human-readable spec format     |

Install them as dev dependencies:

```shell
npm install --save-dev @wdio/jasmine-framework @wdio/local-runner @wdio/schematics @wdio/spec-reporter
```

## Configuration

Angular projects are configured through `angular.json` at the project root. Key configuration areas include:

* `build` target — output path, optimization, assets, budgets.
* `serve` target — development server host, port, and proxy settings.
* `test` target — test runner and browser configuration.
* `lint` target — ESLint integration.

Per-environment settings live in `src/environments/`:

```shell
src/environments/environment.ts          # Development defaults
src/environments/environment.prod.ts     # Production overrides
```

## Usage, tips and tricks

### Coding tips and tricks

Generate components, services, and modules using the CLI instead of creating files manually:

```shell
ng generate component my-component
ng generate service my-service
ng generate module my-module
ng generate guard my-guard
```

Short form:

```shell
ng g c my-component
ng g s my-service
```

Build for production:

```shell
ng build --configuration=production
```

Lint the project:

```shell
ng lint
```

## See also

* [Angular official documentation](https://angular.dev/)
* [Angular version compatibility](https://angular.dev/reference/releases)
* [Angular CLI reference](https://angular.dev/tools/cli)
* [WebdriverIO](https://webdriver.io/)
* [Node.js](node.md)
* [npm](npm.md)
* [Angular start project](angular-start-project.md)
* [A2UI components](a2ui.md)
* [AG-UI protocol](ag-ui.md)
* [Lerna monorepo](lerna.md)
