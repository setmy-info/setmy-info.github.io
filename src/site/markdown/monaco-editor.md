# Monaco Editor

## Information

### Introduction

The [Monaco Editor](https://microsoft.github.io/monaco-editor/) is the code editor that powers
[VS Code](vscode.md). It is a browser-based code editor that provides a rich set of features for editing code, including
syntax highlighting, IntelliSense, and a diff editor.

It is maintained by Microsoft and is licensed under the MIT License.

### What is it for?

Monaco Editor is used to:

* **Embed a Code Editor**: Provide a high-quality code editing experience in web applications.
* **Syntax Highlighting**: Support for a wide range of programming languages out of the box.
* **IntelliSense**: Provide code completion, parameter hints, and member lists.
* **Diff Editor**: Compare two versions of a file side-by-side or inline.
* **Rich Extension API**: Customize the editor's behavior and appearance.

## Main Functionalities and Features

* **Multi-Language Support**: Supports JavaScript, TypeScript, CSS, HTML, JSON, and many more.
* **IntelliSense and Validation**: Built-in support for TypeScript/JavaScript, CSS, LESS, SCSS, JSON, and HTML.
* **Diff Editor**: Powerful side-by-side and inline comparison views.
* **Accessibility**: High level of accessibility for screen readers.
* **Customization**: Highly configurable themes, keybindings, and editor options.
* **Monaco Editor Frameworks**: Wrappers available for React, Angular, Vue, and other frameworks.

## Installation and Setup

### NPM Installation

You can install the Monaco Editor via npm:

```bash
npm install monaco-editor
```

### Basic Integration

To use Monaco Editor in a web page, you need to load the editor's scripts and create an editor instance.

```javascript
import * as monaco from 'monaco-editor';

// Create the editor
const editor = monaco.editor.create(document.getElementById('container'), {
    value: "function x() {\nconsole.log(\"Hello world!\");\n}",
    language: 'javascript',
    theme: 'vs-dark'
});
```

## Tips and Tricks

* **Monaco Editor Loader**: Use `@monaco-editor/loader` for easier integration in frameworks without worrying about
  Web-Worker configurations.
* **Web Workers**: Monaco uses Web Workers for language services to keep the UI responsive. Ensure your build tool
  (Webpack, Vite, etc.) is configured to handle them.
* **Integrated Diff Editor**: Use `monaco.editor.createDiffEditor` for code comparison features.
* **Alternatives**: For different diffing implementations, consider [CodeMirror](codemirror.md) (Merge
  View), [Ace Editor](ace.md) (Ace Diff), or [Diff2Html](diff2html.md).

## See also

* [Monaco Editor Official Website](https://microsoft.github.io/monaco-editor/)
* [Monaco Editor GitHub Repository](https://github.com/microsoft/monaco-editor)
* [CodeMirror](codemirror.md)
* [Ace Editor](ace.md)
* [Diff2Html](diff2html.md)
* [VS Code](vscode.md)
* [JavaScript](javascript.md)
* [Web Components](web-components.md)
* [UI / UX / GUI](ui-ux-gui.md)
