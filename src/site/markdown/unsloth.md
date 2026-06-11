# Unsloth

## Information

`Unsloth` is a fine-tuning toolkit focused on very fast and memory-efficient training on a single GPU. It is commonly
highlighted for reaching up to roughly `5x` faster training and around `70%` lower memory usage in suitable workflows,
which makes it especially attractive for practical experimentation on limited hardware.

It supports popular model families such as `Qwen`, `Llama`, `Mistral`, and `Gemma`.

## Common use cases

* single-GPU fine-tuning experiments,
* efficient `LoRA` and `QLoRA` style adaptation on limited hardware,
* quick prototyping for local or workstation-based model customization,
* and developer workflows where speed and low VRAM usage matter more than large distributed training setups.

## Practical note

The open-source edition is mainly focused on single-GPU usage. If you need multi-GPU scaling, review the current
commercial feature split and licensing terms before building production workflows around it.

## See also

* [LLM](llm.html)
* [TorchTune](torchtune.html)
* [Axolotl](axolotl.html)
