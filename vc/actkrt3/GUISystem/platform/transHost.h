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
#ifndef _TRANS_HOST_H_
#define _TRANS_HOST_H_
#pragma once

//-------------------------------------------------------------------
// Inclusions
//-------------------------------------------------------------------
#define WIN32_LEAN_AND_MEAN			// Obtain lean version of the API
#include <windows.h>				// Include the windows API
#include <cstdlib>					// Include some standard C stuff

//-------------------------------------------------------------------
// Type definitions
//-------------------------------------------------------------------
typedef VOID (__stdcall *CBNoParams) (VOID);
typedef INT (__stdcall *CBNoParamsRet) (VOID);
typedef VOID (__stdcall *CBOneParam) (INT);
typedef VOID (__stdcall *CBTwoParams) (CONST INT, CONST INT);
typedef VOID (__stdcall *CBFourParams) (CONST INT, CONST INT, CONST INT, CONST INT);

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

// Run the main event loop
VOID APIENTRY mainEventLoop(
	CONST INT gameLogicAddress
		);

// Create the host window
INT APIENTRY createHostWindow(
	CONST INT x,
	CONST INT y,
	CONST INT width,
	CONST INT height,
	CONST INT style,
	CONST LPSTR caption,
	CONST INT instance,
	CONST LPSTR className,
	CONST INT hCursor
		);

// Create the event callbacks
VOID APIENTRY createEventCallbacks(
	CONST INT forceRender,
	CONST INT closeSystems,
	CONST INT setAsciiKeyState,
	CONST INT keyDownEvent,
	CONST INT mouseMoveEvent,
	CONST INT mouseDownEvent,
	CONST INT isShuttingDown,
	CONST INT getGameState,
	CONST INT setGameState
		);

// Process an event from the queue
VOID APIENTRY processEvent(
	VOID
		);

// Show the end form
VOID APIENTRY showEndForm(
	CONST INT endFormBackHdc,
	CONST INT x,
	CONST INT y,
	CONST INT hIcon,
	CONST INT hInstance
		);

// Kill the host window
VOID APIENTRY killHostWindow(
	CONST LPSTR windowClass,
	CONST INT hInstance
		);

// Change the host window's caption
VOID APIENTRY changeHostWindowCaption(
	CONST LPSTR newCaption
		);

// End the program
VOID APIENTRY endProgram(
	VOID
		);

// Handle an event
LRESULT CALLBACK eventProcessor(
	HWND hwnd,
	UINT msg,
	WPARAM wParam,
	LPARAM lParam
		);

// Handle the end form
LRESULT CALLBACK endFormWndProc(
	HWND hwnd,
	UINT msg,
	WPARAM wParam,
	LPARAM lParam
		);

// Initiate the render counter
VOID APIENTRY initCounter(
	double *CONST ptrRenderTime,
	INT *CONST ptrRenderCount
		);

//-------------------------------------------------------------------
// End of the header file
//-------------------------------------------------------------------
#endif
