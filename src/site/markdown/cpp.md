# C++

## Coding standard

### Include loading order

Include as:

1. corresponding header file to current .cpp file (with "")
2. current project header files (with "")
3. third party header files (with <>)
4. standard headers C headers (with <>)
5. standard C++ headers (with <>)
6. system headers (with <>)

## Rules

* No mem allocation in constructor.
* Strip bnaries.

## Example code blocks

```cpp
#ifndef SETMYINFO_A_H
#define SETMYINFO_A_H

namespace SetmyInfo {
    class A {
    public:
        A();
        virtual ~A();
        void doSomething();
    private:
        int data_;
    };
}

#endif // SETMYINFO_A_H
````

```cpp
#include "A.h"

using SetmyInfo::A;

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

```cpp
#ifdef __cplusplus
extern "C" {
#endif

// C keelne funktsiooni deklaratsioon
void myCFunction(int arg1, int arg2);

#ifdef __cplusplus
}
#endif
```

## See also

Google C++ Style Guide: https://google.github.io/styleguide/cppguide.html

LLVM Coding Standards: https://llvm.org/docs/CodingStandards.html

C++ Core
Guidelines: https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines, https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md

Microsoft C++ Coding Standards: https://docs.microsoft.com/en-us/cpp/cpp/cpp-coding-standards

GNU Coding Standards for C++: https://www.gnu.org/prep/standards/standards.html#Formatting

Mozilla C++ Coding Style Guide: https://firefox-source-docs.mozilla.org/code-quality/coding-style/coding_style_cpp.html

Bjarne Stroustrup's C++ Style and Technique FAQ: https://www.stroustrup.com/bs_faq2.html

http://fftw.org/

[xxxx](http://yyyyy)
