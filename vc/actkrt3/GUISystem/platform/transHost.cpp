//////////////////////////////////////////////////////////////////////////
//All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Trans3 engine :: C++ code
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Include the header file
//////////////////////////////////////////////////////////////////////////
#include "transHost.h"			//Contains globals, types, constants,
								//and prototypes for this file

//////////////////////////////////////////////////////////////////////////
// Create the DirectX host window
//////////////////////////////////////////////////////////////////////////
int APIENTRY createHostWindow(
                               int x,			//x coord
							   int y,			//y coord
							   int width,		//width
							   int height,		//height
							   int style,		//style
							   char* caption,	//caption
							   int instance,	//instance
							   char* className,	//name of class
							   int hCursor		//cursor
										   )
{

	//This function will create the DirectX host window and return
	//a handle to it (hwnd)

    //Create a windows class and fill it in
    WNDCLASSEX wnd;
	wnd.cbClsExtra = NULL;
	wnd.cbSize = sizeof(wnd); //callback size == length of the structure
	wnd.cbWndExtra = NULL;
	wnd.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH); //black background
	if (hCursor == 0)
		wnd.hCursor = NULL;
	else
		wnd.hCursor = (HICON)hCursor;
	wnd.hIcon = NULL;
	wnd.hIconSm = NULL;
	wnd.hInstance = (HINSTANCE)instance; //instance of owning application
	wnd.lpfnWndProc = eventProcessor;
	wnd.lpszClassName = className; //name of this class
	wnd.lpszMenuName = NULL;
	wnd.style = CS_DBLCLKS | CS_OWNDC | CS_VREDRAW | CS_HREDRAW; //style of window

    //Register the class so windows knows of its existence
    RegisterClassEx(&wnd);

    //Make sure we have a caption
    if (caption == NULL) caption = "RPGToolkit Version 3 Translator";

	//Create the window
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

	//Return its HWND
    return (int)hostHwnd;

}

//////////////////////////////////////////////////////////////////////////
// Trans main event loop
//////////////////////////////////////////////////////////////////////////
void APIENTRY mainEventLoop(int gameLogicAddress)
{

    //This is the main event loop of the whole trans3 engine.
    //It will process events in the DirectX host window and
    //send them to WndProc() (in transEvents). It also
    //continually calls gameLogic() (in transMain). The only
    //to break out of this loop is to call PostQuitMessage().

	//Create a pointer to the gameLogic procedure
	typedef void (__stdcall* FUNCTIONPOINTER)();
	FUNCTIONPOINTER gameLogic;
	gameLogic = (FUNCTIONPOINTER)gameLogicAddress;

	//Define a structure to hold the messages we recieve
    MSG message;

	while (true)
	{

		if ( PeekMessage(&message, NULL, 0, 0, PM_REMOVE) )
		{
			//There was a message, check if it's eventProcessor() asking
            //to leave this loop...
            if (message.message == WM_QUIT)
			{
				//It was-- quit
				break;
			}
            else
			{
                //It wasn't, send the message to eventProcessor()
                TranslateMessage(&message);
                DispatchMessage(&message);
            }
        }

		//Run a frame of game logic
        gameLogic();

    }

	//Deallocate resources used by this library
	closeSystems();

}

//////////////////////////////////////////////////////////////////////////
// Initiate the event processor
//////////////////////////////////////////////////////////////////////////
void APIENTRY createEventCallbacks( 
                                    int forceRender,		//void forceRender()
                                    int closeSystems,		//void closeSystems()
                                    int setAsciiKeyState,	//void setAsciiKeyState(int key)
                                    int keyDownEvent,		//void keyDownEvent(int key, int shift)
                                    int mouseMoveEvent,		//void mouseMoveEvent(int x, int y)
									int mouseDownEvent,		//void mouseDownEvent(int x, int y)
                                    int isShuttingDown,		//int isShuttingDown()
                                    int getGameState,		//int getGameState()
                                    int setGameState		//void setGameState(int newState)
                                                     )
{
	//Create all the callbacks
	::forceRender = (CBNoParams)forceRender;
	::closeSystems = (CBNoParams)closeSystems;
	::setAsciiKeyState = (CBOneParam)setAsciiKeyState;
	::keyDownEvent = (CBTwoParams)keyDownEvent;
	::mouseMoveEvent = (CBTwoParams)mouseMoveEvent;
	::mouseDownEvent = (CBTwoParams)mouseDownEvent;
	::isShuttingDown = (CBNoParamsRet)isShuttingDown;
	::getGameState = (CBNoParamsRet)getGameState;
	::setGameState = (CBOneParam)setGameState;
}

