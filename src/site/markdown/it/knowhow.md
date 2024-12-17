# Developers know how

What Software Developers Need to Know.

## Levels

How deeply developer by profiles should know.

* L1/D1 : L5/D5 - hobby programmer knows how things basically works; senior developer should have good understanding.

### Developer profiles

* L1 Hobby, student programmer, Sunday Programmer. Little to know to do some probes about programming - small probes
  four self.
* L2 ...
* L3 Junior programmer - everyday job, salary from programming. Simple bugs, simple enhancements development.
  Team player. Existing project setup is done by others.
* L4 Middle level programmer.
* L5 Senior programmer, software architect. Hacker.

### Depth level

* D1 (or B) Basics. Check what is already done, and do it by that. Seen or heard something, knows some basics how things
  works, no deeper understanding. Basic usage.
* D2 Can do some enhancements by self, some bug fixes.
* D3 (or C) More complex. Can handle everyday work by self. Knows what to search and solve problems. Can do some design.
  Knows solution basic architecture (layers, models,components)
* D4 ...
* D5 (or D) Deeply. Good understanding internals, deeply, most of the things tested and therefore high understanding how
  system acts. Can do complex architecture, buildingblocks at any level (enterprise or solution).

Higher should same things as lower level.

## Java developers

* Java and JVM (L1/B)
    * Compiling classes
    * Bytecode
    * Garbage collector
    * Heap
    * Stack
    * JIT (L4/D3)
    * Bytecode manipulation
    * Reflection
    * Debugging with IDE
        * Local (Maybe L1, L2-L3 /B)
        * Remote (L4)
    * JNI (L4/D3)
    * Profiler (L4/D3)
* Specific data types (L1 must)
    * Primitives (boolean, char, byte, short, int, long, float, double) their ranges and memory usage
        * These data types representation in memory, in processor
    * and their wrappers (Boolean, Character, Short, Integer, Long, ...)
    * operations: + - * / & && etc
* Variables (L1)
    * Constants (`final` keyword) (L3)
* Specific data structures and containers and collections (L3 must, earlier is better)
    * Arrays (fixed size collections)
    * Lists
    * Sets
    * Maps
    * Queues and stacks
    * Optional
* Java (L1)
    * Classes
    * Enums
    * Interfaces
        * Default methods
    * Annotations (L3 preferred or L4 must)
    * Methods (functions)
        * Method Declaration: returnType methodName(parameters) { ... }
        * Method Signature and Overloading
        * Return Types: `void`, `int`, `String`, custom types
        * Access Modifiers: `public`, `private`, `protected`, `default`
        * Static Methods: Methods that belong to the class, not an instance
        * Instance Methods: Methods that belong to an object instance
        * Method Overriding and Overloading
        * Recursion (a method calling itself)
* Core OOP Principles (L3)
    * Inheritance
    * Encapsulation
    * Polymorphism
    * Abstraction
* Control Flow Structures (L1)
    * if-else
    * cycles:
        * for
        * while
            * do-while
        * continue
* Advanced numerical classes (BigDecimal, BigInteger, ...) (L1-L4 - earlier is better, higher must)
* Core algorithms (starting from L2)
    * Sorting
        * Quick sort
        * Merge sort
    * Search
        * Linear search
        * Binary search
    * Hashing
    * Recursion
* Error Handling (L1)
    * Exception
        * Checked Exceptions
        * Unchecked Exceptions
    * Error
    * User-defined Exceptions
    * try-catch
        * try-with-resources
* Functional programming (L3)
    * Lambdas
    * Functional Interfaces (L4)
        * Predicate
        * Consumer
        * Supplier
        * Function
    * Streams API
        * List, Set, Map
            * filter
            * map
            * flatMap
            * reduce
            * forEach
            * operations (collect)
        * Parallel streams
    * Optional use cases
* I/O and Data streams (L1)
    * InputStream, OutputStream
    * Readers and Writers
    * NIO (Non-blocking I/O)
* Modern Java Features (L4-L5)
    * Modularity (module-info.java)
    * Date and Time API (L3)
    * Generics
* Concurrency and multithreading (L4)
    * Threads and Executors (L3)
        * ForkJoinPool, Latch (CountDownLatch)
        * Synchronization
        * Thread safety
        * Race Conditions
    * CompletableFuture and parallel computation
    * Virtual Threads
    * Structured concurrency
* Testing frameworks (L3)
    * JUnit 5 (and still 4)
    * Mockito (mocking)
    * AssertJ
    * WireMock (L4)
    * BDD (L4)
        * Cucumber
        * Fitnesse
    * Mutation testing (L4)
    * Code quality tools (L4)
        * Find bug, stop bug
        * ...
* Build tools
    * Maven (L3/B)
        * Site (L4)
        * Testing frameworks plugins (L4)
    * Gradle (L3/B)
* JavaDoc (L3)
* Spring and Spring Boot (L4)
* Other Java tools, utils, libraries frameworks (L4)
    * Jackson, Gson
    * JAXB, DOM, SAX
    * Apache Commons: StringUtils, ...
    * Lombok
    * Logging: Log4j, Logback, SLF4J (L3)
    * IDE
        * IntelliJ IDEA (L3)
        * Eclipse IDE
        * NetBeans IDE
    * Async tools
        * Netty, Akka
    * Event driven architecture
        * RabbitMQ, Kafka
    * Reactive programming
    * JPA, Hibernate
    * Spring security: OAuth, authentication, authorization
        * JWT
    * Gatling

## Any developer

* Software Version Control
    * Git (L2/B)
* Build systems, CI (L2/B)
    * Jenkins or similar (Bitbucket or GitHub or GiLab CI)
* Software Issue management (L2/B)
    * Jira
    * Trello
* Software development methodologies
    * Scrum
    * Kanban
* Software design patterns (L5/D5 must)
    * Immutability
    * Singleton
    * Factory
    * Builder
    * Observer
    * Strategy
    * Decorator
    * Adapter
    * Proxy
    * Other detailed design principles
        * Event sourcing
        * CQRS
        * Hexagonal architecture
        * Pipeline Pattern (Data processing patterns)
* Architecture related methodologies
    * DDD
    * Microservices, monoliths, modulith
    *
* Security
    * OWASP top 10
    * SSL/TLS, HTTPS
        * Certificates
* Containers & related technologies
    * Docker
    * Kubernetes
* Cloud tools
    * AWS, Google Cloud, Microsoft Azure
* DevOps
    * Monitoring
        * ELK stack
        * Prometheus
        * Grafana
* Soft Skills
    * Communication
    * Collaboration
    * Problem-solving
* Web Technologies, front-end / Web
    * REST
    * GraphQL
    * WebSockets
    * Server-Sent Events
    * MPA, SPA, PWA
    * Angular or React or VueJs
    * WebAssembly
    * OpenAPI/Swagger
* Database
    * SQL
    * Indexing
* Testing
    * Unit, integration and e2e testing
    * Selenium
    * BDD, Spec by example
    * Contract testing (Pact.io)
* Communication protocols
    * UDP, TCP, IP
    * OSI Network layer
