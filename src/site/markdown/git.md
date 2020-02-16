# GIT

## Information

## Installation

## Usage, tips and tricks

    Change last commit author

        git config --global user.name "John Doe"

        git config --global user.email "john@doe.org"

        git checkout master

        git checkout -b newbranhc

        git checkout -b newbranhc fromcommithash

        git branch -m oldbranchname newbranchname

        git fetch

        git pull

        git push

        git push -f origin feature/xyz

        git cherry-pick hashstring

        git rebase master

        git commit --amend

        git commit -m 'Commit mesage'

        git commit --amend -m 'New Message'

        git commit --amend --author="Imre Tabur <imre.tabur@eesti.ee>"

        git diff Bonebranch..anotherbranch

        git rebase -i HEAD~3

        git log -n 4

        git log --graph --decorate --pretty=oneline --abbrev-commit

        git reset filename(s)

        git tag -a v1.2.3 -m "v1.2.3"

        git tag -a v1.2.3 -m "v1.2.3" hashstring

     Uncommit:

        git reset --soft HEAD~1
       

## See also

    [xxxx](http://yyyyy)
