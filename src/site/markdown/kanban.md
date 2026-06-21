# Kanban

## Information

Kanban is a visual workflow management method that originated in Toyota's production system in the 1940s and was
adapted to knowledge work by David J. Anderson around 2007. The core idea is to make work visible, limit the amount
of work in progress, and continuously improve flow.

### Core Practices (Anderson's Six Practices)

1. **Visualize** — represent work items on a board with columns for each workflow state.
2. **Limit WIP** — set maximum work-in-progress limits per column to reduce multitasking and expose bottlenecks.
3. **Manage flow** — monitor and optimize how work moves through the system.
4. **Make policies explicit** — document column definitions, acceptance criteria, and escalation rules.
5. **Implement feedback loops** — regular cadences (daily standup, replenishment, retrospective).
6. **Improve collaboratively** — use models and the scientific method to evolve the system incrementally.

### Typical Board Structure

```
| Backlog | To Do | In Progress | Review | Done |
|---------|-------|-------------|--------|------|
|         |  WIP≤5|    WIP≤3    |  WIP≤2 |      |
```

### Kanban vs Scrum

| Aspect          | Kanban                              | Scrum                            |
|-----------------|-------------------------------------|----------------------------------|
| Cadence         | Continuous flow, no fixed sprints   | Fixed-length Sprints (1–4 weeks) |
| Commitment      | No iteration commitment             | Sprint commitment                |
| Roles           | No prescribed roles                 | PO, SM, Dev Team                 |
| Change          | Can change priorities at any time   | Changes discouraged mid-Sprint   |
| Best for        | Operations, support, ongoing work   | Feature development, new products|

## Usage, tips and tricks

### WIP Limits

WIP limits are the most powerful Kanban practice. When a column reaches its limit, team members stop pulling new work
and instead help finish existing items. This reduces context switching and makes bottlenecks visible.

### Metrics

* **Cycle time** — elapsed time from work starting to delivery. Lower and predictable is the goal.
* **Throughput** — number of items completed per time period. Use to forecast delivery.
* **Cumulative Flow Diagram (CFD)** — visualizes queue sizes over time; bands widening indicate bottlenecks.

### Tools

* Physical board — sticky notes and columns on a wall or whiteboard.
* Jira — configurable Kanban boards with WIP limit support.
* Trello — simple drag-and-drop boards.
* GitHub Projects — Kanban-style boards linked to issues and PRs.
* Linear — developer-focused with Kanban and cycle options.

### Classes of Service

Define different lanes for different priority levels (e.g., Expedite, Standard, Fixed Date, Intangible) so that urgent
items can bypass normal flow without disrupting the whole board.

## See also

* [Kanban University Guide](https://kanban.university/kanban-guide/#download)
* [Kanban Guides](https://kanbanguides.org/)
* [Scrum Guide](https://scrumguides.org/)
* [eduScrum](eduscrum.md)
