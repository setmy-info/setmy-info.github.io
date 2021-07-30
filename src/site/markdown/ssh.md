# SSH

## Autologin and key based authentication

Prefer in order algorithms (highest first):

* **ed25519**
* ecdsa
* rsa
* dsa

Prefer lengths in bits, even when some algorithms suggest shorter:

* **4096**

On **server side**:

```sh
mkdir ~/.ssh
chmod 700 ~/.ssh
```

On **client side** on password request enter password or just press Enter to make auto login:

```sh
cd ~/.ssh
ssh-keygen -t ed25519 -b 4096 -C "e@mail.domain"
```

Change private key access:

```sh
cd ~/.ssh
chmod 600 id_ed25519
```

Append public key to **authorized_keys**:

```sh
cd ~/.ssh
cat id_ed25519.pub >> authorized_keys
chmod 600 authorized_keys
```

Copy authorized_keys to server side:

```sh
cd ~/.ssh
scp authorized_keys ${REMOTE_USER}@${REMOTE_MACHINE}:~/.ssh
```

Or on client side:

```sh
mkdir ~/bin
nano ~/bin/key.gen.sh
```

Content:

```sh
#!/bin/sh

SSH_DIR=~/.ssh
ARCHIVE_DIR=${SSH_DIR}/archive
TYPE=dsa
TYPE=rsa
TYPE=ed25519
EMAIL=imre.tabur@eesti.ee
BITS=4096
SYSTEM=github

REMOTE_USER=
REMOTE_MACHINE=

COPY_TO_REMOTE=yes
COPY_TO_REMOTE=no

genKey() {
    mkdir -p ${ARCHIVE_DIR}
    chmod 700 ${SSH_DIR}
    ssh-keygen -t ${TYPE} -b ${BITS} -C "${EMAIL}" -f ${ARCHIVE_DIR}/id_${TYPE}.${SYSTEM}
    chmod 600 ${ARCHIVE_DIR}/id_${TYPE}.${SYSTEM}
    cp ${ARCHIVE_DIR}/id_${TYPE}.${SYSTEM} ${SSH_DIR}/id_${TYPE}
    cp ${ARCHIVE_DIR}/id_${TYPE}.${SYSTEM}.pub ${SSH_DIR}/id_${TYPE}.pub
}

makeAuth() {
    cat ${ARCHIVE_DIR}/id_${TYPE}.${SYSTEM}.pub >> ${SSH_DIR}/authorized_keys
    chmod 600 ${SSH_DIR}/authorized_keys
}

echoKey() {
    echo "Copy that key to another system:"
    cat ${ARCHIVE_DIR}/id_${TYPE}.${SYSTEM}.pub
}

copyKey() {
    if [ "${COPY_TO_REMOTE}" == "yes" ]
    then
        scp ${SSH_DIR}/authorized_keys ${REMOTE_USER}@${REMOTE_MACHINE}:~/.ssh
    fi
}

genKey
makeAuth
echoKey
copyKey

exit 0
```

Change key file password

```sh
ssh-keygen -p -f ~/.ssh/id_rsa
ssh-keygen -p -f ~/.ssh/id_ed25519
```
