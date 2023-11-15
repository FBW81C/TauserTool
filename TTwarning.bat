@echo off
:reload
cls
echo TTwarning version 1.0
echo Launching TTLauncher.bat ...
echo Path: %systemdrive%\TTLauncher.bat
if not exist %systemdrive%\TTLauncher.bat goto nolauncher
call %systemdrive%\TTLauncher.bat
goto reload
:nolauncher
cls
echo Launcher File not found!...
echo Choose an option!
echo Type the corresponding number and hit enter!
echo 1) Opem CMD
echo 2) Open an other file
echo 3) Open Notepad
echo 4) Reboot to Windows
set /p opt=Opt: 
if %opt%==1 goto startcmd
if %opt%==2 goto file
if %opt%==3 goto startnotepad
if %opt%==4 goto gotowin
echo O_O thats no option. Type the corresponding number and hit enter!
pause
goto reload

:startcmd
cls
start cmd
goto reload

:file
echo Enter the file path of the file.
set /p file=Filepath: 
if not exist %file% (
echo Your file doesn't exist, enter agian
pause
)
if exist %file% start %file%
goto reload

:startnotepad
cls
start notepad
goto reload

:gotowin
reg add HKLM\System\Setup /v CmdLine /t REG_SZ /d "" /f
reg add HKLM\System\Setup /v SystemSetupInProgress /t REG_DWORD /d 0 /f
reg add HKLM\System\Setup /v OOBEInProgress /t REG_DWORD /d 0 /f
reg add HKLM\System\Setup /v SetupType /t REG_DWORD /d 0 /f
shutdown /f /r /t 0
goto reload