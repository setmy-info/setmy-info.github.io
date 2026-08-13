# TOON (Transparent Object-Oriented Notation)

## Information

TOON (Transparent Object-Oriented Notation) is a data serialization format designed to be as easy for machines to read
as it is for humans, while focusing on being ambiguity-free and hierarchical. It is particularly relevant in the context
of Large Language Models (LLMs) and AI agents as an alternative to JSON, YAML, and TOML.

### Why TOON for AI?

Compared to other formats, TOON offers several advantages for AI workflows:

* **Ambiguity-free**: Unlike YAML (which has complex edge cases like the "Norway problem") or JSON (which has subtle
  differences in how numbers or duplicate keys are handled), TOON is designed to have a single, clear interpretation.
* **Hierarchical**: It naturally represents nested structures, which is essential for complex AI prompts and agent state
  management.
* **Low Boilerplate**: It avoids the heavy use of commas and colons found in JSON, making it easier for LLMs to generate
  without syntax errors.
* **Intent Clarity**: The structure clearly reflects the developer's intent, reducing the "risk of storytelling" where
  the model might deviate into prose.

## Comparison

| Criterion            | LISP       | JSON | YAML | TOML | JS | TOON |
|----------------------|------------|------|------|------|----|------|
| Ambiguity-free       | ✅         | ⚠️   | ❌   | ⚠️   | ⚠️ | ✅   |
| Intent clarity       | ✅         | ❌   | ⚠️   | ⚠️   | ❌ | ⚠️   |
| Hierarchy            | ✅         | ✅   | ⚠️   | ⚠️   | ⚠️ | ✅   |
| AI-friendly          | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ | ⭐   | ⭐ | ⭐⭐ |
| Risk of storytelling | ❌         | ⚠️   | ❌   | ⚠️   | ❌ | ⚠️   |
| Suitable as DSL      | ✅         | ❌   | ❌   | ❌   | ⚠️ | ❌   |

## Usage and Syntax

TOON syntax is minimalist, using braces for hierarchy and avoiding unnecessary punctuation.

### Basic Example

```toon
person {
    name "John Doe"
    age 30
    active true
}
```

### Nested Objects

```toon
project {
    title "AI Assistant"
    meta {
        version "1.0.0"
        author "Junie"
    }
    tasks [
        "Plan implementation"
        "Write code"
        "Verify results"
    ]
}
```

## Integration with LLMs

When using TOON with LLMs, it is often helpful to provide a few-shot example in the system prompt to define the expected
format. Its lack of commas makes it particularly robust for models that tend to struggle with strict JSON syntax in long
outputs.

## See also

* [JSON](https://www.json.org/)
* [YAML](https://yaml.org/)
* [TOML](https://toml.io/)
* [Model Context Protocol (MCP)](mcp.md)
* [LLM](llm.md)
