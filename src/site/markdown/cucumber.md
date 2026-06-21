# Cucumber

## Information

Cucumber is a Behaviour-Driven Development (BDD) framework that implements Specification by Example. Tests are written
in **Gherkin** — a plain-language syntax using Given/When/Then steps that business analysts, QA engineers, and
developers can all read and understand.

Gherkin example:

```gherkin
Feature: User login

  Scenario: Successful login with valid credentials
    Given a registered user with email "user@example.com"
    When the user submits valid credentials
    Then the user should be redirected to the dashboard
```

How it works:

1. Business analysts or QA write `.feature` files with Gherkin scenarios.
2. Developers implement **step definitions** — Java/JS/Python methods that map Gherkin sentences to code.
3. Cucumber runs the scenarios and reports pass/fail results readable by all roles.

The key value is a **single shared artifact** across dev, QA, analysts, and product owners — making functionality
and test coverage transparent to the whole team.

## Installation

### Java / Maven

Add to `pom.xml`:

```xml
<dependencies>
    <dependency>
        <groupId>io.cucumber</groupId>
        <artifactId>cucumber-java</artifactId>
        <version>7.x.x</version>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>io.cucumber</groupId>
        <artifactId>cucumber-junit-platform-engine</artifactId>
        <version>7.x.x</version>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>io.cucumber</groupId>
        <artifactId>cucumber-spring</artifactId>
        <version>7.x.x</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### JavaScript / npm

```shell
npm install --save-dev @cucumber/cucumber
```

## Configuration

### Java — glue path and feature file location

Create a JUnit 5 test runner class or configure via `cucumber.properties`:

```properties
cucumber.glue=info.setmy.steps
cucumber.features=src/test/resources/features
cucumber.plugin=pretty,html:target/cucumber-report.html
```

Or annotation-based:

```java
@Suite
@IncludeEngines("cucumber")
@ConfigurationParameter(key = GLUE_PROPERTY_NAME, value = "info.setmy.steps")
@ConfigurationParameter(key = FEATURES_PROPERTY_NAME, value = "src/test/resources/features")
public class CucumberTestSuite {}
```

### JavaScript — `cucumber.js` config

```javascript
module.exports = {
    default: {
        paths: ['features/**/*.feature'],
        require: ['step-definitions/**/*.js'],
        format: ['progress', 'html:reports/cucumber-report.html']
    }
};
```

## Complaints

Most of the cases, developers and managers are saying: we have or end/ended with a heavy amount and unmanageable test
code.

Sometimes transparency is a problem and people are asking: what functionality we already have, what's the status?

Sometimes solutions for complaints and problems - add scripting possibility for QA.

### Questions for analysis

* Perhaps too freely added? Perhaps the usual mindset - here is functionality to test, let's make and add new test code
  to test it?
* Maybe nobody is managing tests (from the very beginning of the project and is going this way on and on)?
* Why are not tests (and code) managed the same way as REST/GraphQL/gRPC endpoints are managed? These you can manage
  but not test code!?
* What is Spec by example/BDD main features? What are killer features of BDD? Do people understand SbE/BDD?
* Maybe BDD frameworks provide transparency and scripting options?

### Conclusion

Mindset is a problem - too freely adding tests.
Organization silos - QA is separated not working hand to hand with developers.
Therefore, tests are not managed either.
Overlapping tests are executed and time spent twice or more because of that. QA (can) turns to bottleneck.

## 5 Why's asked

Analyzed 3 failing projects where Cucumber was used. Shortly pattern was like that:

1. Why problems? Because unmanageable tests. No freedom to add tests (actually new testing code with new test cases, new
   specific code).
2. Why unmanageable tests? Too many Gherkin sentences, long code structure to support Gherkin sentences.
3. Why too many Gherkins? Added tests (GSM-s) by use case, added tests by bug/regression case, new layer code.
4. Why too many GSM-s? Added quickly, added without analyzing exiting, bad to read code structure.
5. Why quickly without analysis? Pressure.

Why your REST interfaces can be managed but GSM-s can't be? Both have FE (Gherkin sentence) and BE (Code per sentence)
like structure.

## Usage, tips and tricks

Non failing project BDD project:

1. Only a few (ca 10) Gherkin sentences-method/function (GSM) pairs per global or domain area (DA - per feature or
   domain model or technology or request[rest/soap/grpc]).
2. GSM reusability, cross usability.
3. No new GSM-s sets per bug or feature.
4. Strucurize by globally and by DA.
5. Given block sentences should build immutable value objects data.
6. When block sentences should take that built immutable value object data and make calls to testable units and setup
   results data for later checks.
7. Then should check result set data.

## Killer feature of Spec by example

Unified and transparent tool for most of the roles (dev, QA, Analysts, PO and maybe even CO) in software development.
Simply saying single artifact for all of them.

## See also

* [Cucumber official documentation](https://cucumber.io/docs/cucumber/)
* [Cucumber on GitHub](https://github.com/cucumber/cucumber-jvm)
* [BDD — Behaviour-Driven Development](https://cucumber.io/docs/bdd/)
* [Gherkin reference](https://cucumber.io/docs/gherkin/reference/)
* [Unittesting](unittesting.md)
