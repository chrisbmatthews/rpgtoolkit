//////////////////////////////////////////////////////////////////////////
//All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Trans3 engine :: C++ code :: Header
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Protect the header file
//////////////////////////////////////////////////////////////////////////
#ifndef TRANS_HOST_H
#define TRANS_HOST_H

//////////////////////////////////////////////////////////////////////////
// Inclusions
//////////////////////////////////////////////////////////////////////////
#define WIN32_LEAN_AND_MEAN			//Exclude MFC because it sucks
#include <windows.h>				//Include the windows API
#include <cstdlib>					//Include some standard C stuff

//////////////////////////////////////////////////////////////////////////
// Type definitions
//////////////////////////////////////////////////////////////////////////
typedef void (__stdcall* CBNoParams)();
typedef int (__stdcall* CBNoParamsRet)();
typedef void (__stdcall* CBOneParam)(int);
typedef void (__stdcall* CBTwoParams)(int,int);
typedef void (__stdcall* CBFourParams)(int,int,int,int);

//////////////////////////////////////////////////////////////////////////
// Game states
//////////////////////////////////////////////////////////////////////////
const int GS_IDLE = 0;              //just re-renders the screen
const int GS_QUIT = 1;              //shutdown sequence
const int GS_MOVEMENT = 2;          //movement is occurring (players or items)
const int GS_DONEMOVE = 3;          //movement is finished
const int GS_PAUSE = 4;             //pause game (do nothing)

//////////////////////////////////////////////////////////////////////////
// Globals
//////////////////////////////////////////////////////////////////////////
HWND hostHwnd = NULL;				//Handle of host window
int prevGameState = GS_IDLE;		//Last game state
int endFormBackgroundHDC = 0;		//hdc to a background picture for end form
bool m_isActive = false;			//we have the focus?
bool m_exitDo = false;				//end form closed?

//////////////////////////////////////////////////////////////////////////
// Callbacks
//////////////////////////////////////////////////////////////////////////

//No parameters
CBNoParams closeSystems;			//Shuts down trans3
CBNoParams forceRender;				//Forces render of screen

//No parameters, but returns a value
CBNoParamsRet isShuttingDown;		//Check if trans3 is shutting down
CBNoParamsRet getGameState;			//Get current state of logic (returns GS_ constant)

//One parameter
CBOneParam setAsciiKeyState;		//Sets the last ASCII value pressed
CBOneParam setGameState;			//Sets the current gameState (use GS_ constant)

//Two parameters
CBTwoParams keyDownEvent;			//Event on key down
CBTwoParams mouseMoveEvent;			//Event on mouse move

//Four params
CBFourParams mouseDownEvent;		//Event on mouse down

/////////////////////////////////////////////////////////////////////////
// Prototypes
/////////////////////////////////////////////////////////////////////////
void APIENTRY mainEventLoop(int gameLogicAddress);
int APIENTRY createHostWindow(int x, int y, int width, int height, int style, char* caption, int instance, char* className, int hCursor);
void APIENTRY createEventCallbacks(int forceRender, int closeSystems, int setAsciiKeyState, int keyDownEvent, int mouseMoveEvent, int mouseDownEvent, int isShuttingDown, int getGameState, int setGameState);
void APIENTRY processEvent();
void APIENTRY showEndForm(int endFormBackHdc, int x, int y, int hIcon, int hInstance);
void APIENTRY killHostWindow(char* windowClass, int hInstance);
void APIENTRY changeHostWindowCaption(char* newCaption);
void APIENTRY endProgram();
LRESULT CALLBACK eventProcessor(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam);
LRESULT CALLBACK endFormWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);

/////////////////////////////////////////////////////////////////////////
// End of the header file
/////////////////////////////////////////////////////////////////////////
#endif