# mosquitto

## Information

## Installation

```shell
sudo dnf install mosquitto
sudo systemctl daemon-reload
sudo systemctl enable mosquitto
sudo systemctl start mosquitto
```

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

Subscribe:

```shell
mosquitto_sub -h localhost -t test/topic
```

Publish:

```shell
mosquitto_pub -h localhost -t test/topic -m "{"firstName":"John","lastName":"Doe"}"
```

V3 message size : 256 MB

## See also

* [Web page](https://mosquitto.org/)

