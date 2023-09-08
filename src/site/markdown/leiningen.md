# Leiningen

## Information

## Installation

### Fedora

As root

```sh
mkdir -p /opt/leiningen/bin
mkdir -p /opt/leiningen/lib
mkdir -p /opt/leiningen/self-installs
cd /opt/leiningen/bin
wget -c https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod ugo+x /opt/leiningen/bin/lein
cd /opt/leiningen/self-installs
wget -c https://github.com/technomancy/leiningen/releases/download/2.9.10/leiningen-2.9.10-standalone.jar
# Or
lein self-insstall
```

## Configuration

## Usage, tips and tricks

### Project generation

```shell
mkdir leiningen
cd leiningen
lein new app tutorial
cd tutorial
lein run
# Passing parameters
lein run ./test/resources/root
lein test
# Build with profiles
lein with-profile ci,OTHER_PROFILE test
lein uberjar
java -jar ".\target\default+uberjar\tutorial-0.1.0-SNAPSHOT-standalone.jar" fff
# Deploy to clojars - need to have ~/.lein/profiles.clj
# username is like login username, password can be token, in form CLOJARS_xxxxxxxxxxxxxxxx
lein deploy clojars
```

In folder:

    ~/.lein

```clojure
{:user
 {:clojars-auth  :gpg
  :sign-releases false
  :username      "USER_LOGIN_NAME"
  :password      :gpg}}
```

### Run specific test

```shell
lein test :only info.setmy.testing/hello-test
```

## See also

[Leiningen](https://leiningen.org/)

[Lein tutorial](https://codeberg.org/leiningen/leiningen/src/branch/stable/doc/TUTORIAL.md)

[Clojars](https://clojars.org/)
