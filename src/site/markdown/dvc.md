# DVC

## Information

`DVC` (`Data Version Control`) is a command-line tool for tracking large files, datasets, models, and machine learning pipelines together with normal source code repositories.

In practice, it gives developers a workflow similar to `Git`, but for data and reproducible processing steps:

* Keep code in `Git` (or another source-control workflow).
* Keep large files out of the main VCS history.
* Store tracked data in a separate cache / remote storage.
* Restore matching versions of datasets and generated artifacts when switching revisions.
* Define repeatable pipelines with dependencies, outputs, parameters, and metrics.

Main functionalities and features:

* **Large file tracking** without committing raw data blobs directly into normal `Git` history.
* **Local cache + remote storage** support for local paths, `S3`, `SSH`, `Azure Blob`, `GCS`, and similar backends depending on installed extras.
* **Reproducible pipelines** via `dvc.yaml`, `dvc.lock`, tracked dependencies, and commands.
* **Experiment tracking** for data science and machine learning workflows.
* **Data checkout / rollback** so a repository revision can restore the matching data state.
* **Team collaboration** where developers share metadata in VCS and share actual data via DVC remotes.
* **Metrics and plots** support for evaluating experiments and model runs.

Good use cases:

* Machine learning training datasets and model artifacts.
* Generated binary assets that are too large for normal VCS history.
* ETL / data engineering pipelines where inputs and outputs must be reproducible.
* Teams that want `Git`-style workflows for code but do not want to store huge files directly in the VCS server.

## Installation

`DVC` is a Python-based CLI. The most common and reliable installation approach is `pip`, `pipx`, or an official Python environment. Some operating systems may have community packages, but those can lag behind the upstream release.

Before installing, verify Python:

```shell
python --version
pip --version
```

Recommended general installation options:

```shell
pip install --user dvc
```

or with isolated CLI installation:

```shell
pipx install dvc
```

If you need a storage backend plugin, install the matching extra, for example:

```shell
pip install --user "dvc[s3]"
pip install --user "dvc[ssh]"
pip install --user "dvc[gs]"
pip install --user "dvc[azure]"
```

Check installation:

```shell
dvc version
```

### CentOS, Rocky Linux

Install Python tooling first:

```shell
sudo dnf install -y python3 python3-pip
python3 -m pip install --user dvc
```

If your team prefers isolated CLI tools:

```shell
sudo dnf install -y python3 python3-pip pipx
pipx install dvc
```

Developer note:

* On enterprise-like systems, `pipx` or a virtual environment is often safer than mixing many Python CLI tools into the base interpreter.

### Fedora

```shell
sudo dnf install -y python3 python3-pip pipx
pipx install dvc
```

If `pipx` is not preferred:

```shell
python3 -m pip install --user dvc
```

### macOS

Common options:

```shell
brew install pipx
pipx install dvc
```

or:

```shell
python3 -m pip install --user dvc
```

### FreeBSD

Typical approach is Python-based installation:

```shell
pkg install -y python3 py39-pip
python3 -m pip install --user dvc
```

If a matching package version differs on the system, use the available Python / pip package names from the repository.

### OpenIndiana

Package availability can vary, so the practical path is usually Python + `pip`:

```shell
pkg install runtime/python-311
python3 -m ensurepip --upgrade
python3 -m pip install --user dvc
```

If the Python package name differs in your image/repository, use the available Python 3 runtime and then install `DVC` with `pip`.

## Configuration

Typical developer setup flow:

1. Initialize normal source control in the repository.
2. Initialize `DVC` in that repository.
3. Add large files or directories with `dvc add`.
4. Commit the generated `.dvc` files, `.gitignore` changes, `dvc.yaml`, and `dvc.lock` files to VCS.
5. Configure one or more remotes.
6. Push data to the remote so teammates and CI can restore it.

Basic repository initialization:

```shell
git init
dvc init
git add .dvc .dvcignore
git commit -m "Initialize DVC"
```

Useful configuration notes:

* `.dvc/config` is repository-local configuration.
* `.dvc/config.local` is useful for machine-specific settings that should usually not be committed.
* `dvc remote add -d origin <URL>` sets the default remote.
* `dvc doctor` can help diagnose environment issues.
* `dvc cache dir <PATH>` can move the cache to a larger disk if needed.

Examples:

```shell
dvc remote add -d origin C:\data\tank\dvc
dvc remote list
dvc doctor
```

If the cache should live on another drive:

```shell
dvc cache dir D:\dvc-cache
```

Typical remote types developers use:

* local directory for fast local experiments,
* shared network storage,
* `SSH`-reachable storage,
* `S3`-compatible object storage,
* cloud blob/object services.

## Usage, tips and tricks

### Continuous Example Script: How DVC Works End-to-End

The following script is meant to show the normal developer flow from empty repository to tracked data, remote push, modification, and restoring an older state. Adjust paths for your platform.

```shell
mkdir dvc-demo
cd dvc-demo

git init
dvc init
git add .dvc .dvcignore
git commit -m "Initialize repository with DVC"

mkdir data
mkdir remote-storage

echo "raw line 1" > data\dataset.txt
echo "raw line 2" >> data\dataset.txt

dvc add data\dataset.txt
git add data\.gitignore data\dataset.txt.dvc
git commit -m "Track dataset with DVC"

dvc remote add -d localremote .\remote-storage
git add .dvc\config
git commit -m "Configure local DVC remote"

dvc push

echo "raw line 3" >> data\dataset.txt
dvc status

dvc add data\dataset.txt
git add data\dataset.txt.dvc
git commit -m "Update tracked dataset"

dvc push

git log --oneline -n 2

git checkout HEAD~1
dvc checkout

type data\dataset.txt

git checkout -
dvc checkout

type data\dataset.txt
```

