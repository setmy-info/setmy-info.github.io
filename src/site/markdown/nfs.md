# NFS

## Information

## Installation

### CentOS, Rocky, Fedora Linux

#### Server

```shell
sudo dnf -y install nfs-utils
```

```shell
sudo nano /etc/idmapd.conf
```

    # line 5 : uncomment and change to your domain name
    Domain = srv.world

```shell
sudo nano /etc/exports
```

	# 192.168.1.0/24 - as mask
	/var/opt/setmy.info/gintra 10.0.0.0/24(rw,sync,no_subtree_check)

| Option                | Explanation                                                                                   |
|-----------------------|-----------------------------------------------------------------------------------------------|
| `rw` (read-write)     | Allows clients to read and write to the exported folder. Clients have full access and modification rights to the folder's content. |
| `ro` (read-only)      | Allows clients only to read the exported folder. Clients can read the folder's content, but they are not allowed to modify or write to it. |
| `sync`                | Requires write operations to occur immediately and not use buffering. This can enhance system stability but may reduce performance. |
| `async`               | Allows write operations to use buffering, which can improve performance but may increase the risk of data loss if the system crashes. |
| `no_subtree_check`    | Disables subtree checking, which speeds up the export process and reduces server load.      |
| `no_root_squash`      | Allows the root user on the client to have the same access rights as on the NFS server. This can be necessary if you want the root user to have full control over the exported folder. |
| `all_squash`          | Makes all users and groups anonymous (like user `nobody`) and they have no special rights. This is useful for security purposes. |
| `anonuid` and `anongid`| Allows you to specify specific user and group IDs for anonymous users and groups when using `all_squash`. |
| `insecure`            | Allows clients to connect to an export that uses higher port numbers. This may be necessary if a firewall blocks NFS port 2049. |

```shell
sudo groupadd gintra
sudo chown :gintra /var/opt/setmy.info/gintra
sudo chmod -R 770 /var/opt/setmy.info/gintra
sudo usermod -a -G gintra someuser
sudo firewall-cmd --add-service=nfs --permanent
# firewall-cmd --add-service={nfs3,mountd,rpc-bind} --permanent
sudo systemctl enable --now rpcbind nfs-server
sudo firewall-cmd --reload
sudo systemctl restart nfs-server
```

#### Client

```shell
sudo mount -t nfs 10.0.0.1:/var/opt/setmy.info/gintra /mnt/gintra
```

for automatic mount

```shell
sudo nano /etc/fstab
```

	10.0.0.1:/var/opt/setmy.info/gintra /mnt/gintra nfs defaults 0 0

```shell
sudo mount -a
```

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)

