# Low level protocol executor or runner

## Idea

To have Java (or other language) API that can be used to construct a protocol graph - a protocol as a graph.
Fluent, chained API to build graph.

### Protocol context

* Config
* Variables (key, value)
* Path journey completed
* Counters (path journey 2expression")

### Steps aka Nodes

* with name
* read step
* write step
* timeout step
* with step config
* with step rules (decide, where to go with error case, normal case)
* input
* output

### Edges aka path

* unidirectional
* decided by step rule
