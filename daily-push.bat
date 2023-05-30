@echo off
cd /d D:\learning
call git add -v .
call git commit -m "Daily backup"
call git push origin master
pause
