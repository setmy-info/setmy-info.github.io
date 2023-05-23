# No environment storages (DB, file servers, mail servers, ques) cross usage and cross copy in any direction

Environments should be separated and not used in mixed and crossed way (one environment component is using another
environment component).

People should not talk in machine names, just with environment names.

Examples:

* Coping dev DB to live (or other) is forbidden.
* Using live files servers in dev environment (and vice versa) is forbidden.
