# ReactOS

## Information

ReactOS is an open-source operating system designed to be binary-compatible with Microsoft Windows NT-based
applications and drivers. The goal is to allow Windows software and hardware drivers to run on a completely free
and open-source OS without requiring a Windows license.

Key characteristics:

* **Binary compatibility target** — Windows Server 2003 / Windows XP application and driver ABI.
* **Architecture** — NT-style kernel, HAL, and user-mode subsystem; written in C/C++.
* **Current status** — alpha quality. Suitable for testing and experimentation; not recommended for production or
  daily-driver use.
* **Not a Wine derivative** — ReactOS implements the NT kernel from scratch; Wine (Linux compatibility layer for
  Windows apps) is a separate project with different goals.

ReactOS is primarily useful for running legacy Windows XP-era software on open-source hardware, researching Windows
NT internals, and OS development education.

## Usage, tips and tricks

* Boot ReactOS from a live ISO or install it to a virtual machine (QEMU, VirtualBox, VMware) for safe testing.
* Expect frequent crashes and missing functionality — the alpha status is real.
* Hardware support is limited; a virtual machine with emulated hardware gives the most compatible environment.
* The ReactOS application compatibility database lists which apps work, partially work, or crash.

## See also

* [ReactOS website](https://reactos.org/)
* [ReactOS download](https://reactos.org/download/)
* [ReactOS 0.4.14 ISO (SourceForge mirror)](https://sourceforge.net/projects/reactos/files/ReactOS/0.4.14/ReactOS-0.4.14-release-108-gf902afe-iso.zip/download?use_mirror=deac-ams)
