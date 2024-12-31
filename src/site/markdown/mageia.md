# Mageia Linux

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### RPM rebuild with changes

```bash
sudo urpmi rpmdevtools rpmlint rpm-build
rpmdev-setuptree

cd ~/rpmbuild/SRPMS/
urpmi --get-source bc

cd ~/rpmbuild/BUILD/
tar -xvzf ~/rpmbuild/SOURCES/bc-1.07.1.tar.gz
mkdir ~/rpmbuild/BUILD/bc-1.07.1-changed
tar -xvzf ~/rpmbuild/SOURCES/bc-1.07.1.tar.gz --strip-components=1 -C ~/rpmbuild/BUILD/bc-1.07.1-changed
cd ~

cd ~/rpmbuild/BUILD/
diff -urN bc-1.07.1 bc-1.07.1-changed > ~/rpmbuild/SOURCES/bc-1.07.1-changed.patch
cd ~
```

```bash
nano ~/rpmbuild/SPECS/bc.spec
```

```spec
Patch0: bc-1.07.1-changed.patch
```

```bash
sudo urpmi --buildrequires bc
rpmbuild -ba ~/rpmbuild/SPECS/bc.spec
```

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
