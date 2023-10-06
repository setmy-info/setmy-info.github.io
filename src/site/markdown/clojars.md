# Clojars

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Internal local Clojars server

Maven **~/.m2/settings.xml**

```xml

<repositories>
    <repository>
        <id>minu-repo</id>
        <url>http(s)://clojars.gintra/clojars/</url>
    </repository>
</repositories>
<pluginRepositories>
<pluginRepository>
    <id>minu-repo</id>
    <url>http(s)://clojars.gintra/clojars/</url>
</pluginRepository>
</pluginRepositories>
```

**project.clj**

```clojure
:repositories

[["web-clojars-repo" "http(s)://teie-serveri-aadress/clojars/"]
 ["nfs-clojars-repo" "file:///some/nfs/share/with/www/clojars"]]
```

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
