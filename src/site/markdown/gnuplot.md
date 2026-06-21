# Gnuplot

## Information

Gnuplot is a portable, command-driven data visualization and graphing tool. It supports a wide range of output
formats including PNG, PDF, SVG, PostScript, and interactive terminal display. Gnuplot is not related to the GNU
project despite the name — it predates it.

It is widely used in scientific computing, data analysis, and documentation generation because it can be scripted and
integrated into build pipelines.

## Installation

### Rocky Linux / CentOS

```shell
sudo dnf install -y gnuplot
gnuplot --version
```

### Fedora

```shell
sudo dnf install -y gnuplot
```

### Debian / Ubuntu

```shell
sudo apt-get install -y gnuplot
```

### FreeBSD

```shell
sudo pkg install -y gnuplot
```

### OpenIndiana

```shell
sudo pkg install gnuplot
```

### Windows

Download from the [Gnuplot download page](http://gnuplot.info/download.html) and add the `bin/` directory to `PATH`.

## Configuration

Gnuplot reads a startup file at `~/.gnuplot` (or `$GNUPLOT_LIB/gnuplotrc` for system-wide defaults).

Common startup settings:

```gnuplot
set terminal png size 800,600
set encoding utf8
set grid
```

Override the terminal and output on the command line:

```gnuplot
set terminal png size 1024,768
set output 'output.png'
```

## Usage, tips and tricks

### Basic Plot Commands

```gnuplot
# Plot a mathematical function
plot sin(x)

# Plot data from a CSV file (column 1 = x, column 2 = y)
plot 'data.csv' using 1:2 with lines

# Add labels and title
set xlabel 'Time (s)'
set ylabel 'Value'
set title 'Sensor readings'
set grid
plot 'data.csv' using 1:2 with linespoints

# Save to PNG
set terminal png size 800,600
set output 'chart.png'
replot
```

### Scripting

Save commands to a `.gp` file and run:

```shell
gnuplot myscript.gp
```

### Multiplot

```gnuplot
set multiplot layout 2,1 title 'Comparison'
plot sin(x) title 'sin'
plot cos(x) title 'cos'
unset multiplot
```

### Non-interactive / Pipeline Use

```shell
gnuplot -e "set terminal png; set output 'out.png'; plot sin(x)"
```

## See also

* [Gnuplot](http://gnuplot.info/)
* [Gnuplot documentation](http://gnuplot.info/documentation.html)
* [Gnuplot demos](http://gnuplot.info/demo/)
