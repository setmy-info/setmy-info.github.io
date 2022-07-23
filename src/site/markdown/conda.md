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

Set up variable as project name for conda environment name, folder name, environment yaml file name.

**Windows**

```shell
set PROJECT_NAME=conda-experiments
```

***nixes**

```shell
PROJECT_NAME=conda-experiments
```

**Windows**

```shell
mkdir %PROJECT_NAME%
cd %PROJECT_NAME%
conda create -y -n %PROJECT_NAME%                      # create conda environment
conda env list                                            # to get list ov environments
conda install -y -n %PROJECT_NAME% python=3.9.12 pip
conda install -y -n %PROJECT_NAME% imageio
conda install -y -n %PROJECT_NAME% jupyter jupyterlab notebook
conda install -y -n %PROJECT_NAME% tensorflow  matplotlib pandas
conda activate %PROJECT_NAME%
pip install tensorflow-transform tfds-nightly voila
conda list -n %PROJECT_NAME%
conda deactivate
```

***nixes**

```shell
mkdir ${PROJECT_NAME}
cd ${PROJECT_NAME}
conda create -y -n ${PROJECT_NAME}                      # create conda environment
conda env list                                            # to get list ov environments
conda install -y -n ${PROJECT_NAME} python=3.9.12 pip
conda install -y -n ${PROJECT_NAME} imageio
conda install -y -n ${PROJECT_NAME} jupyter jupyterlab notebook
conda install -y -n ${PROJECT_NAME} tensorflow  matplotlib pandas
conda activate ${PROJECT_NAME}
pip install tensorflow-transform tfds-nightly voila
conda list -n ${PROJECT_NAME}
conda deactivate
```

Upgrade all packages:

```shell
conda update -n %PROJECT_NAME% --all
```

```shell
conda update -n ${PROJECT_NAME} --all
```

Create an environment YAML file:

```shell
conda env export -n %PROJECT_NAME% > %PROJECT_NAME%.yaml
```

```shell
conda env export -n ${PROJECT_NAME} > ${PROJECT_NAME}.yaml
```

Create an environment from environment YAML file:

```shell
conda env create -f %PROJECT_NAME%.yaml
conda env list
```

```shell
conda env create -f ${PROJECT_NAME}.yaml
conda env list
```

Deleting/Removing an environment:

```shell
conda remove -y -n %PROJECT_NAME% --all
conda info --envs
```

```shell
conda remove -y -n ${PROJECT_NAME} --all
conda info --envs
```

## See also

[Conda Documentation site](https://docs.conda.io/en/latest/)

[Anaconda](https://www.anaconda.com/)

[Miniconda](https://docs.conda.io/en/latest/miniconda.html)

[Conda repo](https://anaconda.org/anaconda/repo)
