# FFT

## Information

Fast Fourier Transform

https://en.wikipedia.org/wiki/Periodogram

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

## Libraries

### C/C++

http://www.fftw.org/

| Library | Date of first release | License | Implementation | Types | Dims | Andrew's notes |
| --- | --- | --- | --- | --- | --- | --- |
| **CPU libraries**
| [FFTW](http://www.fftw.org/) | 1997 | GPLv2+ or commercial | C generated with OCaml | double, single, long double, quad | 1-N | Large dependency but included on most Linux distros. Very fast, very accurate. |
| [KISS FFT](https://github.com/mborgerding/kissfft) | 2003 | BSD | C | any with macro | 1-2 | |
| [pffft](https://bitbucket.org/jpommier/pffft/) | 2011 | FFTPACK, similar to BSD | C | single | 1 | Written by Julien Pommier, co-developer of [Pianoteq](https://www.modartt.com/pianoteq). Currently used by [VCV Rack](https://vcvrack.com/). Very fast given its small size, due to manual SIMD up to AVX. |
| [marton78's pffft fork](https://github.com/marton78/pffft) | 2015 | same as pffft | C | single, double | 1 | |
| [pocketfft](https://gitlab.mpcdf.mpg.de/mtr/pocketfft) | 2018 | BSD | C | double | 1 | |
| [pocketfft C++](https://gitlab.mpcdf.mpg.de/mtr/pocketfft/tree/cpp) | 2019 | BSD | C++ header-only | any via templates | 1-N | No state needed, uses global caching instead. 2+ dimension supports C++ multithreading. Now used by [Numpy](https://docs.scipy.org/doc/numpy/reference/routines.fft.html)/[Scipy](https://docs.scipy.org/doc/scipy/reference/generated/scipy.fft.fft.html). |
| [FFTS](https://github.com/anthonix/ffts) | 2001 | BSD | C | single | 1-N | |
| [ffmpeg libavcodev](https://git.ffmpeg.org/gitweb/ffmpeg.git/tree/HEAD:/libavcodec) | 2000 | GPLv2.1+ | C | single, fixed-32 | 1 | Initially written by [Fabrice Bellard](https://en.wikipedia.org/wiki/Fabrice_Bellard). |
| [Ooura's FFT](http://www.kurims.kyoto-u.ac.jp/~ooura/fft.html) | 1996 | custom open-source | C and Fortran77 versions | double | 1 | |
| [FFTE](http://www.ffte.jp/) | 2000 | custom open-source | Fortran77 and Nvidia CUDA (GPU) | ? | 1-3 | |
| [FFTReal](https://github.com/cyrilcode/fft-real) | 1999 | WTFPL | C++ | any via templates | 1-N | |
| [FFTPACK](https://netlib.org/fftpack/) | 1982 | public domain | Fortran translated to C | single | 1 | Grandfather of many other FFT libraries. Included for history, not recommended for modern use. |
| [KFR](https://github.com/kfrlib/kfr) | 2016 | GPLv2+ or commercial | C++ | any via templates | 1 | Includes many other DSP routines. |
| [GNU Scientific Library](https://www.gnu.org/software/gsl/) | 1996 | GPLv3 | C | double | 1 | Includes many other numerical routines. |
| [Intel MKL](https://software.intel.com/en-us/mkl/features/fft) | 2003 | freeware | ? | single, double | 1-N | Probably the fastest on this list for Intel CPUs. |
| [Apple vDSP](https://developer.apple.com/documentation/accelerate/fast_fourier_transforms) | ~2001 | freeware | ? | single, double | 1-2 | Only for Apple Mac. |
| [muFFT](https://github.com/Themaister/muFFT) | 2015 | MIT | C | single | 1-2 | |
| [meow_fft](https://github.com/JodiTheTigger/meow_fft) | 2017 | 0-Clause BSD | C header-only | single | 1 | |
| [wareya fft](https://github.com/wareya/fft) | 2017 | public domain | C header-only | double | 1 | No real-to-complex. |
| [dj_fft (for CPU)](https://github.com/jdupuy/dj_fft) | 2019 | public domain or MIT | C++ header-only | any via templates | 1-3 | No real-to-complex. |
| [ minfft](https://github.com/aimukhin/minfft) | 2018 | MIT | C | single, double, long double | 1-3 | |
| **GPU libraries**
| [cuFFT](https://developer.nvidia.com/cufft) | ? | freeware | Nvidia CUDA (GPU) | single, double | 1-N | |
| [clFFT](https://github.com/clMathLibraries/clFFT) | 2013 | Apache-2.0 | OpenCL (GPU) | single, double | 1-N | |
| [GLFFT](https://github.com/Themaister/GLFFT) | 2015 | MIT | OpenGL GLSL (GPU) | single, half-single | 1-2 | |
| [dj_fft (for GPU)](https://github.com/jdupuy/dj_fft) | 2019 | public domain or MIT | C++ header-only, OpenGL GLSL (GPU) | single | 1-3 | No real-to-complex. |
| **Distributed memory libraries**
| [FFTW++](https://github.com/dealias/fftwpp) | 2004 | GPLv3+ | C++ | double? | 1-3 | |
| [fftMPI](https://fftmpi.sandia.gov/) | <=2018 | BSD | C++ | single, double | 2-3 | 1D FFTs computed by [FFTW](http://www.fftw.org), [MKL](https://fftmpi.sandia.gov/mkl), or [KISS FFT](https://sourceforge.net/projects/kissfft). |
| [AccFFT](https://github.com/amirgholami/accfft) | 2015 | GPLv2+ | C++ | double | 1-3 | |
| [SWFFT](https://xgitlab.cels.anl.gov/hacc/SWFFT) | 2017 | custom open-source | C++ | | |
| [P3DFFT](http://www.p3dfft.net/)
| [pfft](https://github.com/mpip/pfft)

### Java

Not FFT just sound api https://www.oracle.com/java/technologies/java-sound-api.html

http://ww1.quifft.org/

https://sites.google.com/site/piotrwendykier/software/jtransforms

https://github.com/wendykierp/JTransforms

https://github.com/hedoluna/fft

https://introcs.cs.princeton.edu/java/97data/FFT.java.html

https://www.ee.columbia.edu/~ronw/code/MEAPsoft/doc/html/FFT_8java-source.html

https://java.hotexamples.com/examples/processing.core/FFT/-/java-fft-class-examples.html

https://github.com/wendykierp/JTransforms

### Python

https://www.dummies.com/article/technology/programming-web-design/python/performing-a-fast-fourier-transform-fft-on-a-sound-file-142859/

https://realpython.com/python-scipy-fft/

https://numpy.org/doc/stable/reference/generated/numpy.fft.fft.html

https://pythonnumericalmethods.berkeley.edu/notebooks/chapter24.03-Fast-Fourier-Transform.html

https://pythonnumericalmethods.berkeley.edu/notebooks/chapter24.04-FFT-in-Python.html

https://www.delftstack.com/howto/python/fft-example-in-python/#use-the-python-numpy.fft-module-for-fast-fourier-transform

## See also

[FFT](https://processing.org/reference/libraries/sound/FFT.html)

[TOOlbox](https://carsomyr.github.io/shared/)
