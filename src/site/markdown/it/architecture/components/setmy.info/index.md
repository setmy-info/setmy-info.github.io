# setmy.info

Root mono repo with GIT submodules.

Mostly for Java and Groovy-related modules (libraries).

## Architecture

## Requirements

## Development notes

### Requirements

- Latest OpenJDK
- Latest maven

Refer also architecture notes [Architecture](../../../it/architecture/index.html)

### GIT Repository

Check GIT command documentation about cloning with submodules [GIT](../../../git.html)

First clone:

```sh
git clone --recurse-submodules git@github.com:setmy-info/setmy.info.git
```

### Submodules

Submoduler folder: ./submodules

Submodules contain links to other GIT repositories and can be cloned all once.

*-start-project submodules are starters or seed projects for starting new projects.

setmy-info-scripts is project for Linux and FreeBSD set of scripts.

### Incubation

Incubation, which contains different probes, poc's, spikes before architecture decisions to add to main root folder:
./incubation

### Modules in root folder

Many modules are just placeholder for future plans as pre made components structure.

Most finished or just main libraries are:

- jwt-models
- java-storage
- java-models
- java-services
- groovy-models
- groovy-services

### Other folders and modules

- setmy-info-docker is Docker hierarchy project folder.
- springboot-start-project is Spring Boot starter or seed project.
- tomcat-start-project is web container starter or seed project for Tomcat (as production) and Jetty (development time).

## QA: test guides and specifications

## Release notes

## Deployment notes

## Maintenance

## Lessons learned

1. Tomcat project should start with mvn jetty:run without warnings about dupplicate classes. Should follow top
   libraries (hibernate core, spring core) deps. Tomcat project didnt start, because some method access errors. Dozer,
   esapi, logback, jaxb introduced duplicates hell.
