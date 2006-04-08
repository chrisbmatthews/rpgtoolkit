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
!MESSAGE "trans3 - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE "trans3 - Win32 Unicode Debug" (based on "Win32 (x86) Application")
!MESSAGE "trans3 - Win32 Release MinSize" (based on "Win32 (x86) Application")
!MESSAGE "trans3 - Win32 Release MinDependency" (based on "Win32 (x86) Application")
!MESSAGE "trans3 - Win32 Unicode Release MinSize" (based on "Win32 (x86) Application")
!MESSAGE "trans3 - Win32 Unicode Release MinDependency" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "trans3 - Win32 Debug"

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
# ADD BASE CPP /nologo /W3 /Gm /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /w /W0 /Gm /GR /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /YX"stdafx.h" /FD /GZ /c
# ADD BASE RSC /l 0x1009 /d "_DEBUG"
# ADD RSC /l 0x1009 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 ddraw.lib dxguid.lib msimg32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib dinput8.lib winmm.lib strmiids.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# Begin Custom Build - Performing registration
OutDir=.\Debug
TargetPath=.\Debug\trans3.exe
InputPath=.\Debug\trans3.exe
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	"$(TargetPath)" /RegServer 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	echo Server registration done! 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "DebugU"
# PROP BASE Intermediate_Dir "DebugU"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "DebugU"
# PROP Intermediate_Dir "DebugU"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_UNICODE" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /W4 /WX /Gm /GX /ZI /Od /Ob2 /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_UNICODE" /FD /GZ /c
# SUBTRACT CPP /Fr /YX /Yc /Yu
# ADD BASE RSC /l 0x1009 /d "_DEBUG"
# ADD RSC /l 0x1009 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /entry:"wWinMainCRTStartup" /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 ddraw.lib dxguid.lib msimg32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib dinput8.lib winmm.lib strmiids.lib /nologo /entry:"wWinMainCRTStartup" /subsystem:windows /debug /machine:I386 /pdbtype:sept
# Begin Custom Build - Performing registration
OutDir=.\DebugU
TargetPath=.\DebugU\trans3.exe
InputPath=.\DebugU\trans3.exe
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	if "%OS%"=="" goto NOTNT 
	if not "%OS%"=="Windows_NT" goto NOTNT 
	"$(TargetPath)" /RegServer 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	echo Server registration done! 
	goto end 
	:NOTNT 
	echo Warning : Cannot register Unicode EXE on Windows 95 
	:end 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ReleaseMinSize"
