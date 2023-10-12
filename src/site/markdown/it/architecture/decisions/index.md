# Decisions and principles

## Decisions

### Microservices and API-s

All external or third party API-s by default should be behind internal API.

* actually can be more fault-tolerant
* more freedom (caching, DB, replace, re-desing external API or design, replace [later throw external out]).
* 2 types, that can be in one but clearly understandable, what can be used
  ** direct, that is 1:1 transferring and translating 3dp or external API
  ** complex or translated (strongly preferred), that is probably translating and doing many complex requests to 3dp/ex
  API

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

Preferred OS should be chosen for production machines, and developers should use that OS as a development machine.

- learning and collecting know-how

IDE - same IDE without configuration changes for all developers

That means:

- install
- start working

Instead:

- install
- remember to find documentation
- read documentation
- configure by documentation
- start working

### Docker

    Images should based on developers maschines.
        - transferrign knowhow into Dockerfile. No differences and different thinking from developer machines.

    Organization should have its own Docker image hierarchy, consolitating security and knowhow in different hierarchy nodes by needs.

### Linux

In priority order (higher to lower): CentOS, Fedora linux, Debian

Follow FHS: https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html

Follow LSB: https://refspecs.linuxfoundation.org/lsb.shtml

By setmy.info standards, all packages should be unpacked (if possible) directly under /opt folder.

Examples:

- /opt/cmake-3.17.1-Linux-x86_64
- /opt/jdk-14.0.1
- /opt/firefox
- /opt/node-v12.18.1-linux-x64
- /opt/apache-maven-3.6.3

### Other OS

    In priority order (higher to lower): FreeBSD and OpenIndiana.

### Containers

    In priority order (higher to lower): Docker, Jail and Zone.
    Tools: Docker registry, Kubernetes for Docker. Probably should change, becase of RedHat new tools. Need to analyze these.
        (RancherOS, Helm ?)

### Front end

* Angular
* LESS
* Single-Page application
* PWA
* Responsive web design
* Cross-browser
    * IE11 (minimum IE)
* Jasmine FW
* Karma
* 3 Layer (Controller/controlling, Service, Resource/API)
    * Service layer independent of Frameworks (VueJS, Angular, React etc.), dependent on Axios (browsers' support
      **fetch**).

### Back end

* Java, Groovy, Python, C/C++
* SpringBoot, Spring
* JSR-330
* 3 Layer (Controller/REST/SOAP/etc., Service, DAO/API/DataSource)
* JPA (Hibernate)
* Log4j2

3 modules (Application, implementation (services), models (also interfaces, exceptions, VO, DTO-s))

### Testing

* JUnit 5
* AssertJ
* Mockito
* Java + Selenium (hub and nodes)
* Cucumber

### DB

* PostgreSQL/Postgis
    * Tools: Liquibase
* MongoDB
* DGraph/Neo4J
* Lucene

### Layers responsibility

1. **Filters and exception handlers**

* 1.1 Should do security checks, if possible and meaningful to do these here
* 1.2 Error messages transformation to HTTP error codes and messages with data: translation key (no error code),
  additional data

2. **App/Controller/Resource/Scheduler**

* 2.1 Do security checks with calling security related service(s) before entering any (business) logic
* 2.2 Data transformations for calling (business) logic services. For example, DTOs to other class model data. Data
  mapper, transform or other services have to be called.
* 2.2 Logic service calls.
* 2.3 Ordinary exceptions to web exception transformation for error message transformations (1.2)

3. **API/Service**

* 3.1 Security check services
* 3.2 Data validation check services
* 3.3 Data transformation services
* 3.4 Logic services, data request and population services
* 3.5 Has its own data models and therefore...
* 3.6 Is independent of point 2 layer

4. **DAO/Repository/API**

* 4.1 Request objects from DB or from external API-s

### Decided tools, components and libraries

#### OS

1.1 DOCUMENTATION MOVED

#### Containers

2.1 DOCUMENTATION MOVED
2.2 DOCUMENTATION MOVED
3 Shell
3.1 Bourne shell and use #!/bin/sh not #!/bin/bash. The First one is in base installation of CentOS, Fedora, *BSD,
Solaris, Debian (*buntu), OpenIndiana etc.
3.2 Therefore a shell script should be not written in "bashism" (bash way), but as much as possible in POSIX shell
way.
3.3 Prefer shell first and if not possible or simpler, then Python 3.x.

#### UI

