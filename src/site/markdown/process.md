# Process

## Information

A process is a defined, repeatable sequence of activities that transforms inputs into outputs to achieve a specific
goal. In software engineering and business contexts, processes provide consistency, predictability, and a basis for
improvement.

A well-defined process answers: what steps are performed, by whom, in what order, with what inputs, and producing what
outputs.

## Components of process

1. **Steps** — ordered activities that make up the process. Each step should have a clear entry condition, action,
   and exit condition.
2. **Roles** — people or systems responsible for executing steps. Roles are described using RACI:
   * **R** (Responsible) — does the work.
   * **A** (Accountable) — owns the outcome, approves the result.
   * **C** (Consulted) — provides input before or during the step.
   * **I** (Informed) — notified of progress or results.
3. **Artifacts** — versioned, traceable items produced or consumed by the process:
   * **Input artifacts** — what the process requires to start (e.g. requirements document, ticket).
   * **Output artifacts** — what the process produces (e.g. tested feature, deployment record, report).

Process produces results (artifacts).

## Introduction

Processes exist at every level — from a single developer's commit workflow to an enterprise-wide release management
process. The appropriate formality depends on the risk, team size, and regulatory context.

Lightweight processes (checklists, team conventions) suit small teams. Heavyweight processes (ITIL, CMMI) suit
regulated industries or large organizations where audit trails are mandatory.

## Usage, tips and tricks

### Process Documentation

Document processes using:

* **Flowcharts** — simple visual representation of steps and decision points.
* **BPMN** (Business Process Model and Notation) — standard notation for more detailed process modeling, tooled in
  Camunda, Bizagi, and similar.
* **Checklists** — lightweight alternative when a step-by-step list is sufficient.
* **Runbooks** — operational documentation for recurring tasks.

### Process Improvement

* **Kaizen** — continuous, incremental improvement driven by the people doing the work. Small changes, frequently.
* **PDCA** (Plan-Do-Check-Act) — iterative improvement cycle: plan a change, do it on a small scale, check results,
  act to standardize or adjust.
* **Retrospectives** — team-level process review at the end of a sprint or milestone (common in Scrum/Agile).

### When to Define a Formal Process

Define a formal process when:

* the activity is repeated frequently and inconsistency has a measurable cost,
* regulatory or audit requirements demand traceability,
* multiple people or teams need to coordinate in a defined way,
* onboarding new team members requires a documented reference.

Avoid over-formalizing low-risk, one-person, or exploratory activities — the overhead of maintaining the process
documentation outweighs the benefit.

## See also

* [BPMN specification](https://www.omg.org/bpmn/)
* [RACI matrix](https://en.wikipedia.org/wiki/Responsibility_assignment_matrix)
* [Kaizen](https://en.wikipedia.org/wiki/Kaizen)
* [PDCA](https://en.wikipedia.org/wiki/PDCA)
