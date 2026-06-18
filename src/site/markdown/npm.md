# npm

## Information

**npm** is the default package manager for the JavaScript runtime environment Node.js. It consists of a command line
client, also called npm, and an online database of public and paid-for private packages, called the npm registry.

## Installation

### Windows & Linux

npm comes bundled with Node.js. To install it, download and install Node.js from
the [official website](https://nodejs.org/).

To check the installed version:

```shell
node -v
npm -v
```

### Upgrade

To upgrade npm to the latest version globally:

```shell
npm install -g npm
```

## Configuration

npm configuration can be managed via the `.npmrc` file (per-project, per-user, or global).

Common configuration commands:

```shell
# Set registry
npm config set registry https://registry.npmjs.org/

# List configuration
npm config list
```

## Multi-module and Monorepo Workspaces

In the SMI ecosystem, we often use a single monorepo with multiple modules (workspaces). This allows managing
dependencies for all sub-projects from the root.

### Defining Workspaces

Workspaces are defined in the root `package.json`:

```json
{
    "name": "my-monorepo",
    "workspaces": [
        "packages/*",
        "apps/*"
    ]
}
```

### Installing Dependencies

When working with workspaces, you should generally run installation commands from the **root folder**.

**Install all dependencies for all workspaces:**

```shell
npm install
```

**Install an external dependency to a specific workspace:**

```shell
npm install <package-name> -w <workspace-name>
```

**Install an internal module as a dependency to another workspace:**

In a monorepo, `<package-name>` can also refer to another internal module (workspace) within the same repository. To
link an internal module as a dependency:

```shell
npm install <internal-package-name> -w <workspace-name>
```

npm will automatically create a symbolic link in `node_modules` of the target workspace pointing to the internal
package.

### Updating Dependencies

**Check for outdated packages across all workspaces:**

```shell
npm outdated -r
```

**Update packages:**

```shell
npm update -w <workspace-name>
```

## Usage, Tips and Tricks

### package.json vs package-lock.json

- **package.json**: Defines the project metadata and version ranges for dependencies (`^`, `~`).
- **package-lock.json**: Automatically generated for any operations where npm modifies either the `node_modules` tree,
  or `package.json`. It describes the exact tree that was generated, such that subsequent installs are able to generate
  identical trees, regardless of intermediate dependency updates. **Always commit this file to VCS.**

### npm install vs npm ci

- `npm install`: Standard way to install dependencies. It may update `package-lock.json` if version ranges in
  `package.json` allow it.
- `npm ci` (**Clean Install**): Used in CI/CD environments (like Jenkins).
    - It requires a `package-lock.json` to exist.
    - It deletes `node_modules` before installing.
    - It is faster than a regular install.
    - It never modifies `package.json` or `package-lock.json`. If they are out of sync, it fails.

```shell
# Use in Jenkins pipelines or local clean builds
npm ci
```

### Running Scripts

To run a script defined in a specific workspace from the root:

```shell
npm run <script-name> -w <workspace-name>
```

To run a script across all workspaces:

```shell
npm run <script-name> --workspaces
```

### Testing

**Run tests in a workspace:**

```shell
npm test -w <workspace-name>
```

**Run tests in all workspaces:**

```shell
npm test --workspaces
```

## See also

* [Official npm Documentation](https://docs.npmjs.com/)
* [CapacitorJS](capacitorjs.md)
* [Android Development](android.md)
* [iOS Development](ios.md)
* [CI Jenkins](it/architecture/decisions/ciJenkinsOvergitGitHuLa.md)
* [GitHub CI/CD Tips](ci-github.md)
