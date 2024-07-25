# Stealer backlog

## Skills

1. Linux
2. CMake
3. Bourne shell

## Software development services expected

1. Development and production helpers shell scripts writing and building with CMake, make and rpmbuild.
2. Different software domains have scripts under submodules/folders in single repo.
3. 3 times code reviews and fixes round.
4. Setup not needed, buildable project is ready. Only coding.
5. Constant communication in Slack

## Deadline

Withing few months. Best price proposal wins.

## Prerequisites and requirements

1. Repository: **git@xxxx** in [GitHub](https://github.com/xxxxxxxx)
2. Branch: **develop | master | epic**
3. All rights to code goes to buyer. Software goes public under MIT license.
4. The work is done under a contractor agreement, not an employment contract.
5. No documentation required.

## Goal description

...

### Idea behind that

...

## Ready

1. ...
2. ...
3. ...
4. ...
5. ...
6. ...

## Draft

1. ...
2. ...
3. ...
4. ...
5. ...
6. ...

1. Prepare folder structure (like modulith) in monorepo for different software component areas (submodules)
2. Prepare CMake files as done for other similar submodules
3. Fix the Bourne shell scripts where variable assignment using command output occurs
4. Make build and build output rpm installation should install software correctly

1. Submodules are: **term**, **pki**, **crm**, **infra**, **python**, **jail**, **packages**, **base**, **workstation**,
   **vcs**, **cloud**, **virtualization**, **tools**
2. Example sub modules are: **docker**, **diskless**, **selenium**
3. All similar ETC_LOCATION=`smi-localhost-location` should be changed to ETC_LOCATION=$(smi-localhost-location)
4. Only folder structure preparation, no existing file moves needed.
