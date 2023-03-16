@echo off && cls
net session >nul 2>&1
if %errorLevel% == 0 ( echo. ) else ( echo You need to run this script as administrator && pause>nul
exit )
set spath=%userprofile%\StandalonePrograms
echo Please enter the path to the .exe folder... && set /p folder=
echo Please enter the .exe file name... ( also the .exe) && set /p exe=
echo How do you want this program to be "nicknamed"?... && set /p nick= && set out=%spath%\%nick%
mkdir %out% && cls && echo Creating files, wait... 
xcopy /s /i %folder% %out%>nul && cls
echo Set oWS = WScript.CreateObject("WScript.Shell") > %spath%\CreateShortcut.vbs
echo sLinkFile = "%HOMEDRIVE%%HOMEPATH%\Desktop\%nick%.lnk" >> %spath%\CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %spath%\CreateShortcut.vbs
echo oLink.TargetPath = "%out%\%exe%" >> %spath%\CreateShortcut.vbs
echo oLink.Save >> %spath%\CreateShortcut.vbs
cscript %spath%\CreateShortcut.vbs>nul && del %spath%\CreateShortcut.vbs && echo msgbox "The folder was copied correctly!",,"Done!" > %spath%\temp.vbs
start %spath%\temp.vbs /separate && timeout /t 1 >nul
del %spath%\temp.vbs && @echo on && cls
