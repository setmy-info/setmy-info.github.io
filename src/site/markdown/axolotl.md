# Axolotl

## Information

`Axolotl` is a production-oriented LLM training and fine-tuning framework widely used for multi-GPU and multi-node
training. It supports many of the main modern training methods, including `LoRA`, `QLoRA`, `DPO`, `GRPO`, and broader
`RLHF`-style workflows.

One of its practical advantages is a `YAML`-based configuration style that makes experiments easier to reproduce,
review, and share across teams.

## Common use cases

* multi-GPU fine-tuning,
* repeatable team-based training pipelines,
* preference optimization and alignment workflows,
* and production environments where structured configuration matters.

## Practical note

`Axolotl` is often a better fit when you want stronger distributed-training support and cleaner reproducibility than a
small single-GPU experimentation stack provides.

## See also

* [LLM](llm.html)
* [Unsloth](unsloth.html)
* [DeepSpeed](deepspeed.html)
