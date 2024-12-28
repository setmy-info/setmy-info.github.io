# golang

## Information

## Installation

### CentOS

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Generate project

```sh
mkdir -p ~/temp/to-go
cd ~/temp/to-go
mkdir module-a
mkdir module-b
mkdir src
mkdir module-a/src
mkdir module-b/src
```

```sh
go mod init to-go

cd module-a
go mod init to-go/module-a
cd ..
cd module-b
go mod init to-go/module-b
cd ..
```

```sh
nano module-a/hello.go
```

```go
package hello

import "fmt"

func Hello() {
    fmt.Println("Hello from Module A!")
}
```

```sh
nano module-b/greet.go
```

```go
package greet

import (
    "to-go/module-a/hello"
)

func Greet() {
    hello.Hello()
}
```

```sh
nano main.go
```

```go
package main

import "to-go/module-b/greet"

func main() {
    greet.Greet()
}
```

```sh
# ?
go run main.go
```

## See also

1. https://github.com/golang-standards/project-layout
1. https://talks.golang.org/2013/bestpractices.slide#36
1. https://golang.org/doc/code.html
1. https://goreportcard.com/
1. https://godoc.org/
1. https://talks.golang.org/2014/names.slide#19
1. https://golang.org/doc/effective_go.html#names
1. https://blog.golang.org/package-names
1. https://golang.org/doc/effective_go.html
1. https://stackoverflow.com/questions/47788850/go-project-structure-best-practice
