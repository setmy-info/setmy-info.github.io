# Should have self (org internal) hosted file servers for for software repos

Should have file servers for binary and textual files (maven repo, CSS, large media files, software installation files,
CDN, ...) at least over SSH, secondly over https.

Minimize risk that some software can't be found ant critical time.

Managed by software team or DevOps.

Examples:

* At writing time Postgis Changed maven repo (or repo was down) and maven build was broken from 18.05.2023. But time is
  what we don't have.
* Some CI builds need testing data. That data goes there, not in git.
* Some software needs some external files (jar, zip, large mpeg, jpeg files) packaged with releasable software, that is
  not hold in git. That can be hold there.
