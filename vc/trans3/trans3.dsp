# Microsoft Developer Studio Project File - Name="trans3" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=trans3 - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "trans3.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "trans3.mak" CFG="trans3 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "trans3 - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "trans3 - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "trans3 - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /w /W0 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /FR /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 ddraw.lib dxguid.lib msimg32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386

!ELSEIF  "$(CFG)" == "trans3 - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /w /W0 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /FR /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 ddraw.lib dxguid.lib msimg32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "trans3 - Win32 Release"
# Name "trans3 - Win32 Debug"
# Begin Group "rpgcode"

# PROP Default_Filter ""
# Begin Group "rpgcode - source"

# PROP Default_Filter "cpp"
# Begin Source File

SOURCE=.\rpgcode\CProgram\CProgram.cpp
# End Source File
# Begin Source File

SOURCE=.\rpgcode\functions.cpp
# End Source File
# Begin Source File

SOURCE=.\rpgcode\parser\parser.cpp
# End Source File
# End Group
# Begin Group "rpgcode - headers"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=.\rpgcode\CProgram\CProgram.h
# End Source File
# Begin Source File

SOURCE=.\rpgcode\CVariant\CVariant.h
# End Source File
# Begin Source File

SOURCE=.\rpgcode\parser\parser.h
# End Source File
# End Group
# End Group
# Begin Group "app"

# PROP Default_Filter ""
# Begin Group "app - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\app\winmain.cpp
# End Source File
# End Group
# Begin Group "app - headers"

# PROP Default_Filter ""
# End Group
# End Group
# Begin Group "common"

# PROP Default_Filter ""
# Begin Group "common - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\common\animation.cpp
# End Source File
# Begin Source File

SOURCE=.\common\background.cpp
# End Source File
# Begin Source File

SOURCE=.\common\board.cpp
# End Source File
# Begin Source File

SOURCE=.\common\CFile.cpp
# End Source File
# Begin Source File

SOURCE=.\common\item.cpp
# End Source File
# Begin Source File

SOURCE=.\common\mainfile.cpp
# End Source File
# Begin Source File

SOURCE=.\common\paths.cpp
# End Source File
# Begin Source File

SOURCE=.\common\player.cpp
# End Source File
# Begin Source File

SOURCE=.\common\tileanim.cpp
# End Source File
# Begin Source File

SOURCE=.\common\tilebitmap.cpp
# End Source File
# End Group
# Begin Group "common - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\common\animation.h
# End Source File
# Begin Source File

SOURCE=.\common\background.h
# End Source File
# Begin Source File

SOURCE=.\common\board.h
# End Source File
# Begin Source File

SOURCE=.\common\CFile.h
# End Source File
# Begin Source File

SOURCE=.\common\item.h
# End Source File
# Begin Source File

SOURCE=.\common\mainfile.h
# End Source File
# Begin Source File

SOURCE=.\common\paths.h
# End Source File
# Begin Source File

SOURCE=.\common\player.h
# End Source File
# Begin Source File

SOURCE=.\common\tileanim.h
# End Source File
# Begin Source File

SOURCE=.\common\tilebitmap.h
# End Source File
# End Group
# End Group
# Begin Group "directX"

# PROP Default_Filter ""
# Begin Group "directX - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkDirectX\platform.cpp
# End Source File
# End Group
# Begin Group "directX - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkDirectX\platform.h
# End Source File
# End Group
# End Group
# Begin Group "canvas"

# PROP Default_Filter ""
# Begin Group "canvas - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\CCanvasPool.cpp
# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\GDICanvas.cpp
# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\tkCanvas.cpp
# End Source File
# End Group
# Begin Group "canvas - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\CCanvasPool.h
# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\GDICanvas.h
# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\tkCanvas.h
# End Source File
# End Group
# End Group
# Begin Group "render"

# PROP Default_Filter ""
# Begin Group "render - source"

# PROP Default_Filter "cpp"
# Begin Source File

SOURCE=..\tkCommon\tkGfx\CTile.cpp
# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkGfx\CUtil.cpp
# End Source File
# Begin Source File

SOURCE=.\render\render.cpp
# End Source File
# End Group
# Begin Group "render - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkGfx\CTile.h
# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkGfx\CUtil.h
# End Source File
# Begin Source File

SOURCE=.\render\render.h
# End Source File
# End Group
# End Group
# Begin Group "input"

# PROP Default_Filter ""
# Begin Group "input - source"

# PROP Default_Filter "cpp"
# Begin Source File

SOURCE=.\input\input.cpp
# End Source File
# End Group
# Begin Group "input - headers"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=.\input\input.h
# End Source File
# End Group
# End Group
# Begin Group "misc"

# PROP Default_Filter ""
# Begin Group "misc - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\misc\misc.cpp
# End Source File
# End Group
# Begin Group "misc - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\misc\misc.h
# End Source File
# End Group
# End Group
# Begin Group "movement"

# PROP Default_Filter ""
# Begin Group "movement - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\movement\locate.cpp
# End Source File
# Begin Source File

SOURCE=.\movement\movement.cpp
# End Source File
# End Group
# Begin Group "movement - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\movement\locate.h
# End Source File
# Begin Source File

SOURCE=.\movement\movement.h
# End Source File
# End Group
# End Group
# End Target
# End Project
