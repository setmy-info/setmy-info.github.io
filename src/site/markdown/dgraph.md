# Dgraph

## Information

### Introduction

Dgraph is an open-source, distributed, native graph database designed for high performance and scalability. Unlike Neo4j, which uses Cypher, Dgraph was originally built with a GraphQL-like query language (DQL) and now supports standard GraphQL natively. It is built in Go and designed to run in a distributed environment, making it a great choice for modern cloud-native applications.

### Key Features

*   **Native GraphQL:** Expose a GraphQL API automatically from a schema definition.
*   **Distributed and Scalable:** Built to scale horizontally by sharding data across multiple nodes.
*   **ACID Compliant:** Supports transactional integrity.
*   **High Performance:** Optimized for low-latency graph traversals.
*   **Vector Search:** Support for vector embeddings to enable similarity search and AI-driven features (similar to RAG).

## Installation

### Docker

For local development, the easiest way to run Dgraph is using the `standalone` Docker image, which includes all necessary components (Zero, Alpha, and Ratel UI).

```bash
docker run -it -p 8080:8080 -p 9080:9080 -p 8000:8000 dgraph/standalone:latest
```

*   `8080`: HTTP port for GraphQL and DQL queries.
*   `9080`: gRPC port for client communication.
*   `8000`: Ratel (the web-based UI for Dgraph).

### Docker Compose

For a more persistent setup, use a `docker-compose.yml` file:

```yaml
services:
    dgraph:
        image: dgraph/standalone:latest
        container_name: dgraph
        ports:
            - "8000:8000"
            - "8080:8080"
            - "9080:9080"
        volumes:
            - ./dgraph_data:/dgraph
        restart: on-failure
```

## Usage, tips and tricks

### Defining a Schema (GraphQL)

To use Dgraph with GraphQL, you must first define a schema. This schema defines the types, fields, and relationships.

```graphql
type Person {
    id: ID!
    name: String! @search(index: [term, exact, fulltext])
    age: Int @search
    city: String @search(index: [term])
    friends: [Person] @hasInverse(field: friends)
    watched: [Movie]
}

type Movie {
    id: ID!
    title: String! @search(index: [term, fulltext])
    year: Int @search
}
```

### Mutating Data (Adding Nodes and Relationships)

#### GraphQL Mutations

```graphql
mutation {
  addPerson(input: [
    { name: "Alice", age: 30, city: "New York" },
    { name: "Bob", age: 25, city: "Los Angeles" },
    { name: "Carol", age: 27, city: "Chicago" },
    { name: "Dave", age: 35, city: "Miami" }
  ]) {
    person {
      id
      name
    }
  }

  addMovie(input: [
    { title: "The Matrix", year: 1999 },
    { title: "Inception", year: 2010 }
  ]) {
    movie {
      id
      title
    }
  }
}
```

#### DQL Mutations (RDF)

DQL uses RDF triples to insert data.

```dql
{
  set {
    _:alice <name> "Alice" .
    _:alice <dgraph.type> "Person" .
    _:alice <age> "30" .
    _:alice <city> "New York" .

    _:bob <name> "Bob" .
    _:bob <dgraph.type> "Person" .
    _:bob <age> "25" .
    _:bob <city> "Los Angeles" .

    _:matrix <title> "The Matrix" .
    _:matrix <dgraph.type> "Movie" .
    _:matrix <year> "1999" .

    _:alice <friends> _:bob .
    _:alice <watched> _:matrix .
  }
}
```

### Querying Data

#### GraphQL Queries

**Find Alice and her friends:**

```graphql
query {
  queryPerson(filter: { name: { eq: "Alice" } }) {
    name
    age
    city
    friends {
      name
      age
      city
    }
  }
}
```

**Find people who watched 'The Matrix':**

```graphql
query {
  queryMovie(filter: { title: { eq: "The Matrix" } }) {
    title
    watchedBy: ~watched {
      name
      age
    }
  }
}
```

#### DQL Queries

**Find Alice's friends of friends:**

```dql
{
  fof(func: eq(name, "Alice")) {
    name
    friends {
      friends {
        name
      }
    }
  }
}
```

**Find people who watched a movie and collect titles:**

```dql
{
  person_movies(func: has(watched)) {
    Person: name
    MoviesWatched: watched {
      title
    }
  }
}
```

### Deleting Data

#### GraphQL Delete

```graphql
mutation {
  deletePerson(filter: { name: { eq: "Alice" } }) {
    msg
    numUids
  }
}
```

#### DQL Delete

To delete everything (equivalent to `MATCH (n) DETACH DELETE n`):

```dql
upsert {
  query {
    v as var(func: has(dgraph.type))
  }
  mutation {
    delete {
      uid(v) * * .
    }
  }
}
```

## See also

*   [Dgraph Official Website](https://dgraph.io/)
*   [Dgraph Documentation](https://dgraph.io/docs/)
*   [Neo4j](neo4j.md)
*   [VectorDB](vectordb.md)
*   [AI](ai.md)
*   [AI Agent](agent.md)
*   [Model Context Protocol (MCP)](mcp.md)
*   [OpenVPN](openvpn.md)
