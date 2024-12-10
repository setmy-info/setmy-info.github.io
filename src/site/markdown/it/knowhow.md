# Developers know how

What Software Developers Need to Know.

## Levels

* L1 Hobby programmer, Sunday Programmer. Little to know to do some probes about programming - small probes four self.
* L2 ...
* L3 Junior programmer - everyday job, salary from programming. Simple bugs, simple enhancements development.
  Team player. Existing project setup is done by others.
* L4 Middle level programmer.
* L5 Senior programmer, software architect. Hacker.

Higher should same things as lower level.

Depth level - how much should know.

* D1 Check what is already done, and do it by that. No deeper understanding.
* D2 ...
* D3 ...
* D4 ...
* D5 Good understanding internals, most of the things tested and therefore high understanding how system acts.

## Java developers

* Java and JVM
    * Compiling classes
    * Bytecode
    * Garbage collector
    * Heap
    * Stack
    * JIT
    * Bytecode manipulation
    * Reflection
    * Debugging with IDE
        * Local
        * Remote
    * JNI
    * Profiler
* Specific data types
    * Primitives (boolean, char, byte, short, int, long, float, double) their ranges and memory usage
        * These data types representation in memory, in processor
    * and their wrappers (Boolean, Character, Short, Integer, Long, ...)
    * operations: + - * / & && etc
* Variables
    * Constants (`final` keyword)
* Specific data structures and containers and collections
    * Arrays (fixed size collections)
    * Lists
    * Sets
    * Maps
    * Queues and stacks
    * Optional
* Java
    * Classes
    * Enums
    * Interfaces
        * Default methods
    * Annotations
    * Methods (functions)
        * Method Declaration: returnType methodName(parameters) { ... }
        * Method Signature and Overloading
        * Return Types: `void`, `int`, `String`, custom types
        * Access Modifiers: `public`, `private`, `protected`, `default`
        * Static Methods: Methods that belong to the class, not an instance
        * Instance Methods: Methods that belong to an object instance
        * Method Overriding and Overloading
        * Recursion (a method calling itself)
* Core OOP Principles
    * Inheritance
    * Encapsulation
    * Polymorphism
    * Abstraction
* Control Flow Structures
    * if-else
    * cycles:
        * for
        * while
            * do-while
        * continue
* Advanced numerical classes (BigDecimal, BigInteger, ...)
* Core algorithms
    * Sorting
        * Quick sort
        * Merge sort
    * Search
        * Linear search
        * Binary search
    * Hashing
    * Recursion
* Error Handling
    * Exception
        * Checked Exceptions
        * Unchecked Exceptions
    * Error
    * User-defined Exceptions
    * try-catch
        * try-with-resources
* Functional programming
    * Lambdas
    * Functional Interfaces
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
* I/O and Data streams
    * InputStream, OutputStream
    * Readers and Writers
    * NIO (Non-blocking I/O)
* Modern Java Features
    * Modularity (module-info.java)
    * Date and Time API
    * Generics
* Concurrency and multithreading
    * Threads and Executors
        * ForkJoinPool, Latch (CountDownLatch)
        * Synchronization
        * Thread safety
        * Race Conditions
    * CompletableFuture and parallel computation
    * Virtual Threads
    * Structured concurrency
* Testing frameworks
    * JUnit 5 (and still 4)
    * Mockito (mocking)
    * AssertJ
    * WireMock
    * BDD
        * Cucumber
        * Fitnesse
    * Mutation testing
    * Code quality tools:
        * Find bug, stop bug
        * ...
* Build tools
    * Maven
        * Site
    * Gradle
* JavaDoc
* Spring and Spring Boot
* Other Java tools, utils, libraries frameworks
    * Jackson, Gson
    * JAXB, DOM, SAX
    * Apache Commons: StringUtils, ...
    * Lombok
    * Logging: Log4j, Logback, SLF4J
    * IDE
        * IntelliJ IDEA
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
    * Git
* Build systems, CI
    * Jenkins or similar (Bitbucket or GitHub or GiLab CI)
* Software Issue management
    * Jira
    * Trello
* Software development methodologies
    * Scrum
    * Kanban
* Software design patterns
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
