# Microsoft Developer Studio Project File - Name="actkrt3" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=actkrt3 - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "actkrt3.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "actkrt3.mak" CFG="actkrt3 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "actkrt3 - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "actkrt3 - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "actkrt3 - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "actkrt3___Win32_Release"
# PROP BASE Intermediate_Dir "actkrt3___Win32_Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 1
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "actkrt3_EXPORTS" /YX /FD /c
# ADD CPP /nologo /MT /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "actkrt3_EXPORTS" /FR /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG" /NODEFAULTLIB:library
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 ddraw.lib dxguid.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib msimg32.lib /nologo /dll /machine:I386 /nodefaultlib:"library"
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "actkrt3 - Win32 Debug"

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
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "actkrt3_EXPORTS" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W2 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "actkrt3_EXPORTS" /FR /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib msimg32.lib ddraw.lib dxguid.lib /nologo /dll /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "actkrt3 - Win32 Release"
# Name "actkrt3 - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\actkrt3.cpp
# End Source File
# Begin Source File

SOURCE=.\actkrt3.def
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\actkrt3.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "tkgfx"

# PROP Default_Filter ""
# Begin Group "tkgfx - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkgfx\CTile.cpp
# End Source File
# Begin Source File

SOURCE=.\tkgfx\CTileCanvas.cpp
# End Source File
# Begin Source File

SOURCE=.\tkgfx\CUtil.cpp
# End Source File
# Begin Source File

SOURCE=.\tkgfx\Tkgfx.cpp
# End Source File
# End Group
# Begin Group "tkgfx - header"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkgfx\callbacks.h
# End Source File
# Begin Source File

SOURCE=.\tkgfx\CTile.h
# End Source File
# Begin Source File

SOURCE=.\tkgfx\CTileCanvas.h
# End Source File
# Begin Source File

SOURCE=.\tkgfx\CUtil.h
# End Source File
# Begin Source File

SOURCE=.\tkgfx\Resource.h
# End Source File
# Begin Source File

SOURCE=.\tkgfx\Tkgfx.h
# End Source File
# Begin Source File

SOURCE=.\tkgfx\tkpluglocalfns.h
# End Source File
# End Group
# End Group
# Begin Group "tkimage"

# PROP Default_Filter ""
# Begin Group "tkimage - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkimage\tkimage.cpp
# End Source File
# End Group
# Begin Group "tkimage - header"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkimage\FreeImage.h
# End Source File
# Begin Source File

SOURCE=.\tkimage\tkimage.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\tkimage\FreeImage.lib
# End Source File
# End Group
# Begin Group "tkzip No. 1"

# PROP Default_Filter ""
# Begin Group "tkzip - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkzip\tkzip.cpp
# End Source File
# End Group
# Begin Group "tkzip - header"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkzip\helper.h
# End Source File
# Begin Source File

SOURCE=.\tkzip\tkzip.h
# End Source File
# Begin Source File

SOURCE=.\tkzip\unzip.h
# End Source File
# Begin Source File

SOURCE=.\tkzip\zconf.h
# End Source File
# Begin Source File

SOURCE=.\tkzip\zip.h
# End Source File
# Begin Source File

SOURCE=.\tkzip\zipoperate.h
# End Source File
# Begin Source File

SOURCE=.\tkzip\zlib.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\tkzip\zlib.lib
# End Source File
# End Group
# Begin Group "tkCanvas"

# PROP Default_Filter ""
# Begin Group "tkCanvas - header"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkCanvas\CCanvasPool.h
# End Source File
# Begin Source File

SOURCE=.\tkCanvas\GDICanvas.h
# End Source File
# End Group
# Begin Group "tkCanvas - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkCanvas\CCanvasPool.cpp
# End Source File
# Begin Source File

SOURCE=.\tkCanvas\GDICanvas.cpp
# End Source File
# End Group
# End Group
# Begin Group "tkDirectX"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkDirectX\platform.cpp
# End Source File
# Begin Source File

SOURCE=.\tkDirectX\platform.h
# End Source File
# End Group
# Begin Group "md5"

# PROP Default_Filter ""
# Begin Group "md5 - Source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=".\md5-c\md5c.c"
# End Source File
# Begin Source File

SOURCE=".\md5-c\mddriver.c"
# End Source File
# Begin Source File

SOURCE=".\md5-c\tkmd5.cpp"
# End Source File
# End Group
# Begin Group "md5 - Headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=".\md5-c\global.h"
# End Source File
# Begin Source File

SOURCE=".\md5-c\md5.h"
# End Source File
# Begin Source File

SOURCE=".\md5-c\tkmd5.h"
# End Source File
# End Group
# End Group
# Begin Group "tkPlug"

# PROP Default_Filter ""
# Begin Group "tkPlug - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkPlug\tkPlug.cpp
# End Source File
# End Group
# Begin Group "tkPLug - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkPlug\plugDLL.h
# End Source File
# End Group
# End Group
# Begin Group "tkRPGCode"

# PROP Default_Filter ""
# Begin Group "tkRPGCode - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkrpgcode\tkrpgcode.cpp
# End Source File
# End Group
# Begin Group "tkRPGCode - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tkrpgcode\calculator.h
# End Source File
# Begin Source File

SOURCE=.\tkrpgcode\tkrpgcode.h
# End Source File
# End Group
# End Group
# Begin Group "audiere"

# PROP Default_Filter ""
# Begin Group "audiere - Header Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\audiere\audiere.h
# End Source File
# Begin Source File

SOURCE=.\audiere\TKAudiere.h
# End Source File
# End Group
# Begin Group "audiere - Source Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\audiere\TKAudiere.cpp
# End Source File
# End Group
# Begin Source File

SOURCE=.\audiere\audiere.lib
# End Source File
# End Group
# Begin Group "transClock"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\transClock.cpp
# End Source File
# End Group
# Begin Group "transHost"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\GUISystem\platform\transHost.cpp
# End Source File
# Begin Source File

SOURCE=.\GUISystem\platform\transHost.h
# End Source File
# End Group
# End Target
# Begin Group "tkzip"

# PROP Default_Filter ""
# End Group
# End Project
