//-------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//-------------------------------------------------------------------

//-------------------------------------------------------------------
// Trans3 engine
//-------------------------------------------------------------------

//-------------------------------------------------------------------
// Inclusions
//-------------------------------------------------------------------
#include "transHost.h"					// Contains types, constants,
										// and prototypes for this file

//-------------------------------------------------------------------
// Definitions
//-------------------------------------------------------------------
#define FPS_CAP 120.0					// FPS cap (also in transMain)

//-------------------------------------------------------------------
// Locals
//-------------------------------------------------------------------
static HWND hostHwnd = NULL;			// Handle of host window
static INT endFormBackgroundHDC;		// HDC to a background picture for end form
static BOOL m_isActive = FALSE;			// We have the focus?
static BOOL m_exitDo = FALSE;			// End form closed?
static double *m_renderTime = NULL;		// Pointer to m_renderTime in transMain.
static INT *m_renderCount = NULL;		// Pointer to m_renderCount in transMain.
static CBNoParams closeSystems;			// Shuts down trans3
static CBNoParams forceRender;			// Forces render of screen
static CBNoParamsRet isShuttingDown;	// Check if trans3 is shutting down
static CBNoParamsRet getGameState;		// Get current state of logic (returns GS_ constant)
static CBOneParam setAsciiKeyState;		// Sets the last ASCII value pressed
static CBOneParam setGameState;			// Sets the current gameState (use GS_ constant)
static CBTwoParams keyDownEvent;		// Event on key down
static CBTwoParams mouseMoveEvent;		// Event on mouse move
static CBFourParams mouseDownEvent;		// Event on mouse down

//-------------------------------------------------------------------
// Create the DirectX host window
//-------------------------------------------------------------------
INT APIENTRY createHostWindow(
	CONST INT x,			// X coord
	CONST INT y,			// Y coord
	CONST INT width,		// Width
	CONST INT height,		// Height
	CONST INT style,		// Style
	CONST LPSTR caption,	// Caption
	CONST INT instance,		// Instance
	CONST LPSTR className,	// Name of class
	CONST INT hCursor		// Cursor
		)
{

	// This function will create the DirectX host window and return
	// a handle to it (hwnd)

    // Create a windows class
    CONST WNDCLASSEX wnd = {
		sizeof(WNDCLASSEX),
		CS_OWNDC,
		eventProcessor,
		NULL,
		NULL,
		HINSTANCE(instance),
		NULL,
		HICON(hCursor),
		HBRUSH(GetStockObject(BLACK_BRUSH)),
		NULL,
		className,
		NULL
			};

    // Register the class so windows knows of its existence
    RegisterClassEx(&wnd);

	// Create the window
	hostHwnd = CreateWindowEx(
		NULL,
		className,
		caption ? caption : "RPGToolkit Version 3 Translator",
		style,
		x, y,
		width, height,
		NULL, NULL,
		HINSTANCE(instance),
		NULL
			);

	// Return its HWND
	return INT(hostHwnd);

}

//-------------------------------------------------------------------
// Trans main event loop
//-------------------------------------------------------------------
VOID APIENTRY mainEventLoop(
	CONST INT gameLogicAddress
		)
{

    // This is the main event loop of the whole trans3 engine.
    // It will process events in the DirectX host window and
    // send them to WndProc() (in transEvents). It also
    // continually calls gameLogic() (in transMain). The only
    // to break out of this loop is to call PostQuitMessage().

	// Create a pointer to the gameLogic procedure
	typedef VOID (__stdcall *FUNCTION_POINTER) (VOID);
	CONST FUNCTION_POINTER gameLogic = FUNCTION_POINTER(gameLogicAddress);

	// Calculate how long one frame should take, in milliseconds
	CONST DWORD dblOneFrame = DWORD(1000.0 / FPS_CAP);

	// Define a structure to hold the messages we recieve
    MSG message;

	while (TRUE)
	{

		// Get current time
		DWORD dblTimeNow = GetTickCount();

		if (PeekMessage(&message, NULL, 0, 0, PM_REMOVE))
		{
			// There was a message, check if it's eventProcessor() asking
            // to leave this loop
            if (message.message == WM_QUIT)
			{
				// It was; quit
				break;
			}
            else
			{
                // Change ascii keys and the like to virtual keys
				TranslateMessage(&message);
				// Send the message to the event processor
				DispatchMessage(&message);
            }
        }

		// Run a frame of game logic
		gameLogic();

		// Sleep for any remaining time
		while ((GetTickCount() - dblTimeNow) < dblOneFrame);

		// Update length rendering took
		dblTimeNow = GetTickCount() - dblTimeNow;

		// Add the time for this loop and increment the counter.
		// Add only if this is a short loop.
		if (dblTimeNow < 200)
		{
			(*m_renderTime) += double(dblTimeNow) / 1000.0; // (Should kill this division!)
			(*m_renderCount)++;
		}

    }

	// Deallocate resources used by this library
	closeSystems();

}

