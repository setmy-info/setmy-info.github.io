# Cucumber

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## 5 Whys asked

Analyzed 3 failing projects where Cucumber was used. Shortly pattern was like that:

1. Why problems? Because unmanagable tests. No freedom to add tests.
2. Why unmanageable tests? Too many Gherkin sentenses, long code structure to suport Gherkin sentenses.
3. Why too many Gherkins? Added tests (GSM-s) by use case, added tests by bug/regression case.
4. Why too many GSM-s? Added quickly, added without analyzing exiting, bad to read code structure.
5. Why quikly without analyze? Pressure.

Why your REST interfaces can be managed but GSM-s can't be? Both have FE (Gherkin sentense) and BE (Code per sentense) like structure.

## Usage, tips and tricks

Non failing project BDD project:

1. Only a few (ca 10) Gherkin sentenses-method/function (GSM) pairs per global or domain area (DA - per feature or domain model or technology or request[rest/soap/grpc]).
2. GSM reusability, cross usability.
3. No new GSM-s sets per bug or feature.
4. Strucurize by globally and by DA.
5. Given block sentenses should build immutable value objects data.
6. When block sentenses should take that built immutable value object data and make calls to testable units and setup results data for later checks.
7. Then should check result set data.

## See also

[xxxx](http://yyyyy)
