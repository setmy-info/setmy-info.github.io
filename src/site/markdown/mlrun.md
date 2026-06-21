# MLRun

## Information

MLRun is an open-source MLOps orchestration framework originally developed by Iguazio. It provides an end-to-end
platform for managing machine learning pipelines from data preparation through model training, deployment, and
monitoring.

Key concepts:

* **Projects** — top-level container grouping functions, workflows, artifacts, and models.
* **Functions** — serverless ML code units (Python functions or containers) that can be run locally, on Kubernetes,
  or Spark.
* **Workflows** — directed acyclic pipelines built on top of Kubeflow Pipelines.
* **Feature Store** — manages feature engineering, storage, and serving for training and inference.
* **Model Registry** — tracks model versions, metadata, metrics, and deployment endpoints.
* **Artifacts** — datasets, models, plots, and other outputs tracked with lineage.

## Installation

### Python Package (local / notebook usage)

```shell
pip install mlrun
```

Install with extras for specific runners:

```shell
pip install mlrun[complete]
```

### MLRun Server (Kubernetes)

Deploy the full MLRun platform via Helm:

```shell
helm repo add v3io-stable https://v3io.github.io/helm-charts/stable
helm install mlrun v3io-stable/mlrun-ce \
  --namespace mlrun \
  --create-namespace
```

### Verify

```shell
python -c "import mlrun; print(mlrun.__version__)"
mlrun version
```

## Configuration

### Connect to MLRun Server

```python
import mlrun

mlrun.set_environment(
    api_path="http://mlrun-api:8080",
    artifact_path="v3io:///projects/{{run.project}}/artifacts"
)
```

### Create or Load a Project

```python
project = mlrun.get_or_create_project(
    name="my-project",
    context="./",
    user_project=True
)
```

## Usage, tips and tricks

### Define an MLRun Function

```python
import mlrun

@mlrun.handler()
def train_model(context, dataset_path: str, n_estimators: int = 100):
    import pandas as pd
    from sklearn.ensemble import RandomForestClassifier

    df = pd.read_csv(dataset_path)
    X, y = df.drop("label", axis=1), df["label"]
    model = RandomForestClassifier(n_estimators=n_estimators)
    model.fit(X, y)

    context.log_model("model", body=model, artifact_path=context.artifact_path)
    context.log_result("accuracy", model.score(X, y))
```

### Run Locally

```python
run = mlrun.run_local(
    name="train",
    handler=train_model,
    inputs={"dataset_path": "data/train.csv"},
    params={"n_estimators": 200}
)
print(run.outputs)
```

### Track Experiments

MLRun automatically logs parameters, results, and artifacts for every run. Browse them in the MLRun UI or list them
programmatically:

```python
runs = project.list_runs(name="train", sort_by="accuracy")
```

### Build a Pipeline

```python
from kfp import dsl

@dsl.pipeline(name="training-pipeline")
def pipeline(dataset_path: str):
    prep = project.run_function("data-prep", inputs={"raw": dataset_path})
    train = project.run_function("trainer", inputs={"dataset": prep.outputs["clean"]})
    project.run_function("deployer", inputs={"model": train.outputs["model"]})
```

## See also

* [MLRun documentation](https://docs.mlrun.org/)
* [MLRun CLI reference](https://docs.mlrun.org/en/stable/cli.html)
* [Kubeflow Pipelines](https://www.kubeflow.org/docs/components/pipelines/)
* [MLRun GitHub](https://github.com/mlrun/mlrun)
* [Python](python.md)
* [Kubernetes](kubernetes.md)
