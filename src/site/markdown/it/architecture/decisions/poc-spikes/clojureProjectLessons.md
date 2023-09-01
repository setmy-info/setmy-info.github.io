# Clojure PoC

Lessons learned from using Clojure with Leiningen and IntelliJ:

* **Integration**: The integration with IntelliJ (VSCode was even worse) is not ideal. There's limited code completion,
  especially for Java interoperability.
* **Parentheses**: The parentheses can still be challenging for "parsing" with the eyes.
* **Atoms**: Working with atoms requires writing too much code to update their values.
* **Learning Curve**: Learning takes time because many things have various (short/long) variants that need to be
  understood.

On the bright side:

* some **layering** can be achieved and handled/used as "class(es)" instances
* no dependency injection is needed; just use **:require**
* Learning is good for the brain. Maybe it's beneficial to remember all Java SDK API functions by heart?

Some re-thinking, re-learning and habits changes needed.
