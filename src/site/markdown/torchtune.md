# TorchTune

## Information

`TorchTune` is a PyTorch-native solution for fine-tuning and experimenting with modern LLMs, especially in ecosystems
close to Meta model workflows. It supports methods such as `DoRA` and `PPO` for `RLHF`-related training and includes
optimization paths such as `PyTorch 2.5` compilation, which can provide roughly `20-24%` speed improvements in the
right scenarios.

## Common use cases

* custom PyTorch-based fine-tuning,
* Meta-model oriented experimentation,
* `RLHF` and adapter-training workflows,
* and teams that prefer writing or extending their own training code instead of relying only on higher-level wrappers.

## Practical note

`TorchTune` is a good fit for PyTorch developers who want more direct control over training code while still using a
purpose-built LLM training toolkit.

## See also

* [LLM](llm.html)
* [Hugging Face PEFT / TRL](hugging-face-peft-trl.html)
* [LitGPT](litgpt.html)
