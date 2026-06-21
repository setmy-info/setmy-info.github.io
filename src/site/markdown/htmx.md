# HTMX

## Information

HTMX is a JavaScript library that extends HTML with AJAX, CSS transitions, WebSockets, and Server-Sent Events
directly through HTML attributes — no JavaScript code required on the client side. The server returns HTML fragments
instead of JSON, and HTMX swaps them into the page.

Key characteristics:

* No build step required — include a single `<script>` tag.
* Server-side rendered HTML replaces JSON APIs for interactions.
* Works with any server framework (FastAPI, Spring Boot, Flask, Express, Rails, …).
* Reduces client-side JavaScript complexity for server-rendered applications.
* Not a replacement for SPAs when complex client-side state is needed; best suited for traditional
  multi-page or hypermedia-driven applications.

## Installation

### CDN (no build step)

```html
<script src="https://unpkg.com/htmx.org@2.0.0" integrity="..." crossorigin="anonymous"></script>
```

Check [unpkg.com/htmx.org](https://unpkg.com/htmx.org/) for the latest version and integrity hash.

### npm

```shell
npm install htmx.org
```

Import in your bundle entry point:

```javascript
import 'htmx.org';
```

### Rocky Linux / Fedora

HTMX is a client-side library — install via npm or CDN. No OS-level package needed.

## Configuration

HTMX is configured through HTML attributes and optional JavaScript configuration:

```javascript
// Global config (place before htmx script tag or in a module)
htmx.config.defaultSwapStyle = 'innerHTML';
htmx.config.historyCacheSize = 20;
htmx.config.refreshOnHistoryMiss = true;
```

## Usage, tips and tricks

### Core Attributes

| Attribute      | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| `hx-get`       | Issues a GET request to the given URL                                       |
| `hx-post`      | Issues a POST request                                                       |
| `hx-put`       | Issues a PUT request                                                        |
| `hx-delete`    | Issues a DELETE request                                                     |
| `hx-target`    | CSS selector for the element to update (default: the element itself)        |
| `hx-swap`      | How to swap the response: `innerHTML`, `outerHTML`, `beforeend`, `afterend`, … |
| `hx-trigger`   | Event that triggers the request (default: natural event for the element)    |
| `hx-indicator` | CSS selector for a loading indicator shown during the request               |
| `hx-push-url`  | Push a new URL to the browser history after the request                     |

### Basic Example — Click to Load

```html
<button hx-get="/api/items" hx-target="#list" hx-swap="innerHTML">
    Load Items
</button>
<div id="list"></div>
```

The server returns an HTML fragment:

```html
<ul>
    <li>Item 1</li>
    <li>Item 2</li>
</ul>
```

### Polling

```html
<div hx-get="/api/status" hx-trigger="every 2s" hx-swap="outerHTML">
    Loading…
</div>
```

### Form Submission

```html
<form hx-post="/api/users" hx-target="#result" hx-swap="innerHTML">
    <input type="text" name="name" placeholder="Name">
    <button type="submit">Save</button>
</form>
<div id="result"></div>
```

### CSS Transition on Swap

Add `htmx-settling` and `htmx-swapping` CSS classes for transition effects:

```css
.htmx-swapping {
    opacity: 0;
    transition: opacity 0.3s ease-out;
}
```

### When to Use HTMX vs a SPA Framework

Use HTMX when:

* The application is primarily server-rendered and interactions are request/response patterns.
* You want to reduce JavaScript complexity and bundle size.
* The server already generates HTML (templates, Thymeleaf, Jinja2, Freemarker, etc.).

Use a SPA framework (React, Angular, Vue) when:

* Rich client-side state management is required.
* The UI needs to respond to frequent local events without server round trips.
* Offline capability or progressive web app features are required.

## See also

* [HTMX official site](https://htmx.org/)
* [HTMX documentation](https://htmx.org/docs/)
* [HTMX examples](https://htmx.org/examples/)
* [FastAPI](fastapi.md)
* [JavaScript](javascript.md)
* [PWA](pwa.md)
