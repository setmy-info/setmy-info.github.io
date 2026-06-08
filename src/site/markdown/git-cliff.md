# git-cliff

## Information

`git-cliff` is an open-source changelog generator for Git repositories. It is designed to create release notes and changelog files from commit history, with strong emphasis on customization, conventional commit workflows, and configuration-driven output formatting. In practice, it is useful for teams that want repeatable changelog generation in local development, release automation, and `CI/CD` pipelines.

### Main Functionalities and Features

* **Automated Changelog Generation**: Builds changelogs from Git history instead of maintaining every release note manually.
* **Highly Customizable Output**: Uses configuration files and regex-based parsing to shape the final changelog format.
* **Conventional Commits Support**: Works especially well with repositories that follow conventional commit conventions.
* **Release-oriented Workflow Support**: Useful for generating release notes between tags or versions.
* **CLI and Library Usage**: Primarily used as a command-line tool and can also be embedded in Rust projects as a library.
* **Easy Automation**: Fits naturally into build scripts, release pipelines, and repository maintenance workflows.

### Common Developer and Release Engineering Use Cases

* Generate a `CHANGELOG.md` file before cutting a new release.
* Produce release notes from Git tags in `CI`.
* Standardize changelog formatting across many repositories.
* Use conventional commits to automatically group features, fixes, and breaking changes.
* Keep manual editing focused on exceptional notes instead of assembling the whole changelog by hand.

## Installation

`git-cliff` provides installation options through its documentation and release distribution channels. In practice, teams usually install it either from a package manager, from release binaries, or by integrating it into existing language- or toolchain-specific workflows.

### Practical Notes

* Prefer a pinned version in release automation for predictable output.
* Align commit conventions before expecting fully structured changelogs.
* Store the `git-cliff` configuration in the repository so changelog generation stays reproducible.

## Configuration

Typical configuration areas include:

* commit parsing rules,
* grouping and ordering of changes,
* template and formatting behavior,
* tag and release range selection,
* and inclusion or exclusion of commits that should not appear in public changelogs.

Because `git-cliff` is intentionally very customizable, the most important team practice is to version the configuration file together with the repository and document which release process is expected to use it.

## Usage, tips and tricks

### Typical Workflow

1. Adopt a consistent commit style such as conventional commits.
2. Add and version a `git-cliff` configuration file in the repository.
3. Run `git-cliff` locally or in `CI` to generate the changelog from Git history.
4. Review the generated output before publishing a release.
5. Use tags consistently so release boundaries remain clear.

### Practical Notes

* The tool works best when commit messages are already disciplined.
* Keep the changelog template aligned with how your team communicates releases.
* Test the output on a few historical tags before making it part of the official release pipeline.
* Use repository-specific rules when different projects need different changelog sections or formatting.

## See also

* [git-cliff official site](https://git-cliff.org/)
* [git-cliff GitHub repository](https://github.com/orhun/git-cliff)
* [GIT](git.html)
* [GitHub](github.html)