# single-spa

## Information

`single-spa` is a JavaScript microfrontend framework and router for building front-end applications from multiple
independently developed modules. In practice, teams use it to compose several `SPA` or frontend applications into one
browser experience while allowing different teams to ship and operate their parts with more autonomy.

### Main Functionalities and Features

* **Microfrontend Orchestration**: Mounts and unmounts independently delivered frontend applications in one page.
* **Framework Freedom**: Commonly used with `React`, `Angular`, `Vue`, and framework-agnostic modules in the same
  overall application.
* **Route-based Activation**: Loads applications only when their route or activation condition matches.
* **Incremental Migration Support**: Useful for introducing new frontend modules next to older applications instead of
  rewriting everything at once.
* **Team Autonomy**: Helps separate frontend ownership by domain, business capability, or product area.
* **Shared Shell Possibilities**: Can be combined with shared navigation, authentication, design systems, and platform
  utilities.

### Common Developer Use Cases

* Split a large monolithic frontend into smaller independently deployable parts.
* Combine legacy and modern frontend applications during a phased migration.
* Let different teams own different browser modules while keeping a unified user journey.
* Load only the frontend functionality needed for a given route or business area.

## Installation

### npm / Yarn / pnpm

For most projects, install `single-spa` from the JavaScript package ecosystem:

```bash
npm install single-spa
```

In practice, teams usually install it together with a broader microfrontend setup, for example a root configuration
application, shared dependency strategy, and deployment approach for each frontend module.

### Practical Notes

* The framework itself is only one part of the solution; you still need conventions for deployment, shared libraries,
  and local development.
* Review the official recommended setup when starting a new microfrontend platform from scratch.
* Keep runtime ownership and versioning of shared dependencies explicit.

## Configuration

Typical configuration areas include:

* application registration and activation rules,
* route layout and root configuration,
* shared dependency loading,
* local development and import-map strategy,
* error handling between microfrontends,
* and deployment / version rollout conventions.

For team environments, document which applications are loaded by which routes, who owns them, and how shared libraries
are versioned.

## Usage, tips and tricks

### Typical Workflow

1. Create a root configuration application.
2. Register each frontend application with `single-spa`.
3. Define when each application becomes active, usually by route.
4. Deploy microfrontends independently.
5. Test combined behavior in the integrated browser shell.

### Practical Notes

* Use `single-spa` when independent delivery and composition are more important than having one unified frontend build.
* Keep cross-application contracts small and explicit.
* Avoid turning the shell into a new monolith with too much shared business logic.
* Plan authentication, navigation, and shared styling early so the user experience stays coherent.
* Be deliberate about how frontend modules share state, because loose coupling is usually easier to maintain.

## See also

* [single-spa official site](https://single-spa.js.org/)
* [single-spa GitHub repository](https://github.com/single-spa/single-spa)
* [SystemJS](systemjs.html)
