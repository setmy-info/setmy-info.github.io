# Developer first

Software default setup/config, build steps, options, etc are simple as possible - by default for developer.

Examples:

* NOT developer first: **mvn -Ddeveloper_should_set_value=true clean install**
* Developer first: **mvn clean install**

First one should be documented (additional work), then learned by newcomers. Different module can have different setup,
therefore more writing and learning.
Second one doesnt need documenting (it is docmented by others, externals, by maven develpers). Newcomers probably knows
already maven. Less to remember.
