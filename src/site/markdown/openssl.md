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
```

Create cert request (QA needed: need to check!):

```sh
openssl req -new -key ~/.ssh/id_dsa -out mykey.csr
```

Certificate format converting (QA needed: need to check!):

```sh
openssl x509 -inform der -in ./my.der -outform pem -out my.pem
```
