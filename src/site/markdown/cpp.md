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

Google C++ Style Guide: https://google.github.io/styleguide/cppguide.html

LLVM Coding Standards: https://llvm.org/docs/CodingStandards.html

C++ Core
Guidelines: https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines,
https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md,
https://isocpp.org/wiki/faq/coding-standards

Microsoft C++ Coding Standards: https://docs.microsoft.com/en-us/cpp/cpp/cpp-coding-standards

GNU Coding Standards for C++: https://www.gnu.org/prep/standards/standards.html#Formatting

Mozilla C++ Coding Style Guide: https://firefox-source-docs.mozilla.org/code-quality/coding-style/coding_style_cpp.html

Bjarne Stroustrup's C++ Style and Technique FAQ: https://www.stroustrup.com/bs_faq2.html

CERT C++ Coding Standards:

* https://wiki.sei.cmu.edu/confluence/pages/viewpage.action?pageId=88046682
* https://insights.sei.cmu.edu/library/sei-cert-c-coding-standard-rules-for-developing-safe-reliable-and-secure-systems-2016-edition-2/
* https://insights.sei.cmu.edu/library/sei-cert-c-and-c-coding-standards/

MISRA C++: https://www.amazon.co.uk/dp/1911700103

JOINT STRIKE FIGHTER (JSF): https://stroustrup.com/JSF-AV-rules.pdf

Sutter and Alexandrescu: https://www.amazon.com/exec/obidos/ASIN/0321113586/

http://fftw.org/

[xxxx](http://yyyyy)

https://www.learncpp.com/cpp-tutorial/pure-virtual-functions-abstract-base-classes-and-interface-classes/

https://en.cppreference.com/w/cpp/language/abstract_class

