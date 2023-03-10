@echo off

echo Checking for Updates...
timeout 1 >NUL

rem verion datei
%windir%\TauserTool\wget\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/version.sys -O%windir%\TauserTool\version.sys
type nul>empty.sys
fc empty.sys %windir%\TauserTool\version.sys >NUL
if %errorlevel%==0 goto fail

rem Test version datei
fc %windir%\TauserTool\version.sys %windir%\TauserTool\local_version.sys >NUL
if not %errorlevel%==0 goto download_update
echo You are already on the newest version.
pause
goto finish

:download_update
%windir%\TauserTool\wget\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/Tauser_Tool.bat -O%windir%\TauserTool\Tauser_Tool.update
type nul>empty.sys
fc empty.sys %windir%\TauserTool\Tauser_Tool.update >NUL
if %errorlevel%==0 goto fail
del %windir%\TauserTool\Tauser_Tool_backup.bat
ren %windir%\TauserTool\Tauser_Tool.bat Tauser_Tool_backup.bat
ren %windir%\TauserTool\Tauser_Tool.update Tauser_Tool.bat

set /p version=<%windir%\TauserTool\version.sys
echo %version%>%windir%\TauserTool\local_version.sys
timeout 1 >nul
goto finish



:fail
echo There is no Internetconnetion or the Servers can not be reached, please try agian
pause
exit

:finish
echo finishing...
