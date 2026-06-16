# µFrontend

## Information

Microfrontend architecture applies the idea of microservices to the frontend. Instead of delivering one very large
frontend application owned by one team, the user interface is split into smaller frontend parts that can be developed,
tested, and released with a higher degree of independence.

A microfrontend is not a single technology. It is an architectural style. The actual implementation may use route-based
splitting, build-time integration, runtime composition in the browser, Web Components, module federation, or plain HTML
fragment assembly delivered to a frontend shell. If the platform explicitly avoids JavaScript rendering on the backend,
the architecture should stay centered on client-side composition instead of server-rendered frontend assembly.

The main goal is usually to let multiple teams work on separate business areas without forcing all frontend changes
through one tightly coupled codebase. That can improve autonomy and scaling of development, but it also increases
integration complexity and requires stronger technical governance.

For practical work, it is useful to think about a microfrontend system as a combination of:

* a **shell** or **host application** that provides the main entry point,
* multiple **independently implemented frontend parts**,
* shared **contracts** for navigation, authentication, events, and design,
* backend services or APIs that support those frontend parts.

## Architecture and Structure

Typical microfrontend architecture includes the following parts:

* **Host application / shell**: loads the overall layout, top-level routing, authentication context, shared navigation,
  and common assets.
* **Microfrontend modules**: self-contained frontend parts focused on business domains such as catalog, checkout,
  account, reporting, or administration.
* **Composition layer**: the mechanism that assembles the host and the microfrontends. In a frontend-only rendering
  model, this usually happens at build time or in the browser at runtime rather than through backend-side JavaScript
  rendering.
* **Shared platform layer**: design system, shared component library, logging, monitoring, feature flags, localization,
  and security-related helpers.
* **Backend integration**: APIs and services used either directly by each microfrontend or through a
  backend-for-frontend
  layer.

Common structural options:

### Route-Based Split

Each major URL section is implemented by a separate frontend application. This is often the simplest way to introduce
microfrontends because ownership boundaries are clear and cross-team runtime coupling is lower.

### Runtime Composition

The host application loads remote frontend parts dynamically in the browser. This approach can improve independent
deployment, but it requires careful management of shared dependencies, loading failures, version compatibility, and
performance.

### Web Components

Microfrontends can be exposed as custom elements and embedded into the host or into each other. This can reduce
framework coupling and make integration more explicit, especially when teams use different frontend stacks.

### Server-Side or Edge Composition

Fragments are assembled before the page reaches the browser. This can simplify first render performance and SEO in some
cases, but it shifts composition complexity to the server or edge layer. If the platform avoids JavaScript in the
backend and keeps rendering frontend-only, this option is usually intentionally excluded from the preferred design.

In practice, a healthy microfrontend system should define clear ownership boundaries, stable integration contracts, and
strict rules for shared dependencies. Without that, the architecture can degrade into a collection of inconsistent
frontend fragments that are harder to maintain than a modular monolith.

## Techniques and Implementation Possibilities

There is no single correct way to build a microfrontend platform. The implementation technique should be selected based
on team structure, browser support requirements, runtime independence needs, operational maturity, and the acceptable
level of platform complexity.

### Build-Time Integration

Several frontend parts are built and released together into one deployable artifact.

Useful when:

* teams want stronger modularity inside one repository or one release train,
* operational simplicity is more important than independent deployment,
* runtime loading of remote modules would add too much complexity.

Benefits:

* simpler runtime behavior,
* easier dependency deduplication,
* lower risk of remote loading failures.

Trade-offs:

* weaker deployment independence,
* release coordination is still required,
* one broken build can block several teams.

### Runtime Composition in the Browser

The shell loads remote applications, modules, or fragments at runtime.

For teams that want to avoid backend-side JavaScript rendering, this is often one of the most natural microfrontend
options because composition stays in the browser and the backend can remain focused on APIs, authentication, and data.

Useful when:

* teams need stronger release independence,
* the platform can tolerate more runtime orchestration,
* the organization can invest in observability and operational discipline.

Benefits:

* independent deployment is easier,
* teams can evolve their frontend parts more autonomously,
* the shell can enable or disable modules dynamically.

Trade-offs:

* more failure modes at runtime,
* stronger need for compatibility governance,
* startup and loading performance can suffer if remotes are not controlled carefully.

### Server-Side Composition

The composed page or layout is assembled on the server before reaching the browser.

If the organization deliberately avoids JavaScript execution for rendering on the backend, this technique usually does
not match the target architecture and should be treated more as a theoretical alternative than as the default path.

Useful when:

