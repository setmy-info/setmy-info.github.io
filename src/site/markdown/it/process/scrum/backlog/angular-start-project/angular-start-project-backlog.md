# angular-start-project backlog

## Description

There is a need for a public Git [repository]((https://github.com/setmy-info/angular-start-project)) that serves as a
template project and can be used as a starting point for new Angular projects.

To provide a **reusable** and **maintainable** Angular starter template that simplifies and standardizes the creation of
new web-based **application** projects and **websites**.

## Skills

Skills and know-how to have at some level (or willingness to learn more deeply).

1. **[Node.js](https://nodejs.org)** and **npm**
    1. Node **workspaces** (monorepo-style approach for multi-module projects)
    2. **Lerna** may be used as an alternative if npm workspaces do not work out well
2. **Angular** and related build [tools](https://angular.dev/tools/cli/build-system-migration)
    1. [esbuild](https://esbuild.github.io/)
    2. [Vite](https://vite.dev/)
3. Frontend **JavaScript** and **TypeScript**
4. **LESS** and **CSS**
5. **Git**
6. **GitHub**
7. **npmjs.com** and related public CDN providers.
8. **Vibe** coding with **Junie** AI
    1. Task list in **LISP** language

## Current State

* Repository: https://github.com/setmy-info/angular-start-project/
    * Branch: started (instead old Angular created new into new folder) in **develop** branch.
* Angular CLI generated **Angular 21** project.
* Folders in a single repo multi-module (monorepo) project:
    * **application.old** - old Angular **13.0.0** template.
    * **angular-start-project** - newly generated (ng new) Angular project.
    * **angular-start-project-style** - LESS module
    * **angular-start-project-library** - strictly from UI separated logic layer, idepended from UI layer
* Old existing web page/system/project in live/production, more or less derrived/copied from **application.old**
    * Old web page: https://setmy.info and https://www.hearandseesystems.com (Code will be given; DOM structure can be
      checked) – domain name-based multi-tenant system
    * Angular version **13.0.0**, .
    * Solution/functionality have:
        * Language change support
        * Hamburger left side menu (hidden by default)
        * Responsive divided into at least two levels (actually support is for more)
        * Menubar (Home, Articles, Contacts)
        * Content Pages (by URL)
        * Multi tenancy
            * By domain name
        * Google Material design icons are used
        * Consent popup
        * HTML/DOM structure
        * Some preparations for PWA
            * HTML Headers, icons, ...

## Required Understanding of Existing Projects

The developer must understand the following internals of the old template project and the web page project:

1. How the language change mechanism works
2. Domain name tenancy selection logic works

## High-Level Requirements

1. Software goes public under MIT license.
2. No backend rendering. No nodejs in backend.
3. Should handle language changes. Multilingual support.
4. Multitenancy support (known that it is not so much a micro frontend direction)
    1. By domain name
    2. As developer can choose the tenant for a loclhost name or similar or better solution
5. To use Less/CSS [setmy-info-less](https://github.com/setmy-info/setmy-info-less) located
   at [npmjs repository](https://www.npmjs.com/package/setmy-info-less).

## New requirements

New requirements to apply on the new template project structure – differences from old solutions.

1. Service for Component. Come up with singleton pattern services for components.

## Deadline

Deadline withing few months.

The project timeline is flexible, allowing for iterative development and adjustments.

Flexibility is limited by a fixed project deadline, which marks the final delivery date, which serves as a
non-negotiable limit.

## User Story Principles

...

## System and User Stories

### Ready

1. ...
2. ...
3. ...
4. ...
5. ...
6. ...

### Draft

1. ...
2. ...
3. ...
4. ...
5. ...
6. ...

---

## Other expectations

1. Communication in **Slack** or other.
2. Meetings in Google **meet**, Zoom or Slack.

1. Development and production helpers shell scripts writing and building with CMake, make and rpmbuild.
2. Different software domains have scripts under submodules/folders in single repo.
3. 3 times code reviews and fixes round.
4. Setup not needed, buildable project is ready. Only coding.
5. Constant communication in Slack
6. In-depth learning of tools is at the developer’s own expense.
   Given that the software is publicly available, the developer is expected not to bill for certain learning-related
   activities.
   **Billing should primarily apply to implementation work only**.

## Pending Items / Gaps

This section captures elements that have not yet been documented or reviewed.

The responsible person (assignee) must update this list with missing items, open questions, and any unclear aspects.

Missing or incomplete user stories should be identified and added.
Ask questions at any unclear aspects.
Each new or updated user story should be linked to its respective follow-up tasks and tracked separately.

The goal is to ensure nothing is overlooked before further implementation or migration.

Lühike ja selge variant

This list contains elements not yet documented. The assignee is responsible for identifying missing user stories,
clarifying questions. User stories should be created.

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
