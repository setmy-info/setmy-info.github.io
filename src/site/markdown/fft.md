# FFT

## Information

The Fast Fourier Transform (FFT) is an efficient algorithm for computing the Discrete Fourier Transform (DFT),
converting a signal from the time domain into the frequency domain. A signal sampled at N points yields N
frequency bins; FFT reduces the naive O(N²) DFT computation to O(N log N).

Key concepts:

- **DFT**: Maps a sequence of N time-domain samples to N complex frequency-domain values.
- **Nyquist theorem**: To avoid aliasing, the sampling rate must be at least twice the highest frequency of interest.
- **Power Spectral Density (PSD)**: Describes how the power of a signal is distributed across frequencies.
- **Periodogram**: Estimate of the PSD computed from the squared magnitude of the DFT.
- **Window functions**: Hann, Hamming, Blackman — applied before FFT to reduce spectral leakage at signal edges.

Applications: audio analysis, signal processing, image processing (2D FFT), vibration analysis, RF spectrum analysis,
seismology, and machine learning feature extraction.

## Installation

### Python

NumPy and SciPy both include FFT implementations (pocketfft C++ under the hood):

```shell
pip install numpy scipy matplotlib
```

### Rocky Linux / CentOS — FFTW (C/C++)

```shell
sudo dnf install fftw fftw-devel
```

### Fedora — FFTW (C/C++)

```shell
sudo dnf install fftw fftw-devel
```

### Debian / Ubuntu — FFTW (C/C++)

```shell
sudo apt install libfftw3-dev
```

### Node.js

```shell
npm install fft-js
```

## Configuration

FFTW uses a planning stage to find the fastest algorithm for your specific hardware. Plans can be saved
and reused:

```c
fftw_plan p = fftw_plan_dft_r2c_1d(N, in, out, FFTW_MEASURE);
// run FFT: fftw_execute(p)
// save plan: fftw_export_wisdom_to_filename("fftw_wisdom.dat")
fftw_destroy_plan(p);
```

## Usage, tips and tricks

### Python FFT with NumPy

```python
import numpy as np
import matplotlib.pyplot as plt

# Generate a test signal: 50 Hz + 120 Hz sine waves
fs = 1000           # sample rate Hz
t = np.linspace(0, 1, fs, endpoint=False)
signal = np.sin(2 * np.pi * 50 * t) + 0.5 * np.sin(2 * np.pi * 120 * t)

# Compute FFT
fft_vals = np.fft.fft(signal)
freqs = np.fft.fftfreq(len(signal), d=1/fs)

# Plot positive frequencies only
mask = freqs >= 0
plt.plot(freqs[mask], np.abs(fft_vals[mask]))
plt.xlabel('Frequency (Hz)')
plt.ylabel('Amplitude')
plt.title('FFT of test signal')
plt.show()
```

### Python FFT with SciPy

SciPy's `scipy.fft` module is the preferred modern API (faster than `numpy.fft` for large inputs):

```python
from scipy.fft import fft, fftfreq
import numpy as np

N = 1024
T = 1.0 / 1000.0
x = np.linspace(0.0, N * T, N, endpoint=False)
y = np.sin(50.0 * 2.0 * np.pi * x) + 0.5 * np.sin(80.0 * 2.0 * np.pi * x)

yf = fft(y)
xf = fftfreq(N, T)[:N // 2]
```

### Coding tips and tricks

- Apply a window function (e.g., `np.hanning(N)`) to the signal before FFT when the input is not periodic.
- Use `np.fft.rfft` / `scipy.fft.rfft` for real-valued inputs — it returns only positive frequencies and is faster.
- Zero-pad to the next power of 2 for optimal FFT performance (`scipy.fft.next_fast_len`).

## Libraries

### C/C++

