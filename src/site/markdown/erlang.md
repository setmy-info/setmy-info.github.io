# Erlang

## Information

## Installation

### Rocky Linux

#### Git

```shell
sudo dnf groupinstall "Development Tools" -y
sudo dnf install -y \
  gcc gcc-c++ make perl wget tar xz unzip git \
  ncurses-devel \
  openssl-devel \
  unixODBC-devel \
  wxWidgets \
  wxGTK-devel \
  libxslt

cd ~/sources/others
git clone https://github.com/erlang/otp.git erlang
cd erlang

LATEST_TAG=$(git tag --sort=-version:refname | grep '^OTP-' | grep -v -- '-rc' | head -n 1)
ERLANG_VERSION=${LATEST_TAG#OTP-}
echo "Latest OTP tag: $LATEST_TAG ($ERLANG_VERSION)"
git checkout "$LATEST_TAG"

#./configure --prefix=/opt/erlang-$ERLANG_VERSION--without-javac
#./configure --prefix=/opt/erlang-$ERLANG_VERSION --without-wx --without-javac
#./configure --prefix=/opt/erlang-$ERLANG_VERSION --without-wx --without-javac --disable-debugger --disable-observer --disable-hipe 
./configure --prefix=/opt/erlang-$ERLANG_VERSION --without-wx --without-javac --disable-debugger --disable-observer --disable-hipe --disable-et --disable-megaco --disable-dialyzer --disable-typer

make
sudo make install
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [Erlang Home page](https://www.erlang.org/)
* [Erlang Source Code](https://github.com/erlang/otp)
