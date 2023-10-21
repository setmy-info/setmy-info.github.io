# IRC

## Information

## Installation

### CentOS, Rocky Linux

```shell
sudo dnf -y install ngircd

sudo nano /etc/ngircd.conf

sudo systemctl start ngircd
sudo systemctl enable ngircd
sudo systemctl status ngircd

sudo firewall-cmd --zone=public --add-port=6667/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-ports
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```
/nick newnick
/join test
/msg NickServ register PASSWORD email@email.com
/msg NickServ identify PASSWORD
```

### Coding tips and tricks

## See also

[Java pircbotx](https://github.com/pircbotx/pircbotx)
[Node IRC client](https://github.com/martynsmith/node-irc)

