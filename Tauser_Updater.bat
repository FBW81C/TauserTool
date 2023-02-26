@echo off

echo Checking for Updates...
timeout 1 >NUL

rem verion datei
%windir%\TauserTool\wget\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/version.sys -O%windir%\TauserTool\version.sys
type nul>empty.sys
fc empty.sys %windir%\TauserTool\version.sys
if %errorlevel%==0 goto fail

fc %windir%\TauserTool\version.sys %windir%\TauserTool\local_version.sys >NUL
if not %errorlevel%==0 goto download_update

:download_update
%windir%\TauserTool\wget\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/Tauser_Tool.bat -O%windir%\TauserTool\Tauser_Tool.update
type nul>empty.sys
fc empty.sys %windir%\TauserTool\Tauser_Tool.update
if %errorlevel%==0 goto fail
del %windir%\TauserTool\Tauser_Tool_backup.bat
ren %windir%\TauserTool\Tauser_Tool.bat Tauser_Tool_backup.bat
ren %windir%\TauserTool\Tauser_Tool.update Tauser_Tool.bat
timeout 1 >nul
goto finish



:fail
echo There is no Internetconnetion or the Servers can not be reached, please try agian
pause
exit

:finish
echo finishing...