# OpenShell

## Information

`OpenShell` is an open-source sandboxing platform from `NVIDIA` for running AI agents and agent-related workloads in
more isolated environments.

It is designed to reduce risk when agents use tools, access files, or interact with external systems.

### What is it for?

Typical `OpenShell` use cases include:

* isolating AI agents inside controlled sandboxes
* applying security boundaries around tool use and local execution
* managing safer environments for agent experimentation and operations
* supporting long-running or always-on agent workloads with stronger controls
* serving as the sandboxing foundation for higher-level stacks such as `NemoClaw`

## Usage

`OpenShell` is relevant when teams want stronger isolation for agent systems than a normal host runtime provides. It is
especially useful for AI agents that execute commands, access local resources, or integrate with external services and
therefore need tighter operational and security boundaries.

## Similar Software

* **[NemoClaw](https://github.com/NVIDIA/NemoClaw):** A higher-level reference stack that builds on `OpenShell`.
* **[Docker](docker.md):** General-purpose containerization platform often used for application isolation.
* **[Kubernetes](kubernetes.md):** Container orchestration platform that can be part of secure runtime architectures.

## See also

* [OpenShell GitHub](https://github.com/NVIDIA/OpenShell)
* [OpenShell Documentation](https://docs.nvidia.com/openshell/latest/)
* [NemoClaw](nemoclaw.md)
* [AI](ai.md)
* [AI Agent](agent.md)
* [LLM](llm.md)