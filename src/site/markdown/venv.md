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
py -m venv ./.venv
.\.venv\Scripts\activate
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
pip install --upgrade pip
pip --version
pip install imageio
pip install jupyter notebook
pip install tensorflow
pip freeze > requirements.txt
# to install frozen packages
pip install -r requirements.txt
```

## See also

[Virtual environments tutorial](https://docs.python.org/3/tutorial/venv.html)

[venv](https://docs.python.org/3/library/venv.html)
