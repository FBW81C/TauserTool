@echo off
:reload
set version=1.1
set cls=1
set repo=https://github.com/FBW81C/TauserTool
echo %version%>%windir%\TauserTool\local_version.sys

echo Tauser Tool Version %version%
echo Made by FBW81C and JanGamesHD
echo Github: %repo%
echo.
echo Checking for Admin privillegs...
REG ADD HKLM\Software\AdminTest /v Data /t REG_BINARY /d %random% /F
if not %errorlevel%==0 goto getadmin
goto afteradmin

:getadmin
title Tauser Tool: Requesting Admin
echo Set UAC = CreateObject("Shell.Application") >%temp%\executeasmin.vbs
echo args = "ELEV " >>%temp%\executeasmin.vbs
echo For Each strArg in WScript.Arguments >>%temp%\executeasmin.vbs
echo args = args & strArg & " "  >>%temp%\executeasmin.vbs
echo Next >>%temp%\executeasmin.vbs
echo UAC.ShellExecute "%~f0", args, "", "runas", 1 >>%temp%\executeasmin.vbs
start /max %temp%\executeasmin.vbs
exit

:afteradmin
rem Add Cursor in TT
if "%username%"=="SYSTEM" reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f
rem Add the reg's if booted in TT to not crash
if "%username%"=="SYSTEM" reg add HKLM\System\Setup /v CmdLine /t REG_SZ /d "cmd.exe /k %windir%\TauserTool\opener.vbs" /f
if "%username%"=="SYSTEM" reg add HKLM\System\Setup /v SystemSetupInProgress /t REG_DWORD /d 1 /f
if "%username%"=="SYSTEM" reg add HKLM\System\Setup /v OOBEInProgress /t REG_DWORD /d 1 /f
if "%username%"=="SYSTEM" reg add HKLM\System\Setup /v SetupType /t REG_DWORD /d 2 /f
rem Ivrit
if exist %windir%\TauserTool\title.sys type %windir%\TauserTool\title.sys
echo Loading some stuff ... 
echo Please wait...
echo.
for /f "skip=3 tokens=1" %%a in ('powershell -command "$PSVersionTable.PSVersion"') do set Major=%%a
echo Powershell Version: %Major%
rem Checks Architecture
wmic os get osarchitecture | findstr "64" >NUL
set errorcode=%errorlevel%
if %errorcode%==0 set osarch=64
if %errorcode%==1 set osarch=32
echo OS Architecture: %osarch%
if not exist %windir%\TauserTool md %windir%\TauserTool
if not exist %windir%\TauserTool\Services md %windir%\TauserTool\Services
if not exist %windir%\TauserTool\temp md %windir%\TauserTool\temp
if not exist %windir%\TauserTool\Setup.sys goto Setup
rem Optional
if not exist %windir%\TauserTool\Services\updates.sys echo False>%windir%\TauserTool\Services\updates.sys
if exist %windir%\TauserTool\preload.bat call %windir%\TauserTool\preload.bat
rem Starts wifi
if exist %windir%\TauserTool\Services\wifi.sys (
start /min cmd /c net start netman
start /min cmd /c net start dhcp
start /min cmd /c net start wlansvc
set /p SSID=<%windir%\TauserTool\Services\wifi.sys
echo Connecting to %SSID% ...
netsh wlan connect name="%SSID%"
)
rem starts lan
if exist %windir%\TauserTool\Services\lan.sys (
start /min cmd /c net start netman
start /min cmd /c net start dhcp
)
rem starts audio
if exist %windir%\TauserTool\Services\audio.sys (
start /min cmd /c net start audiosrv
)
rem starts bluetooth
if exist %windir%\TauserTool\Services\bluetooth.sys (
start /min cmd /c net start btagservice
start /min cmd /c net start bthavctpsvc
start /min cmd /c net start bthserv
)
rem Additional Services
if not exist %windir%\TauserTool\additional_services goto loadhome
for %%i in ("%windir%\TauserTool\additional_services\*") do (
    call "%%~fi"
)

goto loadhome

