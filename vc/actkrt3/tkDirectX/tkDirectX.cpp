//------------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Exportable interface to tkDirectX
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Inclusions
//------------------------------------------------------------------------
#include "tkDirectX.h"				// Stuff for this file

//------------------------------------------------------------------------
// Globals
//------------------------------------------------------------------------
CDirectDraw *g_pDirectDraw = NULL;	// Main DirectDraw object

//------------------------------------------------------------------------
// Initiate DirectX
//------------------------------------------------------------------------
BOOL APIENTRY DXInitGfxMode(
	CONST INT hostHwnd,
	CONST INT nScreenX,
	CONST INT nScreenY,
	CONST BOOL nUseDirectX,
	CONST INT nColorDepth,
	CONST BOOL nFullScreen
		)
{

	// Create a new DirectDraw object
	g_pDirectDraw = new CDirectDraw();

	// Initialize the graphics mode
	return g_pDirectDraw->InitGraphicsMode(HWND(hostHwnd), nScreenX, nScreenY, nUseDirectX, nColorDepth, nFullScreen);

}

//------------------------------------------------------------------------
// Kill DirectX
//------------------------------------------------------------------------
BOOL APIENTRY DXKillGfxMode(
	VOID
		)
{

	// Kill DirectDraw
	delete g_pDirectDraw;
	g_pDirectDraw = NULL;

	// All's good
	return TRUE;

}

//------------------------------------------------------------------------
// Plot a pixel onto the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXDrawPixel(
	CONST INT x,
	CONST INT y,
	CONST INT clr
		)
{
	return g_pDirectDraw->DrawPixel(x, y, clr);
}

//------------------------------------------------------------------------
// Flip the backbuffer onto the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXRefresh(VOID)
{
	return g_pDirectDraw->Refresh();
}

//------------------------------------------------------------------------
// Lock the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXLockScreen(VOID)
{
	return g_pDirectDraw->LockScreen();
}

//------------------------------------------------------------------------
// Unlock the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXUnlockScreen(VOID)
{
	return g_pDirectDraw->UnlockScreen();
}

//------------------------------------------------------------------------
// Draw a canvas
//------------------------------------------------------------------------
BOOL APIENTRY DXDrawCanvas(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST INT lRasterOp
		)
{
	return g_pDirectDraw->DrawCanvas(reinterpret_cast<CGDICanvas *>(cnv), x, y, lRasterOp);
}

//------------------------------------------------------------------------
// Draw a canvas transparently
//------------------------------------------------------------------------
BOOL APIENTRY DXDrawCanvasTransparent(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST INT crTransparentColor
		)
{
	return g_pDirectDraw->DrawCanvasTransparent(reinterpret_cast<CGDICanvas *>(cnv), x, y, crTransparentColor);
}

//------------------------------------------------------------------------
// Draw a canvas translucently
//------------------------------------------------------------------------
BOOL APIENTRY DXDrawCanvasTranslucent(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST DOUBLE dIntensity,
	CONST INT crUnaffectedColor,
	CONST INT crTransparentColor
		)
{
	return g_pDirectDraw->DrawCanvasTranslucent(reinterpret_cast<CGDICanvas *>(cnv), x, y, dIntensity, crUnaffectedColor, crTransparentColor);
}

//------------------------------------------------------------------------
// Clear the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXClearScreen(
	CONST INT crColor
		)
{
	g_pDirectDraw->ClearScreen(crColor);
	return TRUE;
}

//------------------------------------------------------------------------
// Write text onto the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXDrawText(
	CONST INT x,
	CONST INT y,
	CONST LPSTR strText,
	CONST LPSTR strTypeFace,
	CONST INT size,
	CONST INT clr,
	CONST BOOL bold,
	CONST BOOL italics,
	CONST BOOL underline,
	CONST BOOL centred,
	CONST BOOL outlined
		)
{
	return g_pDirectDraw->DrawText(x, y, strText, strTypeFace, size, clr, bold, italics, underline, centred, outlined);
}

//------------------------------------------------------------------------
// Draw a canvas partially
//------------------------------------------------------------------------
BOOL APIENTRY DXDrawCanvasPartial(
	CONST CNV_HANDLE cnv,
	CONST INT destX,
	CONST INT destY,
	CONST INT srcX,
	CONST INT srcY,
	CONST INT width,
	CONST INT height,
	CONST INT lRasterOp
		)
{
	return g_pDirectDraw->DrawCanvasPartial(reinterpret_cast<CGDICanvas *>(cnv), destX, destY, srcX, srcY, width, height, lRasterOp);
}

//------------------------------------------------------------------------
// Partially draw a canvas, using transparency
//------------------------------------------------------------------------
BOOL APIENTRY DXDrawCanvasTransparentPartial(
	CONST CNV_HANDLE cnv,
	CONST INT destX,
	CONST INT destY,
	CONST INT srcX,
	CONST INT srcY,
	CONST INT width,
	CONST INT height,
	CONST INT crTrasparentColor
		)
{
	return g_pDirectDraw->DrawCanvasTransparentPartial(reinterpret_cast<CGDICanvas *>(cnv), destX, destY, srcX, srcY, width, height, crTrasparentColor);
}

//------------------------------------------------------------------------
// Copy the screen to a canvas
//------------------------------------------------------------------------
BOOL APIENTRY DXCopyScreenToCanvas(
	CONST CNV_HANDLE cnv
		)
{
	return g_pDirectDraw->CopyScreenToCanvas(reinterpret_cast<CGDICanvas *>(cnv));
}

//------------------------------------------------------------------------
// Draw part of a canvas, using translucency
//------------------------------------------------------------------------
BOOL APIENTRY DXDrawCanvasTranslucentPartial(
	CONST CNV_HANDLE cnv,
	CONST INT x,
	CONST INT y,
	CONST INT xSrc,
	CONST INT ySrc,
	CONST INT width,
	CONST INT height,
	CONST DOUBLE dIntensity,
	CONST INT crUnaffectedColor,
	CONST INT crTransparentColor
		)
{
	return g_pDirectDraw->DrawCanvasTranslucentPartial(reinterpret_cast<CGDICanvas *>(cnv), x, y, xSrc, ySrc, width, height, dIntensity, crUnaffectedColor, crTransparentColor);
}