# PROP BASE Intermediate_Dir "ReleaseMinSize"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "ReleaseMinSize"
# PROP Intermediate_Dir "ReleaseMinSize"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /O1 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_ATL_DLL" /D "_ATL_MIN_CRT" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /W4 /WX /GX /O1 /Ob2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_ATL_DLL" /D "_ATL_MIN_CRT" /FD /c
# SUBTRACT CPP /Fr /YX /Yc /Yu
# ADD BASE RSC /l 0x1009 /d "NDEBUG"
# ADD RSC /l 0x1009 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 ddraw.lib dxguid.lib msimg32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib dinput8.lib winmm.lib strmiids.lib /nologo /subsystem:windows /machine:I386
# Begin Custom Build - Performing registration
OutDir=.\ReleaseMinSize
TargetPath=.\ReleaseMinSize\trans3.exe
InputPath=.\ReleaseMinSize\trans3.exe
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	"$(TargetPath)" /RegServer 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	echo Server registration done! 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ReleaseMinDependency"
# PROP BASE Intermediate_Dir "ReleaseMinDependency"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "ReleaseMinDependency"
# PROP Intermediate_Dir "ReleaseMinDependency"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /O1 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_ATL_STATIC_REGISTRY" /D "_ATL_MIN_CRT" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /W4 /GR /GX /O1 /Ob2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_ATL_STATIC_REGISTRY" /Fr /FD /c
# ADD BASE RSC /l 0x1009 /d "NDEBUG"
# ADD RSC /l 0x1009 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 ddraw.lib dxguid.lib msimg32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib dinput8.lib winmm.lib strmiids.lib /nologo /subsystem:windows /machine:I386
# Begin Custom Build - Performing registration
OutDir=.\ReleaseMinDependency
TargetPath=.\ReleaseMinDependency\trans3.exe
InputPath=.\ReleaseMinDependency\trans3.exe
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	"$(TargetPath)" /RegServer 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	echo Server registration done! 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ReleaseUMinSize"
# PROP BASE Intermediate_Dir "ReleaseUMinSize"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "ReleaseUMinSize"
# PROP Intermediate_Dir "ReleaseUMinSize"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /O1 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "_ATL_DLL" /D "_ATL_MIN_CRT" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /W4 /WX /GX /O1 /Ob2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "_ATL_DLL" /D "_ATL_MIN_CRT" /FD /c
# SUBTRACT CPP /Fr /YX /Yc /Yu
# ADD BASE RSC /l 0x1009 /d "NDEBUG"
# ADD RSC /l 0x1009 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 ddraw.lib dxguid.lib msimg32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib dinput8.lib winmm.lib strmiids.lib /nologo /subsystem:windows /machine:I386
# Begin Custom Build - Performing registration
OutDir=.\ReleaseUMinSize
TargetPath=.\ReleaseUMinSize\trans3.exe
InputPath=.\ReleaseUMinSize\trans3.exe
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	if "%OS%"=="" goto NOTNT 
	if not "%OS%"=="Windows_NT" goto NOTNT 
	"$(TargetPath)" /RegServer 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	echo Server registration done! 
	goto end 
	:NOTNT 
	echo Warning : Cannot register Unicode EXE on Windows 95 
	:end 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ReleaseUMinDependency"
# PROP BASE Intermediate_Dir "ReleaseUMinDependency"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "ReleaseUMinDependency"
# PROP Intermediate_Dir "ReleaseUMinDependency"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /O1 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "_ATL_STATIC_REGISTRY" /D "_ATL_MIN_CRT" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /W4 /WX /GX /O1 /Ob2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "_ATL_STATIC_REGISTRY" /D "_ATL_MIN_CRT" /FD /c
# SUBTRACT CPP /Fr /YX /Yc /Yu
# ADD BASE RSC /l 0x1009 /d "NDEBUG"
# ADD RSC /l 0x1009 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 ddraw.lib dxguid.lib msimg32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib dinput8.lib winmm.lib strmiids.lib /nologo /subsystem:windows /machine:I386
# Begin Custom Build - Performing registration
OutDir=.\ReleaseUMinDependency
TargetPath=.\ReleaseUMinDependency\trans3.exe
InputPath=.\ReleaseUMinDependency\trans3.exe
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	if "%OS%"=="" goto NOTNT 
	if not "%OS%"=="Windows_NT" goto NOTNT 
	"$(TargetPath)" /RegServer 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	echo Server registration done! 
	goto end 
	:NOTNT 
	echo Warning : Cannot register Unicode EXE on Windows 95 
	:end 
	
# End Custom Build

!ENDIF 

# Begin Target

# Name "trans3 - Win32 Debug"
# Name "trans3 - Win32 Unicode Debug"
# Name "trans3 - Win32 Release MinSize"
# Name "trans3 - Win32 Release MinDependency"
# Name "trans3 - Win32 Unicode Release MinSize"
# Name "trans3 - Win32 Unicode Release MinDependency"
# Begin Group "winmain"

# PROP Default_Filter ""
# Begin Group "winmain - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\StdAfx.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# ADD CPP /Yc"stdafx.h"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

# SUBTRACT CPP /YX /Yc

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

# SUBTRACT CPP /YX /Yc

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

# SUBTRACT CPP /YX /Yc

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

# SUBTRACT CPP /YX /Yc

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\trans3.cpp
# End Source File
# Begin Source File

