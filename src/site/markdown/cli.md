# CLI related

## Information

Command-Line Interface (CLI) tools are programs operated through a text terminal rather than a graphical interface.
Well-designed CLIs follow established conventions so users can predict behavior, compose commands, and integrate tools
in scripts and pipelines.

Key conventions from the POSIX and Unix tradition:

* Short options use a single dash and a single letter: `-v`, `-h`.
* Long options use double dash and a word: `--verbose`, `--help`.
* `--` signals the end of options; everything after is a positional argument.
* Exit code `0` means success; non-zero means failure.
* Standard output (stdout) carries normal output; standard error (stderr) carries diagnostics and errors.
* Tools should be composable: output of one tool piped as input to another.

### Common option conventions

| Option         | Conventional meaning                    |
|----------------|-----------------------------------------|
| `-h` / `--help`    | Show help and exit                  |
| `-v` / `--verbose` | Increase output verbosity           |
| `-q` / `--quiet`   | Suppress non-error output           |
| `-V` / `--version` | Print version and exit              |
| `-o` / `--output`  | Specify output file or directory    |
| `-f` / `--force`   | Skip safety checks / overwrite      |
| `-n` / `--dry-run` | Show what would be done without doing it |
| `-r` / `-R` / `--recursive` | Recurse into subdirectories |

## Configuration

CLI tools commonly read configuration from one or more of:

* A dotfile in the home directory (e.g., `~/.toolrc`, `~/.config/tool/config.yaml`).
* Environment variables (e.g., `TOOL_CONFIG=/path/to/config`).
* A config file in the project directory (e.g., `.toolrc` in the working directory).
* Command-line flags (highest precedence, override everything else).

The typical precedence order: **CLI flags > environment variables > project config > user config > system config**.

## Usage, tips and tricks

### Shell pipelines

```shell
# Count lines matching a pattern
grep "ERROR" app.log | wc -l

# Sort and deduplicate
cat list.txt | sort | uniq

# Process JSON output
curl -s https://api.example.com/items | jq '.[].name'
```

### Redirections

```shell
# Redirect stdout to file
command > output.txt

# Append stdout to file
command >> output.txt

# Redirect stderr to file
command 2> errors.txt

# Redirect both stdout and stderr
command > output.txt 2>&1

# Discard output
command > /dev/null 2>&1
```

### Exit codes in scripts

```shell
#!/bin/bash
set -euo pipefail   # exit on error, unset variable, pipe failure

command_that_might_fail
echo "Success"
```

### Coding tips and tricks

* Design CLI tools to read from stdin when no file argument is given, for pipeline composability.
* Print usage/help to stdout so it can be piped or redirected.
* Never mix progress/diagnostic output into stdout — use stderr for it.
* Follow the convention of `--help` and `--version` at minimum.

## See also

* [CLI design guidelines (clig.dev)](https://clig.dev/#consistency-across-programs)
* [Standard CLI options (TAOUP)](http://catb.org/~esr/writings/taoup/html/ch10s05.html#id2948149)
* [Shell scripting](shell.md)
* [Linux](linux.md)
