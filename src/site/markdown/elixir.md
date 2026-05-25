# Template

## Information

## Installation

### Rocky Linux

#### Git

```shell
cd ~/sources/others
git clone https://github.com/elixir-lang/elixir.git elixir
cd elixir

LATEST_TAG=$(git tag --sort=-version:refname \
  | grep '^v' \
  | grep -v -- '-rc' \
  | grep -v -- '-alpha' \
  | grep -v -- '-beta' \
  | head -n 1)
ELIXIR_VERSION=${LATEST_TAG#v}
echo "Latest Elixir stable tag: $LATEST_TAG ($ELIXIR_VERSION)"
git checkout "$LATEST_TAG"

make clean compile
sudo mkdir -p /opt/elixir-1.19.5
sudo cp -r . /opt/elixir-1.19.5
```

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```elixir
# ============================================================
# ELIXIR FUNCTIONAL PROGRAMMING PATTERNS - SINGLE BLOCK
# ============================================================

defmodule FPPatterns do
  # ==========================================================
  # 1. FUNCTION COMPOSITION
  # Idea: small functions are combined into a processing chain
  # ==========================================================

  def add1(x), do: x + 1
  def double(x), do: x * 2

  def composition_example(x) do
    x
    |> add1()    # first transformation
    |> double()  # second transformation
  end


  # ==========================================================
  # 2. HIGHER-ORDER FUNCTION
  # Idea: function that takes another function as argument
  # ==========================================================

  def apply_twice(fun, x) do
    x
    |> fun.()  # first application
    |> fun.()  # second application
  end


  # ==========================================================
  # 3. MAP / FILTER / REDUCE
  # Core FP collection operations
  # ==========================================================

  def map_filter_reduce(list) do
    list
    |> Enum.map(fn x -> x * 2 end)              # MAP: transform each element
    |> Enum.filter(fn x -> x > 4 end)           # FILTER: keep matching values
    |> Enum.reduce(0, fn x, acc -> x + acc end) # REDUCE: aggregate result
  end


  # ==========================================================
  # 4. PIPELINE PATTERN
  # Data flows step by step through functions
  # ==========================================================

  def trim(x), do: String.trim(x)
  def normalize(x), do: String.upcase(x)
  def validate(x), do: {:ok, x}
  def save(x), do: {:ok, "Saved: #{x}"}

  def pipeline(input) do
    input
    |> trim()
    |> normalize()
    |> validate()
    |> save()
  end


  # ==========================================================
  # 5. RESULT PATTERN (ok / error flow)
  # Railway-oriented programming style
  # ==========================================================

  def step1(x), do: {:ok, x + 1}
  def step2(x), do: {:ok, x * 2}
  def step3(x), do: {:ok, x - 3}

  def result_pipeline(x) do
    with {:ok, a} <- step1(x),
         {:ok, b} <- step2(a),
         {:ok, c} <- step3(b) do
      {:ok, c}
    end
  end


  # ==========================================================
  # 6. STRATEGY PATTERN
  # Function passed as argument (behavior injection)
  # ==========================================================

  def process(data, transform_fun) do
    transform_fun.(data)
  end


  # ==========================================================
  # 7. PARTIAL APPLICATION / ANONYMOUS FUNCTION
  # ==========================================================

  def replace_e(text) do
    String.replace(text, "e", "")
  end

  replace_e_fun = &String.replace(&1, "e", "")


  # ==========================================================
  # 8. FUNCTION COMPOSITION (manual implementation)
  # ==========================================================

  def compose(f, g) do
    fn x ->
      x |> f.() |> g.()
    end
  end


  # ==========================================================
  # 9. IMMUTABLE STATE TRANSFORMATION
  # ==========================================================

  def update_state(state) do
    Map.put(state, :updated, true)
  end
end


# ============================================================
# USAGE EXAMPLES (comments only)
# ============================================================

# FPPatterns.composition_example(10)
# => 22

# FPPatterns.apply_twice(fn x -> x * 2 end, 5)
# => 20

# FPPatterns.map_filter_reduce([1,2,3,4])
# => pipeline result

# FPPatterns.pipeline("  hello  ")
# => {:ok, "Saved: HELLO"}

# FPPatterns.result_pipeline(10)
# => {:ok, ...}

# FPPatterns.process("hello", &String.upcase/1)
# => "HELLO"

# f = FPPatterns.compose(fn x -> x + 1 end, fn x -> x * 2 end)
# f.(10)
# => 22
```

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
* [Erlang Package Repo](https://hex.pm/)
