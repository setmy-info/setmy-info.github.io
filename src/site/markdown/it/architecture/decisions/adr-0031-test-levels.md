# Architecture Decision Record (ADR)

ADR-0031: Top level testing groups

Top-level testing groups and basic constraints and concepts.

## 1. Status

**Accepted**

## 2. Context

To describe for developers what kind of test groups exist, what is the scope or role of a test group. What should go
where and which test type to write.

## 3. Decision

Describe top-level testing groups and basic constraints and concepts by group.

* Unit tests (UT)
    * Unit is a method / function under test
    * Fast/quick tests
* Integration tests (IT)
* e2e tests (E2ET).

| Depend or can depend                                | UT  | IT      | E2ET    |
|-----------------------------------------------------|-----|---------|---------|
| Java (or other platform)                            | YES | YES     | YES     |
| JUnit                                               | YES | YES     | YES     |
| AssertJ                                             | YES | YES     | YES     |
| Mockito                                             | YES | YES     | NO      |
| Mutation testing                                    | YES | NO      | NO      |
| In memory only                                      | YES | NO      | NO      |
| WireMock                                            | NO  | YES     | NO      |
| Environment variables                               | NO  | YES     | YES     |
| (Data) Files                                        | NO  | YES     | YES     |
| Config files                                        | NO  | YES     | YES     |
| DB                                                  | NO  | YES     | YES     |
| Network                                             | NO  | YES     | YES     |
| External system emulators                           | NO  | NO (1)  | YES     |
| Cucumber / Spec by example                          | NO  | NO      | YES     |
| JUnit Suites                                        | NO  | NO      | YES (4) |
| Gatling load testing                                | NO  | NO      | YES     |
| IDE config                                          | NO  | NO      | YES (3) |
| Encrypted secrets in code (5)                       | NO  | YES (2) | YES     |
| Use testable software internals (White box testing) | YES | NO (6)  | NO (7)  |

TODO: write in better English following:

1. Prefer not to use, so mostly NO. Move them to E2ET. Manually, for development time.
1. Mostly YES, but prefer not to use.
1. If possible, avoid it, to hold the principle "Checkout code and start working."
1. If possible, avoid it. If a complicated set of tests helps, use.
1. In test code
1. Mostly no, try not to use
1. Use end points onl

* Test coverage is executed only with unit tests.
* Mutation tests are executed only with unit tests.

## 4. Rationale (Justification):

...

## 3. Consequences, Impacts & Follow-up Actions

...

---

https://adr.github.io/
