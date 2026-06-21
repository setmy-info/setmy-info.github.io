# Mercurial

## Information

Mercurial (command: `hg`) is a distributed version control system (DVCS) written in Python. It emphasizes simplicity,
high performance, and scalability. Like Git, every developer has a full local copy of the repository history.

Key differences from Git:

* No staging area — changes go directly from working directory to commit.
* Linear history by default; branches are explicit named entities.
* Simpler mental model for push/pull: `hg push` sends changesets to the remote, `hg pull` fetches them.
* Changesets are identified by revision numbers locally and by hash globally.
* Large file support via the `largefiles` extension.

Mercurial is used by Meta (for its main monorepo), and historically by Mozilla, Python, and many other open-source
projects. New projects generally use Git, but Mercurial remains in active use in large monorepo contexts.

## Installation

### Rocky Linux / CentOS

```shell
sudo dnf install -y mercurial
hg --version
```

### Fedora

```shell
sudo dnf install -y mercurial
```

### Debian / Ubuntu

```shell
sudo apt install -y mercurial
```

### FreeBSD

```shell
pkg install -y mercurial
```

### macOS

```shell
brew install mercurial
```

### Windows

Download the installer from [mercurial-scm.org](https://www.mercurial-scm.org/downloads) or install via Chocolatey:

```powershell
choco install mercurial
```

## Configuration

User configuration lives in `~/.hgrc` (Linux/macOS) or `%USERPROFILE%\Mercurial.ini` (Windows):

```ini
[ui]
username = Your Name <your@email.com>
editor = vim

[extensions]
color =
pager =
```

Per-repository configuration is in `.hg/hgrc`:

```ini
[paths]
default = https://bitbucket.org/myteam/myrepo
```

## Usage, tips and tricks

### Basic Workflow

```shell
# Initialize a new repository
hg init my-repo
cd my-repo

# Clone an existing repository
hg clone https://example.com/repo

# Check status of working directory
hg status

# Stage and commit all changes (no staging area — all modified tracked files)
hg commit -m "My commit message"

# Add new (untracked) files
hg add
hg add specific-file.txt

# Push changes to remote
hg push

# Pull changes from remote (does not update working directory)
hg pull

# Pull and update working directory
hg pull -u

# Update working directory to a revision
hg update tip
hg update 42
```

### History and Diff

```shell
# Show commit log
hg log
# Compact one-line log
hg log --template "{rev}: {desc|firstline}\n"
# Show diff of working directory
hg diff
# Show diff of a specific changeset
hg diff -c 42
# Show detailed info about a changeset
hg log -r 42 -v
```

### Branching and Merging

```shell
# List branches
hg branches
# Create a named branch
hg branch feature-x
hg commit -m "Start feature-x branch"
# Merge another branch into current
hg merge feature-x
hg commit -m "Merge feature-x"
```

### Undo

```shell
# Revert a file to last committed state
hg revert file.txt
# Revert all changes
hg revert --all
# Amend last commit (requires histedit extension or --amend)
hg commit --amend -m "Better message"
```

## See also

* [Mercurial official site](https://www.mercurial-scm.org/)
* [Mercurial documentation](https://www.mercurial-scm.org/guide)
* [Mercurial wiki](https://wiki.mercurial-scm.org/)
* [Git](git.md)
* [Sapling (Meta's Mercurial-based VCS)](sl.md)
