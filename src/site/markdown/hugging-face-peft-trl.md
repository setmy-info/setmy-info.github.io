# Hugging Face PEFT / TRL

## Information

`Hugging Face PEFT` and `TRL` are core libraries commonly used as the default foundation for adapter-based fine-tuning
and alignment workflows.

`PEFT` provides efficient adaptation methods such as `LoRA`, `QLoRA`, and `DoRA`, while `TRL` adds trainers for
workflows such as `SFT`, `DPO`, `GRPO`, and `PPO`.

Many higher-level tools use these libraries underneath, which makes them important to understand even when you mainly
work through other frameworks.

## Common use cases

* adapter-based fine-tuning,
* supervised fine-tuning and preference optimization,
* custom Python training pipelines,
* and building your own LLM training stack on top of widely adopted libraries.

## Practical note

If you want the most flexible and widely recognized base layer for modern open-model fine-tuning, `PEFT` and `TRL` are
often the most important libraries to learn first.

## See also

* [LLM](llm.html)
* [LLaMA-Factory](llama-factory.html)
* [TorchTune](torchtune.html)
