// setup.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include "stdlib.h"
#include "windows.h"
#include "stdio.h"

char* GetProgramName();
char* RemoveChar(char* pstrString, char rm);
void Execute(char* pstrCommand);


int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{
	//run setup batch file...
	//int a=system("phase1.bat");
	char* pstrName = GetProgramName();
	if (pstrName != NULL) 
	{
		char strMsg[255];
		strcpy(strMsg, "Do you wish to install ");
		strcat(strMsg, RemoveChar(pstrName, '\n'));
		strcat(strMsg, "?");
		int a = MessageBox(NULL, strMsg, "Install", MB_YESNO);
		if (a == IDYES)
		{
			Execute("VBRun60sp5.exe /Q");
			Execute("phase2.exe");
			//system("VBRun60.exe /Q");
			//system("phase2.exe");
		}
		delete [] pstrName;
	}
	return 0;
}


//execute a program and wait for it...
void Execute(char* pstrCommand)
{
	STARTUPINFO start;
	PROCESS_INFORMATION info;
	start.cb = sizeof(start);
	start.cbReserved2 = 0;
	start.dwFillAttribute = 0;
	start.dwFlags = 0;
	start.dwX = 0;
	start.dwXCountChars = 0;
	start.dwXSize = 0;
	start.dwY = 0;
	start.dwYCountChars = 0;
	start.dwYSize = 0;
	start.hStdError = 0;
	start.hStdInput = 0;
	start.hStdOutput = 0;
	start.lpDesktop = 0;
	start.lpReserved = 0;
	start.lpReserved2 = 0;
	start.lpTitle = 0;
	start.wShowWindow = 0;
	
	CreateProcess(0, pstrCommand, 0, 0, 1, NORMAL_PRIORITY_CLASS, 0, 0, &start, &info);
	WaitForSingleObject(info.hProcess, INFINITE);
	CloseHandle(info.hThread);
	CloseHandle(info.hProcess);
}


//get the program name from setup.ini
char* GetProgramName()
{
	char* pstrRet = new char[255];
	FILE* f = fopen("setup.inf", "rt");
	if (f == NULL)
	{
		MessageBox(NULL, "Cannot open setup.inf", "Cannot install", MB_OK);
		delete [] pstrRet;
		return NULL;
	}

	fgets(pstrRet, 255, f);
	return pstrRet;
}


//remove a character from a string.
char* RemoveChar(char* pstrString, char rm)
{
	char* pstrRet = new char[strlen(pstrString)+1];
	unsigned int i=0;
	unsigned int j=0;
	pstrRet[0] = '\0';
	for (j=0; j<strlen(pstrString); j++)
	{
		char part = pstrString[j];
		if (part != rm)
		{
			pstrRet[i] = part;
			pstrRet[i+1] = '\0';
			i++;
		}
	}
	return pstrRet;
}