# OSV-Scanner

## Information

`OSV-Scanner` is an open-source vulnerability scanner from Google that checks project dependencies, lockfiles, source trees, container images, and related artifacts against the `OSV` vulnerability database. In practice, it is used by developers and security teams to detect known vulnerabilities early, work with open vulnerability data, and integrate dependency risk checks into local workflows and `CI/CD` pipelines.

### Main Functionalities and Features

* **Dependency and Lockfile Scanning**: Detects vulnerable packages from supported manifests and lockfiles across multiple ecosystems.
* **Source Directory Scanning**: Recursively scans repositories and source trees for supported package metadata.
* **Container Image Scanning**: Analyzes container images for vulnerable operating system packages and language-specific dependencies.
* **Official `OSV` Database Frontend**: Uses the open `OSV.dev` vulnerability database and related ecosystem data.
* **Offline Scanning Support**: Can work with downloaded local vulnerability databases when network access is limited.
* **Guided Remediation**: Offers remediation suggestions and related upgrade guidance for selected ecosystems.
* **License Scanning**: Can check dependency license information using ecosystem metadata.
* **CLI-first Automation**: Fits well into scripts, developer workstations, and `CI` pipelines.

### Common Developer and DevSecOps Use Cases

* Scan a repository before merging or releasing changes.
* Check a container image for known package vulnerabilities.
* Run dependency vulnerability scans in `CI/CD` without adopting a heavyweight platform.
* Use offline databases for restricted or air-gapped environments.
* Combine vulnerability review with remediation planning for supported ecosystems.

## Installation

### Prebuilt Binary

The recommended installation method is usually to download a prebuilt binary from the project releases for your platform.

### Build with Go

If you want to build from source, the project documents a `Go`-based installation path:

```bash
go install github.com/google/osv-scanner/v2/cmd/osv-scanner@latest
```

### Practical Notes

* Prefer a pinned version in automation instead of always pulling the latest release.
* Verify which `OSV-Scanner` major version your workflow expects, especially when older `V1` material still exists online.
* In restricted environments, plan how offline database downloads and updates will be managed.

## Configuration

Typical configuration concerns include:

* scan target type such as source tree, lockfile, or container image,
* online versus offline database usage,
* severity or remediation expectations in automation,
* supported package ecosystem coverage for the repositories you scan,
* and handling of external services such as `OSV.dev` and related metadata APIs.

For team environments, document which commands are mandatory in local development and `CI`, how findings are triaged, and when remediation suggestions may be applied automatically or only reviewed manually.

## Usage, tips and tricks

### Basic Examples

```bash
osv-scanner scan source -r /path/to/project
osv-scanner scan image my-image-name:tag
osv-scanner --offline --download-offline-databases ./path/to/project
osv-scanner --licenses path/to/repository
```

### Practical Notes

* Run scans close to where dependency changes happen so vulnerabilities are discovered early.
* Use offline mode deliberately when environments cannot reach external services.
* Validate ecosystem and lockfile support before making the tool a hard gate in `CI`.
* Treat guided remediation as helpful automation, but review proposed upgrades before applying them broadly.
* For container scanning, test against the actual base images and artifact types used in production.

## See also

* [OSV-Scanner GitHub repository](https://github.com/google/osv-scanner)
* [OSV-Scanner documentation](https://google.github.io/osv-scanner/)
* [OSV.dev](https://osv.dev/)
* [Grype](grype.html)
* [CycloneDX](cyclonedx.html)