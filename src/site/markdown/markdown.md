# Markdown

## Information

Markdown is a lightweight markup language created by John Gruber in 2004. It is designed to be readable as plain text
while converting cleanly to HTML. It is the dominant format for README files, documentation sites, wikis, and static
site generators.

### Variants and Flavours

| Variant                         | Description                                                              |
|---------------------------------|--------------------------------------------------------------------------|
| **CommonMark**                  | Standardised specification resolving ambiguities in original Markdown    |
| **GitHub Flavored Markdown (GFM)** | Adds tables, strikethrough, task lists, fenced code blocks, autolinks |
| **MultiMarkdown**               | Extends with footnotes, tables, metadata, cross-references               |
| **Pandoc Markdown**             | Highly extensible; used for academic and multi-format document workflows |

Most editors and platforms (GitHub, GitLab, VS Code, Jekyll, Hexo) support GFM or CommonMark.

## Installation

Markdown itself needs no installation — it is a plain-text format.

### Processors and Tools

**Pandoc** — universal document converter supporting Markdown to PDF, DOCX, HTML, and many other formats:

```shell
# Rocky Linux / Fedora
sudo dnf install -y pandoc

# Debian / Ubuntu
sudo apt-get install -y pandoc

# macOS
brew install pandoc
```

**markdown-cli** via npm:

```shell
npm install -g marked
marked --input README.md --output README.html
```

**grip** — renders GitHub Flavored Markdown locally in a browser:

```shell
pip install grip
grip README.md
```

## Configuration

Markdown itself has no configuration. Processor-specific settings:

* **Pandoc**: command-line flags or `defaults.yaml` file.
* **Jekyll**: `_config.yml` `markdown:` key (kramdown, CommonMark).
* **MkDocs**: `mkdocs.yml` `markdown_extensions:` list.
* **Hexo**: `_config.yml` renderer settings.

## Usage, tips and tricks

### Basic Syntax

```markdown
# Heading 1
## Heading 2
### Heading 3

**bold**   *italic*   ~~strikethrough~~   `inline code`

- unordered list item
- another item

1. ordered list item
2. second item

[Link text](https://example.com)
![Alt text](path/to/image.png)

> Blockquote text

Horizontal rule:
---
```

### Code Blocks (GFM)

Fenced code blocks with language identifier enable syntax highlighting:

````markdown
```python
def hello():
    print("Hello, World!")
```
````

### Tables (GFM)

```markdown
| Column A | Column B | Column C |
|----------|:--------:|---------:|
| left     | center   |    right |
```

### Task Lists (GFM)

```markdown
- [x] Completed task
- [ ] Pending task
```

### Escaping

Prefix a Markdown character with `\` to render it literally:

```markdown
\*not italic\*   \# not a heading
```

### Pandoc — Markdown to PDF

```shell
pandoc README.md -o README.pdf
pandoc README.md -o README.docx
```

## See also

* [Markdown Guide](https://www.markdownguide.org)
* [CommonMark specification](https://commonmark.org/)
* [GitHub Flavored Markdown spec](https://github.github.com/gfm/)
* [Dillinger — online Markdown editor](https://dillinger.io/)
* [Pandoc](https://pandoc.org/)
