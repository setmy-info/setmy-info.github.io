# Java

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```shell
# Intranet CA
JAVA_HOME=/opt/jdk
GINTRA_LOCATION=/some/dir
keytool -import -alias has_ee_gintra -keystore ${JAVA_HOME}/lib/security/cacerts -file ${GINTRA_LOCATION}/organizations/ee/has/development/configuration/pki/ca/has.ee.gintra.crt
# CA signed certs
keytool -import -alias intranet_has_ee_gintra -keystore ${JAVA_HOME}/lib/security/cacerts -file ${GINTRA_LOCATION}/organizations/ee/has/development/configuration/pki/intranet.has.ee.gintra.crt
```

### Coding tips and tricks

## See also

PircBotX: A powerful and easy-to-use IRC library for Java, which supports both synchronous and asynchronous
communication with IRC servers.
jIRC: Another Java library for IRC communication, which offers support for DCC chat and file transfer, as well as
customizable event handling.
Smack IRC: A lightweight Java library for IRC communication, which offers support for SSL and TLS encryption, as well as
custom event handling.
IrcClient: A simple Java IRC client library, which supports basic IRC commands and event handling.
Java IRC API: A Java IRC library that offers support for basic IRC commands, as well as custom event handling and plugin
architecture.

PircBotX: https://github.com/TheLQ/pircbotx
IrcBot: https://github.com/sorcix/ircbot
Smack IRC: https://github.com/igniterealtime/Smack/tree/master/smack-irc
Javacord: https://github.com/Javacord/Javacord/tree/master/javacord-irc
TinyIRC: https://github.com/Claymore007/TinyIRC

[Java, Groovy, Kotlin reactive FW](https://vertx.io/)
