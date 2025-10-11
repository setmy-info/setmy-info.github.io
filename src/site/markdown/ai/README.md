# README

## Preparations

```sh
python3 --version
```

Should show:

---
Python 3.13.7
---

If not, try to set 3.13.x python on the PATH variable

```sh
export PATH=/opt/python-3.13.7/bin:${PATH}
```

Check again version

```sh
python3 --version
```

Should be correct now.

Now prepare environment:

```sh
python3 -m venv ./.venv
```

Activate environment, with Python used at venv reation:

```sh
source ./.venv/bin/activate
python --version
```

Upgrade pip:

```sh
pip --version
python -m pip install --upgrade pip
pip --version
```

Install software (TensorFlow, Jupyter, Scikit-learn, Jupyter, Pandas, NumPy, Matplotlib, other dependencies and more):

```sh
pip install -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cpu
```

## Jupyter

Start Jupyter

```sh
jupyter-lab
```

## Lessons

In directory **Lessons**.
