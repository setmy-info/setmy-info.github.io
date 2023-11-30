# C++

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

namespace SetMyInfo {
    class A {
    public:
        A();
        virtual ~A();
        void doSomething();
    private:
        int data_;
    };
}

#endif // SET_MY_INFO_A_H
````

A.cpp

```cpp
#include "A.h"

using SetMyInfo::A;

A::A() {
    // Const impl
}

A::~A() {
    // Dest impl
}

void A::doSomething() {
    // Impl
}
````

C functions in C++.

```cpp
#ifdef __cplusplus
extern "C" {
#endif

void myCFunction(int arg1, int arg2);

#ifdef __cplusplus
}
#endif
```

## Function composition

```cpp
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
  std::vector<int> nums {1, 2, 3, 4, 5};

  // Lambda funktsiooni creation
  auto doubleNum = [](int num) { return num * 2; };

  // Apply lambda funktsion to all elements in a vector
  std::transform(nums.begin(), nums.end(), nums.begin(), doubleNum);

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
Example get_example_return_by_value() {
    Example example(123);
    // do work
    return example;
}

void caller_function() {
    const Example example = get_example_return_by_value();
    // do work
}
```

2. Or return pointer and put it immediately into smart pointer, to be released when exiting scope.
   Use this form at low level services/components.

```cpp
Example *get_example_return_by_pointer() {
    Example *example = new Example(123);
    // do work
    return example;
}

void five_two() {
    // Or std::shared_ptr
    std::unique_ptr<Example> example_smart_pointer(get_example_return_by_pointer());
    // do work
}
```

## See also

Google C++ Style Guide: https://google.github.io/styleguide/cppguide.html

LLVM Coding Standards: https://llvm.org/docs/CodingStandards.html

C++ Core
Guidelines: https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines
, https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md

Microsoft C++ Coding Standards: https://docs.microsoft.com/en-us/cpp/cpp/cpp-coding-standards

GNU Coding Standards for C++: https://www.gnu.org/prep/standards/standards.html#Formatting

Mozilla C++ Coding Style Guide: https://firefox-source-docs.mozilla.org/code-quality/coding-style/coding_style_cpp.html

Bjarne Stroustrup's C++ Style and Technique FAQ: https://www.stroustrup.com/bs_faq2.html

http://fftw.org/

[xxxx](http://yyyyy)
