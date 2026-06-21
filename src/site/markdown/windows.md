# Windows

## Information

Microsoft Windows is a family of operating systems developed by Microsoft. Key desktop versions in current use:

* **Windows 10** — released 2015, supported until October 2025.
* **Windows 11** — released 2021, requires TPM 2.0 and UEFI Secure Boot.
* **Windows Server 2019 / 2022** — server editions with Long-Term Servicing Channel (LTSC) support.

Windows is the dominant desktop OS for enterprise environments. For development, WSL2 (Windows Subsystem for Linux)
makes it practical to run Linux toolchains alongside Windows applications.

## Installation

### Package Managers

Windows has several package managers that allow software installation from the command line:

**winget** (built into Windows 10 1709+ and Windows 11):

```powershell
winget install Git.Git
winget install Microsoft.VisualStudioCode
winget search nodejs
winget upgrade --all
```

**Chocolatey** (third-party, large package catalogue):

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install nodejs-lts
```

**Scoop** (user-space installs, no admin rights needed):

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
scoop install git nodejs
```

### WSL2 (Windows Subsystem for Linux)

```powershell
# Enable WSL and install default Ubuntu distribution
wsl --install
# Install a specific distribution
wsl --install -d Debian
# List available distributions
wsl --list --online
```

## Configuration

### Environment Variables

Set via: **System Properties → Advanced → Environment Variables**.

Or via PowerShell:

```powershell
# User variable (current user only)
[Environment]::SetEnvironmentVariable("MY_VAR", "value", "User")
# System variable (requires admin)
[Environment]::SetEnvironmentVariable("MY_VAR", "value", "Machine")
```

### PowerShell Execution Policy

By default, PowerShell blocks unsigned scripts. For development machines:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Get-ExecutionPolicy
```

## Usage, tips and tricks

### Add Application to Startup

```
Windows + R → shell:startup
```

Place shortcuts or scripts in the folder that opens to run them at login.

### Useful Keyboard Shortcuts

| Shortcut      | Action                                 |
|---------------|----------------------------------------|
| `Win + R`     | Run dialog                             |
| `Win + X`     | Power user menu (Device Manager, etc.) |
| `Win + E`     | Open File Explorer                     |
| `Win + I`     | Settings                               |
| `Win + L`     | Lock screen                            |
| `Ctrl + Shift + Esc` | Task Manager                    |

### PowerShell vs CMD

Use PowerShell for scripting and automation. CMD is a legacy shell kept for compatibility. PowerShell supports
objects, pipelines, and .NET integration.

### WSL2 File Access

Access Windows files from WSL2 at `/mnt/c/`. Access WSL2 files from Windows Explorer via `\\wsl$\Ubuntu\`.

## See also

* [Windows documentation](https://learn.microsoft.com/en-us/windows/)
* [WSL documentation](https://learn.microsoft.com/en-us/windows/wsl/)
* [winget documentation](https://learn.microsoft.com/en-us/windows/package-manager/winget/)
* [Chocolatey](https://chocolatey.org/)
* [Scoop](https://scoop.sh/)
