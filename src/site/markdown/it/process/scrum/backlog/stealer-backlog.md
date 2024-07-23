# Stealer backlog

## Offer

### Skills

1. Linux
2. Java
3. Maven
4. Unit & Integration Testing with JUnit 5, Mockito and AssertJ
5. git, diff (optional), patch and sed commands
6. Understanding singleton pattern

### Services

1. Data class models and service implementation
2. Unit and integration tests as proof

####

## Prerequisites and requirements

1. Repository: **git@github.com:setmy-info/setmy.info.git** in [GitHub](https://github.com/setmy-info/setmy.info) as
   **multi-projects** monorepo
2. Branch: **develop**
3. **Java 21** (OpenJDK) or **multi-projects** property **java.version**
4. Modules to development: **java-vcs**, **java-staler**
5. **Lombok**, **JUnit 5**, **Mockito**, **AssertJ** and modules dependencies only.
6. Prepare(d), fix and change repo A: **git@github.com:setmy-info/stealer-test-a.git**
7. Prepare(d), fix and change repo B: **git@github.com:setmy-info/stealer-test-b.git**
8. Stealer folder: **.stealer**  in working directory
9. Latest **Rocky** or **Fedora** Linux. Should run also on **Windows**.
10. **Unit tests** end with suffix **Test.java** and testable unit (under test) is method (function), other depending on
    units should be mocked out - if needed leave units as package level access. Should not depend on files and DB-s.
11. **Integration tests** end with suffix **IT.java** / can depend on files, config etc.
12. Try to hold as much as possible immutable classes.
13. No config files. Config related data model classes are populated by tests. Config parsing and populating is in
    another task, in CLI tool development task. CLI tool is not current task goal.
14. Good enough (unit tests) test coverage is 70%.
15. Integration tests should prove, that library is working.
16. First solution can have external command calling (Linux only). Existing scripts in **setmy-info-scripts** and other
    **multi-projects** libraries should be used.

## Goal description

To have Java library, that can grab content (software or just files) from different (1 to any number of repositories)
git repositories (or git repository sub folder) and put them together (no merging with git) under
stealer folder and apply changes (clean/delete, patch, sed or by/with shell script for Linux only) and copy results
under working directory. Can have pre- and post- changes to be applied. Cloned (grabbed) repositories should stay under
stealer folder untouched, mixing should be done in other folders in stealer directory.

### Idea behind that

Like different linux distributors take different software source packages, mostly in src.tar.gz form, un-back them,
apply distributor specific patches and then build these software packages into their distribution and release in binary
form in their package management repositories (yum/dnf repo for example).

Around the world exists a lot of free licensed software in different git repositories. Sometimes some code parts are
needed in some projects and need to grab them. So need to have system, that can do that for us - show repo and
subdirectory where to take these, and what changes should be applied. And after that software is built with these
changed code parts into int. So, "steal" code parts from here ant here, and there, put together and ready to build or
use. Good to have library module for that and also CLI tool.

## Ready

1. ...
2. ...
3. ...
4. ...
5. ...
6. ...

## Draft

1. Config ...
2. Cloning ...
3. Subfolder selection ...
4. Cleanup apply ...
5. Patch files apply ...
6. Sed apply ...
7. ...
8. ...
9. ...
10. ...
11. ...
