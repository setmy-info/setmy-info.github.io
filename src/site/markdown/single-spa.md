# single-spa

## Information

`single-spa` is a JavaScript microfrontend framework and router for building front-end applications from multiple
independently developed modules. In practice, teams use it to compose several `SPA` or frontend applications into one
browser experience while allowing different teams to ship and operate their parts with more autonomy.

It is especially relevant when a frontend platform wants one browser experience without forcing every team to build,
release, and deploy from one shared frontend artifact. In such setups, `single-spa` acts as the orchestration layer
that decides which applications are active, when they are mounted, and how they participate in the overall shell.

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

### How `single-spa` Fits Into Modern Frontend Architectures

`single-spa` is not a module loader or a UI framework by itself. It is primarily an orchestration framework for
microfrontends.

It usually sits between:

* the browser shell or root configuration,
* the route or activity rules that determine what should be active,
* and the independently delivered frontend applications that need lifecycle coordination.

In practice, it is often used when:

* multiple teams own separate frontend domains,
* a platform needs browser-side composition of several frontend applications,
* legacy and modern frontend applications must coexist during migration,
* or route-driven activation is needed to keep independently deployed applications manageable.

In contrast, if one modular frontend can be built, tested, and released as a single application without organizational
or operational pain, `single-spa` may introduce more coordination overhead than value.

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

## Core Concepts

### Root Configuration

Most `single-spa` setups start with a root configuration application.

This shell defines shared bootstrap behavior, application registration, top-level wiring, and often coordinates import
maps or shared platform concerns.

### Application Lifecycles

Each registered application typically exposes lifecycle functions such as bootstrap, mount, and unmount.

This allows `single-spa` to activate or deactivate frontend parts in a controlled way as the route or other activity
conditions change.

### Activity Functions

An activity function tells `single-spa` when a given application should be active.

Most often this is route-based, but it can also depend on other runtime conditions such as layout state or feature
flags.

### Orchestration Responsibility

`single-spa` coordinates application activation and lifecycle management. It does not remove the need to define
contracts for navigation, shared state, error isolation, design consistency, observability, or dependency governance.

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

Common configuration decisions include:

* whether applications are registered statically or through generated configuration,
* how route conflicts and overlapping layouts are resolved,
* which dependencies are shared centrally versus bundled per application,
* and how local development overrides are enabled without breaking integrated environments.

## Usage, tips and tricks

### Typical Workflow

1. Create a root configuration application.
2. Register each frontend application with `single-spa`.
3. Define when each application becomes active, usually by route.
4. Deploy microfrontends independently.
5. Test combined behavior in the integrated browser shell.

### Typical Runtime Flow

1. The browser loads the root configuration or shell.
2. `single-spa` evaluates the current URL or activity conditions.
3. Matching applications are bootstrapped and mounted.
4. Non-matching applications remain inactive or are unmounted.
5. On navigation, `single-spa` re-evaluates which applications should stay active, mount, or unmount.

### When `single-spa` Is a Good Fit

`single-spa` is often a good fit when:

* business domains need clear frontend ownership boundaries,
* release independence across frontend teams is a real requirement,
* incremental migration from a legacy frontend is necessary,
* or browser-side orchestration is preferred over server-side fragment composition.

### When to Reconsider It

It may be unnecessary when:

* one team can sustainably own one modular frontend application,
* runtime orchestration complexity would outweigh deployment benefits,
* or the organization lacks the governance needed for shared contracts and operational support.

### Practical Notes

* Use `single-spa` when independent delivery and composition are more important than having one unified frontend build.
* Keep cross-application contracts small and explicit.
* Avoid turning the shell into a new monolith with too much shared business logic.
* Plan authentication, navigation, and shared styling early so the user experience stays coherent.
* Be deliberate about how frontend modules share state, because loose coupling is usually easier to maintain.

### Risks and Limitations

* Cross-application debugging can be harder than in one unified frontend codebase.
* Shared dependency drift can create subtle runtime issues if governance is weak.
* The shell and route model can become overly complex if ownership boundaries are unclear.
* Independent deployment increases the need for observability, rollout discipline, and integration testing.

## See also

* [single-spa official site](https://single-spa.js.org/)
* [single-spa GitHub repository](https://github.com/single-spa/single-spa)
* [SystemJS](systemjs.html)
