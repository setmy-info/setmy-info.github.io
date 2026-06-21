# Windows CMD

## Information

Windows CMD (Command Prompt) is the legacy command-line shell for Microsoft Windows. It interprets batch scripts
written in `.bat` or `.cmd` files and provides a basic scripting environment for Windows automation.

CMD is specified by the `COMSPEC` environment variable (typically `C:\Windows\System32\cmd.exe`). For modern
Windows scripting, prefer PowerShell — it is more powerful, object-oriented, and cross-platform. CMD remains
relevant for legacy batch scripts and environments where PowerShell is not available.

## Configuration

### Environment variables

```bat
:: Set a variable for the current session
set MY_VAR=hello

:: Set a variable permanently (user scope)
setx MY_VAR "hello"

:: Display current PATH
echo %PATH%

:: Add to PATH for current session
set PATH=%PATH%;C:\my\tools
```

Common built-in variables:

| Variable       | Description                            |
|----------------|----------------------------------------|
| `%PATH%`       | Executable search path                 |
| `%TEMP%`       | Temporary files directory              |
| `%USERPROFILE%`| Current user's home directory          |
| `%CD%`         | Current working directory              |
| `%~dp0`        | Directory of the currently running script |
| `%COMSPEC%`    | Path to cmd.exe                        |

## Usage, tips and tricks

### Path manipulation

```bat
set CUR_DIR=%CD%
set PROJECT_NAME_BIN_DIR=%~dp0
set PROJECT_NAME_BIN_DIR=%PROJECT_NAME_BIN_DIR:~0,-1%
set PROJECT_NAME_LIB_DIR=%PROJECT_NAME_BIN_DIR%\..\lib
for %%I in (%CUR_DIR%) do set CUR_DIR_SHORT_NAME=%%~nI
for %%A in ("%~dp0\.") do set COMMAND_DIR=%%~dpnxA
for %%B in ("%~dp0\.") do for %%C in ("%%~dpB\.") do set COMMAND_PARENT_DIR=%%~dpnxC
for %%B in ("%CUR_DIR%") do for %%C in ("%%~dpB\.") do set CUR_DIR_PARENT=%%~dpnxC
```

Output example:

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

### Multi-line command

```bat
call some-command ^
    -p param ^
    -a another
```

### Useful commands

```bat
:: List directory
dir
:: Change directory
cd C:\path\to\dir
:: Copy file
copy source.txt dest.txt
:: Delete file
del file.txt
:: Check if a file exists
if exist myfile.txt echo found
:: Run a script silently
call myscript.bat > NUL 2>&1
```

## See also

* [Microsoft CMD documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands)
* [Windows](windows.md)
* [Shell scripting](shell.md)
