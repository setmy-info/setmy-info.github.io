# Windows CMD

## Usage, tips and tricks

```sh
set CUR_DIR=%CD%
set PROJECT_NAME_BIN_DIR=%~dp0
set PROJECT_NAME_BIN_DIR=%PROJECT_NAME_BIN_DIR:~0,-1%
set PROJECT_NAME_LIB_DIR=%PROJECT_NAME_BIN_DIR%\..\lib
for %%I in (%CUR_DIR%) do set CUR_DIR_SHORT_NAME=%%~nI
for %%A in ("%~dp0\.") do set COMMAND_DIR=%%~dpnxA
for %%B in ("%~dp0\.") do for %%C in ("%%~dpB\.") do set COMMAND_PARENT_DIR=%%~dpnxC
for %%B in ("%CUR_DIR%") do for %%C in ("%%~dpB\.") do set CUR_DIR_PARENT=%%~dpnxC
```

Output

```text
CUR_DIR=C:\data\software\example
PROJECT_NAME_BIN_DIR=C:\pub\smi\bin\
PROJECT_NAME_BIN_DIR=C:\pub\smi\bin
PROJECT_NAME_LIB_DIR=C:\pub\smi\bin\..\lib
CUR_DIR_SHORT_NAME=example
COMMAND_DIR=C:\pub\smi\bin
COMMAND_PARENT_DIR=C:\pub\smi
CUR_DIR_PARENT=C:\data\software
```

## See also

[xxxx](http://yyyyy)
