//-------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
// All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//-------------------------------------------------------------------

//-------------------------------------------------------------------
// Trans3 engine :: C++ code :: Header
//-------------------------------------------------------------------

//-------------------------------------------------------------------
// Protect the header file
//-------------------------------------------------------------------
#ifndef TRANS_HOST_H
#define TRANS_HOST_H
#pragma once

//-------------------------------------------------------------------
// Inclusions
//-------------------------------------------------------------------
#define WIN32_LEAN_AND_MEAN			// Exclude MFC because it sucks
#include <windows.h>				// Include the windows API
#include <cstdlib>					// Include some standard C stuff

//-------------------------------------------------------------------
// Type definitions
//-------------------------------------------------------------------
typedef VOID (__stdcall *CBNoParams) ();
typedef INT (__stdcall *CBNoParamsRet) ();
typedef VOID (__stdcall *CBOneParam) (INT);
typedef VOID (__stdcall *CBTwoParams) (INT, INT);
typedef VOID (__stdcall *CBFourParams) (INT, INT, INT, INT);

//-------------------------------------------------------------------
// Game states
//-------------------------------------------------------------------
CONST INT GS_IDLE = 0;				// Just re-renders the screen
CONST INT GS_MOVEMENT = 1;			// Movement is occurring (players or items)
CONST INT GS_PAUSE = 2;				// Pause game (do nothing)
CONST INT GS_QUIT = 3;				// Shutdown sequence

//-------------------------------------------------------------------
// Prototypes
//-------------------------------------------------------------------
VOID APIENTRY mainEventLoop(CONST INT gameLogicAddress);
INT APIENTRY createHostWindow(INT x, INT y, INT width, INT height, INT style, LPSTR caption, INT instance, LPSTR className, INT hCursor);
VOID APIENTRY createEventCallbacks(INT forceRender, INT closeSystems, INT setAsciiKeyState, INT keyDownEvent, INT mouseMoveEvent, INT mouseDownEvent, INT isShuttingDown, INT getGameState, INT setGameState);
VOID APIENTRY processEvent(VOID);
VOID APIENTRY showEndForm(INT endFormBackHdc, INT x, INT y, INT hIcon, INT hInstance);
VOID APIENTRY killHostWindow(LPSTR windowClass, INT hInstance);
VOID APIENTRY changeHostWindowCaption(LPSTR newCaption);
VOID APIENTRY endProgram(VOID);
LRESULT CALLBACK eventProcessor(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam);
LRESULT CALLBACK endFormWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
VOID APIENTRY initCounter(double *ptrRenderTime,INT *ptrRenderCount);

//-------------------------------------------------------------------
// End of the header file
//-------------------------------------------------------------------
#endif
