@echo off

:showChangelog
set showchangelog=0
if exist %windir%\TauserTool\Changelog\showChangelog.txt set /p showchangelog=<%windir%\TauserTool\Changelog\showChangelog.txt
if %showchangelog%==0 goto main
set newchangelog=0
if exist %windir%\TauserTool\Changelog\newChangelog.txt set /p newchangelog=<%windir%\TauserTool\Changelog\newChangelog.txt
if %newchangelog%==1 call %windir%\TauserTool\Changelog\Tauser_Changelog.bat
set 0 > %windir%\TauserTool\Changelog\newChangelog.txt


:main
if exist %windir%\TauserTool\language.txt set /p language=<%windir%\TauserTool\language.txt
title Tauser Tool Menu
color 0f
cls
echo Welcome at TauserTool, please choose an action.
echo Made by FBW81C#8994 (fbw81c@protonmail.com)
echo 1) Log In
echo 2) Sign Up
echo 3) Exit

set /p opt=Option: 
if %opt%==1 goto testmd
if %opt%==2 goto testmd1
exit




:testmd
if exist %windir%\TauserTool\logindatastuff goto testusers
md %windir%\TauserTool\logindatastuff
goto testmd

:testusers
if exist %windir%\TauserTool\logindatastuff\users goto testaccount
md %windir%\TauserTool\logindatastuff\users
goto testusers

:testmd1
if exist %windir%\TauserTool\logindatastuff goto testusers1
md %windir%\TauserTool\logindatastuff
goto testmd1

:testusers1
if exist %windir%\TauserTool\logindatastuff\users goto signin
md %windir%\TauserTool\logindatastuff\users
goto testusers1










:testaccount
title Tauser Tool Error
if exist %windir%\TauserTool\logindatastuff\users\* goto login
cls
echo You dont have an Account
pause
goto main


:login
title Tauser Tool Login
cls
echo Here you can login (if you want to exit type: exit).

set /p username_login=Username: 
if %username_login%==exit goto main
set /p code=Code: 
if not exist %windir%\TauserTool\logindatastuff\users\%username_login%\name.txt goto faillogin
if not exist %windir%\TauserTool\logindatastuff\users\%username_login%\key.txt goto faillogin
set /p username2=<%windir%\TauserTool\logindatastuff\users\%username_login%\name.txt
set /p code2=<%windir%\TauserTool\logindatastuff\users\%username_login%\key.txt
if %username2%==%username_login% if %code2%==%code% goto Auswahl
goto faillogin

:faillogin
title Tauser Tool Error
cls
echo You Typed the wrong username or Code
pause
goto login




:signin
title Tauser Tool Sign In
cls
echo Here you can create an acount.
echo Username and password are not encrypet (yet).

set /p username3=Username: 
set /p code1=Code: 
set /p code_confrim=Confrim Code: 
if exist %windir%\TauserTool\logindatastuff\users\%username3% goto failuserexist
if %code1%==%code_confrim% goto create_account
cls
echo You typed the wrong code
pause
goto signin





:create_account
md %windir%\TauserTool\logindatastuff\users\%username3%
echo %username3% > %windir%\TauserTool\logindatastuff\users\%username3%\name.txt
echo %code1% > %windir%\TauserTool\logindatastuff\users\%username3%\key.txt
cls
echo Account successfully created!
pause
goto main


:failuserexist
cls
echo This User does already exist. Please choose a other one name.
pause
goto signin











:Auswahl
if exist %windir%\TauserTool\logindatastuff\users\%username_login%\BackgroundColor\Color.txt goto importandsetColor
goto Auswahl1
:Auswahl1
title Tauser Tool
cls
echo Willkommen, %username_login% bei Tauser Tool! Version 1.3 by Lukas
echo 0) Logout
echo 1) Account Settings (Requires administrator privileges)
echo 2) Open cmd
echo 3) Open Notepad
echo 4) Backup Tool
echo 5) Mod Loader
echo 6) App Loader

set /p wahl=Option: 
if %wahl%==0 goto main
if %wahl%==1 goto account_settings
if %wahl%==2 start cmd.exe
if %wahl%==3 start notepad.exe
if %wahl%==5 goto modloader
if %wahl%==6 echo No
if %wahl%==7 echo No
cls
echo Ungültige Wahl
pause
goto Auswahl



:account_settings
rem REG ADD HKLM\Software\AdminTest /v Data /t REG_BINARY /d %random% /F
rem if not %errorlevel%==0 goto getadmin
title Tauser Tool Account Settings
cls
echo 1) Change Background Color
echo 2) Change Account Name
echo 3) Change Account Password
echo 4) Delete Account
echo 5) Back

set /p wahl=Option: 
if %wahl%==1 goto testmdBackground_Color
if %wahl%==2 goto Changeaccountname
if %wahl%==3 goto Changeaccountpassword
if %wahl%==4 goto deleteAccount
if %wahl%==5 goto Auswahl
goto Auswahl


:testmdBackground_Color
if exist %windir%\TauserTool\logindatastuff\users\%username_login%\BackgroundColor goto Background_Color
md %windir%\TauserTool\logindatastuff\users\%username_login%\BackgroundColor
goto testmdBackground_Color

