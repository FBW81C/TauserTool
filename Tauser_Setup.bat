@echo off

REG ADD HKLM\Software\AdminTest /v Data /t REG_BINARY /d %random% /F
if not %errorlevel%==0 goto getadmin

:searchforTauserTool
if not exist %windir%\TauserTool\Tauser_Tool.bat goto setdownload
set main_downloadorstart=Start
set testdownloadorstart=0
goto set_version

:setdownload
set main_downloadorstart=Download
set testdownloadorstart=1
goto set_version

:set_version
if not exist %windir%\TauserTool md %windir%\TauserTool
if exist %windir%\TauserTool\local_version.sys goto main
set version=5.9
echo %version%>%windir%\TauserTool\local_version.sys
goto main

:main
if not exist %windir%\TauserTool\language.txt echo en>%windir%\TauserTool\language.txt
if exist %windir%\TauserTool\language.txt set /p language=<%windir%\TauserTool\language.txt
title Menu
cls

if %language%==en echo Here you can download or start Tauser Tool.
if %language%==en echo 1) %main_downloadorstart% Tauser Tool
if %language%==en echo 2) Update Tauser Tool
if %language%==en echo 3) Settings
if %language%==en echo 4) Exit Tauser Tool Setup

if %language%==de echo Hier kannst du Tauser Tool Herunterladen oder Öffnen. 
if %language%==de echo 1) %main_downloadorstart% Tauser Tool
if %language%==de echo 2) Update Tauser Tool
if %language%==de echo 3) Einstellungen
if %language%==de echo 4) Verlasse Tauser Tool Setup

if %language%==fr echo Ici, vous pouvez télécharger ou démarrer Tauser Tool.
if %language%==fr echo 1) %main_downloadorstart% Tauser Tool
if %language%==fr echo 2) Update Tauser Tool
if %language%==fr echo 3) Paramètres
if %language%==fr echo 4) Sortie Tauser Tool Setup

set /p opt=Option: 
if %opt%==1 goto downloadorstart
if %opt%==2 goto UpdateTauserTool
if %opt%==3 goto Settings
if %opt%==4 exit
echo This was no Option
pause
goto main

:downloadorstart
if %testdownloadorstart%==1 goto DownloadTauserTool
goto StartTauserTool


:DownloadTauserTool
title Download Tauser Tool
if not exist %windir%\TauserTool md %windir%\TauserTool
rem add Test for Insallation path
if not exist %windir%\TauserTool\wget goto test_wget
goto download_wget
rem if exist \\NAS_DS218\Test_2 goto DownloadTauserTool_NAS
echo There is no available Installation path.
pause
goto main
:DownloadTauserTool_Done
echo Download done!
goto searchforTauserTool

:test_wget
title Wget Licence
if not exist %windir%\TauserTool\wget md %windir%\TauserTool\wget
cls
echo By Continuing you accpet the Licence of wget!
echo 1) Download the Licence (Download with bitsadmin, this takes very long)
echo 2) I accept the Licence (Download Wget)

set /p opt=Option: 
if %opt%==1 goto download_licence
if %opt%==2 goto download_wget
cls
echo This is not a option
pause
goto test_wget

:download_licence
bitsadmin /transfer "TauserTool-wget" /PRIORITY HIGH "https://cdn.discordapp.com/attachments/744206114161295451/1079358436308947084/COPYING_WGET" "%userprofile%\Downloads\wget_licence.txt"
goto test_wget

:download_wget
title Downloading...
if exist %windir%\TauserTool\wget\wget.exe goto Downlaod_TauserTool_wget
bitsadmin /transfer "TauserTool-wget" /PRIORITY HIGH "https://eternallybored.org/misc/wget/1.19.4/32/wget.exe" "%windir%\TauserTool\wget\wget.exe"
if not exist %windir%\TauserTool\wget\wget.exe bitsadmin /transfer "TauserTool-wget" /PRIORITY HIGH "https://cdn.discordapp.com/attachments/744206114161295451/1079366391385305208/wget.exe" "%windir%\TauserTool\wget\wget.exe"
if not exist %windir%\TauserTool\wget\wget.exe goto download_wget_fail
goto Downlaod_TauserTool_wget

:download_wget_fail
title Error
cls
echo There is no Inernetconnetion or the Servers are not avaibable
echo Press any Key to retry
pause
goto download_wget

rem :DownloadTauserTool_NAS
rem xcopy \\NAS_DS218\Test_2\Tauser_Tool.bat %windir%\TauserTool\
rem xcopy \\NAS_DS218\Test_2\Tauser_Updater.bat %windir%\TauserTool\
rem goto DownloadTauserTool_Done

:Downlaod_TauserTool_wget
title Downloading
%windir%\TauserTool\wget\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/Tauser_Tool.bat -O%windir%\TauserTool\Tauser_Tool.bat
type nul>empty.sys
fc empty.sys %windir%\TauserTool\Tauser_Tool.bat
if %errorlevel%==0 goto Downlaod_TauserTool_wget_fail

%windir%\TauserTool\wget\wget.exe https://raw.githubusercontent.com/FBW81C/TauserTool/main/Tauser_Updater.bat -O%windir%\TauserTool\Tauser_Updater.bat
fc empty.sys %windir%\TauserTool\Tauser_Updater.bat
if %errorlevel%==0 goto Downlaod_TauserTool_wget_fail

