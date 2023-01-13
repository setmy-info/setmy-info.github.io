# GIT

## Usage, tips and tricks

Set and check name and email for git.

```bash
git config --global user.name "Imre Tabur"

git config --global user.email imre.tabur@eesti.ee

git config --global user.email

git config --global user.name

git config --global --add --bool push.autoSetupRemote true

git config --global url."https://github.com/".insteadOf "git@github.com:"

git config --global --list
```

```bash
git config --global core.editor "'c:\Program Files\Notepad++\notepad++.exe' -multiInst -notabbar -nosession -noPlugin"

git config --global core.editor nano

git config --global core.commentchar "$"

git config --global core.autocrlf true

git config --global core.autocrlf false

git config --global core.autocrlf input

git config --global merge.tool meld

git config --global mergetool.meld.path "c:\Program Files (x86)\Meld\Meld.exe"

# Show remote origin repo url
git config --get remote.origin.url

git remote rename OLDNAME NEWNAME

git config --global color.ui auto

git checkout master

git checkout -b NEWBRANCHNAME

git checkout -b NEWBRANCHNAME COMMITHASH

git branch -m OLDBRANCHNAME NEWBRANCHNAME

git branch -d BRANCHNAME && git push origin --delete BRANCHNAME

git fetch

git pull

git push

git push -f origin feature/FEATURE

# Remove tracking for non existing remote branches.
git remote prune origin

git cherry-pick COMMITHASH

git rebase master

git commit --amend

git commit -m 'Commit mesage'

git commit --amend -m 'New Message'

# Change last commit author:
git commit --amend --author="Imre Tabur <imre.tabur@eesti.ee>"

git diff Bonebranch..anotherbranch

git diff > diff.patch

git apply --stat diff.patch

git apply --check diff.patch

git am --signoff < diff.patch 

git rebase -i HEAD~3

git rebase HEAD~1 --onto master

git log -n 4

git log --graph --decorate --pretty=oneline --abbrev-commit

git reset filename(s)

# Remove last commit
git reset --hard HEAD~1

git reset --hard origin/feature/FEATURE

git tag -a 1.2.3 -m "1.2.3"

git tag -a 1.2.3 -m "1.2.3" COMMITHASH

git push origin 1.2.3

git push --tags

git push --delete origin 1.2.3

git tag --delete 1.2.3

# Uncommit last one commit
git reset --soft HEAD~1

git stash save "save name"
```

Move one repo (repo1) to another (repo2)

```bash
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

```bash
git submodule add REPOURL ./submodules/SUBMODULE_NAME

git submodule init

git submodule update

git submodule update --init

git submodule update --init --recursive

git clone --recurse-submodules MAIN_REPO_URL

git diff --cached --submodule
```

Starting as server

```bash
git daemon --enable=receive-pack --reuseaddr --verbose  --base-path=. --export-all ./setmy-info.github.io
```
