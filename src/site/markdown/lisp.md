# Common LISP

ANSI INCITS 226-1994 (S20018)[1] (formerly X3.226-1994 (R1999)). ANSI common LISP.

Created 1968.

## Information

## Installation

### CentOS, Rocky Linux

Steel bank common lisp

```shell
dnf install -y sbcl
```

```shell
dnf install -y clisp
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

Some random code

```clojure
(require
 "asdf")

(asdf:already-loaded-systems)

(load "quicklisp.lisp")

(asdf:load-asd
 (merge-pathnames "first-app" "C:/sources/setmy.info/incubation/lisp"))

;;(asdf:load-asd (merge-pathnames "first-app" (uiop:getcwd)))

(asdf:already-loaded-systems)

(asdf:load-system "first-app")

; Like package/system/library search
(ql:system-apropos "alexandria")
```

Executing Steel bank common lisp

```shell
sbcl --script src\lisp\main\main.lisp
```

### Quicklisp

Package manager for common lisp (almost like maven, pip, ...).

#### Create new system (project)

```shell
cd ~/common-lisp
curl -O https://beta.quicklisp.org/quicklisp.lisp
curl -O https://beta.quicklisp.org/quicklisp.lisp.asc
gpg --verify quicklisp.lisp.asc quicklisp.lisp
sbcl --load quicklisp.lisp
#sbcl --load C:/pub/quicklisp/quicklisp.lisp
```

REPL is started

```clojure
(quicklisp-quickstart:install)

(ql:quickload "cl-project")

; Sceleton creation
(cl-project:make-project #p"~/common-lisp/first-app" :author "Imre Tabur <info@setmy.info>" :license "MIT" :depends-on '(:alexandria))
```

When quicklisp is already installed, then need to load it.

```clojure
(load
 (merge-pathnames "quicklisp/setup.lisp"
                  (user-homedir-pathname)))

(asdf:already-loaded-systems)
```

```clojure
; Examples of registering new code/system/project location
(pushnew (truename "/projects/app/") ql:*local-project-directories*)

; or
(pushnew "~/asdf/" asdf:*central-registry* :test #'equal)

(ql:register-local-projects)

(ql:quickload :app)
```

To make it automatic (**~/.sbclrc**):

```clojure
(ql:add-to-init-file)
```

#### Run system (project/app)

TODO : how to download dependencies, so application can be executed, locally, by developer with all its dependencies (
for example with alexandria)?

#### Packagind system (project/app)

TODO : how to package it with all its dependencies, so it can be executed in docker for example.

### ASDF

```shell
~/common-lisp
~/.local/share/common-lisp/source/
~/.config/common-lisp/source-registry.conf.d/
~/common-lisp/asdf/
# C:/Users/USERNAME/quicklisp
# C:/Users/USERNAME/common-lisp
~/.config/common-lisp/source-registry.conf
```

**Example system 1**

```clojure
;; Usual Lisp comments are allowed here

(defsystem "hello-lisp"
           :description "hello-lisp: a sample Lisp system."
           :version     "0.0.1"
           :author      "Imre Tabur <imre.tabur@mail.ee>"
           :licence     "MIT"
           :depends-on  ("optima.ppcre" "command-line-arguments")
           :components
                        ((:file "packages")
                            (:file "macros" :depends-on ("packages"))
                            (:file "hello" :depends-on ("macros"))))
```

**Example system 2**

Created with quicklisp

```clojure
(defsystem "first-app"
           :version     "0.1.0"
           :author      "Imre Tabur <info@setmy.info>"
           :license     "MIT"
           :depends-on  ("alexandria")
           :components
                        ((:module "src"
                             :components
                                  ((:file "main"))))
           :description "A sample Lisp system(project)."
           :in-order-to ((test-op (test-op "first-app/tests"))))

(defsystem "first-app/tests"
           :author      "imret"
           :license     "MIT"
           :depends-on
                        ("first-app"
                            "rove")
           :components
                        ((:module "tests"
                             :components
                                  ((:file "main"))))
           :description "Test system for first-app"
           :perform     (test-op (op c) (symbol-call :rove :run c)))
```

### Some libraries

1. Loads of utilities (**alexandria** - (ql:quickload :alexandria))
2. Regular expressions (**cl-ppcre** - (ql:quickload :cl-ppcre))
3. Clojure-like arrow macros (**cl-arrows** - (ql:quickload :cl-arrows))
4. String manipulation (**cl-strings** - (ql:quickload :cl-strings))
5. https://quickdocs.org/ningle

## See also

1. [LISP Lang](https://lisp-lang.org/)

1. [Common LISP lang](https://common-lisp.net/)

1. [Get started](https://lisp-lang.org/learn/getting-started/)

1. [Steel Bank Common Lisp](http://www.sbcl.org/)

    1. [SBCL Guide](http://www.sbcl.org/manual/index.html)

1. [quicklisp](https://www.quicklisp.org)

1. [Lispstick](http://www.iqool.de/lispstick.html)

1. [asdf build tool](https://asdf.common-lisp.dev/)

    1. [Manual](https://asdf.common-lisp.dev/asdf.html)

    1. [Alexandria](https://alexandria.common-lisp.dev/)

1. [Style guide 1](https://lisp-lang.org/style-guide/)

1. [Google LISP Style Guide](https://google.github.io/styleguide/lispguide.xml)

1. [Ariel Style guide](http://labs.ariel-networks.com/cl-style-guide.html)

1. [Style guide in PS](http://norvig.com/luv-slides.ps)

1. [Format](https://en.wikipedia.org/wiki/Format_(Common_Lisp))

1. [CL Wiki](https://www.cliki.net)

    1. [ASDF](https://www.cliki.net/asdf)

    1. [Naming convention](https://www.cliki.net/naming%20conventions)

1. [Boot build tool](https://boot-clj.github.io/)

1. [LISP Cookbook](https://lispcookbook.github.io/cl-cookbook)

1. [Stackoverflow 1](https://stackoverflow.com/questions/23586404/asdf-building-and-common-lisp)

1. [Clojure to Common Lisp 1](https://pvik.github.io/blog/clojure-to-common-lisp-part-1-getting-started/)

1. [Clojure to Common Lisp 2](https://pvik.github.io/blog/clojure-to-common-lisp-part-2-projects/)

1. [Clojure to Common Lisp 3](https://pvik.github.io/blog/clojure-to-common-lisp-part-3-sample-crud-app/)

1. [Libraries search in quickdocs](https://quickdocs.org/)

1. [LISP Specification](http://www.lispworks.com/documentation/HyperSpec/Front/Contents.htm)

1. [Some LISP site](http://articulate-lisp.com/)

    1. [Creating new project](http://articulate-lisp.com/project/new-project.html)

1. [Book - Practical Common Lisp](https://www.barnesandnoble.com/w/practical-common-lisp-peter-seibel/1100626056?ean=9781590592397)

1. [Book - Common LISP: A Gentle Introduction to Symbolic Computation](https://www.barnesandnoble.com/w/common-lisp-david-s-touretzky/1112217374?ean=9780486498201)

1. [Lisp related site](https://lispmethods.com/)

    1. [Libraries](https://lispmethods.com/libraries.html)

1. [Another site for LISP libs](https://common-lisp-libraries.readthedocs.io/)

    1. [Quicklisp](https://common-lisp-libraries.readthedocs.io/quicklisp/)

1. [aaa](bbb)

1. [aaa](bbb)

1. [aaa](bbb)

1. [aaa](bbb)

1. [aaa](bbb)

1. [aaa](bbb)
