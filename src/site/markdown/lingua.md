# Lingua

## Information

### Introduction

`Lingua` is a highly accurate natural language detection library, especially suitable for short text and mixed-language
content. It is designed to identify the language of a given text from a predefined set of supported languages.

Unlike many other language detection libraries that rely on simple n-gram models, `Lingua` uses a combination of
statistical and rule-based approaches, including n-grams and various linguistic properties, to achieve high precision
even on very short strings like tweets or search queries.

### What is it for?

`Lingua` is used by developers who need reliable language identification in their applications. Common use cases
include:

* **Content Moderation**: Automatically identifying the language of user-generated content to apply language-specific
  rules.
* **Search Indexing**: Categorizing documents by language for better search relevance.
* **Translation Services**: Pre-detecting the source language before sending text to a translation API.
* **Personalization**: Serving content or UI elements based on the detected language of a user's input.

## Main Functionalities and Features

* **High Accuracy**: Outperforms many other libraries like CLD3 and fastText, especially on short text.
* **Wide Language Support**: Supports over 70 languages.
* **Detection of Mixed Languages**: Capable of identifying multiple languages within a single text.
* **Language Confidence**: Provides confidence values for its predictions.
* **Minimal Dependencies**: Designed to be lightweight and easy to integrate.
* **Multiple Implementations**: Available for Rust, Python, Go, and the JVM (Java/Kotlin).

## Usage

### Rust

`Lingua` is primarily developed in Rust and offers the best performance and feature set in this ecosystem.

**Cargo.toml**:

```toml
[dependencies]
lingua = "1.6.2"
```

**Basic Example**:

```rust
use lingua::{Language, LanguageDetector, LanguageDetectorBuilder};
use lingua::Language::{English, French, German, Spanish};

fn main() {
    let languages = vec![English, French, German, Spanish];
    let detector: LanguageDetector = LanguageDetectorBuilder::from_languages(&languages).build();
    let detected_language: Option<Language> = detector.detect_language_of("languages are awesome");

    match detected_language {
        Some(lang) => println!("Detected language: {:?}", lang),
        None => println!("No language could be detected"),
    }
}
```

### Python

The Python implementation provides a convenient wrapper around the Rust core.

**Installation**:

```bash
pip install lingua-language-detector
```

**Basic Example**:

```python
from lingua import Language, LanguageDetectorBuilder

languages = [Language.ENGLISH, Language.FRENCH, Language.GERMAN, Language.SPANISH]
detector = LanguageDetectorBuilder.from_languages(*languages).build()
confidence_values = detector.compute_language_confidence_values("languages are awesome")

for language, value in confidence_values:
    print(f"{language.name}: {value:.2f}")
```

### Go

A native Go implementation is also available.

**Installation**:

```bash
go get github.com/pemistahl/lingua-go
```

**Basic Example**:

```go
package main

import (
	"fmt"
	"github.com/pemistahl/lingua-go"
)

func main() {
	languages := []lingua.Language{
		lingua.English,
		lingua.French,
		lingua.German,
		lingua.Spanish,
	}
	detector := lingua.NewLanguageDetectorBuilder().
		FromLanguages(languages...).
		Build()

	if language, exists := detector.DetectLanguageOf("languages are awesome"); exists {
		fmt.Println("Detected language:", language)
	}
}
```

### Java / Kotlin (JVM)

For the JVM, `Lingua` provides a robust implementation that can be used from Java, Kotlin, Scala, and other JVM
languages.

**Maven Dependency**:

```xml

<dependency>
    <groupId>com.github.pemistahl</groupId>
    <artifactId>lingua</artifactId>
    <version>1.2.2</version>
</dependency>
```

**Basic Example (Kotlin)**:

```kotlin
import com.github.pemistahl.lingua.api.*
import com.github.pemistahl.lingua.api.Language.*

fun main() {
    val detector = LanguageDetectorBuilder.fromLanguages(ENGLISH, FRENCH, GERMAN, SPANISH).build()
    val detectedLanguage = detector.detectLanguageOf("languages are awesome")
    println("Detected language: $detectedLanguage")
}
```

## See also

* [Lingua Rust GitHub](https://github.com/pemistahl/lingua)
* [Lingua Python GitHub](https://github.com/pemistahl/lingua-py)
* [Lingua Go GitHub](https://github.com/pemistahl/lingua-go)
* [Lingua JVM GitHub](https://github.com/pemistahl/lingua-jvm)
* [AI](ai.md)
* [ML](ml.md)
* [AI Tools](aitools.md)
