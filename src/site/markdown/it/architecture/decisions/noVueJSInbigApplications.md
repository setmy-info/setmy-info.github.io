# No VueJS in big or huge applications.

VueJS can be used only as simple one HTML SPA.

Examples:

Helping to decide, is it big or not:

* When npm or yarn is needed, then project is too big to use VueJS. This is decision point before starting such project
  and some predictions is needed.
* When everything fits into one HTML file and can be handled and changed in meaningful time, then use VueJS.

We've experienced some issues: **vendor lock-in** and too **long fix times** (probably **attitude and focus problem**) -
merge request code review and tests were done with too much waiting (sometimes infinite waiting).
