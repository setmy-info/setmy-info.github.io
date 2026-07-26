# Diff2Html

## Information

### Introduction

[Diff2Html](https://diff2html.xyz/) is an open-source library that parses git or unified diffs and generates pretty HTML
side-by-side or line-by-line comparison views.

It is written in TypeScript and can be used in the browser, in Node.js applications, or via a CLI.

### What is it for?

Diff2Html is used to:

* **Visualize Diffs**: Turn raw diff output into a human-readable and aesthetically pleasing format.
* **Code Review Tools**: Build custom code review interfaces.
* **Documentation**: Show changes between versions of documentation or configuration files.

## Main Functionalities and Features

* **Side-by-Side and Line-by-Line**: Supports both common diff visualization modes.
* **Syntax Highlighting**: Can integrate with `Highlight.js` or `Prism.js` for code highlighting.
* **Parsing**: Powerful parser for git and unified diff formats.
* **Customizable**: Themes and colors can be adjusted to match application design.
* **Framework Support**: Wrappers available for React, Vue, and Angular.

## Installation and Setup

### NPM Installation

```bash
npm install diff2html
```

### Basic Integration

```javascript
import * as Diff2Html from 'diff2html';
import 'diff2html/bundles/css/diff2html.min.css';

const diffString = 'diff --git a/file.txt b/file.txt\nindex 0000001..1234567\n--- a/file.txt\n+++ b/file.txt\n@@ -1 +1 @@\n-old\n+new';

const targetElement = document.getElementById('myDiffElement');
const configuration = { drawFileList: true, matching: 'lines', outputFormat: 'side-by-side' };

const diffHtml = Diff2Html.html(diffString, configuration);
targetElement.innerHTML = diffHtml;
```

## Tips and Tricks

* **Syntax Highlighting**: For best results, ensure `highlight.js` is loaded and configured in your application to work
  with Diff2Html.

## See also

* [Diff2Html Official Website](https://diff2html.xyz/)
* [Diff2Html GitHub Repository](https://github.com/rtfpessoa/diff2html)
* [Monaco Editor](monaco-editor.md)
* [CodeMirror](codemirror.md)
* [Ace Editor](ace.md)
* [UI / UX / GUI](ui-ux-gui.md)
