# Groovy

## Information

## Installation

### CentOS, Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

```groovy
list = [1,2,3,4,5]
assert 15 == list.inject { e, a -> a += e}
assert 15 == list.sum()
assert [1,3,5] == list.findAll { it % 2 }
assert [1,3,5] == list.grep { it % 2 }
assert 3 == list.find {it > 2}
assert list.every {it < 6}
assert list.any { it % 2 == 0}
assert '1, 2, 3, 4, 5' == list.join(', ')
assert [1, 2] == list.take(2)
assert [4, 5] == list.drop(3)
assert [4, 5] == list.dropWhile { it <= 3 }
assert 1 == list.head()
assert [2, 3, 4, 5] == list.tail()
assert [6, 8] == list[2..3].collect {it * 2}
assert [[1,2,3],[4,5]] == list.collate(3)
assert 1 == list.min()
assert 5 == list.max()
list2 = [4,5,6,7,8]
list.intersect(list2)
assert [1,2,3] == list.minus(list2)
assert [6,7,8] == list2.minus(list)
assert [1, 2, 3, 4, 5, 6, 7, 8] == list.plus(list2).unique()

uniqueList = [1,3,3,4]
uniqueList.unique()
assert [1,3, 4] == uniqueList


upper1 = { s -> s.toUpperCase() }
upper2 = { it.toUpperCase() }
assert 'HELLO' == upper1('hello')
assert 'HELLO' == upper2('hello')

noArgClosure = {-> 'none'}
assert 'none' == noArgClosure()
// filter - findAll
// map - collect
// fold - inject
```

## See also

[xxxx](http://yyyyy)