del empty.sys
goto DownloadTauserTool_Done

:Downlaod_TauserTool_wget_fail
title Error
del empty.sys
cls
echo Tauser Tool wasn't properly downloaded. Try agian.
pause
exit


:StartTauserTool
title Starting...
if not exist %windir%\TauserTool\setupstuff md %windir%\TauserTool\setupstuff
if not exist %windir%\TauserTool\setupstuff\autoupdate_starting.txt echo 1 > %windir%\TauserTool\setupstuff\autoupdate_starting.txt
set /p testonoroffautoupdate=<%windir%\TauserTool\setupstuff\autoupdate_starting.txt
if %testonoroffautoupdate%==0 goto startTauserTool2
if exist %windir%\TauserTool\Tauser_Tool.bat goto startTauserTool1
if not exist %windir%\TauserTool\Tauser_Tool.bat echo Something went wrong, Tauser Tool was not installed or something failed.
if not exist %windir%\TauserTool\Tauser_Tool.bat echo If you read this message you destroyed something.
pause
exit



:UpdateTauserTool
title Update Tauser Tool
if not exist %windir%\TauserTool goto UpdateTauserTool_fail
call %windir%\TauserTool\Tauser_Updater.bat
echo Done!
pause
goto searchforTauserTool

:UpdateTauserTool_fail
title Error
cls
echo You must first install Tauser Tool before you can Update it.
pause
goto main

:UpdateTauserTool_fail1
title Error
echo There is no available path for updating Tauser Tool.
echo Hint: Check your Internet connection.
pause
goto main

:startTauserTool1
title Update and Start Tauser Tool
call %windir%\TauserTool\Tauser_Updater.bat
timeout 1 >NUL
:startTauserTool2
if exist %windir%\TauserTool\Tauser_Tool.bat goto startTauserTool3
echo Tauser Tool does not exist in the directory! Download Again
pause
exit

:startTauserTool3
start %windir%\TauserTool\Tauser_Tool.bat
exit

:Settings
title Settings
if not exist %windir%\TauserTool md %windir%\TauserTool
if not exist %windir%\TauserTool\setupstuff md %windir%\TauserTool\setupstuff
if not exist %windir%\TauserTool\setupstuff\autoupdate_starting.txt echo 1 > %windir%\TauserTool\setupstuff\autoupdate_starting.txt
set /p testonoroffautoupdate=<%windir%\TauserTool\setupstuff\autoupdate_starting.txt
if %testonoroffautoupdate%==1 set settings_onoroffautoupdate=Disable
if %testonoroffautoupdate%==0 set settings_onoroffautoupdate=Enable
cls
echo Note: Enable means that it is currently deactivated, Disable means that it is currently activated.
echo 1) %settings_onoroffautoupdate% Auto Update when starting Tauser Tool
echo 2) Language
echo 3) Back

set /p opt=Option: 
if %opt%==1 goto EnableorDisableAutoUpdate_Start
if %opt%==2 goto Language_settings
if %opt%==3 goto main
echo This is no Option
pause
goto Settings


:EnableorDisableAutoUpdate_Start
if %testonoroffautoupdate%==1 goto Disable
if %testonoroffautoupdate%==0 goto Enable
if not exist %windir%\TauserTool\setupstuff\autoupdate_starting.txt echo An Error occured (Open up Settings again).
pause
goto main


:Disable
echo 0 > %windir%\TauserTool\setupstuff\autoupdate_starting.txt
goto Settings

:Enable
echo 1 > %windir%\TauserTool\setupstuff\autoupdate_starting.txt
goto Settings





:Language_settings
cls
if not exist %windir%\TauserTool\language.txt echo en>%windir%\TauserTool\language.txt
if exist %windir%\TauserTool\language.txt set /p language=<%windir%\TauserTool\language.txt
title Language Settings
echo Current Language: %language%
echo 0) Back
echo 1) English / Englisch     / Anglais
echo 2) German  / Deutsch      / Allemand
echo 3) French  / Französisch  / Français

set /p opt=Option: 
if %opt%==0 goto Settings
if %opt%==1 goto set_en
if %opt%==2 goto set_de
if %opt%==3 goto set_fr
echo This is not a option
pause
goto Language_settings

:set_en
echo en>%windir%\TauserTool\language.txt
goto Language_settings
:set_de
echo de>%windir%\TauserTool\language.txt
goto Language_settings
:set_fr
echo fr>%windir%\TauserTool\language.txt
goto Language_settings



:getadmin
echo Erstmalige Installation wird ausgeführt...
echo Set UAC = CreateObject("Shell.Application") >%temp%\executeasmin.vbs
echo args = "ELEV " >>%temp%\executeasmin.vbs
echo For Each strArg in WScript.Arguments >>%temp%\executeasmin.vbs
echo args = args & strArg & " "  >>%temp%\executeasmin.vbs
echo Next >>%temp%\executeasmin.vbs
echo UAC.ShellExecute "%~f0", args, "", "runas", 1 >>%temp%\executeasmin.vbs
start /max %temp%\executeasmin.vbs
