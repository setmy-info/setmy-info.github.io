# mosquitto

## Information

## Installation

```shell
sudo dnf install mosquitto
sudo systemctl daemon-reload
sudo systemctl enable mosquitto
```

```shell
grep -vE '^#' /etc/mosquitto/mosquitto.conf | grep -E .
sudo nano /etc/mosquitto/mosquitto.conf
```

    per_listener_settings true
    listener 1883
    protocol mqtt
    allow_anonymous false
    password_file /etc/mosquitto/passwd
    listener 9001
    protocol websockets
    socket_domain ipv4
    allow_anonymous false
    password_file /etc/mosquitto/passwd

```shell
# firewall-cmd --add-port=1883/tcp --permanent
sudo mosquitto_passwd -c /etc/mosquitto/passwd USERNAME
chown mosquitto:mosquitto /etc/mosquitto/passwd
sudo systemctl start mosquitto
sudo systemctl restart mosquitto
lsof -i :1883 -i :9001
```

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

Subscribe:

```shell
# -u username -P password
mosquitto_sub -h localhost -t test/topic

# Retain (last message holding)
mosquitto_pub -h localhost -t test/topic -m "Last 1" -r
mosquitto_pub -h localhost -t test/topic -m "Last 2" -r
mosquitto_pub -h localhost -t test/topic -m "Last 3" -r

# Clearing retain message
mosquitto_pub -h localhost -t test/topic -m "" -r
```

Publish:

```shell
# -u username -P password
mosquitto_pub -h localhost -t test/topic -m "{"firstName":"John","lastName":"Doe"}"
```

V3 message size : 256 MB

## See also

* [Web page](https://mosquitto.org/)

