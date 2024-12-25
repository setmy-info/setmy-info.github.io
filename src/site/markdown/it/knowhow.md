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

## Draft

### Junior-level Java developer

A Junior Java Developer should have a solid foundation in both Java programming and general software development
principles.

#### Core Java Concepts

Basic Syntax and Data Types: Understanding variables, data types, operators, and control flow (if-else, switch, loops).
Object-Oriented Programming (OOP): Familiarity with concepts like classes, objects, inheritance, polymorphism,
encapsulation and abstraction.
Exception Handling: Knowledge of try-catch blocks, throwing exceptions and creating custom exceptions.
Collections Framework: Understanding of lists, sets, maps, and their implementations (e.g., ArrayList, HashMap).
Java 8 Features: Familiarity with lambda expressions, streams, and the new date/time API.

#### Development Tools

Integrated Development Environment (IDE): Proficiency in using IDEs like IntelliJ IDEA, Eclipse, or NetBeans.
Build Tools: Basic knowledge of build tools like Maven or Gradle for managing dependencies and building projects.
Version Control Systems: Understanding of Git for version control, including basic commands and workflows.

#### Software Development Principles

Basic Design Patterns: Familiarity with common design patterns like Singleton, Factory, and Observer.
Testing: Understanding of unit testing frameworks like JUnit and basics of test-driven development (TDD).
Code Quality: Awareness of code quality tools (e.g., SonarQube) and practices like code reviews and refactoring.

#### Web Development Basics

Servlets and JSP: Basic understanding of Java web technologies, including servlets and JavaServer Pages (JSP).
RESTful Services: Familiarity with building and consuming REST APIs using frameworks like Spring Boot.

#### Databases

SQL Basics: Understanding of basic SQL queries and database concepts.
JDBC: Knowledge of Java Database Connectivity (JDBC) for connecting Java applications to databases.

#### Problem-Solving Skills

Algorithm and Data Structure Basics: Understanding of basic algorithms (sorting, searching) and data structures (arrays,
linked lists, trees).
Debugging Skills: Ability to troubleshoot and debug code effectively.

#### Soft Skills

Communication: Ability to communicate effectively with team members and stakeholders.
Teamwork: Willingness to collaborate and work in a team environment.
Continuous Learning: Openness to learning new technologies and improving skills.

#### Additional Knowledge (Optional but Beneficial)

Frameworks: Familiarity with popular Java frameworks like Spring or Hibernate.
Cloud Services: Basic understanding of cloud platforms (e.g., AWS, Azure) and their services.
Agile Methodologies: Awareness of Agile development practices and methodologies like Scrum or Kanban.

By focusing on these areas, a Junior Java Developer can build a strong foundation for their career and be well-prepared
for more advanced topics and responsibilities in the future.

### Mid-level Java developer

A mid-level Java developer should have a solid understanding of Java programming, software development principles, and
relevant technologies. They should also possess experience in building applications and be able to work independently or
as part of a team.

#### Core Java Concepts

Advanced Java Features: Proficiency in Java 8 and later features, including lambda expressions, streams, and the new
date/time API.
Concurrency: Understanding of multithreading, synchronization, and concurrent collections. Familiarity with the
java.util.concurrent package.
Design Patterns: Knowledge of common design patterns (e.g., Singleton, Factory, Observer, Strategy) and when to apply
them.
Java Memory Management: Understanding of garbage collection, memory leaks, and performance tuning.

#### Frameworks and Libraries

Spring Framework: Proficiency in Spring Core, Spring Boot, and Spring MVC. Understanding of dependency injection,
aspect-oriented programming, and RESTful web services.
Hibernate/JPA: Familiarity with Object-Relational Mapping (ORM) using Hibernate or Java Persistence API (JPA) for
database interactions.
Testing Frameworks: Experience with unit testing frameworks like JUnit and Mockito, as well as integration testing.

#### Development Tools

Build Tools: Proficiency in build tools like Maven or Gradle for managing dependencies and building projects.
Version Control Systems: Strong knowledge of Git, including branching, merging, and pull requests.
Integrated Development Environments (IDEs): Experience with IDEs like IntelliJ IDEA or Eclipse, including debugging and
profiling tools.

#### Software Development Principles

Agile Methodologies: Familiarity with Agile development practices, such as Scrum or Kanban, and participation in Agile
ceremonies (e.g., stand-ups, retrospectives).
Code Quality: Understanding of code quality principles, including code reviews, static code analysis, and refactoring
techniques.
Microservices Architecture: Basic understanding of microservices principles and how to design and implement
microservices-based applications.

