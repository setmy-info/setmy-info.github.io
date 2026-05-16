# Template

## Information

## Installation

### Rocky Linux

#### Git

```shell
cd ~/sources/others
git clone https://github.com/elixir-lang/elixir.git elixir
cd elixir

LATEST_TAG=$(git tag --sort=-version:refname \
  | grep '^v' \
  | grep -v -- '-rc' \
  | grep -v -- '-alpha' \
  | grep -v -- '-beta' \
  | head -n 1)
ELIXIR_VERSION=${LATEST_TAG#v}
echo "Latest Elixir stable tag: $LATEST_TAG ($ELIXIR_VERSION)"
git checkout "$LATEST_TAG"

make clean compile
sudo mkdir -p /opt/elixir-1.19.5
sudo cp -r . /opt/elixir-1.19.5
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
* [Erlang Package Repo](https://hex.pm/)