SOURCE=.\trans3.idl
# ADD MTL /tlb ".\trans3.tlb" /h "trans3.h" /iid "trans3_i.c" /Oicf
# End Source File
# Begin Source File

SOURCE=.\trans3.rc
# End Source File
# Begin Source File

SOURCE=.\app\winmain.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "winmain - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# Begin Source File

SOURCE=.\app\winmain.h
# End Source File
# End Group
# Begin Group "winmain - resources"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\resources\cursor.bmp
# End Source File
# Begin Source File

SOURCE=.\resources\mouse.bmp
# End Source File
# Begin Source File

SOURCE=.\trans3.rgs
# End Source File
# End Group
# End Group
# Begin Group "rpgcode"

# PROP Default_Filter ""
# Begin Group "rpgcode - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\rpgcode\CCursorMap.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\rpgcode\CProgram.cpp
# End Source File
# Begin Source File

SOURCE=.\rpgcode\functions.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# ADD CPP /YX"stdafx.h"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\rpgcode\parser\parser.cpp
# End Source File
# End Group
# Begin Group "rpgcode - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\rpgcode\CCursorMap.h
# End Source File
# Begin Source File

SOURCE=.\rpgcode\CProgram.h
# End Source File
# Begin Source File

SOURCE=.\rpgcode\parser\parser.h
# End Source File
# End Group
# End Group
# Begin Group "common"

# PROP Default_Filter ""
# Begin Group "common - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\common\animation.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\background.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE="..\tkCommon\movement\board conversion.cpp"
# End Source File
# Begin Source File

SOURCE=.\common\board.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\CAnimation.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\CFile.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\enemy.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\item.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\mainfile.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\mbox.cpp
# End Source File
# Begin Source File

SOURCE=.\common\paths.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\player.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\spcmove.cpp
# End Source File
# Begin Source File

SOURCE=.\common\sprite.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\state.cpp
# End Source File
# Begin Source File

SOURCE=.\common\status.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\tileanim.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\common\tilebitmap.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

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

SOURCE="..\tkCommon\movement\board conversion.h"
# End Source File
# Begin Source File

SOURCE=.\common\board.h
# End Source File
# Begin Source File

SOURCE=.\common\CAllocationHeap.h
# End Source File
# Begin Source File

SOURCE=.\common\CAnimation.h
# End Source File
# Begin Source File

SOURCE=.\common\CFile.h
# End Source File
# Begin Source File

SOURCE=.\common\CInventory.h
# End Source File
# Begin Source File

SOURCE=.\common\enemy.h
# End Source File
# Begin Source File

SOURCE=.\common\item.h
# End Source File
# Begin Source File

SOURCE=.\common\mainfile.h
# End Source File
# Begin Source File

SOURCE=.\common\mbox.h
# End Source File
# Begin Source File

SOURCE=.\common\paths.h
# End Source File
# Begin Source File

SOURCE=.\common\player.h
# End Source File
# Begin Source File

SOURCE=.\common\spcmove.h
# End Source File
# Begin Source File

SOURCE=.\common\sprite.h
# End Source File
# Begin Source File

SOURCE=.\common\state.h
# End Source File
# Begin Source File

SOURCE=.\common\status.h
# End Source File
# Begin Source File

SOURCE=.\common\tileanim.h
# End Source File
# Begin Source File

SOURCE=.\common\tilebitmap.h
# End Source File
# End Group
# End Group
# Begin Group "input"

# PROP Default_Filter ""
# Begin Group "input - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\input\input.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "input - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\input\input.h
# End Source File
# End Group
# End Group
# Begin Group "movement"

# PROP Default_Filter ""
# Begin Group "movement - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\movement\CItem\CItem.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\tkCommon\movement\coords.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# ADD CPP /FR
# SUBTRACT CPP /YX

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\movement\CPathFind\CPathFind.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# ADD CPP /FR
# SUBTRACT CPP /YX

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\movement\CPlayer\CPlayer.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\movement\CSprite\CSprite.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# ADD CPP /FR
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\movement\CVector\CVector.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# ADD CPP /FR
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "movement - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\movement\CItem\CItem.h
# End Source File
# Begin Source File

