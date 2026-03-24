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
set AGENT=%6
if "%AGENT%"=="" set AGENT=claude
for /f "tokens=*" %%a in ('uuid') do set UUID=%%a

set CLONES_DIR=clones

mkdir %CLONES_DIR%

echo Submitting Argo Workflow for repo: %REPO_URL% : %REPO_NAME% (from: %FROM_COMMIT% to: %TO_COMMIT%, agent: %AGENT%, uuid: %UUID%)
argo submit -n review --watch ^
    -p repo-url=%REPO_URL% ^
    -p repo-name=%REPO_NAME% ^
    -p from-commit=%FROM_COMMIT% ^
    -p to-commit=%TO_COMMIT% ^
    -p agent=%AGENT% ^
    -p uuid=%UUID% ^
    argo-wf.yaml

echo All done.
