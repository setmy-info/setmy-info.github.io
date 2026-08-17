# Nerves Project

## Information

Nerves is the open-source platform and infrastructure for building, deploying, and managing professional-grade
embedded systems in Elixir. It combines the power of the Elixir language and the Erlang VM (BEAM) with a minimal,
customized Linux system (via Buildroot).

### What it is for

Nerves is designed for creating reliable, fault-tolerant firmware for embedded devices. It is commonly used in:
*   IoT (Internet of Things) devices.
*   Industrial automation.
*   Smart home systems.
*   Remote monitoring and data collection.

### Key Features

*   **Minimal Linux**: Boots in seconds and includes only what's necessary for the BEAM.
*   **Reliable Updates**: Built-in support for A/B firmware updates.
*   **Hardware Support**: First-class support for Raspberry Pi, BeagleBone, and other popular embedded boards.
*   **Elixir/Erlang ecosystem**: Full access to Mix, Hex, and OTP.

## Installation and Setup

### Prerequisites

You need Elixir and Erlang installed. You also need specific tools for firmware creation (like `fwup` and `squashfs-tools`).

### Creating a New Project

```shell
mix archive.install hex nerves_bootstrap
mix nerves.new my_nerves_app
cd my_nerves_app
```

### Building Firmware

```shell
export MIX_TARGET=rpi3    # Set your target hardware
mix deps.get
mix firmware
```

### Burning to an SD Card

```shell
mix firmware.burn
```

## See also

* [Nerves Project Official Website](https://nerves-project.org/)
* [Nerves Documentation](https://hexdocs.pm/nerves/getting-started.html)
* [Elixir](elixir.md)
* [Erlang](erlang.md)