:Background_Color
cls
color ?
set /p BackgroundColor=Color: 
echo %BackgroundColor% > %windir%\TauserTool\logindatastuff\users\%username_login%\BackgroundColor\Color.txt
goto Auswahl

:importandsetColor
set /p BackgroundColor=<%windir%\TauserTool\logindatastuff\users\%username_login%\BackgroundColor\Color.txt
color %BackgroundColor%
goto Auswahl1




:Changeaccountname
title Tauser Tool Change Account Name
cls
echo Your Username is: %username_login%
echo Do you want to change you username? (if not type: exit)
set /p newusername=New username: 
if %newusername%==exit goto account_settings
if %newusername%==%username_login% goto Changeaccountname_notpossible
set /p newusername_confirm=Confrim new username: 
if not %newusername_confirm%==%newusername% goto Changeaccountname_notsame
echo %newusername_confirm% > %windir%\TauserTool\logindatastuff\users\%username_login%\name.txt
ren %windir%\TauserTool\logindatastuff\users\%username_login% %newusername_confirm%
set /p username_login=<%windir%\TauserTool\logindatastuff\users\%newusername_confirm%\name.txt
goto Changeaccountname_finish

:Changeaccountname_notsame
cls
echo You have typed to wrong username
pause
goto Changeaccountname

:Changeaccountname_notpossible
cls
echo You can't change your username to your current username.
pause
goto Changeaccountname

:Changeaccountname_finish
cls
echo Successfully changed username
pause
goto Auswahl




:Changeaccountpassword
title Tauser Tool Change Account Password
cls
echo Do you want to change your Password? (if not type: exit)
set /p oldpassword=Current Password: 
if %oldpassword%==exit goto account_settings
set /p newpassword=New Password:
set /p newpassword_confirm=Confirm New Password:
set /p code2=<%windir%\TauserTool\logindatastuff\users\%username_login%\key.txt
if %newpassword%==%code2% goto Changeaccountpassword_notpossible
if not %newpassword%==%newpassword_confirm% goto Changeaccountpassword_notsame
if not %oldpassword%==%code2% goto Changeaccountpassword_notsame
echo %newpassword_confirm% > %windir%\TauserTool\logindatastuff\users\%username_login%\key.txt
set /p code2=<%windir%\TauserTool\logindatastuff\users\%username_login%\key.txt
goto Changeaccountpassword_finish


:Changeaccountpassword_notsame
cls
echo You have typed to wrong password or not your current password.
pause
goto Changeaccountpassword

:Changeaccountpassword_notpossible
cls
echo You can't change your password to your current password.
pause
goto Changeaccountpassword

:Changeaccountpassword_finish
cls
echo Successfully changed your account password.
pause
goto account_settings



:deleteAccount
title Tauser Tool Delete Account
cls
echo Here you can delete your Account (if not type: exit)
set /p current_password=Type your current Passsword: 
if %current_password%==exit goto Auswahl
if not exist %windir%\TauserTool\logindatastuff\users\%username_login%\key.txt goto deleteAccount_passwordnotsame
set /p password_check=<%windir%\TauserTool\logindatastuff\users\%username_login%\key.txt
if not %current_password%==%password_check% goto deleteAccount_passwordnotsame
:deleteAccount_ask
cls
echo Are you sure to delete your Account? (yes=y/no=n)
set /p opt=Option: 
if %opt%==n goto Auswahl
if %opt%==y goto deleteAccount_deletion
echo This was no choice
pause 
goto deleteAccount_ask

:deleteAccount_passwordnotsame
cls
echo You have typed the wrong password.
pause
goto deleteAccount


:deleteAccount_deletion
rd %windir%\TauserTool\logindatastuff\users\%username_login% /s /q
echo Successfully deletet your Account
pause
goto main




:modloader
rem Checking bunch of stuff
if not exist %userprofile%\AppData\Roaming\.minecraft goto modloader_nominecraftinstalled
if not exist %userprofile%\AppData\Roaming\.minecraft\mods goto modloader_nomodsfolder
if not exist %windir%\TauserTool\modloaderstuff md %windir%\TauserTool\modloaderstuff
if not exist %userprofile%\Documents\MCMods_TauserTool md %userprofile%\Documents\MCMods_TauserTool
rem Checking bunch of stuff
rem Checking for Mod Folder in Documents (create one). 
if not exist %userprofile%\Documents\MCMods_TauserTool\1.7.10 md %userprofile%\Documents\MCMods_TauserTool\1.7.10
if not exist %userprofile%\Documents\MCMods_TauserTool\1.12.2 md %userprofile%\Documents\MCMods_TauserTool\1.12.2
if not exist %userprofile%\Documents\MCMods_TauserTool\1.15.2 md %userprofile%\Documents\MCMods_TauserTool\1.15.2
if not exist %userprofile%\Documents\MCMods_TauserTool\1.19.2 md %userprofile%\Documents\MCMods_TauserTool\1.19.2
rem Add here a new version

