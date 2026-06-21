# Clojars

## Information

Clojars is the community artifact repository for Clojure libraries — analogous to Maven Central but focused on the
Clojure ecosystem. It hosts open-source Clojure and ClojureScript libraries and is the default repository used by
Leiningen and deps.edn projects.

Published artifacts follow Maven coordinates (group-id/artifact-id) and are consumed via Leiningen's `project.clj`
or tools.deps `deps.edn`.

**Publishing to Clojars:**

1. Create an account at [clojars.org](https://clojars.org/).
2. Generate a deploy token (from account settings).
3. Use `lein deploy clojars` or `clojure -T:build deploy` with the token in `~/.lein/credentials.clj`.

## Installation

No separate installation needed. Clojars is a remote Maven repository. Configure it in your build tool.

**Leiningen** — already includes Clojars by default.

**deps.edn** — add as an alias or in `:mvn/repos`:

```clojure
{:mvn/repos {"clojars" {:url "https://clojars.org/repo"}}}
```

## Configuration

### Internal / private Clojars server

For a self-hosted Clojars instance (e.g., `clojars.gintra`), configure Maven and Leiningen to use it.

Maven **~/.m2/settings.xml**:

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

**project.clj**:

```clojure
:repositories
[["web-clojars-repo" "http(s)://teie-serveri-aadress/clojars/"]
 ["nfs-clojars-repo" "file:///some/nfs/share/with/www/clojars"]]
```

## Usage, tips and tricks

* Use `lein search <term>` to find libraries available on Clojars.
* Pin library versions in `project.clj` to avoid unexpected upgrades.
* Use `lein ancient` to check for outdated dependencies.
* Prefer group IDs prefixed with your domain (e.g., `info.setmy/my-lib`) when publishing.

## See also

* [Clojars.org](https://clojars.org/)
* [Leiningen](leiningen.md)
* [Clojure](clojure.md)
* [Maven](maven.md)
