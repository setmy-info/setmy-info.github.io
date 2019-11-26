# Architecture

Why predefined architecture?

1. Most of the important is that, decision are made (you like it or not), that means some kind of plan are made.
    - More time - no need to spend time to argue, where oposide sides should prove something, prepare for proving,
    search information for proving, reading and listening eachother, misunderstanding,  etc etc

2. Bad plan is a better than no plan.

## Principles

1. *Same version*. All components should have same version, simple to remember and add ass depndency.

2. *POM similarity*. java-model, java-service and springboot-start-project are made as base and other should follow these structures 1:1 as much as possible.

3. *Standardizing and stability as mush as possible*. So third partys (private companies etc) should have possibility to make tool top on all project
possibilites - component locations in folder structure, module/component folder structure, libraries and modules, tools, frameworks used.

## Decisions

### Standard environments list

    * dev - developers and teams playground
    * atest - Automatic tests playground
    * test - (user and) acceptance test playground with fake data
    * prelive - (user and) acceptance test playground with real data
    * live - endusers playground and production

### Standard profiles

    Profiles for Maven, Spring, Micronaut etc profiles are per environment one to one. Name it as mentioned in Standard environments list.

### Versioning

    Currently used: Semantic Versioning 2.0.0

    https://semver.org/

### Decided tools, components and libraries

1. OS
1.1 Linux: in priority order (higher to lower) CentOS, Fedora linux, Debian, FreeBSD and OpenIndiana.
2. Containers
2.1 Docker, Jail and Zone.
2.2 Kubernetes for Docker. Probably should change, becase of RedHat new tools. Need to analyze these.
3 Shell
3.1 Bourne shell and use #!/bin/sh not #!/bin/bash. First one is in base installation of CentOS, Fedora, *BSD, Solaris, Debian (*buntu), OpenIndiana etc.
3.2 Therefore shell script should be not be written in "bashism" (bash way), but as much as possible in POSIX shell way.
3.3 Prefer shell first and if not possible or simplier then Python 3.x.
4. UI
4.1 because HTML has no rich standard set of components, then we need write components by our selves.
4.2 IE 11 is still in use, therefore that should be covered too.
4.3 Prefer CSS tool over JS tools to get UI results.
4.4 Peacause of http2 push method we use old style resources (css, js) loading. Possible to make (if it is not already done) tag library, that does push first for JSP or HTML loading.
4.5 Therefore and because of webpack we should support in JavaScript node packaging and 
5. Logs
5.1 Logging should go to tailable file.
5.2 Logging should be wih size limit, that means logs should be splitted after reaching limit.
6 Build tools
6.1 For Java maven
6.2 Other build tools and helpers: cmake, ant, make (GNU?)
6.3 Webpack build tool for frontend tools.
6.4 Reporting building with maven using maven site, where site have integrated reports: JavaDoc (for main and test code), pitest, OWASP dependencies check, JaCoCo unit test coverage, style check, version notes, todo notes, findbugs.
7. JavaScript (JS)
7.1 Prefer ECMAScript 6 - "Pure JS". Newer standards added a lot of other keywords and possibilities. Some of them make code reading harder!
7.2 Prefer Pure JS over TypeScript.
7.3 Prefer code without "prototype". Just create object and add properties.
7.4 Frontent JS
7.4.1 Use layered architecture: resources at bottom for data access and data fixing and normalization, service layer top on that for ...
7.4.2 Prefer two way datapinging over event dispatch-catch.
8. Java
8.1. Prefer in solutions write code withoud interfaces. Iterfaces are for framweorks or plugins, where N number of third parties should implement something.
9. Source Controll
9.1. Prefer Mercurial over GIT
10. Hibernate
11. DB: PostgreSQL, MongoDB, DGraph (?)
12. MQ: RabbitMQ, Mosquitto
13. Spring, Spring boot andMicronaut, but using as much as possible standard way (javax.*).
14. Semantic versioning: https://semver.org/
4. Solution levels

    1: Only JWT check with symmetric keys. No session cancellation (JWT revoke). Fully stateless solutions. No central solutions cache for apps. Single node solutions. App backend as GW.
    2: DB JWT check with symmetric keys. DB based session cancellation and expiration (JWT revoke). Single node solutions. App backend as GW. No central cache solutions for apps.
    3. DB JWT check with symmetric and assymetric keys. DB based session cancellation and expiration (JWT revoke). Multi node solutions. App backend as GW. No central cache solutions for apps.
    4. Central Cache and session storage. JWT and session revoke in cache systems. Multi node solutions. Multi HW servers only.
    5. Central Cache and session storage. JWT and session revoke in identiti management systems. Multi node systesm. Health checks. API GW (rate limiting, security, identity management etc). Multiple hardware (servers, network nodes, powwersuplies, UPS etc) nodes. Storage systems.

