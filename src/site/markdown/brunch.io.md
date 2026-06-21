# brunch.io

Looks dead project.

## Information

Brunch was a fast, opinionated build tool for web applications that focused on convention over configuration. It
handled compilation, concatenation, and minification of JavaScript, CSS, and other assets. Development on Brunch has
effectively stopped; it is no longer actively maintained.

For new projects, use one of the actively maintained alternatives:

* **Vite** — fast dev server with native ES module support, recommended for most new projects.
* **Webpack** — highly configurable bundler, see [webpack.md](webpack.md).
* **esbuild** — extremely fast bundler written in Go.
* **Parcel** — zero-config bundler.

## Installation

Legacy install (not recommended for new projects):

```shell
npm install -g brunch
brunch new proj -s es6
```

## Usage, tips and tricks

```shell
npm install -g brunch
brunch new proj -s es6
# Build once
brunch build
# Build and watch for changes
brunch watch
# Build for production
brunch build --production
```

## See also

* [brunch.io](https://brunch.io/)
* [Vite (recommended replacement)](https://vitejs.dev/)
* [Webpack](webpack.md)
* [npm](npm.md)
