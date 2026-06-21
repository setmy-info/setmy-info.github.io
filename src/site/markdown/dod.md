# Definition of Done

## Information

The **Definition of Done (DoD)** is a shared agreement within a Scrum team (developers, QA, and stakeholders) that
defines the criteria every Product Backlog Item (PBI) or increment must satisfy before it can be considered complete.
It is not a checklist per item — it is a standing quality gate applied to every item the team delivers.

DoD differs from **Acceptance Criteria**:

* **Acceptance Criteria** — conditions specific to one user story that define when that story meets business requirements.
* **Definition of Done** — team-wide quality standards applied to every story, regardless of its content.

A strong DoD prevents "done but not really done" situations where work passes sprint review but later requires rework
due to skipped quality steps.

### Typical DoD Checklist

* Code is written, reviewed, and approved (pull request merged).
* Automated unit and integration tests are written and passing.
* Code coverage meets the agreed threshold.
* Static analysis / linting passes without new warnings.
* Documentation (code comments, API docs, or wiki) is updated.
* Feature is deployed to a staging or integration environment.
* Acceptance criteria for the story are verified and signed off.
* No known critical or high-severity defects introduced.
* Performance and security considerations reviewed if applicable.

### Team Agreement

The DoD is owned by the team, not by the Scrum Master or Product Owner alone. It should be:

* visible (posted in the team space or wiki);
* revisited regularly (at retrospectives) to raise the quality bar over time;
* agreed by the whole team — adding a new criterion requires consensus.

## Usage, tips and tricks

* Start with a minimal DoD that the team can actually meet each sprint; add criteria as the team matures.
* If an item does not meet the DoD at sprint end, it goes back to the backlog — it is not "almost done."
* Use the DoD review checklist as part of the code review template.
* For distributed teams, make the DoD part of the pull request description template.

## See also

* [Scrum Guide — Definition of Done](https://scrumguides.org/scrum-guide.html#increment)
* [Agile Manifesto](agile-manifesto.md)
* [Kanban](kanban.md)