//-------------------------------------------------------------------
// Initiate the event processor
//-------------------------------------------------------------------
VOID APIENTRY createEventCallbacks( 
	CONST INT forceRender,		// VOID forceRender(VOID)
	CONST INT closeSystems,		// VOID closeSystems(VOID)
	CONST INT setAsciiKeyState,	// VOID setAsciiKeyState(CONST INT key)
	CONST INT keyDownEvent,		// VOID keyDownEvent(CONST INT key, CONST INT shift)
	CONST INT mouseMoveEvent,	// VOID mouseMoveEvent(CONST INT x, CONST INT y)
	CONST INT mouseDownEvent,	// VOID mouseDownEvent(CONST INT x, CONST INT y)
	CONST INT isShuttingDown,	// INT isShuttingDown(VOID)
	CONST INT getGameState,		// INT getGameState(VOID)
	CONST INT setGameState		// VOID setGameState(CONST INT newState)
		)
{
	// Copy over function addresses
	::forceRender = CBNoParams(forceRender);
	::closeSystems = CBNoParams(closeSystems);
	::setAsciiKeyState = CBOneParam(setAsciiKeyState);
	::keyDownEvent = CBTwoParams(keyDownEvent);
	::mouseMoveEvent = CBTwoParams(mouseMoveEvent);
	::mouseDownEvent = CBFourParams(mouseDownEvent);
	::isShuttingDown = CBNoParamsRet(isShuttingDown);
	::getGameState = CBNoParamsRet(getGameState);
	::setGameState = CBOneParam(setGameState);
}

//-------------------------------------------------------------------
// Process events
//-------------------------------------------------------------------
VOID APIENTRY processEvent(
	VOID
		)
{

    // This procedure is pretty much a replacement for DoEvents.
    // It will process a message from the queue *if there is one*
    // and then be done with.

    MSG message;
    if (PeekMessage(&message, NULL, 0, 0, PM_REMOVE))
	{
        // There was a message, check if it's eventProcessor() asking
        // to leave this loop
        if (message.message == WM_QUIT)
		{
			// It was; quit
			closeSystems();
		}
        else
		{
			// Change ascii keys and the like to virtual keys
			TranslateMessage(&message);
			// Send the message to the event processor
			DispatchMessage(&message);
        }
    }

}

//-------------------------------------------------------------------
// Trans3 event processor
//-------------------------------------------------------------------
LRESULT CALLBACK eventProcessor(
	HWND hwnd,
	UINT msg,
	WPARAM wParam,
	LPARAM lParam
		)
{

	// Last game state
	static INT prevGameState = GS_IDLE;

	// Switch on the message we're to process
	switch (msg)
	{

		// Window needs painting
		case WM_PAINT:
		{

			// Begin painting the window
			PAINTSTRUCT ps;
			BeginPaint(hwnd, &ps);

			// Force a render of the screen
			forceRender();

			// End of painting of the window
			EndPaint(hwnd, &ps);

		} break;

		//Window was closed
		case WM_DESTROY:
		{
			// Unless trans3 is already shutting down,
			// initiate the shut down process
			if (!isShuttingDown())
			{
				// Shut down
				closeSystems();
			}
		} break;

		// Key was pressed
		case WM_CHAR:
		{
			// Record the key
			setAsciiKeyState(INT(wParam));
		} break;

		// Key down
		case WM_KEYDOWN:
		{
			// Handle the key down event
			keyDownEvent(INT(wParam), 0);
		} break;

		// Mouse moved
		case WM_MOUSEMOVE:
		{
			// Handle the mouse move event
			mouseMoveEvent(LOWORD(lParam), HIWORD(lParam));
		} break;

		// Left mouse button clicked
		case WM_LBUTTONDOWN:
		{
			// Handle the event
			mouseDownEvent(LOWORD(lParam), HIWORD(lParam),0, 1);
		} break;

		// Window activated/deactivated
        case WM_ACTIVATE:
		{
            if (wParam != WA_INACTIVE)
			{
                //Window is being *activated*
                setGameState(prevGameState);
            }
			else
			{
                //Window is being *deactivated*
                prevGameState = getGameState();
                setGameState(GS_PAUSE);
            }
		} break;

		// Event we don't handle
		default:
		{
			// Let windows do the dirty work
			return DefWindowProc(hwnd, msg, wParam, lParam);
		} break;

	}

	// Return success
	return TRUE;

}

