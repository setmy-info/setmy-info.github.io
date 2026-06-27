# CUDAe

## Information

CUDA (Compute Unified Device Architecture) is NVIDIA's parallel computing platform and programming model that enables
GPU-accelerated computing. It allows software to use NVIDIA GPU cores for general-purpose calculations, making it
the dominant platform for deep learning, scientific computing, and graphics workloads.

Key concepts:

* **CUDA Cores** — parallel processing units on the GPU (e.g. RTX 3080: 8704 cores, RTX 3080 Ti: 10240 cores).
* **VRAM** — dedicated GPU memory; deep learning models must fit in VRAM during inference and training.
* **Compute Capability** — version number identifying supported CUDA features for a GPU:
    * RTX 20 series: 7.5
    * RTX 30 series: 8.6
    * RTX 40 series: 8.9
    * A100: 8.0, H100: 9.0
* **CUDA Toolkit** — compilers (nvcc), libraries, and developer tools.
* **cuDNN** — GPU-accelerated deep neural network primitives used by TensorFlow and PyTorch.
* **NCCL** — NVIDIA Collective Communications Library for multi-GPU and multi-node training.

## Installation

### CentOS, Rocky Linux

```shell
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo
sudo dnf clean all
sudo dnf -y install cuda-toolkit-12-6
# Open kernel module (recommended for recent kernels)
sudo dnf -y module install nvidia-driver:open-dkms
# Or legacy kernel module
sudo dnf -y module install nvidia-driver:latest-dkms
sudo reboot
nvidia-smi
nvcc --version
```

### Fedora

```shell
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora39/x86_64/cuda-fedora39.repo
sudo dnf clean all
sudo dnf -y install cuda-toolkit-12-6
sudo reboot
nvidia-smi
nvcc --version
```

### Verify Installation

```shell
nvidia-smi
nvcc --version
python3 -c "import torch; print(torch.cuda.is_available()); print(torch.cuda.get_device_name(0))"
```

## Configuration

Add CUDA to PATH and library path. Add to `~/.bashrc` or `/etc/profile.d/cuda.sh`:

```shell
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

cuDNN installation (manual, after accepting NVIDIA license):

```shell
tar -xvf cudnn-linux-x86_64-8.x.x.x_cuda12-archive.tar.xz
sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
sudo cp cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
```

## Usage, tips and tricks

Check your GPU's Compute Capability before choosing framework versions:

```shell
nvidia-smi --query-gpu=name,compute_cap --format=csv
```

GPU hardware notes:

```text
CUDA Capability for RTX 30 Series: 8.6

GeForce RTX 3080
                    RTX 3080 Ti             RTX 3080
NVIDIA CUDA Cores   10240                   8960 / 8704
```

https://ordi.eu/ordi-lauaarvutid-ordi-twister-r5-5gen

```text
The GeForce RTX 2060 features 1,920 CUDA cores, 240 Tensor Cores that can deliver 52 teraflops of deep learning horsepower,...
```

8GB MSI RTX3050 Ventus 2X OC

* CUDA 12.x is required for the latest PyTorch and TensorFlow releases.
* Use `nvidia-smi` to monitor GPU utilization and VRAM usage during training.
* For multi-GPU setups, install NCCL alongside the CUDA Toolkit.
* The `8GB MSI RTX3050 Ventus 2X OC` is a budget option for light inference and small model fine-tuning.

## See also

* [CUDA Developer Documentation](https://docs.nvidia.com/cuda/)
* [Linux CUDA Installation Guide](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)
* [NVIDIA nvidia-smi reference](https://developer.nvidia.com/nvidia-system-management-interface)
* [CUDA Wikipedia (ET)](https://et.wikipedia.org/wiki/CUDA)
* [CUDA Wikipedia (EN)](https://en.wikipedia.org/wiki/CUDA)
* [NVIDIA GPU Compare](https://www.nvidia.com/en-eu/geforce/graphics-cards/compare/?section=compare-16)
* [MSI RTX 3050 Ventus 2X 8G OC](https://www.msi.com/Graphics-Card/GeForce-RTX-3050-VENTUS-2X-8G-OC)
* [PyTorch](pytorch.md)

