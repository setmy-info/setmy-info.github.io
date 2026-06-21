# C++

## Information

C++ is a compiled, statically typed, general-purpose programming language that extends C with object-oriented
programming, templates (generic programming), and the Standard Template Library (STL). It is used for
performance-critical applications: embedded systems, game engines, operating systems, high-frequency trading,
scientific computing, and graphics.

Key characteristics:

* **Zero-cost abstractions** — templates, inline functions, and RAII incur no runtime overhead.
* **Manual memory management** — raw pointers, `new`/`delete`, and modern smart pointers (`unique_ptr`,
  `shared_ptr`).
* **OOP + Generic programming** — classes, inheritance, virtual dispatch, templates, and concepts (C++20).
* **Standards**: C++11, C++14, C++17, C++20, C++23 — each adds language features and library improvements.

## Installation

### Rocky Linux / CentOS / Fedora

```shell
sudo dnf install -y gcc-c++ clang cmake make
g++ --version
clang++ --version
cmake --version
```

### Debian / Ubuntu

```shell
sudo apt install -y g++ clang cmake make
```

### Build Tools

```shell
# CMake-based project
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

### Package Managers

* **vcpkg** — Microsoft's C++ library manager: `vcpkg install boost openssl`
* **Conan** — cross-platform C/C++ package manager: `conan install .`

## Coding standard

### Include loading order

Include as:

1. corresponding header file to current .cpp file (with "")
2. current project header files (with "")
3. third party header files (with <>)
4. standard C header files (with <>)
5. standard C++ header files (with <>)
6. system header files (with <>)

## Rules

* No mem allocation in constructor.
* Strip binaries for production/Release.
* C++ .h, .cpp file extensions.
* C .h, .c file extensions.
* Separated Unit tests (test) ant integration test (verify). Option to run on valgrind.

## Example code blocks

A.h

```cpp
#ifndef SET_MY_INFO_A_H
#define SET_MY_INFO_A_H

namespace set_my_info {
    class A {
    public:
        A();
        virtual ~A();
        void DoSomething();
    private:
        int data_length_;// trailing _ for class members
    };
}

#endif // SET_MY_INFO_A_H
````

A.cpp

```cpp
#include "A.h"

using set_my_info::A;

A::A(): data_length_(0) {
    // Const impl
}

A::~A() {
    // Dest impl
}

void A::DoSomething() {
    // Impl
}
````

C functions in C++.

```cpp
#ifdef __cplusplus
extern "C" {
#endif

void MyCFunction(int arg1, int arg2);

#ifdef __cplusplus
}
#endif
```

## Compare with Java

```cpp
#ifndef SET_MY_INFO_A_H
#define SET_MY_INFO_A_H

namespace SetMyInfo {
    class A {
    public:
        void DoSomething();

        // Overridable. Non-pure function.
        virualt void DoSomethingElse();

        // Pure virtual function like in java abstract. Makes class like Java abstract class.
        virualt void DoSomethingElse2() = 0;
    };

    class B : A {
    public:

        // Like @Override in Java
        void DoSomethingElse() = override {};

        // Like @Override in Java
        void DoSomethingElse2() = override {};
    };
}

#endif // SET_MY_INFO_A_H
```

## Function composition

```cpp
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
  std::vector<int> nums {1, 2, 3, 4, 5};

  // Lambda funktsiooni creation
  auto double_num = [](int num) { return num * 2; };

  // Apply lambda funktsion to all elements in a vector
  std::transform(nums.begin(), nums.end(), nums.begin(), double_num);

  // Output vector
  for (auto num : nums) {
    std::cout << num << " ";
  }

  return 0;
}
```

# Returning

1. Return class instances by value (return by value) and caller should use 'const' keyword for function return value
   to avoid class copy. Compiler optimizes and uses caller stack instance.

```cpp
Example GetExampleReturnByValue() {
    Example example(123);
    // do work
    return example;
}

void CallerFunction() {
    const Example example = GetExampleReturnByValue();
    // do work
}
```

2. Or return pointer and put it immediately into smart pointer, to be released when exiting scope.
   Use this form at low level services/components.

```cpp
Example *GetExampleReturnByPointer() {
    Example *example = new Example(123);
    // do work
    return example;
}

void FiveTwo() {
    // Or std::shared_ptr
    std::unique_ptr<Example> example_smart_pointer(GetExampleReturnByPointer());
    // do work
}
```

## See also

* [cppreference.com](https://en.cppreference.com/) — comprehensive C++ language and library reference
* [isocpp.org](https://isocpp.org/) — ISO C++ committee and FAQ
* [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)
* [learncpp.com](https://www.learncpp.com/) — free beginner-to-advanced C++ tutorial
* [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)
* [LLVM Coding Standards](https://llvm.org/docs/CodingStandards.html)
* [Mozilla C++ Coding Style Guide](https://firefox-source-docs.mozilla.org/code-quality/coding-style/coding_style_cpp.html)
* [Bjarne Stroustrup's FAQ](https://www.stroustrup.com/bs_faq2.html)
* [CERT C++ Coding Standards](https://wiki.sei.cmu.edu/confluence/pages/viewpage.action?pageId=88046682)
* [Pure virtual functions — learncpp](https://www.learncpp.com/cpp-tutorial/pure-virtual-functions-abstract-base-classes-and-interface-classes/)
* [Abstract classes — cppreference](https://en.cppreference.com/w/cpp/language/abstract_class)
* [FFTW](http://fftw.org/)
* [cmake-start-project](cmake-start-project.md)

