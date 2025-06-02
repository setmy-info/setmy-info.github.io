# GIT

## Installation

## Usage, tips and tricks

```shell
mkdir my-project.git
cd my-project.git
git init --bare my-project.git
```

Set and check name and email for git.

```shell
git config --global user.name "Imre Tabur"

git config --global user.email imre.tabur@mail.ee

git config --global user.email

git config --global user.name

git config --global --add --bool push.autoSetupRemote true

git config --global init.defaultBranch master

git config --global url."https://github.com/".insteadOf "git@github.com:"

git config --global --unset url.https://github.com/.insteadof
#[url "https://github.com/"]
#    insteadOf = git@github.com:

git remote set-url origin NEW_URL

git config --global --list
```

```shell
git config --global core.editor "'c:\Program Files\Notepad++\notepad++.exe' -multiInst -notabbar -nosession -noPlugin"

git config --global core.editor nano

git config --global core.commentchar "$"

git config --global core.autocrlf true

# Should be on Windows
git config --global core.autocrlf false

git config --global core.autocrlf input

# Also that on Windows
git config --global core.safecrlf false

git config --global merge.tool meld

git config --global mergetool.meld.path "c:\Program Files (x86)\Meld\Meld.exe"

# Show remote origin repo url
git config --get remote.origin.url

git remote -v

git remote rename OLDNAME NEWNAME

git config --global color.ui auto

git checkout master

git checkout -b NEWBRANCHNAME

git checkout -b NEWBRANCHNAME COMMITHASH

git switch -c NEWBRANCHNAME FROMBRANCHNAME

# With two steps
git branch NEWBRANCHNAME FROMBRANCHNAME
git switch NEWBRANCHNAME

git branch -m OLDBRANCHNAME NEWBRANCHNAME

git branch -d BRANCHNAME && git push origin --delete BRANCHNAME

git fetch

# Remove also local branches, those are deleted from remote
git fetch --prune

git pull

git push

git push -f origin feature/FEATURE

git push origin --all

# Remove tracking for non existing remote branches.
git remote prune origin

git cherry-pick COMMITHASH

git rebase master

git commit --amend

git commit -m 'Commit mesage'

git commit --amend -m 'New Message'

# Change last commit author:
git commit --amend --author="Imre Tabur <imre.tabur@mail.ee>"

# Or hashes
git diff Bonebranch..anotherbranch

git diff > diff.patch

git apply --stat diff.patch

git apply --check diff.patch

git am --signoff < diff.patch

git difftool -d COMMITHASH^ COMMITHASH
git difftool -d COMMITHASH^..COMMITHASH

git rebase -i HEAD~3

git rebase HEAD~1 --onto master

git revert COMMITHASH
git revert COMMITHASH --no-commit

git log -n 4

git log --graph --decorate --pretty=oneline --abbrev-commit

git log --oneline development ^master

git show COMMITHASH
git log -1 COMMITHASH

# 5 commits until hash
git log -n 5 COMMITHASH

git bisect start BAD_COMMITHASH
# Or when without hash then
git bisect bad BAD_COMMITHASH
git bisect good GOOD_COMMITHASH
git bisect bad
git bisect good
git bisect bad
# until finding correct
git bisect reset

git rev-list --count development ^master

git log --count master..development

git rev-list --count master..development

git reset filename(s)

# Remove last commit
git reset --hard HEAD~1

git reset --hard origin/feature/FEATURE

# Deleted files,folders to reset
git reset HEAD file
git checkout file

git tag -a 1.2.3 -m "1.2.3"

git tag -a 1.2.3 -m "1.2.3" COMMITHASH

git push origin 1.2.3

git tag -f latest
# Or
git tag -f latest 1.2.3
git push -f origin latest

git push --tags

git push --delete origin 1.2.3

git tag --delete 1.2.3

# Remote tags
git ls-remote --tags origin

# Uncommit last one commit
git reset --soft HEAD~1

# Stash under stash name
git stash push -m "save name"
# Deprecated
git stash save "save name"

git stash pop stash@{n}
```

Move one repo (repo1) to another (repo2)

```shell
git clone repo1

cd repo1

git config --get remote.origin.url

cd ..

git clone repo2

cd repo2

git checkout master

git remote add importrepo REPO1-URL

git fetch importrepo

git merge importrepo/master

git remote rm importrepo
```

