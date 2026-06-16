## Purpose

This document describes the SEO principles and practical rules that should be followed when building pages, examples,
documentation, or generated HTML around `setmy-info-less` and `setmy-info-less-extended`.

The repository is primarily a LESS and HTML tooling workspace, not a marketing site generator, so SEO here should be
treated as a content and markup discipline:

- make pages understandable to search engines
- make page purpose obvious to humans
- keep HTML structure semantic and predictable
- avoid shipping demo pages that look valid visually but are weak in metadata or document structure

SEO in this repository should always support the same broader quality goals already visible in the project:

- explicit structure
- reusable patterns
- predictable layering
- Firefox-first implementation with modern evergreen browser behavior

## Core SEO principles

### 1. One page must have one clear purpose

Every HTML page should communicate a single primary topic.

That means:

- one page should target one main subject, example, component family, or documentation purpose
- the title, main heading, description, and visible introductory text should all describe the same topic
- avoid pages that mix unrelated experiments, unrelated keywords, or unrelated documentation topics just to increase
  text

Good examples of page intent:

- a page that demonstrates frame layouts
- a page that documents utility activator classes
- a page that explains responsive device rules

Weak examples of page intent:

- a page combining typography demo, layout demo, random notes, and JavaScript experiments without a clear main topic
- a page titled one thing but visually centered around something else

Search engines reward clarity. A page that is structurally consistent is easier to classify, index, and rank for its
real purpose.

### 2. Metadata must match visible content

The HTML `<title>` and meta description must reflect what the user actually sees on the page.

If the page is about experimental frames, the metadata should say that directly. Avoid vague or generic metadata such
as:

- `test page`
- `HTML 5 CSS test pages`
- `demo`

These may be acceptable during quick local experiments, but they are weak for any page that might be published,
indexed, shared, or reused as a documentation artifact.

The rule is simple:

- the title should identify the page topic
- the meta description should summarize the page value in one or two concrete sentences
- the first visible heading and introduction should support the same topic

### 3. Semantic HTML is an SEO feature

SEO is not only about keywords. It depends heavily on document structure.

Use meaningful HTML elements whenever possible:

- `header` for page or section introduction
- `main` for primary page content
- `nav` for navigation blocks
- `section` for grouped topics
- `article` for standalone content units
- `aside` for secondary/supporting content
- `footer` for closing metadata or navigation

Search engines use semantic structure to understand hierarchy and importance. Semantic HTML also improves
accessibility, which usually improves SEO quality indirectly.

### 4. Content must describe behavior, not only appearance

This repository already prefers describing CSS by behavior and structure. The same principle should be followed in SEO
content.

For example, documentation should prefer descriptions like:

- `utility activator class for hiding an element`
- `frame layout for left-right split content`
- `responsive helper for phone-sized viewports`

Instead of weak wording like:

- `nice class`
- `special style`
- `cool layout`

Search engines understand intent better when text names what the feature does, who it is for, and when it should be
used.

### 5. Pages should be indexable because they are useful, not because they are noisy

Do not try to improve SEO by stuffing repeated terms into headings, class explanations, or intro paragraphs.

Prefer:

- precise terminology
- short explanatory paragraphs
- meaningful examples
- stable page structure

Avoid:

- repeating the same key phrase unnaturally many times
- adding empty paragraphs only to include keywords
- listing terms with no explanation

The right goal is relevance and clarity, not keyword density.

### 6. Performance and clean output support SEO

Search engines favor pages that are efficient and stable.

For this repository, that means:

- load only the CSS files that are needed
- keep example pages focused
- avoid unnecessary JavaScript on documentation/demo pages
- reduce console noise and debug leftovers in published examples
- make generated HTML valid and predictable

Even when a page is mainly a demo page, avoid shipping debug-oriented output if the page may later be reused publicly.

## Detailed SEO rules

### Page title rules

Each page must have exactly one useful `<title>`.

Recommended characteristics:

- specific to the page
- human-readable
- not just a file name
- not only an internal experiment label

Preferred style:

- `Experimental Frames Layout Demo | setmy-info-less-extended`
- `Utility Activator Classes | setmy-info-less`
- `Responsive Device Rules | setmy-info-less`

Avoid:

- `index.html`
- `page1`
- `experimental-frames.html`
- `test`

The title is one of the strongest SEO signals on the page, so it should describe topic and context, not only storage
name.

### Meta description rules

Every public or shareable page should have a meta description.

The description should:

- summarize the page clearly
- mention the main subject once in natural language
- describe what the user will learn, see, or compare
- stay factual

Good pattern:

`Demonstrates split-pane and frame-oriented layouts from setmy-info-less-extended, including structural containers and responsive behavior.`

Avoid descriptions that are:

- generic
- duplicated across many pages
- unrelated to the visible page content
- only a list of keywords

### Heading hierarchy rules

Use a logical heading hierarchy.

Rules:

- exactly one main `h1` per page
- use `h2` for major sections
- use `h3` and deeper levels only when needed under a parent heading
- do not skip levels without reason

Why this matters:

- headings help search engines understand content structure
- headings improve scanability for humans
- headings make documentation pages easier to reuse and maintain

Bad structure example:

- page title in `div`
- no `h1`
- multiple unrelated `h1` elements
- jumping from `h1` to `h4` only for visual size

Visual styling should be handled by CSS, not by breaking semantic heading order.

### URL and file naming rules

When page URLs or output file names may become public, use stable and descriptive names.

Prefer:

- short names
- lowercase words
- hyphen-separated topics
- names that match the page purpose

Examples:

