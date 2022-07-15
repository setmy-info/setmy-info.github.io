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

#### Installing packages

```shell
python -m pip install SomePackage
python -m pip install SomePackage==1.0.4    # with specific version
python -m pip install "SomePackage>=1.0.4"  # with minimum version
python -m pip install --upgrade SomePackage # upgrade existing already installed software
```

#### Freezing

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
conda activate ${PROJECT_NAME}  # or venv
python -m module.name
conda deactivate
```

### Execute project tests

Execute tests:

```shell
python -m unittest discover -s ./ -p *Test.py
```

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

    pyvenv-3.4 env
    source env/bin/activate
    (pip install --upgrade pip)
    touch main.py .gitignore README.md requirements.txt
    pip install Flask==1.0.2
    pip completion --bash >> ~/.profile
    pip freeze > requirements.txt
        pip install -r requirements.txt
    python -m unittest discover
    python -m unittest discover -s ./ -p *Test.py
    nano main.py
        ---
        from flask import Flask
        app = Flask(__name__)


        @app.route('/')
        def hello():
            return "Hello World!"

        if __name__ == '__main__':
            app.run()
        ---
    export FLASK_ENV=development
    python main.py
    deactivate

    PYTHONPATH for searchin modules, like PATH.

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
    [Pip](https://pypi.org/)
    [Pip registering](https://pypi.org/account/register/)
    [Packaging vol 1](https://packaging.python.org/tutorials/packaging-projects/)
    [Packaging vol 2](https://packaging.python.org/)
    [xxxx](https://fossbytes.com/python-fastest-growing-programming-language/)
    [xxxx](https://stackoverflow.blog/2017/09/14/python-growing-quickly/)

    https://www.patricksoftwareblog.com/structuring-a-flask-project/
    https://realpython.com/scaffold-a-flask-project/
    https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-i-hello-world
    http://flask.pocoo.org/snippets/131/
