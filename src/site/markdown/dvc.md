# DVC

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Alternatives

Possible alternatives:

* [Git LFS](https://git-lfs.com/)
* [MLflow](https://www.mlflow.org)
* [Pachyderm](https://www.pachyderm.com/)
* [LakeFS](https://lakefs.io/)
* [Quilt](https://www.quiltdata.com/)
* [Dagster](https://dagster.io/platform)

Looks like there is no relevant tool, that is just CLI, that can use anu VCS system as versioning and push data to
non-VCS repos (different locations).

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

### Experimenting with DVC with sapling (sl)

```
sl config --user ui.username "John Doe <john.doe@sexample.com>"

mkdir sapling-dvc-experiment
cd sapling-dvc-experiment
sl init --git .
dvc init --no-scm

mkdir huge_files

sl status
# ? .dvc\config
# ? .dvc\tmp\btime
# ? .dvcignore

touch .gitignore
sl add .gitignore
sl add .dvcignore

nano .gitignore
# # Huge files
# huge_files

# #DVC working files
# .dvc/**
# .dvc/tmp/**
# .dvc/cache/files/**
# root-huge-file.txt

sl status
# A .dvcignore
# A .gitignore

echo "Huge file A" > ./huge_files/A.txt
echo "Huge file B" > ./huge_files/B.txt
echo "Root huge file" > ./root-huge-file.txt

sl status
# A .dvcignore
# A .gitignore

dvc status

dvc add ./huge_files
dvc add ./root-huge-file.txt

sl status
# A .dvcignore
# A .gitignore
# ? huge_files.dvc
# ? root-huge-file.txt.dvc
sl add .

sl status
# A .dvcignore
# A .gitignore
# A huge_files.dvc
# A root-huge-file.txt.dvc

dvc remote add -d fake-remote C:\pub\setmy.info\data\dvc

sl commit -m "First huge files added"
dvc pull && dvc push
sl push

echo "Huge file A VERSION 2"    >> ./huge_files/A.txt
echo "Huge file B VERSION 2"    >> ./huge_files/B.txt
echo "Root huge file VERSION 2" >> ./root-huge-file.txt

sl status
dvc status
# huge_files.dvc:
#         changed outs:
#                 modified:           huge_files
# root-huge-file.txt.dvc:
#         changed outs:
#                 modified:           root-huge-file.txt

dvc add ./huge_files
dvc add ./root-huge-file.txt

dvs status
sl status
# M huge_files.dvc
# M root-huge-file.txt.dvc

sl commit -m "VERSION 2"
sl push
dvc pull && dvc push

sl log -l 2

# 1 commit hash
sl update 62a142efa0e99403b9ec0115d25abb69b783750a
dvc checkout

# Back to last
sl update default
dvc checkout
```

.gitignore

```
# Huge files
huge_files

#DVC working files
.dvc/**
.dvc/tmp/**
.dvc/cache/files/**
root-huge-file.txt
```

### Coding tips and tricks

## See also

[DVC](https://dvc.org)

[Data pipelines](https://dvc.org/doc/start/data-management/data-pipelines)

[DVC YAML](https://dvc.org/doc/user-guide/project-structure/dvcyaml-files)

[Issue reported](https://github.com/iterative/dvc/issues/10568)

[Issue turned into discussion](https://github.com/iterative/dvc/discussions/10569)
