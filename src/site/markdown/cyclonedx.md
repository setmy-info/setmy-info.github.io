# CycloneDX

## Information

`CycloneDX` is an open standard for software bill of materials (`SBOM`) and related supply chain security artifacts. It is used to describe application components, libraries, services, dependencies, and associated metadata in a machine-readable way so that build systems, security tools, and governance platforms can exchange software inventory data consistently.

### Main Functionalities and Features

* **`SBOM` Standard**: Describes software components, versions, suppliers, dependencies, and metadata.
* **Multiple Formats**: Commonly used in `JSON` and `XML`, with ecosystem support across many tools.
* **Dependency Graph Representation**: Captures not only what components exist, but also their relationships.
* **Security-oriented Metadata**: Frequently used with vulnerability, licensing, integrity, and provenance workflows.
* **Broad Ecosystem Support**: Supported by generators, scanners, package tools, build plugins, and analysis platforms.
* **Extensible Model**: Useful for software, services, containers, and modern supply chain use cases.

### Common Developer and Security Use Cases

* Generate an `SBOM` during application build.
* Exchange component inventory data between tools in a vendor-neutral format.
* Feed `SBOM` data into platforms such as `Dependency-Track`.
* Scan `SBOM` files directly with tools such as `Grype`.
* Support compliance, vulnerability management, and supply chain traceability.

## Installation

`CycloneDX` itself is a standard rather than one single runtime product. In practice, teams use:

* build plugins that generate `CycloneDX` output,
* CLI tools that create or validate `SBOM` documents,
* or platforms that import and analyze `CycloneDX` files.

Common examples include `Maven`, `Gradle`, `npm`, container tooling, and standalone `SBOM` utilities.

## Configuration

Typical configuration concerns are:

* which components to include,
* how to represent transitive dependencies,
* which metadata fields are required by policy,
* output format selection (`JSON` or `XML`),
* and where generated `SBOM` files are published or stored.

## Usage, tips and tricks

* Generate `CycloneDX` files automatically in `CI/CD`.
* Version and archive important `SBOM` artifacts together with application releases.
* Keep naming and component coordinates consistent to improve downstream matching quality.
* Validate generated `SBOM` output if it is used for compliance or external exchange.
* Treat the `SBOM` as a living release artifact, not as throwaway build output.

### Practical Workflow

1. Build the application.
2. Generate a `CycloneDX SBOM`.
3. Store it as a release artifact.
4. Import it into analysis or governance tooling.
5. Re-generate it whenever dependencies or packaging change.

## See also

* [CycloneDX official site](https://cyclonedx.org/)
* [CycloneDX specification](https://cyclonedx.org/specification/)
* [Dependency-Track](dependency-track.html)
* [Grype](grype.html)
