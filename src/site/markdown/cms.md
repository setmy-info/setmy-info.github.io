# Content management system

## Information

A Content Management System (CMS) is software that allows users to create, manage, and publish digital content without
requiring deep technical knowledge. It separates content from presentation and typically provides a web-based editing
interface.

### CMS Categories

| Category              | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| **Traditional/Coupled** | Frontend and backend are tightly coupled (e.g. WordPress, Drupal)         |
| **Headless**          | Backend-only content API; frontend is completely separate (e.g. Contentful, Strapi) |
| **Decoupled**         | Has a traditional frontend but also exposes APIs for alternative frontends  |

### Content Repository API for Java (JCR)

JCR is a standard Java API for accessing content repositories. It abstracts the storage backend and provides a
tree-based content model with nodes and properties.

Key specifications:

* **JSR-170** (JCR 1.0, 2002) — first standard, read/write access to content repositories.
* **JSR-283** (JCR 2.0, 2009) — added access control, node type management, observations, and locking improvements.

Core JCR concepts:

* **Repository** — the root storage container.
* **Workspace** — a named space within the repository; repositories can have multiple workspaces.
* **Node** — a tree element that can have child nodes and properties.
* **Property** — a named value (string, date, binary, etc.) attached to a node.
* **Node Types** — define allowed children and properties for nodes (similar to a schema).
* **Versioning** — built-in version history for nodes via the version manager.
* **Queries** — supported query languages: **JCR-SQL2** (SQL-like) and **XPath**.

Example JCR-SQL2 query:

```sql
SELECT * FROM [nt:base] WHERE [jcr:title] = 'Home'
```

Apache Jackrabbit is the reference implementation of JCR. It runs embedded or as a standalone server.

## Configuration

Apache Jackrabbit configuration (`repository.xml`) controls persistence managers, search indexing, and access control.
For embedded usage in a Java application:

```xml
<Repository>
    <Workspaces rootPath="${rep.home}/workspaces" defaultWorkspace="default"/>
    <Workspace name="${wsp.name}">
        <PersistenceManager class="org.apache.jackrabbit.core.persistence.bundle.BundleFsPm"/>
    </Workspace>
</Repository>
```

## Usage, tips and tricks

### JCR vs a Simple Database

Use JCR when:

* content has a deeply hierarchical or tree-like structure,
* built-in versioning, access control, and full-text search are needed,
* content may be reused across multiple channels (headless publishing).

Use a relational database when:

* data is tabular and well-defined,
* complex relational queries or joins dominate,
* you need transactions across many independent entities.

### Common JCR Operations (Java)

```java
Repository repository = new TransientRepository();
Session session = repository.login(new SimpleCredentials("admin", "admin".toCharArray()));
Node root = session.getRootNode();
Node article = root.addNode("article", "nt:unstructured");
article.setProperty("title", "Hello JCR");
session.save();
session.logout();
```

## See also

* [Content Repository API for Java](https://en.wikipedia.org/wiki/Content_repository_API_for_Java)
* [jackrabbit](https://jackrabbit.apache.org)
* [jackrabbit FAQ](https://jackrabbit.apache.org/jcr/frequently-asked-questions.html)
