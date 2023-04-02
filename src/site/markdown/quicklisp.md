# Quicklisp

## Information

Package manager for common lisp (almost like maven, pip, ...).

## Installation

Have to download, install and load quicklisp into SBCL.

### Install Quicklisp

### CentOS, Rocky Linux, Fedora

```shell
cd ~
mkdir common-lisp
cd common-lisp
curl -O https://beta.quicklisp.org/quicklisp.lisp
curl -O https://beta.quicklisp.org/quicklisp.lisp.asc
gpg --verify quicklisp.lisp.asc quicklisp.lisp
sbcl --load ~/common-lisp/quicklisp.lisp
```

Continue in Lisp.

### Windows

```commandline
mkdir C:\pub
mkdir C:\pub\quicklisp
cd C:\pub\quicklisp
curl -O https://beta.quicklisp.org/quicklisp.lisp
curl -O https://beta.quicklisp.org/quicklisp.lisp.asc
REM gpg --verify quicklisp.lisp.asc quicklisp.lisp
sbcl --load C:/pub/quicklisp/quicklisp.lisp
```

Continue in Lisp.

### Installation in LISP

Continue Quicklisp installation in Lisp

```common-lisp
(require "asdf")

(asdf:already-loaded-systems)

;; Installs Quicklisp to user home (~/quicklisp on *nixes or %USERPROFILE% on Windows)
(quicklisp-quickstart:install)

(asdf:already-loaded-systems)

;; Adds to config, so it is already loaded at Lisp startup
(ql:add-to-init-file)

; Hit enter
(quit)
```

## Configuration

## Usage, tips and tricks

Loading installed Quicklisp (when it is not added to config for autoload).

```shell
cd C:\pub\quicklisp
```

```shell
cd  ~/common-lisp/quicklisp
```

```common-lisp
;; if sbcl, use: sbcl --load quicklisp.lisp
(load "quicklisp.lisp")
```

Can be added to systems directory

```common-lisp
(load
   (merge-pathnames "quicklisp/setup.lisp"
                    (user-homedir-pathname)))

(asdf:already-loaded-systems)
```

### Coding tips and tricks

## See also

#### Create new system (project)

Start Lisp REPL

```common-lisp
(quicklisp-quickstart:install)

(ql:quickload "cl-project")

;; Sceleton creation
(cl-project:make-project #p"~/common-lisp/first-app" :author "Imre Tabur <info@setmy.info>" :license "MIT" :depends-on '(:alexandria))
```

Examples of registering new code/system/project location

```common-lisp
(pushnew (truename "/projects/app/") ql:*local-project-directories*)

;; or
(pushnew "~/asdf/" asdf:*central-registry* :test #'equal)

(ql:register-local-projects)

(ql:quickload :app)
```

To make it automatic (**~/.sbclrc**):

```common-lisp
(ql:add-to-init-file)
```

[xxxx](http://yyyyy)
