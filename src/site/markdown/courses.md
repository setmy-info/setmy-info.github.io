# courses

## Information

This page is a structured learning path and course outline for software development, organised into skill levels.
Each level builds on the previous one. Topics at each level represent the skills a developer should have before
advancing.

## Level 1

Foundations for a junior developer:

* **Version control**: Git basics — clone, commit, push, pull, branch, merge, rebase. See [git.md](git.md).
* **Command line**: Shell scripting basics, file operations, pipes, environment variables. See [shell.md](shell.md).
* **Java fundamentals**: Data types, OOP (classes, interfaces, inheritance, polymorphism), generics, collections,
  exceptions, I/O.
* **Build tools**: Maven — project structure (pom.xml), dependencies, lifecycle (compile/test/package/install).
  See [maven.md](maven.md).
* **IDE setup**: IntelliJ IDEA or Eclipse — project import, debugger, refactoring tools. See [eclipse.md](eclipse.md).
* **Unit testing**: JUnit 5 — @Test, @BeforeEach, @AfterEach, assertions, parameterized tests. See
  [unittesting.md](unittesting.md).
* **Debugging**: Breakpoints, step-over/into/out, watch expressions, evaluate expressions.

## Level 2

Intermediate skills for building real applications:

* **Spring Boot**: Auto-configuration, dependency injection, REST controllers, data access, profiles, properties.
  See [springboot.md](springboot.md).
* **REST APIs**: HTTP methods, status codes, JSON, OpenAPI/Swagger, REST design. See [rest.md](rest.md).
* **Docker**: Containers, images, Dockerfile, docker-compose, volumes, networking. See [docker.md](docker.md).
* **Databases (SQL)**: Relational model, SQL queries (SELECT/JOIN/GROUP BY), transactions, indexes.
  See [postgresql.md](postgresql.md).
* **Hibernate / JPA**: ORM concepts, entities, relationships (@OneToMany etc.), JPQL, LazyLoading pitfalls.
* **Logging**: SLF4J API, Logback configuration, log levels, MDC (Mapped Diagnostic Context).
* **Annotations**: Java custom annotations, retention policies, reflection-based processing.
* **Web application (classic)**: Servlet lifecycle, JSP basics, filters.
* **Micronaut**: Alternative to Spring for low-footprint services. See [micronaut.md](micronaut.md).

## Level 3

Advanced skills for senior developers and architects:

* **Microservices**: Service decomposition, inter-service communication (REST/gRPC/messaging), circuit breakers.
  See [microfrontend.md](microfrontend.md).
* **Kubernetes**: Pods, deployments, services, config maps, secrets, Helm. See [kubernetes.md](kubernetes.md).
* **CI/CD**: Jenkins pipelines, GitHub Actions, artifact management. See [jenkins.md](jenkins.md),
  [ci-github.md](ci-github.md).
* **Security**: OAuth2, JWT, OpenID Connect, Keycloak integration. See [keycloak.md](keycloak.md),
  [jwt-models.md](jwt-models.md).
* **Performance tuning**: JVM tuning (heap, GC settings), profiling, load testing, database query optimization.
* **Design patterns**: GoF patterns, architectural patterns (CQRS, Event Sourcing, Hexagonal).
* **Clean Code**: Naming, small functions, SOLID principles, refactoring.
* **Gradle**: Alternative build tool, Groovy/Kotlin DSL.
* **Cucumber / BDD**: Specification by Example, Gherkin, step definitions. See [cucumber.md](cucumber.md).
* **JEE / Glassfish / MicroProfile**: Enterprise Java standards and lightweight profiles.

## TODO

```
Java compiling
IDEs
    Debugging
JUnit 4 ja 5
Annotations
web-app - old style web application
Spring
Spring Boot
Micronaut
Maven
    Plugins
    Building
    Site
Gradle
Cucumber
Hibernate & JPA
JEE / Glassfish
Microprofile
Design patterns
Clean Code
```

## See also

* [Java](java.md)
* [Maven](maven.md)
* [Spring Boot](springboot.md)
* [Docker](docker.md)
* [Git](git.md)
* [Cucumber](cucumber.md)
* [Unittesting](unittesting.md)