| Library                                                                                    | Date of first release | License                 | Implementation                     | Types                             | Dims | Notes                                                                                                                                                                                                                                                       |
|--------------------------------------------------------------------------------------------|-----------------------|-------------------------|------------------------------------|-----------------------------------|------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **CPU libraries**                                                                          
| [FFTW](http://www.fftw.org/)                                                               | 1997                  | GPLv2+ or commercial    | C generated with OCaml             | double, single, long double, quad | 1-N  | Large dependency but included on most Linux distros. Very fast, very accurate.                                                                                                                                                                              |
| [KISS FFT](https://github.com/mborgerding/kissfft)                                         | 2003                  | BSD                     | C                                  | any with macro                    | 1-2  |                                                                                                                                                                                                                                                             |
| [pffft](https://bitbucket.org/jpommier/pffft/)                                             | 2011                  | FFTPACK, similar to BSD | C                                  | single                            | 1    | Very fast given its small size, due to manual SIMD up to AVX.                                                                                                                                                                                               |
| [marton78's pffft fork](https://github.com/marton78/pffft)                                 | 2015                  | same as pffft           | C                                  | single, double                    | 1    |                                                                                                                                                                                                                                                             |
| [pocketfft](https://gitlab.mpcdf.mpg.de/mtr/pocketfft)                                     | 2018                  | BSD                     | C                                  | double                            | 1    |                                                                                                                                                                                                                                                             |
| [pocketfft C++](https://gitlab.mpcdf.mpg.de/mtr/pocketfft/tree/cpp)                        | 2019                  | BSD                     | C++ header-only                    | any via templates                 | 1-N  | No state needed, uses global caching instead. 2+ dimension supports C++ multithreading. Now used by [NumPy](https://docs.scipy.org/doc/numpy/reference/routines.fft.html)/[SciPy](https://docs.scipy.org/doc/scipy/reference/generated/scipy.fft.fft.html). |
| [FFTS](https://github.com/anthonix/ffts)                                                   | 2001                  | BSD                     | C                                  | single                            | 1-N  |                                                                                                                                                                                                                                                             |
| [ffmpeg libavcodec](https://git.ffmpeg.org/gitweb/ffmpeg.git/tree/HEAD:/libavcodec)        | 2000                  | GPLv2.1+                | C                                  | single, fixed-32                  | 1    | Initially written by Fabrice Bellard.                                                                                                                                                                                                                       |
| [Ooura's FFT](http://www.kurims.kyoto-u.ac.jp/~ooura/fft.html)                             | 1996                  | custom open-source      | C and Fortran77 versions           | double                            | 1    |                                                                                                                                                                                                                                                             |
| [FFTE](http://www.ffte.jp/)                                                                | 2000                  | custom open-source      | Fortran77 and Nvidia CUDA (GPU)    | ?                                 | 1-3  |                                                                                                                                                                                                                                                             |
| [FFTReal](https://github.com/cyrilcode/fft-real)                                           | 1999                  | WTFPL                   | C++                                | any via templates                 | 1-N  |                                                                                                                                                                                                                                                             |
| [FFTPACK](https://netlib.org/fftpack/)                                                     | 1982                  | public domain           | Fortran translated to C            | single                            | 1    | Grandfather of many other FFT libraries. Included for history, not recommended for modern use.                                                                                                                                                              |
| [KFR](https://github.com/kfrlib/kfr)                                                       | 2016                  | GPLv2+ or commercial    | C++                                | any via templates                 | 1    | Includes many other DSP routines.                                                                                                                                                                                                                           |
| [GNU Scientific Library](https://www.gnu.org/software/gsl/)                                | 1996                  | GPLv3                   | C                                  | double                            | 1    | Includes many other numerical routines.                                                                                                                                                                                                                     |
| [Intel MKL](https://software.intel.com/en-us/mkl/features/fft)                             | 2003                  | freeware                | ?                                  | single, double                    | 1-N  | Probably the fastest on this list for Intel CPUs.                                                                                                                                                                                                           |
| [Apple vDSP](https://developer.apple.com/documentation/accelerate/fast_fourier_transforms) | ~2001                 | freeware                | ?                                  | single, double                    | 1-2  | Only for Apple Mac.                                                                                                                                                                                                                                         |
| [muFFT](https://github.com/Themaister/muFFT)                                               | 2015                  | MIT                     | C                                  | single                            | 1-2  |                                                                                                                                                                                                                                                             |
| [meow_fft](https://github.com/JodiTheTigger/meow_fft)                                      | 2017                  | 0-Clause BSD            | C header-only                      | single                            | 1    |                                                                                                                                                                                                                                                             |
| [wareya fft](https://github.com/wareya/fft)                                                | 2017                  | public domain           | C header-only                      | double                            | 1    | No real-to-complex.                                                                                                                                                                                                                                         |
| [dj_fft (for CPU)](https://github.com/jdupuy/dj_fft)                                       | 2019                  | public domain or MIT    | C++ header-only                    | any via templates                 | 1-3  | No real-to-complex.                                                                                                                                                                                                                                         |
| [minfft](https://github.com/aimukhin/minfft)                                               | 2018                  | MIT                     | C                                  | single, double, long double       | 1-3  |                                                                                                                                                                                                                                                             |
| **GPU libraries**                                                                          
| [cuFFT](https://developer.nvidia.com/cufft)                                                | ?                     | freeware                | Nvidia CUDA (GPU)                  | single, double                    | 1-N  |                                                                                                                                                                                                                                                             |
| [clFFT](https://github.com/clMathLibraries/clFFT)                                          | 2013                  | Apache-2.0              | OpenCL (GPU)                       | single, double                    | 1-N  |                                                                                                                                                                                                                                                             |
| [GLFFT](https://github.com/Themaister/GLFFT)                                               | 2015                  | MIT                     | OpenGL GLSL (GPU)                  | single, half-single               | 1-2  |                                                                                                                                                                                                                                                             |
| [dj_fft (for GPU)](https://github.com/jdupuy/dj_fft)                                       | 2019                  | public domain or MIT    | C++ header-only, OpenGL GLSL (GPU) | single                            | 1-3  | No real-to-complex.                                                                                                                                                                                                                                         |
| **Distributed memory libraries**                                                           
| [FFTW++](https://github.com/dealias/fftwpp)                                                | 2004                  | GPLv3+                  | C++                                | double?                           | 1-3  |                                                                                                                                                                                                                                                             |
| [fftMPI](https://fftmpi.sandia.gov/)                                                       | <=2018                | BSD                     | C++                                | single, double                    | 2-3  | 1D FFTs computed by FFTW, MKL, or KISS FFT.                                                                                                                                                                                                                 |
| [AccFFT](https://github.com/amirgholami/accfft)                                            | 2015                  | GPLv2+                  | C++                                | double                            | 1-3  |                                                                                                                                                                                                                                                             |
| [SWFFT](https://xgitlab.cels.anl.gov/hacc/SWFFT)                                           | 2017                  | custom open-source      | C++                                |                                   |      |
| [P3DFFT](http://www.p3dfft.net/)                                                           |                       |                         |                                    |                                   |      |
| [pfft](https://github.com/mpip/pfft)                                                       |                       |                         |                                    |                                   |      |

### Java

- [Java Sound API](https://www.oracle.com/java/technologies/java-sound-api.html) — not FFT, just audio I/O
- [JTransforms](https://github.com/wendykierp/JTransforms) — pure Java FFT library
- [hedoluna/fft](https://github.com/hedoluna/fft) — simple Java FFT implementation
- [Princeton FFT.java](https://introcs.cs.princeton.edu/java/97data/FFT.java.html) — educational implementation

### Python

- [NumPy FFT](https://numpy.org/doc/stable/reference/generated/numpy.fft.fft.html)
- [SciPy FFT](https://realpython.com/python-scipy-fft/)
- [FFT in Python (Berkeley)](https://pythonnumericalmethods.berkeley.edu/notebooks/chapter24.04-FFT-in-Python.html)

## See also

* [FFT on Wikipedia](https://en.wikipedia.org/wiki/Fast_Fourier_transform)
* [Periodogram on Wikipedia](https://en.wikipedia.org/wiki/Periodogram)
* [FFTW library](http://www.fftw.org/)
* [NumPy FFT documentation](https://numpy.org/doc/stable/reference/routines.fft.html)
* [FFT (Processing)](https://processing.org/reference/libraries/sound/FFT.html)
* [Shared Toolbox](https://carsomyr.github.io/shared/)
