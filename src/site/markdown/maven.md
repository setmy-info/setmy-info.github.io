# Maven

```sh
mvn test

mvn test -Dtest=info.setmy.AbcTest

mvn verify

mvn verify -Dit.test=info.setmy.AbcIT

mvn install -DskipTests

mvn install -Dmaven.test.skip=true

mvn install -DskipITs

mvn org.pitest:pitest-maven:mutationCoverage

mvn site:site

mvn pdf:pdf

```

## Creating maven project

```sh
mvn -B archetype:generate \
    -DgroupId=info.setmy.app \
    -DartifactId=example-app \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DarchetypeVersion=1.4
```

## Creating Maven site project

```sh
mvn archetype:create \
  -DgroupId=info.setmy.site \
  -DartifactId=documentation-example-site \
  -DarchetypeArtifactId=maven-archetype-site-simple
```

## Creating JavaFX project

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

http://www.doclo.be/lieven/articles/personalsitewithmaven.html

https://dzone.com/articles/how-publish-maven-site-docs

https://maven.apache.org/ref/3.9.0/maven-core/lifecycles.html

https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html#lifecycle-reference

(Maven search)[https://search.maven.org/]
