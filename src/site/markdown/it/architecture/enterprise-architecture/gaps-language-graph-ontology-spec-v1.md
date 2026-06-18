# gaps-language-graph-ontology-spec-v1.md

## Status

**DRAFT**

## Purpose

gaps-language (Gaps) is a minimal, human-readable declarative language for describing a structured world model
consisting of entities, relationships, belonging scope, and lifecycle rules.

The language does NOT describe databases or implementation details directly. Instead, it defines a
**semantic model of reality**, from which systems such as graph databases, UI visualizers, and query engines can be
derived.

Influenced by BDD Gherkin language.

## Design Philosophy

This language system models reality. Reality is always from a short scope or view point of view in hierarchy and in a
long scope graph. Also set theory, where entity can belong to set(s). Sets are types.

Graph databases, SQL schemas, Liquibase scripts, or UI structures are derived from projections of this model.

The World contains Countries. Country contains Cities (Cities belong to Country). Country contains Persons (Person
belongs to Country). Companies belong | in | into | under Country. Person under Company. Person under Country as
Citizen.

## Specification

### Sentences

1. **Y can have many of X**
2. **Y can have none of X**
3. **Y can have single of X** – perhaps need to thin abut word "can"
4. **X is enumerative**
5. (?) **X is deleted when it does not belong anywhere**
6. (?) **Delete X only if X has zero active references**
7. (?) **Delete X when no any parents**
8. (?) **Delete X when no any parents. Delete X when no Y parent**
9. **X is small**
10. **X is big**
11. **X is huge**
12. **X is under Y as Z**
13. (?) **X is a synonym of Y**
14. **Entity X**
15. **X contains Y**

* Separate sentences 1-3 together cover:
    * X is under Y, and Y can have zero or more of X. Leaving some of these sentences in or out, we can combine from
      these three some relation criteria (multiplicity constraints).
    * X belongs to set Y.
    * Relaton can be null. In some other caes it cant be null.
* Sentence 4
    * say that X can't be deleted, in case when the parent is deleted. Destructing Y should not destruct/delete X when X
      is under Y.
* Sentence 9 says:
    * It can be taken into memory, handled in memory, enough to process in memory
* Sentence 10 says:
    * It is stored enough big dataset/collection that elements are better to handle in DB (paging, iterations)
* Sentence 11 says:
    * It is stored enough big dataset/collection that even inside DB it is hard to handle, time-consuming, DB change
      consuming, etc. Some performance strategy needs to be applied. Partitioning, ...
* Sentence 12 says:
    * X is under Y, and it has relation as Z. For example, Person is under Country as Citizen. Person under Country as
      Location
* Sentence 15 says:
    * Entity data collection, what else it contains. Perhaps OOP inheritance, discrimination needs.

## Core Relationship Syntax

All structural relationships are expressed using a single canonical form:

A belongs to B

This is the primary structural primitive.

It defines:

- Hierarchy
- Ownership scope
- Lifecycle dependency context

## Core Principle

The world is composed of:

- Entities
- Relationships are always hierarchical
- Belonging scope
- Lifecycle rules

**Existence is not intrinsic. Existence is derived from belonging.**

## Belonging Semantics

Belonging defines:

- Where an entity exists in the structure
- What it is attached to
- Whether it is part of a lifecycle chain

Belonging is the only relationship type that influences existence.

## Global Lifecycle Rule (Orphan Rule)

X is deleted when it does not belong anywhere

Meaning:

- If X has no active belonging relationships → X is deleted
- If at least one belonging relationship exists → X survives

This is a membership-based survival rule, not a strict tree rule.

## Relationship Types

### BELONGS (Structural ownership scope)

A belongs to B

- Defines hierarchy
- Counts for lifecycle rules
- Defines structural location of X

### REFERENCES (Non-ownership link)

A references B

- Does NOT affect lifecycle
- Does NOT count as belonging
- Used for lookup, association, or pointing

### RELATED (Generic association)

A is related to B

- No hierarchy implied
- No lifecycle impact
- Pure semantic connection

### ENUMERATIVE (Global shared entity)

X is enumerative

- X does not belong to any parent
- X exists globally and is shared
- X is NOT subject to belonging-based deletion rules

Examples:

- Country
- Currency
- Role

### COMPOSITION (Strong ownership)

A is an inseparable part of B

- Strong ownership relationship
- A exists only within B
- If B is deleted → A is always deleted (cascade)

## Lifecycle Rules

### Default Lifecycle Rule

If not explicitly defined:

- Only belonging relationships define survival

### Cascade Deletion (Composition)

A is an inseparable part of B

- If B is deleted → A is deleted

### Leave Behavior (Weak relationship)

- Relationship may disappear
- Entity remains alive

### Enumerative Exception

X is enumerative

- Excluded from belonging-based deletion rules
- Globally persistent entity

## Orphan Rule

X is deleted when it does not belong anywhere

Important clarification:

- “Belong” means ONLY belonging relationships
- Not references
- Not generic relationships

## Multi-Parent Rules

Entities may have multiple parents.

Rules:

- If at least one belonging parent exists → the entity survives
- If all belonging parents are removed → the entity is deleted

## Semantic Layers

| Type        | Meaning                     |
|-------------|-----------------------------|
| belongs     | structure + lifecycle scope |
| references  | non-lifecycle linkage       |
| related     | neutral association         |
| enumerative | global shared entity        |
| composition | strong ownership + cascade  |

## Mental Model

- it belongs → where an entity lives
- references → what it points to
- related → general connection
- enumerative → global concept
- composition → inseparable part

## Final Principle

Existence is not a property of an entity.

Existence is a consequence of belonging.

## QA CHECKLIST (Coverage Validation)

Use this checklist to validate whether the language fully covers required modeling capabilities.

### Structural Coverage

- [ ] Can represent a simple hierarchy (A belongs to B)
- [ ] Can represent multi-parent relationships
- [ ] Can represent non-hierarchical relationships
- [ ] Can distinguish ownership vs. non-ownership links
- [ ] Can represent global/shared entities (enumerative)

### Lifecycle Coverage

- [ ] Can delete an entity when it has no belonging relationships
- [ ] Can preserve an entity with at least one active belonging
- [ ] Can define strong ownership (cascade delete)
- [ ] Can define weak relationships (no lifecycle impact)
- [ ] Can handle multi-parent survival logic

### Semantic Clarity

- [ ] “belongs” is unambiguous in meaning
- [ ] “references” does not affect the lifecycle
- [ ] “related” is semantically neutral
- [ ] “enumerative” is globally scoped
- [ ] “composition” implies strict ownership

### Edge Case Coverage

- [ ] Orphan entities are correctly handled
- [ ] Multiple parents do not break lifecycle rules
- [ ] Deletion does not incorrectly propagate through references
- [ ] Enumerative entities are never accidentally deleted
- [ ] Composition does not conflict with references

### Consistency Checks

- [ ] No relationship type overlaps in meaning
- [ ] Every entity is explainable via belonging or enumerative rule
- [ ] Lifecycle rules are deterministic
- [ ] No ambiguous deletion scenario exists
- [ ] All relationships resolve into graph representation

### System Completeness

- [ ] Can generate Graph DB schema
- [ ] Can generate UI graph visualization
- [ ] Can support query engine derivation
- [ ] Can support rule validation engine
- [ ] Can support versioned world model evolution
