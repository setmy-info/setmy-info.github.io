# Conda

## Information

Package, dependency and environment management for any language—Python, R, Ruby, Lua, Scala, Java, JavaScript, C/ C++,
Fortran, and more.

## Installation

### CentOS, Rocky Linux

### Fedora

```shell
sudo dnf -y install conda
```

User should execute conda init for bash.

```shell
conda init bash
```

### OpenIndiana

### Windows

Install conda with PATH option.

## Configuration

## Usage, tips and tricks

*Windows**

```shell
set PROJECT_NAME=conda-experiments
```

***nixes**

```shell
PROJECT_NAME=conda-experiments
```

```shell
mkdir ${PROJECT_NAME}
cd ${PROJECT_NAME}
conda create -y -n ${PROJECT_NAME}                      # create conda environment
conda env list                                            # to get list ov environments
conda install -y -n ${PROJECT_NAME} python=3.9
conda install -y -n ${PROJECT_NAME} python pip
conda install -y -n ${PROJECT_NAME} imageio
conda install -y -n ${PROJECT_NAME} jupyter notebook
conda install -y -n ${PROJECT_NAME} tensorflow
conda activate ${PROJECT_NAME}
conda list
conda deactivate
```

Create an environment YAML file:

```shell
conda env export -n ${PROJECT_NAME} > ${PROJECT_NAME}.yaml
```

Create an environment from environment YAML file:

```shell
conda env create -f ${PROJECT_NAME}.yaml
conda env list
```

Deleting/Removing an environment:

```shell
conda remove -y -n ${PROJECT_NAME} --all
conda info --envs
```

## See also

[Conda Documentation site](https://docs.conda.io/en/latest/)

[Anaconda](https://www.anaconda.com/)

[Miniconda](https://docs.conda.io/en/latest/miniconda.html)

[Conda repo](https://anaconda.org/anaconda/repo)
