# Clojure

## Information

## Installation

## Configuration

## Usage, tips and tricks

### Clojure Spring Boot Execution

```shell
mvn spring-boot:run -Dspring-boot.run.arguments="-n info.setmy.main -s info/setmy/main.clj -m default-main"
``

```shell
java -jar .\target\clojure-0.0.0-SNAPSHOT.jar -n info.setmy.main -s info/setmy/main.clj -m default-main
```

### Clojure maven plugin run

```shell
mvn clojure:run
```

## Programming

```clojure
; integer
42

; floating point
-1.5

; ratio
22/7

; string
"hello"

; character
\e

; regular expression
#"[0-9]+"

; symbol
map

; symbol - most punctuation allowed
+

; namespaced symbol
clojure.core/+

; null value
nil

; booleans
true

false

; keyword
:alpha

; keyword with namespace
:release/alpha
```

![](https://clojure.org/images/content/guides/learn/syntax/structure-and-semantics.png)

### Lists

Linked list.

Clojure functions calls are lists.

```clojure
;; To initiate list with values use ' character
;; clojure.lang.PersistentList
(type '(1 2 3))

(println (str '(1 2 3)))
```

Link: [Lists](https://clojure.org/guides/weird_characters#lists)

### Vectors

Sequential, 0-base indexed.

```clojure
;; clojure.lang.PersistentVector
(type [1 2 3])

(println (str [1 2 3]))
```

Link: [Vectors](https://clojure.org/guides/weird_characters#vectors)

### Maps

```clojure
;; clojure.lang.PersistentArrayMap
(type {:a 1 :b 2})

(println (str {:a 1 :b 2}))
```

Link: [Maps](https://clojure.org/guides/weird_characters#maps)

#### Namespaces

```clojure
;; clojure.lang.PersistentArrayMap
{:person/first "Han"
 :person/last  "Solo"
 :person/ship  {:ship/name  "Millennium Falcon"
                :ship/model "YT-1300f light freighter"}}
```

Link: [Maps](https://clojure.org/reference/reader#_maps)

### Sets

```clojure
;; clojure.lang.PersistentHashSet
(type #{:a :b :c})
(type (hash-set 1 2 3 4))

(println (str #{:a :b :c}))
(println (str (hash-set 1 2 3 4)))
```

Link: [Set](https://clojure.org/guides/weird_characters#_set)

### Symbols

```clojure
;; clojure.lang.Symbol
(type 'abcDEF)

(def plusFuncSymbol '+)

(eval (list plusFuncSymbol 1 2 3))
```

### Equality

```clojure
;; true
(= 2 (+ 1 1))

;; false
(= 2 2.0)

;; true
(== 2 2.0)

;; java.lang.Boolean
(type (= 2 (+ 1 1)))
```

### Functions

```clojure
(defn greet  [name] (str "Hello, " name))

;;  This is equivalent as with anonymous function
(def greet (fn [name] (str "Hello, " name)))

(defn messenger
    ([] (messenger "Hello world!"))
    ([msg] (println msg)))

(defn hello [greeting & who]
    (println greeting who))

(greet "Ernie")

(messenger)
(messenger "Hello class!")

(hello "Hello" "world" "class")
```

#### Anonymous Functions

```clojure
;; Just example syntax
(fn [message] (println message))

((fn [message] (println message)) "Hello world!")

;; Equivalent to: (fn [x] (+ 6 x))
#(+ 6 %)

;; Calling that
(#(+ 6 %) 1)
```

Link: [Functions](https://clojure.org/guides/learn/functions)

## See also

[xxxx](http://yyyyy)

