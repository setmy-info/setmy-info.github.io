# JavaFX

## Information

JavaFX is Java's modern UI framework for building desktop and rich-client applications. It succeeds Swing and AWT,
offering hardware-accelerated 2D/3D graphics, CSS-based styling, FXML for declarative UI layouts, media playback,
WebView, and a rich set of built-in controls.

Oracle removed JavaFX from the JDK in Java 11. Development continues as **OpenJFX** — an open-source project under
the OpenJDK umbrella. Applications target Java 11+ and add OpenJFX as a module or Maven/Gradle dependency. The
**Scene Builder** visual layout tool generates FXML files without writing XML by hand.

## Installation

### Fedora

```shell
sudo dnf install java-21-openjdk java-21-openjdk-devel
```

OpenJFX is available as a separate package on some distributions, or included as a module in some JDK bundles.
Alternatively, add it as a Maven dependency (see below).

### Maven dependency

Add the OpenJFX BOM or individual module dependencies:

```xml
<dependency>
    <groupId>org.openjfx</groupId>
    <artifactId>javafx-controls</artifactId>
    <version>21</version>
</dependency>
<dependency>
    <groupId>org.openjfx</groupId>
    <artifactId>javafx-fxml</artifactId>
    <version>21</version>
</dependency>
```

Also add the OpenJFX Maven plugin to run the application:

```xml
<plugin>
    <groupId>org.openjfx</groupId>
    <artifactId>javafx-maven-plugin</artifactId>
    <version>0.0.8</version>
    <configuration>
        <mainClass>info.setmy.application.Main</mainClass>
    </configuration>
</plugin>
```

## Configuration

### Module system (module-info.java)

When using Java modules, declare the required JavaFX modules:

```java
module info.setmy.application {
    requires javafx.controls;
    requires javafx.fxml;
    opens info.setmy.application to javafx.fxml;
    exports info.setmy.application;
}
```

## Usage, tips and tricks

### Coding tips and tricks

#### Starting a Maven project from the archetype

```sh
mvn archetype:generate \
        -DarchetypeGroupId=org.openjfx \
        -DarchetypeArtifactId=javafx-archetype-simple \
        -DarchetypeVersion=0.0.3 \
        -DgroupId=info.setmy.application \
        -DartifactId=javafx-sample \
        -Dversion=1.0.0-SNAPSHOT \
        -Djavafx-version=19
```

Execute the project:

```sh
mvn clean javafx:run
```

## See also

* [OpenJFX home](https://openjfx.io/)
* [Getting Started with Maven](https://openjfx.io/openjfx-docs/#maven)
* [FXML introduction](https://openjfx.io/javadoc/19/javafx.fxml/javafx/fxml/doc-files/introduction_to_fxml.html)
* [Scene Builder](https://gluonhq.com/products/scene-builder)
* [JavaFX API docs](https://openjfx.io/javadoc/21/)
