# RabbitMQ

## Information

## Installation

### CentOS, Rocky Linux

	sudo rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
	sudo dnf install socat logrotate -y
	wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v4.1.1/rabbitmq-server-4.1.1-1.el8.noarch.rpm
	wget https://github.com/rabbitmq/erlang-rpm/releases/download/v27.3.4.1/erlang-27.3.4.1-1.el9.x86_64.rpm
	sudo dnf install -y erlang-27.3.4.1-1.el9.x86_64.rpm
	sudo dnf install -y rabbitmq-server-4.1.1-1.el8.noarch.rpm

	sudo systemctl enable rabbitmq-server
	sudo systemctl start rabbitmq-server
	sudo sudo systemctl status rabbitmq-server
	sudo firewall-cmd --add-port=15672/tcp --permanent
	sudo firewall-cmd --reload
	sudo rabbitmq-plugins enable rabbitmq_management
		Drfault login (localhost only): guest:guest

    sudo rabbitmq-plugins enable rabbitmq_mqtt
    sudo rabbitmqctl add_user admin parool
    sudo rabbitmqctl set_user_tags admin administrator
    sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
    sudo rabbitmqctl add_vhost dev
    sudo rabbitmqctl add_vhost test
    sudo rabbitmqctl add_vhost prelive
    sudo rabbitmqctl add_vhost live
    sudo rabbitmqctl list_feature_flags

### Windows

* [Download and Installation page](https://www.rabbitmq.com/docs/install-windows#installer)
* [Installer](https://github.com/rabbitmq/rabbitmq-server/releases/download/v4.1.1/rabbitmq-server-4.1.1.exe)

```shell
set RABBITMQ_HOME=C:\Program Files\RabbitMQ Server\rabbitmq_server-4.1.1
set RABBITMQ_BIN_DIR=%RABBITMQ_HOME%\sbin
set PATH=%RABBITMQ_BIN_DIR%;%PATH%

curl -o rabbitmqadmin.py http://localhost:15672/cli/rabbitmqadmin

rabbitmq-plugins --version
rabbitmqctl --version
```

```shell
@echo off
py %~dp0\rabbitmqadmin.py %*
```

```shell
rabbitmqadmin --version

rabbitmq-plugins enable rabbitmq_mqtt
rabbitmq-plugins enable rabbitmq_management
rabbitmqctl add_user admin PASSWORD1234
rabbitmqctl set_user_tags admin administrator
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
rabbitmqctl set_permissions -p dev admin ".*" ".*" ".*"
rabbitmqctl add_vhost dev

# 1. Create user with password: dev : PASSWORD1234
rabbitmqctl add_user dev PASSWORD1234

# 2. Create virtual Host: dev
rabbitmqctl add_vhost dev

# 3. Set rights for user
rabbitmqctl set_permissions -p dev dev ".*" ".*" ".*"

# 4. Check
curl -u dev:PASSWORD1234 http://localhost:15672/api/whoami

# 5. Add administrator rights - just example, really if needed for particular user
rabbitmqctl set_user_tags dev administrator

# 6. Create Queue: test_queue
rabbitmqadmin -u dev -p PASSWORD1234 -V dev declare queue name=test_queue durable=true
rabbitmqadmin -u dev -p PASSWORD1234 -V dev declare queue name=test_queue2 durable=true

# 7. Create MQTT topic exchange: test.topic.exchange (type topic)
rabbitmqadmin -u dev -p PASSWORD1234 -V dev declare exchange name=test.topic.exchange type=topic durable=true
rabbitmqadmin -u dev -p PASSWORD1234 -V dev declare exchange name=test.topic.exchange type=topic durable=true

# 8. Bind exchange with routing key "test/topic" to the queue. Instead: "test/topic" shoule be "test.topic"
rabbitmqadmin -u dev -p PASSWORD1234 -V dev declare binding source=test.topic.exchange  destination=test_queue routing_key=test.topic
REM x-match = all
REM x-match = any
rabbitmqadmin -u dev -p PASSWORD1234 -V dev declare binding source=test.topic.exchange2 destination=test_queue2 arguments="{\"x-match\":\"all\",\"X-Application-Id\":\"test\",\"X-Tenant-Id\":\"tenant-1234\"}"

# 9. Check queues
rabbitmqctl list_queues --vhost dev name messages_ready messages_unacknowledged
rabbitmqctl list_queues --vhost / name messages_ready messages_unacknowledged
rabbitmqctl list_queues name messages_ready messages_unacknowledged

# 10. As administrator to start or stop service
net stop RabbitMQ
net start RabbitMQ

# USe Mosquitto provided commands to send messages and subscribe to queues
mosquitto_sub -h localhost -t "test/probe" -u "dev" -P "PASSWORD1234" -q 2 -v
mosquitto_pub -h localhost -t "test/probe" -u "dev" -P "PASSWORD1234" -q 2 -m "Hello MQTT!"

#Check is it working
mosquitto_sub -d -V mqttv5 -h localhost -t "test/probe" -u "dev" -P "PASSWORD1234" -q 2 -i subscriber_id -c -v
mosquitto_pub -d -V mqttv5 -h localhost -t "test/probe" -u "dev" -P "PASSWORD1234" -q 1 -i publisher_id -c -m "Hello MQTT!"
```

## Configuration

```erlang
[
  {rabbitmq_mqtt, [
    {allow_anonymous, false},
    {default_user, <<"dev">>},
    {default_pass, <<"PASSWORD1234">>},
    {vhost, <<"dev">>},
    {exchange, <<"test.topic.exchange">>},

	{max_connections, 10000},
    {max_connection_lifetime, 5000},

	{prefetch, 1},
    {default_qos, 1},
	{retained_messages_store, {ram, disc}},

	{tcp_listen_options, [
      {backlog, 4096},
      {nodelay, true},
      {linger, {true, 5}},
      {exit_on_close, false}
    ]}

  ]}
].
```

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
[xxxx](http://yyyyy)
[xxxx](http://yyyyy)
[xxxx](http://yyyyy)
[xxxx](http://yyyyy)
[xxxx](http://yyyyy)
[xxxx](http://yyyyy)
[xxxx](http://yyyyy)
[xxxx](http://yyyyy)
[xxxx](http://yyyyy)
[xxxx](http://yyyyy)

