# Template

## Information

## Usage, tips and tricks

### Command line Runner

To inject dependencies.

```Java
package info.setmy.spring.boot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MergerApplication implements CommandLineRunner {

    @Autowired
    SomeService someService;

    public static void main(String[] args) {
        SpringApplication.run(MergerApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        readerService.processFiles();
    }
}
```

### Debugging

```sh
mvn spring-boot:run -Dagentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000
```

Or in pom.xml

```xml
<plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <version>${spring.boot.verions}</version>
        <configuration>
                >jvmArguments>-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000</jvmArguments>
        </configuration>
</plugin>
```

### Getting profiles in code

```Java
    @Autowired
    Environment environment;
```

## See also

[Spring Boot Starter](https://start.spring.io/)