//-------------------------------------------------------------------
// Show the end form
//-------------------------------------------------------------------
VOID APIENTRY showEndForm(
	CONST INT endFormBackHdc,
	CONST INT x,
	CONST INT y,
	CONST INT hIcon,
	CONST INT hInstance
		)
{

	// Store the HDC
	endFormBackgroundHDC = endFormBackHdc;

    // Create a windows class
    CONST WNDCLASSEX wnd = {
		sizeof(WNDCLASSEX),
		CS_DBLCLKS | CS_OWNDC | CS_VREDRAW | CS_HREDRAW,
		endFormWndProc,
		NULL,
		NULL,
		HINSTANCE(hInstance),
		HICON(hIcon),
		NULL,
		HBRUSH(GetStockObject(BLACK_BRUSH)),
		NULL,
		"ENDFORM",
		NULL
			};

    // Register the class so windows knows of its existence
    RegisterClassEx(&wnd);

    // Create a window
	CONST HWND endFormHwnd = CreateWindowEx(
		NULL,
		"ENDFORM",
		"RPGToolkit Development System",
		WS_OVERLAPPED | WS_CAPTION | WS_VISIBLE,
		x, y,
		340, 142,
		NULL, NULL,
		HINSTANCE(hInstance),
		NULL
			);

	// Draw the window
	UpdateWindow(endFormHwnd);

	// Create the 'OK' button
	CONST HWND okHwnd = CreateWindowEx(
		NULL,
		"button",
		"OK",
		WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON,
		253, 10,
		70, 22,
		endFormHwnd,
		HMENU(100),
		HINSTANCE(hInstance),
		NULL
			);

	// Create the 'More Info' button
	CONST HWND moreInfoHwnd = CreateWindowEx(
		NULL,
		"button",
		"More Info",
		WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON,
		253, 40,
		70, 22,
		endFormHwnd,
		HMENU(101),
		HINSTANCE(hInstance),
		NULL
			);

	// Set focus to the 'OK' button
	SetFocus(okHwnd);

	// Declare a message struct
	MSG message;

	// Don't break yet
	m_exitDo = FALSE;

	while (TRUE)
	{
		if (m_exitDo)
		{
			// Break from this loop
			break;
		}
		else if (PeekMessage(&message, endFormHwnd, 0, 0, PM_REMOVE))
		{
			// Process the event
			TranslateMessage(&message);
			DispatchMessage(&message);
		}
		else if ((GetAsyncKeyState(VK_RETURN) < 0) && (m_isActive))
		{
			// Enter pressed
			DestroyWindow(endFormHwnd);
			break;
		}
	}

	// Unregister the class
	UnregisterClass("ENDFORM", HINSTANCE(hInstance));

}

//-------------------------------------------------------------------
// End form event handler
//-------------------------------------------------------------------
LRESULT CALLBACK endFormWndProc(
	HWND hwnd,
	UINT msg,
	WPARAM wParam,
	LPARAM lParam
		)
{

	//Switch on the message we're to handle
    switch (msg)
	{

        case WM_PAINT:
		{
            //Window needs to be repainted
            PAINTSTRUCT ps; HDC hdc;
            BeginPaint(hwnd, &ps);
            hdc = GetDC(hwnd);
            BitBlt(hdc, 1, 1, 372, 126, HDC(endFormBackgroundHDC), 0, 0, SRCPAINT);
            ReleaseDC(hwnd, hdc);
            EndPaint(hwnd, &ps);
		} break;

        case WM_DESTROY:
		{
            //Window was closed-- bail!
            m_exitDo = TRUE;
		} break;

        case WM_COMMAND:
		{
            switch (LOWORD(wParam))
			{

                case 100:
				{
                    //OK button pressed
                    DestroyWindow(hwnd);
                    m_exitDo = TRUE;
				} break;

                case 101:
				{
                    //More info button pressed
                    system("start http://www.toolkitzone.com");
                    DestroyWindow(hwnd);
                    m_exitDo = TRUE;
				} break;

            }
		} break;

        case WM_ACTIVATE:
		{
            m_isActive = (wParam != WA_INACTIVE);
		} break;

        default:
		{
            //Let windows deal with the rest
            return DefWindowProc(hwnd, msg, wParam, lParam);
		} break;

    }

	//Return success
	return TRUE;

}

//-------------------------------------------------------------------
// Kill the host window
//-------------------------------------------------------------------
VOID APIENTRY killHostWindow(
	CONST LPSTR windowClass,
	CONST INT hInstance
		)
{
    CloseWindow(hostHwnd);
    DestroyWindow(hostHwnd);
    UnregisterClass(windowClass, HINSTANCE(hInstance));
}

//-------------------------------------------------------------------
// Change the caption of the host window
//-------------------------------------------------------------------
VOID APIENTRY changeHostWindowCaption(
	CONST LPSTR newCaption
		)
{
	SetWindowText(hostHwnd, newCaption);
}

//-------------------------------------------------------------------
// End trans3
//-------------------------------------------------------------------
VOID APIENTRY endProgram(
	VOID
		)
{
	PostQuitMessage(0);
}

//-------------------------------------------------------------------
// Receive the fps variables from trans3
//-------------------------------------------------------------------
VOID APIENTRY initCounter(
	double *CONST ptrRenderTime,
	INT *CONST ptrRenderCount
		)
{
	// Point the members to the variables.
	m_renderTime = ptrRenderTime;
	m_renderCount = ptrRenderCount;
}
