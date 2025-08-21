# Mermaid

## Information

## Installation

```shell
npm install -g @mermaid-js/mermaid-cli
mmdc --version
mmdc -i input.mmd -o output.svg
```

## Usage, tips and tricks

Class diagram example

```mermaid
classDiagram
    class Book

    class Address {
        <<class>>
        - String street
        - String city
        - String zip
    }

    class Passport {
        <<class>>
        - String number
        - LocalDate expirationDate
    }

    class Person {
        <<class>>
        - String firstName
        - String lastName
        - LocalDate birthDate
        - BiologicalGender gender
        - List<Book> books
        - Address address
        - Passport passport
    }

    class BiologicalGender {
        <<enumeration>>
        + MALE
        + FEMALE
    }

    class Employee {
        <<class>>
        - String employeeId
        - String department
        + work()
    }

    class Student {
        <<class>>
        - String studentId
        - String major
    }

    class WorkerInterface {
        <<interface>>
        + work()
    }

    Person --> BiologicalGender: uses
    Person o-- Book
    Person *-- "1..1" Address
    Person *-- "1..1" Passport
    Employee --|> Person
    Student --|> Person
    Employee ..|> WorkerInterface
```

Usual (REST, GraphQL, gRPC) API

```mermaid
classDiagram
    class ExampleController {
        <<class>>
        + createExample(exampleRequest: ExampleRequestDTO) ExampleResponseDTO
    }

    class ExampleRequestDTO {
        <<class>>
        - String any
        - String property
        - String more
    }

    class ExampleResponseDTO {
        <<class>>
        - Long id
        - String any
        - String property
        - String more
    }

    class ExampleService {
        <<class>>
        + createExample(exampleRequest: ExampleRequest) Example
    }

    class ExampleValidation {
        <<class>>
        + validateExample(exampleRequest: ExampleRequest)
    }

    class ExampleMapper {
        <<class>>
        + mapToExample(exampleRequest: ExampleRequest) Example
    }

    class ExampleRequest {
        <<class>>
        - String any
        - String property
        - String more
    }

    class ExampleResponse {
        <<class>>
        - Long id
        - String any
        - String property
        - String more
    }

    class ExampleRepository {
        <<interface>>
        + save(example: Example): Example
    }

    class Example {
        <<entity>>
        - Long id
        - String any
        - String property
        - String more
    }

    ExampleController o-- ExampleService
    ExampleService o-- ExampleRepository
    ExampleService o-- ExampleValidation
    ExampleService o-- ExampleMapper
    ExampleController --> ExampleRequestDTO: uses
    ExampleController --> ExampleResponseDTO: uses
    ExampleService --> ExampleRequest: uses
    ExampleService --> ExampleResponse: uses
    ExampleValidation --> ExampleRequest: uses
    ExampleRepository --> Example: uses
    ExampleService --> Example: uses
```

### Coding tips and tricks

## See also

* [Mermaid](https://mermaid.js.org/)
* [Mermaid tutorial](https://mermaid.js.org/ecosystem/tutorials.html)
