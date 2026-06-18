# GitHub CI/CD Tips and Tricks

While Jenkins is the primary CI/CD tool for SMI projects, we often interact with GitHub Actions for public repositories
or specific automation tasks.

## Docker Images in CI

Docker is the cornerstone of our CI strategy. It ensures that the build environment matches the developer environment.

### Using Official and Custom Images

- **No "Official" Google SDK Image**: Be aware that Google does not provide a pre-built Docker image for the Android
  SDK.
- **Community Standards**: Use widely accepted community images like `cimg/android` for general tasks.
- **Prefer SMI Images**: If your organization maintains its own Docker hierarchy (e.g., based on Rocky Linux), always
  use those for production builds to ensure parity with developer machines.
- **Specific Versions**: Never use `latest`. Always use a concrete tag (e.g., `cimg/android:2024.01` or
  `your-org/android-sdk:34-jdk17`) to ensure build reproducibility.
- **Minimal Images**: For deployment stages, use Alpine-based images to reduce transfer time and security surface.

### Building with Docker

In GitHub Actions, you can run steps inside a container:

```yaml
jobs:
    build:
        runs-on: ubuntu-latest
        container:
            image: cimg/android:2024.01
        steps:
            -   uses: actions/checkout@v4
            -   run: npm ci
            -   run: npm test
```

### Docker-in-Docker (DinD) vs. Socket Binding

- **Socket Binding**: Binding `/var/run/docker.sock` is preferred for speed if you need to build other images during the
  CI process (on self-hosted runners).
- **DinD**: Use only if absolute isolation is required, but be aware of performance overhead.

Example (DinD service):

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    services:
      docker:
        image: docker:dind
        options: --privileged
    steps:
      - uses: actions/checkout@v4
      - run: docker info
```

## GitHub Actions Tips

### Triggers and Filtering

Avoid running CI on every minor change. Use path filtering to save resources:

```yaml
on:
    push:
        branches: [ master, develop ]
        paths:
            - 'src/**'
            - 'package.json'
            - '.github/workflows/**'
```

### Secrets Management

- **Environment Secrets**: Use GitHub Environments to manage secrets for different stages (dev, test, prod).
- **Naming Convention**: Use uppercase with underscores, prefixed with `SMI_` (e.g., `SMI_DOCKER_PASSWORD`).
- **No Plaintext**: Never log secrets. GitHub automatically masks them, but be careful with base64 encoded strings.

### Environment Variables

Standardize environment variables across Jenkins and GitHub:

- `CI=true`
- `SMI_VERSION=$(cat version.txt)`
- `SMI_BUILD_NUMBER=${{ github.run_number }}`

### Caching for Speed

Always use caching for `node_modules`, Gradle, and Maven dependencies:

```yaml
-   name: Cache npm modules
    uses: actions/cache@v4
    with:
        path: ~/.npm
        key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
        restore-keys: |
            ${{ runner.os }}-node-
```

## Workflows

### Multi-workspace Projects (npm)

When working with npm workspaces, use the `--workspaces` flag in your CI scripts to ensure all modules are tested:

```yaml
-   run: npm ci
-   run: npm test --workspaces
```

### Android/iOS Builds

- **Android**: Use a container with the Android SDK. Ensure `gradlew` is executable.
- **iOS**: Must use `macos-latest` runners. Be aware of the limited concurrency and higher cost of macOS runners. Use
  Fastlane for automation.

## See also

* [Jenkins CI Decisions](it/architecture/decisions/ciJenkinsOvergitGitHuLa.md)
* [npm Monorepo Management](npm.md)
* [Android Development](android.md)
* [iOS Development](ios.md)
* [Docker Decisions](it/architecture/decisions/index.md#docker)
