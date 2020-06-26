# setmy-info-scripts

Mostly development helper and tooling Bourne shell and Python scripts.

Notable tools and commands:

- term (start terminal with specific development environment variables).
- smi-stealer (borrow code from from other GIT repositories and make changes to make solution)

## Architecture

## Requirements

## Development notes

### IDE

For Python: PyCharm

### Requirements

- latest cmake (probably >= 3.17.1 +)
- (GNU) make (probably >= 3.82)
- Python (probably >= 3.6.8)

### Build

```sh
./configure
make
make package
```

### Erase previous build

Execute if needed.

```
sudo rpm -e setmy-info-scripts
```

### Install built package

```
sudo rpm -i setmy-info-scripts-X.Y.Z.noarch.rpm
```

## QA: test guides and specifications

## Release notes

## Deployment notes

## Maintenance