Working with submodules

```shell
git submodule add REPOURL ./submodules/SUBMODULE_NAME

git submodule init

git submodule update

git submodule update --init

git submodule update --init --recursive

git clone --recurse-submodules MAIN_REPO_URL

git diff --cached --submodule

git mv ./submodules/OLD_SUBMODULE_NAME ./submodules/NEW_SUBMODULE_NAME

```

Starting as server

**nano .git/config** and add:

```
[alias]
serve = !git daemon --enable=receive-pack --reuseaddr --verbose --base-path=. --export-all ./flow-example.git
```

or

```shell
git daemon --enable=receive-pack --reuseaddr --verbose  --base-path=. --export-all ./setmy-info.github.io
```

## Older notes

### Meld tricks

**nano ~/bin/git-meld** and add:

```shell
#!/bin/sh
meld $2 $5
exit ${?}
```

**chmod goa+x ~/bin/git-meld** and **nano ~/.gitconfig**

```
[diff]
external = git-meld
```

### bisect example

```text
C:\sources\temp>git log
commit c63d2f39038a009f06c8f46e6f6283958a09a817 (HEAD -> master)
Author: Imre Tabur <imre.tabur@mail.ee>
Date:   Fri Dec 6 15:05:57 2024 +0200

    Commit 7 (With commit 5 bug)

commit 0ccd29033bdc2d52495b3bae40c181d7d45414d8
Author: Imre Tabur <imre.tabur@mail.ee>
Date:   Fri Dec 6 15:05:42 2024 +0200

    Commit 6 (With commit 5 bug)

commit e9fa9c9880c73a2113723f393538564284c336b5
Author: Imre Tabur <imre.tabur@mail.ee>
Date:   Fri Dec 6 15:05:31 2024 +0200

    Commit 5 (Bug introduced)

commit b157f9777aef1de99c0d9928878d687244ab8d20
Author: Imre Tabur <imre.tabur@mail.ee>
Date:   Fri Dec 6 15:05:00 2024 +0200

    Commit 4

commit 0e46b514523a19c59564e549940462c190bb5c9a
Author: Imre Tabur <imre.tabur@mail.ee>
Date:   Fri Dec 6 15:04:41 2024 +0200

    Commit 3

commit a4669d787f7e2bf21754a0da69d3893df4fb3f49
Author: Imre Tabur <imre.tabur@mail.ee>
Date:   Fri Dec 6 15:04:36 2024 +0200

    Commit 2

commit da57139a5cb5d807def761bd176933620d2678d2
Author: Imre Tabur <imre.tabur@mail.ee>
Date:   Fri Dec 6 15:04:21 2024 +0200

    Commit 1

C:\sources\temp>git bisect start
status: waiting for both good and bad commits

C:\sources\temp>git bisect bad c63d2f39038a009f06c8f46e6f6283958a09a817
status: waiting for good commit(s), bad commit known

C:\sources\temp>git bisect good da57139a5cb5d807def761bd176933620d2678d2
Bisecting: 2 revisions left to test after this (roughly 2 steps)
[b157f9777aef1de99c0d9928878d687244ab8d20] Commit 4

C:\sources\temp>git bisect good
Bisecting: 0 revisions left to test after this (roughly 1 step)
[0ccd29033bdc2d52495b3bae40c181d7d45414d8] Commit 6

C:\sources\temp>git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[e9fa9c9880c73a2113723f393538564284c336b5] Commit 5

C:\sources\temp>git bisect bad
e9fa9c9880c73a2113723f393538564284c336b5 is the first bad commit
commit e9fa9c9880c73a2113723f393538564284c336b5 (HEAD)
Author: Imre Tabur <imre.tabur@mail.ee>
Date:   Fri Dec 6 15:05:31 2024 +0200

    Commit 5

test.txt | 1 +
1 file changed, 1 insertion(+)
```

### See also

[Git flow branching](https://nvie.com/posts/a-successful-git-branching-model/)
[GitHub flow](https://docs.github.com/en/get-started/quickstart/github-flow)
[GitLab flow](https://docs.gitlab.com/ee/topics/gitlab_flow.html)
[Trunk based development](https://trunkbaseddevelopment.com/)
https://m.youtube.com/watch?v=aolI_Rz0ZqY
