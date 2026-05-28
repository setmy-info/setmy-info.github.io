@echo off

for /f "tokens=*" %%a in ('uuid') do set UUID=%%a

argo submit -n generator --watch ^
    -p uuid=%UUID% ^
    07-generator-argo.yaml

echo All done.
