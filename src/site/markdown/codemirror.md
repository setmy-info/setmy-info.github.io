# CodeMirror

## Information

### Introduction

[CodeMirror](https://codemirror.net/) is a versatile text editor implemented in JavaScript for the browser. It is
specialized for editing code and comes with over 100 language modes and various addons that implement more advanced
editing functionality.

A rich programming interface and a CSS-based theming system make it easy to customize to fit your application and extend
with new functionality.

### What is it for?

CodeMirror is used to:

* **Embed a Code Editor**: Provide a code editing experience in web applications.
* **Syntax Highlighting**: Support for a vast number of programming languages.
* **Advanced Editing**: Features like autocompletion, code folding, and bracket matching.
* **Diff and Merge**: Compare and merge code changes using the Merge View addon.

## Main Functionalities and Features

* **Extensibility**: Modular architecture allows adding only the features you need.
* **Language Support**: Comprehensive support for modern and legacy languages.
* **Merge View**: Provides a split-view or unified view for diffing and merging code.
* **Mobile Support**: Modern versions (CodeMirror 6) are designed with better mobile and screen reader support.
* **Theming**: Fully customizable via CSS or specialized theme packages.

## Installation and Setup

### NPM Installation (CodeMirror 6)

```bash
npm install codemirror @codemirror/lang-javascript
```

### Basic Integration

```javascript
import {EditorView, basicSetup} from "codemirror"
import {javascript} from "@codemirror/lang-javascript"

let editor = new EditorView({
  doc: "console.log('hello')\n",
  extensions: [basicSetup, javascript()],
  parent: document.body
})
```

## Tips and Tricks

* **Merge View**: Use the `@codemirror/merge` package for implementation of side-by-side or unified diff views.
* **State Management**: CodeMirror 6 separates state from view, making it easier to integrate with frameworks like React
  or Vue.

## See also

* [CodeMirror Official Website](https://codemirror.net/)
* [CodeMirror GitHub Repository](https://github.com/codemirror/dev)
* [CodeMirror Merge View Example](https://codemirror.net/examples/merge/)
* [Monaco Editor](monaco-editor.md)
* [Ace Editor](ace.md)
* [JavaScript](javascript.md)
* [UI / UX / GUI](ui-ux-gui.md)
