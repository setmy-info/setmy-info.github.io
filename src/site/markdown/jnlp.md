# JNLP

## Information

JNLP (Java Network Launch Protocol) is an XML-based descriptor format for deploying Java applications over the web
via **Java Web Start**. A `.jnlp` file describes the application's main class, required JARs, minimum Java version,
and launch options. When a user opens a JNLP URL, Java Web Start downloads, caches, and launches the application
locally without a traditional installer.

**Deprecation notice:** Java Web Start was removed from the JDK in Java 11 (JEP 289). For legacy JNLP-based
deployments, use **OpenWebStart** (a community-maintained Java Web Start replacement) or **IcedTea-Web**.

MIME type for JNLP files:

```
application/x-java-jnlp-file
```

## Configuration

### JNLP file example

```xml
<?xml version="1.0" encoding="UTF-8"?>

<jnlp spec="1.0+" codebase="https://github/xyz" href="">
    <information>
        <title>Launch Java Desktop App</title>
        <vendor>Hear And See systems LLC</vendor>
        <offline-allowed/>
    </information>
    <resources>
        <j2se version="1.5+" href="http://java.sun.com/products/autodl/j2se"/>
        <jar href="abx-1.2.3-1fbdc370-739c-40bb-916d-948b088a88de.jar" main="true" />
    </resources>
    <applet-desc name="Desktop Application XYZ" main-class="info.setmy.javafx.appxyz.Main" width="300" height="200">
    </applet-desc>
    <update check="background"/>
</jnlp>
```

Key JNLP elements:

| Element | Purpose |
|---------|---------|
| `codebase` | Base URL for JAR and resource downloads |
| `<information>` | Title, vendor, description, shortcut options |
| `<resources>` | Java version requirement and JARs to download |
| `<applet-desc>` / `<application-desc>` | Entry point class name and window dimensions |
| `<update check="...">` | Whether to check for updates (always, timeout, background) |

## Usage, tips and tricks

Serve the `.jnlp` file from a web server with the correct MIME type
(`application/x-java-jnlp-file`). Many web servers require manual MIME type registration.

For running JNLP files on modern Java (11+), install OpenWebStart and associate `.jnlp` files with it:

```shell
# OpenWebStart provides its own JNLP handler
javaws application.jnlp
```

## See also

* [OpenWebStart](https://openwebstart.com/)
* [Java Web Start (Wikipedia)](https://en.wikipedia.org/wiki/Java_Web_Start)
* [JNLP (Wikipedia)](https://en.wikipedia.org/wiki/Java_Web_Start#Java_Network_Launching_Protocol_(JNLP))
* [IcedTea-Web GitHub](https://github.com/AdoptOpenJDK/IcedTea-Web)
* [IcedTea-Web](https://icedtea.classpath.org/)
