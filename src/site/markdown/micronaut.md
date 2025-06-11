# Micronaut

## Generating mn 1.x project

For Gradle:

```sh
mn create-app micronaut-start-project
```

For Maven:

```sh
mn create-app micronaut-start-project --build maven


# More complex generation
MODULE_NAME=info.setmy.mqttmessages
mn create-app           --build=maven --jdk=21 --lang=java --test=junit --features=logback,assertj,lombok,mockito,junit-params,h2,hibernate-jpa,jdbc-hikari,liquibase,cache-infinispan,yaml,mqtt,hibernate-validator,micrometer-prometheus ${MODULE_NAME}
mn create-messaging-app --build=maven --jdk=21 --lang=java --test=junit --features=logback,assertj,lombok,mockito,junit-params,h2,hibernate-jpa,jdbc-hikari,liquibase,cache-infinispan,yaml,mqtt,hibernate-validator ${MODULE_NAME}
```

## Maven execution

Micronaut 2.x:

```sh
mvn mn:run
```

## See also

[Micronaut Project starter](https://micronaut.io/launch/)
