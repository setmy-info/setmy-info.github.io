# DeepSpeed

## Information

`DeepSpeed` is Microsoft's framework for efficient distributed training of very large models. It is well known for its
`ZeRO` optimization stages (`1` to `3`), which distribute parameters, gradients, and optimizer state across multiple
GPUs so larger models can be trained more efficiently.

It is especially relevant for very large models, including `70B+` scale workloads that may need to offload part of the
memory demand to CPU or `NVMe`.

## Common use cases

* large-scale distributed model training,
* multi-GPU and multi-node fine-tuning,
* memory optimization for very large models,
* and enterprise or research workloads that exceed the limits of simpler single-node training setups.

## Practical note

`DeepSpeed` becomes especially important when model size and memory pressure are the main bottlenecks. It is less about
beginner simplicity and more about scale, efficiency, and systems-level control.

## See also

* [LLM](llm.html)
* [Axolotl](axolotl.html)
* [Colossal-AI](colossal-ai.html)