//////////////////////////////////////////////////////////////////////////
// Process events
//////////////////////////////////////////////////////////////////////////
void APIENTRY processEvent()
{

    //This procedure is pretty much a replacement for DoEvents.
    //It will process a message from the queue *if there is one*
    //and then be done with.

    MSG message;
    if ( PeekMessage(&message, NULL, 0, 0, PM_REMOVE) )
	{
        //There was a message, check if it's eventProcessor() asking
        //to leave this loop...
        if ( message.message == WM_QUIT )
		{
				//It was-- quit
				closeSystems();
		}
        else
		{
            //It wasn't, send the message to eventProcessor()
            TranslateMessage(&message);
            DispatchMessage(&message);
        }
    }

}

//////////////////////////////////////////////////////////////////////////
// Trans3 event processor
//////////////////////////////////////////////////////////////////////////
LRESULT CALLBACK eventProcessor(
                                 HWND hwnd,
						         UINT msg,
                                 WPARAM wParam,
                                 LPARAM lParam
                                               )
{

	//Create a structure to use when painting the window
	PAINTSTRUCT ps;

	//Switch on the message we're to process
	switch(msg)
	{

		//Window needs painting
		case(WM_PAINT):
		{
			//Begin painting the window
			BeginPaint(hwnd,&ps);
			//Force a render of the screen
			forceRender();
			//End of painting of the window
			EndPaint(hwnd,&ps);
		} break;

		//Window was closed
		case(WM_DESTROY):
		{
			//Unless trans3 is already shutting down,
			//initiate the shut down process
			if (!isShuttingDown())
			{
				//Shut down
				closeSystems();
			}
		} break;

		//Key was pressed
		case(WM_CHAR):
		{
			//Record the key
			setAsciiKeyState((int)wParam);
		} break;

		//Key down
		case(WM_KEYDOWN):
		{
			//Handle the key down event
			keyDownEvent((int)wParam,0);
		} break;

		//Mouse moved
		case(WM_MOUSEMOVE):
		{
			//Handle the mouse move event
			mouseMoveEvent(LOWORD(lParam),HIWORD(lParam));
		} break;

		//Left mouse button clicked
		case(WM_LBUTTONDOWN):
		{
			//Handle the event
			mouseDownEvent(LOWORD(lParam),HIWORD(lParam));
		} break;

		//Window activated/deactivated
        case(WM_ACTIVATE):
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

		//Event we don't handle
		default:
		{
			//Let windows do the dirty work
			return DefWindowProc(hwnd,msg,wParam,lParam);
		} break;

	}

	//Return success
	return true;

}

