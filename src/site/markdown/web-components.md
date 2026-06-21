# Web Components

## Information

Web Components is a suite of browser standards that allow developers to create reusable, encapsulated HTML elements
without any framework dependency. The four core standards are:

* **Custom Elements**: define new HTML elements with their own behaviour using `customElements.define()`.
* **Shadow DOM**: attach an encapsulated DOM tree to an element, isolating its styles and structure from the main document.
* **HTML Templates**: declare inert markup with `<template>` that is not rendered until cloned and attached.
* **ES Modules**: load component scripts as standard JavaScript modules (`type="module"`).

Web Components work in all modern browsers natively (Chrome, Firefox, Safari, Edge). No framework is required. They
can be used alongside React, Angular, Vue, or with no framework at all.

## Installation

No installation is required for browsers that support Web Components natively. To check support:

```javascript
if ('customElements' in window) {
    console.log('Custom Elements supported');
}
```

For a lightweight helper library:

```shell
# Lit — simplifies writing Web Components
npm install lit
```

For polyfills targeting older browsers:

```shell
npm install @webcomponents/webcomponentsjs
```

## Configuration

Web Components need no global configuration. Each component is self-contained. The recommended way to distribute
components is as ES module files loaded via `<script type="module">`.

For npm-distributed components, set `"type": "module"` in `package.json` and expose the component file as the main
entry point.

## Usage, tips and tricks

### Defining a Custom Element

```javascript
class MyGreeting extends HTMLElement {
    static get observedAttributes() {
        return ['name'];
    }

    connectedCallback() {
        this.render();
    }

    attributeChangedCallback(name, oldValue, newValue) {
        this.render();
    }

    render() {
        const name = this.getAttribute('name') || 'World';
        this.textContent = `Hello, ${name}!`;
    }
}

customElements.define('my-greeting', MyGreeting);
```

Use in HTML:

```html
<script type="module" src="my-greeting.js"></script>
<my-greeting name="Alice"></my-greeting>
```

### Shadow DOM Encapsulation

```javascript
class ShadowCard extends HTMLElement {
    connectedCallback() {
        const shadow = this.attachShadow({ mode: 'open' });
        shadow.innerHTML = `
            <style>
                p { color: steelblue; font-weight: bold; }
            </style>
            <p><slot></slot></p>
        `;
    }
}

customElements.define('shadow-card', ShadowCard);
```

Styles inside the Shadow DOM do not leak out, and styles from the main document do not bleed in.

### HTML Template

```html
<template id="card-template">
    <style>
        .card { border: 1px solid #ccc; padding: 1rem; }
    </style>
    <div class="card"><slot></slot></div>
</template>

<script>
class CardElement extends HTMLElement {
    connectedCallback() {
        const template = document.getElementById('card-template');
        const clone = template.content.cloneNode(true);
        this.attachShadow({ mode: 'open' }).appendChild(clone);
    }
}
customElements.define('card-element', CardElement);
</script>
```

### With Lit

Lit is a minimal library that reduces boilerplate:

```javascript
import { LitElement, html, css } from 'lit';

class MyCounter extends LitElement {
    static properties = { count: { type: Number } };
    static styles = css`button { font-size: 1.2rem; }`;

    constructor() {
        super();
        this.count = 0;
    }

    render() {
        return html`
            <button @click=${() => this.count++}>
                Clicked ${this.count} times
            </button>
        `;
    }
}

customElements.define('my-counter', MyCounter);
```

## See also

* [MDN Web Components guide](https://developer.mozilla.org/en-US/docs/Web/API/Web_components)
* [web.dev — Web Components](https://web.dev/articles/web-components)
* [Lit library](https://lit.dev/)
* [Open Web Components](https://open-wc.org/)
* [JavaScript](javascript.md)
* [PWA](pwa.md)
