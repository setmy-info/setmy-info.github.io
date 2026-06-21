# .editorconfig

## Information

EditorConfig is a file format and collection of text editor plugins for maintaining consistent coding styles across
different editors and IDEs. A `.editorconfig` file placed in a project root is automatically read by supported editors
without requiring per-developer configuration.

Most major editors support EditorConfig natively or via a free plugin: VS Code, IntelliJ/IDEA, Vim, Emacs, Sublime
Text, Atom, and many others.

Key properties:

| Property                  | Values                             | Description                                        |
|---------------------------|------------------------------------|----------------------------------------------------|
| `indent_style`            | `space` or `tab`                   | Type of indentation                                |
| `indent_size`             | integer (e.g. `4`)                 | Number of spaces per indent level                  |
| `tab_width`               | integer                            | Width of a tab character (defaults to indent_size) |
| `end_of_line`             | `lf`, `cr`, `crlf`                 | Line ending style                                  |
| `charset`                 | `utf-8`, `latin1`, etc.            | File encoding                                      |
| `trim_trailing_whitespace`| `true` or `false`                  | Remove trailing whitespace on save                 |
| `insert_final_newline`    | `true` or `false`                  | Ensure file ends with a newline                    |
| `max_line_length`         | integer or `off`                   | Soft line length limit                             |

Wildcard patterns for section headers:

* `*` — any string of characters except path separator
* `**` — any string including path separators
* `[*.{js,ts}]` — matches multiple extensions
* `[Makefile]` — exact filename match

## Configuration

Example `.editorconfig` for a mixed Java, JavaScript, and Python project:

```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.{java,kt}]
indent_style = space
indent_size = 4

[*.{js,ts,jsx,tsx,json,html,css,less,scss}]
indent_style = space
indent_size = 4

[*.py]
indent_style = space
indent_size = 4
max_line_length = 120

[*.{yml,yaml}]
indent_style = space
indent_size = 2

[Makefile]
indent_style = tab

[*.md]
trim_trailing_whitespace = false
```

## Usage, tips and tricks

### How Editors Pick Up the File

When opening a file, the editor searches for `.editorconfig` files starting from the file's directory upward toward the
filesystem root. The closest `.editorconfig` wins for each property. Search stops when a file with `root = true` is
found.

This means you can override settings per subdirectory by placing a second `.editorconfig` there without `root = true`.
For example, a `frontend/` subdirectory could use 2-space indent while the rest of the project uses 4-space.

### IDE Integration

* **VS Code**: built-in support, no plugin needed.
* **IntelliJ IDEA / WebStorm**: built-in since 2019.x.
* **Vim/Neovim**: install `editorconfig-vim` plugin.
* **Emacs**: install `editorconfig-emacs` package.

## See also

* [editorconfig.org](https://editorconfig.org/)
* [SMI standard](../resources/.editorconfig)
