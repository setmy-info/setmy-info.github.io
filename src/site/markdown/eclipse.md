# Eclipse IDE

## Information

**Eclipse** is a free, open-source integrated development environment (IDE) primarily used for Java development,
but extensible to many other languages through plugins. It is maintained by the Eclipse Foundation and is one of the
most widely used IDEs for enterprise Java development.

Eclipse uses a plugin architecture — the base IDE is minimal, and functionality (language support, build integration,
version control) is added via plugins. The **Eclipse Marketplace** provides thousands of plugins.

Common Eclipse editions (packages):

* **Eclipse IDE for Java Developers** — core Java development.
* **Eclipse IDE for Enterprise Java and Web Developers** — adds JEE, JSF, Maven, and web tooling.
* **Eclipse IDE for C/C++ Developers** — CDT plugin for C and C++ development.
* **Spring Tools Suite (STS)** — Eclipse-based IDE specialized for Spring Framework development.

## Installation

Download the installer from [eclipse.org/downloads](https://www.eclipse.org/downloads/). Run the installer and
select the appropriate package for your development needs.

### JVM configuration (eclipse.ini)

Eclipse requires a JDK. If it does not detect the correct JVM automatically, specify it in `eclipse.ini`:

```ini
-vm
/opt/jdk/bin
```

Place the `-vm` and the path on separate lines, **before** the `-vmargs` section. Using the JDK (not JRE) is
recommended so Eclipse can compile code.

## Configuration

### Workspace settings

Eclipse stores settings per-workspace under `<workspace>/.metadata/.plugins/`. Key settings:

* **Window → Preferences → Java → Compiler** — set Java source/target compliance level.
* **Window → Preferences → Java → Code Style** — configure formatter and import ordering.
* **Window → Preferences → General → Workspace → Text file encoding** — set to UTF-8.
* **Window → Preferences → Maven** — configure Maven settings file location.

### Code formatter

Export the team formatter settings from **Window → Preferences → Java → Code Style → Formatter → Export** and
commit the XML file to version control so all team members share the same formatting rules.

## Usage, tips and tricks

### Useful keyboard shortcuts

| Shortcut          | Action                                 |
|-------------------|----------------------------------------|
| `Ctrl+Shift+T`    | Open type (class/interface) by name    |
| `Ctrl+Shift+R`    | Open resource (file) by name           |
| `Ctrl+O`          | Quick outline of current file          |
| `Ctrl+E`          | Switch between open editors            |
| `F3`              | Go to declaration                      |
| `Alt+Shift+R`     | Rename (refactoring)                   |
| `Ctrl+1`          | Quick fix (resolve errors/warnings)    |
| `Ctrl+Shift+F`    | Format source code                     |
| `Ctrl+Shift+O`    | Organize imports                       |
| `Alt+Left/Right`  | Navigate back/forward in editor history|

### Running Python in Eclipse (PyDev)

Install PyDev from the Eclipse Marketplace or from:

```
http://www.pydev.org/updates
```

### Maven integration

The M2Eclipse plugin (bundled in enterprise editions) provides Maven project import and build integration. Use
**File → Import → Maven → Existing Maven Projects** to import a Maven project.

## See also

* [Eclipse official website](https://www.eclipse.org/)
* [Eclipse Marketplace](https://marketplace.eclipse.org/)
* [Spring Tools Suite](https://spring.io/tools)
* [PyDev (Python plugin)](https://www.pydev.org/)
* [Maven](maven.md)
* [Java](java.md)
