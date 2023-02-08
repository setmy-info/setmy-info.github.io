# No secrets in main repo

Main project (application, library, microservice, module, ...) VCS (Git, Mercurial, SVN, ...) repository should not
contain secrets from administrators and DevOps. They should hold these somewhere else (other repo, secrets
store/vault).

Examples:

* No usernames, passwords and other secrets in VCS (in base64 or even in crypted form). CI should not start work for
  such encrypted data commits.
* Possibly no admins/devops configuration as well. Main repo holds placeholders or similar.

Code review, merge/pull request looks strange for encrypted data.

Main repo holds placeholders for such data (for example ${PASSWORD} or similar).

Main repo should hold main functionality - that's the main thing. Not strange things (encrypted), that are actually
hidden for review data.

Maybe a lot of commits with encrypted data and maybe CI starts work for these commits. These should be avoided.
