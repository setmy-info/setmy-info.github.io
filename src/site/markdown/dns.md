# DNS, Bind

## Information

## Installation

### CentOS, Rocky Linux

```sh
sudo dnf install -y bind bind-utils
sudo systemctl enable named
sudo systemctl start named
sudo firewall-cmd --zone=trusted --add-source=10.0.0.0/8 --permanent
sudo firewall-cmd --zone=trusted --add-service=ssh --permanent
sudo firewall-cmd --zone=trusted --add-service=dns --permanen
```

**nano /file/path**

```
xxx
```

**nano /file/path**

```
xxx
```

**nano /file/path**

```
xxx
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)

