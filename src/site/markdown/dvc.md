# DVC

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```shell
git init

dvc init

git status

git commit -m "Initialize DVC"

mkdir data

nano data/huge.file.txt

dvc add data/huge.file.txt

git add data/huge.file.txt.dvc data/.gitignore

dvc move data/huge.file.txt data/huge.file.2.txt

git add data/huge.file.2.txt.dvc

git add data/.gitignore

git commit -m "Rename file using DVC"

git commit -m "Add raw data"

dvc remote add mylocalremote c:\\data\\tank\\dvc

dvc remote add -d origin c:\\data\\tank\\dvc

dvc remote default origin

dvc remote modify origin url /NEW/URL

dvc remote list

dvc remote remove mylocalremote

git add .dvc

dvc push

dvc checkout
```

### Coding tips and tricks

## See also

[DVC](https://dvc.org)

[Data pipelines](https://dvc.org/doc/start/data-management/data-pipelines)

[DVC YAML](https://dvc.org/doc/user-guide/project-structure/dvcyaml-files)
