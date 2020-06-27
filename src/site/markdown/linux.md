# Linux

## Information

## Installation

### CentOS

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Example .desktop file

    As menu entries:
        /usr/share/applications
        /usr/local/share/applications

    https://standards.freedesktop.org/menu-spec/latest/
    https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-1.1.html
    localectl list-locales

    [Desktop Entry]
    Comment[en_US]=Example application konsole
    Comment=Example application konsole
    Exec=term exampleApp
    GenericName[en_US]=Example application konsole
    GenericName=Example application konsole
    Icon=utilities-terminal
    MimeType=
    Name[en_US]=Example application konsole
    Name=Example application konsole
    Path=
    StartupNotify=true
    Terminal=false
    TerminalOptions=
    Type=Application
    X-DBUS-ServiceName=
    X-DBUS-StartupType=
    X-KDE-SubstituteUID=false
    X-KDE-Username=

## key gen

    ssh-keygen -t ed25519 -a 1000
    ssh-keygen -t rsa -b 4096 -a 1000

## Usage, tips and tricks

### zip

```sh
zip -r filename.zip ./somefolder
```

### rsync

sync directories from source to destination folder:

```sh
rsync -av --exclude 'exclude.file.txt' ./source/ ./destination/
```

Mirroring and delete files in destination folder, when thery are not in source folder:

```sh
rsync -av --delete --exclude 'exclude.file.txt' ./source/ ./destination/
```

## See also

    [xxxx](http://yyyyy)
