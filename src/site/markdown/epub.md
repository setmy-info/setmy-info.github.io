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
    ├── content.opf
    ├── nav.xhtml (EPUB 3) or toc.ncx (EPUB 2)
    ├── images/
    │   ├── image1.png
    │   └── image2.png
    ├── css/
    │   ├── style1.png
    │   └── style2.png
    ├── chapter1.xhtml
    └── chapter2.xhtml
```

#### mimetype

NB! No new line at the end

```
application/epub+zip
```

#### container.xml

```
xxxx
```

#### content.opf

```
xxxx
```

#### nav.xhtml

EPUB 3

```
xxxx
```

For EPUB 2 **toc.ncx**

#### ZIP

```
cd path/to/smi-book.epub
zip -X0 ../smi-book.epub mimetype
zip -Xr9D ../smi-book.epub META-INF EPUB
```

### Coding tips and tricks

## See also

* [w3c epubcheck](https://github.com/w3c/epubcheck)
* [w3 epub3](https://www.w3.org/publishing/epub3/)
* [xxxx](https://xxxxxx)
* [xxxx](https://xxxxxx)
* [xxxx](https://xxxxxx)
* [xxxx](https://xxxxxx)
* [xxxx](https://xxxxxx)
* [xxxx](https://xxxxxx)