:Setup
echo  _____                           _____           _  >%windir%\TauserTool\title.sys
echo I_   _I_ _ _   _ ___  ___ _ __  I_   _I__   ___ I I >>%windir%\TauserTool\title.sys
echo   I I/ _` I I I / __I/ _ \  __I   I I/ _ \ / _ \I I >>%windir%\TauserTool\title.sys
echo   I I (_I I I_I \__ \  __/ I      I I (_) I (_) I I >>%windir%\TauserTool\title.sys
echo   I_I\__,_I\__,_I___/\___I_I      I_I\___/ \___/I_I >>%windir%\TauserTool\title.sys
title Introduction
if %cls%==1 cls
type %windir%\TauserTool\title.sys
if exist %windir%\TauserTool\title.sys type %windir%\TauserTool\title.sys
echo Welcome to Tauser Tool
echo Version: %version%
echo.
echo With Tauser Tool you can run the bare minimum of Windows.
echo Most applications work out of the Box (like Steam Games).
echo Minecraft does NOT work out of the Box however you can use Porti (from JanGamesHD).
echo You can download Porti from the Startmenu to play it!!!
echo NOTE: If you close Tauser Tool while booted in Tauser Tool your System will crash.
echo.
echo To select an option: Type the coresponding letter or number and hit ENTER
echo Note: y = yes, n = no
echo.
echo Example: if you want X
echo 1) Option X
echo 2) Option Y
echo Option: 1
echo.
echo Pls Subscribe on YouTube (FBW81C)
echo Discord: https://discord.gg/JZ8JrgzA8J
echo And watch the Tutorial.
pause

:Setup_Question0
title Setup Question 0/4
if not exist %windir%\TauserTool\WGET md %windir%\TauserTool\WGET
if %cls%==1 cls
echo It would be really useful if we can download stuff via wget.exe
echo (3rd Party Software to download things).
echo Do you accept the wget.exe licence?
echo.
rem add winxp support via vbs
echo 1) Yes and Download wget.exe
echo 2) No, i don't accept the licence!
echo 3) Download wget.exe licence to %systemdrive%\wget_licence.txt, can take a long time!
set /p opt=Option: 
if %opt%==1 type NUL>%windir%\TauserTool\WGET\accepted.sys
if %opt%==1 goto Setup_Question0_wget
if %opt%==2 (
echo You should accept the licence!
echo Mabay i will add support for this in furture versions.
echo You can close the programm now, or accept the licence.
pause
)
if %opt%==2 goto Setup_Question0
if %opt%==3 bitsadmin /transfer "GetwgetTauserTool" /PRIORITY HIGH "https://cdn.discordapp.com/attachments/744206114161295451/1079358436308947084/COPYING_WGET" %systemdrive%\wget_licence.txt
if %opt%==3 if not exist %systemdrive%\wget_licence.txt (
echo We could not download the licence, the servers are down or you have no internet or the file is deleted!
pause
)
if %opt%==3 if not exist %systemdrive%\wget_licence.txt goto Setup_Question0
if %opt%==3 if exist %systemdrive%\wget_licence.txt goto Setup_Question0
set gobackfromopt=Setup_Question0
goto wrongopt

:Setup_Question0_wget
echo Trying to download...
powershell Invoke-WebRequest https://eternallybored.org/misc/wget/1.19.4/32/wget.exe -OutFile %windir%\TauserTool\WGET\wget.exe
if %errorlevel%==9009 bitsadmin /transfer "GetwgetTauserTool" /PRIORITY HIGH "https://eternallybored.org/misc/wget/1.19.4/32/wget.exe" %windir%\TauserTool\WGET\wget.exe
if %errorlevel%==9009 goto winxpfix
if exist %windir%\TauserTool\WGET\wget.exe (
set "gobackto=Setup_Question1" & set "altway=Setup_Question0" & set "filepath=%windir%\TauserTool\WGET\wget.exe" & set "orginal_hash=3dadb6e2ece9c4b3e1e322e617658b60" & set "notexpected=X" & set "whatnow=0"
)
if exist %windir%\TauserTool\WGET\wget.exe goto checkhash
echo We couldn't download wget.exe, check your internet connection, the servers could be down, or the file could have been removed.
echo If it does not work even after a few atemps, try to download it manualy and place it in %windir%\TauserTool\WGET\wget.exe.
set /p opt=Try agian (y/n): 
if %opt%==y goto Setup_Question0_wget
if %opt%==n goto Setup_Question0
set gobackfromopt=Setup_Question0_wget
goto wrongopt

:checkhash
if not exist %windir%\TauserTool\temp md %windir%\TauserTool\temp
echo Generating MD5 Hash ...
certutil -hashfile "%filepath%" MD5 | findstr /V ":" >"%windir%\TauserTool\temp\hash.sys"
rem what now
if %whatnow%==1 goto checkhash_ask1
echo Writing Original Hash to file...
echo %orginal_hash%>%windir%\TauserTool\temp\orginal_hash.sys
fc %windir%\TauserTool\temp\hash.sys %windir%\TauserTool\temp\orginal_hash.sys
if %errorlevel%==0 goto %gobackto%
if %cls%==1 cls
echo MD5-Hash verification failed!
set /p orginal_hash=<%windir%\TauserTool\temp\orginal_hash.sys
set /p remotehash=<%windir%\TauserTool\temp\hash.sys
echo Expected Hash: %orginal_hash%
echo Returned Hash: %remotehash%
:checkhash_ask
echo Do you want to ignore and continue? (y/n/a (a = agian)) 
set /p opt=Opt: 
if %opt%==y goto %gobackto%
if %opt%==n goto %altway%
if %opt%==a goto checkhash
goto checkwgethash_ask
rem set "gobackto=" & set "altway=" & set "filepath=" & set "orginal_hash=" & set "notexpected=X" & set "whatnow=0"
rem set "gobackto=" & set "altway=X" & set "filepath=" & set "orginal_hash=X" & set "notexpected=" & set "whatnow=1"
:checkhash_ask1
if %cls%==1 cls
echo Is this your expected MD5-Hash?
set /p remotehash=<%windir%\TauserTool\temp\hash.sys
echo Hash: %remotehash%
set /p opt=Option (y/n): 
if %opt%==y goto %gobackto%
if %opt%==n goto %notexpected%
goto checkhash_ask1

:downloadTTwarning
%windir%\TauserTool\WGET\wget.exe "https://raw.githubusercontent.com/FBW81C/TauserTool/main/TTwarning.bat" -O%windir%\TauserTool\TTwarning.bat
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\TTwarning.bat
set errorcode=%errorlevel%
if %errorcode%==0 echo TTwarning.bat could not be downloaded. Check your internet connection, or the servers are down...
if %errorcode%==0 echo Retrying in... (this file is ESSENTIAL for Tauser Tool to work)
if %errorcode%==0 timeout 10
if %errorcode%==0 goto downloadTTwarning
certutil -hashfile "%windir%\TauserTool\TTwarning.bat" MD5 | findstr /V ":" >"%windir%\TauserTool\temp\hash.sys"
set /p remotehash=<%windir%\TauserTool\temp\hash.sys
if 3bcc6b6c4a0e0044b4b98b41e0cb46a6==%remotehash% goto Setup_Question1
echo MD5-Hash Verifcation failed! THAT IS NOT GOD, in this Part of the Program it is ESSENTIAL to work!!!
echo Orginalhash: 3bcc6b6c4a0e0044b4b98b41e0cb46a6
echo Returnedhash: %remotehash%
pause
goto downloadTTwarning

:Setup_Question1
title Setup Question 1/4
if not exist %windir%\TauserTool\TTwarning.bat goto downloadTTwarning
if %cls%==1 cls
echo Now you can configurate Tauser Tool!
echo Part 1: Networking (Internet)
echo To select an option, type the coresponding Letter and Hit Enter (y = yes / n = no).
echo Note: That only means, Tauser Tool will connect to the Network if its available!
set /p opt=Would you like to connect to the Internt? (y/n): 
if %opt%==y goto networksetup
if %opt%==n goto Setup_Question2
set gobackfromopt=Setup_Question1
goto wrongopt

:wrongopt
echo This is not an Option!
echo To select an option, type the coresponding letter or number and hit ENTER (y = yes / n = no).
pause
goto %gobackfromopt%

:Setup_Question2
title Setup Question 2/4
if %cls%==1 cls
echo Part 2: Networking (Bluetooth)
echo Note: You need to pair a device in Windows before you can use it in Tauser Tool! (Someone from the Community should fix it! Because we have no idea how to)
set /p opt=Would you like to use Bluetooth? (y/n): 
if %opt%==y (
type NUL >%windir%\TauserTool\Services\bluetooth.sys
)
if %opt%==y goto Setup_Question3
if %opt%==n goto Setup_Question3
set gobackfromopt=Setup_Question2
goto wrongopt

:Setup_Question3
title Setup Question 3/4
if %cls%==1 cls
echo Part 3: Audio
echo Note: If you're using Win11 you probably don't have any Audio in Tauser Tool. (Someone from the Community should also fix it!)
set /p opt=Would you like to have Audio in Tauser Tool? (y/n): 
if %opt%==y (
type NUL >%windir%\TauserTool\Services\audio.sys
)
if %opt%==y goto Setup_Question4
if %opt%==n goto Setup_Question4
set gobackfromopt=Setup_Question3
goto wrongopt

:Setup_Question4
title Setup Question 4/4
if %cls%==1 cls
echo Part 4: Updating
echo Please select your Updating preferences.
echo 1) Automatically Download and Install Updates
echo 2) Check for Updates but ask me before Downloading and Installing Updates.
echo 3) Don't check for Updates.
set /p opt=Option: 
if %opt%==1 echo True>%windir%\TauserTool\Services\updates.sys
if %opt%==2 echo Ask>%windir%\TauserTool\Services\updates.sys
if %opt%==3 echo False>%windir%\TauserTool\Services\updates.sys
if %opt%==1 goto Setup_Question4_Updater
if %opt%==2 goto Setup_Question4_Updater
if %opt%==3 goto Setup_Question4_Updater
set gobackfromopt=Setup_Question4
goto wrongopt

:Setup_Question4_Updater
%windir%\TauserTool\WGET\wget.exe "https://raw.githubusercontent.com/FBW81C/TauserTool/main/TTUpdater.bat" -O%windir%\TauserTool\TTUpdater.bat
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\TTUpdater.bat
set errorcode=%errorlevel%
if %errorcode%==0 echo The Updater to update Tauser Tool could not be downloaded.
if %errorcode%==0 set /p opt=Retry (y/n): 
if %errorcode%==0 if %opt%==y goto Setup_Question4_Updater
if %errorcode%==0 goto Setup_Question4
%windir%\TauserTool\WGET\wget.exe "https://raw.githubusercontent.com/FBW81C/TauserTool/main/orginal_TTUpdaterhash.sys" -O%windir%\TauserTool\temp\orginal_TTUpdaterhash.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\temp\orginal_TTUpdaterhash.sys
set errorcode=%errorlevel%
if %errorcode%==0 echo The Updaterhash to verify Tauser Tool Updater could not be downloaded.
if %errorcode%==0 set /p opt=Retry (y/n): 
if %errorcode%==0 if %opt%==y goto Setup_Question4_Updater
if %errorcode%==0 goto Setup_Question4
set /p orginal_hash=<%windir%\TauserTool\temp\orginal_TTUpdaterhash.sys
set "gobackto=Setup_Complete" & set "altway=Setup_Question4" & set "filepath=%windir%\TauserTool\TTUpdater.bat" & set "notexpected=X" & set "whatnow=0"
if exist %windir%\TauserTool\Setup.sys set altway=settings_patch_updating
if exist %windir%\TauserTool\Setup.sys set gobackto=settings_patch_updating
goto checkhash

:networksetup
if %cls%==1 cls
echo Please select your preferred method to connect to the Internet.
echo Note: if your're using WiFi, you need to connect to the WiFi in Windows before you can use it in Tauser Tool!
echo 1) WiFi
echo 2) Ethernet (LAN) or an USB-Tethering device
echo 3) No i don't want to setup Internt anymore!
set /p opt=Option: 
if %opt%==1 set gobackto=Setup_Question2
if %opt%==1 goto wifisetup
if %opt%==2 (
type NUL >%windir%\TauserTool\Services\lan.sys
)
if %opt%==2 goto Setup_Question2
if %opt%==3 goto Setup_Question2
set gobackfromopt=networksetup
goto wrongopt

:wifisetup
if %cls%==1 cls
echo All available WiFi Networks
echo.
netsh wlan show networks
echo.
echo Please Enter the SSID (Name of the WiFi).
set /p SSID=SSID: 
echo %SSID%>%windir%\TauserTool\Services\wifi.sys
goto %gobackto%

:Setup_Complete
title Setup Complete
if %cls%==1 cls
if exist %windir%\TauserTool\title.sys type %windir%\TauserTool\title.sys
echo The Setup is now complete!
if exist %windir%\TauserTool\Services\lan.sys echo LAN:       ON 
if not exist %windir%\TauserTool\Services\lan.sys echo LAN:       OFF
if exist %windir%\TauserTool\Services\wifi.sys (
set /p SSID=<%windir%\TauserTool\Services\wifi.sys
echo WiFi:      ON (SSID: %SSID%)
)
if not exist %windir%\TauserTool\Services\wifi.sys echo WiFi:      OFF (SSID: None)
if exist %windir%\TauserTool\Services\audio.sys echo Audio:     ON
if not exist %windir%\TauserTool\Services\audio.sys echo Audio:     OFF
if exist %windir%\TauserTool\Services\bluetooth.sys echo Bluetooth: ON
if not exist %windir%\TauserTool\Services\bluetooth.sys echo Bluetooth: OFF
if not exist %windir%\TauserTool\Services\updates.sys set updatesetting=False
if exist %windir%\TauserTool\Services\updates.sys set /p updatesetting=<%windir%\TauserTool\Services\updates.sys
echo Updating:  %updatesetting%
echo.
echo You can change your preferences in settings > Patch!
echo Press any key to reload
pause>NUL
echo %version% >%windir%\TauserTool\Setup.sys

echo Set WshShell = WScript.CreateObject("WScript.Shell") >%windir%\TauserTool\opener.vbs
echo Do >>%windir%\TauserTool\opener.vbs
echo     WshShell.Run "%windir%\TauserTool\TTwarning.bat", 1, True >>%windir%\TauserTool\opener.vbs
echo     WScript.Sleep 1000 >>%windir%\TauserTool\opener.vbs
echo Loop >>%windir%\TauserTool\opener.vbs
goto reload

:loadhome
if %cls%==1 cls
if exist %windir%\TauserTool\Services\updates.sys set /p updatesetting=<%windir%\TauserTool\Services\updates.sys
if not exist %windir%\TauserTool\Services\updates.sys set updatesetting=False
rem ADD download wget.exe if accepted
if not exist %windir%\TauserTool\wget\wget.exe set gobackto=loadhome
if not exist %windir%\TauserTool\wget\wget.exe goto getwget
if %updatesetting%==True if exist %windir%\TauserTool\wget\wget.exe if exist %windir%\TauserTool\TTUpdater.bat call %windir%\TauserTool\TTUpdater.bat
if %updatesetting%==Ask if exist %windir%\TauserTool\wget\wget.exe if exist %windir%\TauserTool\TTUpdater.bat call %windir%\TauserTool\TTUpdater.bat
rem if %updatesetting%==False goto home
if exist %windir%\TauserTool\Services\color.sys (
set /p backgroundcolor=<%windir%\TauserTool\Services\color.sys
color %backgroundcolor%
if %errorlevel%==1 (
echo Note: Your choosen back-/ foreground color isn't valid, it wil be deleted now!
del %windir%\TauserTool\Services\color.sys /f /q
)
)

:tellnew
if not exist %windir%\TauserTool\Changelog md %windir%\TauserTool\Changelog
if not exist %windir%\TauserTool\Changelog\newChangelog.sys goto home
if not exist %windir%\TauserTool\Changelog\TTChangelog.sys goto home
title Changelog
if exist %windir%\TauserTool\title.sys type %windir%\TauserTool\title.sys
type %windir%\TauserTool\Changelog\TTChangelog.sys
del %windir%\TauserTool\Changelog\newChangelog.sys /f /q
pause

:home
title Tauser Tool Home
if %cls%==1 cls
echo Welcome to Tauser Tool!
echo Version: %version%
echo Made by FBW81C
echo.
goto home_show
:home_show2
echo.
echo 0) Exit / Shutdown / Reboot
echo 1) Start CMD
echo 2) 7-Zip File Manager
echo 3) Settings
echo 4) Installed Programs
echo 5) Store
echo 6) Tools
echo 7) Porti
rem echo 8) 
echo 9) Log off (Lock)
set /p opt=Option: 
if %opt%==0 goto exit
if %opt%==1 start cmd
if %opt%==1 goto home
if %opt%==2 goto check7z
if %opt%==3 goto settings
if %opt%==4 goto applications
if %opt%==5 goto store
if %opt%==6 goto tools
if %opt%==7 goto launchPorti
if %opt%==9 goto lock
set gobackfromopt=home
goto wrongopt

:home_show
sc query netman | findstr "RUNNING" >NUL
set errorcode=%errorlevel%
if %errorcode%==0 echo LAN: ON
if %errorcode%==1 echo LAN: OFF

sc query wlansvc | findstr "RUNNING" >NUL
set errorcode=%errorlevel%
if %errorcode%==0 echo WiFi: ON
if %errorcode%==1 echo WiFi: OFF

sc query bthserv | findstr "RUNNING" >NUL
set errorcode=%errorlevel%
if %errorcode%==0 echo Bluetooth: ON
if %errorcode%==1 echo Bluetooth: OFF

sc query audiosrv | findstr "RUNNING" >NUL
set errorcode=%errorlevel%
if %errorcode%==0 echo Audio: ON
if %errorcode%==1 echo Audio: OFF
goto home_show2

:exit
title exit
if %cls%==1 cls
echo Here you can exit Tauser Tool
echo 0) Back
echo 1) Shutdown / Reboot to Windows
echo 2) Shutdown / Reboot to Tauser Tool
set /p opt=Option: 
if %opt%==0 goto home
if %opt%==1 goto windowsoptions
if %opt%==2 goto Tauseroptions
set gobackfromopt=exit
goto wrongopt

:windowsoptions
title exit
if %cls%==1 cls
echo 0) Back
echo 1) Reboot to Windows
echo 2) Shutdown to Windows
set /p opt=Option: 
if %opt%==0 goto exit
if %opt%==1 set Tauseroptions_rs=r
if %opt%==2 set Tauseroptions_rs=s
if %opt%==1 goto rswin
if %opt%==2 goto rswin
set gobackfromopt=windowsoptions
goto wrongopt

:rswin
reg add HKLM\System\Setup /v CmdLine /t REG_SZ /d "" /f
reg add HKLM\System\Setup /v SystemSetupInProgress /t REG_DWORD /d 0 /f
reg add HKLM\System\Setup /v OOBEInProgress /t REG_DWORD /d 0 /f
reg add HKLM\System\Setup /v SetupType /t REG_DWORD /d 0 /f
shutdown /f /%Tauseroptions_rs% /t 0
goto shutdownscreen

:Tauseroptions
title exit
if %cls%==1 cls
echo 0) Back
echo 1) Reboot to Tauser Tool
echo 2) Shutdown to Tauser Tool
set /p opt=Option: 
if %opt%==0 goto exit
if %opt%==1 set Tauseroptions_rs=r
if %opt%==2 set Tauseroptions_rs=s
if %opt%==1 goto rstau
if %opt%==2 goto rstau
set gobackfromopt=Tauseroptions
goto wrongopt

:rstau
reg add HKLM\System\Setup /v CmdLine /t REG_SZ /d "cmd.exe /k %windir%\TauserTool\opener.vbs" /f
reg add HKLM\System\Setup /v SystemSetupInProgress /t REG_DWORD /d 1 /f
reg add HKLM\System\Setup /v OOBEInProgress /t REG_DWORD /d 1 /f
reg add HKLM\System\Setup /v SetupType /t REG_DWORD /d 2 /f
shutdown /f /%Tauseroptions_rs% /t 0

:shutdownscreen
set shutdownwait=0
if %cls%==1 cls
echo Loading... I
goto shutdownscreen_wait
:shutdownscreen2
if %cls%==1 cls
echo Loading... /
goto shutdownscreen_wait
:shutdownscreen3
if %cls%==1 cls
echo Loading... --
goto shutdownscreen_wait
:shutdownscreen4
if %cls%==1 cls
echo Loading... \
goto shutdownscreen_wait

:shutdownscreen_wait
set /a shutdownwait+=1
if %shutdownwait%==100 goto shutdownscreen2
if %shutdownwait%==200 goto shutdownscreen3
if %shutdownwait%==300 goto shutdownscreen4
if %shutdownwait%==400 goto shutdownscreen
goto shutdownscreen_wait


:lock
if not exist %windir%\TauserTool\lockpw.sys (
if %cls%==1 cls
echo You have no Lock Password, create one!
pause
)
if not exist %windir%\TauserTool\lockpw.sys goto settings_lock
set /p lock_pw=<%windir%\TauserTool\lockpw.sys
if %cls%==1 cls
echo Tauser Tool is Locked.
echo You need to enter your Tauser Tool Password, to login (type "exit" to reboot to Windows / Exit Tauser Tool).
echo.
set /p opt=Password: 
if %opt%==exit set Tauseroptions_rs=r
if %opt%==exit goto rswin
if %opt%==%lock_pw% goto home
if %cls%==1 cls
echo The Password is not correct! Try again.
pause
goto lock


:check7z
if exist "%ProgramFiles%\7-Zip\7zFM.exe" start cmd /c "%ProgramFiles%\7-Zip\7zFM.exe"
if exist "%ProgramFiles%\7-Zip\7zFM.exe" goto home
if exist "%ProgramFiles(x86)%\7-Zip\7zFM.exe" start cmd /c "%ProgramFiles(x86)%\7-Zip\7zFM.exe"
if exist "%ProgramFiles(x86)%\7-Zip\7zFM.exe" goto home
if %cls%==1 cls
echo --- 7-Zip ---
echo.
echo It looks like you havn't installed 7-Zip
echo Do you want to download and install it?
set /p opt=Option (y/n): 
if %opt%==y goto check7z_download
if %opt%==n goto home
set gobackfromopt=check7z
goto wrongopt

:check7z_download
rem Add not wget.exe supports
rem if not exist %windir%\TauserTool\WGET\wget.exe
if not exist %windir%\TauserTool\Programs md %windir%\TauserTool\Programs
if %osarch%==32 goto check7z_download_32
%windir%\TauserTool\WGET\wget.exe "https://7-zip.org/a/7z2301-x64.exe" -O%windir%\TauserTool\Programs\7z2301-x64.exe
if not exist %windir%\TauserTool\Programs\7z2301-x64.exe goto check7z_download_fail
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\Programs\7z2301-x64.exe
if %errorlevel%==0 goto check7z_download_fail
set "gobackto=check7z_download_install" & set "altway=home" & set "filepath=%windir%\TauserTool\Programs\7z2301-x64.exe" & set "orginal_hash=e5788b13546156281bf0a4b38bdd0901" & set "notexpected=X" & set "whatnow=0"
goto checkhash

:check7z_download_32
%windir%\TauserTool\WGET\wget.exe "https://7-zip.org/a/7z2301.exe" -O%windir%\TauserTool\Programs\7z2301.exe
if not exist %windir%\TauserTool\Programs\7z2301.exe goto check7z_download_fail
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\Programs\7z2301.exe
if %errorlevel%==0 goto check7z_download_fail
set "gobackto=check7z_download_install" & set "altway=home" & set "filepath=%windir%\TauserTool\Programs\7z2301.exe" & set "orginal_hash=1cfb215a6fb373ac33a38b1db320c178" & set "notexpected=X" & set "whatnow=0"
goto checkhash

:check7z_download_fail
if %cls%==1 cls
echo 7-Zip could not be downloaded, check your internet connection.
pause
goto check7z

:check7z_download_install
if %osarch%==64 if exist %windir%\TauserTool\Programs\7z2301-x64.exe start %windir%\TauserTool\Programs\7z2301-x64.exe
if %osarch%==32 if exist %windir%\TauserTool\Programs\7z2301.exe start %windir%\TauserTool\Programs\7z2301.exe
goto home

:settings
title Settings
if %cls%==1 cls
echo Here you can change some stuff
echo.
echo 0) Back
echo 1) Lock Password
echo 2) Patch / Service preferences
echo 3) Background
echo 4) Additional Services / Autostart
echo 5) Fallback
echo 9) About Tauser Tool
set /p opt=Option: 
if %opt%==0 goto home
if %opt%==1 goto settings_lock
if %opt%==2 goto settings_patch
if %opt%==3 goto settings_background
if %opt%==4 goto settings_additional
if %opt%==5 goto settings_fallback
if %opt%==9 goto stettings_tauser
set gobackfromopt=settings
goto wrongopt

:settings_lock
title Settings
if %cls%==1 cls
echo Here you can configurate your Lock Password.
echo.
echo 0) Back
echo 1) Create Lock Password
echo 2) Change Lock Password
echo 3) Delete Lock Password
set /p opt=Option: 
if %opt%==0 goto settings
if %opt%==1 goto settings_lock_create
if %opt%==2 goto settings_lock_change
if %opt%==3 goto settings_lock_delete
set gobackfromopt=settings_lock
goto wrongopt

:settings_lock_create
if exist %windir%\TauserTool\lockpw.sys if %cls%==1 cls
if exist %windir%\TauserTool\lockpw.sys echo You have already a Lock Password!
if exist %windir%\TauserTool\lockpw.sys pause
if exist %windir%\TauserTool\lockpw.sys goto settings_lock
if %cls%==1 cls
echo Here you can create your Lock Password (type "exit" to stop creation)!
echo.
set /p opt=Password: 
if %opt%==exit goto settings_lock
set /p opt1=Confirm Password:
if %opt%==%opt1% echo %opt1% >%windir%\TauserTool\lockpw.sys
if %opt%==%opt1% echo Created password successfully!
if %opt%==%opt1% pause
if %opt%==%opt1% goto settings_lock
if %cls%==1 cls
echo Passwords do not match (Try again)!
pause
goto settings_lock_create

:settings_lock_change
if not exist %windir%\TauserTool\lockpw.sys if %cls%==1 cls
if not exist %windir%\TauserTool\lockpw.sys echo You don't have a Lock Password!
if not exist %windir%\TauserTool\lockpw.sys pause
if not exist %windir%\TauserTool\lockpw.sys goto settings_lock_create
if %cls%==1 cls
set /p lock_pw=<%windir%\TauserTool\lockpw.sys
echo Here you can change your Lock Password (type "exit" to stop changing)!
echo.
set /p opt=Current Password: 
if %opt%==exit goto settings_lock
set /p opt1=New Password: 
set /p opt2=Confirm New Password: 
if not %opt%==%lock_pw% echo That's not your current password, try again!
if not %opt%==%lock_pw% pause
if not %opt%==%lock_pw% goto settings_lock_change
if not %opt1%==%opt2% echo The passwords do not match!
if not %opt1%==%opt2% pause 
if not %opt1%==%opt2% goto settings_lock_change
echo %opt2% >%windir%\TauserTool\lockpw.sys
if %cls%==1 cls
echo Sucessfully changed Lock Password!
pause
goto settings_lock

:settings_lock_delete
if not exist %windir%\TauserTool\lockpw.sys if %cls%==1 cls
if not exist %windir%\TauserTool\lockpw.sys echo You don't have a Lock Password!
if not exist %windir%\TauserTool\lockpw.sys pause
if not exist %windir%\TauserTool\lockpw.sys goto settings_lock_create
if %cls%==1 cls
set /p lock_pw=<%windir%\TauserTool\lockpw.sys
echo Here you can delete / deactivate your Lock Password (type "exit" to stop deleting)!
echo.
set /p opt=Current Password: 
if %opt%==exit goto settings_lock
if %opt%==%lock_pw% goto settings_lock_delete_ask
if %cls%==1 cls
echo Password incorrect, try agian!
pause
goto settings_lock_delete

:settings_lock_delete_ask
if %cls%==1 cls
echo Are you sure that you want delete your Lock Password (yes/n)
set /p opt=Option: 
if %opt%==n goto settings_lock
if %opt%==yes goto settings_lock_delete_init
set gobackfromopt=settings_lock_delete_ask
goto wrongopt

:settings_lock_delete_init
del %windir%\TauserTool\lockpw.sys /f /q
if %cls%==1 cls
echo Password successfully deleted!
pause
goto settings_lock


:settings_patch
title Settings
if %cls%==1 cls
set bluetoothonoff=0
set audioonoff=0
set wifionoff=0
set lanonoff=0
set updateonoff=False
set SSID=None
if exist %windir%\TauserTool\Services\bluetooth.sys set bluetoothonoff=1
if exist %windir%\TauserTool\Services\audio.sys set audioonoff=1
if exist %windir%\TauserTool\Services\wifi.sys set wifionoff=1
if exist %windir%\TauserTool\Services\wifi.sys set /p SSID=<%windir%\TauserTool\Services\wifi.sys
if exist %windir%\TauserTool\Services\lan.sys set lanonoff=1
set /p updateonoff=<%windir%\TauserTool\Services\updates.sys

echo --- Patch ---
echo Note: (X) = ON, ( ) = OFF
echo 0) Back
if %lanonoff%==1 echo 1) (X) Networking (Internet / Enthernet)
if %lanonoff%==0 echo 1) ( ) Networking (Internet / Enthernet)

if %wifionoff%==1 echo 2) (X) Networking (WiFi, SSID: %SSID%)
if %wifionoff%==0 echo 2) ( ) Networking (WiFi, SSID: %SSID%)

if %bluetoothonoff%==1 echo 3) (X) Networking (Bluetooth)
if %bluetoothonoff%==0 echo 3) ( ) Networking (Bluetooth)

if %audioonoff%==1 echo 4) (X) Audio
if %audioonoff%==0 echo 4) ( ) Audio

if %updateonoff%==True echo 5) Updating (Automatically)
if %updateonoff%==Ask echo 5) Updating (Ask)
if %updateonoff%==False echo 5) Updating (No)

set /p opt=Option: 
if %opt%==0 goto settings

rem Lan make OFF
if %opt%==1 if %lanonoff%==1 (
del %windir%\TauserTool\Services\lan.sys
start /min cmd /c net stop netman
start /min cmd /c net stop dhcp
)
rem Lan make ON
if %opt%==1 if %lanonoff%==0 (
type NUL >%windir%\TauserTool\Services\lan.sys
start /min cmd /c net start netman
start /min cmd /c net start dhcp
)
if %opt%==1 goto settings_patch


rem WiFi make OFF
if %opt%==2 if %wifionoff%==1 (
del %windir%\TauserTool\Services\wifi.sys
start /min cmd /c net stop wlansvc
if %lanonoff%==0 (
start /min cmd /c net stop netman
start /min cmd /c net stop dhcp
)
)
rem WiFi make ON
if %opt%==2 if %wifionoff%==0 set gobackto=backtopatchwifi
if %opt%==2 if %wifionoff%==0 goto wifisetup
if %opt%==2 if %wifionoff%==0 (
start /min cmd /c net start netman
start /min cmd /c net start dhcp
start /min cmd /c net start wlansvc
set /p SSID=<%windir%\TauserTool\Services\wifi.sys
echo Connecting to %SSID% ...
netsh wlan connect name="%SSID%"
)
:backtopatchwifi
if %opt%==2 goto settings_patch

rem bluetooth make OFF
if %opt%==3 if %bluetoothonoff%==1 (
del %windir%\TauserTool\Services\bluetooth.sys
start /min cmd /c net stop btagservice
start /min cmd /c net stop bthavctpsvc
start /min cmd /c net stop bthserv
)
rem bluetooth make ON
if %opt%==3 if %bluetoothonoff%==0 (
type NUL >%windir%\TauserTool\Services\bluetooth.sys
start /min cmd /c net start btagservice
start /min cmd /c net start bthavctpsvc
start /min cmd /c net start bthserv
)
if %opt%==3 goto settings_patch

rem Audio make OFF
if %opt%==4 if %audioonoff%==1 (
del %windir%\TauserTool\Services\audio.sys
start /min cmd /c net stop audiosrv
)
rem Audio make ON
if %opt%==4 if %audioonoff%==0 (
type NUL >%windir%\TauserTool\Services\audio.sys
start /min cmd /c net start audiosrv
)
if %opt%==4 goto settings_patch

rem Updating
if %opt%==5 goto settings_patch_updating
set gobackfromopt=settings_patch
goto wrongopt

:settings_patch_updating
title Settings
if %cls%==1 cls
set /p updateonoff=<%windir%\TauserTool\Services\updates.sys
echo Here you can change your updating preferences!
if %updateonoff%==True echo Currently: Automatically
if %updateonoff%==Ask echo Currently: Ask
if %updateonoff%==False echo Currently: No
echo 0) Back
echo 1) Automatically
echo 2) Ask
echo 3) No
echo 4) Check for updates depending on your above chosen preference
set /p opt=Option: 
if %opt%==0 goto settings_patch
rem Make Updating Auto
if %opt%==1 echo True>%windir%\TauserTool\Services\updates.sys
if %opt%==1 goto settings_patch_updating
rem Make Updating Ask
if %opt%==2 echo Ask>%windir%\TauserTool\Services\updates.sys
if %opt%==2 goto settings_patch_updating
rem Make Updating OFF
if %opt%==3 echo False>%windir%\TauserTool\Services\updates.sys
if %opt%==3 goto settings_patch_updating
if %opt%==4 goto settings_patch_updating_4
set gobackfromopt=settings_patch_updating
goto wrongopt

:settings_patch_updating_4
if %updateonoff%==False (
echo O_O you can't update if you have disabled updating...
pause
)
if %updateonoff%==False goto settings_patch_updating
if not %updateonoff%==False if not exist %windir%\TauserTool\TTUpdater.bat goto Setup_Question4_Updater
if not %updateonoff%==False if exist %windir%\TauserTool\WGET\wget.exe call %windir%\TauserTool\TTUpdater.bat
goto settings_patch_updating


:settings_background
title Settings
if %cls%==1 cls
echo Here you can change your Background preferences (type "exit" to exit)!
echo Note: If you choose the same colors for back- and foreground or colors that don't exist, nothing will it will stay the deaufalt way!
color ?
set /p opt=Option (only type the two hex values):
if %opt%==exit goto settings
echo %opt%>%windir%\TauserTool\Services\color.sys
goto settings


:settings_additional
if not exist %windir%\TauserTool\additional_services md %windir%\TauserTool\additional_services
if %cls%==1 cls
echo --- List Start ---
dir %windir%\TauserTool\additional_services\ /B /W
echo --- List End ---
echo.
echo 0) Back
echo 1) Add Additional Service
echo 2) Remove Additional Service
set /p opt=Option: 
if %opt%==0 goto settings
if %opt%==1 goto settings_additional_add
if %opt%==2 goto settings_additional_rem
set gobackfromopt=settings_additional
goto wrongopt

:settings_additional_add
if not exist %windir%\TauserTool\WGET\wget.exe (
echo You havn't downloaded wget.exe, you need to download it to access this function!
pause
)
if not exist %windir%\TauserTool\WGET\wget.exe goto settings_additional
if %cls%==1 cls
echo --- Download Additional Service ---
echo.
echo NOTE: If you implement a .bat file and it exits with "exit" command, your system will crash.
echo       .exe files should work, i havn't tested it .vbs
echo       If you aren't sure if it does. Test it in Windows.
echo.
set /p link=Link: 
if %link%==exit goto settings_additional
set /p filename=Filename (include file extension) (not filepath):
if %link%==exit goto settings_additional 
%windir%\TauserTool\WGET\wget.exe "%link%" -O"%windir%\TauserTool\additional_services\%filename%"
if not exist "%windir%\TauserTool\additional_services\%filename%" goto settings_additional_fail
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys "%windir%\TauserTool\additional_services\%filename%"
if %errorlevel%==0 goto settings_additional_fail
set "gobackto=settings_additional" & set "altway=X" & set "filepath=%windir%\TauserTool\additional_services\%filename%" & set "orginal_hash=X" & set "notexpected=settings_additional_del" & set "whatnow=1"
goto checkhash

:settings_additional_fail
if %cls%==1 cls
echo The file could no be downloaded.
echo Check your Internet connection.
pause
goto settings_additional

:settings_additional_rem
if %cls%==1 cls
echo --- Additional Service Remove ---
echo.
echo Type the name of the Additional Service you want to remove (with file extension).
set /p additionalname=Name: 
if not exist "%windir%\TauserTool\additional_services\%additionalname%" goto settings_additional_notfound
set /p opt1=Are you sure you want to remove it? (y/n): 
if %opt1%==y goto settings_additional_del
goto settings_additional

:settings_additional_del
del %windir%\TauserTool\additional_services\%additionalname% /F /Q
echo Additional Service successfully removed!
pause
goto settings

:settings_additional_notfound
if %cls%==1 cls
echo There is no Additional Service with the name: %additionalname%
echo Retry...
pause
goto settings_additional

:settings_fallback
if %cls%==1
title Fallback
echo This Fallback Feature opens Tauser Tool agian if it gets closed by accident.
echo NOTE: If you close Tauser Tool while booted in Tauser Tool your System will crash.
echo NOTE: I'm note sure if it will work... In Development...
echo.
if exist %windir%\TauserTool\opener.vbs echo Mode: Acitve
if not exist %windir%\TauserTool\opener.vbs echo Mode: Inactive
echo.
echo 0) Back
echo 1) Switch Mode
set /p opt=Option:
if %opt%==0 goto settings
if %opt%==1 goto settings_fallback_switch
set gobackfromopt=settings_fallback
goto wrongopt

:settings_fallback_switch
if not exist %windir%\TauserTool\opener.vbs goto settings_fallback_switch_on
if exist %windir%\TauserTool\opener.vbs del %windir%\TauserTool\opener.vbs /f /q
echo You need to restart your System to apply changes
pause
goto settings_fallback
:settings_fallback_switch_on
echo You need to restart your System to apply changes
pause
goto settings_fallback

:stettings_tauser
title Info
if %cls%==1 cls
if exist %windir%\TauserTool\title.sys type %windir%\TauserTool\title.sys
set /p orginal_TTUpdaterhash=<%windir%\TauserTool\temp\orginal_TTUpdaterhash.sys
if exist %windir%\TauserTool\WGET\orginal_TTLauncherhash.sys set /p orginal_TTLauncherhash=<%windir%\TauserTool\WGET\orginal_TTLauncherhash.sys
echo Here you can see Stuff about Tauser Tool!
echo Tauser Tool Made by FBW81C and JanGamesHD (Sub on YT pls)
echo Current Version: %version%
echo Github: %repo%
echo TTUpdater MD5-Hash: %orginal_TTUpdaterhash%
if exist %windir%\TauserTool\WGET\orginal_TTLauncherhash.sys echo TTLauncher MD5-Hash: %orginal_TTLauncherhash%
pause
type NUL>%windir%\TauserTool\Changelog\newChangelog.sys
goto tellnew

:applications
if not exist %windir%\TauserTool\applications md %windir%\TauserTool\applications
if %cls%==1 cls
echo --- Program List Start ---
dir %windir%\TauserTool\applications\ /B /W
echo --- Program List End ---
echo.
echo Want to update Program List? Type reload
echo Want to go back? Type: ..
echo.
echo To select an option type the name or copy paste it (include the file extension).
echo Expamle: notepad.lnk
set /p opt=Opt: 
if "%opt%"=="reload" goto applications_reload
if "%opt%"==".." goto home
if not exist "%windir%\TauserTool\applications\%opt%" goto applications_notfound
start /min cmd /c "%windir%\TauserTool\applications\%opt%"
goto home


:applications_reload
echo Deleting old TauserTool Startmenu Items...
del %windir%\TauserTool\applications\*.lnk /Q /S /F
echo Refetching Programs... Pls Dont Turn Off or Start Menu Items will be broken O__O
set movedone=0
:here
for /R "%ProgramData%\Microsoft\Windows\Start Menu\Programs"\ %%f in (*.lnk) do set ziel=%%f
if not exist "%ziel%" goto nextstep
rem echo Refetching %ziel% ...
if %cls%==1 cls
echo Already Done: %movedone%
echo Refetching Programs... Pls DON'T Turn Off your device! 
echo If you do your Start Menu Items will be broken O__O (can't open apps anymore)
copy "%ziel%" %windir%\TauserTool\applications\ >NUL
set errorcode=%errorlevel%
if %errorcode%==0 set /a movedone=%movedone%+1
if not %errorcode%==0 goto nextstep
rem for %%a in (%ziel%) do set rd=%%~dpa
rem echo DELETE START: %rd%
rem set rd=%rd:~0,-1%
rem echo DELETE STOP: %rd%
rem rd %rd%
ren "%ziel%" *.CopyDone
if not %errorlevel%==0 goto nextstep
rem if not exist "%output%" goto nextstep
goto here

:nextstep
echo Renaming Back...
for /R "%ProgramData%\Microsoft\Windows\Start Menu\Programs"\ %%f in (*.CopyDone) do ren "%%f" *.lnk
echo Done!
goto applications


:applications_notfound
echo %opt% not found!
pause
goto applications


:store
title Store
if %cls%==1 cls
if not exist %windir%\TauserTool\Programs md %windir%\TauserTool\Programs
echo ------ Programs ------
echo.
echo Here you can start and download programs!
echo NOTE: DO NOT change your installation path!!! 
echo (You would need to change the Tauser Tool file)
echo.
echo 0) Back
if exist "%systemdrive%\Program Files\Mozilla Firefox\firefox.exe" echo 1) Start Mozilla Firefox
if not exist "%systemdrive%\Program Files\Mozilla Firefox\firefox.exe" echo 1) Download Firefox
rem Steam
if exist "%ProgramFiles(x86)%\Steam\steam.exe" echo 2) Start Steam
if not exist  "%ProgramFiles(x86)%\Steam\steam.exe" echo 2) Download Steam
rem Steam
rem Epic
if exist "%ProgramFiles(x86)%\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe" echo 3) Start Epic Games
if not exist "%ProgramFiles(x86)%\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe" echo 3) Download Epic Games
rem Epic
rem echo 4) Discord (32 Bit)
rem Notepad++
if exist "%ProgramFiles(x86)%\Notepad++\notepad++.exe" set storevalue=2
if exist "%ProgramFiles%\Notepad++\notepad++.exe" set storevalue=1
if not exist "%ProgramFiles(x86)%\Notepad++\notepad++.exe" if not exist "%ProgramFiles%\Notepad++\notepad++.exe" set storevalue=0
if %storevalue%==0 echo 5) Download Notepad++
if %storevalue%==1 echo 5) Start Notepad++ (64 Bit)
if %storevalue%==2 echo 5) Start Notepad++ (32 Bit)
rem Notepad++
rem Rufus
if %osarch%==64 if not exist %windir%\TauserTool\Programs\rufus-4.3.exe echo 6) Download Rufus 4.3 (64 Bit)
if %osarch%==32 if not exist %windir%\TauserTool\Programs\rufus-4.3_x86.exe echo 6) Download Rufus 4.3 (32 Bit)
if %osarch%==64 if exist %windir%\TauserTool\Programs\rufus-4.3.exe echo 6) Start Rufus 4.3 (64 Bit)
if %osarch%==32 if exist %windir%\TauserTool\Programs\rufus-4.3_x86.exe echo 6) Start Rufus 4.3 (32 Bit)
rem Rufus
rem Roblox
rem https://www.roblox.com/download/client?os=win
rem Roblox
set /p opt=Option: 
if %opt%==0 goto home
if %opt%==1 goto firefox
if %opt%==2 goto steam
if %opt%==3 goto epicgames
if %opt%==5 goto notepadplusplus
if %opt%==6 goto rufus
set gobackfromopt=store
goto wrongopt

:firefox
if exist "%systemdrive%\Program Files\Mozilla Firefox\firefox.exe" goto startfirefox
if not exist "%systemdrive%\Program Files\Mozilla Firefox\firefox.exe" goto downloadfirefox
goto home

:startfirefox
start cmd /c "%systemdrive%\Program Files\Mozilla Firefox\firefox.exe"
goto home

:downloadfirefox
if not exist %windir%\TauserTool\WGET\wget.exe set gobackto=downloadfirefox
if not exist %windir%\TauserTool\WGET\wget.exe goto getwget
%windir%\TauserTool\WGET\wget.exe "https://download-installer.cdn.mozilla.net/pub/firefox/releases/99.0b8/win64/de/Firefox Setup 99.0b8.exe" -O%windir%\TauserTool\Programs\FirefoxSetup.exe
if not exist %windir%\TauserTool\Programs\FirefoxSetup.exe goto store_fail
start %windir%\TauserTool\Programs\FirefoxSetup.exe
goto home

:notepadplusplus
if exist "%ProgramFiles%\Notepad++\notepad++.exe" start cmd /c "%ProgramFiles%\Notepad++\notepad++.exe"
if exist "%ProgramFiles%\Notepad++\notepad++.exe" goto home
if exist "%ProgramFiles(x86)%\Notepad++\notepad++.exe" start cmd /c "%ProgramFiles(x86)%\Notepad++\notepad++.exe"
if exist "%ProgramFiles(x86)%\Notepad++\notepad++.exe" goto home
if %osarch%==32 goto notepadplusplus_32
%windir%\TauserTool\WGET\wget.exe "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.8/npp.8.5.8.Installer.x64.exe" -O%windir%\TauserTool\Programs\npp.8.5.8.Installer.x64.exe
if not exist %windir%\TauserTool\Programs\npp.8.5.8.Installer.x64.exe goto store_fail
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\Programs\npp.8.5.8.Installer.x64.exe
if %errorlevel%==0 goto store_fail
set "gobackto=notepadplusplus_install" & set "altway=store" & set "filepath=%windir%\TauserTool\Programs\npp.8.5.8.Installer.x64.exe" & set "orginal_hash=bb24bfe6b03ed859d38d7ac653617417" & set "notexpected=X" & set "whatnow=0"
goto checkhash

:notepadplusplus_32
%windir%\TauserTool\WGET\wget.exe "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.8/npp.8.5.8.Installer.exe" -O%windir%\TauserTool\Programs\npp.8.5.8.Installer.exe
if not exist %windir%\TauserTool\Programs\npp.8.5.8.Installer.exe goto store_fail
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\Programs\npp.8.5.8.Installer.exe
if %errorlevel%==0 goto store_fail
set "gobackto=notepadplusplus_install" & set "altway=store" & set "filepath=%windir%\TauserTool\Programs\npp.8.5.8.Installer.exe" & set "orginal_hash=e11d1f24d0abeaf09154c83202366b68" & set "notexpected=X" & set "whatnow=0"
goto checkhash

:notepadplusplus_install
if %osarch%==32 if exist %windir%\TauserTool\Programs\npp.8.5.8.Installer.exe start %windir%\TauserTool\Programs\npp.8.5.8.Installer.exe
if %osarch%==64 if exist %windir%\TauserTool\Programs\npp.8.5.8.Installer.x64.exe start %windir%\TauserTool\Programs\npp.8.5.8.Installer.x64.exe
goto home

:steam
rem 32 Bit
if exist "%ProgramFiles(x86)%\Steam\steam.exe" start cmd /c "%ProgramFiles(x86)%\Steam\steam.exe"
if exist "%ProgramFiles(x86)%\Steam\steam.exe" goto home
%windir%\TauserTool\WGET\wget.exe "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe" -O%windir%\TauserTool\Programs\SteamSetup.exe
if not exist %windir%\TauserTool\Programs\SteamSetup.exe goto store_fail
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\Programs\SteamSetup.exe
if %errorlevel%==0 goto store_fail
rem set "gobackto=steam_install" & set "altway=store" & set "filepath=%windir%\TauserTool\Programs\SteamSetup.exe" & set "orginal_hash="
rem Mayby add a specific steam version not just the newest, then it can also test the hash
rem goto checkhash

:steam_install
if exist %windir%\TauserTool\Programs\SteamSetup.exe start %windir%\TauserTool\Programs\SteamSetup.exe
goto home

:epicgames
if exist "%ProgramFiles(x86)%\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe" start cmd /c "%ProgramFiles(x86)%\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe"
if exist "%ProgramFiles(x86)%\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe" goto home
%windir%\TauserTool\WGET\wget.exe "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi" -O%windir%\TauserTool\Programs\EpicInstaller.msi
if not exist %windir%\TauserTool\Programs\EpicInstaller.msi goto store_fail
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\Programs\EpicInstaller.msi
if %errorlevel%==0 goto store_fail
rem set "gobackto=epcigames_install" & set "altway=store" & set "filepath=%windir%\TauserTool\Programs\EpicInstaller.msi" & set "orginal_hash="
rem Mayby add a specific epicgames version not just the newest, then it can also test the hash
rem goto checkhash

:epicgames_install
if exist %windir%\TauserTool\Programs\EpicInstaller.msi start %windir%\TauserTool\Programs\EpicInstaller.msi
goto home

:rufus
if exist %windir%\TauserTool\Programs\rufus-4.3.exe start cmd /c %windir%\TauserTool\Programs\rufus-4.3.exe
if exist %windir%\TauserTool\Programs\rufus-4.3.exe goto home
if exist %windir%\TauserTool\Programs\rufus-4.3_x86.exe start cmd /c %windir%\TauserTool\Programs\rufus-4.3_x86.exe
if exist %windir%\TauserTool\Programs\rufus-4.3.exe goto home
if %osarch%==32 goto rufus_32
%windir%\TauserTool\WGET\wget.exe "https://github.com/pbatard/rufus/releases/download/v4.3/rufus-4.3.exe" -O%windir%\TauserTool\Programs\rufus-4.3.exe
if not exist %windir%\TauserTool\Programs\rufus-4.3.exe goto store_fail
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\Programs\rufus-4.3.exe
if %errorlevel%==0 goto store_fail
set "gobackto=store" & set "altway=store" & set "filepath=%windir%\TauserTool\Programs\rufus-4.3.exe" & set "orginal_hash=12501c163c493bf13a05e5c042b576e3" & set "notexpected=X" & set "whatnow=0"
goto checkhash


:rufus_32
%windir%\TauserTool\WGET\wget.exe "https://github.com/pbatard/rufus/releases/download/v4.3/rufus-4.3_x86.exe" -O%windir%\TauserTool\Programs\rufus-4.3_x86.exe
if not exist %windir%\TauserTool\Programs\rufus-4.3_x86.exe goto store_fail
type NUL>%windir%\TauserTool\temp\empty.sys
fc %windir%\TauserTool\temp\empty.sys %windir%\TauserTool\Programs\rufus-4.3_x86.exe
if %errorlevel%==0 goto store_fail
set "gobackto=store" & set "altway=store" & set "filepath=%windir%\TauserTool\Programs\rufus-4.3_x86.exe" & set "orginal_hash=d9d8e8064ccb177a2c370a565c9f0ece" & set "notexpected=X" & set "whatnow=0"
goto checkhash

:store_fail
Title Store Fail
if %cls%==1 cls
echo The App couldn't be downloaded, check your internet connection.
pause
goto store

:getwget_accept
if %cls%==1 cls
echo It looks like you havn't accepted the wget.exe licence...
echo Please accept the licence...
echo 1) Accept
echo 2) Decline
echo 3) Download Licene to %systemdrive%\wget_licence.txt (via PowerShell)
set /p opt=Option: 
if %opt%==1 type NUL >%windir%\TauserTool\WGET\accepted.sys
if %opt%==1 goto getwget
if %opt%==2 (
echo We can't continue if you don't accept the licence!
echo Come back Later!
pause
)
if %opt%==2 goto home

if %opt%==3 for /f "skip=3 tokens=1" %%a in ('powershell -command "$PSVersionTable.PSVersion"') do set Major=%%a
if %opt%==3 if %Major% lss 3 (
if %cls%==1 cls
echo You can't download the wget.exe licence via PowerShell with your current PowerShell version.
pause
)
if %Major% lss 3 goto getwget_accept
powershell Invoke-WebRequest https://cdn.discordapp.com/attachments/744206114161295451/1079358436308947084/COPYING_WGET -OutFile %systemdrive%\wget_licence.txt
if exist %systemdrive%\wget_licence.txt (
echo Succesfully downloaded wget.exe licence!
pause
)
if %opt%==3 if exist %systemdrive%\wget_licence.txt goto getwget_accept
if %opt%==3 if not exist %systemdrive%\wget_licence.txt goto getwget_accept_fail

set gobackfromopt=getwget_accept
goto wrongopt

:getwget_accept_fail
echo We couldn't download wget.exe licnece via PowerShell.
set /p opt=Try agian (y/n (n = return to home)): 
if %opt%==y goto getwget_accept
if %opt%==n goto home
set gobackfromopt=getwget_accept_fail
goto wrongopt



:getwget
if not exist %windir%\TauserTool\WGET md %windir%\TauserTool\WGET
if not exist %windir%\TauserTool\WGET\accepted.sys goto getwget_accept
if %cls%==1 cls
echo It looks like you havn't installed wget.exe (3rd Party Software to download things).
echo How should we download wget.exe?
echo.
echo 1) Download wget.exe via bitsadmin (can take a while and will probaly not work in Tauser Tool)
echo 2) Download wget.exe via powershell (faster than bitsadmin)
echo 3) No, now i don't want to download it!
set /p opt=Option: 
if %opt%==1 goto getwget_ba
if %opt%==2 goto getwget_ps
if %opt%==3 goto home
set gobackfromopt=getwget
goto wrongopt

:getwget_ps
for /f "skip=3 tokens=1" %%a in ('powershell -command "$PSVersionTable.PSVersion"') do set Major=%%a
if %Major% lss 3 (
if %cls%==1 cls
echo You can't download wget.exe via PowerShell with your current PowerShell version.
pause
)
if %Major% lss 3 goto getwget

echo Trying to download wget.exe ...
powershell Invoke-WebRequest https://eternallybored.org/misc/wget/1.19.4/32/wget.exe -OutFile %windir%\TauserTool\WGET\wget.exe
if %errorlevel%==9009 bitsadmin /transfer "GetwgetTauserTool" /PRIORITY HIGH "https://eternallybored.org/misc/wget/1.19.4/32/wget.exe" %windir%\TauserTool\WGET\wget.exe
if %errorlevel%==9009 goto getwget_ps_fail
if exist %windir%\TauserTool\WGET\wget.exe goto checkwgethash
echo We couldn't download wget.exe via PowerShell.
set /p opt=Try agian (y/n): 
if %opt%==y goto getwget_ps
if %opt%==n goto getwget
set gobackfromopt=getwget_ps
goto wrongopt

:getwget_ps_fail
echo It looks like you are using and very old version of windows and/or you havn't installed the newest type of powershell!
echo Please Donwload bitsadmin and/or update powershell!
pause
goto home


:checkwgethash
rem Fallback if goback is not defined maybay here
rem Generating MD5 Hash
echo Generating MD5 Hash ...
certutil -hashfile "%windir%\TauserTool\WGET\wget.exe" MD5 | findstr /V ":" >"%windir%\TauserTool\WGET\wgethash.sys"
rem  Writing Original Hash to file...
echo Writing Original Hash to file...
echo 3dadb6e2ece9c4b3e1e322e617658b60>%windir%\TauserTool\WGET\orginal_wgethash.sys
fc %windir%\TauserTool\WGET\wgethash.sys %windir%\TauserTool\WGET\orginal_wgethash.sys
if %errorlevel%==0 goto %gobackto%

title MD5-Hash verification failed!
echo MD5-Hash verification failed!
set /p remotehash_wget=<%windir%\TauserTool\WGET\wgethash.sys
echo Expected Hash: 3dadb6e2ece9c4b3e1e322e617658b60
echo Returned Hash: %remotehash_wget%

:checkwgethash_ask
echo Do you want to ignore and continue? (y/n/a (a = agian)) 
set /p opt=Opt: 
if %opt%==y goto %gobackto%
if %opt%==n goto fail1
if %opt%==a goto checkwgethash
goto checkwgethash_ask

:fail1
if %cls%==1 cls
echo The Hash isn't the same. This could mean that the Provider replaced or edited the file or the servers are offline or you have no internet connection!
echo We will not continue downloading.
pause
goto home

:getwget_ba
bitsadmin /transfer "GetwgetTauserTool" /PRIORITY HIGH "https://eternallybored.org/misc/wget/1.19.4/32/wget.exe" %windir%\TauserTool\WGET\wget.exe
if %errorlevel%==9009 goto getwget_ps_fail
if exist %windir%\TauserTool\WGET\wget.exe goto checkwgethash
echo We couldn't download wget.exe via bitsadmin.
set /p opt=Try agian (y/n): 
if %opt%==y goto getwget_ba
if %opt%==n goto getwget
set gobackfromopt=getwget_ba
goto wrongopt


:tools
title Tools
if %cls%==1 cls
echo ------ Tools ------
echo.
echo 0) Back
echo 1) Installer
echo 2) Uninstaller
echo 4) Change Volume
echo 5) Sound Settings
echo 6) Change Brightness
echo 7) Force-Close Program
echo 8) Windows-Build-In Tools
echo 9) Use Goto-Value (EXPERIENCED USERS ONLY!)
echo 10) Change content of Tauser Tool file (EXPERIENCED USERS ONLY!)
set /p opt=Option: 
if %opt%==0 goto home
if %opt%==1 goto tools_installer
if %opt%==2 goto tools_uninstaller
if %opt%==4 start sndvol
if %opt%==4 goto home
if %opt%==5 start rundll32 shell32.dll,Control_RunDLL mmsys.cpl,,sounds
if %opt%==5 goto home
if %opt%==6 goto tools_changebrightness
if %opt%==7 goto tools_forceclose
if %opt%==8 goto tools_buildin
if %opt%==9 goto tools_goto
if %opt%==10 notepad \TTLauncher.bat
if %opt%==10 goto home
set gobackfromopt=tools
goto wrongopt


:tools_installer
title Tools
if %cls%==1 cls
echo ------ Installer ------
echo.
echo Here you can download files. Expamples .exe, .bat, .msi ... or just .txt
echo You can Copy and Paste the download link here, enter "exit" to exit
echo.
set /p downloadlink=Download Link: 
if %downloadlink%==exit goto tools
echo Choose Where you want it to be stored, enter "exit" to exit
echo Example: C:\MyFile.exe (absolute filepath)
echo.
set /p filename=Save to: 
if %filename%==exit goto tools

:tools_installer_ask
title Tools
if %cls%==1 cls
echo ------ Installer ------
echo.
echo Only dowload stuff you know!
echo Downloadlink: %downloadlink%
echo Safe File to: %filename%
echo.
echo 0) Back
echo 1) Download via bitsadmin (slow, will probably not work in Tauer Tool)
echo 2) Download via PowerShell (faster than bitsadmin)
echo 3) Download via wget.exe (3rd Party Software, fastest)
set /p opt=Option: 
if %opt%==0 goto tools_installer
if %opt%==1 goto tools_installer_dowload_ba
if %opt%==2 goto tools_installer_dowload_ps
if %opt%==3 goto tools_installer_dowload_wg
set gobackfromopt=tools_installer
goto wrongopt

:tools_installer_dowload_ba
bitsadmin /transfer "TauserToolInstallTool" /PRIORITY HIGH "%downloadlink%" "%filename%"
set errorcode=%errorlevel%
if %errorcode%==9009 (
echo bitsadmin could not download the file because your are using a old Windows version and bitsadmin is not installed!
pause
)
if %errorcode%==9009 goto tools_installer_ask
if not exist "%filename%" set gobacktodownload=tools_installer_dowload_ba
if not exist "%filename%" goto tools_installer_dowload_noexist
goto tools_installer_dowload_checkhash

:tools_installer_dowload_ps
for /f "skip=3 tokens=1" %%a in ('powershell -command "$PSVersionTable.PSVersion"') do set Major=%%a
if %Major% lss 3 (
if %cls%==1 cls
echo You can't download via PowerShell with your current PowerShell version.
pause
)
if %Major% lss 3 goto tools_installer_ask
powershell Invoke-WebRequest "%downloadlink%" -OutFile "%filename%"
if not exist "%filename%" set gobacktodownload=tools_installer_dowload_ps
if not exist "%filename%" goto tools_installer_dowload_noexist
goto tools_installer_dowload_checkhash

:tools_installer_dowload_wg
if not exist %windir%\TauserTool\WGET\wget.exe set gobackto=tools_installer_dowload_wg
if not exist %windir%\TauserTool\WGET\wget.exe goto getwget
%windir%\TauserTool\WGET\wget.exe "%downloadlink%" -O"%filename%"
if not exist "%filename%" set gobacktodownload=tools_installer_dowload_wg
if not exist "%filename%" goto tools_installer_dowload_noexist
goto tools_installer_dowload_checkhash

:tools_installer_dowload_noexist
if %cls%==1 cls
echo %downloadlink% could not be safed to:
echo %filename%
echo Do you want to try again? (y/n)
set /p opt=Option: 
if %opt%==y goto %gobacktodownload%
if %opt%==n goto tools_installer_ask
set gobackfromopt=tools_installer_dowload_noexist
goto wrongopt

:tools_installer_dowload_checkhash
if not exist %windir%\TauserTool\temp md %windir%\TauserTool\temp
echo Hashing file for security reasons ...
echo Generating MD5 Hash ...
certutil -hashfile "%filename%" MD5 | findstr /V ":" >"%windir%\TauserTool\temp\md5hash.sys"

if %cls%==1 cls
echo MD5-Hash verification!
title MD5-Hash verification!
set /p returnedhash=<%windir%\TauserTool\temp\md5hash.sys
echo Is that your expected MD5 Hash?
echo Returned Hash: %returnedhash%
echo 1) Yes, execute file
echo 2) Yes, go back
echo 3) No, but execute file
echo 4) No, delete file and go back
set /p opt=Option: 
if %opt%==1 goto tools_installer_executeit
if %opt%==2 goto tools
if %opt%==3 goto tools_installer_executeit
if %opt%==4 goto tools_installer_deleteit
set gobackfromopt=tools_installer_dowload_checkhash
goto wrongopt

:tools_installer_executeit
echo Executing %filename% ...
start /min cmd /c "%filename%"
echo Done!
pause
goto home

:tools_installer_deleteit
echo Deleting %filename% ...
del "%filename%" /f /q
echo file Successfully deleted!
pause
goto tools


:tools_uninstaller
title Tools
if %cls%==1 cls
echo --- Program List Start ---
wmic product get name
echo --- ¨Program List End ---
echo Copy and Paste the name of the Program you want to uninstall (Enter "exit" to exit)
set /p programname=Program: 
if %programname%==exit goto tools
cls
echo Are you sure you want to uninstall "%programname%" ? (y/n)
set /p opt=Opt: 
if %opt%==y goto tools_uninstaller_uninstall
if %opt%==n goto tools
set gobackfromopt=tools_uninstaller
goto wrongopt

:tools_uninstaller_uninstall
cls
echo Uninstalling: "%programname%" ...
wmic product where name="%programname%" call uninstall
set errorcode=%errorlevel%
echo Process wmic.exe exited with Errorlevel %errorcode% ...
pause
goto tools

:tools_changebrightness
title Tools
for /f "skip=3 tokens=1" %%a in ('powershell -command "$PSVersionTable.PSVersion"') do set Major=%%a
if %Major% lss 3 (
if %cls%==1 cls
echo You can't change your Display Brightenss via PowerShell with your current PowerShell version, maybay i will add support in the near future...
pause
)
if %Major% lss 3 goto tools
if %cls%==1 cls
echo Enter the percentage of the Display Brightness (1-100).
rem for /f "tokens=2 delims==" %%a in ('powershell -Command "Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightness | findstr CurrentBrightness"') do set curbrightness=%%a
rem for /f "tokens=2 delims==" %%a in ('powershell -Command "Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightness | findstr InstanceName"') do set monitorname=%%a
rem echo Current Brightness: %curbrightness%
rem echo Screen Name: %monitorname%
set /p opt=Option: 
if %opt% LSS 1 if %opt% GTR 100 goto tools_changebrightness_fail
echo Changing Brightness...
powershell (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,%opt%)
echo Succesfully changed Display Brightenss to %opt%
goto tools

:tools_changebrightness_fail
if %cls%==1 cls
echo %opt% is not a valid value
echo Enter a value between 1 and 100
pause
goto tools_changebrightness


:tools_goto
title Tools
if %cls%==1 cls
echo --- Goto-Value ---
echo NOTE: THIS OPTION IS FOR EXPERIENCED USERS ONLY!
echo       IF YOU ENTER A WRONG VALUE, IT CAN CRASH YOUR SYSTEM!
echo Enter "home" or "tools" to go back!
echo.
set /p opt=Value: 
set /p opt1=Are you sure (yes/n) (n = back): 
if %opt1%==yes goto %opt%
if %opt1%==n goto tools
set gobackfromopt=tools_goto
goto wrongopt

:tools_forceclose
if %cls%==1 cls
title Tools
tasklist
echo Enter the corresponding Process Name.
echo Enter "exit" to exit
set /p opt=Process Name: 
if %opt%==exit goto tools
WMIC PROCESS WHERE Name="%opt%" CALL Terminate
echo Exited with Errorlevel %errorlevel%
taskkill /F /IM %opt%
echo Exited with Errorlevel: %errorlevel%
pause
goto tools

:tools_buildin
if %cls%==1 cls
title Tools
echo ----- Windows-Build-In Tools -----
echo.
echo 0) Back
echo 1) Paint
echo 2) WordPad
echo 3) Notepad
echo 4) Snipping Tool
echo 5) Color Manager
echo 6) Control Panel
echo 7) Device Manager
echo 8) Disk Management 
echo 9) Optional Features
echo 10) Resource Monitor
echo 11) Create Windows Recovery Media 
set /p opt=Option: 
if %opt%==0 goto tools
if %opt%==1 start mspaint.exe
if %opt%==2 start write.exe
if %opt%==3 start notepad.exe
if %opt%==4 start SnippingTool.exe
if %opt%==5 start colorcpl.exe
if %opt%==6 start control.exe
if %opt%==7 start devmgmt
if %opt%==8 start diskmgmt.msc
if %opt%==9 start OptionalFeatures.exe
if %opt%==10 start resmon.exe
if %opt%==11 start recdisc.exe
if %opt%==1 goto home
if %opt%==2 goto home
if %opt%==3 goto home
if %opt%==4 goto home
if %opt%==5 goto home
if %opt%==6 goto home
if %opt%==7 goto home
if %opt%==8 goto home
if %opt%==9 goto home
if %opt%==10 goto home
if %opt%==11 goto home
set gobackfromopt=tools_buildin
goto wrongopt
rem Cedb1549 bewertet diesen Code mit 9.5 von 10 Punkten :D
rem Er weis zwar nicht was der Code macht aber er bewertet es trozdem...