//////////////////////////////////////////////////////////////////////////
//All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Inclusions
//////////////////////////////////////////////////////////////////////////
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

//////////////////////////////////////////////////////////////////////////
// Type definitions
//////////////////////////////////////////////////////////////////////////
typedef void (__stdcall* closeSystemsPointer)();

//////////////////////////////////////////////////////////////////////////
// Globals
//////////////////////////////////////////////////////////////////////////
HWND hostHwnd = NULL;				//Handle of host window
closeSystemsPointer closeSystems;	//Close systems procedure

/////////////////////////////////////////////////////////////////////////
// Prototypes
//////////////////////////////////////////////////////////////////////////
void APIENTRY mainEventLoop(int gameLogicAddress);
int APIENTRY createHostWindow(int x, int y, int width, int height, int style, char* caption, int instance, int wndProc, char* className, int hCursor);
void APIENTRY initEventProcessor(int closeSystemsAddress);
void APIENTRY processEvent();

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
							   int wndProc,		//window process
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
	wnd.lpfnWndProc = (long (__stdcall *)(struct HWND__ *,unsigned int,unsigned int,long))wndProc; //Address of WinProc
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

		if ( PeekMessage(&message, hostHwnd, 0, 0, PM_REMOVE) )
		{
			//There was a message, check if it's WndProc asking
            //to leave this loop...
            if (message.message == WM_QUIT)
			{
                //It was-- quit
                break;
			}
            else
			{
                //It wasn't, send the message to WndProc
                TranslateMessage(&message);
                DispatchMessage(&message);
            }
        }

		//Run a frame of game logic
        gameLogic();

    }

}

//////////////////////////////////////////////////////////////////////////
// Initiate the event processor
//////////////////////////////////////////////////////////////////////////
void APIENTRY initEventProcessor(int closeSystemsAddress)
{
	//Create pointer to closeSystems
	closeSystems = (closeSystemsPointer)closeSystemsAddress;
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
    if ( PeekMessage(&message, hostHwnd, 0, 0, PM_REMOVE) )
	{
        //There was a message, check if it's WinProc asking
        //to leave this loop...
        if ( message.message == WM_QUIT )
		{
            //It was-- quit
            closeSystems();
		}
        else
		{
            //It wasn't, send the message to WinProc
            TranslateMessage(&message);
            DispatchMessage(&message);
        }
    }

}