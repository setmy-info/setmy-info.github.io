# Mermaid

## Information

## Installation

```shell
npm install -g @mermaid-js/mermaid-cli
mmdc --version
mmdc -i input.mmd -o output.svg
```

## Usage, tips and tricks

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

### Coding tips and tricks

## See also

* [Mermaid](https://mermaid.js.org/)
* [Mermaid tutorial](https://mermaid.js.org/ecosystem/tutorials.html)
