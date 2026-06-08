# Qt

## Information

`Qt` is a cross-platform application development framework and UI toolkit commonly used for desktop applications,
embedded interfaces, industrial software, engineering tools, and rich native-style graphical clients. In the context of
`Rocky Linux 10.x`, it is relevant both as a runtime dependency for existing applications and as a development stack for
building modern `C++` or `QML`-based software on an enterprise-oriented Linux platform.

### Main Functionalities and Features

* **Cross-platform GUI Framework**: Build native-feeling desktop applications for `Linux`, `Windows`, and `macOS` from a
  shared codebase.
* **Widgets and `QML` / `Qt Quick`**: Supports both traditional widget-based UIs and modern declarative interfaces.
* **Core Application Libraries**: Includes containers, string handling, networking, threading, file APIs, timers,
  processes, and serialization helpers.
* **Graphics and Multimedia Support**: Covers 2D / 3D rendering, image handling, audio, video, and related UI
  integration layers.
* **SQL and Database Integration**: Commonly used with `SQLite`, `PostgreSQL`, `MySQL`, and other supported backends.
* **Tools and Build System Support**: Works with `CMake`, legacy `qmake`, `Qt Creator`, translation tooling, resource
  embedding, and UI design workflows.
* **Embedded and Industrial Relevance**: Frequently used in `HMI`, kiosk, control-panel, and device-management software.

### Common Developer Use Cases

* Build a native desktop tool for internal engineering or operations teams.
* Create a cross-platform `C++` application with one shared UI and business logic codebase.
* Develop an embedded or kiosk-style interface on a `Linux` distribution.
* Maintain software that depends on `Qt 6` runtime libraries on `Rocky Linux 10.x`.

## Installation

### Rocky Linux 10.x

For `Rocky Linux 10.x`, the exact package names and repository availability can vary by enabled repositories and by
whether you want runtime packages only or a full development environment. In practice, start by refreshing metadata and
searching available `Qt` packages:

```bash
sudo dnf makecache
dnf search qt6
dnf search qt-creator
```

Typical package groups to look for:

* `qt6-qtbase`
* `qt6-qtbase-devel`
* `qt6-qtdeclarative`
* `qt6-qtdeclarative-devel`
* `qt6-qtmultimedia`
* `qt6-qttools`
* `qt-creator`

Example installation for a common development setup:

```bash
sudo dnf install -y qt6-qtbase qt6-qtbase-devel qt6-qtdeclarative qt6-qtdeclarative-devel qt6-qttools qt-creator cmake gcc-c++
```

If some packages are unavailable in your enabled repositories, verify whether the required `CRB` or additional
Rocky-compatible repositories are enabled in your environment before choosing third-party sources.

### Practical Rocky Linux Notes

* Prefer distribution packages first for predictable maintenance and security updates.
* Confirm whether your target software expects `Qt 5` or `Qt 6`; enterprise Linux environments may contain both in
  different forms.
* For GUI applications on servers or minimal images, remember that X11 / Wayland, fonts, and desktop integration
  packages may also be needed.
* Keep `gcc`, `cmake`, and debugger tooling aligned with the platform toolchain.

## Configuration

Typical configuration concerns in a `Rocky Linux 10.x` environment include:

* selecting the required `Qt` major version,
* ensuring development headers and runtime libraries are both installed,
* configuring `CMake` or, for older projects, `qmake` to find the correct `Qt6` packages,
* checking platform plugins for `xcb` or Wayland-based GUI execution,
* and documenting any extra multimedia, WebEngine, or SQL driver dependencies.

For team environments, keep build instructions versioned and note which repositories and packages are required for
reproducible workstation or build-agent setup.

## Usage, tips and tricks

* Prefer `CMake`-based builds for modern `Qt 6` projects when starting new work.
* Treat `qmake` mainly as a legacy build tool for existing Qt projects rather than the default choice for new
  development.
* Verify package availability on the exact `Rocky Linux 10.x` image used in development, `CI`, and production-like
  environments.
* Separate framework installation concerns from application packaging concerns.
* If you deploy GUI software, test it on the same display stack type (`X11` or Wayland) that the target environment
  uses.
* When using `QML`, keep runtime module dependencies explicit so deployment is easier to reproduce.

### `qmake` in Qt context

`qmake` is Qt's older project-generation and build-configuration tool. Conceptually it fills a similar role to `CMake`:
you describe your application, source files, forms, resources, and required Qt modules, and the tool generates the
platform-specific build files needed by the compiler toolchain.

For modern Qt development, the newer and recommended direction is `CMake`, especially for `Qt 6`. `qmake` is still
important to understand because many existing codebases, tutorials, and internal tools continue to use `.pro` project
files, but it should generally be seen as a maintenance and compatibility topic rather than the primary build approach
for new projects.

### Newer build direction: `CMake`

If you are starting a new Qt project today, use `CMake` instead of `qmake`. In current Qt documentation and tooling,
`CMake` is the standard build system for new work.

Why `CMake` is the newer preferred option:

* it is the default direction for modern `Qt 6` projects,
* it integrates better with broader `C++` ecosystems and tooling,
* it is a better fit for mixed dependencies outside Qt,
* and it is the build approach most new examples and official guidance focus on.

Typical situations where `qmake` is useful to know:

* maintaining an older Qt application that already uses `.pro` files,
* reading legacy examples from blogs, forums, or internal repositories,
* understanding how `Qt Creator` opens and builds older Qt projects,
* and doing quick experiments with a very small Qt Widgets or `QML` application.

### Minimal `qmake` Example

Create a file such as `qt-hello.pro`:

```qmake
QT += widgets
CONFIG += c++17 console
CONFIG -= app_bundle

SOURCES += main.cpp
```

Then generate build files and build the application:

```bash
qmake6 qt-hello.pro
make
```

On some systems the binary may be named `qmake` instead of `qmake6`, depending on packaging and whether `Qt 5` and
`Qt 6` are both installed.

### How to use `qmake`

The usual `qmake` workflow is:

1. Create a `.pro` file that declares the project type, Qt modules, sources, headers, forms, and resources.
2. Run `qmake` or `qmake6` on that file to generate a `Makefile`.
3. Run `make` to compile the application.
4. Re-run `qmake` if you change project structure in ways that affect generated build files.

Common `.pro` items include:

* `QT += widgets network sql` to enable Qt modules,
* `SOURCES += main.cpp window.cpp`,
* `HEADERS += window.h`,
* `FORMS += window.ui`,
* `RESOURCES += resources.qrc`,
* and `CONFIG += c++17` for compiler-related settings.

For `Rocky Linux 10.x`, verify that the package providing `qmake` is installed, usually through the Qt development tools
packages. If you work on a mixed environment with both `Qt 5` and `Qt 6`, be careful to invoke the correct `qmake`
binary for the target major version.

### Minimal `CMake` Example

```cmake
cmake_minimum_required(VERSION 3.16)
project(QtHello LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Widgets)

add_executable(qt-hello main.cpp)
target_link_libraries(qt-hello PRIVATE Qt6::Widgets)
```

### Minimal `C++` Example

```cpp
#include <QApplication>
#include <QLabel>

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    QLabel label("Hello from Qt on Rocky Linux");
    label.resize(320, 80);
    label.show();
    return app.exec();
}
```

## See also

* [Qt official site](https://www.qt.io/)
* [Qt documentation](https://doc.qt.io/)
* [SDL](sdl.html)
* [C++](cpp.html)
