# epub

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Basic file structure

Basic file structure inside EPUB (ZIP):

```
smi-book.epub/
├── mimetype
├── META-INF/
│   └── container.xml
└── EPUB/
    ├── css/
    │   ├── epub.css
    │   ├── style1.css
    │   └── style2.css
    ├── images/
    │   ├── cover.svg
    │   ├── fallback-cover.png
    │   ├── image1.png
    │   └── image2.png
    ├── content.opf
    ├── navigation.xhtml (EPUB 3) or toc.ncx (EPUB 2)
    ├── cover.xhtml
    ├── end.xhtml
    ├── chapter1.xhtml
    └── chapter2.xhtml
```

#### mimetype

NB! No new line at the end

```
application/epub+zip
```

#### container.xml

```xml
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<container xmlns="urn:oasis:names:tc:opendocument:xmlns:container" version="1.0">
    <rootfiles>
        <rootfile full-path="EPUB/content.opf" media-type="application/oebps-package+xml"/>
    </rootfiles>
</container>
```

#### content.opf

```
<?xml version="1.0" encoding="UTF-8"?>

<package version="3.0" xmlns="http://www.idpf.org/2007/opf"
         unique-identifier="book-id"
         xml:lang="et"
         prefix="schema: http://schema.org/ dcterms: http://purl.org/dc/terms/">

    <metadata xmlns:dc="http://purl.org/dc/elements/1.1/"
              xmlns:dcterms="http://purl.org/dc/terms/"
              xmlns:schema="http://schema.org/">

        <dc:identifier id="book-id">urn:uuid:c4520679-c296-4412-98af-57a2f31a4031</dc:identifier>
        <meta property="dcterms:identifier" refines="#book-id">_manual_book</meta>
        <dc:title id="title">Test Book</dc:title>
        <dc:creator id="creator">Author Name</dc:creator>
        <dc:language>et</dc:language>
        <dc:date>2007-03-13</dc:date>
        <meta property="dcterms:modified">2025-07-18T00:00:00Z</meta>
        <dc:publisher>By My Self</dc:publisher>
        <dc:rights>Copyright © 2025 Imre Tabur</dc:rights>
        <meta property="dcterms:rightsHolder">Imre Tabur</meta>
        <dc:subject>Subject 1</dc:subject>
        <dc:subject>Subject 2</dc:subject>
        <meta property="schema:accessMode">textual</meta>
        <meta property="schema:accessModeSufficient">textual</meta>
        <meta property="schema:accessibilityFeature">tableOfContents</meta>
        <meta property="schema:accessibilityHazard">none</meta>
        <meta property="schema:accessibilitySummary">This publication contains text content and navigation.</meta>
    </metadata>

    <manifest>
        <item id="css" href="css/epub.css" media-type="text/css"/>
        <item id="cover" href="cover.xhtml" media-type="application/xhtml+xml"/>
        <item id="cover-image" href="images/cover.svg" media-type="image/svg+xml"/>
        <item id="fallback-cover" href="images/fallback-cover.jpg" media-type="image/jpeg"/>
        <item id="nav" href="navigation.xhtml" properties="nav" media-type="application/xhtml+xml"/>
        <item id="chapter1" href="chapter1.xhtml" media-type="application/xhtml+xml"/>
        <item id="chapter2" href="chapter2.xhtml" media-type="application/xhtml+xml"/>
        <item id="end" href="end.xhtml" media-type="application/xhtml+xml"/>
    </manifest>

    <spine>
        <itemref idref="cover" linear="yes"/>
        <itemref idref="nav"/>
        <itemref idref="chapter1"/>
        <itemref idref="chapter2"/>
        <itemref idref="end" linear="yes"/>
    </spine>
</package>
```

#### navigation.xhtml

EPUB 3

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:epub="http://www.idpf.org/2007/ops"
      xml:lang="et"
      lang="et">
<head>
    <title>Navigation</title>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" type="text/css" href="css/epub.css"/>
</head>
<body>
<nav epub:type="toc"
     role="doc-toc"
     id="toc">
    <h1>Table of Contents</h1>
    <ol>
        <li><a href="chapter1.xhtml">Chapter 1</a></li>
        <li><a href="chapter2.xhtml">Chapter 2</a></li>
    </ol>
</nav>
</body>
</html>
```

For EPUB 2 **toc.ncx**

#### ZIP

```
#!/bin/sh

buildBook() {
    BOOK_NAME=${1}
    rm -f ../${BOOK_NAME}
    zip -X0 ../${BOOK_NAME} mimetype
    zip -Xr9D ../${BOOK_NAME} META-INF EPUB
}

buildBook setmy-info-book.epub.zip
buildBook setmy-info-book.epub

exit 0
```

### Coding tips and tricks

## See also

* [w3c epubcheck](https://github.com/w3c/epubcheck)
* [w3 epub3](https://www.w3.org/publishing/epub3/)
* [epub validator](https://www.bookery.app/epub_validation)
* [xxxx](https://xxxxxx)
* [xxxx](https://xxxxxx)
* [xxxx](https://xxxxxx)
* [xxxx](https://xxxxxx)
* [xxxx](https://xxxxxx)
