# PyTorch

## Information

**PyTorch** is an open-source machine learning framework developed by Meta AI. It uses dynamic computation graphs
(define-by-run), making debugging natural since the graph is built at runtime. PyTorch is the dominant framework for
deep learning research and is increasingly used in production.

Key components:
* `torch` — tensor library with CUDA GPU acceleration.
* `torch.nn` — neural network building blocks (layers, loss functions, containers).
* `torch.optim` — optimizers (SGD, Adam, AdamW).
* `torch.utils.data` — `Dataset` and `DataLoader` for batched data loading.
* `torchvision` / `torchaudio` / `torchtext` — domain libraries for vision, audio, text.

## Installation

### Rocky Linux / Fedora — CPU only

```shell
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu
```

### Rocky Linux / Fedora — GPU (CUDA 12.x)

```shell
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

Always verify the correct install command for your CUDA version at [pytorch.org/get-started](https://pytorch.org/get-started/locally/).

### Debian / Ubuntu — CPU only

```shell
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu
```

### FreeBSD

PyTorch does not have official FreeBSD packages. Use a Linux VM or container.

### Windows

```powershell
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

### Verify installation

```python
import torch
print(torch.__version__)
print(torch.cuda.is_available())   # True if GPU is accessible
print(torch.cuda.get_device_name(0))  # GPU name
```

## Configuration

### Device selection

```python
import torch

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Using device: {device}")

# Move model and data to device
model = MyModel().to(device)
inputs = inputs.to(device)
```

### Reproducibility

```python
import torch, random, numpy as np

torch.manual_seed(42)
torch.cuda.manual_seed_all(42)
random.seed(42)
np.random.seed(42)
torch.backends.cudnn.deterministic = True
```

## Usage, tips and tricks

### Tensor basics

```python
import torch

# Create tensors
x = torch.tensor([1.0, 2.0, 3.0])
z = torch.zeros(3, 4)
o = torch.ones(2, 2)
r = torch.rand(3, 3)        # uniform [0, 1)
n = torch.randn(3, 3)       # standard normal

# Operations
y = x * 2
dot = torch.dot(x, x)
mm = torch.mm(r, r)         # matrix multiply
```

### Autograd

```python
x = torch.tensor(2.0, requires_grad=True)
y = x ** 3
y.backward()
print(x.grad)   # dy/dx = 3x^2 = 12
```

### Defining a model

```python
import torch.nn as nn

class MLP(nn.Module):
    def __init__(self):
        super().__init__()
        self.layers = nn.Sequential(
            nn.Linear(784, 256),
            nn.ReLU(),
            nn.Linear(256, 10)
        )

    def forward(self, x):
        return self.layers(x)
```

### Training loop skeleton

```python
model = MLP().to(device)
criterion = nn.CrossEntropyLoss()
optimizer = torch.optim.Adam(model.parameters(), lr=1e-3)

for epoch in range(10):
    model.train()
    for inputs, labels in train_loader:
        inputs, labels = inputs.to(device), labels.to(device)
        optimizer.zero_grad()
        outputs = model(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()
```

### Save and load model

```python
# Save
torch.save(model.state_dict(), "model.pt")

# Load
model = MLP()
model.load_state_dict(torch.load("model.pt", map_location=device))
model.eval()
```

## See also

* [PyTorch official documentation](https://pytorch.org/docs/)
* [PyTorch tutorials](https://pytorch.org/tutorials/)
* [torchvision](https://pytorch.org/vision/stable/)
* [TorchTune](torchtune.md)
* [Axolotl](axolotl.md)
* [Python](python.md)
