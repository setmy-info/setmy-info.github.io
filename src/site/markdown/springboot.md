# Template

## Information

## Usage, tips and tricks

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

## See also

[Spring Boot Starter](https://start.spring.io/)
