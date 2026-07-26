# Ace Editor

## Information

### Introduction

[Ace](https://ace.c9.io/) (Ajax.org Cloud9 Editor) is an embeddable code editor written in JavaScript. It matches the
features and performance of native editors such as Sublime Text, Vim, and TextMate.

It can be easily embedded in any web page and JavaScript application. Ace is the primary editor for Cloud9 IDE and the
successor of the Bespin and Skywriter projects.

### What is it for?

Ace Editor is used to:

* **Embed a Code Editor**: Provide a high-performance code editing experience in web applications.
* **Syntax Highlighting**: Supports over 120 languages.
* **Large Documents**: Handles huge documents (up to 4 million lines) with ease.
* **Vim and Emacs Modes**: Provides keybindings for power users.
* **Diffing**: Can be used for code comparison with wrappers like `ace-diff`.

## Main Functionalities and Features

* **High Performance**: Smooth scrolling and typing even with large files.
* **Theming**: Over 20 themes available.
* **Keybindings**: Support for Vim and Emacs keybindings.
* **Customization**: Fully customizable through a rich API.
* **Ace Diff**: A specific wrapper (`ace-diff`) provides a two-panel diffing and merging interface.

## Installation and Setup

### NPM Installation

```bash
npm install ace-builds
```

### Basic Integration

```javascript
import ace from 'ace-builds';

const editor = ace.edit("editor");
editor.setTheme("ace/theme/monokai");
editor.session.setMode("ace/mode/javascript");
```

## Tips and Tricks

* **Ace Diff**: To use the diff variant, install `ace-diff` and configure it with two Ace editor instances.
* **Web Workers**: Use workers for syntax validation to keep the editor responsive.

## See also

* [Ace Editor Official Website](https://ace.c9.io/)
* [Ace Editor GitHub Repository](https://github.com/ajaxorg/ace)
* [Ace Diff GitHub](https://github.com/ace-diff/ace-diff)
* [Ace Diff Demo](https://ace-diff.github.io/ace-diff/)
* [Monaco Editor](monaco-editor.md)
* [CodeMirror](codemirror.md)
* [JavaScript](javascript.md)
* [UI / UX / GUI](ui-ux-gui.md)
