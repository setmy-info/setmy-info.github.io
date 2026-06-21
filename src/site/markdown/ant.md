# Apache ANT

## Information

**Apache Ant** is a Java-based build tool that uses XML build files (`build.xml`) to define project build steps. It
provides a rich set of built-in tasks (compile, jar, copy, delete, mkdir, echo, exec) and can be extended with custom
tasks. Ant is predominantly used for Java projects, though it can automate any file-based workflow.

Unlike Maven or Gradle, Ant does not impose a project layout or lifecycle; it gives full control over the build
script. This makes it flexible but requires more explicit configuration.

## Installation

### Rocky Linux / Fedora

```shell
sudo dnf install -y ant
ant -version
```

### Debian / Ubuntu

```shell
sudo apt install -y ant
ant -version
```

### FreeBSD

```shell
pkg install -y apache-ant
```

### Manual (all platforms)

Download the binary distribution from [ant.apache.org](https://ant.apache.org/bindownload.cgi), extract, and set:

```shell
export ANT_HOME=/opt/apache-ant-1.10.x
export PATH=${ANT_HOME}/bin:${PATH}
ant -version
```

## Configuration

### Minimal build.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project name="myapp" default="compile" basedir=".">

    <property name="src.dir" value="src"/>
    <property name="build.dir" value="build"/>
    <property name="dist.dir" value="dist"/>

    <target name="init">
        <mkdir dir="${build.dir}"/>
        <mkdir dir="${dist.dir}"/>
    </target>

    <target name="compile" depends="init">
        <javac srcdir="${src.dir}" destdir="${build.dir}" includeantruntime="false"/>
    </target>

    <target name="jar" depends="compile">
        <jar destfile="${dist.dir}/myapp.jar" basedir="${build.dir}">
            <manifest>
                <attribute name="Main-Class" value="com.example.Main"/>
            </manifest>
        </jar>
    </target>

    <target name="clean">
        <delete dir="${build.dir}"/>
        <delete dir="${dist.dir}"/>
    </target>

</project>
```

### Adding extra JARs to ANT_HOME/lib

Ant loads additional JARs from `${ANT_HOME}/lib` at startup. Example — add the XZ compression library:

```sh
cd ${ANT_HOME}/lib
wget -c https://repo1.maven.org/maven2/org/tukaani/xz/1.9/xz-1.9.jar
```

## Usage, tips and tricks

```shell
# Run the default target
ant

# Run a specific target
ant jar

# List available targets (those with description attribute)
ant -projecthelp

# Use a specific build file
ant -f other-build.xml

# Pass a property override
ant -Ddist.dir=/tmp/output jar
```

### Property files

Externalise environment-specific values into a `.properties` file:

```shell
# build.properties
app.version=1.0.0
server.host=localhost
```

Load in build.xml:

```xml
<property file="build.properties"/>
```

### Ivy dependency management

Apache Ivy integrates with Ant to resolve Maven-style dependencies. Add `ivy.jar` to `ANT_HOME/lib`, create
`ivy.xml` with dependencies, then call `<ivy:retrieve/>` in your build.

## See also

* [Apache Ant home page](https://ant.apache.org/)
* [Apache Ant manual](https://ant.apache.org/manual/)
* [Apache Ivy](https://ant.apache.org/ivy/)
* [Maven](maven.md)
