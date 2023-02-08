# Maven is SMI main tool

Maven is well documented and stable tool. Things those can be learned are documented. Most of the plugins are made
by maven development team. Maven sets boundaries to stay within - its like standard over all projects.

Gradle has positive side, that is actually also negative side - **customization**. Freedom to change (add, remove)
functionality (re-program, re-configure Gradle behaviour) and boundaries.
Therefore, all these changes should be documented - additional work and **waste**. Usually something are
written team members. These changes, differences should be learned by other development team members or sometimes should
be checked somewhere (from self written docs or directly from changes in Gradle behaviour), check that maybe something
is changed by other team members. Many project, different changes - a deviation from what might be called the standard.
Can't be learned once. All that is **waste** (of time).

Some cases Gradle projects (modules in development organization/unit) have been tried to make similar in Gradle. Usually
ends with hiring a new small team, who makes that Gradle standard component for company. Without hiring that team, the
Gradle "standard" management work is put on developers in that organization. To reach good level in that "standard
Gradle config/reprogram/extension" takes a time (to analyze, how to do that all "correctly").

At the writing time Gradle (7.6) reached some kind of stability - long time haven't changed something. Until that
version constantly something was deprecated.

Usually small Gradle projects have fast build time compared with maven. Bigger Gradle projects have no advantages.

With maven:

* external development team (maven developers) is writing documentation
* some set of maven plugins can be learned once - jumping into any maven project is not so heavy
* stability

Yes, maven can be configured also differently. But still, main line is the same.
For example maven unit and integration tests plugins. Usually developers are not learned maven well and doesn't know,
that these can be simply separated. Then they start to add some configurations and rules for separation. Then these
developers find, Gradle is better, because it can be highly customized. Without learning maven more deeply first!

Why not to push developers to learn these plugins well, so no need to write separate configuration (and maybe
documentation) and rules by self? **We have maven team who made plugin and documented it already for us.**
