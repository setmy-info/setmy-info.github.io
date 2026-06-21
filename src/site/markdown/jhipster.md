# JHipster

## Information

JHipster is an open-source application generator that scaffolds full-stack Spring Boot + Angular/React/Vue projects.
It uses Yeoman under the hood and produces production-ready code with JWT or OAuth2 authentication, a chosen database,
caching layer, build toolchain, Docker Compose files, CI/CD configuration, and optional microservices/Kubernetes
support — all from answers to an interactive questionnaire or a JDL file.

JHipster Domain Language (JDL) lets you describe entities, relationships, pagination, and DTOs in a structured text
format and then generate or regenerate the corresponding code.

## Installation

Prerequisites:

* JDK 17
* Node.js (LTS) — tested with v18.15.0
* JHipster 7.9.3+

```shell
npm install -g generator-jhipster
mkdir jhipster
cd jhipster
```

Known npm compatibility issue with older generator-jhipster + yeoman-environment:

```
Error [ERR_PACKAGE_PATH_NOT_EXPORTED]: Package subpath './lib/util/namespace' is not defined by "exports"
```

Workaround: Edit `node_modules/generator-jhipster/node_modules/yeoman-environment/package.json` and add to
`"exports"`:

```
"./lib/util/namespace": "./lib/util/namespace.js"
```

See: [GitHub issue #19627](https://github.com/jhipster/generator-jhipster/issues/19627)

### Initialize a project

```shell
jhipster
```

Example answers:

```
What is the base name of your application? jhipster1
Which *type* of application? Monolithic application
Default Java package name? info.setmy.jhipster
Maven or Gradle? Maven
Reactive with Spring WebFlux? No
Authentication type? JWT
Testing frameworks? Gatling, Cucumber
Database type? SQL
Production database? PostgreSQL
Development database? H2 with disk-based persistence
Cache? Infinispan
Client framework? Angular
Generate admin UI? Yes
Internationalization? Yes; native: English; additional: Estonian, Russian
```

Delete `.mvn/wrapper/jvm.config` if it causes issues.

Edit `.mvn/wrapper/maven-wrapper.properties`:

```properties
wrapperVersion=3.3.2
distributionUrl=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.11/apache-maven-3.9.11-bin.zip
```

Build:

```shell
.\mvnw clean install
```

Run (main page at http://localhost:8080, admin:admin; Swagger at http://localhost:8080/admin/docs):

```shell
.\mvnw
```

## Configuration

`.yo-rc.json` in the project root stores all generator answers and is used when re-running JHipster to regenerate
code. Commit it to version control.

### JDL configuration example

```jdl
application {
  config {
    applicationType monolith
    authenticationType jwt
    baseName jhipsterFirst
    buildTool maven
    cacheProvider infinispan
    clientFramework angular
    clientTheme none
    databaseType sql
    devDatabaseType h2Disk
    enableHibernateCache true
    jhipsterVersion "8.1.0"
    languages [et, en, ru, sk, ua]
    nativeLanguage et
    packageName info.setmy.jhipster
    prodDatabaseType postgresql
    testFrameworks [cucumber, cypress]
    withAdminUi true
  }

  entities Author, Book
}

@ChangelogDate("20231221151227")
entity Author {
  name String required minlength(5) maxlength(20)
  birthDate LocalDate
  notes String
}
@ChangelogDate("20231221152455")
entity Book {
  name String required
  description String maxlength(125)
}
relationship ManyToOne {
  Book{author} to Author
}

dto Author, Book with mapstruct
paginate Author, Book with pagination
service Author, Book with serviceClass
filter Author, Book
```

### Entity and code generation

```shell
jhipster entity author
jhipster entity book
jhipster spring-controller Foo
jhipster spring-service Bar
```

Export and import JDL:

```shell
jhipster export-jdl jhipster1.jh
jhipster import-jdl jhipster1.jh
jhipster --force jdl jhipster1.jh
```

Add to `.dockerignore`:

```
.idea
node_modules
target
```

## Usage, tips and tricks

### Coding tips and tricks

Modify `pom.xml` `modernizer-maven-plugin.version` if the default version causes build failures:

```xml
<modernizer-maven-plugin.version>2.5.0</modernizer-maven-plugin.version>
```

## See also

* [JHipster official site](https://www.jhipster.tech/)
* [Entity creation](https://www.jhipster.tech/creating-an-entity/)
* [Controller creation](https://www.jhipster.tech/creating-a-spring-controller/)
* [Service creation](https://www.jhipster.tech/creating-a-spring-service/)
* [DTOs](https://www.jhipster.tech/using-dtos/)
* [Relationships](https://www.jhipster.tech/managing-relationships/)
* [Field data types](https://www.jhipster.tech/creating-an-entity/#field-types)
* [JDL Studio](https://start.jhipster.tech/jdl-studio/)
* [JDL samples](https://github.com/jhipster/jdl-samples)
* [JHipster security](https://www.jhipster.tech/security/)
* [Efficiency in mapping](https://vladmihalcea.com/the-best-way-to-map-a-onetoone-relationship-with-jpa-and-hibernate/)
