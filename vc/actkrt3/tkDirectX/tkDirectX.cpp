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
#include "tkDirectX.h"			// Stuff for this file

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
	return InitGraphicsMode(HWND(hostHwnd), nScreenX, nScreenY, nUseDirectX, nColorDepth, nFullScreen);
}

//------------------------------------------------------------------------
// Kill DirectX
//------------------------------------------------------------------------
BOOL APIENTRY DXKillGfxMode(
	VOID
		)
{
	return KillGraphicsMode();
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
	return DrawPixel(x, y, clr);
}

//------------------------------------------------------------------------
// Flip the backbuffer onto the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXRefresh(
	CONST CNV_HANDLE cnvHandle
		)
{
	return Refresh(reinterpret_cast<CGDICanvas *>(cnvHandle));
}

//------------------------------------------------------------------------
// Lock the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXLockScreen(VOID)
{
	return LockScreen();
}

//------------------------------------------------------------------------
// Unlock the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXUnlockScreen(VOID)
{
	return UnlockScreen();
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
	return DrawCanvas(reinterpret_cast<CGDICanvas *>(cnv), x, y, lRasterOp);
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
	return DrawCanvasTransparent(reinterpret_cast<CGDICanvas *>(cnv), x, y, crTransparentColor);
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
	return DrawCanvasTranslucent(reinterpret_cast<CGDICanvas *>(cnv), x, y, dIntensity, crUnaffectedColor, crTransparentColor);
}

//------------------------------------------------------------------------
// Clear the screen
//------------------------------------------------------------------------
BOOL APIENTRY DXClearScreen(
	CONST INT crColor
		)
{
	ClearScreen(crColor);
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
	return DrawText(x, y, strText, strTypeFace, size, clr, bold, italics, underline, centred, outlined);
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
	return DrawCanvasPartial(reinterpret_cast<CGDICanvas *>(cnv), destX, destY, srcX, srcY, width, height, lRasterOp);
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
	return DrawCanvasTransparentPartial(reinterpret_cast<CGDICanvas *>(cnv), destX, destY, srcX, srcY, width, height, crTrasparentColor);
}

//------------------------------------------------------------------------
// Copy the screen to a canvas
//------------------------------------------------------------------------
BOOL APIENTRY DXCopyScreenToCanvas(
	CONST CNV_HANDLE cnv
		)
{
	return CopyScreenToCanvas(reinterpret_cast<CGDICanvas *>(cnv));
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
	return DrawCanvasTranslucentPartial(reinterpret_cast<CGDICanvas *>(cnv), x, y, xSrc, ySrc, width, height, dIntensity, crUnaffectedColor, crTransparentColor);
}
