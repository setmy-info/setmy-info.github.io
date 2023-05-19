# Jenkins CI over GitHuLa and GitLab (or similar)

Jenkins with Jenkins pipelines is main CI/CD tool.

GitHuLa (GitHub, GitLab) are relatively new tools, comparing to Jenkins (+ Hudson) history - **un-stability** (today
works, tomorrow not).

Jenkins handles/develops/implements Jenkins (pipeline) file functionality (mostly) by themselves. Main modules ar from
them. GitHub doesn't (Marketplace aka third party modules). Same un-stability. **Learning time** and **relearning**
after "marketplace module" is changed.

Sel-managed in-house Jenkins give more flexibility in error cases.

Example:

* GitHub gave at random point for a fev days: "Unknown host repo.osgeo.org".
