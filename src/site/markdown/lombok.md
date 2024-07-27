# Lombok

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

Immutable class example

```Java
import java.util.ArrayList;

@Getter
@Builder(toBuilder = true)
@RequiredArgsConstructor
public class Example {

    private final String text;
}
```

````Java

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
````

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
