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
