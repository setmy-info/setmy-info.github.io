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
    listener 1883 127.0.0.1
    protocol mqtt
    persistence true
    persistence_file mosquitto.db
    persistence_location /var/lib/mosquitto/
    autosave_interval 1
    autosave_on_changes true
    max_queued_messages 0
    max_queued_bytes 0
    max_inflight_messages 1
    allow_anonymous false
    password_file /etc/mosquitto/passwd
    #acl_file /etc/mosquitto/aclfile
    listener 9001
    protocol websockets
    socket_domain ipv4
    allow_anonymous false
    password_file /etc/mosquitto/passwd

```shell
sudo dnf install mosquitto
rpm -ql mosquitto | grep -E 'mosquitto.conf|mosquitto.service|/etc/mosquitto'
rpm -ql mosquitto
ls -la /etc/mosquitto
ls -laZ /etc/mosquitto

sudo install -d -o root -g root -m 0755 /etc/mosquitto
sudo install -d -o mosquitto -g mosquitto -m 0700 /var/lib/mosquitto
sudo install -d -o mosquitto -g mosquitto -m 0750 /var/log/mosquitto

sudo mosquitto_passwd -c /etc/mosquitto/passwd USERNAME

sudo chown root:root /etc/mosquitto
sudo chmod 755 /etc/mosquitto
sudo chown root:root /etc/mosquitto/mosquitto.conf
sudo chmod 644 /etc/mosquitto/mosquitto.conf
sudo chown root:mosquitto /etc/mosquitto/passwd
sudo chmod 640 /etc/mosquitto/passwd
sudo chown mosquitto:mosquitto /var/lib/mosquitto
sudo chmod 700 /var/lib/mosquitto
sudo chown mosquitto:mosquitto /var/log/mosquitto
sudo chmod 750 /var/log/mosquitto

sudo restorecon -RFv /etc/mosquitto /var/lib/mosquitto /var/log/mosquitto

sudo systemctl daemon-reload
sudo systemctl enable mosquitto
sudo systemctl restart mosquitto

lsof -i :1883 -i :9001
sudo ss -lntup | grep 1883
ls -laZ /etc/mosquitto
```

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

Subscribe:

```shell
mosquitto_sub -d -V mqttv5 -h localhost -t "ee/test/dok" -u "has" -P "xxxxx" -q 2 -i subscriber_id -c -v
mosquitto_pub -d -V mqttv5 -h localhost -p 1883 -u "has" -P "xxx" -t "ee/test/dok" -m "Critical QoS 2 message" -q 2

mosquitto_sub -d -V mqttv5 -h localhost -p 8883 --cafile /path/to/ca.crt --cert /path/to/client.crt --key /path/to/client.key --tls-version tlsv1.3 -t "ee/test/dok" -q 2 -i subscriber_id -c -v
mosquitto_pub -d -V mqttv5 -h localhost -p 8883 --cafile /path/to/ca.crt --cert /path/to/client.crt --key /path/to/client.key --tls-version tlsv1.3 -t "ee/test/dok" -m "Critical QoS 2 message" -q 2
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

