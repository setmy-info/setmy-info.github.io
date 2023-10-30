# Janet Language

## Information

## Installation

### CentOS, Rocky Linux

```shell
wget https://github.com/janet-lang/janet/releases/download/v1.32.1/janet-v1.32.1-linux-x64.tar.gz
cd /opt/
sudo tar xvzf janet-v1.32.1-linux-x64.tar.gz
sudo ln -s /opt/janet-xxxxxxxxxxx /opt/janet
```

Export Janet:

```shell
export JANET_PATH=/opt/janet
export PATH=${JANET_PATH}/bin:${PATH}
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

**project.janet**

```shell
nano ./project.janet
```

```clojure
(declare-project
  :name "abclib" # required
  :description "A library example"
  :dependencies ["https://github.com/janet-lang/json.git"])

(declare-source
  :source ["abclib.janet"])

(declare-native
 :name "abcnative"
 :source ["abcnative.c" "abcsupport.c"]
 :embedded ["extra-functions.janet"])

(declare-executable
 :name "abcexec"
 :entry "main.janet")
```

### Coding tips and tricks

## See also

[Home page](https://janet-lang.org/)

[jpm](https://janet-lang.org/1.16.1/docs/jpm.html)
