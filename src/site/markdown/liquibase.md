# Liquibase

## Information

Liquibase is an open-source database schema change management tool. It tracks, versions, and deploys database
changes using changelog files written in XML, YAML, JSON, or plain SQL. It works similarly to version control for
database schemas: each change is recorded as a `changeSet` and applied in order, with Liquibase tracking which
changesets have already run via a `DATABASECHANGELOG` table.

Liquibase integrates with Maven, Gradle, Spring Boot, and standalone CLI.

## Installation

### Maven plugin

Add to `pom.xml`:

```xml
<plugin>
    <groupId>org.liquibase</groupId>
    <artifactId>liquibase-maven-plugin</artifactId>
    <version>4.27.0</version>
    <configuration>
        <changeLogFile>src/main/resources/db/changelog/db.changelog-master.yaml</changeLogFile>
        <url>jdbc:postgresql://localhost:5432/mydb</url>
        <username>myuser</username>
        <password>mypassword</password>
    </configuration>
</plugin>
```

### Spring Boot auto-configuration

Spring Boot auto-applies Liquibase on startup when the dependency is on the classpath:

```xml
<dependency>
    <groupId>org.liquibase</groupId>
    <artifactId>liquibase-core</artifactId>
</dependency>
```

`application.yaml`:

```yaml
spring:
  liquibase:
    enabled: true
    change-log: classpath:db/changelog/db.changelog-master.yaml
```

## Configuration

### Changelog master file

```yaml
databaseChangeLog:
  - include:
      file: db/changelog/changes/001-create-users-table.yaml
      relativeToChangelogFile: false
```

### changeSet structure

```yaml
databaseChangeLog:
  - changeSet:
      id: 001
      author: imre.tabur
      changes:
        - createTable:
            tableName: users
            columns:
              - column:
                  name: id
                  type: BIGINT
                  autoIncrement: true
                  constraints:
                    primaryKey: true
              - column:
                  name: email
                  type: VARCHAR(255)
                  constraints:
                    nullable: false
```

### Cross-database type properties

```xml
<property name="jsonbType" value="json" dbms="h2"/>
<property name="jsonbType" value="jsonb" dbms="postgresql"/>

<column name="metaData" type="${jsonbType}"/>
```

## Usage, tips and tricks

```shell
# Apply pending changes
mvn liquibase:update

# Roll back last N changesets
mvn liquibase:rollback -Dliquibase.rollbackCount=1

# Show pending changesets
mvn liquibase:status

# Generate diff between DB and changelog
mvn liquibase:diff
```

## See also

* [Liquibase official site](https://www.liquibase.org/)
* [Liquibase Maven plugin](https://docs.liquibase.com/tools-integrations/maven/home.html)
* [Spring Boot Liquibase integration](https://docs.spring.io/spring-boot/docs/current/reference/html/howto.html#howto.data-initialization.migration-tool.liquibase)