4.1 because HTML has no rich standard set of components, then we need write components by our selves.
4.2 IE 11 is still in use, therefore, that should be covered too.
4.3 Prefer CSS tool over JS tools to get UI results.
4.4 because of http2 push method we use old style resources (css, js) loading. Possible to make (if it is not
already done) tag library, that does push first for JSP or HTML loading.
4.5 Therefore and because of webpack we should support in JavaScript node packaging and

#### Logs

5.1 Logging should go to tailable file.
5.2 Logging should be with size limit; that means logs should be split after reaching the limit.
6 Build tools
6.1 For Java maven
6.2 Other build tools and helpers: cmake, ant, make (GNU?)
6.3 Webpack build tool for frontend tools.
6.4 Reporting building with maven using maven site, where site has integrated reports: JavaDoc (for main and test
code), pitest, OWASP dependencies check, JaCoCo unit test coverage, style check, version notes, todo notes, findbugs.

#### JavaScript (JS)

7.1 Prefer ECMAScript 6 - "Pure JS". Newer standards added a lot of other keywords and possibilities. Some of them
make code reading harder!
7.2 Prefer Pure JS to TypeScript.
7.3 Prefer code without "prototype". Just create an object and add properties.
7.4 Frontent JS
7.4.1 Use layered architecture: resources at bottom for data access and data fixing and normalization, service layer
top on that for ...
7.4.2 Prefer two-way data binding over event dispatch-catch.

#### Java

8.1. Prefer solutions to write code without interfaces. Interfaces are for frameworks or plugins, where N number of
third parties should implement something.
8.2. Java fail length up to 512 lines and line length 110.

#### Source Controll

9.1. GIT over Mercurial

10. Hibernate
11. DB: PostgreSQL, MongoDB, DGraph (?)
12. MQ: RabbitMQ (should be used, when they hide problems? Replace it with Redis?), Mosquitto
13. Spring, Spring boot andMicronaut, but using as much as possible standard way (javax.*).
14. Semantic versioning: https://semver.org/
4. Solution levels

1: Only JWT check with symmetric keys. No session cancellation (JWT revoke). Fully stateless solutions. No central
solutions cache for apps. Single node solutions. App backend as GW.
2: DB JWT check with symmetric keys. DB-based session cancellation and expiration (JWT revoke). Single node
solutions. App backend as GW. No central cache solutions for apps.

3. DB JWT check with symmetric and asymmetric keys. DB-based session cancellation and expiration (JWT revoke). Multi
   node solutions. App backend as GW. No central cache solutions for apps.
4. Central Cache and session storage. JWT and session revoke in cache systems. Multi node solutions. Multi HW
   servers only.
5. Central Cache and session storage. JWT and session revoke in identity management systems. Multi node systems.
   Health checks. API GW (rate limiting, security, identity management, etc.). Multiple hardware (servers, network
   nodes, powwersuplies, UPS etc.) nodes. Storage systems.

15. Prefer standard or well defined or stable tools over self making tools.
16. Xfce is class desktop environment.

## Application configuration

Overload (overwritten from top to down) order

| **Order**                                   |
|---------------------------------------------|
| Defaults in code                            |
| File (**.yaml** overwrites **.properties**) |
| Environment variables                       |
| CLI                                         |

Variable naming convention

|                                           | **Prefix**                 |
|-------------------------------------------|----------------------------|
| File<br/>**properties**<br/>**yaml**<br/> | <br/>**smi.**<br/>**smi:** |
| Environment variables                     | **SMI_**                   |
| CLI                                       | **--smi-**                 |

```properties
smi.xyz=abc,def,ghi
```

```yaml
smi:
    xyz: abc,def,ghi
```

```shell
SMI_XYZ=abc,def,ghi
```

```shell
abx --smi-xyz=abc,def,ghi
```

Names after prefix:

| Configuration option              | properties | yaml | Environment variables suffix | CLI options suffix     | Notes |
|-----------------------------------|------------|------|------------------------------|------------------------|-------|
| Profiles                          | -          | -    | PROFILES                     | -profiles              |       |
| Config paths                      | -          | -    | CONFIG_PATHS                 | -config-paths          |       |
| Optional application config files | -          | -    | OPTIONAL_CONFIG_FILES        | -optional-config-files |       |
| Application name                  | -          | -    | NAME                         | -name                  |       |

## Other

[No addons, extensions, plugins into git](noGitAddons.md)

[No release by VCS tag](noReleaseByVCSTag.md)

[No secrets in main VCS](noSecretsInMainVCS.md)

[Maven](maven.md)

[Cucmber tests principles](cucumberTestsPrinciples.md)
