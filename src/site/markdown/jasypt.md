# Jasypt

## Information

Jasypt (Java Simplified Encryption) is a Java library for encrypting and decrypting values in application configuration
files. It is commonly used with Spring Boot to protect database passwords, API keys, and other secrets stored in
`application.properties` or `application.yml`. A CLI distribution lets you generate encrypted values from the command
line without writing code.

The `jasypt-spring-boot-starter` integrates transparently: values wrapped in `ENC(...)` in property files are
decrypted automatically at startup using a master password supplied via an environment variable or system property.

## Installation

### Maven

```xml
<dependency>
    <groupId>com.github.ulisesbocchio</groupId>
    <artifactId>jasypt-spring-boot-starter</artifactId>
    <version>3.0.5</version>
</dependency>
```

### CLI (download separately)

Download the distribution JAR from the [Jasypt releases page](https://github.com/jasypt/jasypt/releases) and unpack.
The `bin/` directory contains `encrypt.sh` / `encrypt.bat` and `decrypt.sh` / `decrypt.bat` scripts.

## Configuration

Set the master password as an environment variable (preferred over putting it in the config file):

```shell
export JASYPT_ENCRYPTOR_PASSWORD=my-secret-master-password
```

Or pass it as a JVM system property:

```shell
java -Djasypt.encryptor.password=my-secret-master-password -jar app.jar
```

In `application.properties`, wrap encrypted values with `ENC(...)`:

```properties
spring.datasource.password=ENC(zIiWGQoAxrogbkleQNELuEbxWivzSFcblLQt/2GH3TK/x5G9YmKVQ2h1J921Oju1)
jasypt.encryptor.password=${JASYPT_ENCRYPTOR_PASSWORD}
```

## Usage, tips and tricks

Encrypt and decrypt using the CLI scripts:

```shell
encrypt input="This is my message to be encrypted" password=MYPAS_WORD
decrypt input="zIiWGQoAxrogbkleQNELuEbxWivzSFcblLQt/2GH3TK/x5G9YmKVQ2h1J921Oju1" password=MYPAS_WORD
```

### Coding tips and tricks

Override the default algorithm or salt generator in `application.properties`:

```properties
jasypt.encryptor.algorithm=PBEWithMD5AndDES
jasypt.encryptor.string-output-type=base64
```

For stronger encryption use `PBEWITHHMACSHA512ANDAES_256` (requires unlimited JCE policy, available by default in
Java 9+).

## See also

* [Home page](http://www.jasypt.org)
* [GitHub](https://github.com/jasypt/jasypt)
* [Download](https://github.com/jasypt/jasypt/releases)
* [jasypt-spring-boot](https://github.com/ulisesbocchio/jasypt-spring-boot)
