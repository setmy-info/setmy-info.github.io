# Cucumber

## Information

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

Unified and transparent tool for most of the roles (dev, QA, Analysts, PO and maybe even CO) in software development
Simply saying single artifact for all of them.

## See also

[xxxx](http://yyyyy)