#### Databases

SQL and NoSQL: Proficiency in SQL for relational databases (e.g., MySQL, PostgreSQL) and familiarity with NoSQL
databases (e.g., MongoDB, Cassandra).
Database Design: Understanding of database normalization, indexing, and query optimization.

#### Web Development

RESTful APIs: Experience in designing and consuming RESTful APIs, including understanding of HTTP methods, status codes,
and authentication mechanisms (e.g., OAuth, JWT).
Frontend Technologies: Basic knowledge of frontend technologies (e.g., HTML, CSS, JavaScript) and frameworks (e.g.,
Angular, React) can be beneficial for full-stack development.

#### Problem-Solving Skills

Algorithms and Data Structures: Strong understanding of algorithms (sorting, searching) and data structures (arrays,
linked lists, trees, graphs).
Debugging and Troubleshooting: Ability to diagnose and resolve issues in code and applications effectively.

#### Soft Skills

Communication: Strong verbal and written communication skills to collaborate with team members and stakeholders.
Teamwork: Ability to work effectively in a team environment and contribute to group discussions and decision-making.
Mentorship: Willingness to mentor junior developers and share knowledge within the team.

Additional Knowledge (Optional but Beneficial)

Cloud Services: Familiarity with cloud platforms (e.g., AWS, Azure, Google Cloud) and their services, especially related
to deployment and scaling.
Containerization: Understanding of containerization technologies like Docker and orchestration tools like Kubernetes.
DevOps Practices: Basic knowledge of CI/CD pipelines and tools (e.g., Jenkins, GitLab CI) for automating the software
development lifecycle.

By focusing on these areas, a mid-level Java developer can enhance their skills, contribute effectively to projects, and
prepare for more advanced roles in their career.

#### Senior-level Java developer

A senior-level Java developer is expected to have extensive experience and a deep understanding of Java programming,
software architecture, and best practices. They should be capable of leading projects, mentoring junior developers, and
making architectural decisions. Here are the key areas of knowledge and skills that a senior Java developer should
possess:

#### Core Java Expertise

Advanced Java Features: In-depth knowledge of Java 8 and later features, including lambdas, streams, the new date/time
API, and modules.
Concurrency and Multithreading: Strong understanding of concurrency concepts, thread management, synchronization, and
the Java Memory Model.
Java Performance Tuning: Experience in profiling and optimizing Java applications, understanding garbage collection
mechanisms, and memory management.

#### Software Architecture and Design

Design Patterns: Proficiency in various design patterns (e.g., Singleton, Factory, Strategy, Observer) and architectural
patterns (e.g., MVC, Microservices, Event-Driven Architecture).
Microservices Architecture: Experience in designing and implementing microservices, including service discovery, API
gateways, and inter-service communication.
System Design: Ability to design scalable, maintainable, and robust systems, considering trade-offs and best practices.

#### Frameworks and Technologies

Spring Ecosystem: Deep knowledge of Spring Framework, Spring Boot, Spring MVC, Spring Security, and Spring Data. Ability
to design and implement RESTful services using Spring.
Persistence Frameworks: Expertise in Hibernate, JPA, and database design principles, including ORM best practices.
Reactive Programming: Familiarity with reactive programming concepts and frameworks (e.g., Project Reactor, RxJava) can
be beneficial.

#### Development Tools and Practices

Build and Dependency Management: Proficiency in build tools like Maven and Gradle, including custom configurations and
plugin development.
Version Control and CI/CD: Strong experience with Git and CI/CD tools (e.g., Jenkins, GitLab CI, CircleCI) for
automating the software development lifecycle. Possibly other version control systems too (Mercurial, DVC, ...)
Testing Strategies: Expertise in unit testing, integration testing, and test automation using frameworks like JUnit,
Mockito, and TestNG.

#### Cloud and DevOps

Cloud Platforms: Experience with cloud services (e.g., AWS, Azure, Google Cloud) and deploying Java applications in
cloud environments.
Containerization and Orchestration: Knowledge of Docker and Kubernetes for containerization and orchestration of
applications.
Infrastructure as Code: Familiarity with tools like Terraform or Ansible for managing infrastructure.

#### Security and Compliance

Application Security: Understanding of security best practices, including authentication, authorization, and secure
coding practices.
Compliance Standards: Awareness of compliance standards (e.g., GDPR, PCI-DSS) and how they impact software development.

#### Leadership and Mentorship

