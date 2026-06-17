# Architecture

Why predefined architecture?

1. Most of the important is that decisions are made (you like it or not) that means some kind of plan are made.

2. More time - no need to spend time to argue, where opposite sides should prove something, prepare for proving,
   search information for proving, reading and listening to each-other, misunderstanding, etc etc

3. Bad plan is a better than no plan.

## Principles

1. *Same version*. All components should have a same version, simple to remember and add as dependency.

2. *POM similarity*. java-model, java-service and springboot-start-project are made as base and other should follow
   these structures 1:1 as much as possible.

3. *Standardizing and stability as mush as possible*. So third partys (private companies etc) should have possibility to
   make tool top on all project
   possibilities - component locations in folder structure, module/component folder structure, libraries and modules,
   tools, frameworks used.

## Standard profiles

Profiles for Maven, Spring, Micronaut etc profiles are per environment one to one. Name it as mentioned in environments
list.

See also `ADR-0042` for the rule that runtime profiles must use only the canonical environment names.

See also `ADR-0043` for the `Architecture levels 1-5` reference table.

## Hybrid architecture (cloud + )

## Feature switches levels

Complexity grows with level.

1. Compiled into code, changed in some classes as boolean (only) values and compiled again.
2. Configuration compiled into final package (like Java jar), but overloaded by external configuration (file) with
   boolean values only.
3. Like previous, but also DB holds boolean values. Overload order: db is overwritten by config all that overwritten by
   command line. DB is replacing fancy switches UI.
4. External library used, not anymore boolean values, string values, more control elements/functions.
5. Like previous, but with UI.
