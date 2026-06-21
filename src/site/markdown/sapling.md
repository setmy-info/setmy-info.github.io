# Sapling

## Information

Sapling is a source control system developed by Meta. It is designed to be Git-compatible while offering a better
developer experience for large repositories and complex workflows. The CLI command is `sl`.

Key features:

* **Interactive smartlog** — `sl` shows a concise, graphical view of your local commits and their relationship to
  remote branches, making it easy to understand stack state at a glance.
* **Stacked commits** — first-class support for working with a stack of dependent commits and submitting or landing
  them independently.
* **Simplified rebasing** — rebasing and amending commits is a central workflow pattern; Sapling makes this less
  error-prone than raw Git rebasing.
* **Partial clone support** — designed for very large monorepos where full checkout is impractical.
* **Git compatibility** — can work with existing Git repositories; push and pull against Git remotes.

See [sl.md](sl.md) for detailed CLI command reference.

## Installation

### macOS

```shell
brew install sapling
sl --version
```

### Rocky Linux / Fedora

Download the RPM from the [Sapling releases page](https://github.com/facebook/sapling/releases):

```shell
sudo rpm -i sapling_*.rpm
sl --version
```

### Debian / Ubuntu

Download the DEB from the [Sapling releases page](https://github.com/facebook/sapling/releases):

```shell
sudo dpkg -i sapling_*.deb
sl --version
```

### Windows

Download and run the installer from the [Sapling releases page](https://github.com/facebook/sapling/releases).

## Configuration

Sapling stores its configuration in `~/.config/sapling/sapling.conf` (or `~/.sapling/sapling.conf` on some
platforms):

```ini
[ui]
username = Your Name <your@email.com>

[extensions]
rebase =
```

To initialize a new repository:

```shell
sl init my-repo
cd my-repo
```

To clone an existing Git repository:

```shell
sl clone https://github.com/example/repo.git
```

## Usage, tips and tricks

### View the smartlog

```shell
sl
# or
sl log --graph
```

### Common workflow commands

```shell
sl status              # show working copy changes
sl add <file>          # track new file
sl commit -m "message" # create a commit
sl amend               # amend the current commit
sl pull                # fetch remote changes
sl push                # push to remote
sl rebase -d main      # rebase current stack onto main
sl goto <commit>       # check out a commit
```

### Stacked commits

Sapling encourages small, reviewable commits stacked on top of each other. Use `sl next` and `sl prev` to navigate
the stack, and submit each commit for review independently.

```shell
sl next      # move to next commit in stack
sl prev      # move to previous commit in stack
```

## See also

* [sl CLI reference](sl.md)
* [Sapling official site](https://sapling-scm.com/)
* [Sapling GitHub repository](https://github.com/facebook/sapling)
* [git](git.md)
