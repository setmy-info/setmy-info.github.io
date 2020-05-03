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
(Fill questions: EE, Harju, Tallinn, Private Company LLC, CA departement, Peeter Meeter, peeter.meeter@trump.com, 1234, Private Company LLC).

```
openssl req -new -key /usr/local/share/certs/CA.priv.key -out /usr/local/share/certs/CA.csr
```

Create **signed certificate** signed by third-party (parent CA) or by CA departement as self signed (currently self signing):

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

Sub-departement creates **certification request** (Fill questions: EE, Harju, Tallinn, Private Company LLC, RQ departement, Donald Trump, donald.trump@trump.com, 1234, Private Company LLC):

```sh
openssl req -new -key /usr/local/share/certs/RQ.priv.key -out /usr/local/share/certs/RQ.csr
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
MIIDijCCAvOgAwIBAgIJAKRvtQxONVZoMA0GCSqGSIb3DQEBBAUAMIGLMQswCQYD 
...
b6EjG/l4HW2BztYJfx15pk51M49TYS7okDKWYRT10y65xcyQdfUKvfDC1k5P9Q== 
-----END CERTIFICATE-----
```
