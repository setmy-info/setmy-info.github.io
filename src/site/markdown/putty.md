# Putty

## Information

## Installation

### Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Port forwarding

```text
1. Open PuTTYGen
2. Conversion -> Import Key -> id_ed25519
3. Save private key : id_ed25519.priv.ppk
4. Putty: Connection -> SSH -> Auth -> Credential -> Private key file for authentication: C:\Users\<USERNAME>\.ssh\id_ed25519.priv.ppk
5. Tunnel for Postgres: Putty: Connection -> SSH -> Tunnels -> Source port: 5433; Destination: db.example.com:5432
6. Session: username@ssh.server.exacmple.com : 22
7. Session: Save
8. Open
```

## See also

* [xxxx](http://yyyyy)
