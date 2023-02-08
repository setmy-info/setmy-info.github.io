# CI should not start release build by VCS tag event

CI should set and push VCS tag **after successful build**. VCS should not tell a lie.

Build:

* compile
* test (automatic, unit, integration, ...)
* code checks (Sonarqube, findbug, stopbug, vulnerability, ...)
* formatters (if any)

Any step in build can fail, but tag is already set in VCS, if used tag event for releasing. So VCS is already corrupted
is **lying** to everybody (third party, system, person at next to you)!
