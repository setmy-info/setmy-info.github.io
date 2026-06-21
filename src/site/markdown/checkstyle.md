# Checkstyle

## Information

**Checkstyle** is a static analysis tool for Java that enforces coding standards and style rules. It checks source
code against a configurable rule set and reports violations. Common rule sets are based on the **Google Java Style
Guide** or the original **Sun Coding Conventions**.

Checkstyle integrates with Maven, Gradle, Ant, and IDE plugins (IntelliJ IDEA, Eclipse). It is typically run as part
of the build process to fail the build on style violations, or in IDE to give inline feedback during development.

### What it checks

* Naming conventions (classes, methods, fields, variables, constants)
* Whitespace and indentation
* Import ordering and unused imports
* Javadoc presence and format
* Block structure (braces, empty blocks)
* Class and method design (magic numbers, complexity)
* Coding style (variable declarations, string literals)

## Installation

Checkstyle is typically used as a build plugin — no separate installation is needed.

### Maven (maven-checkstyle-plugin)

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-checkstyle-plugin</artifactId>
    <version>3.4.0</version>
    <configuration>
        <configLocation>checkstyle.xml</configLocation>
        <failsOnError>true</failsOnError>
        <consoleOutput>true</consoleOutput>
    </configuration>
    <executions>
        <execution>
            <id>validate</id>
            <phase>validate</phase>
            <goals>
                <goal>check</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

### Gradle

```groovy
plugins {
    id 'checkstyle'
}

checkstyle {
    toolVersion = '10.x.x'
    configFile = file('config/checkstyle/checkstyle.xml')
}
```

## Configuration

### checkstyle.xml

The rule file selects and configures individual checks:

```xml
<?xml version="1.0"?>
<!DOCTYPE module PUBLIC
    "-//Checkstyle//DTD Checkstyle Configuration 1.3//EN"
    "https://checkstyle.org/dtds/configuration_1_3.dtd">
<module name="Checker">
    <property name="charset" value="UTF-8"/>
    <property name="severity" value="error"/>

    <module name="TreeWalker">
        <module name="ConstantName"/>
        <module name="LocalFinalVariableName"/>
        <module name="LocalVariableName"/>
        <module name="MemberName"/>
        <module name="MethodName"/>
        <module name="PackageName"/>
        <module name="TypeName"/>
        <module name="AvoidStarImport"/>
        <module name="WhitespaceAround"/>
        <module name="EmptyLineSeparator"/>
        <module name="MagicNumber"/>
        <module name="JavadocMethod">
            <property name="accessModifiers" value="public"/>
        </module>
    </module>
</module>
```

### suppressions.xml

Suppress specific checks for generated code or legacy files:

```xml
<?xml version="1.0"?>
<!DOCTYPE suppressions PUBLIC
    "-//Checkstyle//DTD SuppressionFilter Configuration 1.2//EN"
    "https://checkstyle.org/dtds/suppressions_1_2.dtd">
<suppressions>
    <suppress checks=".*" files="[\\/]generated[\\/]"/>
    <suppress checks="MagicNumber" files="Test\.java$"/>
</suppressions>
```

Reference it from `checkstyle.xml`:

```xml
<module name="SuppressionFilter">
    <property name="file" value="suppressions.xml"/>
</module>
```

## Usage, tips and tricks

```shell
# Run Checkstyle via Maven
mvn checkstyle:check

# Generate HTML report
mvn checkstyle:checkstyle
# Report at target/site/checkstyle.html
```

* Start with the Google style configuration to get a complete, well-maintained baseline:
  `com/puppycrawl/tools/checkstyle/checks/imports/google_checks.xml` (available in the checkstyle JAR).
* Add the suppressions file early to exclude generated sources (`target/generated-sources`) from checks.
* Use IDE plugins to see violations as you type, not only at build time.
* Customise severity per check (`warning` vs `error`) to phase in stricter rules gradually.

## See also

* [Checkstyle home page](https://checkstyle.sourceforge.io/)
* [Checkstyle configuration reference](https://checkstyle.sourceforge.io/config.html)
* [Available checks](https://checkstyle.sourceforge.io/checks.html)
* [Google Java Style checks config](https://raw.githubusercontent.com/checkstyle/checkstyle/refs/heads/master/config/checkstyle-checks.xml)
* [Maven](maven.md)
