@echo off
cls
echo.
echo RPGToolkit, Version 3 :: RegOcx
echo -------------------------------
echo.
echo This file will register three components used
echo by the RPGToolkit, Version 3 editor. This may fix
echo problems with the code editor, or editor in its
echo entirety, opening. The chances, however, aren't that
echo high because the installer also performs this task.
echo Therefore, this file is most useful if you have moved
echo the toolkit to a new directory or you know of a reason
echo why the installer would not have been able to register
echo said components (i.e., being logged under an account
echo with insufficient capabilities). Regardless of your
echo situation, running this file can do no harm, so you
echo might as well try.
echo.
echo Registering Microsoft's Common Controls...
rundll32 mscomctl.ocx, DllRegisterServer
echo Registering the "SSTab" ActiveX control...
rundll32 tabctl32.ocx, DllRegisterServer
echo Registering the "Rich Text Box" ActiveX control...
rundll32 richtx32.ocx, DllRegisterServer
echo.
echo Done!
echo.
echo [ Press any key to close this window ]
pause > nul
