# JNLP

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

MIME type:

```
application/x-java-jnlp-file
```

### Coding tips and tricks

```xml
<?xml version="1.0" encoding="UTF-8"?>

<jnlp spec="1.0+" codebase="https://github/xyz" href="">
    <information>
        <title>Launch Java Desktop APp</title>
        <vendor>Hear And See systems LLC</vendor>
        <offline-allowed/>
    </information>
    <resources>
        <j2se version="1.5+" href="http://java.sun.com/products/autodl/j2se"/>
        <jar href="abx-1.2.3-1fbdc370-739c-40bb-916d-948b088a88de.jar" main="true" />
    </resources>
    <applet-desc name="Desktop Aplication XYZ" main-class="info.setmy.javafx.appxyz.Main" width="300" height="200">
    </applet-desc>
  <update check="background"/>
</jnlp>
```

## See also

[Java OpenWebAStart](https://openwebstart.com/)

[JWS in Wikipedia](https://en.wikipedia.org/wiki/Java_Web_Start)

[JNLP](https://en.wikipedia.org/wiki/Java_Web_Start#Java_Network_Launching_Protocol_(JNLP))

[IcedTea-Web GitHub](https://github.com/AdoptOpenJDK/IcedTea-Web)

[IcedTea-Web](https://icedtea.classpath.org/)