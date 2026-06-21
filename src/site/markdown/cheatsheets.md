# Cheatsheets

## Information

Cheatsheets are compact reference cards for commands, syntax, or options that are too numerous to memorize but too
frequently needed to look up in full documentation. They are a practical productivity tool for developers, sysadmins,
and anyone working with command-line tools or languages regularly.

The **cheat** CLI tool lets you view and manage cheatsheets from the terminal. It ships with access to the community
cheatsheets repository and supports personal cheatsheets stored locally.

## Installation

### Linux (from releases)

```shell
# Download the binary for your platform from https://github.com/cheat/cheat/releases
chmod +x cheat-linux-amd64
sudo mv cheat-linux-amd64 /usr/local/bin/cheat
cheat --version
```

### macOS (Homebrew)

```shell
brew install cheat
```

### From source (Go required)

```shell
go install github.com/cheat/cheat/cmd/cheat@latest
```

On first run, cheat will prompt you to download the community cheatsheets:

```shell
cheat --init
```

## Configuration

Configuration is stored in `~/.config/cheat/conf.yml`. Key settings:

* `cheatpaths` — list of directories where cheatsheets are searched, with priority ordering.
* `colorize` — enable or disable syntax highlighting in output.
* `editor` — editor used when creating or editing cheatsheets.

Example config snippet:

```yaml
colorize: true
editor: vim
cheatpaths:
  - name: personal
    path: ~/.config/cheat/cheatsheets/personal
    tags: [ personal ]
    readonly: false
  - name: community
    path: ~/.config/cheat/cheatsheets/community
    tags: [ community ]
    readonly: true
```

## Usage, tips and tricks

### View a cheatsheet

```shell
cheat tar
cheat git
cheat curl
```

### Search cheatsheets

```shell
cheat -s "find files"
```

### List all available cheatsheets

```shell
cheat -l
```

### Create a personal cheatsheet

```shell
cheat -e my-topic
```

This opens the configured editor. Personal cheatsheets are stored in the personal path configured in `conf.yml`.

### Example personal cheatsheet format

```
---
tags: [ shell, git ]
---
# Show last 5 commits
git log --oneline -5

# Undo last commit (keep changes staged)
git reset --soft HEAD~1
```

### Tagging and filtering

```shell
# Show only cheatsheets tagged 'shell'
cheat -l -t shell
```

## See also

* [cheat CLI GitHub](https://github.com/cheat/cheat)
* [Community cheatsheets repository](https://github.com/cheat/cheatsheets)
* [tldr-pages (simplified man pages)](https://tldr.sh/)
* [Shell](shell.md)