SOURCE=..\tkCommon\movement\coords.h
# End Source File
# Begin Source File

SOURCE=.\movement\CPathFind\CPathFind.h
# End Source File
# Begin Source File

SOURCE=.\movement\CPlayer\CPlayer.h
# End Source File
# Begin Source File

SOURCE=.\movement\CSprite\CSprite.h
# End Source File
# Begin Source File

SOURCE=.\movement\CVector\CVector.h
# End Source File
# Begin Source File

SOURCE=.\movement\movement.h
# End Source File
# End Group
# End Group
# Begin Group "render"

# PROP Default_Filter ""
# Begin Group "render - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\render\render.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "render - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\render\render.h
# End Source File
# End Group
# End Group
# Begin Group "misc"

# PROP Default_Filter ""
# Begin Group "misc - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\misc\misc.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "misc - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\misc\misc.h
# End Source File
# End Group
# End Group
# Begin Group "tkDirectX"

# PROP Default_Filter ""
# Begin Group "tkDirectX - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkDirectX\platform.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "tkDirectX - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkDirectX\platform.h
# End Source File
# End Group
# End Group
# Begin Group "tkCanvas"

# PROP Default_Filter ""
# Begin Group "tkCanvas - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\CCanvasPool.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\GDICanvas.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "tkCanvas - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\CCanvasPool.h
# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkCanvas\GDICanvas.h
# End Source File
# End Group
# End Group
# Begin Group "tkGfx"

# PROP Default_Filter ""
# Begin Group "tkGfx - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkGfx\CTile.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkGfx\CUtil.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "tkGfx - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\tkGfx\CTile.h
# End Source File
# Begin Source File

SOURCE=..\tkCommon\tkGfx\CUtil.h
# End Source File
# End Group
# End Group
# Begin Group "plugins"

# PROP Default_Filter ""
# Begin Group "plugins - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\plugins\Callbacks.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# ADD CPP /YX

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

# ADD CPP /W2
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\plugins\plugins.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "plugins - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\plugins\Callbacks.h
# End Source File
# Begin Source File

SOURCE=.\plugins\constants.h
# End Source File
# Begin Source File

SOURCE=.\plugins\oldCallbacks.h
# End Source File
# Begin Source File

SOURCE=.\plugins\plugins.h
# End Source File
# End Group
# Begin Group "plugins - resources"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Callbacks.rgs
# End Source File
# End Group
# End Group
# Begin Group "audio"

# PROP Default_Filter ""
# Begin Group "audio - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\audio\CAudioSegment.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "audio - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\audio\audiere.h
# End Source File
# Begin Source File

SOURCE=.\audio\CAudioSegment.h
# End Source File
# End Group
# Begin Group "audio - libraries"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\audio\audiere.lib
# End Source File
# End Group
# End Group
# Begin Group "images"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\tkCommon\images\FreeImage.h
# End Source File
# Begin Source File

SOURCE=..\tkCommon\images\FreeImage.lib
# End Source File
# End Group
# Begin Group "fight"

# PROP Default_Filter ""
# Begin Group "fight - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\fight\fight.cpp

!IF  "$(CFG)" == "trans3 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Debug"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Release MinDependency"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinSize"

!ELSEIF  "$(CFG)" == "trans3 - Win32 Unicode Release MinDependency"

!ENDIF 

# End Source File
# End Group
# Begin Group "fight - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\fight\fight.h
# End Source File
# Begin Source File

SOURCE=.\fight\IFighter.h
# End Source File
# End Group
# End Group
# Begin Group "video"

# PROP Default_Filter ""
# Begin Group "video - source"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\video\CVideo.cpp
# End Source File
# End Group
# Begin Group "video - headers"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\video\CVideo.h
# End Source File
# End Group
# End Group
# End Target
# End Project
