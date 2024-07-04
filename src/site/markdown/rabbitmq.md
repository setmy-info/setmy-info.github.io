# RabbitMQ

## Information

## Installation

### CentOS, Rocky Linux

	sudo rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
	sudo dnf install socat logrotate -y
	wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.12.6/rabbitmq-server-3.12.6-1.el8.noarch.rpm
	wget https://github.com/rabbitmq/erlang-rpm/releases/download/v26.1.2/erlang-26.1.2-1.el9.x86_64.rpm
	sudo dnf install -y erlang-26.1.2-1.el9.x86_64.rpm
	sudo dnf install -y rabbitmq-server-3.12.6-1.el8.noarch.rpm

	sudo systemctl enable rabbitmq-server
	sudo systemctl start rabbitmq-server
	sudo sudo systemctl status rabbitmq-server
	sudo firewall-cmd --add-port=15672/tcp --permanent
	sudo firewall-cmd --reload
	sudo rabbitmq-plugins enable rabbitmq_management
		Drfault login (localhost only): guest:guest

    rabbitmq-plugins enable rabbitmq_mqtt

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)

