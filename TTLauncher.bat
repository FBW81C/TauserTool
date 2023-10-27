@echo off
:reload
set version=0.1
set cls=1

echo Tauser Tool Version %version%
echo Made by FBW81C and JanGamesHD
echo Github: https://github.com/FBW81C/TauserTool
echo.
echo Checking for Admin...
REG ADD HKLM\Software\AdminTest /v Data /t REG_BINARY /d %random% /F
if not %errorlevel%==0 goto getadmin
goto afteradmin

:getadmin
title Tauser Tool: requesting Admin
echo Set UAC = CreateObject("Shell.Application") >%temp%\executeasmin.vbs
echo args = "ELEV " >>%temp%\executeasmin.vbs
echo For Each strArg in WScript.Arguments >>%temp%\executeasmin.vbs
echo args = args & strArg & " "  >>%temp%\executeasmin.vbs
echo Next >>%temp%\executeasmin.vbs
echo UAC.ShellExecute "%~f0", args, "", "runas", 1 >>%temp%\executeasmin.vbs
start /max %temp%\executeasmin.vbs
exit

:afteradmin
rem
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f
if "%username%"=="SYSTEM" reg add HKLM\System\Setup /v CmdLine /t REG_SZ /d "cmd.exe /k %systemdrive%\TTLauncher.bat" /f
if "%username%"=="SYSTEM" reg add HKLM\System\Setup /v SystemSetupInProgress /t REG_DWORD /d 1 /f
if "%username%"=="SYSTEM" reg add HKLM\System\Setup /v OOBEInProgress /t REG_DWORD /d 1 /f
if "%username%"=="SYSTEM" reg add HKLM\System\Setup /v SetupType /t REG_DWORD /d 2 /f
rem
echo Loading Settings
if not exist %windir%\TauserTool md %windir%\TauserTool
if not exist %windir%\TauserTool\Services md %windir%\TauserTool\Services
if not exist %windir%\TauserTool\Setup.sys goto Setup
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
goto loadhome


:Setup
if %cls%==1 cls
echo Welcome to Tauser Tool
echo Version: %version%
echo.
echo With Tauser Tool you can run the bare minimum of Windows.
echo Most applications work out of the Box (like Steam Games).
echo Minecraft does NOT work out of the Box however you can use Porti (from JanGamesHD).
echo You can download Porti from the Startmenu to play it!!!
echo.
echo Pls Subscribe on YouTube (FBW81C)
echo And watch the Tutorial.
pause
:Setup_Question1
if %cls%==1 cls
echo Now you can configurate Tauser Tool!
echo Part 1: Networking (Internet)
echo To select an option, type the coresponding Letter and Hit Enter (y = yes / n = no).
set /p opt=Would you like to connect to the Internt? (y/n): 
if %opt%==y goto networksetup
if %opt%==n goto Setup_Question2
set gobackfromopt=Setup_Question1
goto wrongopt

:wrongopt
echo This is not an Option!
echo To select an option, type the coresponding Letter and Hit Enter (y = yes / n = no).
pause
goto %gobackfromopt%

:Setup_Question2
if %cls%==1 cls
echo Part 2: Networking (Bluetooth)
echo Note: You need to pair a device in Windows before you can use it in Tauser Tool! (Someone from the Community should fix it! Because we have no idea how to)
set /p opt=Would you like to use Bluetooth? (y/n): 
if %opt%==y (
type NUL>%windir%\TauserTool\Services\bluetooth.sys
)
if %opt%==y goto Setup_Question3
if %opt%==n goto Setup_Question3
set gobackfromopt=Setup_Question2
goto wrongopt

:Setup_Question3
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
if %cls%==1 cls
echo Part 4: Updating
echo Please select your Updating preferences.
echo 1) Automatically Download and Install Updates
echo 2) Check for Updates but ask me before Downloading and Installing Updates.
echo 3) Don't check for Updates.
set /p opt=Option: 
if %opt%==1 (
echo True>%windir%\TauserTool\Services\updates.sys
)
if %opt%==2 (
echo Ask>%windir%\TauserTool\Services\updates.sys
)
if %opt%==3 (
echo False>%windir%\TauserTool\Services\updates.sys
)
if %opt%==1 goto Setup_Complete
if %opt%==2 goto Setup_Complete
if %opt%==3 goto Setup_Complete
set gobackfromopt=Setup_Question4
goto wrongopt

