# RPM

## Information

**RPM** (Red Hat Package Manager, recursively: RPM Package Manager) is the package format and low-level package
management tool used on RHEL, CentOS, Rocky Linux, Fedora, AlmaLinux, and SUSE/openSUSE. Package files use the
`.rpm` extension and contain compressed software, metadata, pre/post install scripts, and dependency declarations.

RPM is both a binary package format and a command-line tool. Higher-level tools (dnf, yum, zypper) call the RPM
database internally for dependency resolution; the `rpm` command is used for lower-level operations and package
building.

## Installation

The `rpm` command is built-in on all RPM-based distributions — no separate installation is needed.

For package building tools:

```shell
# Rocky Linux / CentOS / Fedora
sudo dnf install -y rpm-build rpmdevtools
```

## Configuration

### Repository files

Third-party repositories are configured as `.repo` files under `/etc/yum.repos.d/`:

```ini
[myrepo]
name=My Repository
baseurl=https://repo.example.com/el9/
enabled=1
gpgcheck=1
gpgkey=https://repo.example.com/GPG-KEY-myrepo
```

### GPG key verification

Packages should be signed. Import a GPG key:

```shell
sudo rpm --import https://repo.example.com/GPG-KEY-myrepo
```

## Usage, tips and tricks

### Basic rpm commands

```shell
# Install a package
rpm -i package.rpm
# Upgrade (or install if not present)
rpm -U package.rpm
# Erase / remove
rpm -e package-name
# Query: is this package installed?
rpm -q package-name
# List all files in an installed package
rpm -ql package-name
# Which package owns a file?
rpm -qf /usr/bin/bash
# List all installed packages
rpm -qa
# Show package info
rpm -qi package-name
# List all installed packages with versions, sorted
rpm -qa --queryformat '%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n' | sort
```

### Building an RPM package

Set up the build tree:

```shell
rpmdev-setuptree
# Creates ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
```

Minimal spec file (`~/rpmbuild/SPECS/myapp.spec`):

```spec
Name:           myapp
Version:        1.0.0
Release:        1%{?dist}
Summary:        My application
License:        MIT
Source0:        %{name}-%{version}.tar.gz

%description
My application description.

%prep
%autosetup

%build
make %{?_smp_mflags}

%install
make install DESTDIR=%{buildroot}

%files
%license LICENSE
%doc README.md
/usr/bin/myapp

%changelog
* Mon Jan 01 2024 Your Name <you@example.com> - 1.0.0-1
- Initial package
```

Build:

```shell
rpmbuild -ba ~/rpmbuild/SPECS/myapp.spec
```

Output: `~/rpmbuild/RPMS/` (binary) and `~/rpmbuild/SRPMS/` (source RPM).

### Spec file sections

| Section      | Purpose                                        |
|--------------|------------------------------------------------|
| `%prep`      | Unpack and patch sources                       |
| `%build`     | Compile                                        |
| `%install`   | Install into `%{buildroot}`                    |
| `%files`     | List files that go into the package            |
| `%changelog` | Chronological list of changes                  |
| `%pre`/`%post` | Scripts run before/after installation        |

## See also

* [RPM official site](https://rpm.org/)
* [Fedora Packaging Guidelines](https://docs.fedoraproject.org/en-US/packaging-guidelines/)
* [RPM Packaging Guide (Red Hat)](https://rpm-packaging-guide.github.io/)
* [Fedora](fedora.md)
