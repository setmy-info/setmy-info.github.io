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

CA departement (usally IT departement or IT sup departement)
should generate **private key**:

```sh
openssl genrsa -out /usr/local/share/certs/CA.priv.key 2048
```

Then generate **public key** from provate key:

```sh
openssl rsa -in /usr/local/share/certs/CA.priv.key -pubout -out /usr/local/share/certs/CA.pub.key
```

Creates **certificate request** (.csr) for CA to sign certificate
(Fill questions: EE, Harju, Tallinn, Private Company LLC, CA departement, Peeter Meeter, peeter.meeter@trump.com, 1234,
Private Company LLC).

```
openssl req -new -key /usr/local/share/certs/CA.priv.key -out /usr/local/share/certs/CA.csr
```

Create **signed certificate** signed by third-party (parent CA) or by CA departement as self signed (currently self
signing):

```sh
openssl x509 -req -days 2048 -in /usr/local/share/certs/CA.csr -signkey /usr/local/share/certs/CA.priv.key -out /usr/local/share/certs/CA.crt
```

Now CA departement have root signed certificate.

### Requestor

To have certificates for organization other departements, IT infrastructure systems need to do following.

Sub-departement creates **private key** for them selves (for some IT systems, services):

```sh
openssl genrsa -out /usr/local/share/certs/RQ.priv.key 2048
```

Sub-departement creates **public key**

```sh
openssl rsa -in /usr/local/share/certs/RQ.priv.key -pubout -out /usr/local/share/certs/RQ.pub.key
```

Sub-departement creates **certification request** (Fill questions: EE, Harju, Tallinn, Private Company LLC, RQ
departement, Donald Trump, donald.trump@trump.com, 1234, Private Company LLC):

```sh
openssl req -new -key /usr/local/share/certs/RQ.priv.key -out /usr/local/share/certs/RQ.csr
```

Probably by case have to add following options:

* **-addext "keyUsage=critical"**
* **-addext "subjectAltName = DNS:${DOMAIN_NAME}"**

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

## See also

[Firefox cert extension changes](https://support.mozilla.org/en-US/questions/1379667)
