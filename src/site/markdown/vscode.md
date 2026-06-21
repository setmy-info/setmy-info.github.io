# VSCode

## Information

Visual Studio Code (VS Code) is a lightweight, cross-platform source code editor developed by Microsoft. It is built
on the Electron framework and supports a rich extension ecosystem covering languages, debuggers, linters, themes, and
remote development workflows.

Key characteristics:

* IntelliSense code completion, syntax highlighting, and refactoring for many languages out of the box.
* Integrated Git support and diff viewer.
* Built-in debugger with breakpoints and variable inspection.
* Remote development via SSH, containers, or WSL through official extensions.
* Large marketplace of community and vendor extensions.

## Installation

### Rocky Linux / Fedora

Import the Microsoft GPG key and add the repository, then install:

```shell
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code
```

### Debian / Ubuntu

```shell
sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt-get update
sudo apt-get install -y code
```

### Windows

Download and run the installer from [code.visualstudio.com](https://code.visualstudio.com/).

Or via winget:

```powershell
winget install Microsoft.VisualStudioCode
```

### Verify

```shell
code --version
```

## Configuration

User settings are stored in `settings.json`. Open it via **File → Preferences → Settings → Open Settings (JSON)** or
press `Ctrl+Shift+P` and type `Open User Settings JSON`.

Useful settings:

```json
{
    "workbench.tree.indent": 32,
    "editor.tabSize": 4,
    "editor.formatOnSave": true,
    "editor.rulers": [120],
    "editor.renderWhitespace": "boundary",
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true,
    "files.exclude": {
        "**/.git": true,
        "**/node_modules": true,
        "**/target": true
    }
}
```

Workspace-level settings go in `.vscode/settings.json` at the project root and override user settings.

## Usage, tips and tricks

### Key Shortcuts

| Action                  | Shortcut          |
|-------------------------|-------------------|
| Command Palette         | `Ctrl+Shift+P`    |
| Quick file open         | `Ctrl+P`          |
| Integrated terminal     | Ctrl+\`           |
| Toggle sidebar          | `Ctrl+B`          |
| Multi-cursor (add)      | `Alt+Click`       |
| Format document         | `Ctrl+Shift+I`    |
| Go to definition        | `F12`             |
| Find in files           | `Ctrl+Shift+F`    |
| Rename symbol           | `F2`              |

### Recommended Extensions

| Extension      | Purpose                                                      |
|----------------|--------------------------------------------------------------|
| ESLint         | JavaScript/TypeScript linting inline in the editor           |
| Prettier       | Code formatter — integrates with formatOnSave                |
| GitLens        | Enhanced Git blame, history, and diff views                  |
| Remote - SSH   | Edit files on remote servers as if they were local           |
| EditorConfig   | Applies `.editorconfig` rules in the editor                  |
| Java Extension Pack | Full Java support (Language Server, Debugger, Maven) |

### Workspace Snippets

Place custom code snippets in `.vscode/<language>.json` to share them with a team via version control.

## See also

* [VS Code official documentation](https://code.visualstudio.com/docs)
* [VS Code extension marketplace](https://marketplace.visualstudio.com/vscode)
* [EditorConfig](editorconfig.md)
* [ESLint](https://eslint.org/)
* [Remote development overview](https://code.visualstudio.com/docs/remote/remote-overview)
