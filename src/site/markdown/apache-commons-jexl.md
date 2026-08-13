# Apache Commons JEXL

## Information

Apache Commons JEXL is a library intended to facilitate the implementation of dynamic and scripting features in 
applications and frameworks written in Java. It provides a small footprint scripting engine for Java, inspired by 
JSTL Expression Language (EL) and Velocity, but with more powerful features such as full flow control (loops, if/else).

JEXL is often used for:
*   Configuration files that require some logic.
*   Business rules engines.
*   Data validation.
*   Dynamic filtering and sorting.

## Installation

### Maven dependency

```xml

<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-jexl3</artifactId>
    <version>3.3</version>
</dependency>
```

## Usage, tips and tricks

### Basic Expression Evaluation

The most common use case is evaluating a simple expression against a context.

```java
import org.apache.commons.jexl3.*;

// Create or reuse an engine
JexlEngine jexl = new JexlBuilder().create();

// Create an expression
String jexlExp = "foo.inner.bar";
JexlExpression e = jexl.createExpression(jexlExp);

// Create a context and add data
JexlContext jc = new MapContext();
jc.set("foo", someObjectWithInner);

// Now evaluate the expression, getting the result
Object o = e.evaluate(jc);
```

### Scripting with Control Flow

JEXL supports full scripts with local variable assignments, loops, and conditionals.

```java
import org.apache.commons.jexl3.*;
import java.util.Arrays;

JexlEngine jexl = new JexlBuilder().create();

String scriptText = 
    "var x = 0; " +
    "for (var item : list) { " +
    "  x = x + item; " +
    "} " +
    "return x;";

JexlScript script = jexl.createScript(scriptText);
JexlContext jc = new MapContext();
jc.set("list", Arrays.asList(1, 2, 3, 4));

Object result = script.execute(jc);
// result will be 10
```

### Custom Functions and Namespaces

You can register Java classes or objects as namespaces to use their methods as functions in JEXL expressions.

```java
import org.apache.commons.jexl3.*;
import java.util.HashMap;
import java.util.Map;

Map<String, Object> namespaces = new HashMap<>();
namespaces.put("math", Math.class);

JexlEngine jexl = new JexlBuilder().namespaces(namespaces).create();
JexlContext jc = new MapContext();

Object result = jexl.createExpression("math:max(10, 20)").evaluate(jc);
// result will be 20.0
```

### Object Navigation and Safety

JEXL provides safe navigation (similar to Groovy or Kotlin) and can be configured to be lenient or strict.

```java
// Create a strict engine
JexlEngine jexl = new JexlBuilder().strict(true).silent(false).create();

// Use safe navigation
String exp = "user?.address?.city";
```

## See also

* [Apache Commons JEXL official site](https://commons.apache.org/proper/commons-jexl/)
* [JEXL Syntax Reference](https://commons.apache.org/proper/commons-jexl/reference/syntax.html)
* [Maven Central: commons-jexl3](https://central.sonatype.com/artifact/org.apache.commons/commons-jexl3)
