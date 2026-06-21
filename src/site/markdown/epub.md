# epub

## Information

EPUB is an open e-book standard maintained by the W3C (originally by the IDPF). An EPUB file is a ZIP archive
containing XHTML content, CSS stylesheets, images, and metadata.

- **EPUB 2**: uses `toc.ncx` for navigation, OPF 2.0 package.
- **EPUB 3**: uses `navigation.xhtml` (HTML5 `<nav epub:type="toc">`), OPF 3.0. EPUB 3 is the current standard.

The `mimetype` file inside the ZIP must be the first entry and must not be compressed.

## Installation

### CentOS, Rocky Linux / Fedora

```shell
# Calibre — read, edit, and convert e-books
sudo dnf install -y calibre

# Pandoc — convert documents (Markdown, DOCX, etc.) to EPUB
sudo dnf install -y pandoc
```

### Debian

```shell
sudo apt install -y calibre pandoc
```

### Python (programmatic creation)

```shell
pip install ebooklib
```

### Validation

```shell
# epubcheck — W3C's official EPUB validator (requires Java)
# Download from https://github.com/w3c/epubcheck/releases
java -jar epubcheck.jar my-book.epub
```

## Configuration

### content.opf — package document (EPUB 3)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<package version="3.0" xmlns="http://www.idpf.org/2007/opf"
         unique-identifier="book-id"
         xml:lang="et">

    <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
        <dc:identifier id="book-id">urn:uuid:c4520679-c296-4412-98af-57a2f31a4031</dc:identifier>
        <dc:title id="title">Test Book</dc:title>
        <dc:creator id="creator">Author Name</dc:creator>
        <dc:language>et</dc:language>
        <dc:date>2007-03-13</dc:date>
        <meta property="dcterms:modified">2025-07-18T00:00:00Z</meta>
        <dc:publisher>By My Self</dc:publisher>
        <dc:rights>Copyright © 2025 Imre Tabur</dc:rights>
    </metadata>

    <manifest>
        <item id="css"      href="css/epub.css"        media-type="text/css"/>
        <item id="cover"    href="cover.xhtml"         media-type="application/xhtml+xml"/>
        <item id="nav"      href="navigation.xhtml"    properties="nav" media-type="application/xhtml+xml"/>
        <item id="chapter1" href="chapter1.xhtml"      media-type="application/xhtml+xml"/>
        <item id="chapter2" href="chapter2.xhtml"      media-type="application/xhtml+xml"/>
        <item id="end"      href="end.xhtml"           media-type="application/xhtml+xml"/>
    </manifest>

    <spine>
        <itemref idref="cover"/>
        <itemref idref="nav"/>
        <itemref idref="chapter1"/>
        <itemref idref="chapter2"/>
        <itemref idref="end"/>
    </spine>
</package>
```

### container.xml

```xml
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<container xmlns="urn:oasis:names:tc:opendocument:xmlns:container" version="1.0">
    <rootfiles>
        <rootfile full-path="EPUB/content.opf" media-type="application/oebps-package+xml"/>
    </rootfiles>
</container>
```

## Usage, tips and tricks

### Basic file structure inside EPUB (ZIP)

```
smi-book.epub/
├── mimetype                          (no newline at end)
├── META-INF/
│   └── container.xml
└── EPUB/
    ├── css/
    │   ├── epub.css
    │   └── style1.css
    ├── images/
    │   ├── cover.svg
    │   └── image1.png
    ├── content.opf
    ├── navigation.xhtml              (EPUB 3) or toc.ncx (EPUB 2)
    ├── cover.xhtml
    ├── chapter1.xhtml
    ├── chapter2.xhtml
    └── end.xhtml
```

### navigation.xhtml (EPUB 3)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:epub="http://www.idpf.org/2007/ops"
      xml:lang="et" lang="et">
<head>
    <title>Navigation</title>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" type="text/css" href="css/epub.css"/>
</head>
<body>
<nav epub:type="toc" role="doc-toc" id="toc">
    <h1>Table of Contents</h1>
    <ol>
        <li><a href="chapter1.xhtml">Chapter 1</a></li>
        <li><a href="chapter2.xhtml">Chapter 2</a></li>
    </ol>
</nav>
</body>
</html>
```

### Build script

```shell
#!/bin/sh

buildBook() {
    BOOK_NAME=${1}
    rm -f ../${BOOK_NAME}
    zip -X0 ../${BOOK_NAME} mimetype
    zip -Xr9D ../${BOOK_NAME} META-INF EPUB
}

buildBook setmy-info-book.epub
```

## See also

* [W3C EPUB 3 specification](https://www.w3.org/publishing/epub3/)
* [epubcheck — W3C EPUB validator](https://github.com/w3c/epubcheck)
* [Bookery EPUB validator (online)](https://www.bookery.app/epub_validation)
* [Calibre e-book manager](https://calibre-ebook.com/)
* [Pandoc document converter](https://pandoc.org/)
