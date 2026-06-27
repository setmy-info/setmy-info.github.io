# Template

## Information

Spring Boot is a strong choice for building AI-enabled backend services, internal tools, chat applications,
document-processing pipelines, and workflow automations. It already provides the pieces typically needed around AI:
REST APIs, configuration management, security, observability, validation, scheduling, messaging, data access,
batch jobs, and integration with external systems.

For AI use cases, Spring Boot is often used as the orchestration layer around model providers, vector databases,
business rules, and enterprise data sources.

### AI integrations in Spring Boot and Java

Common possibilities:

* **Chat and assistant APIs:** Build chat endpoints, internal copilots, support bots, and knowledge assistants.
* **RAG applications:** Retrieve data from databases, search indexes, files, or vector stores before prompting a
  model.
* **Structured extraction:** Extract entities, classifications, summaries, and JSON objects from documents, emails,
  and forms.
* **Agentic workflows:** Let models call tools, invoke APIs, trigger business actions, or coordinate multi-step
  flows.
* **Embedding pipelines:** Generate embeddings for search, recommendation, clustering, or semantic similarity.
* **Moderation and guardrails:** Apply validation, prompt templates, filtering, and policy checks around model usage.
* **Batch AI processing:** Run offline enrichment jobs for products, articles, tickets, CRM data, or logs.
* **Multimodal integrations:** Connect text generation with image, audio, speech-to-text, or OCR services.

### Main tools and frameworks

#### Spring AI

`Spring AI` is the most Spring-native option for AI integrations in Spring Boot. It follows familiar Spring patterns
such as autoconfiguration, starter dependencies, property-based configuration, abstractions for providers, and
integration with vector stores and tool calling.

Good fit when you want:

* idiomatic Spring Boot configuration
* easy provider swapping
* prompt templates and chat clients in Spring style
* vector store integrations
* MCP and tool-calling friendly architecture

#### LangChain4j

`LangChain4j` is the main Java ecosystem equivalent to LangChain concepts. It is useful for Java-first AI
applications, especially when you want memory, retrieval, tool calling, AI services, and broader LLM application
patterns without being tied only to Spring.

Good fit when you want:

* Java-centric LLM abstractions
* AI service interfaces mapped to Java methods
* retrieval, embeddings, and memory support
* portable design beyond only Spring Boot

#### Direct provider SDKs and HTTP clients

You can also integrate directly with provider SDKs or plain HTTP clients such as `WebClient` or `RestClient`.

Good fit when you want:

* complete control over raw API calls
* immediate access to newly released provider features
* thin wrappers around a single model vendor

This is often useful for OpenAI-compatible APIs, Anthropic, Gemini, Azure OpenAI, local Ollama endpoints, or custom
inference gateways.

## Usage, tips and tricks

### Generating

```sh
https://start.spring.io/#!type=maven-project&language=java&platformVersion=3.1.4&packaging=jar&jvmVersion=21&groupId=ee.test.task&artifactId=event-application&name=event-application&description=Event%20Registration%20Application&packageName=ee.test.task.event-application&dependencies=lombok,devtools,web,thymeleaf,jdbc,data-jdbc,data-jpa,liquibase,h2,postgresql,validation
```

### Command line Runner

To inject dependencies.

```Java
package info.setmy.spring.boot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.ExitCodeGenerator;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CLIApplication implements CommandLineRunner, ExitCodeGenerator {

    @Autowired
    SomeService someService;

    private int exitCode;

    public static void main(String[] args) {
        System.exit(
            SpringApplication.exit(
                SpringApplication.run(MergerApplication.class, args)
            )
        );
    }

    @Override
    public void run(String... args) throws Exception {
        readerService.processFiles();
        // Also changes in exitCode
    }

    @Override
    public int getExitCode() {
        return exitCode;
    }
}
```

### Debugging

```sh
mvn spring-boot:run -Dagentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000
```

Or in pom.xml

```xml

<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <version>${spring.boot.verions}</version>
    <configuration>
        <jvmArguments>jvmArguments>-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000
        </jvmArgumentsjvmArguments>
    </configuration>
</plugin>
```

### Getting profiles in code

```Java

@Autowired
Environment environment;
```

### Make the console silent

