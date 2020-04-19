# GIT

## Information

## Installation

## Usage, tips and tricks

```bash

git config --global user.name "Imre Tabur"

git config --global user.email imre.tabur@eesti.ee

git config --global core.editor "c:\Program Files\Notepad++\notepad++.exe"

git config --global core.editor nano

git config --global core.commentchar "$"

git config --global core.autocrlf true

git config --global core.autocrlf false

git config --global core.autocrlf input

git config --get remote.origin.url

git checkout master

git checkout -b NEWBRANCHNAME

git checkout -b NEWBRANCHNAME COMMITHASH

git branch -m OLDBRANCHNAME NEWBRANCHNAME

git branch -d BRANCHNAME && git push origin --delete BRANCHNAME

git fetch

git pull

git push

git push -f origin feature/FEATURE

git remote prune origin

git cherry-pick COMMITHASH

git rebase master

git commit --amend

git commit -m 'Commit mesage'

git commit --amend -m 'New Message'

Change last commit author:

git commit --amend --author="Imre Tabur <imre.tabur@eesti.ee>"

git diff Bonebranch..anotherbranch

git rebase -i HEAD~3

git rebase HEAD~1 --onto master

git log -n 4

git log --graph --decorate --pretty=oneline --abbrev-commit

git reset filename(s)

Remove last commit

git reset --hard HEAD~1

git reset --hard origin/feature/FEATURE

git tag -a v1.2.3 -m "v1.2.3"

git tag -a v1.2.3 -m "v1.2.3" COMMITHASH

git push --tags

Uncommit:

git reset --soft HEAD~1

git stash save "save name"

Move one repo (repo1) to another (repo2)

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

git submodule add REPOURL ./submodules/SUBMODULE_NAME

git clone --recurse-submodules MAIN_REPO_URL

```

## See also

[xxxx](http://yyyyy)
