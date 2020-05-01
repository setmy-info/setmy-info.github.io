# SSH

## Autologin

On server side:

```sh
mkdir ~/.ssh && chmod 700 ~/.ssh
```

On client side:

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
    cp ${ARCHIVE_DIR}/id_${TYPE}.${SYSTEM} ${SSH_DIR}/id_${TYPE}
    cp ${ARCHIVE_DIR}/id_${TYPE}.${SYSTEM}.pub ${SSH_DIR}/id_${TYPE}.pub
}

makeAuth() {
    cat ${ARCHIVE_DIR}/id_${TYPE}.${SYSTEM}.pub >> ${SSH_DIR}/authorized_keys
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
