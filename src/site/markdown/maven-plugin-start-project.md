# maven-plugin-start-project

## Information

A Maven plugin is a collection of goals (Mojos) that can be bound to lifecycle phases or executed directly from the
command line. Plugins are the primary extension mechanism in Maven — build tools, code generators, deployment helpers,
and analyzers are all implemented as Maven plugins.

This page covers how to scaffold a custom Maven plugin from scratch.

## Preparations

### Generate from Archetype

Use the official Maven plugin archetype to bootstrap the project:

```shell
mvn archetype:generate \
  -DgroupId=info.setmy \
  -DartifactId=my-maven-plugin \
  -DarchetypeGroupId=org.apache.maven.archetypes \
  -DarchetypeArtifactId=maven-archetype-plugin \
  -DarchetypeVersion=RELEASE \
  -DinteractiveMode=false
```

This creates a project with `packaging=maven-plugin` and a sample Mojo class.

### pom.xml — Key Elements

```xml
<project>
    <groupId>info.setmy</groupId>
    <artifactId>my-maven-plugin</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>maven-plugin</packaging>

    <dependencies>
        <dependency>
            <groupId>org.apache.maven</groupId>
            <artifactId>maven-plugin-api</artifactId>
            <version>3.9.6</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>org.apache.maven.plugin-tools</groupId>
            <artifactId>maven-plugin-annotations</artifactId>
            <version>3.12.0</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-plugin-plugin</artifactId>
                <version>3.12.0</version>
            </plugin>
        </plugins>
    </build>
</project>
```

### Minimal Mojo

```java
package info.setmy;

import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.LifecyclePhase;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;

@Mojo(name = "greet", defaultPhase = LifecyclePhase.GENERATE_SOURCES)
public class GreetMojo extends AbstractMojo {

    @Parameter(property = "greet.name", defaultValue = "World")
    private String name;

    @Override
    public void execute() throws MojoExecutionException {
        getLog().info("Hello, " + name + "!");
    }
}
```

### Project Structure

```
my-maven-plugin/
├── pom.xml
└── src/
    ├── main/
    │   └── java/
    │       └── info/setmy/
    │           └── GreetMojo.java
    └── test/
        └── java/
            └── info/setmy/
                └── GreetMojoTest.java
```

## Installation

The plugin is installed into your local Maven repository as part of a normal build:

```shell
mvn install
```

After installation, use the plugin in any project:

```xml
<plugin>
    <groupId>info.setmy</groupId>
    <artifactId>my-maven-plugin</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <executions>
        <execution>
            <goals>
                <goal>greet</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <name>Developer</name>
    </configuration>
</plugin>
```

## Configuration

### @Parameter Annotation Options

```java
@Parameter(
    property = "greet.name",   // Overridable via -Dgreet.name=value on the CLI
    defaultValue = "World",    // Used when property is not set
    required = true,           // Build fails if not provided
    readonly = false           // If true, cannot be set by the user
)
private String name;
```

### Accessing the Maven Project

Inject the current Maven project to read POM metadata:

```java
@Parameter(defaultValue = "${project}", readonly = true, required = true)
private MavenProject project;
```

Add the dependency:

```xml
<dependency>
    <groupId>org.apache.maven</groupId>
    <artifactId>maven-core</artifactId>
    <version>3.9.6</version>
    <scope>provided</scope>
</dependency>
```

## Usage, tips and tricks

### Build the Plugin

```shell
mvn clean install
```

This compiles the code and generates the plugin descriptor (`META-INF/maven/plugin.xml`) automatically.

### Run a Goal Directly

```shell
mvn info.setmy:my-maven-plugin:greet
mvn info.setmy:my-maven-plugin:greet -Dgreet.name=Alice
```

### Integration Testing with maven-invoker-plugin

Add to `pom.xml`:

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-invoker-plugin</artifactId>
    <version>3.6.0</version>
    <executions>
        <execution>
            <goals>
                <goal>install</goal>
                <goal>run</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <projectsDirectory>src/it</projectsDirectory>
        <cloneProjectsTo>${project.build.directory}/it</cloneProjectsTo>
        <postBuildHookScript>verify</postBuildHookScript>
    </configuration>
</plugin>
```

Place a test project under `src/it/basic-test/pom.xml`. The invoker plugin runs it and checks the result.

### Help Mojo

Generate a help mojo automatically:

```xml
<configuration>
    <generateHelpMojo>true</generateHelpMojo>
</configuration>
```

Then users can run:

```shell
mvn info.setmy:my-maven-plugin:help -Ddetail=true
```

## See also

* [Maven Plugin Development Guide](https://maven.apache.org/guides/plugin/guide-java-plugin-development.html)
* [maven-plugin-annotations Javadoc](https://maven.apache.org/plugin-tools/maven-plugin-annotations/)
* [maven-invoker-plugin](https://maven.apache.org/plugins/maven-invoker-plugin/)
* [maven.md](maven.md)
