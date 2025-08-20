# JHipster

## Information

## Installation

* JDK 17
* Node v18.15.0
* JHipster 7.9.3

```
npm install -g generator-jhipster
mkdir jhipster
cd jhipster
```

```
Error [ERR_PACKAGE_PATH_NOT_EXPORTED]: Package subpath './lib/util/namespace' is not defined by "exports" in C:\pub\node-v18.15.0-win-x64\node_modules\generator-jhipster\node_modules\yeoman-environment\package.json
```

The [problem](https://github.com/jhipster/generator-jhipster/issues/19627)  in GitHub issue management

Edit: **C:\pub\node-v18.15.0-win-x64\node_modules\generator-jhipster\node_modules\yeoman-environment\package.json**

Add into "**exports**"

```
"./lib/util/namespace": "./lib/util/namespace.js"
```

Interactive interface

```
jhipster
```

Answers:

```
√ What is the base name of your application? jhipster1
√ Which *type* of application would you like to create? Monolithic application (recommended for simple projects)
√ What is your default Java package name? info.setmy.jhipster
√ Would you like to use Maven or Gradle for building the backend? Maven
√ Do you want to make it reactive with Spring WebFlux? No
√ Which *type* of authentication would you like to use? JWT authentication (stateless, with a token)
√ Besides JUnit, which testing frameworks would you like to use? Gatling, Cucumber
√ Which *type* of database would you like to use? SQL (H2, PostgreSQL, MySQL, MariaDB, Oracle, MSSQL)
√ Which *production* database would you like to use? PostgreSQL
√ Which *development* database would you like to use? H2 with disk-based persistence
√ Which cache do you want to use? (Spring cache abstraction) Infinispan (hybrid cache, for multiple nodes)
√ Do you want to use Hibernate 2nd level cache? Yes
√ Which other technologies would you like to use?
√ Which *framework* would you like to use for the client? Angular
√ Besides Jest/Vitest, which testing frameworks would you like to use?
√ Do you want to generate the admin UI? Yes
√ Would you like to use a Bootswatch theme (https://bootswatch.com/)? Default JHipster
√ Would you like to enable internationalization support? Yes
√ Please choose the native language of the application English
√ Please choose additional languages to install Estonian, Russian
```

Delete **.mvn/wrapper/jvm.config**

Edit **.mvn/wrapper/maven-wrapper.properties**

```properties
wrapperVersion=3.3.2
distributionUrl=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.11/apache-maven-3.9.11-bin.zip
```

Edit **pom.xml** and change as this:

```xml

<modernizer-maven-plugin.version>2.5.0</modernizer-maven-plugin.version>
```

Build app:

```
.\mvnw clean install
```

Run app:

```
.\mvnw
```

Main page (admin:admin): http://localhost:8080

Swagger : http://localhost:8080/admin/docs

```
jhipster entity author
jhipster entity book
jhipster spring-controller Foo
jhipster spring-service Bar
```

Answers:

```
? Do you want to add a field to your entity? Yes
? What is the name of your field? name
? What is the type of your field? String
? Do you want to add validation rules to your field? No
...
? Do you want to add a field to your entity? Yes
? What is the name of your field? birthDate
? What is the type of your field? LocalDate
? Do you want to add validation rules to your field? No
...
? Do you want to use separate service class for your business logic? Yes, generate a separate service class
? Do you want to use a Data Transfer Object (DTO)? Yes, generate a DTO with MapStruct
? Do you want to add filtering? Dynamic filtering for the entities with JPA Static metamodel
? Is this entity read-only? No
? Do you want pagination and sorting on your entity? Yes, with pagination links and sorting headers
```

Export project JDL:

```
jhipster export-jdl jhipster1.jh
```

Importing JDL starting project from JDL file only

```
jhipster import-jdl jhipster1.jh
```

Importing JDL

```
jhipster --force jdl jhipster1.jh
```

Add to **.dockerignore**

```
.idea
node_modules
target
```

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [Entity creation](https://www.jhipster.tech/creating-an-entity/)
* [Controller creation](https://www.jhipster.tech/creating-a-spring-controller/)
* [Service creation](https://www.jhipster.tech/creating-a-spring-service/)
* [DTOs](https://www.jhipster.tech/using-dtos/)
* [Relationships](https://www.jhipster.tech/managing-relationships/)
* [Field data types](https://www.jhipster.tech/creating-an-entity/#field-types)
* [JHipster logoJDL-Studio](https://start.jhipster.tech/jdl-studio/)
* [JDL samples](https://github.com/jhipster/jdl-samples)
* [Efficiency in mapping](https://vladmihalcea.com/the-best-way-to-map-a-onetoone-relationship-with-jpa-and-hibernate/)
* [JHip security](https://www.jhipster.tech/security/)
