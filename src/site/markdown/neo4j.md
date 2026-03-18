# Neo4j

## Information

### Introduction

Neo4j is a high-performance, NoSQL graph database management system. It is designed to store and process data in a
graph format, using nodes, relationships, and properties. Unlike traditional relational databases, Neo4j excels at
representing complex, interconnected data, making it ideal for use cases like social networks, recommendation engines,
fraud detection, and knowledge graphs.

### Key Features

* **Graph Data Model:** Stores data as nodes and relationships, which is more natural for many real-world datasets.
* **Cypher Query Language:** A powerful, declarative query language designed specifically for graph data.
* **ACID Compliance:** Ensures data integrity and reliability.
* **Scalability:** Supports horizontal and vertical scaling to handle large amounts of data and high query loads.
* **Vector Search:** Includes built-in support for vector embeddings and similarity search, enabling Retrieval-Augmented
  Generation (RAG) and other AI-driven workflows.

## Installation

### Docker

For local development, the easiest way to run Neo4j is using Docker.

```bash
docker run \
    --name neo4j \
    -p 7474:7474 -p 7687:7687 \
    -d \
    -v $HOME/neo4j/data:/data \
    -v $HOME/neo4j/logs:/logs \
    -v $HOME/neo4j/import:/import \
    -v $HOME/neo4j/plugins:/plugins \
    --env NEO4J_AUTH=neo4j/testpassword \
    neo4j:latest
```

* `-p 7474:7474`: HTTP port for the Neo4j Browser.
* `-p 7687:7687`: Bolt port for binary protocol (used by drivers).
* `-v`: Mounts local directories for data persistence and imports.
* `--env NEO4J_AUTH=neo4j/password`: Sets the initial username and password.

### Docker Compose

Alternatively, use a `docker-compose.yml` file:

```yaml
services:
    neo4j:
        image: neo4j:latest
        container_name: neo4j
        ports:
            - "7474:7474"
            - "7687:7687"
        volumes:
            - ./neo4j/data:/data
            - ./neo4j/logs:/logs
            - ./neo4j/import:/import
            - ./neo4j/plugins:/plugins
        environment:
            NEO4J_AUTH: neo4j/testpassword
            NEO4J_PLUGINS: '["apoc"]' # Optional: enable APOC library
```

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

## See also

* [Neo4j Official Website](https://neo4j.com/)
* [Dgraph](dgraph.md)
* [Cypher Query Language Guide](https://neo4j.com/docs/cypher-manual/current/)
* [VectorDB](vectordb.md)
* [AI](ai.md)
* [AI Agent](agent.md)
* [Model Context Protocol (MCP)](mcp.md)
* [OpenVPN](openvpn.md)
