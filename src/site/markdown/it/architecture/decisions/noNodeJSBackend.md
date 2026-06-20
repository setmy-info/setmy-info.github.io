# No Nodejs backend

<!-- REVIEW: R-03 — this prohibition conflicts with Angular SSR (adr-0030, angular.md) which runs a Node.js server process; boundary not defined -->
NodeJS NPM packages are the heaviest object in universe and simple to create and push to for public usage.
Therefore, it is simple to find and take one of these (buggy and maybe attacker prepared) into project.

Maven repos in other hand have at leas simple background check (for organizations, maybe now persons to)
so responsible person can be exposed. At least some obstacle in the path of attack vector planning.

A lot of security problems, cant fix by self. Too deep dependencies, un-compatibility problems, etc.
