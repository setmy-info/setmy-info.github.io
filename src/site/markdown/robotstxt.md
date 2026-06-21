# robots.txt

## Information

`robots.txt` is a plain-text file placed at the root of a web server (`https://example.com/robots.txt`) that instructs
web crawlers which URLs they are allowed or not allowed to crawl. It implements the **Robots Exclusion Protocol**,
an informal standard introduced in 1994.

**Important**: `robots.txt` is advisory only. Legitimate crawlers (Googlebot, Bingbot) respect it; malicious bots
typically ignore it. It is not a security mechanism — do not rely on it to keep content private.

### Syntax

```
User-agent: <bot-name or *>
Disallow: <path>
Allow: <path>
Crawl-delay: <seconds>
Sitemap: <full URL to sitemap.xml>
```

* `User-agent: *` applies the rules to all crawlers.
* `Disallow: /` blocks all crawlers from all pages.
* `Disallow:` (empty value) allows everything.
* `Allow:` overrides a broader `Disallow` for a specific sub-path.
* `Crawl-delay:` is honoured by some bots (not Googlebot) to reduce server load.
* Multiple `User-agent` and `Disallow`/`Allow` lines can form separate rule groups.

## Configuration

### Allow all crawlers (default open site)

```
User-agent: *
Disallow:
Sitemap: https://example.com/sitemap.xml
```

### Block all crawlers (private or staging site)

```
User-agent: *
Disallow: /
```

### Block a specific bot

```
User-agent: SemrushBot
Disallow: /

User-agent: AhrefsBot
Disallow: /
```

### Protect admin and API paths

```
User-agent: *
Disallow: /admin/
Disallow: /api/
Disallow: /private/
Allow: /api/public/
Sitemap: https://example.com/sitemap.xml
```

### Block all except one bot

```
User-agent: Googlebot
Allow: /

User-agent: *
Disallow: /
```

## Usage, tips and tricks

### Test in Google Search Console

Upload your site to Google Search Console and use the **robots.txt Tester** tool to verify which URLs Googlebot
can and cannot access.

### robots.txt vs noindex

`robots.txt Disallow` prevents crawling but does not remove an already-indexed page. To de-index a page that was
previously indexed, use the `<meta name="robots" content="noindex">` HTML tag or the `X-Robots-Tag: noindex` HTTP
header instead.

### Googlebot-specific rules

```
User-agent: Googlebot
Disallow: /staging/
Crawl-delay: 1
```

Note: Googlebot ignores `Crawl-delay`. Use Google Search Console crawl rate settings to control Googlebot speed.

### Sitemap Declaration

Always declare the sitemap URL in `robots.txt` — this helps search engines discover it regardless of submission
through Search Console:

```
Sitemap: https://example.com/sitemap.xml
Sitemap: https://example.com/sitemap-news.xml
```

## See also

* [robotstxt.org](https://www.robotstxt.org/)
* [Google Developers — robots.txt introduction](https://developers.google.com/search/docs/crawling-indexing/robots/intro)
* [MDN — robots.txt](https://developer.mozilla.org/en-US/docs/Web/Security/Practical_implementation_guides/Robots_txt)
* [Google Search Console](https://search.google.com/search-console)
* [SEO](seo.md)
