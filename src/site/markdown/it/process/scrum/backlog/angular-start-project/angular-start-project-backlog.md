# angular-start-project backlog

## Description

There is a need for a public Git [repository]((https://github.com/setmy-info/angular-start-project)) that serves **as a
template** project and can be used as a starting point for new Angular projects.

To provide a **reusable** and **maintainable** Angular starter template that simplifies and standardizes the creation of
new web-based **application** projects and **websites**.

In future such a template can be developed into a CLI tool for Angular projects generation.

## Goal description

To upgrade an old Angular template project to the newest Angular.
Add a root folder / URL leaving for specifically styled and designed web pages.

### Idea behind that

...

## Skills

Skills and know-how to have at some level (or willingness to learn more deeply).

1. **[Node.js](https://nodejs.org)** and **npm**
    1. Node **workspaces** (monorepo-style approach for multi-module projects)
    2. **Lerna** may be used as an alternative if npm workspaces do not work out well
2. **Angular** and related build [tools](https://angular.dev/tools/cli/build-system-migration)
    1. [esbuild](https://esbuild.github.io/)
    2. [Vite](https://vite.dev/)
3. Frontend **JavaScript** and **TypeScript**
4. **LESS** for **CSS** generation
5. **Git**
6. **GitHub**
7. **npmjs.com** and related public CDN providers.
8. **Vibe** coding with **Junie** AI
    1. Task list in **LISP** language

## Current State

* Repository: https://github.com/setmy-info/angular-start-project/
    * **develop** branch (some preparations done).
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
        * Content Pages (by/with URL)
        * Multi tenancy
            * By domain name
        * Google Material design icons are used
        * Consent popup
        * HTML/DOM structure
        * Some preparations for PWA
            * HTML Headers, icons, ...
        * Usage of Material design components
        * Miscellaneous:
            * robots.txt
            * sitemap.xml
            * [particles.js](https://github.com/marcbruederlin/particles.js) (2.0.2)

## High-Level Requirements, understanding requirements of an existing project

The developer must understand the following internals of the old template project and the web page project. Old solution
functionality is listed above. How these things are structured and how they work.

1. Software goes **public** under **MIT** license.
2. No backend rendering. No **nodejs in backend**.
3. Old functionality is carried into a new template project – listed above.

## New requirements

New requirements to apply on the new template project structure – differences from old solutions.

1. Service for Component. Come up with singleton pattern services for components.
2. To use Less/CSS [setmy-info-less](https://github.com/setmy-info/setmy-info-less) located
   at [npmjs repository](https://www.npmjs.com/package/setmy-info-less).
3. Considering switching to https://github.com/tsparticles/tsparticles instead of particles.js.
4. Separation of an app like solution from web pages like solutions. Web pages (specifically designed, promotional web
   pages).

## Other expectations

1. Communication in **Slack** or other.
2. Meetings in **Google meet**, Zoom or Slack.
3. In-depth learning of tools is at the developer’s own expense. Given that the software is publicly available, the
   developer is expected not to bill for certain learning-related activities. Billing should primarily apply to
   implementation work only.
4. Finishing with less effort than a proposal, a new task list will be created to have value to be added for the cost.
   Probably at other fields and projects.
5. Documentation creation is not the primary responsibility of the developer.
6. The responsible person (assignee) must update/suggest updating a user stories list. Missing or incomplete user
   stories should be identified and added.
7. Open questions at any unclear aspects.

### Deadline

* Deadline withing few months.
* The project timeline is flexible, allowing for iterative development and adjustments.
* Flexibility is limited by a fixed project deadline, which marks the final delivery date, which serves as a
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