* first render performance and SEO are important,
* fragment ownership is needed but browser orchestration should stay simpler,
* teams can rely on a shared server or edge composition layer.

Benefits:

* simpler browser runtime,
* easier control of initial render,
* better fit for content-heavy or SEO-sensitive pages.

Trade-offs:

* more complexity in server orchestration,
* tighter coupling to the delivery platform,
* fragment caching and personalization become more complex.
* it conflicts with a frontend-only rendering strategy when backend-side JavaScript rendering is intentionally avoided.

### Web Component Based Integration

Each frontend part is exposed as a browser custom element.

Useful when:

* framework independence matters,
* teams need explicit integration contracts,
* the system benefits from DOM-level composition.

Benefits:

* browser-native integration model,
* clearer boundaries around inputs, outputs, and lifecycle,
* can reduce framework lock-in.

Trade-offs:

* shared state and routing still need explicit architecture,
* SSR and hydration can require extra work,
* browser support and polyfill requirements must be verified.

### Route-Level Ownership Only

The simplest possibility is to let each domain own a route or URL area without embedding several frontend runtimes into
the same page.

Useful when:

* business domains are clearly separated,
* cross-page composition is not required,
* the goal is team autonomy with minimal architectural overhead.

Benefits:

* simplest operational model,
* lower collision risk,
* easier debugging and testing.

Trade-offs:

* less flexible cross-page composition,
* transitions between areas may feel less seamless,
* shared shell behavior still needs coordination.

## How to Implement Microfrontends

Microfrontends should be introduced incrementally. In most cases, it is better to start with the simplest viable split
and only add more dynamic composition later if the organization actually needs it.

### Suggested Implementation Workflow

1. Identify business domains and ownership boundaries.
2. Decide whether route-level separation is sufficient or whether same-page composition is required.
3. Define the shell responsibilities clearly.
4. Define integration contracts for routing, identity, events, styling, and error handling.
5. Choose the composition technique, preferring browser-side or build-time composition when backend rendering is out of
   scope.
6. Set rules for shared dependencies and design-system reuse.
7. Implement one vertical slice first and validate developer workflow, deployment, and observability.
8. Only then scale the approach to more teams or domains.

### Step 1: Define Boundaries

Good boundaries are usually based on business capability rather than technical layer. For example, `catalog`,
`checkout`, `billing`, or `account` are usually better boundaries than `forms`, `tables`, or `widgets`.

Questions to answer:

* Which team owns this area end to end?
* Which routes or page regions belong to that team?
* Which data and backend APIs does that area depend on?
* What can change without requiring other teams to release?

### Step 2: Decide the Shell Responsibilities

The shell should usually own only cross-cutting concerns, for example:

* top-level routing,
* authentication context,
* shared navigation,
* feature flags,
* error boundaries and fallback UI,
* shared telemetry bootstrap,
* global design tokens.

The shell should usually not absorb domain logic that belongs inside a microfrontend, otherwise the architecture slowly
re-centralizes.

### Step 3: Define Contracts Early

Before scaling implementation, define how microfrontends communicate. Options include:

* route changes and URL parameters,
* custom browser events,
* shared state services with strict API boundaries,
* host-provided callbacks or adapters,
* HTML attributes and properties in Web Component scenarios.

The contract should define not only happy-path behavior, but also loading, timeout, permission-denied, and degraded
mode behavior.

### Step 4: Choose Deployment and Delivery Model

Typical options:

* single repository with multiple apps,
* monorepo with shared tooling and independent pipelines,
* polyrepo with platform governance,
* centrally versioned shell with independently deployed remotes,
* server-composed fragments delivered from separate services.

The decision affects release safety, dependency sharing, local development, and rollback complexity.

If rendering must stay in the frontend only, the decision space becomes narrower: route-based separation, browser
runtime composition, Web Components, or build-time integration are usually better fits than server-side rendering
pipelines.

### Step 5: Add Platform Safeguards

A real implementation should define safeguards such as:

* timeout for loading remote modules,
* fallback UI when a remote fails,
* logging with module identity attached,
* feature flags for gradual rollout,
* compatibility checks for remote manifests or contracts,
* accessibility and performance checks in CI.

## Communication and Integration Options

One of the most important implementation decisions is how microfrontends communicate.

### How Microfrontend Parts Interact Inside an SPA or PWA

When several microfrontend parts live inside the same single-page application or progressive web app, interaction
should usually happen through explicit platform contracts instead of direct hidden imports between teams.

In practice, the safest interaction model is often:

* the **shell** owns global concerns such as routing, authentication state, top navigation, and application-level
  lifecycle,
