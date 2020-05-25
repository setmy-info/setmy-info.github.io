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

* local - developer local machine
* dev - developers and teams playground
* ci (also atest) - Automatic tests playground
* testing - (user and) acceptance test playground with fake data. Keyword 'test' is Spring Boot test profile. Not to mix with them.
* prelive - (user and) acceptance test playground with real data
* live - endusers playground and production

Environments should be separated and not used in moxed and crossed way (one environemnt komponent is usind another environment komponent).
Peopel should not talk in mashine names, just with environmnet names.

### Standard profiles

Profiles for Maven, Spring, Micronaut etc profiles are per environment one to one. Name it as mentioned in Standard environments list.

### Versioning

Currently used: Semantic Versioning 2.0.0

[Sematic versioning page](https://semver.org/)

Use at development and testing time suffix: -SNAPSHOT

Currently only numbers are used. No alphabetic prefixes or suffixes.

Examples:

* At development time: 1.2.3-SNAPSHOT and after release: 1.2.3
* At development time, with build number: 1.2.3-54321-SNAPSHOT and after release: 1.2.3

### Branching

* git flow (Vincent Driessen aka [nvie], https://nvie.com/posts/a-successful-git-branching-model/)
master, default, feature, release branches
* flexible but compex internal branching schema:
N number of branches per release items - release branches
Releasing at any time, any order
Handling releases or hotfixes same way.

### Microservices and API-s

All external or third party API-s by default should be behind internal API.
* actually can be more fault tolerant
* more freedom (caching, DB, replace, re-desing external API or design, replace [later throw external out]).
* 2 types, that can be in one but clearly understandable, what can be used
** direct, that is 1:1 transfering and translating 3dp or external API
** complex or translated (strongly preferred), that is probably translating and doing many complext requests to 3dp/ex API 

### Translations

    Should be:
    - used as one or in many formats (JSON, XML, JS, Java properties, YAML, ...), that can be requested for example with GET method
    - added at compile time
    - added, loaded or used at runtime (REST or other API), and probavly cached for runtime
    - in DB
    - versioned (versions can be 1:1 withh software version os independent)
    - by application, module or API
    - use camel case JS format as key ("someApplicationView.tooltip")
    - with user UI

### Developers

    Preferred OS should be choosen for production machines and developers should use that OS as development machine.
        - learning and collecting knowhow

### Docker

    Images should based on developers maschines.
        - transferrign knowhow into Dockerfile. No differences and different thinking from developer machines.

    Organization should have its own Docker image hierarchy, consolitating security and knowhow in different hierarchy nodes by needs.

### Linux

    In priority order (higher to lower): CentOS, Fedora linux, Debian
    Follow FHS: https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html
    Follow LSB: https://refspecs.linuxfoundation.org/lsb.shtml

### Other OS

    In priority order (higher to lower): FreeBSD and OpenIndiana.

### Containers

    In priority order (higher to lower): Docker, Jail and Zone.
    Tools: Docker registry, Kubernetes for Docker. Probably should change, becase of RedHat new tools. Need to analyze these.
        (RancherOS, Helm ?)

### Front end

    LESS
    Single-Page application
    Responsive web design
    Cross-browser
        IE11 (minimum IE)
    Jasmine FW
    Karma
    3 Layer (Controller/controlling, Service, Resource/API)
        Service layer independent from Frameworks (VueJS, Angular, React etc), depndent from Axios.

### Back end

    Java, Groovy, NodeJS, Python, (Not decided: Go, C/C++)
    SpringBoot, Spring, Micronaut
    JSR-330
    3 Layer (Controller/REST/SOAP/etc, Service, DAO/API/DataSource)
    JPA (Hibernate)

### Testing

    JUnit 5
    Java + Selenium (hub and nodes)
    Cucumber

### DB

    PostgreSQL
        Tools: Liquibase
    MongoDB
    DGraph/Neo4J
    Lucene

### Layers responsibility
    1. Filters and exteption handlers
    1.1 Should do security checks, if possible and meaninful to do these here
    1.2 Error messages transformation to HTTP error codes and messages with data: tranlsation key (no error code), additional data 
    2. Controller/Resource/Scheduler
    2.1 Do security checks with calling security related service(s) before entering any (business) logic
    2.2 Data transformations for calling (business) logic services. For example DTOs to other class model data. Data mapper, transform or other services have to be called.
    2.2 Logic service calls.
    2.3 Ordinary exceptions to web excepton transformation for error message transformations (1.2)
    3. Service
    3.1 Security check services
    3.2 Data validation check services
    3.3 Data transformation services
    3.4 Logic services, data request and population services
    4. DEO/Repository/API
    4.1 Request objects from DB or from external API-s

### Decided tools, components and libraries

1. OS
1.1 MOVED
2. Containers
2.1 MOVED
2.2 MOVED
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
8.2. Java fail length up to 512 lines and line length 110.
9. Source Controll
9.1. Prefer Mercurial over GIT
10. Hibernate
11. DB: PostgreSQL, MongoDB, DGraph (?)
12. MQ: RabbitMQ (should be used, when they hide problems? Replace it with Redis?), Mosquitto
13. Spring, Spring boot andMicronaut, but using as much as possible standard way (javax.*).
14. Semantic versioning: https://semver.org/
4. Solution levels

    1: Only JWT check with symmetric keys. No session cancellation (JWT revoke). Fully stateless solutions. No central solutions cache for apps. Single node solutions. App backend as GW.
    2: DB JWT check with symmetric keys. DB based session cancellation and expiration (JWT revoke). Single node solutions. App backend as GW. No central cache solutions for apps.
    3. DB JWT check with symmetric and assymetric keys. DB based session cancellation and expiration (JWT revoke). Multi node solutions. App backend as GW. No central cache solutions for apps.
    4. Central Cache and session storage. JWT and session revoke in cache systems. Multi node solutions. Multi HW servers only.
    5. Central Cache and session storage. JWT and session revoke in identiti management systems. Multi node systesm. Health checks. API GW (rate limiting, security, identity management etc). Multiple hardware (servers, network nodes, powwersuplies, UPS etc) nodes. Storage systems.
 