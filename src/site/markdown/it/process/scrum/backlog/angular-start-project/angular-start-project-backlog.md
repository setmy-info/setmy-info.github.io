# angular-start-project backlog

## Description

There is a need for a public Git [repository]((https://github.com/setmy-info/angular-start-project)) that serves as a
template project and can be used as a starting point for
new Angular projects.

To provide a **reusable** and **maintainable** Angular starter template that simplifies and standardizes the creation of
new projects.

## Skills

Skills and know-how to have at some level (or willingness to learn more deeply).

1. **[Node.js](https://nodejs.org)** and **npm**
2. **Angular** and related build [tools](https://angular.dev/tools/cli/build-system-migration)
    1. [esbuild](https://esbuild.github.io/)
    2. [Vite](https://vite.dev/)
3. **JavaScript** and **TypeScript**
4. **Git**
    1. Git **workspaces** (monorepo-style approach for multi-module projects)
    2. Lerna may be used as an alternative if npm workspaces do not work out well
5. **GitHub**
6. **npmjs.com** and related public CDN providers.

## Current State

* Branch: started in **develop** branch.
* Angular CLI generated **Angular 21** project.
* Folders:
    * xxx
    * xxx
    * xxx
    * xxx
    * xxx
    * xxx
* Old veb page
    * Angular version XXX
    * Solution have:
        * Language change support
        * Hamburger left side menu (hidden by default)
        * Responsive divided into at least 3 levels
        * Menubar

## Requirements

... Language changes support
... Multitenant (not so much micro), developer work in context of each
... To use Less/CSS [setmy-info-less](https://github.com/setmy-info/setmy-info-less) located at
npmjs [repository](https://www.npmjs.com/package/setmy-info-less).



---

## Software development services expected

1. Development and production helpers shell scripts writing and building with CMake, make and rpmbuild.
2. Different software domains have scripts under submodules/folders in single repo.
3. 3 times code reviews and fixes round.
4. Setup not needed, buildable project is ready. Only coding.
5. Constant communication in Slack

## Deadline

Withing few months. Best price proposal wins.

## Prerequisites and requirements

1. Repository: **git@xxxx** in [GitHub](https://github.com/xxxxxxxx)
2. Branch: **develop | master | epic**
3. All rights to code goes to buyer. Software goes public under MIT license.
4. The work is done under a contractor agreement, not an employment contract.
5. No documentation required.

## Goal description

...

### Idea behind that

...

## Ready

1. ...
2. ...
3. ...
4. ...
5. ...
6. ...

## Draft

1. ...
2. ...
3. ...
4. ...
5. ...
6. ...

1. Prepare folder structure (like modulith) in monorepo for different software component areas (submodules)
2. Prepare CMake files as done for other similar submodules
3. Fix the Bourne shell scripts where variable assignment using command output occurs
4. Make build and build output rpm installation should install software correctly

1. Submodules are: **term**, **pki**, **crm**, **infra**, **python**, **jail**, **packages**, **base**, **workstation**,
   **vcs**, **cloud**, **virtualization**, **tools**
2. Example sub modules are: **docker**, **diskless**, **selenium**
3. All similar ETC_LOCATION=`smi-localhost-location` should be changed to ETC_LOCATION=$(smi-localhost-location)
4. Only folder structure preparation, no existing file moves needed.

---

Description / Purpose
Project Current State
Required Skills
High-Level Requirements
User Story Principles
Scope (In / Out)
Quick Start
Contribution Expectations

Minimaalne info, mida arendajatel on veel vaja

Arvestades, et:

Node.js ja Angular tööpõhimõtted on eeldatavad teadmised

tegemist on template / starter projektiga

rõhk on lihtsusel ja pragmaatikal

1. Project Scope (Intentional Limitations)

👉 Väga oluline, isegi kui kõik muu on minimaalne

What the project intentionally does not cover

What problems it is not trying to solve

Näide:

This project intentionally avoids enterprise-level abstractions and complex configurations.

2. Decision Boundaries

👉 Et arendajad teaksid, kus on vabadus

Which parts are expected to change

Which principles should remain stable

Näide:

Tooling choices may evolve. Core principles and the simplicity-first approach should remain unchanged.

3. Contribution Principles (not process)

👉 Ilma protsessita, ainult suund

Small changes

Minimal scope

No speculative features

Näide:

Changes should be incremental, minimal, and aligned with the defined principles.

4. Target Audience

👉 Aitab vältida valesti kasutamist

Näide:

This template is intended for experienced developers who are familiar with Angular and Node.js fundamentals.

5. Ownership & Direction

👉 Väga alahinnatud, aga oluline

Who provides direction

Who resolves ambiguity

Näide:

Functional and strategic direction is provided by analysts, architects, and product owners.

Mida teadlikult ei ole vaja

✔ How to start
✔ Installation steps
✔ Angular basics
✔ Tool documentation
✔ Detailed processes

➡️ Kõik see on teadlikult delegeeritud olemasolevale standardteadmisele.

Kokkuvõte

Sul on väga selge filosoofia:

Assume competence

Avoid duplication

Document intent, not tutorials

See teeb dokumendi:

lühikeseks,

ausaks,

arendajate suhtes lugupidavaks.

Kui tahad, võin aidata:

sõnastada explicit statement’i, et miks “How to start” puudub,

või panna kogu selle asja üheks väga puhtaks README.md-ks.

Siin on selge ja neutraalne ingliskeelne sõnastus, mis väljendab täpselt sinu mõtet:
fookus ülekandmisel, mitte ümbertegemisel või refaktoreerimisel; nõuded on juba kõrgtasemel kirjas.

Migration Focus

Certain elements will be transferred from an existing project.

The focus is on identifying what needs to be carried over, not on refactoring or redesigning.

Transferred components should remain functionally and structurally close to their original form.

Requirements and constraints for the migration are defined in the High-Level Requirements section.

Any refactoring or improvement should be explicitly justified and is not part of the default scope.

Lühem variant

Elements from an existing project will be carried over as-is, with minimal changes and no refactoring by default.

Veidi ametlikum

The migration aims to preserve existing behavior and structure.

Changes beyond direct transfer are considered out of scope unless explicitly required.

Mida see hästi teeb

Väldib “salajast refaktoreerimist”

Seob otseselt High-Level Requirements-iga

Jätab ruumi eranditele, aga ainult teadlikult

Kui tahad, võin aidata ka:

koostada konkreetse checklist’i (what to migrate),

või siduda selle Project Current State sektsiooniga.

Migration / Transfer

Elements from an existing project will be carried over as-is.

Focus is on direct transfer, not refactoring or redesign.

Transferred components should retain their original behavior and structure.

Requirements and constraints for the transfer are defined in the High-Level Requirements section.

Any improvements or refactoring beyond the direct transfer must be explicitly justified and are out of scope by default.

New Features / Expectations

This section outlines features or functionality that are expected to be added or improved beyond what is migrated.

These features should align with project principles: simplicity, minimal effort, and incremental delivery.

New features are prioritized according to product vision and guidance from analysts, architects, and product owners.

Implementation should follow the same deliberately minimal and pragmatic approach as existing principles.

💡 Näpunäide:

Migration / Transfer = “mis tuleb üle” (stabiilne, ei muuda põhimõtteid)

New Features / Expectations = “mis tuleb juurde” (pragmatiline, järgib sama printsiipi)

Kui soovid, võin järgmises sammus koostada täieliku README skeletoni, kus kõik seni kokku pandud sektsioonid:

Description

Current State

Skills

High-Level Requirements

User Story Principles

Migration / Transfer

New Features / Expectations

Scope / Boundaries

Contribution Principles

Target Audience / Ownership

See annaks täieliku minimaalse arendajadokumentatsiooni.

Kas soovid, et teeksin selle kohe valmis?

Pending Items / Gaps

This section captures elements that have not yet been documented or reviewed.

The responsible person (assignee) must update this list with missing items, open questions, and any unclear aspects.

Missing or incomplete user stories should be identified and added to JIRA for proper tracking.

Each new or updated user story should be linked to its respective follow-up tasks and tracked separately.

The goal is to ensure nothing is overlooked before further implementation or migration.

Lühike ja selge variant

This list contains elements not yet documented. The assignee is responsible for identifying missing user stories,
clarifying questions, and creating corresponding JIRA tasks for tracking.

Hoiab fookuse täiendamisel ja jälgimisel, mitte implementeerimisel

Sobib ideaalselt “To Be Completed” sektsiooniks README-s või backlogis

Võib lisada ka tabeli või nimekirja veergudega:

Element / Feature

Status (Missing / Partially Documented)

Responsible

JIRA Ticket

Notes / Questions

Timeline
The project timeline is flexible, allowing for iterative development and adjustments.
Flexibility is limited by a fixed project deadline, which marks the final delivery date.
While short-term plans and priorities may evolve, all work must ultimately align with the established end date.
Timeline is flexible but bounded by a fixed project deadline. Iterative adjustments are allowed within this timeframe.

Ametlik / guideline-stiil
Development should follow an iterative and adaptive approach.
The project has a defined end date, which serves as a non-negotiable limit.
Planning and execution must balance flexibility with the requirement to deliver on time.

No backend rendering.
