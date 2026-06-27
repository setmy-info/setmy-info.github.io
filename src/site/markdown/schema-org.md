# schema.org

## Information

`schema.org` is shared vocabulary for structured data on the web. It helps website owners describe pages, entities,
events, organizations, products, articles, and many other concepts in a machine-readable way that search engines and
other consumers can understand more consistently.

In practice, teams use `schema.org` to add semantic meaning to site content, most often through `JSON-LD`, so search
engines and external systems can interpret page purpose and important attributes more accurately.

It is especially relevant for websites that care about search visibility, rich results, knowledge panels, content
discovery, and clearer interoperability between web content and automated consumers.

### Main Functionalities and Features

* **Shared Structured Data Vocabulary**: Provides standardized types and properties for describing common web entities.
* **Search Engine Friendly Markup**: Commonly used to help search engines interpret pages and qualify them for rich
  results.
* **Flexible Representation Model**: Can be embedded using `JSON-LD`, `Microdata`, or `RDFa`, depending on the site's
  implementation approach.
* **Broad Entity Coverage**: Supports schemas for organizations, people, articles, products, recipes, events, FAQs,
  reviews, and many other domains.
* **Interoperability Support**: Makes web content easier to consume by search tools, assistants, aggregators, and other
  automated systems.

### How `schema.org` Fits Into Web Development

`schema.org` is not a frontend framework and not a CMS feature by itself. It is a semantic data vocabulary used to
describe content in a structured, machine-readable form.

It is often used when:

* a team wants search engines to better understand page content,
* developers need structured metadata for articles, products, organizations, or navigation,
* or a website aims to support rich snippets, knowledge graph signals, or better content interoperability.

### Common Use Cases

* Mark up articles, blog posts, authors, and publishers on content sites.
* Describe products, pricing, ratings, and availability for e-commerce pages.
* Add organization, local business, and contact information to company websites.
* Publish event, course, recipe, FAQ, or breadcrumb metadata for enhanced search presentation.

### Practical Notes

* `schema.org` markup should reflect the actual visible content of the page rather than aspirational or misleading
  metadata.
* `JSON-LD` is often the preferred implementation format because it is easier to manage than embedding semantics across
  many `HTML` attributes.
* Structured data can improve eligibility for rich results, but it does not guarantee them.

## See also

* [schema.org](https://schema.org/)
* [EPUB](epub.md)
* [SEO](seo.md)
