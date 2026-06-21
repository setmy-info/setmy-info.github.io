# go-start-project

## Information

This page describes how to scaffold and prepare a new Go (golang) project from scratch, including module
initialization, directory layout, common packages, and the standard build and test workflow.

Go requires no separate package manager for the runtime — the toolchain (`go`) handles dependencies via `go.mod` and
`go.sum`. See [go.md](go.md) for Go installation instructions.

## Preparations

### Initialize a New Module

```shell
mkdir my-project
cd my-project
git init
go mod init github.com/your-org/my-project
```

`go mod init` creates `go.mod`, which records the module path and Go version. The module path should match the
repository URL when the project will be published.

### Recommended Project Layout

```
my-project/
├── cmd/
│   └── my-project/
│       └── main.go        # Binary entry point
├── internal/
│   └── myfeature/
│       ├── feature.go     # Package not importable outside this module
│       └── feature_test.go
├── pkg/
│   └── util/
│       └── util.go        # Packages intended for external use
├── go.mod
├── go.sum
├── Makefile
└── README.md
```

`cmd/` holds entry points for each binary. `internal/` enforces that packages there cannot be imported by other
modules. `pkg/` holds reusable packages that may be imported externally.

### Minimal main.go

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```

### Build and Run

```shell
# Run without building a binary
go run ./cmd/my-project

# Build a binary
go build -o bin/my-project ./cmd/my-project

# Run tests
go test ./...

# Run tests with coverage
go test -cover ./...
```

## Installation

See [go.md](go.md) for full installation instructions. Quick reference:

### Rocky Linux / Fedora

```shell
sudo dnf install -y golang
go version
```

### Debian / Ubuntu

```shell
sudo apt-get install -y golang-go
go version
```

### FreeBSD

```shell
pkg install -y go
```

### Windows

```powershell
winget install GoLang.Go
go version
```

## Configuration

### go.mod

```
module github.com/your-org/my-project

go 1.22

require (
    github.com/spf13/cobra v1.8.0
    go.uber.org/zap v1.27.0
)
```

Add a dependency:

```shell
go get github.com/gin-gonic/gin
```

Tidy (remove unused, add missing):

```shell
go mod tidy
```

### Makefile

A minimal `Makefile` for common tasks:

```makefile
.PHONY: build test lint clean

build:
	go build -o bin/my-project ./cmd/my-project

test:
	go test ./...

lint:
	golangci-lint run

clean:
	rm -rf bin/
```

### Environment Variables

```shell
# Set the module proxy (default)
GOPROXY=https://proxy.golang.org,direct
# Disable proxy (use direct VCS)
GONOSUMCHECK=*
# Build output directory
GOBIN=$(go env GOPATH)/bin
```

## Usage, tips and tricks

### Common Packages and Their Purpose

| Package                     | Purpose                                                          |
|-----------------------------|------------------------------------------------------------------|
| `github.com/spf13/cobra`    | CLI framework — commands, flags, subcommands                     |
| `github.com/gin-gonic/gin`  | HTTP web framework — routing, middleware, JSON binding           |
| `go.uber.org/zap`           | Structured, leveled, high-performance logging                    |
| `github.com/stretchr/testify` | Testing assertions and mocks                                   |
| `github.com/joho/godotenv`  | Load `.env` files into environment variables                     |
| `gorm.io/gorm`              | ORM for SQL databases                                            |

### Writing Tests

```go
// internal/myfeature/feature_test.go
package myfeature_test

import (
    "testing"
    "github.com/your-org/my-project/internal/myfeature"
)

func TestAdd(t *testing.T) {
    got := myfeature.Add(2, 3)
    if got != 5 {
        t.Errorf("Add(2, 3) = %d; want 5", got)
    }
}
```

### golangci-lint

Install:

```shell
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

Run:

```shell
golangci-lint run ./...
```

Create `.golangci.yml` for configuration:

```yaml
linters:
  enable:
    - gofmt
    - govet
    - errcheck
    - staticcheck
```

### Cross-Compilation

```shell
# Build for Linux on a Mac or Windows machine
GOOS=linux GOARCH=amd64 go build -o bin/my-project-linux ./cmd/my-project
# Build for Windows
GOOS=windows GOARCH=amd64 go build -o bin/my-project.exe ./cmd/my-project
```

## See also

* [Go official documentation](https://go.dev/doc/)
* [Go module reference](https://go.dev/ref/mod)
* [Standard project layout](https://github.com/golang-standards/project-layout)
* [golangci-lint](https://golangci-lint.run/)
* [go.md](go.md)
