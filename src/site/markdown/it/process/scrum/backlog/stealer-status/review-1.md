# Stealer status review 1

### 1

I consider first Code review done, but that not correct way to do it.

For code review have to pull request have to be made, so reviewer can write code review results into pull request (
GitHub pull request) for example - that is code review nowadays.
In case of communication problems, we need to do it properly. Next time when we have problems we need to
skip demo and code review. I can't accept such form of code reviewing.
I suggest GitHub pull request, and I write there code review results. Demo by you and writen feedback from me does
not need my microphone. Just in case I can still to do one more review.

I want to see code review diff - that is the main tool from GitHub for reviewing the code. Also add comments to the
source code lines.

Suggest any other form, that is supporting these two. Something setup on your computer to demo diffs and then I can add
comments.

### 2

Prepare more detailed demo.

Tests (Requirements in stealer-backlog.html) haven't demod for review. Test should prove code is working.
**mvn clean install** should work for example or other trick I ask to do.

IntelliJ tests was not executed for demo. Next time execute tests with debug mode and breakpoints (all lines
in doSteal method), and show final folder - at beginning empty, at breakpoints files are appearing.

Main code changes haven't demod for review. Demo: What was done? How was done? What are changes made? Line by
line.

And final result folder should be demod with final content after **mvn clean install** command execution.

### 3

In StepConfig patch files list was missing. As we discussed.

Need to be added to pass patch files list locations. Patch files list
have
to be added from test (hard coded into test).
Like:

```java
final List<String> patchFiles = new ArrayList<>();
patchFiles.

add("./src/test/resources/patch-files/patch.a");
```

etc. Requirements in stealer-backlog.html document Draft section point 4.

### 4

If code is searching and using config.yaml - that is not correct and was not in requirements list. That is out of the
scope. That is CLI project scope. Requirements in stealer-backlog.html document point 14.

### 5

If code is recursively searching patch files, then is not correct. Was not in requirements list. That is out of the
scope. That is CLI project scope.

### 6

If code is using Snakeyaml - that is not correct. Was not in requirements list. That is out of the scope. That is CLI
project scope.

### 7

If pom.xml dependencies are added, then that is not correct. All needed is already there.

### 8

Meetings are too often, for such task. My time is therefore too much in this project. Task should be ready for demo!

Then I do review. Let's do this time Sunday again, but then switch to once a week. It is turning to teaching and
teaching was not in the plans, as we discussed.

### 9

Read requirements carefully. Requirements in stealer-backlog.html. Check and prove, that all is done.

### 10

When you are planning to demo whole work? Deadline? That have to be written form to me. As I Understand from
previous conversations, it is almost ready. But currentlyI'm not so sure, what the status really is.

### 11

Requirements in stealer-backlog.html document points 7. and 8. need to be used. Is there something to fix (if
defect) or change?

### 12

Squashing (single commit) was not allowed. No-squash means multiple commits by you and often. History is visible.

### 13

How Patch is executed? It should go through java-exec.

### 14

Late minute questions are not good. We should cancel meeting, when no prepared.

### 15

doChange(stealerConfig); is out of scope, as we discussed.

### 16

For demo need to learn some basics IntelliJ short keys and moving around back forward. Into class, into method.

### 17

User stories (Draft section) are left without focus. Just started to work, like task is understood, but actually not.

### 18

Notes about Executor exists from the date:  27. July 2024.

java-vcs works top on that. Notes about java-vcs is in documents from 22. July 2024.

Executor simplifies the work and also narrows down task implementation (task scope).

```
commit 18e373a6e0dcd5a1661c4bd41c0d46838a8c577e
Author: Imre Tabur <imre.tabur@mail.ee>
Date:   Sat Jul 27 21:16:18 2024 +0300

    Execution notes

 src/site/markdown/it/process/scrum/backlog/stealer-backlog.md | 1 +
 1 file changed, 1 insertion(+)

C:\sources\setmy.info\submodules\setmy-info.github.io>git bisect reset
Previous HEAD position was 18e373a Execution notes
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
```

```
git diff 18e373a6e0dcd5a1661c4bd41c0d46838a8c577e~1..18e373a6e0dcd5a1661c4bd41c0d46838a8c577e
```

```
diff --git a/src/site/markdown/it/process/scrum/backlog/stealer-backlog.md b/src/site/markdown/it/process/scrum/backlog/stealer-backlog.md
index 5ecd332..14df7d5 100644
--- a/src/site/markdown/it/process/scrum/backlog/stealer-backlog.md
+++ b/src/site/markdown/it/process/scrum/backlog/stealer-backlog.md
@@ -68,6 +68,7 @@ Withing few months. Best price proposal wins.
 1. java-vcs with git cloning, checkout functionality. Example code exists.
 2. Maven wrapper. Build should go smoothly.
 3. A and B repos with content prepared.
+4. Command execution code is ready: Executor

 ## Goal description
```

```
git diff 9bc52cfa~1..9bc52cfa
```

### Conclusion

Prove through tests, that code is working - that is in the requirements list. Demo tests, through breakpoints and show
output directory appearance at breakpoint moments.
Please follow requirements document more, then you can also ask correct questions. Hold it under focus.