* each **microfrontend** owns its domain UI and domain-specific state,
* shared changes are propagated through documented APIs, browser events, URL state, or backend synchronization.

This is important because microfrontends in the same SPA or PWA may render on the same page, but they should still not
behave like one uncontrolled shared codebase.

### Interaction Through the Shell

The shell is usually the safest mediator between microfrontend parts.

Typical responsibilities:

* mount and unmount frontend parts,
* provide shared context such as current user, locale, theme, or feature flags,
* expose approved communication APIs,
* coordinate error handling and degraded mode behavior.

Example interaction flow:

1. one microfrontend emits an event such as `cart:updated`,
2. the shell receives and validates the event,
3. the shell updates shared indicators such as cart badge or header summary,
4. another microfrontend reacts only through the documented contract, not through direct internal access.

This keeps ownership boundaries clearer than letting one microfrontend call internal functions of another.

### Interaction Through URL and Navigation State

Inside an SPA, navigation is often the primary integration mechanism.

Examples:

* one frontend part navigates to `/checkout?cartId=123`,
* another frontend part reads route parameters and loads its own data,
* filter state, selected entity, or tab state is reflected in the URL instead of hidden in global memory.

Benefits:

* explicit and debuggable,
* deep-linkable and bookmarkable,
* resilient across refreshes and browser restarts.

For a PWA this is especially useful because app restarts, offline resumes, and suspended mobile sessions are common.
If interaction state only lives in memory, the user may lose workflow continuity.

### Interaction Through Browser Events

Custom browser events are useful when parts must notify each other inside the same page without creating strong
compile-time coupling.

Good uses:

* `auth:changed`,
* `cart:updated`,
* `notification:open`,
* `search:filters-changed`.

Good rules:

* keep event names stable and namespaced,
* keep payloads small and versioned,
* treat events as notifications, not as a hidden request-response API,
* document who is allowed to emit and consume each event.

In SPA and PWA environments, events are useful for in-memory coordination, but they should not be the only source of
truth for critical business data.

### Interaction Through Shared State

Sometimes microfrontend parts inside the same SPA need synchronized state, for example:

* current cart summary,
* authenticated user profile,
* active organization or tenant,
* unsaved workflow draft shared by several page regions.

In such cases, use a deliberately designed shared state service with a narrow public API.

Important restrictions:

* avoid exposing raw internal stores to every microfrontend,
* separate read models from write operations,
* define ownership of each piece of state,
* persist only what is actually needed across reloads or offline sessions.

If every frontend part can mutate everything, the system stops being a federation and becomes a fragile distributed
monolith in the browser.

### Interaction Through Backend Coordination

For workflows that must survive refresh, device sleep, reconnect, or offline/online transitions, backend coordination
is often the most reliable option.

Examples:

* one microfrontend stores a draft order,
* another microfrontend resumes the same draft later,
* audit state, approval state, and synchronization conflicts are handled through backend rules instead of only in
  frontend memory.

This is particularly important in a PWA because the application may be suspended by the device, reopened later, or used
with intermittent connectivity.

### Additional Considerations for PWA Behavior

When the host application is also a PWA, interaction design must respect offline and lifecycle constraints.

Important considerations:

* microfrontends should not assume continuous network availability,
* data passed only through runtime memory may disappear when the app is killed in the background,
* offline actions may need local persistence and later synchronization,
* the service worker may cache shell assets and API responses differently from what individual teams expect,
* update timing matters because different frontend parts may be refreshed at different moments.

Useful patterns for PWA-capable microfrontends:

* keep critical workflow state in `IndexedDB` or another durable browser storage instead of only in-memory stores,
* use the backend as the source of truth for cross-session workflows,
* define how queued offline mutations are replayed,
* define conflict handling when two frontend parts depend on stale cached data,
* make loading and empty-state UI explicit for offline and reconnect scenarios.

### Recommended Default

For most systems, a good default interaction model is:

* use **URL and route state** for navigation and durable view state,
* use **shell-mediated custom events** for lightweight in-page notifications,
* use **shared state** only for a small set of truly cross-cutting live state,
* use the **backend** for durable workflow coordination,
* in PWAs, persist important user progress in durable browser storage when offline continuity is required.

This combination usually keeps coupling lower while still allowing a coherent SPA or PWA user experience.

### URL and Routing Based Communication

Useful for:

* loose coupling,
* page-level ownership,
* bookmarkable and testable navigation state.

This is often the safest default because the browser URL is explicit and observable.

### Custom Events

Useful for:

* browser-level decoupling,
* event-based notifications between host and embedded modules,
* framework-independent communication.

Requirements:

* event names must be documented,
* payload schema should be versioned,
* ownership and allowed listeners should be clear.

