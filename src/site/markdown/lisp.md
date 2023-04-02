# Common LISP

## Information

![LISP](https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Lisp_logo.svg/240px-Lisp_logo.svg.png)

ANSI INCITS 226-1994 (S20018)[1] (formerly X3.226-1994 (R1999)). ANSI common LISP.

Created 1968.

### Hello World

```common-lisp
(format t "Hello, World!~%")
```

```common-lisp
(concatenate 'string "Hello, " "World!")
```

## Installation

### CentOS, Rocky Linux

Steel bank common lisp

```shell
dnf install -y sbcl
```

```shell
dnf install -y clisp
```

### Windows

Download and install SBCL - Steel Bank Common Lisp.

### Post install

Install [Quicklisp](quicklisp.md).

## Usage, tips and tricks

### Working with System (Project)

```common-lisp
;; Load main system
(asdf:already-loaded-systems)

(pushnew (truename "./") ql:*local-project-directories*)

;(require "cl-start-project")
(ql:quickload :cl-start-project)

(asdf:already-loaded-systems)

;; Load tests system
(ql:quickload :rove)

;(require "cl-start-project/tests")
(ql:quickload :cl-start-project/tests)

(asdf:already-loaded-systems)

;; Run tests
(rove:run :cl-start-project/tests)

;; Make executable
(asdf:make :cl-start-project)
```

#### Run system (project/app)

TODO : how to download dependencies, so application can be executed, locally, by developer with all its dependencies (
for example with alexandria)?

#### Packaging system (project/app)

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

### System files

Usual example file:

```common-lisp
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

Created with quicklisp

```common-lisp
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

### IDE

Currently, setmy.info standard IDE for Common LISP is VSCode.

With plugins:

[CL VSCode plugin](https://marketplace.visualstudio.com/items?itemName=qingpeng.common-lisp)

[Markdown VSCode plugin](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)

## Some misc code

```common-lisp
(require "asdf")

;; When quicklisp is loaded?
(require "cl-start-project")

(asdf:already-loaded-systems)

(load "quicklisp.lisp")

(asdf:load-asd
   (merge-pathnames "cl-start-project" "C:/sources/setmy.info/incubation/lisp"))

;(asdf:load-asd (merge-pathnames "cl-start-project" (uiop:getcwd)))

(asdf:already-loaded-systems)

(asdf:load-system "cl-start-project")

;; Like package/system/library search
(ql:system-apropos "alexandria")

;; Make bin file?
(asdf:make :cl-start-project)

(prove:run #P"myapp/tests/my-test.lisp")
```

Executing Steel bank common lisp

```shell
sbcl --script src\lisp\main\main.lisp
```

### Some libraries

1. Loads of utilities (**alexandria** - (ql:quickload :alexandria))
2. Regular expressions (**cl-ppcre** - (ql:quickload :cl-ppcre))
3. Clojure-like arrow macros (**cl-arrows** - (ql:quickload :cl-arrows))
4. String manipulation (**cl-strings** - (ql:quickload :cl-strings))
5. https://quickdocs.org/ningle
6. https://edicl.github.io/hunchentoot/
7. https://edicl.github.io/cl-who/
8. https://github.com/fukamachi/clack
9. https://github.com/m2ym/cl-annot
10. https://github.com/fukamachi/caveman
11. https://github.com/arielnetworks/cl-markup
12. https://github.com/fukamachi/prove
13. https://github.com/fukamachi/rove
14. https://github.com/arielnetworks/cl-pattern
15. https://github.com/fukamachi/cl-project
16. postmodern
17. local-time

### Data types

#### Collections

##### List

```common-lisp
'(1 2.2 1/2 "Hello" nil)

;; same as previous
;; (1 2.2 1/2 "Hello" NIL)
(list 1 2.2 1/2 "Hello" nil)
```

##### Vector

Integer indexed collection.

```common-lisp
#(1 2 3)

;; same as previous
(vector 1 2 3)

```

##### Set

##### Hash Tables (Map?)

```common-lisp
(defparameter *h* (make-hash-table))

(gethash 'foo *h*)

(setf (gethash 'foo *h*) 'quux)
(setf (gethash 'foo *h*) "Foo")

(gethash 'foo *h*)
```

### Misc

```common-lisp
(reduce #'+ '(1 2 3 4))

(mapcar #'sqrt '(1 2 3 4))

(mapcan #'(lambda (x) (if (oddp x) (list x))) '(1 2 3 4 5))
```

#### Importing section

```common-lisp
(in-package :cl-user)

(defpackage cl-start-project/main
    #|Avoid :use. Instead, do this:
    (:use :cl)
    (:import-from :cl-start-project/foo :hello-world)
    (:import-from :cl-start-project/style :+golden-ratio+)
    (:import-from :cl-start-project/lesson :show-math)
    Use :import-from
    |#
    (:use :cl)
    (:import-from :cl-start-project/foo :hello-world)
    (:import-from :cl-start-project/style :+golden-ratio+)
    (:import-from :cl-start-project/lesson :show-math)
    ;(:export :show-math)
    (:export :main))

(in-package :cl-start-project/main)
```

#### Class

```common-lisp
(defclass person ()
    ((first-name
      :initarg  :first-name
      :initform "")
        (last-name
         :initarg  :last-name
         :initform "")))

(defparameter *person* (make-instance 'person :first-name "John" :last-name "Doe"))

;; See the ~a and ~s difference
(format t "Person: first name ~a last name ~s ~%" (slot-value *person* 'first-name) (slot-value *person* 'last-name))
;; Same thing to return string
(format NIL "Person: first name ~a last name ~s ~%" (slot-value *person* 'first-name) (slot-value *person* 'last-name))
```

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

1. [Blog about web dev](https://lisp-journey.gitlab.io/blog/web-development-in-common-lisp/#with-docker)

1. [Clack and Lack](https://fukamachi.hashnode.dev/how-to-build-a-web-app-with-clack-and-lack-1)

1. [LISP Work](https://lispjobs.wordpress.com/)

1. [Some list of libraries](http://articulate-lisp.com/project/abcs.html)

1. [rove usage](https://quickdocs.org/rove)

1. [Reduce](http://www.lispworks.com/documentation/HyperSpec/Body/f_reduce.htm)

1. [Map](http://www.lispworks.com/documentation/HyperSpec/Body/f_map.htm)

1. [Book](https://gigamonkeys.com/book/)

1. [Book 2](https://www.amazon.com/Successful-Lisp-How-Understand-Common/dp/3937526005)

1. [Dandelion - Eclipse plugin](https://github.com/Ragnaroek/dandelion)

1. [CL Jupyter](https://github.com/yitzchak/common-lisp-jupyter)
