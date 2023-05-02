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

## Function composition

```
#include <iostream>
#include <vector>
#include <algorithm>

int main() {
  std::vector<int> nums {1, 2, 3, 4, 5};
  
  // Lambda funktsiooni loomine, mis võtab argumentina num ja tagastab num * 2
  auto doubleNum = [](int num) { return num * 2; };
  
  // Rakendame lambda funktsiooni igale elemendile vektoris
  std::transform(nums.begin(), nums.end(), nums.begin(), doubleNum);
  
  // Väljastame muudetud vektori
  for (auto num : nums) {
    std::cout << num << " ";
  }
  
  return 0;
}
```

## See also

[xxxx](http://yyyyy)
