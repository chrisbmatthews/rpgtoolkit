//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

/************************************************
 Christopher B. Matthews
 platform.h
 Include file for accessing graphics system.

 ************************************************/

#ifndef PLATFORM_H
#define PLATFORM_H

//comment out to use the GDI instead of GDI (for debugging)
//#define USE_DIRECTX

//INCLUDES...
#include <windows.h>
#include <string>
#include "ddraw.h"	//for DirectX
#include "..\..\tkCanvas\GDICanvas.h"	//for gdi canvas objects


//Definition of an RGB color...
typedef struct colorTag
{
	unsigned char red;
	unsigned char green;
	unsigned char blue;
} RGBCOLOR;


//Definition of important DirectX data...
typedef struct dxInfoTag
{
	LPDIRECTDRAW7 lpdd;									//main direct draw object
	LPDIRECTDRAWSURFACE7 lpddsPrime;		//direct draw primary surface
	LPDIRECTDRAWSURFACE7 lpddsSecond;		//direct draw back buffer
	int nWidth;													//width of surafces
	int nHeight;												//height of surafces
	LPDIRECTDRAWCLIPPER lpddclip;				//clipper (for windowed mode only)
	bool bFullScreen;										//running in fullscreen mode?
	int nColorDepth;										//color depth
} DXINFO;

class CGDICanvas;

//code for Windows...
LRESULT CALLBACK TheWindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam);

//////////////////////////////////////////////////////////
//
// Supporting Code
//
//////////////////////////////////////////////////////////
DXINFO InitDirectX(HWND hWnd, int nWidth, int nHeight, long nColorDepth, bool bFullScreen);

HDC OpenDC();
void CloseDC(HDC hdc);

//////////////////////////////////////////////////////////
//
// Graphics System
//
//////////////////////////////////////////////////////////
bool InitGraphicsMode(HWND hWndHost, int nWidth, int nHeight, bool bUseDirectX, long nColorDepth, bool bFullScreen);
bool KillGraphicsMode();
bool DrawPixel(int x, int y, long clr);
bool DrawLine(int x1, int y1, int x2, int y2, long clr);
bool DrawFilledRect(int x1, int y1, int x2, int y2, long clr);
bool DrawGradientRect(int x1, int y1, int x2, int y2, long clr1, long clr2);
bool Refresh();
bool DrawText(int x, int y, std::string strText, std::string strTypeFace, int size, long clr, bool bold = false, bool italics = false, bool underline = false, bool centred = false, bool outlined = false);
CGDICanvas* CreateCanvas(int nWidth, int nHeight, bool bUseDX = false);
int CopyScreenToCanvas(CGDICanvas* pCanvas);
bool DrawCanvas(CGDICanvas* pCanvas, int x, int y, long lRasterOp = SRCCOPY);
bool DrawCanvasTransparent(CGDICanvas* pCanvas, int x, int y, long crTransparentColor);
bool DrawCanvasTranslucent(CGDICanvas* pCanvas, int x, int y, double dIntensity, long crUnaffectedColor, long crTransparentColor);
bool DrawCanvasPartial(CGDICanvas* pCanvas, int destx, int desty, int srcx, int srcy, int width, int height, long lRasterOp = SRCCOPY);
bool DrawCanvasTransparentPartial(CGDICanvas* pCanvas, int destx, int desty, int srcx, int srcy, int width, int height, long crTransparentColor);
void ClearScreen(long crColor);
long GetPixelColor(int x, int y);

bool LockScreen();
bool UnlockScreen();
//bool SetClippingRect(int x, int y, int width, int height);
//bool ClearClipping();

//////////////////////////////////////////////////////////
//
// Message Handling System
//
//////////////////////////////////////////////////////////
//valid nType messages:
#define EVT_MOUSEMOVE 0
#define EVT_MOUSEDOWN 1
#define EVT_MOUSEUP 2
#define EVT_DOUBLECLICK 3
#define EVT_KEYDOWN 4		//key is first pressed
#define EVT_KEYPRESS 5	//key is pressed and released

//virtual keys...
#define KEY_LEFT 37
#define KEY_RIGHT 39
#define KEY_BACKSPACE 8
#define KEY_DELETE 46

//mouse state structure...
typedef struct tagMouseState
{
	int x, y;		//mouse position

	bool bCTRL;		//ctrl key down?
	bool bSHIFT;	//shift key down?
	bool bLButton;	//left button down?
	bool bMButton;	//middle button down?
	bool bRButton;	//right button down?
	bool bLButtonActive;	//left button is primary focus (ie, coming up or double clicked)
	bool bMButtonActive;	//middle button is primary focus (ie, coming up or double clicked)
	bool bRButtonActive;	//right button is primary focus (ie, coming up or double clicked)
} MOUSESTATE;


typedef void (*EVENT_HANDLER) (int nType, MOUSESTATE mouseState, int nASCIICode);	//definition for message handler

void SetCustomEventHandler(EVENT_HANDLER eh);

#endif