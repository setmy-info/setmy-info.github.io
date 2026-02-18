# Neo4j

## Information

## Installation

    docker run --name neo4j -p 7474:7474 -p 7687:7687 -e NEO4J_AUTH=neo4j/testpassword neo4j:ubi10

## Usage, tips and tricks

```cypher
CREATE (alice:Person {name: 'Alice', age: 30, city: 'New York'})
CREATE (bob:Person {name: 'Bob', age: 25, city: 'Los Angeles'})
```

```cypher
CREATE
  (carol:Person {name: 'Carol', age: 27, city: 'Chicago'}),
  (dave:Person {name: 'Dave', age: 35, city: 'Miami'})
```

```cypher
CREATE
  (neo:Movie {title: 'The Matrix', year: 1999}),
  (trinity:Person {name: 'Trinity', age: 29})
```

```cypher
CREATE
  (alice:Person {name: 'Alice'}),
  (bob:Person {name: 'Bob'}),
  (alice)-[:FRIEND]->(bob)
```

```cypher
MERGE (alice:Person {name: 'Alice'})
ON CREATE SET alice.age = 30, alice.city = 'New York'
```

```cypher
// Create People
CREATE
  (alice:Person {name: 'Alice', age: 30, city: 'New York'}),
  (bob:Person {name: 'Bob', age: 25, city: 'Los Angeles'}),
  (carol:Person {name: 'Carol', age: 27, city: 'Chicago'})

// Create Movies
CREATE
  (matrix:Movie {title: 'The Matrix', year: 1999}),
  (inception:Movie {title: 'Inception', year: 2010})

// Create Relationships
CREATE
  (alice)-[:FRIEND]->(bob),
  (bob)-[:FRIEND]->(carol),
  (alice)-[:WATCHED]->(matrix),
  (bob)-[:WATCHED]->(matrix),
  (carol)-[:WATCHED]->(inception)
```

```cypher
MATCH (alice:Person {name: 'Alice'})-[:FRIEND]->(friends)
RETURN friends.name, friends.age, friends.city
```

```cypher
MATCH (person:Person)-[:WATCHED]->(movie:Movie {title: 'The Matrix'})
RETURN person.name, person.age
```

```cypher
MATCH (alice:Person {name: 'Alice'})-[:FRIEND]->()-[:FRIEND]->(fof)
RETURN DISTINCT fof.name
```

```cypher
MATCH (person:Person)-[:WATCHED]->(movie:Movie)
RETURN person.name AS Person, collect(movie.title) AS MoviesWatched
```

```cypher
MATCH (n)
DETACH DELETE n
```

```cypher
```

```cypher
```

```cypher
```

```cypher
```

```cypher
```

```cypher
```

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
