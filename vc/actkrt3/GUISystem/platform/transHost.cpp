//-------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
// All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//-------------------------------------------------------------------

//-------------------------------------------------------------------
// Trans3 engine
//-------------------------------------------------------------------

//-------------------------------------------------------------------
// Include the header file
//-------------------------------------------------------------------
#include "transHost.h"					// Contains types, constants,
										// and prototypes for this file

//-------------------------------------------------------------------
// Definintions
//-------------------------------------------------------------------
#define FPS_CAP 120						// FPS cap

//-------------------------------------------------------------------
// Globals
//-------------------------------------------------------------------
static HWND hostHwnd = NULL;			// Handle of host window
static INT endFormBackgroundHDC = 0;	// HDC to a background picture for end form
static BOOL m_isActive = FALSE;			// We have the focus?
static BOOL m_exitDo = FALSE;			// End form closed?

//-------------------------------------------------------------------
// Callbacks
//-------------------------------------------------------------------

// No parameters
CBNoParams closeSystems;				// Shuts down trans3
CBNoParams forceRender;					// Forces render of screen

// No parameters, but returns a value
CBNoParamsRet isShuttingDown;			// Check if trans3 is shutting down
CBNoParamsRet getGameState;				// Get current state of logic (returns GS_ constant)

// One parameter
CBOneParam setAsciiKeyState;			// Sets the last ASCII value pressed
CBOneParam setGameState;				// Sets the current gameState (use GS_ constant)

// Two parameters
CBTwoParams keyDownEvent;				// Event on key down
CBTwoParams mouseMoveEvent;				// Event on mouse move

// Four params
CBFourParams mouseDownEvent;			// Event on mouse down

//-------------------------------------------------------------------
// Create the DirectX host window
//-------------------------------------------------------------------
INT APIENTRY createHostWindow(
                               INT x,			// x coord
							   INT y,			// y coord
							   INT width,		// width
							   INT height,		// height
							   INT style,		// style
							   LPSTR caption,	// caption
							   INT instance,	// instance
							   LPSTR className,	// name of class
							   INT hCursor		// cursor
										   )
{

	// This function will create the DirectX host window and return
	// a handle to it (hwnd)

    // Create a windows class and fill it in
    WNDCLASSEX wnd;
	wnd.cbClsExtra = NULL;
	wnd.cbSize = sizeof(wnd); // callback size == length of the structure
	wnd.cbWndExtra = NULL;
	wnd.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH); // black background
	if (hCursor == 0)
		wnd.hCursor = NULL;
	else
		wnd.hCursor = (HICON)hCursor;
	wnd.hIcon = NULL;
	wnd.hIconSm = NULL;
	wnd.hInstance = (HINSTANCE)instance; // instance of owning application
	wnd.lpfnWndProc = eventProcessor;
	wnd.lpszClassName = className; // name of this class
	wnd.lpszMenuName = NULL;
	wnd.style = CS_OWNDC; // style of window

    // Register the class so windows knows of its existence
    RegisterClassEx(&wnd);

    // Make sure we have a caption
    if (caption == NULL) caption = "RPGToolkit Version 3 Translator";

	// Create the window
	hostHwnd = CreateWindowEx( 
                               NULL,
                               className,
						       caption,
							   style,
							   x,
						       y,
							   width,
							   height,
							   NULL, NULL, (HINSTANCE)instance, 
							   NULL
							        );

	// Return its HWND
	return INT(hostHwnd);

}

//-------------------------------------------------------------------
// Trans main event loop
//-------------------------------------------------------------------
VOID APIENTRY mainEventLoop(CONST INT gameLogicAddress)
{

    // This is the main event loop of the whole trans3 engine.
    // It will process events in the DirectX host window and
    // send them to WndProc() (in transEvents). It also
    // continually calls gameLogic() (in transMain). The only
    // to break out of this loop is to call PostQuitMessage().

	// Create a pointer to the gameLogic procedure
	typedef VOID (__stdcall *FUNCTIONPOINTER)();
	CONST FUNCTIONPOINTER gameLogic = FUNCTIONPOINTER(gameLogicAddress);

	// Calculate how long one frame should take
	CONST DWORD dblOneFrame = 1000 / FPS_CAP;

	// Define a structure to hold the messages we recieve
    MSG message;

	while (TRUE)
	{

		if (PeekMessage(&message, NULL, 0, 0, PM_REMOVE))
		{
			// There was a message, check if it's eventProcessor() asking
            // to leave this loop...
            if (message.message == WM_QUIT)
			{
				// It was-- quit
				break;
			}
            else
			{
                // It wasn't, send the message to eventProcessor()
                TranslateMessage(&message);
                DispatchMessage(&message);
            }
        }

		// Get current time
		CONST DWORD dblTimeNow = GetTickCount();

		// Run a frame of game logic
        gameLogic();

		// Sleep for any remaining time
		while ((GetTickCount() - dblTimeNow) < dblOneFrame);

    }

	// Deallocate resources used by this library
	closeSystems();

}

