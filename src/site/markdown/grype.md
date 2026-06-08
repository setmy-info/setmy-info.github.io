# Grype

## Information

`Grype` is an open-source vulnerability scanner for container images, filesystems, and `SBOM` inputs. It is commonly used in developer workstations, CI/CD pipelines, and container security workflows to identify known vulnerabilities in operating system packages and application dependencies.

### Main Functionalities and Features

* **Container Image Scanning**: Scan `Docker`, `OCI`, and related image formats.
* **Filesystem Scanning**: Analyze unpacked application directories and local filesystems.
* **`SBOM` Scanning**: Read an existing `SBOM` and detect known vulnerabilities without rescanning the original source.
* **Broad Ecosystem Coverage**: Supports major operating system and language package ecosystems.
* **Risk Prioritization**: Can incorporate `EPSS`, `KEV`, and related risk signals.
* **`OpenVEX` Support**: Helps filter and enrich vulnerability results in modern supply chain workflows.
* **CLI-first Operation**: Easy to automate in scripts, pipelines, and container scanning jobs.

### Common Developer and Security Use Cases

* Scan a container image before publishing it.
* Check a local project directory for vulnerable dependencies.
* Reuse a generated `CycloneDX` or other `SBOM` artifact for fast vulnerability detection.
* Gate `CI` pipelines on high-severity findings.
* Add vulnerability review into software supply chain controls.

## Installation

### Linux / macOS

```bash
curl -sSfL https://get.anchore.io/grype | sudo sh -s -- -b /usr/local/bin
```

### Other Installation Options

The project also documents additional installation methods such as package managers, container images, and platform-specific distribution channels.

## Configuration

Typical configuration areas include:

* output format,
* severity thresholds,
* ignore rules and policy decisions,
* vulnerability database update behavior,
* and integration with `SBOM` or `OpenVEX` based workflows.

For team usage, keep policy decisions documented so scan results remain understandable and repeatable.

## Usage, tips and tricks

### Basic Examples

```bash
grype alpine:latest
grype ./my-project
grype sbom:./sbom.json
```

### Practical Notes

* Prefer scanning in automation, not only manually.
* Scan `SBOM` files when you already produce them in the build pipeline.
* Define severity and fail / pass behavior before enforcing the tool in `CI`.
* Keep the vulnerability database reasonably fresh.
* Review findings in the context of exploitability and environment, not only raw counts.

## See also

* [Grype GitHub repository](https://github.com/anchore/grype)
* [Anchore OSS documentation](https://oss.anchore.com/docs/)
* [CycloneDX](cyclonedx.html)
* [Dependency-Track](dependency-track.html)
