# PWA

## Information

Progressive Web Apps (PWAs) are web applications that use standard browser capabilities to provide an app-like
experience. A PWA is still a website, but it can support installation, offline work, background updates, push
notifications, and a more resilient user experience on unreliable networks.

If the goal is to make a PWA feel as installable as possible on handheld devices, the design should prioritize mobile
browser compatibility, home-screen installation flows, standalone display, touch-friendly navigation, and predictable
behavior on Android and iOS-like environments. A PWA cannot become a fully native application on every device, but it
can be designed to maximize the chance that users see an install prompt or can add it to the home screen and use it as
an app-like entry point.

For practical work, it is useful to think about a PWA as a combination of:

* normal HTML, CSS, and JavaScript pages,
* a web app manifest that describes how the app should look when installed,
* a service worker that controls caching and offline behavior,
* backend APIs designed to tolerate unstable connectivity and synchronization.

## Architecture and Structure

Typical PWA structure includes the following parts:

* **Application shell**: the minimal HTML, CSS, JavaScript, icons, and navigation needed to render the basic interface
  quickly.
* **Manifest**: `manifest.webmanifest` or similar, used by browsers to expose installability and metadata such as name,
  icons, theme color, and start URL.
* **Service worker**: JavaScript running separately from the page, usually responsible for caching static assets,
  intercepting requests, and controlling offline and update strategies.
* **Storage layer**: browser storage for settings, cached content, queued operations, and temporary user data.
* **Backend API**: the remote system of record used for synchronization, authentication, and data exchange when
  connectivity is available.

In practice, a PWA should be organized so that the user interface can start without waiting for all backend requests.
Critical rendering assets should be separated from dynamic data. Static resources should be versioned so they can be
cached safely and updated predictably.

## Environment Restrictions

PWAs run inside the browser environment and therefore inherit browser security and platform restrictions.

### General Restrictions

* No unrestricted filesystem access like a native desktop application.
* No arbitrary background processes.
* Limited access to operating system integration.
* Hardware access is possible only through browser-provided APIs and usually requires explicit user permission.
* Browser storage quotas apply and may vary by platform and vendor.

### Development Environment Restrictions

Development usually differs from production in important ways:

* Service workers usually require a secure context. In practice this means `https`, with `localhost` commonly treated as
  secure for local development.
* Caching can make debugging confusing because old assets may remain controlled by a previously installed service
  worker.
* Browser DevTools may need manual cache clearing, unregistering service workers, and reloading under controlled
  conditions.
* Some installability or push-notification features may behave differently or be partially unavailable in local
  development.
* Backend calls from local frontend development often require correct CORS configuration.
* Self-signed certificates in development can introduce extra trust and testing problems.

When developing a PWA, it is important to test both first-load online behavior and repeated loads with network
throttling, offline mode, and stale caches.

## Requirements

At minimum, a production-quality PWA should define and verify the following requirements.

### HTML Requirements

The main HTML page should include at least:

```html
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#ffffff">
    <meta name="description" content="Application description">
    <link rel="manifest" href="/manifest.webmanifest">
    <link rel="icon" href="/icons/icon-192.png">
    <title>Application name</title>
</head>
<body>
<div id="app"></div>
<script src="/app.js"></script>
</body>
</html>
```

Common expectations:

* valid `<!doctype html>` declaration,
* correct language and character encoding,
* responsive viewport meta tag,
* manifest link,
* theme color,
* at least one icon,
* bootstrap element for the application shell.

### Manifest Requirements

The web app manifest should normally contain:

* `name`,
* `short_name`,
* `start_url`,
* `display`,
* `background_color`,
* `theme_color`,
* `icons` in suitable sizes such as `192x192` and `512x512`.

For handheld-device installability, it is also strongly recommended to define:

* `display` as `standalone` or `fullscreen` only when the application is truly designed for that mode,
* `id` so the application has a stable identity,
* `scope` so navigation stays inside the installed experience,
* `description`,
* `orientation` when the application is optimized for a specific device posture,
* `screenshots` where supported by install surfaces,
* maskable icons in addition to normal icons.

