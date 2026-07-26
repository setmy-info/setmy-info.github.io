# Spotless

## Information

### Introduction

`Spotless` is a general-purpose code formatter that can enforce a consistent coding style across a variety of
programming languages and build tools. It is designed to "keep your code spotless" by automatically formatting source
files according to defined rules.

Spotless is particularly popular in the Java and Kotlin ecosystems, but it supports many other languages including
Scala, Groovy, C++, Python, JavaScript, and more. It integrates seamlessly with build tools like `Gradle` and `Maven`,
allowing for easy enforcement of styling rules in CI/CD pipelines.

### What is it for?

Spotless is used to:

* **Enforce Coding Standards**: Ensure that all developers on a project follow the same formatting rules.
* **Automate Formatting**: Reduce manual effort by automatically fixing formatting issues during build or on-demand.
* **Simplify Code Reviews**: Focus on logic and functionality rather than debating about indentation or bracing styles.
* **Prevent Formatting Conflicts**: Avoid "diff noise" caused by different IDE settings or developer preferences.

## Main Functionalities and Features

* **Multi-Language Support**: Supports Java, Kotlin, Scala, Groovy, C/C++, C#, CSS, HTML, JavaScript, JSON, Markdown,
  Python, SQL, YAML, and more.
* **Build Tool Integration**: First-class support for `Gradle` and `Maven`.
* **Multiple Formatters**: Can wrap existing formatters like `google-java-format`, `eclipse-jdt`, `ktlint`,
  `prettier`, `black`, and more.
* **License Header Management**: Can automatically add or update license headers in source files.
* **Check and Apply**: Provides tasks to check if code is compliant and tasks to automatically apply the formatting.
* **Idempotency**: Guarantees that applying the formatter multiple times will result in the same output.

## Installation and Setup

### Maven Setup

To use Spotless with Maven, add the `spotless-maven-plugin` to your `pom.xml`.

```xml

<plugin>
    <groupId>com.diffplug.spotless</groupId>
    <artifactId>spotless-maven-plugin</artifactId>
    <version>2.43.0</version>
    <configuration>
        <java>
            <googleJavaFormat>
                <version>1.17.0</version>
                <style>GOOGLE</style>
            </googleJavaFormat>
            <licenseHeader>
                <content>/* (C) $YEAR */</content>
            </licenseHeader>
        </java>
    </configuration>
    <executions>
        <execution>
            <goals>
                <goal>check</goal>
            </goals>
            <phase>compile</phase>
        </execution>
    </executions>
</plugin>
```

### Gradle Setup

To use Spotless with Gradle, apply the plugin and configure it in your `build.gradle` or `build.gradle.kts`.

```kotlin
plugins {
    id("com.diffplug.spotless") version "6.25.0"
}

spotless {
    java {
        googleJavaFormat("1.17.0")
        licenseHeader("/* (C) $YEAR */")
    }
}
```

## Usage

### Common Commands

**For Maven:**

* Check formatting: `mvn spotless:check`
* Apply formatting: `mvn spotless:apply`

**For Gradle:**

* Check formatting: `./gradlew spotlessCheck`
* Apply formatting: `./gradlew spotlessApply`

## Tips and Tricks

* **CI Enforcement**: Always run `spotless:check` in your CI pipeline to ensure no unformatted code is merged.
* **Pre-commit Hooks**: Integrate Spotless with `git` pre-commit hooks to format code automatically before every commit.
* **Selective Formatting**: Use the `ratchetFrom` feature in Gradle to only format files that have changed since a
  certain git ref (e.g., `origin/main`).

## See also

* [Spotless GitHub Repository](https://github.com/diffplug/spotless)
* [Google Java Format](https://github.com/google/google-java-format)
* [ktlint](https://pinterest.github.io/ktlint/)
* [Prettier](https://prettier.io/)
* [Java](java.md)
* [Maven](maven.md)
* [Code quality](it/knowhow.md)
