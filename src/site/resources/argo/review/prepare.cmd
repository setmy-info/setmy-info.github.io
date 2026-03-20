@echo off

set REPO_URL=%1
if "%REPO_URL%"=="" set REPO_URL=git@bitbucket.org:example/example-app.git
set REPO_NAME=%2
if "%REPO_NAME%"=="" set REPO_NAME=example-app
set REPO_BRANCH=%3
if "%REPO_BRANCH%"=="" set REPO_BRANCH=master
set FROM_COMMIT=%4
if "%FROM_COMMIT%"=="" set FROM_COMMIT=HEAD~1
set TO_COMMIT=%5
if "%TO_COMMIT%"=="" set TO_COMMIT=HEAD

set CLONES_DIR=clones

if exist %CLONES_DIR% rd /s /q %CLONES_DIR%
mkdir %CLONES_DIR%

call clone-repo.cmd %REPO_URL% %REPO_NAME% %REPO_BRANCH%
if exist secondary-clones.cmd call secondary-clones.cmd

echo Submitting Argo Workflow for repo: %REPO_NAME% (from: %FROM_COMMIT% to: %TO_COMMIT%)
argo submit -n review --watch ^
    -p repo-name=%REPO_NAME% ^
    -p from-commit=%FROM_COMMIT% ^
    -p to-commit=%TO_COMMIT% ^
    C:\sources\setmy.info\submodules\setmy-info.github.io\src\site\resources\argo\review\argo-code-review.yaml

echo All done.
