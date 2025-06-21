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
mosquitto_sub -d -V mqttv5 -h localhost -t "test/probe" -u "dev" -P "PASSWORD1234" -q 2 -i subscriber_id -c -v

# Retain (last message holding)
mosquitto_pub -V mqttv5 -h localhost -t test/topic -m "Last 1" -r
mosquitto_pub -V mqttv5 -h localhost -t test/topic -m "Last 2" -r
mosquitto_pub -V mqttv5 -h localhost -t test/topic -m "Last 3" -r

# Clearing retain message
mosquitto_pub -h localhost -t test/topic -m "" -r

# *nixes
# AWS IoT MQTT QoS: 0, 1 only
MQTT_ENDPOINT=xxxxxxxxxxxxxxxxxx-yyy.iot.eu-central-1.amazonaws.com
MQTT_ENDPOINT_PORT=8883
MQTT_QOS=1
MQTT_SUB_ID=mosquitto_sub
MQTT_PUB_ID=mosquitto_pub
CA_FILE=AmazonRootCA1.pem
CERT_FILE=certificate.crt
KEY_FILE=private.key

mosquitto_sub \
    -d \
    -h ${MQTT_ENDPOINT} \
    -p ${MQTT_ENDPOINT_PORT} \
    --cafile ${CA_FILE} \
    --cert ${CERT_FILE} \
    --key ${KEY_FILE} \
    -q ${MQTT_QOS} \
    -i ${MQTT_SUB_ID} \
    -t "test/topic" \
    --tls-version tlsv1.2

mosquitto_pub \
    -d \
    -h ${MQTT_ENDPOINT} \
    -p ${MQTT_ENDPOINT_PORT} \
    --cafile ${CA_FILE} \
    --cert ${CERT_FILE} \
    --key ${KEY_FILE} \
    -q ${MQTT_QOS} \
    -i ${MQTT_PUB_ID} \
    -t "test/topic" \
    -m "{\"message\": \"Hello from Mosquitto!\", \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" \
    --tls-version tlsv1.2

# Windows
@echo off
set MQTT_ENDPOINT=xxxxxxxxxxxxxxxxxx-yyy.iot.eu-central-1.amazonaws.com
set MQTT_ENDPOINT_PORT=8883
set MQTT_QOS=1
set MQTT_SUB_ID=mosquitto_sub
set MQTT_PUB_ID=mosquitto_pub
set CA_FILE=AmazonRootCA1.pem
set CERT_FILE=certificate.crt
set KEY_FILE=private.key

mosquitto_sub ^
    -d ^
    -h %MQTT_ENDPOINT% ^
    -p %MQTT_ENDPOINT_PORT% ^
    --cafile %CA_FILE% ^
    --cert %CERT_FILE% ^
    --key %KEY_FILE% ^
    -q %MQTT_QOS% ^
    -i %MQTT_SUB_ID% ^
    -t "test/topic" ^
    --tls-version tlsv1.2

mosquitto_pub ^
    -d ^
    -h %MQTT_ENDPOINT% ^
    -p %MQTT_ENDPOINT_PORT% ^
    --cafile %CA_FILE% ^
    --cert %CERT_FILE% ^
    --key %KEY_FILE% ^
    -q %MQTT_QOS% ^
    -i %MQTT_PUB_ID% ^
    -t "test/topic" ^
    -m "{\"message\": \"Hello from Mosquitto!\", \"timestamp\": \"%date% %time%\"}" ^
    --tls-version tlsv1.2
```

Publish:

```shell
# -u username -P password
mosquitto_pub -d -V mqttv5 -h localhost -t test/topic -q 2 -i publisher_id -c -m "{"firstName":"John","lastName":"Doe"}"
```

MQTT v3.1.1
V3 message size : 256 MB

Clean Session (bool)

MQTT v3.1.1

Session Expiry Interval (int seconds).

## See also

* [Web page](https://mosquitto.org/)

