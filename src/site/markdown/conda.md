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

```shell
mkdir conda-experiments
cd conda-experiments
conda create -y -n conda-experiments                      # create conda environment
conda env list                                            # to get list ov environments
conda install -y -n conda-experiments python=3.9
conda install -y -n conda-experiments python pip
conda install -y -n conda-experiments imageio
conda install -y -n conda-experiments jupyter notebook
conda install -y -n conda-experiments tensorflow
conda activate conda-experiments
conda list
conda deactivate
```

Create an environment YAML file:

```shell
conda env export -n conda-experiments > conda-experiments.yaml
```

Create an environment from environment YAML file:

```shell
conda env create -f conda-experiments.yaml
conda env list
```

Deleting/Removing an environment:

```shell
conda remove -y -n conda-experiments --all
conda info --envs
```

## See also

[Conda Documentation site](https://docs.conda.io/en/latest/)

[Anaconda](https://www.anaconda.com/)

[Miniconda](https://docs.conda.io/en/latest/miniconda.html)

[Conda repo](https://anaconda.org/anaconda/repo)