//-------------------------------------------------------------------
// Initiate the event processor
//-------------------------------------------------------------------
VOID APIENTRY createEventCallbacks( 
                                    INT forceRender,		// VOID forceRender()
                                    INT closeSystems,		// VOID closeSystems()
                                    INT setAsciiKeyState,	// VOID setAsciiKeyState(INT key)
                                    INT keyDownEvent,		// VOID keyDownEvent(INT key, INT shift)
                                    INT mouseMoveEvent,		// VOID mouseMoveEvent(INT x, INT y)
									INT mouseDownEvent,		// VOID mouseDownEvent(INT x, INT y)
                                    INT isShuttingDown,		// INT isShuttingDown()
                                    INT getGameState,		// INT getGameState()
                                    INT setGameState		// VOID setGameState(INT newState)
                                                     )
{
	// Create all the callbacks
	::forceRender = (CBNoParams)forceRender;
	::closeSystems = (CBNoParams)closeSystems;
	::setAsciiKeyState = (CBOneParam)setAsciiKeyState;
	::keyDownEvent = (CBTwoParams)keyDownEvent;
	::mouseMoveEvent = (CBTwoParams)mouseMoveEvent;
	::mouseDownEvent = (CBFourParams)mouseDownEvent;
	::isShuttingDown = (CBNoParamsRet)isShuttingDown;
	::getGameState = (CBNoParamsRet)getGameState;
	::setGameState = (CBOneParam)setGameState;
}

//-------------------------------------------------------------------
// Process events
//-------------------------------------------------------------------
VOID APIENTRY processEvent(VOID)
{

    // This procedure is pretty much a replacement for DoEvents.
    // It will process a message from the queue *if there is one*
    // and then be done with.

    MSG message;
    if (PeekMessage(&message, NULL, 0, 0, PM_REMOVE))
	{
        // There was a message, check if it's eventProcessor() asking
        // to leave this loop...
        if (message.message == WM_QUIT)
		{
			// It was-- quit
			closeSystems();
		}
        else
		{
            // It wasn't, send the message to eventProcessor()
            TranslateMessage(&message);
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

	// Create a structure to use when painting the window
	PAINTSTRUCT ps;

	// Switch on the message we're to process
	switch (msg)
	{

		// Window needs painting
		case WM_PAINT:
		{

			// Begin painting the window
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
            if(wParam != WA_INACTIVE)
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
			return DefWindowProc(hwnd,msg,wParam,lParam);
		} break;

	}

	// Return success
	return TRUE;

}

//-------------------------------------------------------------------
// Show the end form
//-------------------------------------------------------------------
VOID APIENTRY showEndForm(INT endFormBackHdc, INT x, INT y, INT hIcon, INT hInstance)
{

    //-------------------------------------------------------------------
    // YOU MAY NOT REMOVE THIS NOTICE !!!!!!
    //-------------------------------------------------------------------

	endFormBackgroundHDC = endFormBackHdc;

    //Create a windows class and fill it in
    WNDCLASSEX wnd;
	wnd.cbClsExtra = NULL;
    wnd.cbSize = sizeof(wnd); //callback size == length of the structure
	wnd.cbWndExtra = NULL;
    wnd.hbrBackground = HBRUSH(GetStockObject(BLACK_BRUSH));
	wnd.hCursor = NULL;
	wnd.hIcon = HICON(hIcon);
	wnd.hIconSm = NULL;
	wnd.hInstance = HINSTANCE(hInstance); //instance of owning application
    wnd.lpfnWndProc = endFormWndProc; //Address of WinProc
    wnd.lpszClassName = "ENDFORM"; //name of this class
	wnd.lpszMenuName = NULL;
    wnd.style = CS_DBLCLKS | CS_OWNDC | CS_VREDRAW | CS_HREDRAW; //style of window

    //Register the class so windows knows of its existence
    RegisterClassEx(&wnd);

    //Create a window
    INT endFormHwnd = 0;
    endFormHwnd = (INT)CreateWindowEx(
                                       NULL,
                                       "ENDFORM",
									   "RPGToolkit Development System",
									   WS_OVERLAPPED | WS_CAPTION | WS_VISIBLE,
									   x,
									   y,
									   340,
									   142,
                                       NULL, NULL, HINSTANCE(hInstance),
                                       NULL
                                            );

	UpdateWindow(HWND(endFormHwnd));

	INT okHwnd = 0, moreInfoHwnd = 0;
	okHwnd = INT(CreateWindowEx(0, "button", "OK", WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON, 253, 10, 70, 22, HWND(endFormHwnd), HMENU(100), HINSTANCE(hInstance), 0));
	moreInfoHwnd = INT(CreateWindowEx(0, "button", "More Info", WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON, 253, 40, 70, 22, HWND(endFormHwnd), HMENU(101), HINSTANCE(hInstance), 0));

	SetFocus(HWND(okHwnd));

	MSG message;
	while (TRUE)
	{
		if (m_exitDo)
		{
			break;
		}
		else if (PeekMessage(&message, HWND(endFormHwnd), 0, 0, PM_REMOVE))
		{
			TranslateMessage(&message);
			DispatchMessage(&message);
		}
		else if ((GetAsyncKeyState(VK_RETURN) < 0) && (m_isActive))
		{
			DestroyWindow(HWND(endFormHwnd));
			break;
		}
	}

	m_exitDo = FALSE;

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
VOID APIENTRY killHostWindow(LPSTR windowClass, INT hInstance)
{
    CloseWindow(hostHwnd);
    DestroyWindow(hostHwnd);
    UnregisterClass(windowClass, HINSTANCE(hInstance));
}

//-------------------------------------------------------------------
// Change the caption of the host window
//-------------------------------------------------------------------
VOID APIENTRY changeHostWindowCaption(LPSTR newCaption)
{
	SetWindowText(hostHwnd, newCaption);
}

//-------------------------------------------------------------------
// End trans3
//-------------------------------------------------------------------
VOID APIENTRY endProgram(VOID)
{
	PostQuitMessage(0);
}
