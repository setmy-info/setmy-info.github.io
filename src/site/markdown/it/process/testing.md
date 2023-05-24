# Template

## Information

## Configuration

* Testing data and debug data for developers. Matrix/dimension have to be created for that.
* No test data insertion for tests into DB. Only through API/APP (software that creates data).
* (Recursive) Dimension documentation (dimensions list) have to be created for tests. Dimensions multiplication and
  exclusion matrix have to be created.
* Smoke, Sanity test dimension multiplication matrix (plan) should be created.
* Prepare also constant/stable environment for testing (hardware setup, physical field for device testing, UI test
  farm (e.g. selenium nodes), ...) and prepare/plan initialization, preparations and routine tasks and procedures
  documentation. To collect test data and tests result data.

### Dimensions examples

* Browsers dimension: Firefox (Versions: 100, 113.0.1, 113.0.2), Chrome (Versions: ..., ...), Edge (...)
* OS dimension: Linux (Rocky, Fedora, Debian, ...), Windows (10, 11)
* Webcam dimension: Logitech (Logitech Brio 4K), EMEET 1080P Webcam
* ...

**Multiplication**: Browser x OS x Webcam's

In multiplication some combinations sometimes can't be applied, these are **exclusions**.

### Prepared field tests environment

For example webcams perhaps needs following setup for real **field tests** and **test (+ result) data** gathering.

* Constant light point(s). Light intensity measured and changed by needs.
* White paper sheet on constant distance. Dot's and lines on white paper. Color examples.
* Black paper sheet on constant distance.

Procedures about measuring light intensity. Procedures about taking initial camera pictures.

## Usage, tips and tricks

## See also

[xxxx](http://yyyyy)
