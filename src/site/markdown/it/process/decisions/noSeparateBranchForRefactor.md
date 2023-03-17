# No separate software refactor branch

New software branch for new software "style" (new structure and components, split code parts, moved code) with huge
merge conflict possibility should not be created. Use trunk based development with simple as possible feature switches.

Examples:

* Decided do refactor software.
* Change components (one component with another), libraries, tools.
* Change code structure in components, apply other or new design patterns.

It ends **always** with need for new separate team(s). One for **new software** and one for **old software** and
possibly for **merge conflict and broken tests resolving**.

If no team(s) as resources added, multiply other project deadline with **3**.