//=========================================================================
// Show the end form
//=========================================================================
void APIENTRY showEndForm(int endFormBackHdc, int x, int y, int hIcon, int hInstance)
{

    //=========================================================================
    // YOU MAY NOT REMOVE THIS NOTICE !!!!!!
    //=========================================================================

    const char* WINDOW_CLASS = "ENDFORM";
	endFormBackgroundHDC = endFormBackHdc;

    //Create a windows class and fill it in
    WNDCLASSEX wnd;
	wnd.cbClsExtra = NULL;
    wnd.cbSize = sizeof(wnd); //callback size == length of the structure
	wnd.cbWndExtra = NULL;
    wnd.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
	wnd.hCursor = NULL;
	wnd.hIcon = (HICON)hIcon;
	wnd.hIconSm = NULL;
	wnd.hInstance = (HINSTANCE)hInstance; //instance of owning application
    wnd.lpfnWndProc = endFormWndProc; //Address of WinProc
    wnd.lpszClassName = WINDOW_CLASS; //name of this class
	wnd.lpszMenuName = NULL;
    wnd.style = CS_DBLCLKS | CS_OWNDC | CS_VREDRAW | CS_HREDRAW; //style of window

    //Register the class so windows knows of its existence
    RegisterClassEx(&wnd);

    //Create a window
    int endFormHwnd = 0;
    endFormHwnd = (int)CreateWindowEx(
                                       NULL,
                                       "ENDFORM",
									   "RPGToolkit Development System",
									   WS_OVERLAPPED | WS_CAPTION | WS_VISIBLE,
									   x,
									   y,
									   340,
									   142,
                                       NULL, NULL, (HINSTANCE)hInstance,
                                       NULL
                                            );

	UpdateWindow((HWND)endFormHwnd);

	int okHwnd = 0, moreInfoHwnd = 0;
	okHwnd = (int)CreateWindowEx(0, "button", "OK", WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON, 253, 10, 70, 22, (HWND)endFormHwnd, (HMENU)100, (HINSTANCE)hInstance, 0);
	moreInfoHwnd = (int)CreateWindowEx(0, "button", "More Info", WS_VISIBLE | WS_CHILD | BS_PUSHBUTTON, 253, 40, 70, 22, (HWND)endFormHwnd, (HMENU)101, (HINSTANCE)hInstance, 0);

	SetFocus((HWND)okHwnd);

	MSG message;
	while (true)
	{
		if(m_exitDo)
		{
			break;
		}
		else if (PeekMessage(&message, (HWND)endFormHwnd, 0, 0, PM_REMOVE))
		{
			TranslateMessage(&message);
			DispatchMessage(&message);
		}
		else if ((GetAsyncKeyState(VK_RETURN) < 0) && (m_isActive))
		{
			DestroyWindow((HWND)endFormHwnd);
			break;
		}
	}

	m_exitDo = false;

	UnregisterClass(WINDOW_CLASS, (HINSTANCE)hInstance);

}

//=========================================================================
// End form event handler
//=========================================================================
LRESULT CALLBACK endFormWndProc(
                                 HWND hwnd,
						         UINT msg,
                                 WPARAM wParam,
                                 LPARAM lParam
                                               )

{

	//Switch on the message we're to handle
    switch(msg)
	{

        case(WM_PAINT):
		{
            //Window needs to be repainted
            PAINTSTRUCT ps; HDC hdc;
            BeginPaint(hwnd, &ps);
            hdc = GetDC(hwnd);
            BitBlt(hdc, 1, 1, 372, 126, (HDC)endFormBackgroundHDC, 0, 0, SRCPAINT);
            ReleaseDC(hwnd, hdc);
            EndPaint(hwnd, &ps);
		} break;

        case(WM_DESTROY):
		{
            //Window was closed-- bail!
            m_exitDo = true;
		} break;

        case(WM_COMMAND):
		{
            switch(LOWORD(wParam))
			{

                case(100):
				{
                    //OK button pressed
                    DestroyWindow(hwnd);
                    m_exitDo = true;
				} break;

                case(101):
				{
                    //More info button pressed
                    system("start http://www.toolkitzone.com");
                    DestroyWindow(hwnd);
                    m_exitDo = true;
				} break;

            }
		} break;

        case(WM_ACTIVATE):
		{
            if(wParam != WA_INACTIVE)
			{
                //Window is being *activated*
                m_isActive = true;
            }
			else
			{
                //Window is being *deactivated*
                m_isActive = false;
            }
		} break;

        default:
		{
            //Let windows deal with the rest
            return DefWindowProc(hwnd, msg, wParam, lParam);
		} break;

    }

	//Return success
	return true;

}

//=========================================================================
// Kill the host window
//=========================================================================
void APIENTRY killHostWindow(char* windowClass, int hInstance)
{
    CloseWindow(hostHwnd);
    DestroyWindow(hostHwnd);
    UnregisterClass(windowClass, (HINSTANCE)hInstance);
}

//=========================================================================
// Change the caption of the host window
//=========================================================================
void APIENTRY changeHostWindowCaption(char* newCaption)
{
	SetWindowText(hostHwnd,newCaption);
}

//=========================================================================
// End trans3
//=========================================================================
void APIENTRY endProgram()
{
	PostQuitMessage(0);
}