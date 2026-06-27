# zip

## Information

`zip` is a command-line tool and archive format used to package one or more files and directories into a single
compressed `.zip` file. In daily system administration and developer workflows, it is commonly paired with `unzip` for
creating, listing, testing, and extracting archives.

The `ZIP` format is widely supported across Linux, `macOS`, `Windows`, BSD systems, and many programming languages,
which makes it one of the most practical formats for exchanging files between different operating systems.

In practice, people use `zip` when they want to:

* bundle files for transfer or download,
* compress logs, reports, or build artifacts,
* archive directories while preserving relative paths,
* create password-protected archives for lightweight protection,
* prepare cross-platform archives that can be opened almost anywhere.

### Main functionalities and features

* **Create archives**: store multiple files and directories in one `.zip` file,
* **Compression**: reduce size for text-heavy or repetitive content,
* **Recursive directory support**: archive whole directory trees with `-r`,
* **Update existing archives**: add or refresh changed files without rebuilding from scratch,
* **Listing and extraction**: inspect and unpack archives with `unzip`,
* **Broad compatibility**: usually works well across major operating systems and desktop tools.

### `zip` command vs `ZIP` format

It is useful to separate two related ideas:

* **`zip` command**: the CLI utility used to create or update archives,
* **`ZIP` format**: the archive file format itself, supported by many tools beyond the original CLI.

This means you might create a `.zip` file with the `zip` command on Linux and later open it in `Windows Explorer`,
`7-Zip`, Java libraries, or browser-based tooling.

### Typical use cases

* create a downloadable package of generated reports,
* compress a project folder before sending it to another team,
* archive logs while excluding temporary or noisy files,
* inspect the contents of an archive before extraction,
* update an existing archive with only newer versions of files.

## Installation

### Rocky Linux

```bash
sudo dnf install zip unzip
```

### Fedora

```bash
sudo dnf install zip unzip
```

### FreeBSD

```bash
sudo pkg install zip unzip
```

### OpenIndiana

```bash
pfexec pkg install archiver/zip archiver/unzip
```

## Configuration

For most users, `zip` and `unzip` need little or no configuration.

Operationally, the main things to care about are:

* where archives are created and extracted,
* whether recursive archiving should include hidden or temporary files,
* whether password protection is acceptable for the sensitivity level of the data,
* and whether file names and permissions need special handling across operating systems.

For stronger security requirements, prefer modern encrypted containers or transport-level security rather than relying
only on basic `ZIP` password protection.

## Usage, tips and tricks

### Common commands

Create a new archive:

```bash
zip archive.zip file1.txt file2.txt
```

Create an archive from a directory recursively:

```bash
zip -r folder.zip myfolder
```

Exclude matching files while archiving:

```bash
zip -r folder.zip myfolder -x '*.log'
```

List archive contents without extracting:

```bash
unzip -l archive.zip
```

Extract into the current directory:

```bash
unzip archive.zip
```

Extract into a specific directory:

```bash
unzip archive.zip -d /path/to/directory
```

Add another file to an existing archive:

```bash
zip archive.zip file3.txt
```

Update only files that changed:

```bash
zip -u archive.zip file1.txt
```

Create a password-protected archive:

```bash
zip -e archive.zip file1.txt file2.txt
```

### Practical notes

* Use `-r` carefully because it may include cache directories, build output, or hidden files you did not intend to
  ship.
* Use `unzip -l` before extraction when working with archives from untrusted or unfamiliar sources.
* Be careful when extracting into shared directories so existing files are not overwritten unexpectedly.
* Password-protected `ZIP` archives are convenient, but they should not be treated as high-assurance encryption.

### Coding tips and tricks

When `ZIP` files are used in software projects:

* treat them as packaging or interchange artifacts,
* avoid committing large generated archives into source control unless there is a strong reason,
* prefer deterministic build packaging when archives are part of release automation,
* verify archive contents explicitly in scripts before distributing them.

## See also

* [ZIP file format](https://en.wikipedia.org/wiki/ZIP_(file_format))
* [7-Zip](7zip.md)
* [tar](tar.md)
