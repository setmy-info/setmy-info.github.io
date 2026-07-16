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

TODO: Remove lines, those most likkelly are not relevant to other than maven. That means some things in other langiages
are already done or are not relevant at all.

| Group      | Phase / Lifecycle       | Maven                                  | Node.js (npm)                      | Python (venv + pip)                                                 | Elixir (mix)                             | CMake / Make                   |
|------------|-------------------------|----------------------------------------|------------------------------------|---------------------------------------------------------------------|------------------------------------------|--------------------------------|
| Workspace  | Bootstrap               | `mvn dependency:go-offline`            | `npm ci`                           | `python -m venv .venv && python -m pip install -r requirements.txt` | `mix deps.get`                           | `make bootstrap`               |
| Workspace  | Clean                   | `mvn clean`                            | `npm run clean`                    | `python scripts/clean.py`                                           | `mix clean`                              | `make clean`                   |
| Validation | Validate                | `mvn validate`                         | `npm run validate`                 | `python scripts/validate.py`                                        | `mix validate` *(custom)*                | `make validate`                |
| Validation | Format                  | `mvn spotless:apply`                   | `npm run format`                   | `python -m black .`                                                 | `mix format`                             | `make format`                  |
| Validation | Lint                    | `mvn checkstyle:check`                 | `npm run lint`                     | `python -m ruff check .`                                            | `mix credo`                              | `make lint`                    |
| Generation | Generate Sources        | `mvn generate-sources`                 | `npm run generate-sources`         | `python scripts/generate_sources.py`                                | `mix generate-sources` *(custom)*        | `make generate-sources`        |
| Generation | Process Resources       | `mvn process-resources`                | `npm run process-resources`        | `python scripts/process_resources.py`                               | `mix process-resources` *(custom)*       | `make process-resources`       |
| Build      | Compile                 | `mvn compile`                          | `npm run build`                    | `python -m compileall src` *(optional)*                             | `mix compile`                            | `cmake --build build`          |
| Build      | Process Classes         | `mvn process-classes`                  | `npm run process-classes`          | `python scripts/process_classes.py`                                 | `mix process-classes` *(custom)*         | `make process-classes`         |
| Test       | Generate Test Resources | `mvn generate-test-resources`          | `npm run generate-test-resources`  | `python scripts/generate_test_resources.py`                         | `mix generate-test-resources` *(custom)* | `make generate-test-resources` |
| Test       | Process Test Resources  | `mvn process-test-resources`           | `npm run process-test-resources`   | `python scripts/process_test_resources.py`                          | `mix process-test-resources` *(custom)*  | `make process-test-resources`  |
| Test       | Test Compile            | `mvn test-compile`                     | `npm run test-build`               | `python -m compileall tests` *(optional)*                           | `mix test.compile` *(custom)*            | `make test-compile`            |
| Test       | Unit Test               | `mvn test`                             | `npm test`                         | `python -m pytest`                                                  | `mix test`                               | `ctest`                        |
| Test       | Pre Integration Test    | `mvn pre-integration-test`             | `npm run pre-integration-test`     | `python scripts/pre_integration_test.py`                            | `mix pre-integration-test` *(custom)*    | `make pre-integration-test`    |
| Test       | Integration Test        | `mvn integration-test`                 | `npm run integration-test`         | `python -m pytest -m integration`                                   | `mix integration-test` *(custom)*        | `make integration-test`        |
| Test       | Post Integration Test   | `mvn post-integration-test`            | `npm run post-integration-test`    | `python scripts/post_integration_test.py`                           | `mix post-integration-test` *(custom)*   | `make post-integration-test`   |
| Test       | Pre E2E Test            | `mvn -Pe2e pre-integration-test`       | `npm run pre-e2e-test`             | `python scripts/pre_e2e_test.py`                                    | `mix pre-e2e-test` *(custom)*            | `make pre-e2e-test`            |
| Test       | E2E Test                | `mvn -Pe2e integration-test`           | `npm run e2e-test`                 | `python -m pytest -m e2e`                                           | `mix e2e-test` *(custom)*                | `make e2e-test`                |
| Test       | Post E2E Test           | `mvn -Pe2e post-integration-test`      | `npm run post-e2e-test`            | `python scripts/post_e2e_test.py`                                   | `mix post-e2e-test` *(custom)*           | `make post-e2e-test`           |
| Quality    | Coverage                | `mvn jacoco:report`                    | `npm run coverage`                 | `python -m coverage run -m pytest`                                  | `mix coveralls`                          | `make coverage`                |
| Quality    | Security                | `mvn org.owasp:dependency-check:check` | `npm audit`                        | `python -m pip_audit`                                               | `mix deps.audit` *(custom)*              | `make security`                |
| Quality    | License                 | `mvn license:check`                    | `npm run license-check`            | `python scripts/license_check.py`                                   | `mix license` *(custom)*                 | `make license`                 |
| Quality    | Verify                  | `mvn verify`                           | `npm run verify`                   | `python scripts/verify.py`                                          | `mix verify` *(custom)*                  | `make verify`                  |
| Package    | Package                 | `mvn package`                          | `npm pack`                         | `python -m build`                                                   | `mix archive.build`                      | `cpack`                        |
| Package    | SBOM                    | `mvn cyclonedx:makeAggregateBom`       | `npm run sbom`                     | `cyclonedx-py`                                                      | `mix sbom` *(custom)*                    | `make sbom`                    |
| Package    | Sign                    | `mvn gpg:sign`                         | `npm run sign`                     | `gpg --detach-sign dist/*`                                          | `mix sign` *(custom)*                    | `make sign`                    |
| Publish    | Install                 | `mvn install`                          | `npm run install-local` *(custom)* | `python -m pip install dist/*.whl`                                  | `mix archive.install`                    | `make install`                 |
| Publish    | Publish                 | `mvn deploy`                           | `npm publish`                      | `python -m twine upload dist/*`                                     | `mix hex.publish`                        | `make publish`                 |
| Deploy     | Deploy                  | `mvn cargo:deploy` *(example)*         | `npm run deploy`                   | `python scripts/deploy.py`                                          | `mix deploy` *(custom)*                  | `make deploy`                  |

### Notes

- **Maven lifecycle is the reference model** for all languages in the monorepo.
- Missing lifecycle phases in a language ecosystem SHOULD be implemented as custom scripts or build targets to preserve
  a consistent developer experience.
- **Node.js** should prefer `npm ci` in CI and `npm install` for local development.
- **Python** should prefer the built-in `venv` + `pip` toolchain. Additional package managers (Poetry, PDM, uv, etc.)
  are implementation choices, not lifecycle requirements.
- **E2E testing** is modelled as a specialization of the Integration Test lifecycle. In Maven, it is recommended to
  execute E2E tests using a dedicated profile (e.g. `-Pe2e`) and Failsafe includes patterns such as `*E2ET.java`, while
  still using the standard `pre-integration-test` → `integration-test` → `post-integration-test` phases.
- **SBOM** generation should preferably use CycloneDX or another organization-approved standard.

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
