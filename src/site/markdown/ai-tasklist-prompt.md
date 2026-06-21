# AI Tasklist prompting

## Information

AI tasklist prompting is a structured prompt format for giving AI coding agents precise task definitions. It uses a
Lisp/S-expression notation to encode constraints, module scope, pre-conditions, required outcomes, things to avoid,
and individual task steps in a machine-parseable structure.

The goal is to reduce hallucination and keep AI agents focused on a specific, well-bounded coding task. Instead of a
free-form natural-language prompt, the tasklist format makes constraints and expectations explicit:

* `constraint` — rules the agent must follow (e.g., must stay within a specific file set)
* `pre-condition` — state that must be true before starting
* `required` — what the task must achieve
* `avoid` — changes or patterns the agent must not introduce
* `do-not` — explicit prohibitions
* `task` — individual work item with expected result and build error context

The prompt to the agent is simply a reference to the tasklist file.

## Usage, tips and tricks

Example tasklist (TASKLIST.lisp or TASKLIST.sexp):

```lisp
(task-list
 (constraint "are in updated AGENTS.md")
 (modules "")
 (pre-condition "some ...")
 (required "To ...")
 (avoid "... changes")
 (do-not "change ...")
 (example "...")
 (task
  (actual "")
  (required "To ...")
  (to-do "...")
  (result "")
  (npm-build-error-message "")
  (mvn-build-error-message "")
  (node-build-error-message "")
  (java-build-error-message "")
 )
)
```

Prompt given to the AI agent:

```
Follow TASKLIST.md
Follow TASKLIST.lisp
Follow TASKLIST.sexp
```

### Tips

* Keep each `task` entry focused on a single change to allow the agent to verify success before moving on.
* Use `avoid` and `do-not` to prevent the agent from refactoring unrelated code.
* Include expected build error messages so the agent knows what a broken state looks like.
* Store TASKLIST files in version control alongside the code they describe.

## See also

* [AI Agent](agent.md)
* [Model Context Protocol (MCP)](mcp.md)
* [AI](ai.md)
