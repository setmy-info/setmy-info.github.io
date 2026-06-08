# Dependency-Track

## Information

Dependency-Track is an open-source software supply chain security platform focused on continuous `SBOM` analysis. In practice, it is used to ingest software bill of materials data, monitor component risk over time, correlate vulnerabilities, and help teams reduce exposure across applications, services, and product portfolios.

### Main Functionalities and Features

* **Continuous `SBOM` Analysis**: Tracks component inventories over time instead of treating analysis as a one-time scan.
* **Vulnerability Correlation**: Maps components and versions to known vulnerabilities and related risk intelligence.
* **Policy and Risk Visibility**: Helps security and engineering teams review risk by project, portfolio, component, and severity.
* **Standards-Based `SBOM` Support**: Commonly used together with `CycloneDX` and similar software inventory workflows.
* **Portfolio and Project Views**: Useful when one organization needs to monitor many applications and teams centrally.
* **Notifications and Integrations**: Can be integrated with build pipelines, ticketing, and operational workflows.
* **REST API and Automation**: Supports automated uploads, reporting, and synchronization from CI/CD or external systems.

### Common Developer and DevSecOps Use Cases

* Upload an `SBOM` from a `CI` pipeline after each build.
* Continuously monitor third-party dependencies used by internal applications.
* Track vulnerable components across many services in one central platform.
* Support software composition analysis (`SCA`) and supply chain governance processes.
* Feed risk findings into remediation, compliance, or reporting workflows.

## Installation

### Docker / Container-based Setup

Dependency-Track is commonly deployed as a containerized application together with its required storage services. For local evaluation or team environments, start with the official deployment guidance and version-specific release notes from the project site.

Typical high-level steps:

1. Provision the required runtime and database services.
2. Start the `Dependency-Track` API / frontend components.
3. Configure authentication, notification, and external vulnerability data sources as needed.
4. Upload a test `SBOM` and verify project creation and finding visibility.

### Practical Notes

* Prefer container or orchestrated deployment for reproducibility.
* Keep vulnerability feeds, database sizing, and retention in mind for larger portfolios.
* Plan access control and API token handling before connecting automated pipelines.

## Configuration

Typical areas to configure:

* authentication and user access,
* portfolio / project structure,
* `SBOM` ingestion method,
* notification and webhook behavior,
* vulnerability source settings,
* data retention and operational monitoring.

For real environments, keep configuration versioned and document how `SBOM` uploads, access policies, and alert handling are governed.

## Usage, tips and tricks

* Treat `Dependency-Track` as a continuous monitoring platform, not only as a build-time scanner.
* Prefer automated `SBOM` uploads from `CI/CD` instead of manual imports.
* Use stable project naming and version conventions so portfolio reporting stays clean.
* Define ownership for remediation so findings become operationally actionable.
* Review license, policy, and vulnerability views together when using the platform for supply chain governance.

### Typical Workflow

1. Generate an `SBOM` from the application build.
2. Upload it into `Dependency-Track`.
3. Review correlated vulnerabilities and affected components.
4. Prioritize remediation based on severity, exploitability, and business criticality.
5. Re-upload updated `SBOM` data after dependency changes.

## See also

* [Dependency-Track official site](https://dependencytrack.org/)
* [OWASP Dependency-Track on GitHub](https://github.com/DependencyTrack/dependency-track)
* [CycloneDX](cyclonedx.html)
* [Grype](grype.html)
