@echo off

rem =====================================================
rem All contents copyright 2004, Colin James Fitzpatrick
rem All rights reserved. YOU MAY NOT REMOVE THIS NOTICE
rem Read LICENSE.txt for licensing info
rem =====================================================

cls
echo.
echo RPGToolkit, Version 3 :: RegOcx
echo -------------------------------
echo.
echo This file will register two components used
echo by the RPGToolkit, Version 3 editor. This may fix
echo problems with the code editor, or editor in its
echo entirety, opening. The chances, however, aren't that
echo high because the installer also performs this task.
echo Therefore, this file is most useful if you have moved
echo the toolkit to a new directory or you know of a reason
echo why the installer would not have been able to register
echo said components (ie. being logged under an account
echo with insufficient capabilities). Regardless of your
echo situation, running this file can do no harm, so you
echo might as well try.
echo.
echo Registering the "SSTab" ActiveX control...
regsvr32 /s TABCTL32.OCX
echo Registering the "Rich Text Box" ActiveX control...
regsvr32 /s richtx32.ocx
echo.
echo Done!
echo.
echo [ Press any key to close this window ]
pause > nul
