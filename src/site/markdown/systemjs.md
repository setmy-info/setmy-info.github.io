# SystemJS

## Information

`SystemJS` is a dynamic JavaScript module loader commonly used in browser-based applications and microfrontend setups.
In practice, it is often used to load JavaScript modules at runtime, work with import maps, and support scenarios where
applications or frontend modules need to be composed and updated independently.

It is especially relevant when a frontend platform needs runtime composition instead of packaging every module into one
bundle at build time. In such setups, a shell application can decide at runtime which module URL should satisfy a given
module name, which makes `SystemJS` a common companion for independently deployed frontend artifacts.

### Main Functionalities and Features

* **Dynamic Module Loading**: Loads JavaScript modules in the browser at runtime.
* **Import Map Support**: Commonly used with browser import maps to control how module specifiers resolve.
* **Microfrontend Compatibility**: Frequently used together with `single-spa` and similar architectures.
* **Legacy and Mixed Environment Support**: Helps bridge environments where native module loading support or
  compatibility requirements vary.
* **Pluggable Loading Behavior**: Can be extended for custom resolution and loading workflows in advanced scenarios.
* **Runtime Composition**: Useful when separate frontend artifacts are deployed and wired together after build time.

### How `SystemJS` Fits Into Modern Frontend Architectures

`SystemJS` is not a UI framework. It is an infrastructure-level runtime utility.

It usually sits between:

* the browser,
* the import map that declares module locations,
* and the application shell or orchestrator that requests modules.

In practice, it is often used when:

* multiple frontend modules are deployed separately,
* the final module URLs are chosen at runtime,
* teams need controlled indirection between logical module names and physical assets,
* or a microfrontend shell needs to compose features without rebuilding the whole frontend.

In contrast, if a project is fully bundled at build time and does not require runtime module composition,
`SystemJS` may add unnecessary complexity.

### Common Developer Use Cases

* Load independently deployed frontend modules in a microfrontend platform.
* Use import maps to switch module locations between local development and production.
* Compose browser applications from separately versioned artifacts.
* Support migration paths where not all modules are bundled or loaded the same way.

## Installation

### npm

For package-managed projects, install `SystemJS` from `npm`:

```bash
npm install systemjs
```

For browser-based setups, teams may also load the runtime from a hosted asset or build output, depending on how their
import maps and deployment process are managed.

### Practical Notes

* Match the loading approach to your browser support and deployment requirements.
* Keep import-map changes controlled and versioned, because they influence which modules are actually loaded at runtime.
* Prefer clear ownership of module URLs and release flow when multiple teams publish frontend artifacts.

## Core Concepts

### Import Maps

An import map links a module specifier such as `app1` to a concrete URL.

This lets application code import or request logical module names while deployment infrastructure decides where the real
artifact lives.

### Runtime Resolution

When `SystemJS` is asked to load a module, it resolves the module name using the configured mapping and then fetches the
target script.

This makes runtime behavior highly flexible, but it also means configuration errors often appear only after deployment.

### Independent Deployment

One of the main reasons to use `SystemJS` is to support separate release cycles.

For example, a shell can stay unchanged while one microfrontend is upgraded by updating only the import map entry for
that module.

### Loader Responsibility

`SystemJS` is responsible for module loading and resolution, not for business routing, state management, or UI design.
Those concerns still need explicit contracts at the application architecture level.

## Configuration

Typical configuration areas include:

* import maps and module specifier resolution,
* runtime module URL locations,
* development versus production loading behavior,
* compatibility with bundlers or transpilers,
* and shell-level integration with microfrontend orchestration.

For team usage, document who owns each module entry and how runtime mapping changes are promoted across environments.

Common configuration decisions include:

* whether import maps are embedded into HTML or served as separate assets,
* how fallback behavior is handled when a remote module fails to load,
* which shared libraries are resolved centrally versus bundled per module,
* and how local development overrides are applied without breaking production mappings.

## Usage, tips and tricks

### Basic Example

```html

<script type="systemjs-importmap">
    {
      "imports": {
        "app1": "/apps/app1.js"
      }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/systemjs/dist/system.min.js"></script>
<script>
    System.import('app1');
</script>
```

In this example, `app1` is a logical module name. The import map resolves it to `/apps/app1.js`, and `SystemJS`
loads that module dynamically in the browser.

### Typical Usage Flow

1. A shell or entry page defines an import map.
2. `SystemJS` is loaded into the browser.
3. The shell requests one or more modules by logical name.
4. `SystemJS` resolves those names to URLs and loads the matching artifacts.
5. The loaded modules register routes, export functions, or bootstrap UI fragments.

### When `SystemJS` Is a Good Fit

`SystemJS` is often a good fit when:

* runtime composition is a real architectural requirement,
* teams deploy frontend parts independently,
* environment-specific module URLs must remain externalized,
* or a shell needs control over which module version is active without rebuilding everything.

### When to Reconsider It

It may be unnecessary when:

* one frontend application is released as a single artifact,
* native browser modules with simple import maps are already sufficient,
* or the team cannot operationally support runtime dependency governance.

### Practical Notes

* Use `SystemJS` when runtime module composition is part of your architecture, not only as a default choice for every
  frontend.
* Keep import maps small, readable, and environment-aware.
* Test the integrated runtime behavior, because resolution issues often appear only after deployment.
* When used with microfrontends, align `SystemJS` configuration with the shell, routing, and release strategy.
* Avoid hidden coupling between independently loaded modules.

### Risks and Limitations

* Runtime loading can fail because of CDN, network, mapping, or versioning issues.
* Debugging is often more operationally complex than in a single bundled application.
* Shared dependency strategy must be explicit to avoid subtle incompatibilities.
* Performance can degrade if too many remote modules are loaded without coordination.

## See also

* [SystemJS official documentation](https://github.com/systemjs/systemjs)
* [SystemJS npm package](https://www.npmjs.com/package/systemjs)
* [single-spa](single-spa.html)