- `utility-classes.html`
- `responsive-layouts.html`
- `experimental-frames.html`

File names should still not be the only SEO signal. A good URL helps, but good structure and content matter more.

### Canonical content rules

Avoid publishing several pages with nearly identical content under different names.

If multiple pages demonstrate the same concept:

- decide which page is the main reference
- reduce duplication where possible
- make variant pages clearly distinct in purpose

This is especially important in repositories that generate many demo pages, because generated examples can easily drift
into duplicated structures with only small wording changes.

### Introductory content rules

A good page should open with a short visible explanation near the top of the main content.

That intro should answer:

- what this page is about
- who it is useful for
- what the reader can expect to learn or inspect

For documentation/demo pages, one short paragraph is usually enough.

Avoid opening a page with only a layout shell and no explanation. Search engines and first-time users both benefit from
brief context.

### Image rules

If images are used:

- provide meaningful `alt` text
- do not use image text as the only place where important meaning exists
- use descriptive file names where possible

For decorative images:

- use empty `alt` only when the image truly adds no content meaning

If a screenshot demonstrates a CSS behavior, the surrounding text should still explain the behavior in words.

### Link rules

Links should be descriptive.

Prefer:

- `Read the developer guide`
- `Open the frame layout example`
- `See the utility panel helpers`

Avoid repeated weak link text such as:

- `click here`
- `more`
- `link`

Internal links are useful for SEO because they help search engines understand relationships between pages and help users
move between concepts.

### Structured consistency rules

Pages in the same documentation family should follow a shared structure where practical.

For example:

1. title and description
2. short introduction
3. main example or explanation
4. usage guidance
5. related links

This consistency helps both maintainers and search engines understand what kind of page they are reading.

### Accessibility-aligned SEO rules

Accessibility improvements often strengthen SEO at the same time.

Required mindset:

- use semantic landmarks
- label interactive elements clearly
- preserve readable contrast
- keep DOM order meaningful
- make headings descriptive

If a page is hard to interpret with assistive technologies, it is often also harder for search engines to interpret
well.

### JavaScript rules for SEO-sensitive pages

The repository contains some experimental pages with JavaScript behavior. For SEO-sensitive pages, JavaScript should not
hide essential meaning.

Rules:

- important textual content should exist in the HTML, not only after script execution
- scripts should enhance, not define, the entire page meaning
- remove debug logging from public-facing pages when it adds no user value
- interactive resizing or experiments should not prevent the page from having understandable base content

For example, a split-pane demo can still have a semantic heading, explanatory paragraph, and clear section labels before
any script runs.

### Demo page rules

Demo pages are valid content, but they still need discipline if they may be indexed or shared.

A good demo page should include:

- a concrete title
- a useful description
- a visible explanation of what is being demonstrated
- labels for important panels or sections
- enough text to explain purpose without turning the page into marketing copy

If a demo page is purely internal and should not be indexed, then that decision should be explicit in deployment or site
integration. Do not rely on weak content to prevent indexing.

## Recommended metadata pattern

Use this as a baseline for public-facing documentation or example pages:

```html

<head>
    <title>Experimental Frames Layout Demo | setmy-info-less-extended</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta
        name="description"
        content="Demonstrates frame-oriented and split-pane layouts from setmy-info-less-extended with semantic page structure and responsive behavior."
    >
</head>
```

This should then be matched by visible body content such as:

- one `h1`
- one short intro paragraph
- semantic sections for the demonstrated layouts

## How these SEO rules fit this repository

### Base module relevance

For `setmy-info-less`, SEO quality mostly depends on how generated or example HTML uses:

- structural selectors
- utility activator classes
- headings
- navigation
- content grouping

Because the base module provides many reusable styling helpers, documentation should explain them with clear behavior
language. That improves both developer understanding and content relevance.

### Extended module relevance

For `setmy-info-less-extended`, SEO concerns are especially relevant in frame and experimental pages.

These pages often risk becoming visually interesting but semantically weak. When authoring them:

- ensure panel layouts still have meaningful labels and headings
- make sure page titles describe the frame pattern, not just the file name
- describe the layout purpose in visible text
- avoid relying only on visual arrangement to communicate page meaning

## Practical do and do not list

### Do

- use a descriptive `<title>`
- write a page-specific meta description
- include one clear `h1`
- use semantic HTML landmarks
- describe CSS behavior in human terms
- keep page topics focused
- add short explanatory text to demos and docs
- use descriptive links and image alt text
- keep public-facing HTML clean and intentional

### Do not

- publish pages with file-name-only titles
- reuse the same description on unrelated pages
- rely on visual layout alone to communicate meaning
- stuff keywords into headings or paragraphs
- use headings only for styling size
- leave public demo pages with only debug-oriented wording
- depend on JavaScript to create all meaningful content

## Decision rule for future changes

When adding or editing a page, ask these questions:

1. What is the single main topic of this page?
2. Does the `<title>` describe that topic clearly?
3. Does the meta description match the visible content?
4. Is there one clear `h1`?
5. Does the page use semantic sections and landmarks?
6. Would a search engine understand the page without guessing from CSS or JavaScript?
7. Would a first-time human visitor immediately understand what this page is for?

If any answer is `no`, improve the page structure before considering the page SEO-ready.

## Conclusion

SEO in this repository should be treated as structured documentation quality:

- clear topic per page
- accurate metadata
- semantic HTML
- descriptive content
- clean, reusable page patterns

The most important rule is consistency between page intent, metadata, and visible content. If those three stay aligned,
most on-page SEO decisions will already be on the right track.
