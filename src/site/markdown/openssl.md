# openssl

## See key content

```sh
cd ~/.ssh
openssl dsa -in ~/.ssh/id_dsa -text
openssl rsa -in ~/.ssh/id_rsa -text
```

See certificate (.crt) content:

```sh
openssl x509 -in abc.crt -noout -text
# Or
openssl x509 -in abc.crt -text
```

To check DER:

```sh
openssl x509 -in abc.crt -inform DER -text
```

To check pkcs12:

```sh
openssl pkcs12 -in abc.crt -info
```

Create cert request (QA needed: need to check!):

```sh
openssl req -new -key ~/.ssh/id_dsa -out mykey.csr
```

Certificate format converting (QA needed: need to check!):

```sh
openssl x509 -inform der -in ./my.der -outform pem -out my.pem
```

## Organizational CA

### Become as CA

Become as CA probably inside company.

CA department (usually IT department or IT sup department)
should generate **private key**:

```sh
openssl genrsa -out /usr/local/share/certs/CA.priv.key 2048
```

Then generate **public key** from provate key:

```sh
openssl rsa -in /usr/local/share/certs/CA.priv.key -pubout -out /usr/local/share/certs/CA.pub.key
```

Creates **certificate request** (.csr) for CA to sign certificate (Fill questions: EE, Harjumaa, Tallinn, Private
Company LLC, CA department, Peeter Meeter, peeter.meeter@trump.com,
1234,
Private Company LLC).

```
openssl req -new -key /usr/local/share/certs/CA.priv.key -out /usr/local/share/certs/CA.csr
```

Create **signed certificate** signed by third-party (parent CA) or by CA department as self-signed (currently self
signing):

```sh
openssl x509 -req -days 2048 -in /usr/local/share/certs/CA.csr -signkey /usr/local/share/certs/CA.priv.key -out /usr/local/share/certs/CA.crt
```

Now CA departement have root signed certificate.

### Requester

To have certificates for organization other departements, IT infrastructure systems need to do following.

Sub-department creates **private key** for themselves (for some IT systems, services):

```sh
openssl genrsa -out /usr/local/share/certs/RQ.priv.key 2048
```

Sub-departement creates **public key**

```sh
openssl rsa -in /usr/local/share/certs/RQ.priv.key -pubout -out /usr/local/share/certs/RQ.pub.key
```

Sub-department creates **certification request** (Fill questions: EE, Harju, Tallinn, Private Company LLC, RQ
department, Donald Trump, donald.trump@trump.com, 1234, Private Company LLC):

```sh
DOMAIN_NAME_SUFFIX=example.com
openssl req -new -key /usr/local/share/certs/RQ.priv.key -addext "keyUsage=critical,digitalSignature,keyEncipherment" -addext "subjectAltName=DNS:*.${DOMAIN_NAME_SUFFIX},DNS:${DOMAIN_NAME_SUFFIX}" -out /usr/local/share/certs/RQ.csr
```

### CA departement

Signs CSR

```sh
openssl x509 -req -in /usr/local/share/certs/RQ.csr -CA /usr/local/share/certs/CA.crt -CAkey /usr/local/share/certs/CA.priv.key -CAcreateserial -out /usr/local/share/certs/RQ.crt
```

### Requestor

```sh
cat /usr/local/share/certs/CA.crt > /usr/local/share/certs/CA.bundle
```

## Formats

* PEM
* DER
* pkcs12

DER and pkcs12 are binary formats.

PEM format are text formats:

```
-----BEGIN CERTIFICATE-----
MIID1TCCAr0CFHc9NenQAeSBLYFsYBJ9ddTeRUDKMA0GCSqGSIb3DQEBCwUAMIGm
...
RaoghItDqV64Y9FGSpI1upI0BoBzo+svDg==
-----END CERTIFICATE-----
```

## Arguments

```
-subj "/C=ET/ST=Harjumaa/L=Tallinn/O=Example Tallinn Company/CN=exampletln.com"
-subj "/C=ET/ST=Tartumaa/L=Tartu/O=Example Tartu Inc/CN=example.com/emailAddress=admin@example.com/OU=Some Org Unit"
/C  - countryName
/ST - stateOrProvinceName
/L  - localityName
/O  - organizationName
/CN - commonName
/OU - organizationalUnitName
/emailAddress - emailAddress
```

## Adding CA certs for linux tools

wget, curl, ...

```shell
GINTRA_LOCATION=/some/dir
sudo cp ${GINTRA_LOCATION}/organizations/ee/has/development/configuration/pki/ca/has.ee.gintra.crt /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust
```

## CA, Intermediate CA, server/service cert and client cert - leaf certs, mTLS

| Kind                      | Signed by           | Must carry                                             | Job                            |
|---------------------------|---------------------|--------------------------------------------------------|--------------------------------|
| CA, the root              | itself, self signed | `CA:TRUE`, `Certificate Sign`                          | the trust anchor, kept offline |
| Intermediate CA           | the CA              | `CA:TRUE`, `Certificate Sign`                          | signs the leaves               |
| server/service cert, leaf | the Intermediate CA | `CA:FALSE`, EKU `TLS Web Server Authentication`, a SAN | proves the name of the service |
| client cert, leaf         | the Intermediate CA | `CA:FALSE`, EKU `TLS Web Client Authentication`        | proves who is calling          |

### Which side holds what, and in what order inside the file

|            | Server, the service                                        | Client, the caller                                         |
|------------|------------------------------------------------------------|------------------------------------------------------------|
| own chain  | `server.fullchain.crt`: #1 server leaf, #2 Intermediate CA | `client.fullchain.crt`: #1 client leaf, #2 Intermediate CA |
| own key    | `private/server.priv.key`: the key alone                   | `private/client.priv.key`: the key alone                   |
| trust file | `ca.chain.crt`: #1 Intermediate CA, #2 CA                  | `ca.chain.crt`: #1 Intermediate CA, #2 CA                  |

* a fullchain is what the handshake sends, so the order is the chain: leaf first, then its issuer. Reversed,
  nothing works;
* the order inside the trust file does not matter, but both certificates have to be in it;
* no private key in a `.crt`, no passphrase on a key a service starts with, and no root CA needed in a fullchain.

```shell
cat server.crt intermediate-ca.crt > server.fullchain.crt
cat client.crt intermediate-ca.crt > client.fullchain.crt
cat intermediate-ca.crt ca.crt     > ca.chain.crt

openssl crl2pkcs7 -nocrl -certfile server.fullchain.crt | openssl pkcs7 -print_certs -noout
```

The last command prints the file in file order: the first `subject=` has to be the leaf, and the `issuer=` of
each certificate the `subject=` of the one below it. `openssl x509` and `openssl verify` read only the first
certificate of a file, so neither of them can tell you this.

## See also

[Firefox cert extension changes](https://support.mozilla.org/en-US/questions/1379667)