:networksetup
if %cls%==1 cls
echo Please select your preferred method to connect to the Internet.
echo Note: if your're using WiFi, you need to connect to the WiFi in Windows before you can use it in Tauser Tool!
echo 1) WiFi
echo 2) Ethernet (LAN) or an USB-Tethering device
echo 3) No i don't want to setup Internt anymore!
set /p opt=Option: 
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
goto Setup_Question2

:Setup_Complete
if %cls%==1 cls
echo The Setup is now complete!
echo Press any key to reload
pause>NUL
echo %version% >%windir%\TauserTool\Setup.sys
goto reload

:loadhome
if %cls%==1 cls
if exist %windir%\TauserTool\Services\updates.sys set /p updatesetting=<%windir%\TauserTool\Services\updates.sys
if exist %windir%\TauserTool\Services\updates.sys (
if %updatesetting%==True start /min cmd /c %windir%\TauserTool\Updater.bat
if %updatesetting%==Ask start /min cmd /c %windir%\TauserTool\Updater.bat
)
if exist %windir%\TauserTool\Updater\updateavailable.sys goto askforupdate
rem make askforupdate

:home
if %cls%==1 cls
echo Welcome to Tauser Tool!
echo Version: %version%
echo Made by FBW81C and JanGamesHD
echo.
echo 0) Exit / Shutdown / Reboot
echo 1) Start CMD
echo 2) 7-Zip File Manager
echo 3) Settings
echo 4) Install/ed Programs
echo 5) Porti
echo 9) Log off (Lock)
set /p opt=Option: 
if %opt%==0 goto exit
if %opt%==1 start cmd
if %opt%==1 goto home
if %opt%==2 goto check7z
if %opt%==3 goto settings
if %opt%==4 goto applications
if %opt%==5 goto launchPorti
if %opt%==9 goto lock
set gobackfromopt=home
goto wrongopt

:exit
if %cls%==1 cls
echo Here you can exit Tauser Tool
echo 1) Shutdown / Reboot to Windows
echo 2) Shutdown / Reboot to Tauser Tool
echo 3) Back
set /p opt=Option: 
if %opt%==1 goto windowsoptions
if %opt%==2 goto Tauseroptions
if %opt%==3 goto home
set gobackfromopt=exit
goto wrongopt

:windowsoptions
if %cls%==1 cls
echo 1) Reboot to Windows
echo 2) Shutdown to Windows
echo 3) Back
set /p opt=Option: 
if %opt%==1 set Tauseroptions_rs=r
if %opt%==2 set Tauseroptions_rs=s
if %opt%==1 goto rswin
if %opt%==2 goto rswin
if %opt%==3 goto exit
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
if %cls%==1 cls
echo 1) Reboot to Tauser Tool
echo 2) Shutdown to Tauser Tool
echo 3) Back
set /p opt=Option: 
if %opt%==1 set Tauseroptions_rs=r
if %opt%==2 set Tauseroptions_rs=s
if %opt%==1 goto rstau
if %opt%==2 goto rstau
if %opt%==3 goto exit
set gobackfromopt=Tauseroptions
goto wrongopt

:rstau
reg add HKLM\System\Setup /v CmdLine /t REG_SZ /d "cmd.exe /k %systemdrive%\TTLauncher.bat" /f
reg add HKLM\System\Setup /v SystemSetupInProgress /t REG_DWORD /d 1 /f
reg add HKLM\System\Setup /v OOBEInProgress /t REG_DWORD /d 1 /f
reg add HKLM\System\Setup /v SetupType /t REG_DWORD /d 2 /f
shutdown /f /%Tauseroptions_rs% /t 0

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

:settings
if %cls%==1 cls
echo Here you can change some stuff
echo.
echo 0) Back
echo 1) Lock Password
echo 2) Patch
set /p opt=Option: 
if %opt%==0 goto home
if %opt%==1 goto settings_lock
if %opt%==2 goto settings_patch
set gobackfromopt=settings
goto wrongopt

:settings_lock
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
if exist %windir%\TauserTool\Services\wifi.sys set SSID=<%windir%\TauserTool\Services\wifi.sys
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
set gobackfromopt=settings_patch
goto wrongopt
