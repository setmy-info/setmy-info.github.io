# Togglz

## Information

`Togglz` is a Java feature-flag framework for enabling, disabling, and gradually operating application functionality at
runtime. It is especially useful in `Spring Boot` applications where teams want safer releases, staged rollouts,
temporary kill switches, and the ability to decouple deployment from feature exposure.

In practical `SMI` style usage, `Togglz` is most valuable when feature flags are treated as operational controls, not
as permanent architecture. Use it to release incrementally, protect risky integrations, and test new behavior with real
traffic before making it the default path.

### Main Functionalities and Features

* **Runtime feature flags**: Turn features on or off without rebuilding the application.
* **`Spring Boot` integration**: Integrates with application context, web layer, and operational configuration.
* **Admin and operational control**: Feature state can be managed programmatically or through the `Togglz` console.
* **Pluggable state storage**: Store feature state in memory, files, or persistent repositories such as `JDBC` backed
  by `PostgreSQL`.
* **Activation strategies**: Support conditional rollout such as username, percentage, server, or custom strategies.
* **Enum-based feature definitions**: Keep feature names explicit and version-controlled in code.

### Typical Use Cases

* hide incomplete features in production,
* enable functionality only for internal users or selected customers,
* add a kill switch for unstable integrations,
* separate deployment from business rollout,
* run controlled experiments or gradual migration paths.

## Installation

For most `Spring Boot` projects, use the starter rather than wiring `Togglz` manually.

### Maven

```xml

<dependency>
    <groupId>org.togglz</groupId>
    <artifactId>togglz-spring-boot-starter</artifactId>
</dependency>
```

If you want the web console in non-`Spring Boot` environments or need finer control, the broader `Togglz` modules are
also available, but the starter is the simplest and most maintainable entry point for typical service applications.

### Gradle

```groovy
implementation 'org.togglz:togglz-spring-boot-starter'
```

## Core concepts

### Feature enum

The most common pattern is to define features in an enum.

```java
import org.togglz.core.Feature;
import org.togglz.core.annotation.EnabledByDefault;
import org.togglz.core.annotation.Label;

public enum MyFeatures implements Feature {

    @Label("New checkout flow")
    NEW_CHECKOUT_FLOW,

    @EnabledByDefault
    @Label("Legacy reporting")
    LEGACY_REPORTING
}
```

This keeps feature definitions discoverable in code, code review, and architecture discussions.

### Runtime checks

At runtime, code can branch based on feature state.

```java
import org.springframework.stereotype.Service;
import org.togglz.core.manager.FeatureManager;

@Service
public class CheckoutService {

    private final FeatureManager featureManager;

    public CheckoutService(FeatureManager featureManager) {
        this.featureManager = featureManager;
    }

    public CheckoutResult checkout(Order order) {
        if (featureManager.isActive(MyFeatures.NEW_CHECKOUT_FLOW)) {
            return processWithNewFlow(order);
        }
        return processWithLegacyFlow(order);
    }
}
```

This is the simplest form of runtime feature toggle usage.

## `Spring Boot` integration

### Recommended approach

In `Spring Boot`, keep integration explicit:

* define feature enums in application code,
* keep operational ownership of feature state clear,
* use persistent storage if feature state must survive restart,
* secure any admin surface exposed for feature changes,
* clean up stale feature flags after the rollout decision is over.

### Basic configuration example

```yaml
togglz:
    feature-enums: com.example.demo.MyFeatures
    console:
        enabled: true
        path: /togglz-console
        secured: true
```

This tells the starter where the feature enum lives and enables the management console.

### Practical `Spring Boot` notes

* Prefer feature checks in service or orchestration layers rather than scattering them through controllers and views.
* For business-critical toggles, use persistent state storage instead of in-memory defaults.
* If you expose the console, keep it behind authentication and restrict access to operators or trusted developers.
* If you already use `Spring Boot Actuator`, document clearly which operational endpoint or admin path is responsible
  for flag visibility and updates in your environment.

## `PostgreSQL` example with `JDBC` state repository

When feature state must survive restart and be shared across instances, use a persistent repository. With
`PostgreSQL`, a common pattern is to create a `JDBC`-backed `StateRepository`.

### Why `PostgreSQL`

Use persistent storage when:

* the application runs on multiple nodes,
* operations must change flags at runtime,
* flags should survive restarts or deployments,
* environment consistency matters.

