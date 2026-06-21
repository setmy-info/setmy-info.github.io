# Vertx

Reactive applications on the JVM

## Information

Eclipse Vert.x is a toolkit for building reactive, event-driven applications on the JVM. It is non-blocking by design
and polyglot — the same concepts apply in Java, Kotlin, Groovy, JavaScript (via GraalVM), and Ruby.

Core concepts:

* **Verticle** — the unit of deployment; a small isolated component similar to an Actor. Verticles communicate through
  the Event Bus rather than sharing state.
* **Event Bus** — in-process and clustered message-passing backbone. Supports point-to-point, publish-subscribe, and
  request-reply patterns.
* **Non-blocking I/O** — all I/O (HTTP, TCP, database, file) is asynchronous and does not block the event-loop thread.
* **Reactive Extensions** — first-class support for RxJava 3 and SmallRye Mutiny for composing asynchronous pipelines.

Vert.x is intentionally un-opinionated about project structure. It is often used as a foundation for microservices,
API gateways, and real-time backends.

## Installation

### Maven

```xml
<dependency>
    <groupId>io.vertx</groupId>
    <artifactId>vertx-core</artifactId>
    <version>4.5.10</version>
</dependency>
```

For the web router:

```xml
<dependency>
    <groupId>io.vertx</groupId>
    <artifactId>vertx-web</artifactId>
    <version>4.5.10</version>
</dependency>
```

### Gradle

```groovy
implementation 'io.vertx:vertx-core:4.5.10'
implementation 'io.vertx:vertx-web:4.5.10'
```

## Configuration

**VertxOptions** — controls thread pool sizes, cluster settings, and metrics:

```java
VertxOptions options = new VertxOptions()
    .setWorkerPoolSize(40)
    .setEventLoopPoolSize(2 * Runtime.getRuntime().availableProcessors());
Vertx vertx = Vertx.vertx(options);
```

**DeploymentOptions** — controls per-verticle threading and instance count:

```java
DeploymentOptions opts = new DeploymentOptions()
    .setInstances(4)
    .setWorker(false);
vertx.deployVerticle(MyVerticle.class.getName(), opts);
```

## Usage, tips and tricks

### Verticle lifecycle

```java
public class MyVerticle extends AbstractVerticle {
    @Override
    public void start(Promise<Void> startPromise) {
        vertx.createHttpServer()
            .requestHandler(req -> req.response().end("Hello"))
            .listen(8080)
            .onSuccess(s -> startPromise.complete())
            .onFailure(startPromise::fail);
    }

    @Override
    public void stop() {
        // cleanup
    }
}
```

### Event Bus patterns

```java
// Send (point-to-point)
vertx.eventBus().send("address", "message");

// Publish (broadcast)
vertx.eventBus().publish("address", "broadcast");

// Request-Reply
vertx.eventBus().request("address", "ping")
    .onSuccess(reply -> System.out.println("Got: " + reply.body()));
```

### HTTP Server with Router

```java
Router router = Router.router(vertx);
router.get("/hello").handler(ctx -> ctx.response().end("Hello, Vert.x!"));
vertx.createHttpServer().requestHandler(router).listen(8080);
```

### Do not block the event loop

All handlers run on the event loop. If you need blocking operations (JDBC, file I/O), use a worker verticle or
`vertx.executeBlocking(...)`.

## See also

* [Vert.x official documentation](https://vertx.io/docs/)
* [Vert.x GitHub](https://github.com/eclipse-vertx/vert.x)
* [Vert.x starter](https://start.vertx.io/)
* [Reactive programming with Mutiny](https://smallrye.io/smallrye-mutiny/)
