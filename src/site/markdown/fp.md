# Functional programming

## Information

Functional programming (FP) is a programming paradigm that treats computation as the evaluation of mathematical
functions. Programs are built by composing pure functions, avoiding shared mutable state and side effects.

Programming with pure functions (functions with no side effects — referential transparency, idempotence) used as/like
data — created at runtime, passed around (passed as arguments, returned as return value) like any other data type.

### Key Concepts

**Pure functions** — given the same inputs, always return the same output and produce no side effects (no I/O, no
mutation of external state). This makes them trivially testable and safe to cache (memoize).

**Immutability** — data structures are never modified after creation. Transformations produce new values instead of
mutating existing ones.

**Higher-order functions** — functions that accept other functions as arguments or return functions as results.
Examples: `map`, `filter`, `reduce`.

**Function composition** — combining two or more functions to produce a new function. The output of one becomes the
input of the next.

```python
compose = lambda f, g: lambda x: f(g(x))
add1_then_double = compose(lambda x: x * 2, lambda x: x + 1)
```

**Currying** — transforming a function that takes multiple arguments into a sequence of functions each taking one
argument.

```javascript
const add = a => b => a + b;
const add5 = add(5);
add5(3); // 8
```

**Monads** — a design pattern for chaining operations that may have context (e.g. Optional/Maybe for null safety,
Result/Either for error handling, IO for side effects).

### Advantages

* **Testability** — pure functions have no hidden dependencies, no database calls, no file I/O; they are trivial to
  unit test.
* **Concurrency safety** — immutable data eliminates entire categories of race conditions and shared-state bugs.
* **Predictability** — referential transparency means function calls can be reasoned about in isolation.
* **Composability** — small, focused functions are easy to combine into larger pipelines.

### Language Support

| Language   | FP Level     | Notes                                               |
|------------|--------------|-----------------------------------------------------|
| Haskell    | Pure FP      | Purely functional, lazy evaluation, strong types    |
| Clojure    | FP-first     | Lisp dialect on JVM, persistent data structures     |
| Erlang     | FP-first     | Actor model, fault-tolerant distributed systems     |
| Scala      | Hybrid       | OOP + FP on JVM, Cats/ZIO ecosystem                 |
| F#         | Hybrid       | FP-first on .NET                                    |
| JavaScript | Partial FP   | First-class functions, but mutable by default       |
| Python     | Partial FP   | map/filter/reduce, lambdas, functools               |
| Java       | Partial FP   | Streams API, Optional, lambdas since Java 8         |

## Usage, tips and tricks

### Practical FP Patterns in OOP Languages

Prefer immutable data holders:

```java
// Java — use records (Java 16+)
record Point(int x, int y) {}
```

Use streams instead of loops:

```java
List<String> names = people.stream()
    .filter(p -> p.getAge() > 18)
    .map(Person::getName)
    .collect(Collectors.toList());
```

Avoid shared mutable state in service classes — pass data in, return results out.

Return `Optional` instead of `null`:

```java
Optional<User> find(String id) { ... }
```

### Composition over Inheritance

Favour small, composable functions/behaviours over deep class hierarchies.

## See also

* [Referential transparency](https://en.wikipedia.org/wiki/Referential_transparency)
* [Idempotence](https://en.wikipedia.org/wiki/Idempotence)
