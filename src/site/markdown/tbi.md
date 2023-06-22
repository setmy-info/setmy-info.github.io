# TBI

## Information

Like in scrum product backlog item, this is **training backlog item** for ML training backlog and sprint/iteration
training backlog.

TBI contains information about learning and test **data**, NN **configuration** and **code** (SCM - git url) and other
describing data (label, description, changelog, documentation, authors, ...).

## Configuration

### YAML

DRAFT:

```yaml
name: TBI name
description: TBI description
materials:
    - example.doc
    - https://example.com/document
steps:
    -   name: Data gathering
        workloads: Description about what, how, where todo, information for implementation
    -   name: Data preparation
        workloads: Description about what, how, where todo, information for implementation
    -   name: Training
        workloads: Description about what, how, where todo, information for implementation
        dvc: file:///example/dvc/pth
    -   name: Result analysis
        workloads: Description about what, how, where todo, information for implementation
    -   name: Documentation
        workloads: Description about what, how, where todo, information for implementation
changelog:
    added:
        - Added example thing
    removed:
        - Removed example thing
    changed:
        - Changed example thing
authors:
    - Imre Tabur <imre.tabur@mail.ee>
```

Some steps are for human intervention some for training pipelines. Training is for training automated pipeline.

## Usage, tips and tricks

### Coding tips and tricks

## See also

[xxxx](yyyyy)
