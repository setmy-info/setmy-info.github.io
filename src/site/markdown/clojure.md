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

; floating point (double)
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

; clojure.lang.Symbol
(type 'xyz)

; clojure.lang.Keyword
(type ':xyz)

; null value
nil

; booleans
true

false

; keyword
:alpha

; keyword with namespace
:release/alpha

; clojure.lang.BigInt
(type 123N)
(type (bigint 123))

; java.math.BigInteger
(type (biginteger 123))

; vector
[1 2 3]

; list. At the case execute function 1 with params 2 and 3
(1 2 3)

; hash-map
{}

; set
#{}

```

![](https://clojure.org/images/content/guides/learn/syntax/structure-and-semantics.png)

### Lists

Linked list.

Clojure functions calls are lists.

```clojure
;; To initiate list with values use ' character
;; clojure.lang.PersistentList
(type '(1 2 3))
(type (list 1 2 3))

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

### Let

```clojure
; 1
(let [x 1]
    x)

; 3
(let [a 1
      b 2]
    (+ a b))

; 8
(let [c     (+ 1 2)
      [d e] [5 6]]
    (-> (+ d e) (- c)))

; "1 2 3 4"
(let [aList     (list 1 2 3 4)
      [a b c d] aList]
    (str a " " b " " c " " d))
```

### misc

```clojure
(-> "Look "
    (str "I'm ")
    (str "writing ")
    (str "clojure."))

(def makeList
    (->> (range 1 10)
         (map println)))

(def makeList
    (->> (range)
         (map inc)
         (take 5)))

makeList

(->> (range 1 10)
     (map (fn [x] (println x) x))
     (take 4))

; "2022-11-13T19:29:40.944111600Z"
(str (java.time.Instant/now))

; "2022-11-13T21:30:41.775844700"
(str (java.time.LocalDateTime/now))

(str (bean (java.time.LocalDateTime/now)))

; #inst "2022-11-13T19:29:52.015-00:00"
(java.util.Date.)

```

Link: [Functions](https://clojure.org/guides/learn/functions)

## See also

[Pedastal](http://pedestal.io/)

[Clojure diary](https://clojure-diary.gitlab.io/)
