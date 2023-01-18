# Maven

## Creating maven project

```sh
mvn -B archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4
```

## Adding wrapper to project

```sh
mvn wrapper:wrapper
```

## Release number setting

```sh
.\mvnw versions:set -DnewVersion=%RELEASE_NUMBER% -DprocessAllModules
```

Surefire + Junit 5

https://maven.apache.org/surefire/maven-surefire-plugin/examples/junit-platform.html