Example:

```json
{
    "id": "/",
    "name": "Application name",
    "short_name": "App",
    "start_url": "/?source=pwa",
    "scope": "/",
    "display": "standalone",
    "background_color": "#ffffff",
    "theme_color": "#ffffff",
    "description": "Application description",
    "icons": [
        {
            "src": "/icons/icon-192.png",
            "sizes": "192x192",
            "type": "image/png"
        },
        {
            "src": "/icons/icon-512.png",
            "sizes": "512x512",
            "type": "image/png"
        },
        {
            "src": "/icons/maskable-512.png",
            "sizes": "512x512",
            "type": "image/png",
            "purpose": "maskable"
        }
    ]
}
```

### Installability Requirements

To maximize installability on many handheld devices, the application should satisfy all of the following:

* be served over `https`,
* provide a valid manifest linked from HTML,
* provide a working service worker for the application scope,
* start from a mobile-friendly page that works without desktop-only interactions,
* use touch-sized controls and responsive layout,
* provide icons that remain recognizable on different launcher shapes,
* avoid browser UI dependencies that break in standalone mode,
* keep essential navigation inside the manifest `scope`,
* ensure the start URL loads reliably even on slow networks.

Installability is vendor-specific. Some browsers show an install prompt automatically, some require a manual browser
menu action such as "Add to Home Screen", and some handheld environments support only a subset of manifest or service
worker features.

### Service Worker Requirements

The service worker should:

* register successfully,
* cache only well-defined resources,
* version caches,
* remove obsolete caches during activation,
* define explicit behavior for navigation requests, static assets, and API calls,
* fail safely when network or storage is unavailable.

### Operational Requirements

* The application must remain usable when the network is slow or temporarily unavailable.
* The user should receive predictable behavior when a new application version is deployed.
* Critical user operations should not be silently lost when offline.
* Accessibility, responsive layout, and normal browser navigation must still work.

## Offline Work

Offline support should be designed intentionally, not treated as a side effect of caching.

Useful offline patterns include:

* **App shell caching**: keep the interface available even when backend data cannot be loaded.
* **Read cache**: store previously fetched content for later viewing.
* **Write queue**: store user actions locally and synchronize them later.
* **Optimistic UI**: update the interface immediately, then reconcile with the backend after synchronization.
* **Fallback pages**: show dedicated offline pages or cached placeholders for missing content.

Not all data should be cached. Sensitive, short-lived, or large datasets should be evaluated carefully before local
persistence is enabled.

## Handheld Device Notes

Installability and app-like behavior differ across handheld platforms.

### Android and Chromium-based Browsers

Usually provide the best PWA installability support:

* manifest metadata is used directly,
* install prompts may appear automatically when installability criteria are met,
* standalone display mode is commonly supported,
* service worker caching and push support are generally strongest here.

### iPhone and iPad Safari

Support is more limited and should be planned for explicitly:

* installation is often a manual `Add to Home Screen` action,
* install prompts are not equivalent to Chromium behavior,
* some web platform APIs may be unavailable or restricted,
* background behavior is more constrained,
* storage eviction and caching behavior can be more aggressive,
* push notifications and other capabilities depend on OS and browser version.

For broad handheld support, documentation and UX should never assume one identical install flow everywhere.
Users may need platform-specific instructions even when the application itself remains the same.

## Offline Storage Options

Several browser storage mechanisms can be used depending on the data type and lifecycle.

### Cache Storage

Good for:

* HTML,
* CSS,
* JavaScript bundles,
* images,
* previously fetched HTTP responses.

Usually accessed from the service worker. Best suited for deterministic asset and response caching.

### IndexedDB

Good for:

* structured application data,
* drafts,
* queued commands,
* synchronization metadata,
* larger offline datasets.

IndexedDB is the usual choice for serious offline-capable applications.

### localStorage and sessionStorage

Good only for small and simple values such as:

