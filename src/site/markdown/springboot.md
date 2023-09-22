# Template

## Information

## Usage, tips and tricks

### Generating

```sh
https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.1.4&packaging=jar&jvmVersion=21&groupId=ee.test.task&artifactId=event-application&name=event-application&description=Event%20Registration%20Application&packageName=ee.test.task.event-application&dependencies=lombok,devtools,web,thymeleaf,jdbc,data-jdbc,data-jpa,liquibase,h2,postgresql,validation
```

### Command line Runner

To inject dependencies.

```Java
package info.setmy.spring.boot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.ExitCodeGenerator;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MergerApplication implements CommandLineRunner, ExitCodeGenerator {

    @Autowired
    SomeService someService;

    private int exitCode;

    public static void main(String[] args) {
        System.exit(
            SpringApplication.exit(
                SpringApplication.run(MergerApplication.class, args)
            )
        );
    }

    @Override
    public void run(String... args) throws Exception {
        readerService.processFiles();
        // Also changes in exitCode
    }

    @Override
    public int getExitCode() {
        return exitCode;
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
        >jvmArguments>-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000
    </jvmArguments>
</configuration>
    </plugin>
```

### Getting profiles in code

```Java
    @Autowired
    Environment environment;
```

### Make console silent

```yml
spring:
    main:
        banner-mode: "off"
```

### Spring execution 1

```sh
java ${JAVA_OPTIONS} -Dlogging.file.name=${LOG_DIR_NAME}/${LOG_FILE_NAME} -Dspring.profiles.active=${APPLICATION_PROFILES} -Dspring.config.additional-location=optional:${OPTIONAL_CONFIG_FILE_NAME} -Dloader.main=${APPLICATION_MAIN_CLASS_NAME} -cp ${APPLICATION_JAR_FILE_NAME} org.springframework.boot.loader.PropertiesLauncher ${*}
```

## See also

[Spring Boot Starter](https://start.spring.io/)
