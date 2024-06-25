# Requirements from process, roles, artifacts for branching and issue management

## Developers

1. Fewer branches to remember. And which is base branch (max 3 branches). Reason: Developer can produce many branches at
   development for refactor, adding tests, etc. And one change needed between different tasks. Branching-merging order
   hell.
2. Fast merge - max 2 hours (because of point 1). Problem: developers can produce 5-10 PR in a day, with proper refactor
   habits, but developer can handle 2 PR at the same time.
3. Constant refactoring have to be made, unless Business point 1. That means, current point is relevant until hou have
   possibility to stop enhancements adding **at least** for 1 month (what ever it takse to refactor - 6 months?).

## QA

1. Master should have quality checked code (reviewed, tested, other measurements).

## Business

1. Should be possible to add new requirements and bug fixes constantly by wish and need. Enhancements adding should not
   stop.
2. Enhancements should be released in any order.

## Environment

1. Should be auto deployed to dev, test automatically and pre-live, live by user interaction.
2. Developer should get constant and full (all automatic tests are executed) feedback for task under development.

## Process

1. In issue management item should get correct status by process.
2. Process have to be followed.
