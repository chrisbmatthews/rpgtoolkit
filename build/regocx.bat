@echo off
echo Registering ocx controls...
regsvr32 /s picclp32.ocx
regsvr32 /s mci32.ocx
regsvr32 /s mscomctl.ocx
regsvr32 /s audiere.dll
echo Done