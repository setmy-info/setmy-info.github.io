# Julia

## Information

Julia is a high-performance, dynamic programming language designed for numerical and scientific computing. It delivers
speed close to C while retaining the ease of use of Python or R. Julia is JIT-compiled using LLVM, supports multiple
dispatch as its core paradigm, and has a rich package ecosystem for data science, machine learning, statistics,
differential equations, and parallel computing.

Key features: fast loops (no vectorization required for performance), first-class Unicode support, built-in package
manager, interoperability with Python (PyCall.jl) and C, and distributed/parallel computing primitives.

## Installation

### Rocky Linux / Fedora

Download the official binary from [julialang.org](https://julialang.org/downloads/) and unpack:

```shell
wget https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-1.10.4-linux-x86_64.tar.gz
sudo tar xvzf julia-1.10.4-linux-x86_64.tar.gz -C /opt/
sudo ln -s /opt/julia-1.10.4 /opt/julia
export PATH=/opt/julia/bin:${PATH}
```

Or use the **juliaup** version manager (recommended):

```shell
curl -fsSL https://install.julialang.org | sh
juliaup add release
```

### Debian / Ubuntu

```shell
sudo apt install julia
```

### Windows

```shell
winget install julia -s msstore
```

## Configuration

Julia projects use two files to pin dependencies:

* `Project.toml` — declares direct dependencies and compatibility bounds.
* `Manifest.toml` — exact resolved versions of all transitive dependencies.

## Usage, tips and tricks

### REPL and package manager

```shell
mkdir julia-poc
cd julia-poc
julia
```

Inside the REPL, press `]` to enter **pkg** mode. Press `Backspace` to return to the Julia prompt.

```shell
generate jpoc
add Pluto Plots CSV DataFrames
activate jpoc
```

When the project is ready:

```shell
cd jpoc
julia
# press ]
activate .
```

```julia
exit()
```

### Running a script

**jpoc/src/main.jl**

```julia
import jpoc
jpoc.greet()
```

```shell
julia --project=jpoc jpoc/src/main.jl
```

### Jupyter with Julia

Install the IJulia kernel inside the Julia REPL:

```julia
using Pkg
Pkg.add("IJulia")
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("Plots")
```

### Pluto notebooks

```julia
import Pluto
Pluto.run()
```

In a Pluto cell:

```julia
using Plots, CSV, DataFrames
```

### Function composition

```julia
julia> f(x) = x * 2
f (generic function with 1 method)

julia> g(x) = "Number is $(x)"
g (generic function with 1 method)

julia> h = g ∘ f
#13 (generic function with 1 method)

julia> h(5)
"Number is 10"
```

### IDE

Visual Studio Code with the
[Julia extension](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia) provides
syntax highlighting, REPL integration, debugger, and inline plot display.

## See also

* [Julia official site](https://julialang.org/)
* [Julia documentation](https://docs.julialang.org/)
* [Julia packages](https://juliapackages.com/)
* [Pluto.jl notebooks](https://github.com/fonsp/Pluto.jl)
