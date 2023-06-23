# TBI

## Information

Like in scrum product backlog item, this is **training backlog item** for ML training backlog and training
sprint/iteration backlog.

TBI contains information about learning and test **data**, NN **configuration** and **code** (SCM - git url) and other
describing data (label, description, changelog, documentation, authors, ...).

Initially for ML Code Deployment Pipeline (ML CDP), Continuous Machine Learning (CML) and
ML Continuous Delivery (ML CD) - ML CI/DI.

## Version 1

* DRAFT 2

### YAML

#### DRAFT 1

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

#### DRAFT 2

Don't need to repeat steps, these can in external tool WF config/setup - BPMN, Argos YAML.
Let's say Camunda is executing ML sprint. For that exists BPMN. Some steps for machines, some automatic and
some are ML steps - all in BPMN. All needed info is in that file and added at WF start - WF or steps configuration.

File naming convention with UUID 1:

**tbi-376bdfaa-1195-11ee-be56-0242ac120002.yaml**

```yaml
name: TBI name
description: TBI description
materials:
    - example.doc
    - https://example.com/document
    - url/uri/path/to/bpmn/file.bpmn (don't repeat, if it is already mentioned in tbi_process_uri)
external_process_engine:
    type: Camunda (can be missing, for passing directly to Jenkins)
    process_id: MLSprint (can be missing, for passing directly to Jenkins)
    config:
        tbi_process_uri: url/uri/path/to/bpmn/file.bpmn (can be missing, for passing directly to Jenkins)
        jenkins_pipeline:
            tbi_vcs_url: https://example.com/tbi/git/repo/with/Jenkinsfile/pipeline.git  (can be missing, Jenkins already have pipeline execution configured)
            tbi_dvc_path: path/to/dvc (ML software config can also be there, because config is also data)
            tbi_code_vcs_path: path/to/dvc_code (ML software to build, or use tbi_training_command and tbi_testing_command)
            tbi_training_command: command (to execute for training)
            tbi_testing_command: command (to execute for testing)
            tbi_config_vcs_path: path/to/config (ML software config to use, can be unset)
            tbi_parallel_execution: true (or false, based on whether parallel execution is desired, but mostly Jenkinsfile responsibility)
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

If no Camunda, directly pass information to Jenkins pipeline (remove type and process_id).
