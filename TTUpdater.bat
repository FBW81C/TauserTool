@echo off
:updatemain
echo Checking for Updates...
if not exist %windir%\TauserTool\wget\wget.exe goto finish
rem verion datei
%windir%\TauserTool\wget\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/version.sys -O%windir%\TauserTool\version.sys
if not exist %windir%\TauserTool\temp md %windir%\TauserTool\temp
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\version.sys >NUL
if %errorlevel%==0 goto fail

rem Test version datei
fc %windir%\TauserTool\version.sys %windir%\TauserTool\local_version.sys
if not %errorlevel%==0 goto download_update
echo You are already on the newest version.
pause
goto finish

:download_update
%windir%\TauserTool\WGET\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/TTLauncher.bat -O%windir%\TauserTool\TTLauncher.update
type nul>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\TTLauncher.update >NUL
if %errorlevel%==0 goto fail
copy %systemdrive%\TTLauncher.bat %windir%\TauserTool\TTLauncher.backup /y
copy %windir%\TauserTool\TTLauncher.update %systemdrive%\TTLauncher.bat /y

:gethash
echo Generating MD5 Hash ...
certutil -hashfile %systemdrive%\TTLauncher.bat MD5 | findstr /V ":" >"%windir%\TauserTool\temp\TTLauncherhash.sys"
rem  Writing Original Hash to file...
echo Downloading Original Hash to...
%windir%\TauserTool\WGET\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/orginal_TTLauncherhash.sys -O%windir%\TauserTool\WGET\orginal_TTLauncherhash.sys
type nul>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\WGET\orginal_TTLauncherhash.sys >NUL
if %errorlevel%==0 goto fail
rem Check if hash is same
fc %windir%\TauserTool\temp\TTLauncherhash.sys %windir%\TauserTool\WGET\orginal_TTLauncherhash.sys
if %errorlevel%==0 goto afterhash


set /p orginal=<%windir%\TauserTool\WGET\orginal_TTLauncherhash.sys
set /p current=<%windir%\TauserTool\temp\TTLauncherhash.sys

echo MD5-Hash verification failed!
echo Expected hash: %orginal%
echo Returned hash: %current%
set /p opt=Retry (y/n): 
if %opt%==n goto restorelastversion
goto updatemain

:restorelastversion
echo Restoring local version...
copy %windir%\TauserTool\TTLauncher.backup %systemdrive%\TTLauncher.bat /y
goto finish

:afterhash
rem renew version
copy %windir%\TauserTool\version.sys %windir%\TauserTool\local_version.sys /y

rem Changelog
if not exist %windir%\TauserTool\Changelog md %windir%\TauserTool\Changelog
%windir%\TauserTool\wget\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/Changelog.sys -O%windir%\TauserTool\Changelog\TTChangelog.sys
fc empty.sys %windir%\TauserTool\Tauser_Changelog.sys
if %errorlevel%==0 goto Downlaod_Changelog_wget_fail
echo 1 > %windir%\TauserTool\Changelog\newChangelog.sys

goto finish


:fail
echo There is no Internetconnetion or the Servers can not be reached
echo 1) Retry
echo 2) Leave
set /p opt=Option: 
if %opt%==1 goto updatemain

:finish
echo finishing...