### Shared State Container

Useful only when:

* several microfrontends truly need synchronized in-page state,
* the team accepts tighter coupling,
* the state API is governed like a public contract.

This option should be used carefully because it can easily recreate a distributed monolith in the browser.

### Backend-Mediated Coordination

Useful for:

* workflows that should remain consistent across page refreshes,
* auditability,
* cross-device or multi-session continuity.

Instead of passing too much transient state across frontend boundaries, use backend APIs as the source of truth where
appropriate.

## Option Selection Guide

Different implementation options fit different situations.

### Choose a Simpler Split When

* one team owns most of the frontend,
* release cadence is shared anyway,
* same-page composition is not necessary,
* the main problem is internal modularity rather than team autonomy.

In such cases, a modular monolith frontend or route-based multi-app structure may be a better option than a full
runtime microfrontend platform.

### Choose Runtime Microfrontends When

* multiple teams release independently,
* domains are stable and clearly separated,
* the organization can support platform governance,
* operational visibility and frontend reliability are taken seriously.

### Choose Web Components When

* teams use different frameworks,
* browser-level composition is acceptable,
* explicit DOM contracts are preferred.

### Choose Server or Edge Composition When

* first paint and SEO matter strongly,
* composition should happen before the page reaches the client,
* the delivery platform can own fragment orchestration.

If the platform deliberately avoids JavaScript in the backend, this option is usually not the preferred choice and the
architecture should instead optimize client-side startup, caching, and API design.

## Testing and Verification Requirements

Implementation is not complete unless verification strategy is defined.

Each microfrontend setup should test at least:

* isolated rendering of every frontend part,
* integrated rendering inside the shell,
* navigation across module boundaries,
* failure when one remote is unavailable,
* authentication/session continuity,
* accessibility and responsive behavior,
* performance impact of composition.

Useful verification practices:

* contract tests for host-remote integration,
* smoke tests for deployed remotes,
* visual regression checks for shared layout areas,
* synthetic monitoring for critical composition paths,
* bundle analysis to control duplicated dependencies.

## Environment Restrictions

Microfrontends still run in the browser and inherit the same browser security model as other web applications, but the
architecture introduces additional restrictions and operational risks.

### General Restrictions

* All parts share the browser page and therefore compete for network, memory, CPU time, and rendering budget.
* JavaScript isolation is limited unless explicit sandboxing is used.
* Global CSS, global events, and global browser state can leak across boundaries if not controlled.
* Shared dependencies can create version conflicts or duplicate downloads.
* Client-side composition can increase startup latency if too many remote parts are loaded at once.

### Development Environment Restrictions

Development usually differs from production in important ways:

* Local development often means several frontend dev servers running at the same time.
* Cross-origin requests are common and usually require correct CORS configuration.
* Different ports, domains, and authentication cookies can make local integration harder than production.
* Runtime-loaded remotes may fail because of version mismatch, missing manifests, or stale browser caches.
* Shared libraries may accidentally be bundled multiple times during development, hiding production problems or causing
  local-only issues.
* Source maps, HMR, and dev proxies may work differently across host and remote applications.

When developing microfrontends, it is important to test not only each frontend part in isolation, but also integrated
navigation, shared session behavior, error states, and partial availability when one frontend part fails to load.

## Requirements

At minimum, a production-quality microfrontend setup should define and verify the following requirements.

### HTML and Host Application Requirements

The main host HTML page should include at least the base structure needed to mount the shell and allow composed frontend
parts to render into defined areas.

```html
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Microfrontend host application">
    <title>Application shell</title>
</head>
<body>
<div id="app-shell">
    <header id="global-header"></header>
    <nav id="global-navigation"></nav>
    <main id="microfrontend-root"></main>
</div>
<script src="/shell.js"></script>
</body>
</html>
```

Common expectations:

* valid `<!doctype html>` declaration,
* correct language and character encoding,
* responsive viewport meta tag,
* a stable shell root element,
* predictable mount points for composed frontend parts,
* clear ownership of shared page regions such as header, navigation, and footer.

### Architecture Requirements

The system should define explicitly:

* which application acts as the shell,
* how microfrontends are discovered and loaded,
* which routes belong to which team or module,
* how shared dependencies are versioned,
* how cross-microfrontend communication is allowed,
* how failure of one frontend part is contained.

### Integration Contract Requirements

Each microfrontend should have a documented contract such as:

* expected input properties or configuration,
* emitted events,
* routing assumptions,
* authentication requirements,
* error handling behavior,
* loading and unmount lifecycle.

If Web Components are used, the contract should specify:

