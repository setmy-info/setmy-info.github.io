# Jupyter

## Information

Jupyter is an open-source, web-based interactive computing environment. Notebooks (`.ipynb` files) combine live code,
narrative text (Markdown), equations (LaTeX), and visualizations in a single document. Originally created as
**IPython Notebook**, Jupyter now supports over 40 programming language kernels — including Python, R, and Julia.

**JupyterLab** is the modern, IDE-style successor to the classic Notebook interface, providing a tabbed workspace with
a file browser, terminal, text editor, and notebook viewer side by side.

**Voilà** converts Jupyter notebooks into standalone interactive web dashboards without exposing source code.

## Installation

### pip (all platforms, recommended with venv)

```shell
pip install jupyterlab notebook voila
```

### Rocky Linux / Fedora (via Python venv)

```shell
mkdir jupyter-probe
cd jupyter-probe
python3 -m venv .venv
source .venv/bin/activate
pip install jupyterlab notebook voila
jupyter-lab
```

Using the `smi` helper scripts:

```shell
smi-download-package python313
smi-install-package python313
export PATH=/opt/python-3.13.7/bin:${PATH}
python3 --version
smi-create-venv
smi-venv-command pip install jupyterlab notebook voila
smi-venv-command jupyter-lab
smi-venv-command pip freeze > requirements.txt
```

### Debian / Ubuntu

```shell
sudo apt install python3-jupyter-core jupyter-notebook
# Or via pip in a venv (preferred for the latest version)
pip install jupyterlab
```

## Start Jupyter

```shell
jupyter-lab
```

Open the browser at [http://localhost:8888/](http://localhost:8888/).

## Matplotlib and NumPy

### Preparations

#### Installation with additionals

```shell
pip install jupyterlab notebook voila numpy pandas matplotlib seaborn tensorflow pyarrow
```

#### Script preparations

```python
import os
import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import tensorflow as tf
from tensorflow.keras import layers
import datetime
import timeit
import itertools
import pyarrow as pa
```

#### Version check

```python
print("TensorFlow:", tf.__version__)
print("NumPy:", np.__version__)
print("pandas:", pd.__version__)
print("pyarrow:", pa.__version__)
```

#### Plots

```python
fig, ax = plt.subplots()
ax.plot([1, 2, 3, 4], [1, 4, 2, 3])
```

```python
x = np.linspace(0, 2, 100)
fig, ax = plt.subplots(figsize=(5, 2.7), layout='constrained')
ax.plot(x, x, label='linear')
ax.plot(x, x ** 2, label='quadratic')
ax.plot(x, x ** 3, label='cubic')
ax.set_xlabel('x label')
ax.set_ylabel('y label')
ax.set_title("Simple Plot")
ax.legend()
```

#### Return multiple values from a function

```python
def return_multiple():
    return 1, 2, 3

return_all = return_multiple()
print(f'{return_all=}')

a, b, c = return_multiple()
print(f'{a=}')
print(f'{b=}')
print(f'{c=}')

a, *b = return_multiple()
print(f'{a=}')
print(f'{b=}')
```

## See also

* [Jupyter official site](https://jupyter.org/)
* [JupyterLab documentation](https://jupyterlab.readthedocs.io/)
* [Voilà](https://voila.readthedocs.io/)
* [Matplotlib gallery](https://matplotlib.org/stable/gallery/index)
* [Matplotlib cheatsheets](https://matplotlib.org/cheatsheets/_images/cheatsheets-1.png)