* UI flags,
* user preferences,
* lightweight non-sensitive settings.

These APIs are synchronous and should not be used for large or critical offline data.

## Tools and Libraries for Offline Storage

The browser APIs above can be used directly, but in practice many projects use helper libraries to make offline storage,
cache management, and synchronization easier to maintain.

### Workbox

Useful for:

* service worker generation,
* precaching,
* runtime caching strategies,
* offline fallbacks,
* background sync integration.

Workbox is one of the most common choices when the application needs a structured way to manage service worker caching
without writing all cache logic manually.

### Dexie

Useful for:

* simpler `IndexedDB` access,
* schema versioning,
* structured local datasets,
* queues for offline write operations,
* querying and updating local records.

Dexie is a practical wrapper around `IndexedDB` and is often easier to work with than the raw browser API.

### localForage

Useful for:

* a simple key-value API,
* storing data through `IndexedDB` when available,
* fallback handling across browser storage backends,
* lightweight offline persistence without much storage boilerplate.

localForage is a good option when the project wants something more capable than `localStorage` but simpler than using
raw `IndexedDB` directly.

### idb

Useful for:

* minimal wrappers around native `IndexedDB`,
* promise-based database access,
* projects that want small abstractions with low overhead.

`idb` is suitable when the team wants to stay close to the platform API while avoiding the verbosity of native
`IndexedDB`.

### PouchDB

Useful for:

* local-first applications,
* document-style offline storage,
* synchronization patterns,
* conflict-aware replication in architectures that support it.

PouchDB can be useful for some offline-first designs, although it fits best when the application architecture is built
around document replication patterns.

### Choosing a Library

Typical selection guidance:

* choose **Workbox** for service worker caching and offline asset strategies,
* choose **Dexie** or **idb** for structured `IndexedDB` data,
* choose **localForage** for simpler key-value persistence,
* choose **PouchDB** only when document synchronization and replication patterns match the backend model.

Even when a helper library is used, storage quotas, eviction behavior, browser compatibility, and security rules still
come from the browser platform.

## Working with Backend

The backend remains the authoritative data source in most PWA architectures. The frontend should be designed to tolerate
temporary disconnection without corrupting user actions.

Useful backend integration practices:

* Design APIs so repeated requests are safe where possible.
* Prefer stable identifiers generated on the client or returned predictably by the backend.
* Support resumable synchronization and conflict handling.
* Return timestamps, versions, or ETags to help with reconciliation.
* Distinguish clearly between cached read models and authoritative server state.
* Keep authentication flows compatible with browser constraints and token expiration during offline periods.

For write operations performed offline, define a synchronization strategy explicitly:

* queue locally,
* retry with backoff,
* detect conflicts,
* show status to the user,
* allow manual resolution when automatic merge is unsafe.

When the installed PWA is expected to behave like a handheld app, backend APIs should also minimize cold-start cost:

* keep startup requests small,
* avoid requiring multiple sequential blocking calls before rendering,
* allow partial data loading,
* support resumable sessions when the browser process is suspended.

## Configuration

Typical configuration topics for a PWA include:

* service worker registration,
* cache naming and versioning,
* runtime caching policy,
* manifest metadata,
* icon set,
* backend base URL,
* offline fallback routes,
* feature flags for browser-specific behavior.

## Usage, tips and tricks

### Coding tips and tricks

* Keep the first page render independent from slow API requests.
* Treat service worker updates as part of release management.
* Avoid caching authenticated API responses blindly.
* Separate static asset caching from dynamic API caching.
* Always test update flow, not only initial installation.
* Make offline limitations visible to users instead of failing silently.
* Test installation and launch on real handheld devices, not only desktop responsive mode.
* Verify standalone mode layout, splash appearance, icon rendering, and back-navigation behavior.
* Do not rely only on automatic install prompts; ensure manual install instructions also exist.

## See also

* [PWA dev](https://web.dev/explore/progressive-web-apps)
* [Learn PWA](https://web.dev/learn/pwa)
