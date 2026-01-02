# Angular

## Information

## Installation

LTS nodejs is required,

```shell
npm upgrade -g npm
npm install -g @angular/cli
ng --version
```

## Initialize new application

```shell
#Interactive
ng new my-app

# Non-interactive with preset choices
ng new my-app --style=less --ssr=false --ai-config=agents --ai-config=gemini --ai-config=jetbrains --strict --routing=true --defaults --skip-git
```

```shell
cd my-app
```

```shell
ng serve --open
```

[localhost](http://localhost:4200/)

```shell
/opt/firefox/firefox --new-tab http://localhost:4200/
```


```shell
#Interactive unit test
ng test
# Single run
ng test --watch=false
```
    "@wdio/jasmine-framework": "^9.22.0",
    "@wdio/local-runner": "^9.22.0",
    "@wdio/schematics": "^1.2.1",
    "@wdio/spec-reporter": "^9.20.0",

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
