# Webpack

## Information

Webpack is a static module bundler for JavaScript applications. It processes an application's dependency graph starting
from one or more entry points and produces one or more output bundles. During bundling it can transform assets —
transpiling TypeScript/JSX, processing CSS, optimising images — through configurable loaders and plugins.

Webpack requires **Node.js** to run. Use a Node.js **LTS** version for Webpack tooling. See [node.md](node.md).

Key concepts:

* **Entry**: one or more modules where Webpack starts building the dependency graph.
* **Output**: where the resulting bundles are written.
* **Loaders**: transform non-JavaScript files (TypeScript, CSS, images) so Webpack can include them in the graph.
* **Plugins**: perform broader tasks — HTML generation, CSS extraction, environment variable injection, etc.
* **Mode**: `development` (readable output, source maps) vs `production` (minification, tree shaking).

## Installation

```shell
npm install --save-dev webpack webpack-cli
# Dev server for HMR during development
npm install --save-dev webpack-dev-server
```

Common loaders and plugins:

```shell
# Transpile modern JS / JSX with Babel
npm install --save-dev babel-loader @babel/core @babel/preset-env @babel/preset-react
# CSS
npm install --save-dev css-loader style-loader
# Extract CSS to separate files in production
npm install --save-dev mini-css-extract-plugin
# Generate index.html automatically
npm install --save-dev html-webpack-plugin
```

## Configuration

### webpack.config.js

```javascript
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = (env, argv) => {
    const isProd = argv.mode === 'production';

    return {
        entry: './src/index.js',
        output: {
            filename: '[name].[contenthash].js',
            path: path.resolve(__dirname, 'dist'),
            clean: true,
        },
        module: {
            rules: [
                {
                    test: /\.(js|jsx)$/,
                    exclude: /node_modules/,
                    use: 'babel-loader',
                },
                {
                    test: /\.css$/,
                    use: [
                        isProd ? MiniCssExtractPlugin.loader : 'style-loader',
                        'css-loader',
                    ],
                },
            ],
        },
        plugins: [
            new HtmlWebpackPlugin({ template: './src/index.html' }),
            isProd && new MiniCssExtractPlugin({ filename: '[name].[contenthash].css' }),
        ].filter(Boolean),
        devServer: {
            port: 3000,
            hot: true,
        },
    };
};
```

### package.json scripts

```json
{
    "scripts": {
        "start": "webpack serve --mode development",
        "build": "webpack --mode production"
    }
}
```

## Usage, tips and tricks

### Creating Webpack Libraries

[Libraries guide](https://webpack.js.org/guides/author-libraries/)

For a distributable library, set `output.library` and `output.libraryTarget`:

```javascript
output: {
    filename: 'my-lib.js',
    library: 'MyLib',
    libraryTarget: 'umd',
    globalObject: 'this',
},
```

### Tree Shaking

Tree shaking removes unused exports in production builds. Requires ES modules (`import`/`export`):

```json
// package.json — mark package as side-effect-free
{
    "sideEffects": false
}
```

### Source Maps

```javascript
// Development
devtool: 'eval-source-map',
// Production (separate file, do not serve publicly)
devtool: 'source-map',
```

### Bundle Analysis

```shell
npm install --save-dev webpack-bundle-analyzer
```

```javascript
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');
plugins: [new BundleAnalyzerPlugin()],
```

## See also

* [Webpack official documentation](https://webpack.js.org/)
* [Webpack guides](https://webpack.js.org/guides/)
* [html-webpack-plugin](https://webpack.js.org/plugins/html-webpack-plugin/)
* [Vite (modern alternative)](https://vitejs.dev/)
* [Node.js](node.md)
* [npm](npm.md)
* [JavaScript](javascript.md)