What this demonstrates:

* `Git` tracks the small metadata files.
* `DVC` tracks the actual file content in cache / remote storage.
* `dvc push` uploads data objects to the configured remote.
* `dvc checkout` restores the workspace data for the current repository revision.

Developer notes:

* Use `dvc status` before and after `dvc add` to understand whether tracked outputs changed.
* If another developer cloned the repository, they usually need `dvc pull` to restore the data after `git clone`.
* For large directory trees, track directories instead of adding thousands of files one by one.

### Working with DVC Remotes

Useful remote commands:

```shell
dvc remote add mylocalremote C:\data\tank\dvc
dvc remote add -d origin C:\data\tank\dvc
dvc remote default origin
dvc remote modify origin url C:\new-data-location\dvc
dvc remote list
dvc remote remove mylocalremote
```

Typical daily workflow in an existing repository:

```shell
git pull
dvc pull

# work with data

dvc status
dvc add data
git add *.dvc .gitignore dvc.yaml dvc.lock
git commit -m "Update data metadata"
dvc push
git push
```

### Pipeline Notes

One important strength of `DVC` is pipeline reproducibility. Example:

```shell
dvc stage add -n prepare \
  -d src/prepare.py \
  -d data/dataset.txt \
  -o data/prepared.txt \
  python src/prepare.py
```

This creates `dvc.yaml` and, after running, `dvc.lock`. Those files describe how outputs depend on code and inputs.

Common follow-up commands:

```shell
dvc repro
dvc dag
dvc metrics show
```

### Experimenting with DVC with Sapling (`sl`)

`DVC` is often used with `Git`, but it can still be useful in workflows where you want DVC-managed data and another source-control workflow around the repository. The main idea remains the same: commit `DVC` metadata files to your chosen VCS, and store real data in DVC cache/remotes.

The example below keeps `DVC` in `--no-scm` mode while `Sapling` tracks the metadata files.

```shell
sl config --user ui.username "John Doe <john.doe@example.com>"

mkdir sapling-dvc-experiment
cd sapling-dvc-experiment

sl init
dvc init --no-scm

mkdir huge_files

echo "# Huge files" > .gitignore
echo "huge_files" >> .gitignore
echo "root-huge-file.txt" >> .gitignore

sl add .gitignore .dvcignore

echo "Huge file A" > .\huge_files\A.txt
echo "Huge file B" > .\huge_files\B.txt
echo "Root huge file" > .\root-huge-file.txt

dvc add .\huge_files
dvc add .\root-huge-file.txt

sl add .

dvc remote add -d fake-remote C:\pub\setmy.info\data\dvc

sl commit -m "First huge files added"
dvc push

echo "Huge file A VERSION 2" >> .\huge_files\A.txt
echo "Huge file B VERSION 2" >> .\huge_files\B.txt
echo "Root huge file VERSION 2" >> .\root-huge-file.txt

dvc status
dvc add .\huge_files
dvc add .\root-huge-file.txt

sl status
sl commit -m "Version 2"
dvc push

sl log -l 2

# move to an older Sapling revision, then restore matching data metadata
sl goto .^ 
dvc checkout
```

Important note:

* `Git` remains the best-documented and most common DVC workflow. If you use another VCS, keep the process simple and verify the exact commands in your environment.

### Example `.gitignore`

When you track raw files with `DVC`, the actual data path is often added to `.gitignore` while the small `.dvc` metadata file is committed.

```shell
# Huge files
huge_files
root-huge-file.txt
```

### Coding tips and tricks

* Commit `.dvc` files, `dvc.yaml`, `dvc.lock`, and intentional config changes; do **not** commit the actual large tracked outputs unless you truly mean to keep them in normal VCS.
* Prefer one well-named DVC remote per environment instead of many ad-hoc remotes.
* Keep local-only secrets such as cloud credentials out of committed `.dvc/config`; store machine-specific overrides in `.dvc/config.local` or normal credential providers.
* Use `dvc pull` after switching branches if the working tree data does not match the checked-out metadata.
* Use `dvc gc` carefully. Garbage collection can remove cache objects that other branches, tags, or teammates may still need.
* For CI/CD, make the workflow explicit: source checkout, `dvc pull`, run pipeline/tests, then optionally `dvc push` for newly produced approved artifacts.
* If your goal is full pipeline reproducibility, track parameters and metrics too, not only the dataset files.

## Alternatives

Possible alternatives:

* [Git LFS](https://git-lfs.com/)
* [MLflow](https://www.mlflow.org)
* [Pachyderm](https://www.pachyderm.com/)
* [LakeFS](https://lakefs.io/)
* [Quilt](https://www.quiltdata.com/)
* [Dagster](https://dagster.io/platform)

Short comparison notes:

* `Git LFS` is simpler when you mainly need large-file storage tied closely to `Git`.
* `DVC` is often stronger when you want data versioning plus reproducible pipelines and ML/data workflows.
* `MLflow` focuses more on experiment/model lifecycle tracking than generic file/data versioning.
* `LakeFS` and `Pachyderm` are more platform-oriented and can be better for larger shared data-platform use cases.

## See also

[DVC](https://dvc.org)

[Get Started: Data Management](https://dvc.org/doc/start/data-management)

[Data pipelines](https://dvc.org/doc/start/data-management/data-pipelines)

[DVC YAML](https://dvc.org/doc/user-guide/project-structure/dvcyaml-files)

[Experiments](https://dvc.org/doc/user-guide/experiment-management)

[Issue reported](https://github.com/iterative/dvc/issues/10568)

[Issue turned into discussion](https://github.com/iterative/dvc/discussions/10569)
