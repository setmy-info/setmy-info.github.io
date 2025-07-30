# UML

## Information

### Association

![](https://www.uml-diagrams.org/association/association.png)

### Composition

Strict association.

![](https://www.uml-diagrams.org/association/class-composition.png)

```mermaid
classDiagram
    class House {
        +String address
    }

    class Room {
        +String name
        +int area
    }

    House *-- "1..*" Room: consists of
```

A Room can't exist without a House. If the House is destroyed, the Room is destroyed as well.

### Aggregation

Soft association.

![](https://www.uml-diagrams.org/association/shared-aggregation.png)

```mermaid
classDiagram
    class Team {
        +String name
    }

    class Player {
        +String name
    }

Team o-- "0..*" Player: has
```

Players can exist independently of a Team.

Aggregation is well-suited for linking to enum-like reference tables, where the associated values are shared, reusable,
and not owned exclusively by the referring object.

### Generalization

![](https://www.uml-diagrams.org/class-diagrams/class-generalizaion-shared.png)

### Dependency

**Web Shopping** package uses (depends on) **Payment** package.

![](https://www.uml-diagrams.org/dependency/use-package.png)

Interface **SiteSearch** is realized (implemented) by **SearchService**.

![](https://www.uml-diagrams.org/uml-core/class-interface-realization.png)

## Usage, tips and tricks

### Coding tips and tricks

## See also

* [OMG](https://www.omg.org/spec/UML/2.5.1/PDF)
* [uml](https://www.uml-diagrams.org/)
* [composition](https://www.uml-diagrams.org/composition.html)
* [aggregation](https://www.uml-diagrams.org/aggregation.html)
* [association](https://www.uml-diagrams.org/association.html)
* [generalization](https://www.uml-diagrams.org/generalization.html)
* [dependency](https://www.uml-diagrams.org/dependency.html)