* custom element name,
* required attributes or properties,
* custom events,
* style or theming hooks,
* browser support assumptions.

### Styling Requirements

Styling rules should be defined to avoid collisions:

* prefer design-system tokens or shared CSS variables,
* avoid uncontrolled global CSS,
* isolate styles when possible,
* define how typography, spacing, and colors stay consistent,
* document whether Shadow DOM, CSS Modules, BEM, or another isolation strategy is used.

### Operational Requirements

A production-ready setup should also define:

* deployment independence rules,
* rollback strategy,
* observability requirements for frontend errors,
* performance budgets,
* accessibility requirements,
* compatibility policy for browsers and devices.

## Backend Integration

Microfrontends should not interact with backend services in an uncontrolled way. Even if teams own separate frontend
modules, the user should still experience one coherent application.

If rendering is frontend-only, the backend should primarily expose APIs, security/session handling, and possibly BFF
endpoints. It should not be responsible for composing JavaScript-rendered UI fragments on the server.

Common backend integration patterns:

### Direct API Access per Microfrontend

Each microfrontend calls its own backend service or domain API directly. This supports strong team ownership, but it can
also create duplicated authentication handling, inconsistent error models, and uneven API design.

### Backend for Frontend (BFF)

A BFF layer can aggregate or adapt backend APIs for the frontend composition model. This is useful when the browser
should not orchestrate too many service calls directly or when a consistent security/session model is required.

In a frontend-rendered architecture, a BFF can still be useful, but mainly as an API-shaping layer rather than as a UI
rendering layer.

### Shared Session and Identity

Authentication, token refresh, logout behavior, and permissions should be handled consistently across all frontend
parts. If each microfrontend implements this differently, the whole application becomes fragile.

### API Contract Discipline

Backend contracts should be versioned and documented. Frontend independence works only if teams can evolve their modules
without frequently breaking each other through hidden API coupling.

## Configuration

Configuration usually needs to exist at more than one level:

* **Shell configuration**: routing map, remote entry locations, feature flags, shared environment values.
* **Microfrontend configuration**: own API base URL, own feature flags, local defaults, and rendering options.
* **Platform configuration**: authentication endpoints, telemetry endpoints, design system version, locale settings.

Useful configuration practices:

* keep environment-specific values outside the compiled code when possible,
* validate remote/module configuration early,
* version shared contracts,
* avoid hidden runtime assumptions between teams,
* document required variables for local development.

## Usage, Tips and Tricks

Microfrontends are most useful when organizational boundaries are real and stable. They are usually not a good default
for small projects with one team and a manageable codebase.

Practical recommendations:

* split by business capability, not by technical layer only,
* keep shared code small and intentional,
* share a design system, not arbitrary internal application logic,
* define team ownership clearly,
* keep rendering responsibility in the browser when backend-side JavaScript rendering is intentionally avoided,
* prefer simple integration first and add runtime dynamism only when justified,
* monitor bundle size and startup cost continuously.

### Coding Tips and Tricks

Useful practices for implementation:

* keep public integration APIs small,
* avoid global mutable state,
* isolate styles and DOM assumptions,
* use explicit events or contracts instead of hidden cross-app imports,
* handle loading, timeout, and fallback UI states for remote frontend parts,
* ensure that each microfrontend can be tested alone and inside the integrated shell.

### Common Risks

Microfrontend adoption often fails because of:

* too much shared code,
* unclear ownership,
* duplicated frameworks and oversized bundles,
* inconsistent UX,
* poor observability across frontend boundaries,
* using microfrontends to solve problems that are actually internal modularity problems.

## Tools and Related Approaches

The architecture can be implemented with different tools depending on goals and frontend stack.

### Web Components

Useful for:

* framework-agnostic composition,
* explicit browser-native integration points,
* better isolation possibilities when combined with Shadow DOM.

### Module Federation

Useful for:

* runtime loading of separately built frontend modules,
* sharing dependencies between host and remotes,
* independent deployments in JavaScript bundler-based environments.

### Single-SPA

Useful for:

* orchestrating multiple frontend applications in one page,
* mounting and unmounting applications by route,
* gradual adoption in existing systems.

### Import Maps

Useful for:

* controlling browser module resolution,
* simplifying some composition scenarios with native ES modules,
* reducing some bundler-specific coupling.

### Server-Side Fragment Composition

Useful for:

* composing pages before delivery,
* improving first paint in some architectures,
* integrating frontend ownership at template or fragment level.

The right tool depends on team structure, deployment model, browser support requirements, and how much runtime
independence is truly needed.

## See also

mikrofrontend-web-components.html
