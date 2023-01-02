Julia language

```shell
mkdir julia-poc
cd julia-poc
julia
```

Press **]**

Then it goes to **pkg** mode.

To go back to Julia language REPL press **backspace**.

```shell
generate jpoc
add Pluto  Plots CSV DataFrames
activate jpoc
``` 

When project is ready, then:

```shell
cd jpoc
julia
# ]
activate .
```

```julia
exit()
``` 

**jpoc/src/main.jl**

```julia
import jpoc
jpoc.greet()
``` 

```shell
cd jpoc
julia --project=jpoc jpoc/src/main.jl
```

Pluto in Julia mode

```julia
import Pluto
Pluto.run()
``` 

In pluto:

```sh
using Plots, CSV, DataFrames
```

IDE

Visual Studio Code

With plugin:

https://marketplace.visualstudio.com/items?itemName=julialang.language-julia
