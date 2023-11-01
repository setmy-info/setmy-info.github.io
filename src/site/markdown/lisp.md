# Common LISP

## Install

```shell
mkdir ~/temp
cd ~/temp
wget http://prdownloads.sourceforge.net/sbcl/sbcl-2.3.9-x86-64-linux-binary.tar.bz2
tar xvjf sbcl-2.3.9-x86-64-linux-binary.tar.bz2
cd sbcl-2.3.9-x86-64-linux/
sudo INSTALL_ROOT=/opt/sbcl sh install.sh

export SBCL_HOME=/opt/sbcl/lib/sbcl
```

## Information

![LISP](https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Lisp_logo.svg/240px-Lisp_logo.svg.png)

ANSI INCITS 226-1994 (S20018)[1] (formerly X3.226-1994 (R1999)). ANSI common LISP.

Created 1968.

### Hello World

Simple as that:

```common-lisp
"Hello, World!"
```

More complex:

```common-lisp
(format t "Hello, World!~%")
```

or:

```common-lisp
(concatenate 'string "Hello, " "World!")
```

Difference with Clojure: https://clojure.org/reference/lisps

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

#### Compiling

To FASL (fast-load file) binary format.

NB! Works with same version of sbcl that compiled the file. Version compatibility can also lead to hard debuggable bugs.

```common-lisp
(compile-file "tests/hello.lisp")
```

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

### Data types

#### Collections

##### List

Plain list.

```common-lisp
'(1 2.2 1/2 "Hello" nil)

;; same as previous
;; (1 2.2 1/2 "Hello" NIL)
(list 1 2.2 1/2 "Hello" nil)
```

###### Association Lists

```common-lisp
(defparameter *example-asso-list* (list (cons :a 1) (cons :b 2) (cons :c 3) (cons :d 1.1) (cons :e "Hello, world") (cons :f T) (cons :g nil)))
(cdr (first (member ':a *example-asso-list* :key 'car)))
(cdr (first (member ':b *example-asso-list* :key 'car)))
(cdr (first (member ':c *example-asso-list* :key 'car)))
(cdr (first (member ':d *example-asso-list* :key 'car)))
(cdr (first (member ':e *example-asso-list* :key 'car)))
(cdr (first (member ':f *example-asso-list* :key 'car)))
(cdr (first (member ':g *example-asso-list* :key 'car)))
(assoc ':e *example-asso-list*)
```

###### Plist

Collection of elements where any other element "describes" next element.

```common-lisp
(defparameter *exampleplist* (list :a 1 :b 2 :c 3 :d 1.1 :e "Hello, world" :f T :g nil))
(getf *exampleplist* :a)
(getf *exampleplist* :b)
(getf *exampleplist* :c)
(getf *exampleplist* :d)
(getf *exampleplist* :e)
(getf *exampleplist* :f)
(getf *exampleplist* :g)
```

```common-lisp
(defparameter *ages* (list 'Peter 34 'Meeter 23 'Tom 72))
(getf *ages* 'Tom)
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

(setf (gethash 'foo *h*) 'foo1)
(gethash 'foo *h*)
(setf (gethash 'foo *h*) "Foo2")
(gethash 'foo *h*)
```

### Misc

Some miscellaneous code parts - unsorted, systemized, structured etc.

Executing Steel bank common lisp script

```shell
sbcl --script src\lisp\main\main.lisp
```

Some unselected code parts about loading and working with asdf and quicklisp.

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

Functions

