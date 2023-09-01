# Clojure

![CLOJURE](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Clojure_logo.svg/240px-Clojure_logo.svg.png)

## Information

## Installation

## Configuration

## Usage, tips and tricks

### Clojure Spring Boot Execution

```shell
mvn spring-boot:run -Dspring-boot.run.arguments="-n info.setmy.main -s info/setmy/main.clj -m default-main"
```

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

; clojure.lang.Keyword
(type :a)

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

### Collections

#### Lists

Linked list.

Clojure functions calls are lists.

```clojure
;; To initiate list with values use ' character. Othervise it is executed (read an interpreted) as function 1 with args 2 and 3.
;; ' is macro
;; clojure.lang.PersistentList
(type (quote (1 2 3)))
(type '(1 2 3))
(type (list 1 2 3))

(println (str '(1 2 3)))
```

Link: [Lists](https://clojure.org/guides/weird_characters#lists)

#### Vectors

Sequential, 0-base indexed.

```clojure
;; clojure.lang.PersistentVector
(type [1 2 3])

(println (str [1 2 3]))
```

Link: [Vectors](https://clojure.org/guides/weird_characters#vectors)

#### Sets

Unordered collection with unique vales in it.

```clojure
;; clojure.lang.PersistentHashSet
(type #{:a :b :c})
(type (hash-set 1 2 3 4))

(println (str #{:a :b :c}))
(println (str (hash-set 1 2 3 4)))
(println (str {"firstName" "Imre" "lastName" "Tabur"}))

;; #{2.0 1 true "abc" 3 2}
(hash-set 1 2 3 "abc" true 2.0 "abc")

;; Syntax error reading source at (REPL:1:30).
;; Duplicate key: abc
#{1 2 3 "abc" true 2.0 "abc"}
```

Link: [Set](https://clojure.org/guides/weird_characters#_set)

#### Maps

```clojure
;; clojure.lang.PersistentArrayMap
(type {:a 1 :b 2})

(println (str {:a 1 :b 2}))
```

Link: [Maps](https://clojure.org/guides/weird_characters#maps)

### Namespaces

```clojure
;; clojure.lang.PersistentArrayMap
{:person/first "Han"
 :person/last  "Solo"
 :person/ship  {:ship/name  "Millennium Falcon"
                :ship/model "YT-1300f light freighter"}}
```

Link: [Maps](https://clojure.org/reference/reader#_maps)

### Symbols

```clojure
;; clojure.lang.Symbol
(type 'abcDEF)

(def plusFuncSymbol '+)

(eval (list plusFuncSymbol 1 2 3))

(def listFunc (list plusFuncSymbol 1 2 3))

(eval listFunc)
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
(defn greet [name] (str "Hello, " name))

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
(let [c (+ 1 2)
      [d e] [5 6]]
     (-> (+ d e) (- c)))

; "1 2 3 4"
(let [aList (list 1 2 3 4)
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

; Exactly this way
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

; Func passing and executing
(defn greet [value infunc] (str "Hello," (infunc value)))

(greet 2 (fn [x] (+ x 1)))

; 13.7
(get ["a" 13.7 :foo] 1)

; Filter, map, reduce
(def aVector [1 2 3 4 5 6 7 8 9])

(take 2 (map (fn [x] (* x 2)) (filter (fn [x] (= (rem x 2) 0)) aVector)))
(take 2 (map (fn [x] (* x 2)) (filter (fn [x] (= (rem x 2) 0)) aVector)))

(take-last 2 (map (fn [x] (* x 2)) (filter (fn [x] (= (rem x 2) 0)) aVector)))

; filter in even numbers from vector,map by multiplying by 2 and collect last 2 and collect into vector and sum the vector
(reduce +
        (into []
              (take-last 2 (map (fn [x] (* x 2)) (filter (fn [x] (= (rem x 2) 0)) aVector)))))

; Filtering hash map items list
(def person1 {:firstName "Joe" :lastName "Biden"})
(def person2 {:firstName "Donald" :lastName "Trump"})
(def person3 {:firstName "Barack" :lastName "Obama"})
(def personList (list person1 person2 person3))

(filter #(not= (:firstName %) "Joe") personList)

(remove #(= (:firstName %) "Joe") personList)

(filter #(not= "Joe" (get % :firstName)) personList)
(filter (fn [person] (not= (person :firstName) "Joe")) personList)
(filter (fn [person] (not= (get person :firstName) "Joe")) personList)
(filter #(not= (% :firstName) "Joe") personList)

(def strings ["1" "2" "3"])

; Mapping vector through mapping lambda to clojure.lang.LazySeq.
(println (map #(Integer. %) strings))

(def aVariable (conj #{} "Hello"))

; #{"World" "Hello"}
(conj aVariable "World")
```

Link: [Functions](https://clojure.org/guides/learn/functions)

#### The thread-first macro (->)

Linear flow of calls for readability.

-> thing

## Function composition

Make it work:

```clojure
(defn double [x] (* 2 x))
(defn add-one [x] (+ 1 x))
(defn double-and-add-one (comp add-one double))

(double-and-add-one 3)
```

## See also

* Clojupyter
* Neanderthal
* ClojureCL
* ClojureCUDA
* Fluokitten

## IDE

* IntelliJ
  * Cursive (Need to puy)
  * Clojure-Kit
* VSCode - Calva

[Web Noir](http://www.webnoir.org/)

[Pedestal](http://pedestal.io/)

[Clojure diary](https://clojure-diary.gitlab.io/)

[reduce spec](https://clojuredocs.org/clojure.core/reduce)

[Liberator](https://clojure-liberator.github.io/liberator/)

[Compojure](https://github.com/weavejester/compojure)

[Ring](https://github.com/ring-clojure/ring)

[scicloj.ml](https://github.com/scicloj/scicloj.ml)

[Cortex](https://github.com/originrose/cortex)

[Gorilla REPL](http://gorilla-repl.org/)

[Clojure Style Guide](https://guide.clojure.style/)

[uncomplicate - CL libs for ML/AI](https://uncomplicate.org/)

[clj-commons](https://github.com/clj-commons)

[Codox](https://cljdoc.org/d/codox/codox.leiningen)

[Korma](https://github.com/korma/Korma)
