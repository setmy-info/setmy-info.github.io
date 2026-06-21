# Emacs

## Information

Emacs (GNU Emacs) is an extensible, self-documenting, real-time display editor. It is highly configurable through
Emacs Lisp (Elisp) and has been continuously developed since the 1970s. Emacs is both a text editor and an
environment — users routinely run email, shells, file managers, and REPLs inside it.

Key characteristics:

* Everything is a buffer — files, terminals, help pages, and command output all live in named buffers.
* The editor is live-programmable: Elisp code can be evaluated and takes effect immediately without restarting.
* A package ecosystem (MELPA, ELPA) provides syntax highlighting, LSP integration, Git interfaces (Magit), and more.
* Notation: **C-** means hold Control, **M-** means hold Meta (Alt on most keyboards), **S-** means hold Shift.

## Installation

### Rocky Linux / CentOS

```shell
sudo dnf install -y emacs
emacs --version
```

### Fedora

```shell
sudo dnf install -y emacs
```

### Debian / Ubuntu

```shell
sudo apt-get install -y emacs
```

### FreeBSD

```shell
sudo pkg install -y emacs
emacs --version
```

### macOS

```shell
brew install emacs
```

### Windows

Download from [GNU Emacs for Windows](https://www.gnu.org/software/emacs/download.html) or:

```powershell
winget install GNU.Emacs
```

## Configuration

Emacs reads its configuration from `~/.emacs` or `~/.emacs.d/init.el` at startup.

Minimal `~/.emacs.d/init.el`:

```elisp
;; Package sources
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; UI
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode t)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
```

Install a package interactively:

```
M-x package-refresh-contents RET
M-x package-install RET <package-name> RET
```

## Usage, tips and tricks

M is the Meta key (Alt on most keyboards). C is Control.

### Essential Key Bindings

| Key binding   | Action                                      |
|---------------|---------------------------------------------|
| `C-x C-f`     | Open (find) file                            |
| `C-x C-s`     | Save current buffer                         |
| `C-x C-w`     | Save buffer as (write to new file)          |
| `C-x C-c`     | Quit Emacs                                  |
| `C-g`         | Cancel current command                      |
| `M-x`         | Open command prompt (run any command by name)|
| `C-x b`       | Switch to buffer                            |
| `C-x k`       | Kill (close) buffer                         |
| `C-x 2`       | Split window horizontally                   |
| `C-x 3`       | Split window vertically                     |
| `C-x o`       | Switch to other window                      |
| `C-space`     | Set mark (start selection)                  |
| `M-w`         | Copy region                                 |
| `C-w`         | Cut region                                  |
| `C-y`         | Yank (paste)                                |
| `C-/`         | Undo                                        |
| `C-s`         | Incremental search forward                  |
| `C-r`         | Incremental search backward                 |
| `M-%`         | Query replace                               |
| `M-g g`       | Go to line number                           |

### Running a Shell

```
M-x shell      # interactive shell buffer
M-x eshell     # Emacs-native shell
M-x term       # full terminal emulator
```

### Evaluating Elisp

```
M-x eval-buffer    # evaluate the current buffer
M-: (expression)   # evaluate a single expression
```

## See also

* [GNU Emacs manual](https://www.gnu.org/software/emacs/manual/html_node/emacs/index.html)
* [MELPA package repository](https://melpa.org/)
* [Emacs Wiki](https://www.emacswiki.org/)
