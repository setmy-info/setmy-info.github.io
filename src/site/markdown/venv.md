# venv

## Information

Python own virtual environment tool module.

## Usage, tips and tricks

### Check python version

**Windows**

```commandline
py --version
```

***nixes**

```shell
python --version
# or
python3 --version
```

### Example use case

```shell
mkdir example-software
cd example-software
```

**Windows**

```commandline
REM py -3.12 -m venv ./.venv
REM most probavly works for tensorflow
py -3.9 -m venv ./.venv
.\.venv\Scripts\activate
python --version
```

***nixes**

```shell
# On Linux
python -m venv ./.venv
source ./.venv/bin/activate
# cd ./.venv/bin
```

continue:

```shell
python -m pip install --upgrade pip
pip --version
pip install --upgrade setuptools
pip install numpy
pip install pandas
pip install jupyterlab
pip install notebook
pip install voila
pip install imageio
pip install matplotlib
pip install tensorflow
pip install tensorflow-datasets
pip install tensorflow-estimator
pip install tfds-nightly
pip install tensorboard
pip install seaborn
pip install Flask
pip install itsdangerous
#pip install tensorflow-transform
pip freeze > requirements.txt
# to install frozen packages
pip install -r requirements.txt
pip install -r requirements.txt --upgrade
pip install -r requirements.txt -r requirements-ai.txt
# Upgrade some package
pip install <package_name> --upgrade
```

## See also

[Virtual environments tutorial](https://docs.python.org/3/tutorial/venv.html)

[venv](https://docs.python.org/3/library/venv.html)

[pip installer](https://pip.pypa.io/en/stable/cli/pip_install/)
