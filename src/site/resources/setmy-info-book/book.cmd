@echo off
setlocal

set BOOK_NAME1=setmy-info-book.epub.zip
set BOOK_NAME2=setmy-info-book.epub

call :buildBook %BOOK_NAME1%
call :buildBook %BOOK_NAME2%

exit /b 0

:buildBook
set BOOK_NAME=%~1

REM Remove
if exist "..\%BOOK_NAME%" del "..\%BOOK_NAME%"

REM Add mimetype
7z a -mx=0 "..\%BOOK_NAME%" mimetype >nul

REM Then add rest of the files
7z a -tzip "..\%BOOK_NAME%" META-INF EPUB >nul

exit /b
