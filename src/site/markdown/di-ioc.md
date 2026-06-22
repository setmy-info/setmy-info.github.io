# Dependency Injection and Inversion of Control (`DI` / `IoC`)

## Information

`Dependency Injection` (`DI`) and `Inversion of Control` (`IoC`) are closely related software design concepts used to
reduce coupling, improve testability, and separate object creation from business behavior.

In practical application development, especially in `Java`, `Spring`, and enterprise systems, these concepts help keep
application code focused on what it should do instead of how every dependency is created and wired.

`IoC` is the broader principle. `DI` is one common way to implement it.

### Main Functionalities and Benefits

* **Lower coupling**: classes depend on abstractions or collaborators, not on hard-coded construction logic,
* **Better testability**: dependencies can be replaced with test doubles more easily,
* **Clearer responsibilities**: object creation and object usage are separated,
* **Configurable wiring**: environments can choose different implementations,
* **Better maintainability**: large systems become easier to evolve.

### Typical Use Cases

* wiring services, repositories, and clients in `Spring`,
* replacing production integrations with test implementations,
* switching between local, staging, and production configurations,
* keeping controllers and services focused on application behavior,
* building modular applications with cleaner boundaries.

## Core concepts

### What is `Inversion of Control`

`IoC` means that control over certain parts of the program flow or object lifecycle is moved away from the class itself
to an external mechanism.

Without `IoC`, a class often creates and manages everything it needs on its own. With `IoC`, something outside the
class provides those collaborators or manages when components are created and connected.

Typical examples of `IoC`:

* a framework creates application components,
* a container manages object lifecycle,
* configuration decides which implementation is used,
* callbacks or event handlers let the framework call application code.

### What is `Dependency Injection`

`DI` is a concrete technique where dependencies are supplied to a class from the outside instead of being constructed
internally.

If a service needs a repository, logger, or client, it receives them from outside, commonly through a constructor,
method, or field.

### Relationship between `IoC` and `DI`

The simplest practical distinction is:

* `IoC` = the broad design principle,
* `DI` = one implementation pattern of that principle.

So it is correct to say that `DI` is a form of `IoC`, but not every `IoC` mechanism is specifically `DI`.

## Why this matters

When classes create their own collaborators directly, the result often becomes rigid.

Example of tighter coupling:

```java
public class OrderService {

    private final PaymentClient paymentClient = new PaymentClient();

    public void process(Order order) {
        paymentClient.charge(order);
    }
}
```

Problems with this approach:

* the class is tied to one concrete implementation,
* testing becomes harder,
* object creation is hidden inside business logic,
* configuration and replacement are limited.

With `DI`, the same idea becomes cleaner:

```java
public class OrderService {

    private final PaymentClient paymentClient;

    public OrderService(PaymentClient paymentClient) {
        this.paymentClient = paymentClient;
    }

    public void process(Order order) {
        paymentClient.charge(order);
    }
}
```

Now the dependency is explicit and replaceable.

## Common injection styles

### Constructor injection

This is usually the preferred approach.

```java
public class BillingService {

    private final InvoiceRepository invoiceRepository;
    private final TaxCalculator taxCalculator;

    public BillingService(InvoiceRepository invoiceRepository, TaxCalculator taxCalculator) {
        this.invoiceRepository = invoiceRepository;
        this.taxCalculator = taxCalculator;
    }
}
```

Why it is usually preferred:

* required dependencies are explicit,
* immutable fields are easy to use,
* objects are harder to construct in an invalid state,
* tests are straightforward.

### Setter injection

Setter injection can be useful for optional dependencies or specific framework scenarios.

```java
public class ReportService {

    private ReportFormatter reportFormatter;

    public void setReportFormatter(ReportFormatter reportFormatter) {
        this.reportFormatter = reportFormatter;
    }
}
```

Use carefully because the object may exist before all required collaborators are set.

### Field injection

Field injection is common in older examples but is usually less explicit.

