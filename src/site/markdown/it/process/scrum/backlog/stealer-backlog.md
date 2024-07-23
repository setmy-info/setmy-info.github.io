# Stealer backlog

## Offer

### Skills

1. Linux
2. Java
3. Maven
4. Lombok
5. Unit & Integration Testing with JUnit 5, Mockito and AssertJ
6. git, diff (optional), patch and sed commands
7. Understanding singleton pattern, in pure Java

### Software development services expected

1. Data class models and service implementation
2. Demo: Unit and integration tests as proof

####

## Detailed prerequisites and requirements

1. Repository: **git@github.com:setmy-info/setmy.info.git** in [GitHub](https://github.com/setmy-info/setmy.info) as
   **multi-projects** monorepo
2. Branch: **develop**
3. **Java 21** (OpenJDK) or **multi-projects** property **java.version**
4. Modules to development: **java-vcs**, **java-staler**
5. **Lombok**, **JUnit 5**, **Mockito**, **AssertJ** and modules dependencies only.
6. Prepare(d), fix and change repo A: **git@github.com:setmy-info/stealer-test-a.git**
7. Prepare(d), fix and change repo B: **git@github.com:setmy-info/stealer-test-b.git**
8. Stealer folder: **.stealer**  in working directory
9. Latest **Rocky** or **Fedora** Linux. Should run also on **Windows** (use git msys shell).
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
17. Mutation tests (optional) coverage is 70%.
18. Apply clean code rules.
19. In meta/allegorical language: [{ url, branch, subdirectory }, {...}]
20. What is best order: clone, cleanup, subfolder prepare, patch or by request object - order and implementation
    developer decision.

## Goal description

To have Java library, that can grab content (software or just files) from different (1 to any number of repositories)
git repositories (or git repository subdirectory) and put them together (no merging with git) under
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
use. Good to have library module for that and also CLI tool or maven plugin, that executes at
[generate-sources](generate-sources) phase.

## Ready

1. ...
2. ...
3. ...
4. ...
5. ...
6. ...

## Draft

1. As a library user I want to fill an immutable request/command object with multiple Git URLs (mandatory), each
   accompanied by a branch (optional) and a subdirectory (optional), so that I can later pass it to the service for
   processing.
2. As a library user I want to pass the request/command object to a service that performs git clone operations and
   branch checkouts into a designated stealer directory, ensuring the directory
   structure remains immutable. For example ./.stealer/clones/stealer-test-a
3. As a library user I want the service to perform cleanup operations as specified by cleanup commands included in the
   request/command object, so that the output is organized, for example into: ./.stealer/cleaned/stealer-test-a,
   directly with subdirectory content, if specified.
4. As a library user I want the service to apply patches as specified by patch files included in the request/command
   object, so that the output is organized, for example into: ./.stealer/patched/stealer-test-a.
5. As a library user I want the intermediate results of processing multiple repositories to be stored in the
   ./.stealer/final directory.
6. I want the final results to be available in the working directory