rem Checking for Mod Folder in Documents (create one). 
if exist %windir%\TauserTool\modloaderstuff\currentmods.txt goto modloader_loadX
rem set (/) if none mods are loaded before
set Mods1710=(/)
set Mods1122=(/)
set Mods1152=(/)
set Mods1192=(/)
rem Add here a new version

rem set (/) if none mods are loaded before
:modloader_choice
title Tauser Tool Mod Loader
rem Just some Text
echo Warning! ALL current Minecraft Mods in the Minecraft Mod folder will be replaced with the choosen Mods!
echo Make sure your Mods are stored in C:\Users\"Your Username"\Documents\MCMods_TauserTool\"Name of the Mod Version" (Folder) for example 1.19.2\
echo Currently Supportet Mod Versions: 1.7.10, 1.12.2, 1.15.2, 1.19.2 (Send Mail to fbw81c@protonmail.com for further Mod Versions).
echo The current Mods are marked with an (X), those wich are not currently in the folder are marked with ().
rem Just some Text
rem Options
echo 0) Back
echo 1) %Mods1710% Mods 1.7.10
echo 2) %Mods1122% Mods 1.12.2
echo 3) %Mods1152% Mods 1.15.2
echo 4) %Mods1192% Mods 1.19.2
rem Add here a new version

rem Options
rem Test Options
set /p modloaderopt=Option: 
if %modloaderopt%==0 goto Auswahl
if %modloaderopt%==1 goto modloader_load1710
if %modloaderopt%==2 goto modloader_load1122
if %modloaderopt%==3 goto modloader_load1152
if %modloaderopt%==4 goto modloader_load1192
rem Add here a new version

echo This was not an Option
pause
goto modloader_choice

:modloader_nominecraftinstalled
title Tauser Tool Error
cls
echo You havn't downloaded Minecraft Java yet...
pause
goto Auswahl

:modloader_nomodsfolder
title Tauser Tool Error
cls
echo There is no C:\Users\"Your Username"\AppData\Roaming\.minecraft\mods folder
pause
goto Auswahl

:modloader_loadX
set /p loadX=<%windir%\TauserTool\modloaderstuff\currentmods.txt
if %loadX%==1710 goto modloader_setX1710
if %loadX%==1122 goto modloader_setX1122
if %loadX%==1152 goto modloader_setX1152
if %loadX%==1192 goto modloader_setX1192
rem Add here a new version

goto modloader_choice





rem set (X) or (/)
:modloader_setX1710
set Mods1710=(X)
set Mods1122=(/)
set Mods1152=(/)
set Mods1192=(/)
goto modloader_choice

:modloader_setX1122
set Mods1710=(/)
set Mods1122=(X)
set Mods1152=(/)
set Mods1192=(/)
goto modloader_choice

:modloader_setX1152
set Mods1710=(/)
set Mods1122=(/)
set Mods1152=(X)
set Mods1192=(/)
goto modloader_choice

:modloader_setX1192
set Mods1710=(/)
set Mods1122=(/)
set Mods1152=(/)
set Mods1192=(X)
goto modloader_choice
rem set (X) or (/)

rem Add here a new version


:modloader_load1710
del %userprofile%\AppData\Roaming\.minecraft\mods\* /q
copy %userprofile%\Documents\MCMods_TauserTool\1.7.10\* %userprofile%\AppData\Roaming\.minecraft\mods\
echo 1710 > %windir%\TauserTool\modloaderstuff\currentmods.txt
goto modloader_finish

:modloader_load1122
del %userprofile%\AppData\Roaming\.minecraft\mods\* /q
copy %userprofile%\Documents\MCMods_TauserTool\1.12.2\* %userprofile%\AppData\Roaming\.minecraft\mods\
echo 1122 > %windir%\TauserTool\modloaderstuff\currentmods.txt
goto modloader_finish

:modloader_load1152
del %userprofile%\AppData\Roaming\.minecraft\mods\* /q
copy %userprofile%\Documents\MCMods_TauserTool\1.15.2\* %userprofile%\AppData\Roaming\.minecraft\mods\
echo 1152 > %windir%\TauserTool\modloaderstuff\currentmods.txt
goto modloader_finish

:modloader_load1192
del %userprofile%\AppData\Roaming\.minecraft\mods\* /q
copy %userprofile%\Documents\MCMods_TauserTool\1.19.2\* %userprofile%\AppData\Roaming\.minecraft\mods\
echo 1192 > %windir%\TauserTool\modloaderstuff\currentmods.txt
goto modloader_finish

rem Add here a new version

:modloader_finish
cls
echo Successfully moved/copyied mods.
pause
goto Auswahl















rem :getadmin
rem echo Set UAC = CreateObject("Shell.Application") >%temp%\executeasmin.vbs
rem echo args = "ELEV " >>%temp%\executeasmin.vbs
rem echo For Each strArg in WScript.Arguments >>%temp%\executeasmin.vbs
rem echo args = args & strArg & " "  >>%temp%\executeasmin.vbs
rem echo Next >>%temp%\executeasmin.vbs
rem echo UAC.ShellExecute "%~f0", args, "", "runas", 1 >>%temp%\executeasmin.vbs
rem start /max %temp%\executeasmin.vbs
