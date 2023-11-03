# FP LMS

Topic arise from software development principles and patterns like on OOP **1.1** and **3** for FP.

## Conclusion

## Facts

1. In FP still have to write files (**.clj**, **.lisp**, **etc.**).
2. In FP still need to have files structured into **folders/directories**.
3. In FP developers still ask questions in which **directory** and **file** I should put that code X?
    1. Structured by **technology terms** (I/O, network, TCP, crypto, ...).
    2. Business rules (use cases, business terms, requirements, ...).
    3. SW dev patterns or **layers** (controllers, services, components, modules, ...).
4. In FP still have **variables**.
5. In FP developers still ask or can ask question (and mostly ask and should ask - if not is he/she robot/AI?), what
   are the **file, directory structure rules** our work (for functionality **X**, **Y**, etc.)?
5. In FP still have data structures like lists, vectors, **maps**, etc.
6. In FP **maps** are often used for **objects** (for example person data map with first name, last name, etc.). Some FP
   languages (F# ?) have **types**.
7. In OOP languages **classes** are often used for **types** and are taking a part at type checking at compile time. So
   in OOP classes are used to define new data **types** with some **rules**, **constraints** for **objects**.
8. In FP still need to validate map value data by rules.
9. Cleaner (less) code.
10. In Clojure immutability is reached, and we have pure functions.
11. We are living in world of objects (virtual objects too) and object names (nouns, types). Object is perhaps wrong
    term, maybe entities.

## L

Java for OOP and Clojure for FP.

Looking at facts - classes are replaced with file and directory structures and external (runtime) tools.
Variables are inside files, like variables in classes (like static variables or non-statics in singletons).
OOP domain model are in maps. In Clojure type check are at runtime and somewhere else in code (validation code,
validation libraries **2.9**).

FP is relatively new increasing type of programming and still need to have some rules for code. Need to invent wheel,
new wheel?

Implementing some SOLID rules as much as possible keeping in mind classes are files?

So it looks lie, when comparing/putting SOLID - S part at the same level with function. Maybe same with others letters
too. So it is not so simple, like presented, like FP has no more similar principles.

Therefore, it looks lie to me.

## M

Equality level is done forcibly, maybe for joke at the presentation moment. We still have so much common with OOP or
with classes - maybe even with some losses. Holding back information about reality, really comparable things, changing
forcibly context, looks salesman manipulation to me.

## S

Is reinventing the wheel smart process? Probably better is to take some existing design principles, change there
something with or by similar meaning and start apply that. Getting back old good and mature (in time approved) quality.
Not doing that looks stupid to me.

## Topicless

In OOP we have compile-time checks. But runtime we have also libs/frameworks for data
validations. Summa summarum is null at that point, but FP loss at compile time types checking. FP you can pass in code
to function anything(?).

## See also

1. [Simplified FP overview by Scott Wlaschin](https://www.youtube.com/watch?v=srQt1NAHYC0)
    1. 3:45 - overview of SF dev principles, patterns
2. [Clojure tools, libs, etc by Andrey Fadeev](https://www.youtube.com/watch?v=bME124Ky8M0)
    1. 0:00 Introduction
    2. 1:12 Libraries vs frameworks
    3. 2:16 How to manage dependencies
    4. 4:16 How to manage components
    5. 7:04 Configuration libraries
    6. 8:16 HTTP servers and HTTP abstractions
    7. 10:48 HTTP requests
    8. 11:58 Working with relational databases
    9. 14:12 **Schemas and validation**
    10. 15:21 Other libraries
    11. 17:08 Other tools (cljfmt, clj-kondo and babashka)
    12. 18:30 Outro
3. [Stackoverflow](https://stackoverflow.com/questions/327955/does-functional-programming-replace-gof-design-patterns)
   discussion
4. [Scott Wlaschin GitHub repos](https://github.com/swlaschin)
5. [Entity - entitas](https://en.wikipedia.org/wiki/Entity)
6. [Entiteet](https://et.wikipedia.org/wiki/Entiteet)
