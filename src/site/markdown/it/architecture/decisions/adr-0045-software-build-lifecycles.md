# Architecture Decision Record (ADR)

ADR-0045: Software build lifecycles Ultra-light Architecture Decision Record (ADR)

> Use this when speed and simplicity are more important than detail.

## 1. Status:

**Draft**

## 2. Context

Different technology stacks (Java/Maven, Node.js, Python, Elixir, C++/CMake) have varying build lifecycles. To provide a
consistent developer experience and standardized CI/CD pipelines, we need to map these diverse tools to a unified set
of lifecycle phases. Maven's build lifecycle serves as the primary reference model.

## 3. Decision

Standardize software build lifecycles across the organization by adopting the following mapping table as a reference
for CI/CD pipeline definitions and local development workflows. Where a tool does not natively support a phase name or
it is reserved, project-specific aliases (e.g., in `package.json`, `mix.exs`, `Makefile`, or `pyproject.toml`) must be
used to map the harmonized name to the underlying tool command:

| Phase / Lifecycle    | Maven                       | Node.js (npm)                   | Python (poetry/pytest)             | Elixir (mix)                | CMake / Makefile             |
|----------------------|-----------------------------|---------------------------------|------------------------------------|-----------------------------|------------------------------|
| **Clean**            | `mvn clean`                 | `npm run clean`                 | `poetry run clean`                 | `mix clean`                 | `make clean`                 |
| **Validate / Lint**  | `mvn validate`              | `npm run validate`              | `poetry run validate`              | `mix validate`              | `make validate`              |
| **Compile**          | `mvn compile`               | `npm run compile`               | `poetry run compile`               | `mix compile`               | `make compile`               |
| **Resources**        | `mvn process-resources`     | `npm run resources`             | `poetry run resources`             | `mix resources`             | `make resources`             |
| **Unit Test**        | `mvn test`                  | `npm test`                      | `poetry run test`                  | `mix test`                  | `make test`                  |
| **IT Setup**         | `mvn pre-integration-test`  | `npm run pre-integration-test`  | `poetry run pre-integration-test`  | `mix pre-integration-test`  | `make pre-integration-test`  |
| **Integration Test** | `mvn integration-test`      | `npm run integration-test`      | `poetry run integration-test`      | `mix integration-test`      | `make integration-test`      |
| **IT Teardown**      | `mvn post-integration-test` | `npm run post-integration-test` | `poetry run post-integration-test` | `mix post-integration-test` | `make post-integration-test` |
| **Verify / Quality** | `mvn verify`                | `npm run verify`                | `poetry run verify`                | `mix verify`                | `make verify`                |
| **Package**          | `mvn package`               | `npm run package`               | `poetry run package`               | `mix package`               | `make package`               |
| **E2E Test**         | (Custom / Failsafe)         | `npm run e2e-test`              | `poetry run e2e-test`              | `mix e2e-test`              | `make e2e-test`              |
| **Site / Doc**       | `mvn site`                  | `npm run site`                  | `poetry run site`                  | `mix site`                  | `make site`                  |
| **Install**          | `mvn install`               | `npm run install`               | `poetry run install`               | `mix install`               | `make install`               |
| **Deploy**           | `mvn deploy`                | `npm run deploy`                | `poetry run deploy`                | `mix deploy`                | `make deploy`                |

*Note: E2E tests are exceptional as Maven does not have a native standard phase for them (often part
of `integration-test` with specific profiles).*

## 4. Rationale (Justification):

Standardization reduces the cognitive load for developers switching between projects and simplifies the maintenance of
shared CI/CD pipeline templates. By using Maven as the baseline, we leverage a well-understood and robust lifecycle
model.

## 5. Consequences, Impacts & Follow-up Actions

* All new projects should aim to implement these scripts/commands.
* CI/CD pipeline templates will be updated to use these standardized phases.
* Documentation for each platform should reference this ADR for build instructions.

https://adr.github.io/

[Architecture](../index.md)
