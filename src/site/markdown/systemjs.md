# SystemJS

## Information

`SystemJS` is a dynamic JavaScript module loader commonly used in browser-based applications and microfrontend setups.
In practice, it is often used to load JavaScript modules at runtime, work with import maps, and support scenarios where
applications or frontend modules need to be composed and updated independently.

### Main Functionalities and Features

* **Dynamic Module Loading**: Loads JavaScript modules in the browser at runtime.
* **Import Map Support**: Commonly used with browser import maps to control how module specifiers resolve.
* **Microfrontend Compatibility**: Frequently used together with `single-spa` and similar architectures.
* **Legacy and Mixed Environment Support**: Helps bridge environments where native module loading support or
  compatibility requirements vary.
* **Pluggable Loading Behavior**: Can be extended for custom resolution and loading workflows in advanced scenarios.
* **Runtime Composition**: Useful when separate frontend artifacts are deployed and wired together after build time.

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

## Configuration

Typical configuration areas include:

* import maps and module specifier resolution,
* runtime module URL locations,
* development versus production loading behavior,
* compatibility with bundlers or transpilers,
* and shell-level integration with microfrontend orchestration.

For team usage, document who owns each module entry and how runtime mapping changes are promoted across environments.

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

### Practical Notes

* Use `SystemJS` when runtime module composition is part of your architecture, not only as a default choice for every
  frontend.
* Keep import maps small, readable, and environment-aware.
* Test the integrated runtime behavior, because resolution issues often appear only after deployment.
* When used with microfrontends, align `SystemJS` configuration with the shell, routing, and release strategy.
* Avoid hidden coupling between independently loaded modules.

## See also

* [SystemJS official documentation](https://github.com/systemjs/systemjs)
* [SystemJS npm package](https://www.npmjs.com/package/systemjs)
* [single-spa](single-spa.html)
