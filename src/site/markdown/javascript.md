# JavaScript

## Information

JavaScript is a high-level, interpreted programming language that is one of the core technologies of the World Wide
Web, alongside HTML and CSS. It runs in web browsers, but also server-side via Node.js and other runtimes.

JavaScript is standardized through the **ECMAScript (ES)** specification. Modern JavaScript (ES6+) supports classes,
modules, arrow functions, async/await, destructuring, and many other features.

When running JavaScript server-side with Node.js, use a **Node.js LTS version** for production workloads. The
JavaScript language itself (ECMAScript) evolves independently of the runtime, but the Node.js version determines which
ES features are available without transpilation. See [node.md](node.md) for the Node.js LTS versioning policy.

## Installation

JavaScript runs natively in all modern web browsers with no installation required.

For server-side or tooling use, install Node.js. See [node.md](node.md) for installation instructions.

### CentOS, Rocky Linux

```shell
curl -fsSL https://rpm.nodesource.com/setup_22.x | sudo bash -
sudo dnf install -y nodejs
```

### Fedora

```shell
sudo dnf install -y nodejs npm
```

### FreeBSD

```shell
pkg install -y node npm
```

### OpenIndiana

```shell
pkg install runtime/javascript/nodejs
```

## Configuration

JavaScript projects are typically configured through:

* `package.json` — project metadata, scripts, and dependency declarations (see [npm.md](npm.md)).
* `.eslintrc.json` / `eslint.config.js` — linting rules.
* `tsconfig.json` — TypeScript compiler settings (when using TypeScript).
* `.babelrc` / `babel.config.json` — transpilation settings (when targeting older environments).

## Usage, tips and tricks

### Coding tips and tricks

Function composition:

```javascript
const add = x => x + 1;
const multiplyByTwo = x => x * 2;
const composed = x => multiplyByTwo(add(x));

console.log(composed(2)); // 6
```

Destructuring:

```javascript
const { name, age } = person;
const [first, ...rest] = array;
```

Async / await:

```javascript
async function fetchData(url) {
    const response = await fetch(url);
    const data = await response.json();
    return data;
}
```

Optional chaining and nullish coalescing:

```javascript
const city = user?.address?.city ?? 'Unknown';
```

Array methods:

```javascript
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(x => x * 2);
const evens = numbers.filter(x => x % 2 === 0);
const sum = numbers.reduce((acc, x) => acc + x, 0);
```

## See also

* [MDN JavaScript Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide)
* [MasteringJS](https://masteringjs.io)
* [Node.js](node.md)
* [npm](npm.md)
* [Flow — structural typing](https://flow.org/en/docs/getting-started/)
* [SockJS](https://github.com/sockjs/sockjs-client)
* [Svelte](https://svelte.dev/)
