# Python

## Installation

### CentOS, Rocky Linux

```shell
yum install -y python3 (?)
```

### Fedora

```shell
dnf install -y python3
```

### FreeBSD

```shell
pkg install -y python3
```

### Windows

Go to [download](https://www.python.org/downloads/)

Set it to the PATH.

## Usage, tips and tricks

### Virtual environments

**Virtual environment is separated "sandbox" (isolated location) where is collected set of software (components,
modules, libraries) with their versions together as software state.** On single machine (developer machine, production
machines, etc.) can be prepared many separated and different sets/states of software. Perhaps module or project specific
sets. One of these sets contains even Python with specific version.

Python internal module [venv](venv.html) can be used as virtual environment tools. Also [conda](conda.html) can be used
for virtual environment handling.

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

### Python packages

Python packages web page: [PyPI](https://pypi.org/)

When **pip** is not installed:

**Windows**

```commandline
py -m ensurepip --default-pip
pip --version
```

***nixes**

```shell
python3 -m ensurepip --default-pip
pip --version
```

### Installing packages

```shell
python -m pip install SomePackage
python -m pip install SomePackage==1.0.4    # with specific version
python -m pip install "SomePackage>=1.0.4"  # with minimum version
python -m pip install --upgrade SomePackage # upgrade existing already installed software
```

### Freezing

**Get state of software and their versions.**

To get installed packages (inside venv) into **requirements.txt**

```shell
pip freeze > requirements.txt
```

To install frozen (**requirements.txt**) packages

```shell
pip install -r requirements.txt
```

Guide to make your own Python packages: [Python Packaging User Guide](https://packaging.python.org/en/latest/)

### Execute project application

```shell
conda activate %PROJECT_NAME%  # or venv
python -m module.name
conda deactivate
```

```shell
conda activate ${PROJECT_NAME}  # or venv
python -m module.name
conda deactivate
```

### Execute project tests

Execute tests:

```shell
python -m unittest discover -s ./ -p *Test.py
```

### Code examples

#### Lambda

```python
maximum_number = lambda x, y: x if x > y else y
print("Max:", maximum_number(8, 5))
```

#### Map

```python
number_list = [4, 3, 2, 1]
print(list(map(lambda x: x ** 2, number_list)))
```

#### Iteration I

```python
for item in number_list:
    print("Item=", item)
```

#### Iteration II

```python
for index in range(len(number_list)):
    print("number_list[", index, "]=", number_list[index])
```

#### Iteration III

```python
for index, item in enumerate(number_list):
    print("Item=", item, ",", index)
```

#### Chained map and filter chain

```python
print(
    list(
        filter(
            lambda persona: persona.id > 2,
            list(
                map(
                    lambda id: Person(id, None),
                    number_list
                )
            )
        )
    )
)
```

#### Switch I

```python
val = "abc"
switcher = {
    "abc": lambda: int(1),
    "def": lambda: int(2)
}
print("Switch: abc=", switcher[val]())
```

#### Switch II

```python
val = "def"
switcher = {
    "abc": int(1),
    "def": int(2)
}
print("Switch: def=", switcher[val])
val = "xyz"
print("Switch: def=", switcher.get(val, None))
```

#### Switch III (starting from Pyton 3.10)

##### A

```python
def number_to_string(val: int):
    match val:
        case 0:
            return "zero"
        case 1:
            return "one"
        case 2:
            return "two"
        case _:
            return "something"
```

case _: can be case default?

##### B

That's not working!

```python
ABC = "abc"


def number_to_string(val: str):
    match val:
        case ABC:
            print("zero")
        case "def":
            print("one")
        case "ghi":
            print("two")
        case _:
            print("Unknown")
```

Possible solution for that.

```python
import types

constants = types.SimpleNamespace()
constants.ABC = "abc"
constants.DEF = "def"
constants.GHI = "ghi"

val: str = "abc"
match val:
    case constants.ABC:
        print("zero")
    case constants.DEF:
        print("one")
    case constants.GHI:
        print("two")
    case _:
        print("Unknown")
```

#### Testing mocking

[mocking](https://docs.python.org/3/library/unittest.mock.html)

## Python Enhancement Proposals (PEPs)

[PEPs](https://peps.python.org/)

## Frameworks

Django

Flask (http://flask.pocoo.org/)

Falcon

Jinja2 (Template engine : http://jinja.pocoo.org/)

Chameleon (Template engine : https://chameleon.readthedocs.io/en/latest/)

## Package management

    wget -c https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
        --user
            Under **~/.local/bin**
        --proxy='${$http_proxy}'
    pip --version

## Eclipse

        http://www.pydev.org/updates

## Project setup

Activate (updated [pip, etc.]) env and:

```shell
touch main.py .gitignore README.md requirements.txt
pip completion --bash >> ~/.profile
pip install Flask
pip freeze > requirements.txt
```

create main

```shell
nano main.py
```

with content

```python
from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello():
    return "Hello World!"


if __name__ == '__main__':
    app.run()
```

Unit test and run Flask main

```shell
python -m unittest discover
python -m unittest discover -s ./ -p *Test.py
export FLASK_ENV=development
python main.py
git add **.py .gitignore README.md requirements.txt
```

Deactivate env.

PYTHONPATH is for searching modules, like PATH for commands.

## See also

[xxxx](https://pythonspot.com/)

[xxxx](https://www.fullstackpython.com)

[xxxx](https://pip.pypa.io/en/stable/installing/)

[xxxx](https://pip.readthedocs.io/en/1.0/running-tests.html#how-to-run-tests)

[xxxx](http://flask.pocoo.org/docs/1.0/quickstart/#a-minimal-application)

[xxxx](https://docs.python.org/3/library/unittest.mock.html)

[xxxx](https://docs.python.org/3.5/library/datatypes.html)

[xxxx](https://www.bipm.org/en/measurement-units/)

[xxxx](https://realpython.com/python-mock-library/)

[Pip registering](https://pypi.org/account/register/)

[Packaging vol 1](https://packaging.python.org/tutorials/packaging-projects/)

[Packaging vol 2](https://packaging.python.org/)

[xxxx](https://fossbytes.com/python-fastest-growing-programming-language/)

[xxxx](https://stackoverflow.blog/2017/09/14/python-growing-quickly/)

https://www.patricksoftwareblog.com/structuring-a-flask-project/

https://realpython.com/scaffold-a-flask-project/

https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-i-hello-world

http://flask.pocoo.org/snippets/131/
