# Model first analysis

**DRAFT**

Model first analysis is a methodology focused on defining the core entities and their relationships before diving into
detailed process or transformation logic. It emphasizes understanding the static structure and lifecycle of data objects
across systems.

## Identifying Objects and Participants

The initial phase involves determining the primary objects and the actors (participants) involved in the system.
This includes:

- **Objects:** The core entities that represent data or state.
- **Participants:** Systems, users, or agents that interact with or own these objects.
- **System Boundaries:** How objects move between different systems and where they reside.

## Composition, Dependencies, and Lifespan

Once the objects are identified, the analysis deepens into their structure and relationships:

- **Composition:** How objects are built from smaller parts or other objects.
- **Dependencies:** How objects rely on each other (e.g., an Order depends on a Customer).
- **Lifespan:** The creation, update, and deletion (or archival) cycle of an object relative to others.

## Constraints and Sizes

Defining the physical and logical boundaries of objects:

- **Logical Constraints:** Business rules that limit the state or value of an object (e.g., "age must be > 18").
- **Physical Sizes:** Estimating the size of objects for storage, memory, and transmission purposes (e.g., maximum
  string lengths, collection sizes).

## Detailed Lifecycle Analysis

After the high-level modeling, the process focuses on the dynamic aspects of the objects:

- **Movement:** How and when objects are transferred between components or systems.
- **Transformation:** How objects change their structure or state (e.g., from an input DTO to a persistent Entity).
- **Storage:** Where and how objects are persisted (databases, caches, file systems).
- **Validation:** Ensuring objects meet all constraints before being stored or moved.
