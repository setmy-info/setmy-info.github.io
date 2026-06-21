# Node

## Information

Node.js is a cross-platform, open-source JavaScript runtime environment that executes JavaScript code outside a web
browser. It is built on Chrome's V8 JavaScript engine and uses an event-driven, non-blocking I/O model, making it
efficient and suitable for scalable network applications.

### LTS and Non-LTS Versions

Node.js follows a predictable release cycle with two release types:

**Even-numbered major versions (e.g., 18, 20, 22, 24)** are LTS (Long-Term Support) releases:

* They enter **Active LTS** 6 months after release and receive active maintenance for 18 months total.
* Then they move to **Maintenance LTS** for an additional 12 months with critical fixes only.
* Total support lifetime: approximately 30 months.
* **Recommended for production use.** These versions prioritize stability over new features.

**Odd-numbered major versions (e.g., 19, 21, 23)** are Current (non-LTS) releases:

* They are supported for only 6 months.
* They contain the latest features but are not recommended for production.
* Suitable for experimentation, testing new language features, or short-lived tooling projects.

Release phases for an LTS version:

| Phase           | Duration       | Description                                  |
|-----------------|----------------|----------------------------------------------|
| Current         | 6 months       | Active development, new features added       |
| Active LTS      | 12 months      | Bug fixes, security patches, performance     |
| Maintenance LTS | 12 months      | Critical fixes and security patches only     |
| End-of-Life     | —              | No further updates, do not use in production |

Typical guidance:

* Use the latest **Active LTS** version for new production projects.
* Avoid odd-numbered Current versions for anything intended to run longer than a few months.
* Upgrade before a version reaches **End-of-Life (EOL)** to remain eligible for security patches.
* Check the current release schedule at the [Node.js releases page](https://nodejs.org/en/about/previous-releases).

## Installation

### NVM (Node Version Manager) — Linux / macOS

NVM is the recommended tool for managing multiple Node.js versions on a single machine. It allows installing, switching,
and removing Node.js versions without system-wide changes.

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# Restart shell or source profile
source ~/.bashrc
nvm --version
```

Install and use a specific Node.js version:

```shell
# Install latest LTS
nvm install --lts
# Install a specific LTS version
nvm install 22
# Use a version in the current shell
nvm use 22
# Set the default for new shells
nvm alias default 22
# List installed versions
nvm ls
# List available LTS versions remotely
nvm ls-remote --lts
```

### Rocky Linux / CentOS

Using NodeSource repository (recommended for server installs when you need a specific LTS):

```shell
# Node.js 22 LTS
curl -fsSL https://rpm.nodesource.com/setup_22.x | sudo bash -
sudo dnf install -y nodejs
node -v
npm -v
```

Using system packages:

```shell
sudo dnf install -y nodejs npm
```

### Fedora

```shell
sudo dnf install -y nodejs npm
```

For a specific LTS version via NodeSource:

```shell
curl -fsSL https://rpm.nodesource.com/setup_22.x | sudo bash -
sudo dnf install -y nodejs
```

### Debian / Ubuntu

```shell
# NodeSource for latest LTS
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
npm -v
```

### FreeBSD

```shell
pkg install -y node npm
# Or a specific LTS version
pkg install -y node22 npm-node22
```

### Windows

Download and install the LTS release directly from [nodejs.org](https://nodejs.org/).

Or use **nvm-windows** (separate project from nvm):

```powershell
winget install CoreyButler.NVMforWindows
nvm install lts
nvm use lts
```

Or use **fnm** (Fast Node Manager, cross-platform, written in Rust):

```powershell
winget install Schniz.fnm
fnm install --lts
fnm use lts
```

### Verify Installation

```shell
node -v
npm -v
npx -v
```

## Configuration

Node.js itself requires no configuration file for basic use. The most important runtime configuration is done through
environment variables:

* `NODE_ENV` — controls the runtime mode (`development`, `production`, `test`).
* `NODE_PATH` — extra module search directories (rarely needed with modern npm).
* `NODE_OPTIONS` — default command-line flags applied to every `node` process.

```shell
# Run in production mode
NODE_ENV=production node app.js
# Increase heap memory limit
NODE_OPTIONS="--max-old-space-size=4096" node app.js
```

### .nvmrc

Pin the project's Node.js version by placing a `.nvmrc` file in the project root:

```
22
```

Team members and CI pipelines then run `nvm use` to switch to the correct version automatically.

## Usage, tips and tricks

### Switching Versions with NVM

```shell
# Check current version
node -v
# Switch to another installed version
nvm use 20
# Automatically use the version from .nvmrc
nvm use
```

### CommonJS vs ES Modules

Node.js supports both module systems. Choose one consistently within a project.

**CommonJS** (default unless `"type": "module"` is set in `package.json`):

```javascript
const fs = require('fs');
module.exports = { myFunction };
```

**ES Modules** (use `.mjs` extension or set `"type": "module"` in `package.json`):

```javascript
import fs from 'fs';
export { myFunction };
```

### Running Scripts

```shell
# Run a file
node script.js
# Pass arguments
node script.js arg1 arg2
# Open the REPL
node
```

### Useful Built-in Globals

* `process` — current process info, environment variables (`process.env`), exit code.
* `__dirname` / `__filename` — directory and path of the current file (CommonJS only).
* `Buffer` — binary data operations.
* `require()` / `module.exports` — CommonJS module loading.

### npx

`npx` is bundled with npm and executes a package binary without a global install:

```shell
# Run a one-off command without installing globally
npx create-react-app my-app
npx eslint --init
```

### Debugging

```shell
# Start with built-in inspector
node --inspect app.js
# Break at first line
node --inspect-brk app.js
```

Then open `chrome://inspect` in Chrome or connect from VS Code to attach the debugger.

## See also

* [Node.js official site](https://nodejs.org/)
* [Node.js release schedule](https://nodejs.org/en/about/previous-releases)
* [NVM — Node Version Manager](https://github.com/nvm-sh/nvm)
* [fnm — Fast Node Manager](https://github.com/Schniz/fnm)
* [npm](npm.md)
* [Node start project](node-start-project.md)
* [JavaScript](javascript.md)
