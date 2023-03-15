@echo off && cls

net session >nul 2>&1

if %errorLevel% == 0 (
    echo.
) else (
    echo You need to run this script as administrator
    pause>nul
    exit
)

echo Please enter the path to the .exe folder...
set /p folder=
echo Please enter the .exe file name... ( also the .exe)
set /p exe=
echo How do you want this program to be "nicknamed"?...
set /p nick=
set out=C:\Users\%username%\StandalonePrograms\%nick%

mkdir %out%

xcopy /s /i %folder% %out%

echo Set oWS = WScript.CreateObject("WScript.Shell") > C:\Users\%username%\StandalonePrograms\CreateShortcut.vbs
echo sLinkFile = "%HOMEDRIVE%%HOMEPATH%\Desktop\%nick%.lnk" >> C:\Users\%username%\StandalonePrograms\CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> C:\Users\%username%\StandalonePrograms\CreateShortcut.vbs
echo oLink.TargetPath = "%out%\%exe%" >> C:\Users\%username%\StandalonePrograms\CreateShortcut.vbs
echo oLink.Save >> C:\Users\%username%\StandalonePrograms\CreateShortcut.vbs
cscript C:\Users\%username%\StandalonePrograms\CreateShortcut.vbs
del C:\Users\%username%\StandalonePrograms\CreateShortcut.vbs

echo msgbox "The folder was copied correctly!",,"Done!" > C:\Users\%username%\StandalonePrograms\temp.vbs

start C:\Users\%username%\StandalonePrograms\temp.vbs /separate

timeout /t 1 >nul

del C:\Users\%username%\StandalonePrograms\temp.vbs