```common-lisp
(in-package :cl-user)

(defpackage cl-start-project/main
    # |Avoid :use . Instead, do this :
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


(defun hello-world ()
    (format t "Hello, world~1%"))

(hello-world)

(defun say-hello (name)
    "Say hello to 'name'."
    (let ((hello-string (format nil "Hello ~a!" name)))
        (format t "~a~%" hello-string)
        hello-string))

(say-hello "Imre Tabur")

(defun say-hello (name &optional age gender)
    "Say hello to 'name'."
    (let ((hello-string (format nil "Hello ~a (~d, ~a)!" name age gender)))
        (format t "~a~%" hello-string)
        hello-string))

(say-hello "Imre Tabur" 20 "M")

(defun say-hello (name &optional age gender)
    "Say hello to 'name'."
    (let
        ((hello-string (format nil "Hello ~a (~d, ~a, ~a)!" name age gender status)))
        (format t "~a~%" hello-string)
        hello-string))

(say-hello "Imre Tabur" :status "Working" 20 "M")


(defun say-hello (name &key status location)
    "Say hello to 'name'."
    (let
        ((hello-string (format nil "Hello ~a (~a at ~a)!" name status location)))
        (format t "~a~%" hello-string)
        hello-string))

(say-hello "Imre Tabur" :status "Working" :location "Home")

(defun say-hello (name &key status (location "Home"))
    "Say hello to 'name'."
    (let
        ((hello-string (format nil "Hello ~a (~a at ~a)!" name status location)))
        (format t "~a~%" hello-string)
        hello-string))

(say-hello "Imre Tabur" :status "Working")

(defun say-hello (&key (name "") (status "Working") (location "Home"))
    "Say hello to 'name'."
    (let
        ((hello-string (format nil "Hello ~a (~a at ~a)!" name status location)))
        (format t "~a~%" hello-string)
        hello-string))

(say-hello)
(say-hello :name "Imre Tabur")
(say-hello :name "Imre Tabur" :status "Vacation")
(say-hello :name "Imre Tabur" :status "Vacation" :location "Africa")

;; Returns same string
(write-line "Hello World!")
;; Hello Geek
;; "Hello Geek"

;; Short comment.
(defparameter *global-variable* "Global variable in earmuffs. All variables should be writen
    complete words. You should use lower case. You must not use / or . instead of -")

(defconstant +golden-ratio+ 575 "Global constants should be with plus sign.")
(defconstant +mix32+ #x12b9b0a1 "pi, an arbitrary number")
(defconstant +mix64+ #x2b992ddfa23249d6 "more digits of pi")

(format t "~d ~%" +mix32+)
(format t "~f ~%" +mix64+)
(format t "~s ~%" "Hello World")

;; Print out symbol.
(format t "~s ~%" :this-is-symbol)

(parse-integer "-64")
(parse-integer "no integer string" :junk-allowed t)

;; T
(string= "foo" "foo")
;; NIL
(string= "foo" "Foo")
;; T
(string= "petronas pizza" "pizza" :start1 10 :end1 14 :start2 1)

(ql:quickload "parse-float")
(parse-float:parse-float "1.2e2")

(if (< 3 5)
    (format t "~s ~%" "True")
    (format t "~s ~%" "False"))

; Like if-elseif-else switch-case
;(defparameter *global-variable* 4)
;(defparameter *global-variable* 5)
(defparameter *global-variable* 6)
(cond ((< *global-variable* 5) (format t "~s ~%" "First"))
      ((< *global-variable* 6) (format t "~s ~%" "Second"))
      (t (format t "~s ~%" "Third")))

;; Short comment.
(defun is-it-good-p (input-data)
    "Function that returns T or NIL should end with -p (predicate). If the rest of the function
    name is a single word, e.g: abstractp, bluep, evenp. If the rest of the function name is more
    than one word, e.g largest-planet-p, request-throttled-p."
    ;; Region 2. Two semicolons.
    nil)

;; Class example
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

;;--- TODO(info@setmy.info): Refactor to provide a better API.  Remove this code after release 1.7
;; or before 2099-12-31.
(defun foo-bar ()
    (format t "Hello, world~1%"))

(type-of :abc)
;; KEYWORD

(type-of "abc")
;; (SIMPLE-ARRAY CHARACTER (3))

(type-of ':abc)
;; KEYWORD

(type-of *person*)
;; PERSON

(type-of 'hello-world)
;; SYMBOL

(type-of #'hello-world)
;; COMPILED-FUNCTION

(type-of nil)
;; NULL

(type-of t)
;; BOOLEAN

(reduce #'+ '(1 2 3 4))

(mapcar #'sqrt '(1 2 3 4))

(mapcan #'(lambda (x) (if (oddp x) (list x))) '(1 2 3 4 5))

(defun do-fun (in-func)
    (funcall in-func 1 2))

(do-fun #'+)

(defun do-fun-again (in-func &rest other-arguments)
    (apply in-func other-arguments))

(do-fun-again #'+ 1 2)
(do-fun-again #'- 1 (do-fun-again #'+ 1 2))

(defparameter *a-list* (list 1 2 3 4))

;; x is actually a list
(maplist #'(lambda (x) x) *a-list*)
;;((1 2 3 4) (2 3 4) (3 4) (4))

(maplist #'(lambda (a-list) (+ (car a-list) 1)) *a-list*)
;; (2 3 4 5)

(mapcar #'(lambda (a-list-item) (+ a-list-item 1)) *a-list*)
;; (2 3 4 5)

;; filters - named as Remove If Not
(remove-if-not (lambda (x) (>= x 2)) *a-list*)

(defun Σ (a-list)
    (reduce #'+ a-list))
(Σ *a-list*)
;; 10

(Σ (remove-if-not (lambda (x) (>= x 2)) *a-list*))
;; 9

(reduce (lambda (acc x) (append acc (list (+ x 1)))) *a-list* :initial-value nil)
;; (2 3 4 5)

(first *a-list*)
;; 1

(second *a-list*)
;; 2

(setf (second *a-list*) 6)
*a-list*
;; 6
;; (1 6 3 4)

(nth 0 *a-list*)
(nth 1 *a-list*)
;; 1
;; 6

(setf (nth 1 *a-list*) 65)
*a-list*
(1 65 3 4)
;; Reset as initial list was.
(setf (nth 1 *a-list*) 2)

(mapcar #'evenp *a-list*)
;; (NIL T NIL T)

(mapcar #'string-upcase (list "Hello" "world!"))
;; ("HELLO" "WORLD!")

(concatenate 'string "hello " "world")
;; "hello world"

(sort (list 9 2 4 7 3 0 8) #'<)
(sort (list "B" "A" "C") #'string<)
;; ("A" "B" "C")

(defparameter *person-list*
  (list
   (make-instance 'person :first-name "John1" :last-name "Doe1")
   (make-instance 'person :first-name "John2" :last-name "Doe2")
   (make-instance 'person :first-name "John3" :last-name "Doe3")))

(slot-value
 (first
  (sort
   *person-list*
   #'(lambda (person-left person-right)
      "case-sensitive: string=, string/=, string>, string<; and case insensitive: string-equal, string-not-equal, string-greaterp, string-lessp, string-not-lessp, string-not-greaterp"
      (string<
       (slot-value person-left 'first-name)
       (slot-value person-right 'first-name)))))
 'first-name)
;; "John1"

;; new line
(terpri)

;; Curring
(defun add (x)
  (lambda (y) (+ x y)))
(defvar add-five (add 5))
(defvar result (funcall add-five 3))

```

