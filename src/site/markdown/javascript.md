# JavaScript

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

### Coding tips and tricks

Function composition

```javascript
const add = x => x + 1;
const multiplyByTwo = x => x * 2;
const addAndMultiply = add.compose(multiplyByTwo);

console.log(addAndMultiply(2)); // Output: 6
```

## See also