```java

@Service
public class NotificationService {

    @Autowired
    private MailClient mailClient;
}
```

Practical drawbacks:

* dependencies are less visible,
* testing without framework help is less convenient,
* required versus optional dependencies become less clear.

In many codebases, constructor injection is the default better choice.

## `Spring` example

`Spring Framework` is one of the most common examples of `IoC` and `DI` in `Java` development.

### Simple service wiring

```java
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Repository
public class CustomerRepository {

    public Customer findById(Long id) {
        return new Customer(id, "Example");
    }
}

@Service
public class CustomerService {

    private final CustomerRepository customerRepository;

    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public Customer loadCustomer(Long id) {
        return customerRepository.findById(id);
    }
}
```

In this model:

* `Spring` manages component creation,
* the container wires dependencies,
* the service focuses on business behavior.

### `@Bean` configuration example

Sometimes explicit configuration is better than component scanning.

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfiguration {

    @Bean
    public PricingPolicy pricingPolicy() {
        return new StandardPricingPolicy();
    }

    @Bean
    public CheckoutService checkoutService(PricingPolicy pricingPolicy) {
        return new CheckoutService(pricingPolicy);
    }
}
```

This is often useful when:

* creating third-party objects,
* choosing implementations explicitly,
* documenting wiring in one place,
* keeping architecture boundaries clearer.

## Practical best practices

### Prefer constructor injection for required dependencies

It keeps the object valid from the moment it is created.

### Depend on abstractions where it helps

Not every class needs an interface, but important boundaries often benefit from depending on an abstraction instead of a
concrete implementation.

### Keep object creation out of business logic

Application services should usually not construct infrastructure clients directly if those collaborators belong to
configuration or framework wiring.

### Avoid overengineering

Do not create unnecessary interfaces or layers just because `DI` exists. Use it where replaceability, testing, or
modularity actually matter.

### Keep container usage at the edges

Business classes should preferably know about their dependencies, not about the dependency injection container itself.

Good practice:

* receive collaborators through constructors,
* keep framework annotations minimal and purposeful,
* avoid service-locator style access inside domain logic.

## Common misunderstandings

### `IoC` and `DI` are not identical terms

They are related, but `IoC` is broader than `DI`.

### `DI` is not only a framework feature

You can do `DI` manually without any container.

```java
PaymentClient paymentClient = new PaymentClient();
OrderService orderService = new OrderService(paymentClient);
```

This is still dependency injection because the dependency is supplied from outside.

### `DI` does not automatically mean better design

If the class boundaries are poor, adding a container does not fix the underlying design problem.

### Too much container magic can hide architecture

If developers cannot easily see what depends on what, the codebase may become harder to understand rather than easier.

## Common issues

### Hidden dependencies

Cause: field injection, service locator patterns, or too much framework magic.

Fix: make dependencies explicit and review object construction patterns.

### Circular dependencies

Cause: components depend on each other in both directions.

Fix: separate responsibilities, introduce clearer boundaries, or redesign the collaboration flow.

### Too many abstractions

Cause: creating interfaces and wrappers for everything without a real need.

Fix: keep abstractions where they provide testing, replacement, or architectural value.

### Business code tied to the container

Cause: domain or service code directly asks the framework container for dependencies.

Fix: inject collaborators normally and keep container-specific code in configuration or framework integration layers.

## When developers should know this

From a practical `Java` / backend perspective:

* junior developers should understand the basic idea of dependencies being provided from outside,
* mid-level developers should be able to use `DI` correctly in frameworks such as `Spring`,
* senior developers should understand trade-offs, testing impact, lifecycle concerns, and architectural consequences.

This aligns well with general developer know-how expectations around maintainability, modularity, and framework usage.

## See also

* [Spring Framework](spring.md)
* [Spring Boot](springboot.md)
* [Togglz](togglz.md)
* [Architecture Decision Record template](it/architecture/decisions/template.md)
