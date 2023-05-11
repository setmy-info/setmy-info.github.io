# GPG

## Information

## Installation

### CentOS, Rocky Linux, Fedora

```sh
sudo dnf -y install gnupg
```

## Configuration

## Usage, tips and tricks

Start key (pair) generation

```sh
gpg --full-generate-key
```

List keys

```sh
gpg --list-keys
```

List keys

```sh
gpg --search-keys some.user@example.com
```

Export secret keys:

```sh
gpg --export-secret-keys -o secret-keys.asc
```

Export public keys:

```sh
gpg --export -a -o public-keys.asc
```

Export keys

```sh
mkdir -p ~/backup/gpg
gpg --export-secret-keys -o ~/backup/gpg/secret-keys.asc
gpg --export -a -o ~/backup/gpg/public-keys.asc
```

Import keys

```sh
gpg --import ~/backup/gpg/secret-keys.asc
gpg --import ~/backup/gpg/public-keys.asc
gpg --list-keys
gpg --list-secret-keys
```

Sign file

```sh
mkdir ~/temp
gpg --sign ~/temp/test.txt
```

Sign file, marking output file:

```sh
gpg --output ~/temp/test.txt.sig --detach-sig ~/temp/test.txt
```

Sign file, marking output file and using key id:

```sh
gpg --output ~/temp/test.txt.sig --local-user 1122334455667788990011223344556677889900 --detach-sig ~/temp/test.txt
gpg --output ~/temp/test.txt.sig --local-user "First Last (First Last) <first.last@example.com>" --detach-sig ~/temp/test.txt
```

Send keys to ()

```sh
gpg --send-keys key-id
```

```sh
gpg --recv-keys key-id
```

## See also

[keys.openpgp.org](https://keys.openpgp.org)
