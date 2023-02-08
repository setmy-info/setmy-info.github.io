# Maven

```sh
mvn test

mvn verify

mvn install -DskipTests

mvn install -Dmaven.test.skip=true

mvn install -DskipITs

mvn site:site

mvn pdf:pdf

```

## Creating maven project

```sh
mvn -B archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4
```

Site project creation

```sh
mvn archetype:create \
  -DgroupId=mygroup \
  -DartifactId=mywebsite \
  -DarchetypeArtifactId=maven-archetype-site-simple
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