### Example table

The exact table design may vary, but a simple example is:

```sql
create table if not exists togglz
(
    feature_name
    varchar
(
    200
) primary key,
    feature_enabled boolean not null,
    strategy_id varchar
(
    200
),
    strategy_params text
    );
```

### Example `Spring` configuration

```java
import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.togglz.core.repository.StateRepository;
import org.togglz.core.repository.jdbc.JDBCStateRepository;

@Configuration
public class TogglzConfiguration {

    @Bean
    public StateRepository stateRepository(DataSource dataSource) {
        return new JDBCStateRepository(dataSource);
    }
}
```

With this approach, `Togglz` stores feature state in the configured relational database instead of memory.

### Example datasource configuration

```yaml
spring:
    datasource:
        url: jdbc:postgresql://localhost:5432/appdb
        username: app
        password: strong-password
        driver-class-name: org.postgresql.Driver

togglz:
    feature-enums: com.example.demo.MyFeatures
    console:
        enabled: true
        secured: true
```

### Operational advice for `PostgreSQL`

* treat the feature-state table as operational configuration data,
* manage backups and migrations like other small but important system tables,
* avoid manual edits unless your operational process explicitly allows them,
* document who is allowed to change feature state and through which interface.

## Runtime feature toggling

There are several practical ways to change feature state during runtime.

### 1. Admin console

The `Togglz` console is the simplest operator-facing approach for many internal applications.

Typical use:

* enable a feature after deployment,
* disable a problematic path quickly,
* inspect current feature states,
* test rollout behavior without redeploying.

If you use the console in shared or production-like environments, secure it properly and log access through your normal
application security and operations processes.

### 2. Programmatic update

If your application needs controlled internal rollout logic, update the feature state through `FeatureManager`.

```java
import org.springframework.stereotype.Service;
import org.togglz.core.manager.FeatureManager;
import org.togglz.core.repository.FeatureState;

@Service
public class FeatureAdminService {

    private final FeatureManager featureManager;

    public FeatureAdminService(FeatureManager featureManager) {
        this.featureManager = featureManager;
    }

    public void enableNewCheckoutFlow() {
        FeatureState state = new FeatureState(MyFeatures.NEW_CHECKOUT_FLOW, true);
        featureManager.setFeatureState(state);
    }
}
```

Use this approach when runtime toggling should happen through an internal admin API, scheduled workflow, or controlled
operational automation.

### 3. Activation strategies

Instead of turning a feature on for everyone, you can activate it only for selected users or a percentage of traffic.

Good examples:

* internal users only,
* one pilot customer,
* 10 percent rollout,
* one application node or region.

This is often better than a simple global `on/off` switch when release risk is moderate and observation is needed.

## Best practices

### Use short-lived flags where possible

Many feature flags should be temporary. Once a rollout is complete and stable, remove dead branches and the feature flag
itself.

### Distinguish release toggles from permanent business rules

Do not use `Togglz` as a substitute for normal authorization, pricing logic, or long-term tenant configuration unless
that decision is explicit and well-architected.

### Name flags clearly

Good:

* `NEW_CHECKOUT_FLOW`
* `ASYNC_EXPORT_PIPELINE`
* `PARTNER_X_INTEGRATION`

Bad:

* `FEATURE_1`
* `TEST_FLAG`
* `TEMP_NEW`

### Keep ownership clear

Each important flag should have:

* purpose,
* owner,
* rollback expectation,
* planned removal date or review point.

### Avoid flag sprawl

Too many old flags make code harder to reason about than the original risky change.

## Common issues

### Feature state is lost after restart

Cause: in-memory state repository or non-persistent configuration.

Fix: use a persistent repository such as `JDBC` with `PostgreSQL`.

### Flags differ between instances

Cause: local-only configuration or per-node state.

Fix: store state centrally and make all application instances use the same repository.

### Console exposure is too open

Cause: console enabled without strong access control.

Fix: protect the console with proper authentication, authorization, and environment-specific restrictions.

### Old flags remain forever

Cause: no cleanup discipline after rollout.

Fix: treat flag removal as part of the feature completion definition.

## See also

* [Official Togglz website](https://www.togglz.org/)
* [Spring Framework](spring.md)
* [Spring Boot](springboot.md)
* [PostgreSQL](postgresql.md)
* [Zeebe](zeebe.md)
