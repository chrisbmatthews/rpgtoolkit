@echo off
echo RPGToolkit, Version 3 :: Installation Builder
echo.
echo Please wait...
start /wait helper.exe setup.exe, zip.zip, setup.exe
start /wait helper.exe setup.exe, tkzip.dll, setup.exe
echo.
echo Done!
pause > nul
exit