```yml
spring:
    main:
        banner-mode: "off"
```

### Spring execution 1

```sh
# SB 3.x : org.springframework.boot.loader.launch.PropertiesLauncher
java ${JAVA_OPTIONS} -Dlogging.file.name=${LOG_DIR_NAME}/${LOG_FILE_NAME} -Dspring.profiles.active=${APPLICATION_PROFILES} -Dspring.config.additional-location=optional:${OPTIONAL_CONFIG_FILE_NAME} -Dloader.main=${APPLICATION_MAIN_CLASS_NAME} -cp ${APPLICATION_JAR_FILE_NAME} org.springframework.boot.loader.PropertiesLauncher ${*}
```

### AI integration tips and tricks

#### Typical architecture

For production systems, keep the AI integration behind your own service layer:

* controller or messaging entry point
* application service orchestrating prompts, retrieval, validation, and model calls
* provider adapter or AI client wrapper
* persistence layer for chat history, embeddings, audit logs, and cached results

This keeps prompt logic, provider-specific code, and business logic separate.

#### Configuration tips

* Keep API keys in environment variables or secret managers, not in source code.
* Externalize model names, temperature, token limits, timeouts, and retry policies into Spring configuration.
* Use separate profiles for local, staging, and production model providers.
* Make it easy to switch between cloud models and local models such as `Ollama`.

Example:

```yml
app:
    ai:
        model: gpt-4o-mini
        temperature: 0.2
        timeout-seconds: 30
```

#### Design tips

* Prefer small focused prompts over very long prompt templates.
* Ask for structured output such as JSON when downstream systems need deterministic parsing.
* Validate model output before using it in business workflows.
* Put AI calls behind interfaces so you can replace providers or mock them in tests.
* Add fallback behavior for timeouts, rate limits, and provider outages.

#### RAG tips

* Store chunk metadata such as document id, source, tenant, language, and timestamps.
* Keep chunk size and overlap configurable.
* Re-rank or filter retrieved results before building the final prompt.
* Log which documents were retrieved for traceability and debugging.
* Separate ingestion pipelines from online query pipelines.

#### Performance and operations

* Use timeouts and retries with backoff for all provider calls.
* Cache expensive responses when use cases allow it.
* Track latency, token usage, error rate, and cost per feature.
* Use asynchronous processing for slow document or embedding pipelines.
* Apply rate limiting when exposing AI-backed endpoints publicly.

#### Security and compliance

* Never send secrets, credentials, or raw personal data unless explicitly allowed.
* Redact or minimize sensitive fields before sending prompts.
* Keep audit logs of prompts, retrieved documents, tools used, and model responses when compliance requires it.
* Define clear boundaries for what tools the model may call.

#### Testing tips

* Separate prompt construction from provider transport so most logic can be unit tested.
* Snapshot or golden-file test prompts and structured outputs where useful.
* Mock external AI providers in fast tests.
* Add a few integration tests against a real provider or local model for end-to-end verification.

### Spring Boot AI stack examples

#### Option 1: Spring Boot + Spring AI

Best for Spring-native applications that want standard Boot configuration, AI client abstractions, and easier provider
swapping.

#### Option 2: Spring Boot + LangChain4j

Best for Java-first LLM application patterns, AI services, memory, retrieval, and tool calling.

#### Option 3: Spring Boot + provider SDK

Best when you need low-level control or vendor-specific features immediately.

#### Option 4: Spring Boot + local models

Useful for local development, privacy-sensitive environments, and low-cost prototyping. A common path is running local
models via `Ollama` and exposing them through the same application services used for cloud providers.

## See also

* [Spring Boot Starter](https://start.spring.io/)
* [Spring AI](https://spring.io/projects/spring-ai)
* [Spring AI GitHub](https://github.com/spring-projects/spring-ai)
* [LangChain4j](https://github.com/langchain4j/langchain4j)
* [Ollama](https://ollama.com/)
* [Property launcher](https://docs.spring.io/spring-boot/specification/executable-jar/property-launcher.html)
* [Spring security](https://www.toptal.com/spring/spring-security-tutorial)
* [JWT](https://docs.spring.io/spring-security/reference/servlet/oauth2/resource-server/jwt.html)
