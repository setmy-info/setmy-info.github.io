# LFE (Lisp Flavored Erlang)

## Information

LFE (Lisp Flavored Erlang) is a Lisp (S-expression) syntax for Erlang, providing a full-featured Lisp system that runs
on the Erlang VM (BEAM). Created by Robert Virding (one of the original creators of Erlang), it was designed to provide
a Lisp that is 100% compatible with Erlang.

### Relation to Erlang

LFE is not just "like" Erlang; it *is* Erlang in a Lisp syntax. Key points of its relationship include:

* **BEAM VM**: LFE compiles directly to BEAM bytecode, just like Erlang.
* **Full Interoperability**: You can call any Erlang function from LFE and any LFE function from Erlang with zero overhead.
* **OTP Support**: LFE can use all OTP (Open Telecom Platform) behaviors like `gen_server`, `supervisor`, and `application`.
* **No Performance Penalty**: Since it compiles to the same bytecode as Erlang, there is no runtime performance difference.
* **Lisp-2**: LFE is a Lisp-2 (like Common Lisp), meaning it has separate namespaces for functions and variables.

## Installation

LFE is typically managed as a dependency in a `rebar3` project.

### Using rebar3

Add `lfe` as a dependency in your `rebar.config`:

```erlang
{deps, [
    {lfe, "2.1.2"}
]}.

{plugins, [
    {rebar3_lfe, "0.4.8"}
]}.
```

### Manual Installation (on Linux)

```shell
git clone https://github.com/lfe/lfe.git
cd lfe
make
sudo make install
```

## Usage, tips and tricks

### Interactive REPL

Start the LFE REPL with:

```shell
lfe
```

Example session:

```lfe
> (+ 1 2 3)
6
> (lfe_io:format "Hello, ~s!~n" '("World"))
Hello, World!
ok
```

### Defining a Module

```lfe
(defmodule hello
  (export (world 0)))

(defun world ()
  (lfe_io:format "Hello from LFE!~n" '()))
```

### Calling Erlang from LFE

You can call Erlang modules directly using the `:module:function` syntax:

```lfe
(: lists map (lambda (x) (* x 2)) '(1 2 3))
;; Returns (2 4 6)
```

## See also

* [LFE Official Website](https://lfe.io/)
* [LFE Documentation](https://lfe.io/docs/)
* [LFE on GitHub](https://github.com/lfe/lfe)
* [Erlang](erlang.md)
* [Elixir](elixir.md)
* [Lisp](lisp.md)
