# Firefox

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Start headless

```shell
firefox --headless --url https://example.com
# screenshot.png
/opt/firefox/firefox --headless --screenshot https://example.com
/opt/firefox/firefox --new-tab `pwd`/src/site/resources/static.html
/opt/firefox/firefox --new-tab `pwd`/target/site/index.html

/opt/firefox/firefox -CreateProfile "selenium-test"
# -no-remote - many instances with same profile?
/opt/firefox/firefox -P "selenium-test" -no-remote
```

### Coding tips and tricks

## See also

[xxxx](http://yyyyy)
