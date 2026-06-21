# Lombok

## Information

Lombok is a Java annotation processor that generates boilerplate code at compile time. It eliminates the need to
manually write getters, setters, constructors, builders, equals/hashCode, and toString methods. The annotations are
processed by the Java compiler via an annotation processor — the generated code is present in the compiled bytecode
but not visible in the source files.

Commonly used annotations: `@Getter`, `@Setter`, `@Builder`, `@Data`, `@RequiredArgsConstructor`, `@Slf4j`, `@Value`.

## Installation

### Maven dependency

```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.32</version>
    <scope>provided</scope>
</dependency>
```

## Configuration

### annotationProcessorPaths in maven-compiler-plugin

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <configuration>
        <annotationProcessorPaths>
            <path>
                <groupId>org.projectlombok</groupId>
                <artifactId>lombok</artifactId>
                <version>1.18.32</version>
            </path>
        </annotationProcessorPaths>
    </configuration>
</plugin>
```

### IDE setup

* **IntelliJ IDEA**: Install the "Lombok" plugin from the plugin marketplace, then enable annotation processing
  in `Settings > Build > Compiler > Annotation Processors`.
* **Eclipse**: Download and run the Lombok JAR as a Java agent: `java -jar lombok.jar`.

### Common annotations

| Annotation              | What it generates                                      |
|-------------------------|--------------------------------------------------------|
| `@Data`                 | `@Getter` + `@Setter` + `@ToString` + `@EqualsAndHashCode` + `@RequiredArgsConstructor` |
| `@Builder`              | A builder pattern class with fluent API                |
| `@Getter` / `@Setter`   | Getters and/or setters for fields                      |
| `@Slf4j`                | A `log` field backed by SLF4J logger                   |
| `@NoArgsConstructor`    | No-argument constructor                                |
| `@AllArgsConstructor`   | Constructor with all fields                            |
| `@RequiredArgsConstructor` | Constructor for `final` and `@NonNull` fields       |
| `@Value`                | Immutable class: all fields `final`, no setters        |

## Usage, tips and tricks

### Immutable class with builder

```java
import java.util.ArrayList;

@Getter
@Builder(toBuilder = true)
@RequiredArgsConstructor
public class Example {

    private final String text;
}
```

### Builder pattern usage

```java
@Test
public void justExampleTest() {
    var example = Example.builder()
        .text("Hello world")
        .amount(123.12D)
        .build();
    assertThat(example.getText()).isEqualTo("Hello world");
    assertThat(example.getAmount()).isEqualTo(123.12D);

    var example2 = example.toBuilder()
        .text("Another Hello World")
        // NB! Without amount!!!
        .build();
    assertThat(example2.getText()).isEqualTo("Another Hello World");
    assertThat(example2.getAmount()).isEqualTo(123.12D);
}
```

## See also

* [Project Lombok official site](https://projectlombok.org/)
* [Lombok features reference](https://projectlombok.org/features/)
* [Maven Central: lombok](https://central.sonatype.com/artifact/org.projectlombok/lombok)
