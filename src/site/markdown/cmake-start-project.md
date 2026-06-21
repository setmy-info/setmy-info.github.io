# cmake-start-project

## Information

CMake is a cross-platform build system generator. It does not build code directly but generates native build files
(Makefiles, Ninja build files, Visual Studio projects, etc.) from a `CMakeLists.txt` description. It is the de-facto
standard for C and C++ projects.

## Preparations

### Minimal Project Structure

```
my-project/
├── CMakeLists.txt
├── src/
│   └── main.cpp
├── include/
│   └── my-project/
│       └── my_lib.h
├── tests/
│   └── test_main.cpp
└── cmake/
    └── FindSomeDep.cmake
```

### Minimal CMakeLists.txt (executable)

```cmake
cmake_minimum_required(VERSION 3.20)
project(my-project VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(my-project src/main.cpp)
target_include_directories(my-project PRIVATE include)
```

### Minimal CMakeLists.txt (library + executable)

```cmake
cmake_minimum_required(VERSION 3.20)
project(my-project VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(my-lib src/my_lib.cpp)
target_include_directories(my-lib PUBLIC include)

add_executable(my-project src/main.cpp)
target_link_libraries(my-project PRIVATE my-lib)
```

### Build and Run

```shell
mkdir build
cd build
cmake ..
cmake --build .
./my-project
```

Release build:

```shell
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
```

Using Ninja (faster builds):

```shell
cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug ..
ninja
```

## Installation

### Rocky Linux / Fedora

```shell
sudo dnf install -y cmake gcc gcc-c++ ninja-build
cmake --version
```

### Debian / Ubuntu

```shell
sudo apt-get install -y cmake g++ ninja-build
cmake --version
```

### FreeBSD

```shell
pkg install -y cmake ninja
```

### Windows

Install via winget:

```powershell
winget install Kitware.CMake
winget install Ninja-build.Ninja
```

Or install via Visual Studio Installer which bundles CMake and Ninja.

## Configuration

### CMakePresets.json (CMake 3.20+)

Presets allow sharing standard configure/build/test options without passing flags manually:

```json
{
    "version": 3,
    "configurePresets": [
        {
            "name": "debug",
            "generator": "Ninja",
            "binaryDir": "${sourceDir}/build/debug",
            "cacheVariables": {
                "CMAKE_BUILD_TYPE": "Debug"
            }
        },
        {
            "name": "release",
            "generator": "Ninja",
            "binaryDir": "${sourceDir}/build/release",
            "cacheVariables": {
                "CMAKE_BUILD_TYPE": "Release"
            }
        }
    ]
}
```

Use with:

```shell
cmake --preset debug
cmake --build --preset debug
```

### Dependency Management with vcpkg

```shell
git clone https://github.com/microsoft/vcpkg.git
./vcpkg/bootstrap-vcpkg.sh
```

Add to CMakeLists.txt before `project()`:

```cmake
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake")
```

Declare dependencies in `vcpkg.json`:

```json
{
    "name": "my-project",
    "version": "0.1.0",
    "dependencies": ["fmt", "spdlog"]
}
```

### Dependency Management with Conan

```shell
pip install conan
conan profile detect
```

`conanfile.txt`:

```ini
[requires]
spdlog/1.13.0

[generators]
CMakeDeps
CMakeToolchain
```

```shell
conan install . --output-folder=build --build=missing
cmake -B build -DCMAKE_TOOLCHAIN_FILE=build/conan_toolchain.cmake
cmake --build build
```

## Usage, tips and tricks

### CTest — Unit Testing

Add tests to `CMakeLists.txt`:

```cmake
enable_testing()
find_package(GTest REQUIRED)

add_executable(test_main tests/test_main.cpp)
target_link_libraries(test_main PRIVATE my-lib GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(test_main)
```

Run tests:

```shell
cd build
ctest --output-on-failure
```

### Install Rules

```cmake
install(TARGETS my-project DESTINATION bin)
install(TARGETS my-lib DESTINATION lib)
install(DIRECTORY include/ DESTINATION include)
```

Install to a local prefix:

```shell
cmake --install build --prefix /opt/my-project
```

### Compiler Warnings

```cmake
target_compile_options(my-project PRIVATE -Wall -Wextra -Wpedantic)
```

## See also

* [CMake official documentation](https://cmake.org/documentation/)
* [CMake tutorial](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)
* [vcpkg](https://vcpkg.io/)
* [Conan package manager](https://conan.io/)
* [GoogleTest](https://github.com/google/googletest)
* [cpp.md](cpp.md)
