# Nginx

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

If SELinux doesn't allow to "share" at that location files. Use SELin tools for probes, to [switch off](selinux.md) selinux etc.

```shell
ls -Z /tank
# Probably enough (or ZFS over fuze problem?)
chcon -R -t httpd_sys_content_t /tank
# If not enough try also
setsebool -P httpd_read_user_content 1
chcon -t unconfined_u:object_r:unlabeled_t:s0 /tank
```

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
