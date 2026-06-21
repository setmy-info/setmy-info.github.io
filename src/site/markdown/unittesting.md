# Unit testing

## Information

Unit testing is a software testing method in which individual units of source code — typically a single function,
method, or class — are tested in isolation from the rest of the system. The goal is to verify that each unit behaves
correctly given controlled inputs, independent of external dependencies.

A unit test is fast, deterministic, and has no side effects on external systems (no database, no network, no
filesystem unless mocked).

## Pros

* Leads to better code granulation — forces developers to write small, focused, testable units.
* Leads to self (developer) review — writing a test forces re-reading and reconsidering the implementation.
* Leads to rechecking the requirement — test authorship surfaces misunderstood requirements early.
* Fixes and documents the expected state — tests act as executable specifications.
* Fast feedback about wrong changes — a failing unit test points directly to the broken unit.
* Safe refactoring — a passing test suite confirms behavior is preserved after internal changes.

## Cons and tradeoffs

* Unit tests can give false confidence when integration behavior is what actually breaks.
* Over-mocking hides real integration bugs — tests pass but the system fails.
* High test count with low value (testing trivial getters/setters) adds maintenance burden.
* Tests themselves can contain bugs, masking the defect they were meant to catch.

## Usage, tips and tricks

### AAA Pattern (Arrange, Act, Assert)

Structure every test in three phases:

```
Arrange  — set up the object under test and its dependencies
Act      — call the method or function being tested
Assert   — verify the result or side effect
```

Example (Java / JUnit 5):

```java
@Test
void shouldReturnSumOfTwoPositiveNumbers() {
    // Arrange
    Calculator calc = new Calculator();
    // Act
    int result = calc.add(2, 3);
    // Assert
    assertEquals(5, result);
}
```

### Test naming conventions

A test name should describe what is being tested and under what condition:

* `shouldReturnSumWhenBothInputsArePositive`
* `givenNullInput_whenValidate_thenThrowsIllegalArgument`
* `add_twoPositiveNumbers_returnsCorrectSum`

### Test isolation

* Each test must be independent — no shared mutable state between tests.
* Use `@BeforeEach` / `setUp()` to reinitialize objects before each test.
* Avoid test order dependencies.

### Mocking

Use mocking to replace external dependencies (database, HTTP client, file system) with controlled fakes:

```java
// Mockito example
UserRepository repo = mock(UserRepository.class);
when(repo.findById(1L)).thenReturn(Optional.of(new User(1L, "Alice")));
```

Mock only at the boundary of the unit under test. Do not mock value objects or simple data classes.

### Code coverage

Coverage measures how much of the source code is exercised by tests. Aim for meaningful coverage of business logic,
not 100% coverage of all lines. A high coverage number with trivial assertions is worse than lower coverage with
strong assertions.

## See also

* [JUnit 5](https://junit.org/junit5/)
* [Mockito](https://site.mockito.org/)
* [Mocha (JavaScript)](https://mochajs.org/)
* [pytest (Python)](https://docs.pytest.org/)
* [Cucumber BDD](cucumber.md)
* [Maven](maven.md)