Project Leadership: Experience in leading projects, coordinating with cross-functional teams, and managing project
timelines and deliverables.
Mentorship: Ability to mentor and guide junior and mid-level developers, providing code reviews and sharing best
practices.
Stakeholder Communication: Strong communication skills to interact with stakeholders, gather requirements, and present
technical solutions.

#### Problem-Solving and Critical Thinking

Complex Problem-Solving: Ability to analyze complex problems, identify root causes, and propose effective solutions.
Architectural Trade-offs: Experience in evaluating architectural trade-offs and making informed decisions based on
project requirements and constraints.

#### Continuous Learning

Staying Updated: Commitment to staying current with industry trends, new technologies, and best practices in software
development.
Community Involvement: Participation in developer communities, conferences, or open-source projects can be beneficial.

#### Conclusion

A senior-level Java developer is expected to be a technical leader with a broad skill set and the ability to make
strategic decisions. They should be capable of designing complex systems, mentoring others, and driving projects to
successful completion. By focusing on these areas, a senior Java developer can continue to grow in their career and
contribute significantly to their organization.

## Table

| Topics/Themes                       | Junior Developer                            | Mid-level Developer                                    | Senior Developer                                                      |
|-------------------------------------|---------------------------------------------|--------------------------------------------------------|-----------------------------------------------------------------------|
| **Core Java Concepts**              | Basic syntax, OOP, exception handling       | Advanced features, concurrency, performance tuning     | Advanced features, concurrency, performance tuning                    |
| **Java Memory Management**          | Basic understanding of memory management    | Understanding of garbage collection and memory leaks   | In-depth knowledge of performance tuning and memory management        |
| **Design Patterns**                 | Basic understanding of common patterns      | Knowledge of common design patterns                    | Proficiency in various design and architectural patterns              |
| **Microservices Architecture**      | Basic understanding of microservices        | Experience in designing and implementing microservices | Expertise in microservices architecture and service design            |
| **Frameworks and Libraries**        | Basic understanding of Spring and Hibernate | Proficiency in Spring, Hibernate, testing frameworks   | Deep knowledge of Spring ecosystem, reactive programming              |
| **Development Tools**               | Familiarity with IDEs, basic Git            | Proficiency in build tools (Maven/Gradle), Git         | Advanced Git, CI/CD tools, custom build configurations                |
| **Version Control Systems**         | Basic Git commands                          | Strong knowledge of Git workflows                      | Advanced Git usage, branching strategies                              |
| **Software Development Principles** | Basic understanding of Agile                | Familiarity with Agile methodologies, code quality     | Strong Agile experience, architectural trade-offs                     |
| **Testing Frameworks**              | Basic understanding of unit testing         | Experience with JUnit, Mockito                         | Expertise in testing strategies and test automation                   |
| **Databases**                       | Basic SQL knowledge                         | Proficiency in SQL and NoSQL, database design          | Expertise in ORM, complex database design                             |
| **Web Development**                 | Basic understanding of web technologies     | Experience with RESTful APIs, basic frontend knowledge | Advanced RESTful API design, microservices architecture               |
| **Problem-Solving Skills**          | Basic algorithms and data structures        | Strong understanding of algorithms and data structures | Complex problem-solving, architectural trade-offs                     |
| **Debugging and Troubleshooting**   | Basic debugging skills                      | Proficient in debugging and troubleshooting            | Advanced debugging and performance analysis                           |
| **Soft Skills**                     | Communication and teamwork                  | Strong communication, collaboration                    | Leadership, mentorship, stakeholder communication                     |
| **Cloud Services**                  | Basic understanding of cloud concepts       | Experience with cloud platforms, deployment            | Expertise in cloud services, containerization, infrastructure as code |
| **Containerization**                | Basic understanding of containers           | Familiarity with Docker                                | Expertise in Docker and Kubernetes                                    |
| **DevOps Practices**                | Basic understanding of CI/CD                | Experience with CI/CD tools                            | In-depth knowledge of CI/CD pipelines and automation                  |
| **Application Security**            | Basic security awareness                    | Understanding of security best practices               | In-depth knowledge of application security and compliance standards   |
| **Compliance Standards**            | Basic awareness of compliance               | Awareness of compliance standards                      | In-depth knowledge of compliance standards (e.g., GDPR, PCI-DSS)      |
| **Leadership and Mentorship**       | N/A                                         | Mentorship of junior developers                        | Project leadership, mentoring, guiding teams                          |
| **Continuous Learning**             | Willingness to learn                        | Commitment to learning new technologies                | Staying updated, community involvement                                |
