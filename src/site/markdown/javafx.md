# JavaFX

## Information

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

#### Starting maven project

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

Execute project:

```sh
mvn clean javafx:run
```

## See also

[JavaFX home](https://openjfx.io/)

[Starting with Maven](https://openjfx.io/openjfx-docs/#maven)

[FXML](https://openjfx.io/javadoc/19/javafx.fxml/javafx/fxml/doc-files/introduction_to_fxml.html)

[Scene Builder](https://gluonhq.com/products/scene-builder)
