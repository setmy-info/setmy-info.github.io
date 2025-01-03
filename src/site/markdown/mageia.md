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
sudo urpmi --auto rpmdevtools rpmlint rpm-build nano mc wget
rpmdev-setuptree

cd ~/rpmbuild/SRPMS/
urpmi --get-source bc
wget https://mirror.yandex.ru/mageia/distrib/9/SRPMS/core/release/bc-1.07.1.mga9.src.rpm
#rpm -ivh bc-1.07.1.mga9.src.rpm
rpm -Uvh bc-1.07.1.mga9.src.rpm

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

#### Chrony (NTP) SRPM rebuild with changes

```bash
sudo urpmi --auto rpmdevtools rpmlint rpm-build nano mc wget
rpmdev-setuptree

# Is it needed?
sudo urpmi --auto chrony

cd ~/rpmbuild/SRPMS/
#    https://fr2.rpmfind.net/linux/mageia/iso/9/Mageia-9-x86_64/Mageia-9-x86_64.iso
wget https://mirror.yandex.ru/mageia/distrib/9/SRPMS/core/release/chrony-4.3-1.mga9.src.rpm
#rpm -ivh chrony-4.3-1.mga9.src.rpm
rpm -Uvh chrony-4.3-1.mga9.src.rpm

cd ~/rpmbuild/BUILD/
tar -xvzf ~/rpmbuild/SOURCES/chrony-4.3.tar.gz
mkdir ~/rpmbuild/BUILD/chrony-4.3-changed
tar -xvzf ~/rpmbuild/SOURCES/chrony-4.3.tar.gz --strip-components=1 -C ~/rpmbuild/BUILD/chrony-4.3-changed
cd ~

# Here make changes in changed folder
# For example: examples/chrony.conf.example2
nano ~/rpmbuild/BUILD/chrony-4.3-changed/examples/chrony.conf.example2

cd ~/rpmbuild/BUILD/
diff -urN chrony-4.3 chrony-4.3-changed > ~/rpmbuild/SOURCES/chrony-4.3-changed.patch
cd ~
```

```bash
nano ~/rpmbuild/SPECS/chrony.spec
```

```spec
Patch0: chrony-4.3-changed.patch
```

```bash
urpmi --auto --buildrequires ~/rpmbuild/SRPMS/chrony-4.3-1.mga9.src.rpm
rpmbuild -ba ~/rpmbuild/SPECS/chrony.spec
```

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