Function composition

TODO : make it work

```common-lisp
(defun h (x) (* x 2))
(defun g (x) (+ x 3))
(defun f (x) (expt x 2))

(defun composed-function (x)
  (funcall (compose 'f 'g 'h) x))

(composed-function 5)

(defun compose (f g)
  #'(lambda (x) (funcall f (funcall g x))))
```

## Some libraries

1. Loads of utilities (**alexandria** - (ql:quickload :
   alexandria)) https://alexandria.common-lisp.dev/ https://gitlab.common-lisp.net/alexandria/alexandria
2. Regular expressions (**cl-ppcre** - (ql:quickload :cl-ppcre)) https://github.com/edicl/cl-ppcre
3. Clojure-like arrow macros (**cl-arrows** - (ql:quickload :cl-arrows)) https://github.com/nightfly19/cl-arrows
4. String manipulation (**cl-strings** - (ql:quickload :cl-strings)) https://github.com/diogoalexandrefranco/cl-strings
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
16. https://github.com/lokedhs/cl-rabbit
17. https://github.com/vseloved/cl-redis
18. https://marijnhaverbeke.nl/postmodern
19. https://quickref.common-lisp.net/local-time.html
    1. https://quickref.common-lisp.net/local-time.html
    2. https://cl-library-docs.github.io/common-lisp-libraries/local-time/
    3. https://local-time.common-lisp.dev/manual.html
    4. https://github.com/dlowe-net/local-time
    5. http://naggum.no/lugm-time.html
20. https://quickdocs.org/birch
21. https://quickdocs.org/maiden
22. https://quickdocs.org/cl-irc
23. https://github.com/fukamachi/cl-dbi
24. https://github.com/fukamachi/mito
25. https://quickref.common-lisp.net/cl-jpeg.html
26. https://quickref.common-lisp.net/png.html
27. https://github.com/eudoxia0/cl-yaml
28. https://github.com/mabragor/cl-yaclyaml
29. https://github.com/sharplispers/cl-jpeg
30. https://github.com/3b/cl-opengl
31. https://www.xach.com/lisp/zpng/
32. https://github.com/mmontone/cl-rest-server
33. https://github.com/hankhero/cl-json
34. https://edicl.github.io/drakma/
35. https://lisp-journey.gitlab.io/web-dev/
36. https://awesome-cl.com/
37. https://github.com/CodyReichert/awesome-cl
37. https://github.com/fukamachi/dexador
38. https://github.com/joaotavora/snooze
39. https://github.com/Shinmera/lquery
40. https://github.com/Shinmera/plump

## See also

Clim-IRC: https://github.com/sjl/clim-irc

IBCL: https://github.com/drewc/ibcl

lisp-irc-client: https://github.com/svetlyak40wt/lisp-irc-client

lispbot: https://github.com/rkoeninger/lispbot

ERC: https://www.emacswiki.org/emacs/ErC

CL-IRC: https://github.com/alex-gutev/cl-irc

LispIRC: https://github.com/shinmera/lispirc

Lichat: https://github.com/harley/lisp-irc

SICL IRC: https://github.com/robert-strandh/SICL-IRC

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

1. [CL Library doc](https://quickref.common-lisp.net/index-per-library.html)

1. [CLHS](https://www.cliki.net/CLHS)

    1. [CLHS 1](http://clhs.lisp.se/)

    1. [CLHS 1](http://www.lispworks.com/documentation/HyperSpec/Front/index.htm)

1. [CL Quick ref](http://clqr.boundp.org/index.html)

1. [usocket](https://usocket.common-lisp.dev/)

1. [Fennel lang - LUA and LISP](https://fennel-lang.org/)

1. [ultralisp](https://ultralisp.org)
