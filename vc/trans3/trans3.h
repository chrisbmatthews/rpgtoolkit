

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 7.00.0500 */
/* at Mon Jan 11 22:59:18 2010
 */
/* Compiler settings for .\trans3.idl:
    Oicf, W1, Zp8, env=Win32 (32b run)
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#pragma warning( disable: 4049 )  /* more than 64k source lines */


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __trans3_h__
#define __trans3_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __ICallbacks_FWD_DEFINED__
#define __ICallbacks_FWD_DEFINED__
typedef interface ICallbacks ICallbacks;
#endif 	/* __ICallbacks_FWD_DEFINED__ */


#ifndef __Callbacks_FWD_DEFINED__
#define __Callbacks_FWD_DEFINED__

#ifdef __cplusplus
typedef class Callbacks Callbacks;
#else
typedef struct Callbacks Callbacks;
#endif /* __cplusplus */

#endif 	/* __Callbacks_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __ICallbacks_INTERFACE_DEFINED__
#define __ICallbacks_INTERFACE_DEFINED__

/* interface ICallbacks */
/* [unique][helpstring][dual][uuid][oleautomation][object] */ 


EXTERN_C const IID IID_ICallbacks;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("C146901F-ABFA-4D24-A4F2-D83C961D37B9")
    ICallbacks : public IDispatch
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE CBRpgCode( 
            /* [string] */ BSTR rpgcodeCommand) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetString( 
            /* [string] */ BSTR varname,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetNumerical( 
            /* [string] */ BSTR varname,
            /* [retval][out] */ double *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetString( 
            /* [string] */ BSTR varname,
            /* [string] */ BSTR newValue) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetNumerical( 
            /* [string] */ BSTR varname,
            double newValue) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetScreenDC( 
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetScratch1DC( 
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetScratch2DC( 
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetMwinDC( 
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBPopupMwin( 
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBHideMwin( 
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBLoadEnemy( 
            /* [string] */ BSTR file,
            int eneSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyNum( 
            int infoCode,
            int eneSlot,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyString( 
            int infoCode,
            int eneSlot,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetEnemyNum( 
            int infoCode,
            int newValue,
            int eneSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetEnemyString( 
            int infoCode,
            /* [string] */ BSTR newValue,
            int eneSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerNum( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerString( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerNum( 
            int infoCode,
            int arrayPos,
            int newVal,
            int playerSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerString( 
            int infoCode,
            int arrayPos,
            /* [string] */ BSTR newVal,
            int playerSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetGeneralString( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetGeneralNum( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetGeneralString( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string] */ BSTR newVal) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetGeneralNum( 
            int infoCode,
            int arrayPos,
            int playerSlot,
            int newVal) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetCommandName( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetBrackets( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCountBracketElements( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetBracketElement( 
            /* [string] */ BSTR rpgcodeCommand,
            int elemNum,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetStringElementValue( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetNumElementValue( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ double *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetElementType( 
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDebugMessage( 
            /* [string] */ BSTR message) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPathString( 
            int infoCode,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBLoadSpecialMove( 
            /* [string] */ BSTR file) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetSpecialMoveString( 
            int infoCode,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetSpecialMoveNum( 
            int infoCode,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBLoadItem( 
            /* [string] */ BSTR file,
            int itmSlot) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetItemString( 
            int infoCode,
            int arrayPos,
            int itmSlot,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetItemNum( 
            int infoCode,
            int arrayPos,
            int itmSlot,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetBoardNum( 
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetBoardString( 
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetBoardNum( 
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            int nValue) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetBoardString( 
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [string] */ BSTR newVal) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetHwnd( 
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBRefreshScreen( 
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCreateCanvas( 
            int width,
            int height,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDestroyCanvas( 
            int canvasID,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvas( 
            int canvasID,
            int x,
            int y,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvasPartial( 
            int canvasID,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvasTransparent( 
            int canvasID,
            int x,
            int y,
            int crTransparentColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvasTransparentPartial( 
            int canvasID,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            int crTransparentColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawCanvasTranslucent( 
            int canvasID,
            int x,
            int y,
            double dIntensity,
            int crUnaffectedColor,
            int crTransparentColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasLoadImage( 
            int canvasID,
            /* [string] */ BSTR filename,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasLoadSizedImage( 
            int canvasID,
            /* [string] */ BSTR filename,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasFill( 
            int canvasID,
            int crColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasResize( 
            int canvasID,
            int width,
            int height,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBlt( 
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBltPartial( 
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBltTransparent( 
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int crTransparentColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBltTransparentPartial( 
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            int crTransparentColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvas2CanvasBltTranslucent( 
            int cnvSrc,
            int cnvDest,
            int destX,
            int destY,
            double dIntensity,
            int crUnaffectedColor,
            int crTransparentColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasGetScreen( 
            int cnvDest,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBLoadString( 
            int id,
            /* [string] */ BSTR defaultString,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawText( 
            int canvasID,
            /* [string] */ BSTR text,
            /* [string] */ BSTR font,
            int size,
            double x,
            double y,
            int crColor,
            int isBold,
            int isItalics,
            int isUnderline,
            int isCentred,
            /* [defaultvalue][in] */ int isOutlined,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasPopup( 
            int canvasID,
            int x,
            int y,
            int stepSize,
            int popupType,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasWidth( 
            int canvasID,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasHeight( 
            int canvasID,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawLine( 
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawRect( 
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasFillRect( 
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawHand( 
            int canvasID,
            int pointx,
            int pointy,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawHand( 
            int pointx,
            int pointy,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCheckKey( 
            /* [string] */ BSTR keyPressed,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBPlaySound( 
            /* [string] */ BSTR soundFile,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBMessageWindow( 
            /* [string] */ BSTR text,
            int textColor,
            int bgColor,
            /* [string] */ BSTR bgPic,
            int mbtype,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFileDialog( 
            /* [string] */ BSTR initialPath,
            /* [string] */ BSTR fileFilter,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDetermineSpecialMoves( 
            /* [string] */ BSTR playerHandle,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetSpecialMoveListEntry( 
            int idx,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBRunProgram( 
            /* [string] */ BSTR prgFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetTarget( 
            int targetIdx,
            int ttype) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetSource( 
            int sourceIdx,
            int sType) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerHP( 
            int playerIdx,
            /* [retval][out] */ double *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerMaxHP( 
            int playerIdx,
            /* [retval][out] */ double *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerSMP( 
            int playerIdx,
            /* [retval][out] */ double *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerMaxSMP( 
            int playerIdx,
            /* [retval][out] */ double *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerFP( 
            int playerIdx,
            /* [retval][out] */ double *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerDP( 
            int playerIdx,
            /* [retval][out] */ double *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPlayerName( 
            int playerIdx,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAddPlayerHP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAddPlayerSMP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerHP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerSMP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerFP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetPlayerDP( 
            int amount,
            int playerIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyHP( 
            int eneIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyMaxHP( 
            int eneIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemySMP( 
            int eneIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyMaxSMP( 
            int eneIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyFP( 
            int eneIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetEnemyDP( 
            int eneIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAddEnemyHP( 
            int amount,
            int eneIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAddEnemySMP( 
            int amount,
            int eneIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetEnemyHP( 
            int amount,
            int eneIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBSetEnemySMP( 
            int amount,
            int eneIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawBackground( 
            int canvasID,
            /* [string] */ BSTR bkgFile,
            int x,
            int y,
            int width,
            int height) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCreateAnimation( 
            /* [string] */ BSTR file,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDestroyAnimation( 
            int idx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawAnimation( 
            int canvasID,
            int idx,
            int x,
            int y,
            int forceDraw,
            int forceTransp) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasDrawAnimationFrame( 
            int canvasID,
            int idx,
            int frame,
            int x,
            int y,
            int forceTranspFill) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationCurrentFrame( 
            int idx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationMaxFrames( 
            int idx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationSizeX( 
            int idx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationSizeY( 
            int idx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBAnimationFrameImage( 
            int idx,
            int frame,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetPartySize( 
            int partyIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterHP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterMaxHP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterSMP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterMaxSMP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterFP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterDP( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterName( 
            int partyIdx,
            int fighterIdx,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterAnimation( 
            int partyIdx,
            int fighterIdx,
            /* [string] */ BSTR animationName,
            /* [string][retval][out] */ BSTR *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBGetFighterChargePercent( 
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFightTick( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDrawTextAbsolute( 
            /* [string] */ BSTR text,
            /* [string] */ BSTR font,
            int size,
            int x,
            int y,
            int crColor,
            int isBold,
            int isItalics,
            int isUnderline,
            int isCentred,
            /* [defaultvalue][in] */ int isOutlined,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBReleaseFighterCharge( 
            int partyIdx,
            int fighterIdx) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFightDoAttack( 
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            int amount,
            int toSMP,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFightUseItem( 
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            /* [string] */ BSTR itemFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFightUseSpecialMove( 
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            /* [string] */ BSTR moveFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBDoEvents( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFighterAddStatusEffect( 
            int partyIdx,
            int fightIdx,
            /* [string] */ BSTR statusFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFighterRemoveStatusEffect( 
            int partyIdx,
            int fightIdx,
            /* [string] */ BSTR statusFile) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCheckMusic( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBReleaseScreenDC( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasOpenHdc( 
            int cnv,
            /* [retval][out] */ int *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasCloseHdc( 
            int cnv,
            int hdc) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBFileExists( 
            /* [string] */ BSTR strFile,
            /* [retval][out] */ short *pRet) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasLock( 
            int cnv) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CBCanvasUnlock( 
            int cnv) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct ICallbacksVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            ICallbacks * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            ICallbacks * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            ICallbacks * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            ICallbacks * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            ICallbacks * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            ICallbacks * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            ICallbacks * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        HRESULT ( STDMETHODCALLTYPE *CBRpgCode )( 
            ICallbacks * This,
            /* [string] */ BSTR rpgcodeCommand);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetString )( 
            ICallbacks * This,
            /* [string] */ BSTR varname,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetNumerical )( 
            ICallbacks * This,
            /* [string] */ BSTR varname,
            /* [retval][out] */ double *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetString )( 
            ICallbacks * This,
            /* [string] */ BSTR varname,
            /* [string] */ BSTR newValue);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetNumerical )( 
            ICallbacks * This,
            /* [string] */ BSTR varname,
            double newValue);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetScreenDC )( 
            ICallbacks * This,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetScratch1DC )( 
            ICallbacks * This,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetScratch2DC )( 
            ICallbacks * This,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetMwinDC )( 
            ICallbacks * This,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBPopupMwin )( 
            ICallbacks * This,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBHideMwin )( 
            ICallbacks * This,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBLoadEnemy )( 
            ICallbacks * This,
            /* [string] */ BSTR file,
            int eneSlot);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetEnemyNum )( 
            ICallbacks * This,
            int infoCode,
            int eneSlot,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetEnemyString )( 
            ICallbacks * This,
            int infoCode,
            int eneSlot,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetEnemyNum )( 
            ICallbacks * This,
            int infoCode,
            int newValue,
            int eneSlot);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetEnemyString )( 
            ICallbacks * This,
            int infoCode,
            /* [string] */ BSTR newValue,
            int eneSlot);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPlayerNum )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPlayerString )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetPlayerNum )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            int newVal,
            int playerSlot);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetPlayerString )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            /* [string] */ BSTR newVal,
            int playerSlot);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetGeneralString )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetGeneralNum )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetGeneralString )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            /* [string] */ BSTR newVal);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetGeneralNum )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            int playerSlot,
            int newVal);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetCommandName )( 
            ICallbacks * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetBrackets )( 
            ICallbacks * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCountBracketElements )( 
            ICallbacks * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetBracketElement )( 
            ICallbacks * This,
            /* [string] */ BSTR rpgcodeCommand,
            int elemNum,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetStringElementValue )( 
            ICallbacks * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetNumElementValue )( 
            ICallbacks * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ double *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetElementType )( 
            ICallbacks * This,
            /* [string] */ BSTR rpgcodeCommand,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDebugMessage )( 
            ICallbacks * This,
            /* [string] */ BSTR message);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPathString )( 
            ICallbacks * This,
            int infoCode,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBLoadSpecialMove )( 
            ICallbacks * This,
            /* [string] */ BSTR file);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetSpecialMoveString )( 
            ICallbacks * This,
            int infoCode,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetSpecialMoveNum )( 
            ICallbacks * This,
            int infoCode,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBLoadItem )( 
            ICallbacks * This,
            /* [string] */ BSTR file,
            int itmSlot);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetItemString )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            int itmSlot,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetItemNum )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos,
            int itmSlot,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetBoardNum )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetBoardString )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetBoardNum )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            int nValue);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetBoardString )( 
            ICallbacks * This,
            int infoCode,
            int arrayPos1,
            int arrayPos2,
            int arrayPos3,
            /* [string] */ BSTR newVal);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetHwnd )( 
            ICallbacks * This,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBRefreshScreen )( 
            ICallbacks * This,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCreateCanvas )( 
            ICallbacks * This,
            int width,
            int height,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDestroyCanvas )( 
            ICallbacks * This,
            int canvasID,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDrawCanvas )( 
            ICallbacks * This,
            int canvasID,
            int x,
            int y,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDrawCanvasPartial )( 
            ICallbacks * This,
            int canvasID,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDrawCanvasTransparent )( 
            ICallbacks * This,
            int canvasID,
            int x,
            int y,
            int crTransparentColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDrawCanvasTransparentPartial )( 
            ICallbacks * This,
            int canvasID,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            int crTransparentColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDrawCanvasTranslucent )( 
            ICallbacks * This,
            int canvasID,
            int x,
            int y,
            double dIntensity,
            int crUnaffectedColor,
            int crTransparentColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasLoadImage )( 
            ICallbacks * This,
            int canvasID,
            /* [string] */ BSTR filename,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasLoadSizedImage )( 
            ICallbacks * This,
            int canvasID,
            /* [string] */ BSTR filename,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasFill )( 
            ICallbacks * This,
            int canvasID,
            int crColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasResize )( 
            ICallbacks * This,
            int canvasID,
            int width,
            int height,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvas2CanvasBlt )( 
            ICallbacks * This,
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvas2CanvasBltPartial )( 
            ICallbacks * This,
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvas2CanvasBltTransparent )( 
            ICallbacks * This,
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int crTransparentColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvas2CanvasBltTransparentPartial )( 
            ICallbacks * This,
            int cnvSrc,
            int cnvDest,
            int xDest,
            int yDest,
            int xsrc,
            int ysrc,
            int width,
            int height,
            int crTransparentColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvas2CanvasBltTranslucent )( 
            ICallbacks * This,
            int cnvSrc,
            int cnvDest,
            int destX,
            int destY,
            double dIntensity,
            int crUnaffectedColor,
            int crTransparentColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasGetScreen )( 
            ICallbacks * This,
            int cnvDest,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBLoadString )( 
            ICallbacks * This,
            int id,
            /* [string] */ BSTR defaultString,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasDrawText )( 
            ICallbacks * This,
            int canvasID,
            /* [string] */ BSTR text,
            /* [string] */ BSTR font,
            int size,
            double x,
            double y,
            int crColor,
            int isBold,
            int isItalics,
            int isUnderline,
            int isCentred,
            /* [defaultvalue][in] */ int isOutlined,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasPopup )( 
            ICallbacks * This,
            int canvasID,
            int x,
            int y,
            int stepSize,
            int popupType,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasWidth )( 
            ICallbacks * This,
            int canvasID,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasHeight )( 
            ICallbacks * This,
            int canvasID,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasDrawLine )( 
            ICallbacks * This,
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasDrawRect )( 
            ICallbacks * This,
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasFillRect )( 
            ICallbacks * This,
            int canvasID,
            int x1,
            int y1,
            int x2,
            int y2,
            int crColor,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasDrawHand )( 
            ICallbacks * This,
            int canvasID,
            int pointx,
            int pointy,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDrawHand )( 
            ICallbacks * This,
            int pointx,
            int pointy,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCheckKey )( 
            ICallbacks * This,
            /* [string] */ BSTR keyPressed,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBPlaySound )( 
            ICallbacks * This,
            /* [string] */ BSTR soundFile,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBMessageWindow )( 
            ICallbacks * This,
            /* [string] */ BSTR text,
            int textColor,
            int bgColor,
            /* [string] */ BSTR bgPic,
            int mbtype,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBFileDialog )( 
            ICallbacks * This,
            /* [string] */ BSTR initialPath,
            /* [string] */ BSTR fileFilter,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDetermineSpecialMoves )( 
            ICallbacks * This,
            /* [string] */ BSTR playerHandle,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetSpecialMoveListEntry )( 
            ICallbacks * This,
            int idx,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBRunProgram )( 
            ICallbacks * This,
            /* [string] */ BSTR prgFile);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetTarget )( 
            ICallbacks * This,
            int targetIdx,
            int ttype);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetSource )( 
            ICallbacks * This,
            int sourceIdx,
            int sType);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPlayerHP )( 
            ICallbacks * This,
            int playerIdx,
            /* [retval][out] */ double *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPlayerMaxHP )( 
            ICallbacks * This,
            int playerIdx,
            /* [retval][out] */ double *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPlayerSMP )( 
            ICallbacks * This,
            int playerIdx,
            /* [retval][out] */ double *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPlayerMaxSMP )( 
            ICallbacks * This,
            int playerIdx,
            /* [retval][out] */ double *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPlayerFP )( 
            ICallbacks * This,
            int playerIdx,
            /* [retval][out] */ double *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPlayerDP )( 
            ICallbacks * This,
            int playerIdx,
            /* [retval][out] */ double *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPlayerName )( 
            ICallbacks * This,
            int playerIdx,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBAddPlayerHP )( 
            ICallbacks * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBAddPlayerSMP )( 
            ICallbacks * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetPlayerHP )( 
            ICallbacks * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetPlayerSMP )( 
            ICallbacks * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetPlayerFP )( 
            ICallbacks * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetPlayerDP )( 
            ICallbacks * This,
            int amount,
            int playerIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetEnemyHP )( 
            ICallbacks * This,
            int eneIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetEnemyMaxHP )( 
            ICallbacks * This,
            int eneIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetEnemySMP )( 
            ICallbacks * This,
            int eneIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetEnemyMaxSMP )( 
            ICallbacks * This,
            int eneIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetEnemyFP )( 
            ICallbacks * This,
            int eneIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetEnemyDP )( 
            ICallbacks * This,
            int eneIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBAddEnemyHP )( 
            ICallbacks * This,
            int amount,
            int eneIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBAddEnemySMP )( 
            ICallbacks * This,
            int amount,
            int eneIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetEnemyHP )( 
            ICallbacks * This,
            int amount,
            int eneIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBSetEnemySMP )( 
            ICallbacks * This,
            int amount,
            int eneIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasDrawBackground )( 
            ICallbacks * This,
            int canvasID,
            /* [string] */ BSTR bkgFile,
            int x,
            int y,
            int width,
            int height);
        
        HRESULT ( STDMETHODCALLTYPE *CBCreateAnimation )( 
            ICallbacks * This,
            /* [string] */ BSTR file,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBDestroyAnimation )( 
            ICallbacks * This,
            int idx);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasDrawAnimation )( 
            ICallbacks * This,
            int canvasID,
            int idx,
            int x,
            int y,
            int forceDraw,
            int forceTransp);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasDrawAnimationFrame )( 
            ICallbacks * This,
            int canvasID,
            int idx,
            int frame,
            int x,
            int y,
            int forceTranspFill);
        
        HRESULT ( STDMETHODCALLTYPE *CBAnimationCurrentFrame )( 
            ICallbacks * This,
            int idx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBAnimationMaxFrames )( 
            ICallbacks * This,
            int idx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBAnimationSizeX )( 
            ICallbacks * This,
            int idx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBAnimationSizeY )( 
            ICallbacks * This,
            int idx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBAnimationFrameImage )( 
            ICallbacks * This,
            int idx,
            int frame,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetPartySize )( 
            ICallbacks * This,
            int partyIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetFighterHP )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetFighterMaxHP )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetFighterSMP )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetFighterMaxSMP )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetFighterFP )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetFighterDP )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetFighterName )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetFighterAnimation )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx,
            /* [string] */ BSTR animationName,
            /* [string][retval][out] */ BSTR *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBGetFighterChargePercent )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBFightTick )( 
            ICallbacks * This);
        
        HRESULT ( STDMETHODCALLTYPE *CBDrawTextAbsolute )( 
            ICallbacks * This,
            /* [string] */ BSTR text,
            /* [string] */ BSTR font,
            int size,
            int x,
            int y,
            int crColor,
            int isBold,
            int isItalics,
            int isUnderline,
            int isCentred,
            /* [defaultvalue][in] */ int isOutlined,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBReleaseFighterCharge )( 
            ICallbacks * This,
            int partyIdx,
            int fighterIdx);
        
        HRESULT ( STDMETHODCALLTYPE *CBFightDoAttack )( 
            ICallbacks * This,
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            int amount,
            int toSMP,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBFightUseItem )( 
            ICallbacks * This,
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            /* [string] */ BSTR itemFile);
        
        HRESULT ( STDMETHODCALLTYPE *CBFightUseSpecialMove )( 
            ICallbacks * This,
            int sourcePartyIdx,
            int sourceFightIdx,
            int targetPartyIdx,
            int targetFightIdx,
            /* [string] */ BSTR moveFile);
        
        HRESULT ( STDMETHODCALLTYPE *CBDoEvents )( 
            ICallbacks * This);
        
        HRESULT ( STDMETHODCALLTYPE *CBFighterAddStatusEffect )( 
            ICallbacks * This,
            int partyIdx,
            int fightIdx,
            /* [string] */ BSTR statusFile);
        
        HRESULT ( STDMETHODCALLTYPE *CBFighterRemoveStatusEffect )( 
            ICallbacks * This,
            int partyIdx,
            int fightIdx,
            /* [string] */ BSTR statusFile);
        
        HRESULT ( STDMETHODCALLTYPE *CBCheckMusic )( 
            ICallbacks * This);
        
        HRESULT ( STDMETHODCALLTYPE *CBReleaseScreenDC )( 
            ICallbacks * This);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasOpenHdc )( 
            ICallbacks * This,
            int cnv,
            /* [retval][out] */ int *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasCloseHdc )( 
            ICallbacks * This,
            int cnv,
            int hdc);
        
        HRESULT ( STDMETHODCALLTYPE *CBFileExists )( 
            ICallbacks * This,
            /* [string] */ BSTR strFile,
            /* [retval][out] */ short *pRet);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasLock )( 
            ICallbacks * This,
            int cnv);
        
        HRESULT ( STDMETHODCALLTYPE *CBCanvasUnlock )( 
            ICallbacks * This,
            int cnv);
        
        END_INTERFACE
    } ICallbacksVtbl;

    interface ICallbacks
    {
        CONST_VTBL struct ICallbacksVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define ICallbacks_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define ICallbacks_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define ICallbacks_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define ICallbacks_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define ICallbacks_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define ICallbacks_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define ICallbacks_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define ICallbacks_CBRpgCode(This,rpgcodeCommand)	\
    ( (This)->lpVtbl -> CBRpgCode(This,rpgcodeCommand) ) 

#define ICallbacks_CBGetString(This,varname,pRet)	\
    ( (This)->lpVtbl -> CBGetString(This,varname,pRet) ) 

#define ICallbacks_CBGetNumerical(This,varname,pRet)	\
    ( (This)->lpVtbl -> CBGetNumerical(This,varname,pRet) ) 

#define ICallbacks_CBSetString(This,varname,newValue)	\
    ( (This)->lpVtbl -> CBSetString(This,varname,newValue) ) 

#define ICallbacks_CBSetNumerical(This,varname,newValue)	\
    ( (This)->lpVtbl -> CBSetNumerical(This,varname,newValue) ) 

#define ICallbacks_CBGetScreenDC(This,pRet)	\
    ( (This)->lpVtbl -> CBGetScreenDC(This,pRet) ) 

#define ICallbacks_CBGetScratch1DC(This,pRet)	\
    ( (This)->lpVtbl -> CBGetScratch1DC(This,pRet) ) 

#define ICallbacks_CBGetScratch2DC(This,pRet)	\
    ( (This)->lpVtbl -> CBGetScratch2DC(This,pRet) ) 

#define ICallbacks_CBGetMwinDC(This,pRet)	\
    ( (This)->lpVtbl -> CBGetMwinDC(This,pRet) ) 

#define ICallbacks_CBPopupMwin(This,pRet)	\
    ( (This)->lpVtbl -> CBPopupMwin(This,pRet) ) 

#define ICallbacks_CBHideMwin(This,pRet)	\
    ( (This)->lpVtbl -> CBHideMwin(This,pRet) ) 

#define ICallbacks_CBLoadEnemy(This,file,eneSlot)	\
    ( (This)->lpVtbl -> CBLoadEnemy(This,file,eneSlot) ) 

#define ICallbacks_CBGetEnemyNum(This,infoCode,eneSlot,pRet)	\
    ( (This)->lpVtbl -> CBGetEnemyNum(This,infoCode,eneSlot,pRet) ) 

#define ICallbacks_CBGetEnemyString(This,infoCode,eneSlot,pRet)	\
    ( (This)->lpVtbl -> CBGetEnemyString(This,infoCode,eneSlot,pRet) ) 

#define ICallbacks_CBSetEnemyNum(This,infoCode,newValue,eneSlot)	\
    ( (This)->lpVtbl -> CBSetEnemyNum(This,infoCode,newValue,eneSlot) ) 

#define ICallbacks_CBSetEnemyString(This,infoCode,newValue,eneSlot)	\
    ( (This)->lpVtbl -> CBSetEnemyString(This,infoCode,newValue,eneSlot) ) 

#define ICallbacks_CBGetPlayerNum(This,infoCode,arrayPos,playerSlot,pRet)	\
    ( (This)->lpVtbl -> CBGetPlayerNum(This,infoCode,arrayPos,playerSlot,pRet) ) 

#define ICallbacks_CBGetPlayerString(This,infoCode,arrayPos,playerSlot,pRet)	\
    ( (This)->lpVtbl -> CBGetPlayerString(This,infoCode,arrayPos,playerSlot,pRet) ) 

#define ICallbacks_CBSetPlayerNum(This,infoCode,arrayPos,newVal,playerSlot)	\
    ( (This)->lpVtbl -> CBSetPlayerNum(This,infoCode,arrayPos,newVal,playerSlot) ) 

#define ICallbacks_CBSetPlayerString(This,infoCode,arrayPos,newVal,playerSlot)	\
    ( (This)->lpVtbl -> CBSetPlayerString(This,infoCode,arrayPos,newVal,playerSlot) ) 

#define ICallbacks_CBGetGeneralString(This,infoCode,arrayPos,playerSlot,pRet)	\
    ( (This)->lpVtbl -> CBGetGeneralString(This,infoCode,arrayPos,playerSlot,pRet) ) 

#define ICallbacks_CBGetGeneralNum(This,infoCode,arrayPos,playerSlot,pRet)	\
    ( (This)->lpVtbl -> CBGetGeneralNum(This,infoCode,arrayPos,playerSlot,pRet) ) 

#define ICallbacks_CBSetGeneralString(This,infoCode,arrayPos,playerSlot,newVal)	\
    ( (This)->lpVtbl -> CBSetGeneralString(This,infoCode,arrayPos,playerSlot,newVal) ) 

#define ICallbacks_CBSetGeneralNum(This,infoCode,arrayPos,playerSlot,newVal)	\
    ( (This)->lpVtbl -> CBSetGeneralNum(This,infoCode,arrayPos,playerSlot,newVal) ) 

#define ICallbacks_CBGetCommandName(This,rpgcodeCommand,pRet)	\
    ( (This)->lpVtbl -> CBGetCommandName(This,rpgcodeCommand,pRet) ) 

#define ICallbacks_CBGetBrackets(This,rpgcodeCommand,pRet)	\
    ( (This)->lpVtbl -> CBGetBrackets(This,rpgcodeCommand,pRet) ) 

#define ICallbacks_CBCountBracketElements(This,rpgcodeCommand,pRet)	\
    ( (This)->lpVtbl -> CBCountBracketElements(This,rpgcodeCommand,pRet) ) 

#define ICallbacks_CBGetBracketElement(This,rpgcodeCommand,elemNum,pRet)	\
    ( (This)->lpVtbl -> CBGetBracketElement(This,rpgcodeCommand,elemNum,pRet) ) 

#define ICallbacks_CBGetStringElementValue(This,rpgcodeCommand,pRet)	\
    ( (This)->lpVtbl -> CBGetStringElementValue(This,rpgcodeCommand,pRet) ) 

#define ICallbacks_CBGetNumElementValue(This,rpgcodeCommand,pRet)	\
    ( (This)->lpVtbl -> CBGetNumElementValue(This,rpgcodeCommand,pRet) ) 

#define ICallbacks_CBGetElementType(This,rpgcodeCommand,pRet)	\
    ( (This)->lpVtbl -> CBGetElementType(This,rpgcodeCommand,pRet) ) 

#define ICallbacks_CBDebugMessage(This,message)	\
    ( (This)->lpVtbl -> CBDebugMessage(This,message) ) 

#define ICallbacks_CBGetPathString(This,infoCode,pRet)	\
    ( (This)->lpVtbl -> CBGetPathString(This,infoCode,pRet) ) 

#define ICallbacks_CBLoadSpecialMove(This,file)	\
    ( (This)->lpVtbl -> CBLoadSpecialMove(This,file) ) 

#define ICallbacks_CBGetSpecialMoveString(This,infoCode,pRet)	\
    ( (This)->lpVtbl -> CBGetSpecialMoveString(This,infoCode,pRet) ) 

#define ICallbacks_CBGetSpecialMoveNum(This,infoCode,pRet)	\
    ( (This)->lpVtbl -> CBGetSpecialMoveNum(This,infoCode,pRet) ) 

#define ICallbacks_CBLoadItem(This,file,itmSlot)	\
    ( (This)->lpVtbl -> CBLoadItem(This,file,itmSlot) ) 

#define ICallbacks_CBGetItemString(This,infoCode,arrayPos,itmSlot,pRet)	\
    ( (This)->lpVtbl -> CBGetItemString(This,infoCode,arrayPos,itmSlot,pRet) ) 

#define ICallbacks_CBGetItemNum(This,infoCode,arrayPos,itmSlot,pRet)	\
    ( (This)->lpVtbl -> CBGetItemNum(This,infoCode,arrayPos,itmSlot,pRet) ) 

#define ICallbacks_CBGetBoardNum(This,infoCode,arrayPos1,arrayPos2,arrayPos3,pRet)	\
    ( (This)->lpVtbl -> CBGetBoardNum(This,infoCode,arrayPos1,arrayPos2,arrayPos3,pRet) ) 

#define ICallbacks_CBGetBoardString(This,infoCode,arrayPos1,arrayPos2,arrayPos3,pRet)	\
    ( (This)->lpVtbl -> CBGetBoardString(This,infoCode,arrayPos1,arrayPos2,arrayPos3,pRet) ) 

#define ICallbacks_CBSetBoardNum(This,infoCode,arrayPos1,arrayPos2,arrayPos3,nValue)	\
    ( (This)->lpVtbl -> CBSetBoardNum(This,infoCode,arrayPos1,arrayPos2,arrayPos3,nValue) ) 

#define ICallbacks_CBSetBoardString(This,infoCode,arrayPos1,arrayPos2,arrayPos3,newVal)	\
    ( (This)->lpVtbl -> CBSetBoardString(This,infoCode,arrayPos1,arrayPos2,arrayPos3,newVal) ) 

#define ICallbacks_CBGetHwnd(This,pRet)	\
    ( (This)->lpVtbl -> CBGetHwnd(This,pRet) ) 

#define ICallbacks_CBRefreshScreen(This,pRet)	\
    ( (This)->lpVtbl -> CBRefreshScreen(This,pRet) ) 

#define ICallbacks_CBCreateCanvas(This,width,height,pRet)	\
    ( (This)->lpVtbl -> CBCreateCanvas(This,width,height,pRet) ) 

#define ICallbacks_CBDestroyCanvas(This,canvasID,pRet)	\
    ( (This)->lpVtbl -> CBDestroyCanvas(This,canvasID,pRet) ) 

#define ICallbacks_CBDrawCanvas(This,canvasID,x,y,pRet)	\
    ( (This)->lpVtbl -> CBDrawCanvas(This,canvasID,x,y,pRet) ) 

#define ICallbacks_CBDrawCanvasPartial(This,canvasID,xDest,yDest,xsrc,ysrc,width,height,pRet)	\
    ( (This)->lpVtbl -> CBDrawCanvasPartial(This,canvasID,xDest,yDest,xsrc,ysrc,width,height,pRet) ) 

#define ICallbacks_CBDrawCanvasTransparent(This,canvasID,x,y,crTransparentColor,pRet)	\
    ( (This)->lpVtbl -> CBDrawCanvasTransparent(This,canvasID,x,y,crTransparentColor,pRet) ) 

#define ICallbacks_CBDrawCanvasTransparentPartial(This,canvasID,xDest,yDest,xsrc,ysrc,width,height,crTransparentColor,pRet)	\
    ( (This)->lpVtbl -> CBDrawCanvasTransparentPartial(This,canvasID,xDest,yDest,xsrc,ysrc,width,height,crTransparentColor,pRet) ) 

#define ICallbacks_CBDrawCanvasTranslucent(This,canvasID,x,y,dIntensity,crUnaffectedColor,crTransparentColor,pRet)	\
    ( (This)->lpVtbl -> CBDrawCanvasTranslucent(This,canvasID,x,y,dIntensity,crUnaffectedColor,crTransparentColor,pRet) ) 

#define ICallbacks_CBCanvasLoadImage(This,canvasID,filename,pRet)	\
    ( (This)->lpVtbl -> CBCanvasLoadImage(This,canvasID,filename,pRet) ) 

#define ICallbacks_CBCanvasLoadSizedImage(This,canvasID,filename,pRet)	\
    ( (This)->lpVtbl -> CBCanvasLoadSizedImage(This,canvasID,filename,pRet) ) 

#define ICallbacks_CBCanvasFill(This,canvasID,crColor,pRet)	\
    ( (This)->lpVtbl -> CBCanvasFill(This,canvasID,crColor,pRet) ) 

#define ICallbacks_CBCanvasResize(This,canvasID,width,height,pRet)	\
    ( (This)->lpVtbl -> CBCanvasResize(This,canvasID,width,height,pRet) ) 

#define ICallbacks_CBCanvas2CanvasBlt(This,cnvSrc,cnvDest,xDest,yDest,pRet)	\
    ( (This)->lpVtbl -> CBCanvas2CanvasBlt(This,cnvSrc,cnvDest,xDest,yDest,pRet) ) 

#define ICallbacks_CBCanvas2CanvasBltPartial(This,cnvSrc,cnvDest,xDest,yDest,xsrc,ysrc,width,height,pRet)	\
    ( (This)->lpVtbl -> CBCanvas2CanvasBltPartial(This,cnvSrc,cnvDest,xDest,yDest,xsrc,ysrc,width,height,pRet) ) 

#define ICallbacks_CBCanvas2CanvasBltTransparent(This,cnvSrc,cnvDest,xDest,yDest,crTransparentColor,pRet)	\
    ( (This)->lpVtbl -> CBCanvas2CanvasBltTransparent(This,cnvSrc,cnvDest,xDest,yDest,crTransparentColor,pRet) ) 

#define ICallbacks_CBCanvas2CanvasBltTransparentPartial(This,cnvSrc,cnvDest,xDest,yDest,xsrc,ysrc,width,height,crTransparentColor,pRet)	\
    ( (This)->lpVtbl -> CBCanvas2CanvasBltTransparentPartial(This,cnvSrc,cnvDest,xDest,yDest,xsrc,ysrc,width,height,crTransparentColor,pRet) ) 

#define ICallbacks_CBCanvas2CanvasBltTranslucent(This,cnvSrc,cnvDest,destX,destY,dIntensity,crUnaffectedColor,crTransparentColor,pRet)	\
    ( (This)->lpVtbl -> CBCanvas2CanvasBltTranslucent(This,cnvSrc,cnvDest,destX,destY,dIntensity,crUnaffectedColor,crTransparentColor,pRet) ) 

#define ICallbacks_CBCanvasGetScreen(This,cnvDest,pRet)	\
    ( (This)->lpVtbl -> CBCanvasGetScreen(This,cnvDest,pRet) ) 

#define ICallbacks_CBLoadString(This,id,defaultString,pRet)	\
    ( (This)->lpVtbl -> CBLoadString(This,id,defaultString,pRet) ) 

#define ICallbacks_CBCanvasDrawText(This,canvasID,text,font,size,x,y,crColor,isBold,isItalics,isUnderline,isCentred,isOutlined,pRet)	\
    ( (This)->lpVtbl -> CBCanvasDrawText(This,canvasID,text,font,size,x,y,crColor,isBold,isItalics,isUnderline,isCentred,isOutlined,pRet) ) 

#define ICallbacks_CBCanvasPopup(This,canvasID,x,y,stepSize,popupType,pRet)	\
    ( (This)->lpVtbl -> CBCanvasPopup(This,canvasID,x,y,stepSize,popupType,pRet) ) 

#define ICallbacks_CBCanvasWidth(This,canvasID,pRet)	\
    ( (This)->lpVtbl -> CBCanvasWidth(This,canvasID,pRet) ) 

#define ICallbacks_CBCanvasHeight(This,canvasID,pRet)	\
    ( (This)->lpVtbl -> CBCanvasHeight(This,canvasID,pRet) ) 

#define ICallbacks_CBCanvasDrawLine(This,canvasID,x1,y1,x2,y2,crColor,pRet)	\
    ( (This)->lpVtbl -> CBCanvasDrawLine(This,canvasID,x1,y1,x2,y2,crColor,pRet) ) 

#define ICallbacks_CBCanvasDrawRect(This,canvasID,x1,y1,x2,y2,crColor,pRet)	\
    ( (This)->lpVtbl -> CBCanvasDrawRect(This,canvasID,x1,y1,x2,y2,crColor,pRet) ) 

#define ICallbacks_CBCanvasFillRect(This,canvasID,x1,y1,x2,y2,crColor,pRet)	\
    ( (This)->lpVtbl -> CBCanvasFillRect(This,canvasID,x1,y1,x2,y2,crColor,pRet) ) 

#define ICallbacks_CBCanvasDrawHand(This,canvasID,pointx,pointy,pRet)	\
    ( (This)->lpVtbl -> CBCanvasDrawHand(This,canvasID,pointx,pointy,pRet) ) 

#define ICallbacks_CBDrawHand(This,pointx,pointy,pRet)	\
    ( (This)->lpVtbl -> CBDrawHand(This,pointx,pointy,pRet) ) 

#define ICallbacks_CBCheckKey(This,keyPressed,pRet)	\
    ( (This)->lpVtbl -> CBCheckKey(This,keyPressed,pRet) ) 

#define ICallbacks_CBPlaySound(This,soundFile,pRet)	\
    ( (This)->lpVtbl -> CBPlaySound(This,soundFile,pRet) ) 

#define ICallbacks_CBMessageWindow(This,text,textColor,bgColor,bgPic,mbtype,pRet)	\
    ( (This)->lpVtbl -> CBMessageWindow(This,text,textColor,bgColor,bgPic,mbtype,pRet) ) 

#define ICallbacks_CBFileDialog(This,initialPath,fileFilter,pRet)	\
    ( (This)->lpVtbl -> CBFileDialog(This,initialPath,fileFilter,pRet) ) 

#define ICallbacks_CBDetermineSpecialMoves(This,playerHandle,pRet)	\
    ( (This)->lpVtbl -> CBDetermineSpecialMoves(This,playerHandle,pRet) ) 

#define ICallbacks_CBGetSpecialMoveListEntry(This,idx,pRet)	\
    ( (This)->lpVtbl -> CBGetSpecialMoveListEntry(This,idx,pRet) ) 

#define ICallbacks_CBRunProgram(This,prgFile)	\
    ( (This)->lpVtbl -> CBRunProgram(This,prgFile) ) 

#define ICallbacks_CBSetTarget(This,targetIdx,ttype)	\
    ( (This)->lpVtbl -> CBSetTarget(This,targetIdx,ttype) ) 

#define ICallbacks_CBSetSource(This,sourceIdx,sType)	\
    ( (This)->lpVtbl -> CBSetSource(This,sourceIdx,sType) ) 

#define ICallbacks_CBGetPlayerHP(This,playerIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetPlayerHP(This,playerIdx,pRet) ) 

#define ICallbacks_CBGetPlayerMaxHP(This,playerIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetPlayerMaxHP(This,playerIdx,pRet) ) 

#define ICallbacks_CBGetPlayerSMP(This,playerIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetPlayerSMP(This,playerIdx,pRet) ) 

#define ICallbacks_CBGetPlayerMaxSMP(This,playerIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetPlayerMaxSMP(This,playerIdx,pRet) ) 

#define ICallbacks_CBGetPlayerFP(This,playerIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetPlayerFP(This,playerIdx,pRet) ) 

#define ICallbacks_CBGetPlayerDP(This,playerIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetPlayerDP(This,playerIdx,pRet) ) 

#define ICallbacks_CBGetPlayerName(This,playerIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetPlayerName(This,playerIdx,pRet) ) 

#define ICallbacks_CBAddPlayerHP(This,amount,playerIdx)	\
    ( (This)->lpVtbl -> CBAddPlayerHP(This,amount,playerIdx) ) 

#define ICallbacks_CBAddPlayerSMP(This,amount,playerIdx)	\
    ( (This)->lpVtbl -> CBAddPlayerSMP(This,amount,playerIdx) ) 

#define ICallbacks_CBSetPlayerHP(This,amount,playerIdx)	\
    ( (This)->lpVtbl -> CBSetPlayerHP(This,amount,playerIdx) ) 

#define ICallbacks_CBSetPlayerSMP(This,amount,playerIdx)	\
    ( (This)->lpVtbl -> CBSetPlayerSMP(This,amount,playerIdx) ) 

#define ICallbacks_CBSetPlayerFP(This,amount,playerIdx)	\
    ( (This)->lpVtbl -> CBSetPlayerFP(This,amount,playerIdx) ) 

#define ICallbacks_CBSetPlayerDP(This,amount,playerIdx)	\
    ( (This)->lpVtbl -> CBSetPlayerDP(This,amount,playerIdx) ) 

#define ICallbacks_CBGetEnemyHP(This,eneIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetEnemyHP(This,eneIdx,pRet) ) 

#define ICallbacks_CBGetEnemyMaxHP(This,eneIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetEnemyMaxHP(This,eneIdx,pRet) ) 

#define ICallbacks_CBGetEnemySMP(This,eneIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetEnemySMP(This,eneIdx,pRet) ) 

#define ICallbacks_CBGetEnemyMaxSMP(This,eneIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetEnemyMaxSMP(This,eneIdx,pRet) ) 

#define ICallbacks_CBGetEnemyFP(This,eneIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetEnemyFP(This,eneIdx,pRet) ) 

#define ICallbacks_CBGetEnemyDP(This,eneIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetEnemyDP(This,eneIdx,pRet) ) 

#define ICallbacks_CBAddEnemyHP(This,amount,eneIdx)	\
    ( (This)->lpVtbl -> CBAddEnemyHP(This,amount,eneIdx) ) 

#define ICallbacks_CBAddEnemySMP(This,amount,eneIdx)	\
    ( (This)->lpVtbl -> CBAddEnemySMP(This,amount,eneIdx) ) 

#define ICallbacks_CBSetEnemyHP(This,amount,eneIdx)	\
    ( (This)->lpVtbl -> CBSetEnemyHP(This,amount,eneIdx) ) 

#define ICallbacks_CBSetEnemySMP(This,amount,eneIdx)	\
    ( (This)->lpVtbl -> CBSetEnemySMP(This,amount,eneIdx) ) 

#define ICallbacks_CBCanvasDrawBackground(This,canvasID,bkgFile,x,y,width,height)	\
    ( (This)->lpVtbl -> CBCanvasDrawBackground(This,canvasID,bkgFile,x,y,width,height) ) 

#define ICallbacks_CBCreateAnimation(This,file,pRet)	\
    ( (This)->lpVtbl -> CBCreateAnimation(This,file,pRet) ) 

#define ICallbacks_CBDestroyAnimation(This,idx)	\
    ( (This)->lpVtbl -> CBDestroyAnimation(This,idx) ) 

#define ICallbacks_CBCanvasDrawAnimation(This,canvasID,idx,x,y,forceDraw,forceTransp)	\
    ( (This)->lpVtbl -> CBCanvasDrawAnimation(This,canvasID,idx,x,y,forceDraw,forceTransp) ) 

#define ICallbacks_CBCanvasDrawAnimationFrame(This,canvasID,idx,frame,x,y,forceTranspFill)	\
    ( (This)->lpVtbl -> CBCanvasDrawAnimationFrame(This,canvasID,idx,frame,x,y,forceTranspFill) ) 

#define ICallbacks_CBAnimationCurrentFrame(This,idx,pRet)	\
    ( (This)->lpVtbl -> CBAnimationCurrentFrame(This,idx,pRet) ) 

#define ICallbacks_CBAnimationMaxFrames(This,idx,pRet)	\
    ( (This)->lpVtbl -> CBAnimationMaxFrames(This,idx,pRet) ) 

#define ICallbacks_CBAnimationSizeX(This,idx,pRet)	\
    ( (This)->lpVtbl -> CBAnimationSizeX(This,idx,pRet) ) 

#define ICallbacks_CBAnimationSizeY(This,idx,pRet)	\
    ( (This)->lpVtbl -> CBAnimationSizeY(This,idx,pRet) ) 

#define ICallbacks_CBAnimationFrameImage(This,idx,frame,pRet)	\
    ( (This)->lpVtbl -> CBAnimationFrameImage(This,idx,frame,pRet) ) 

#define ICallbacks_CBGetPartySize(This,partyIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetPartySize(This,partyIdx,pRet) ) 

#define ICallbacks_CBGetFighterHP(This,partyIdx,fighterIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetFighterHP(This,partyIdx,fighterIdx,pRet) ) 

#define ICallbacks_CBGetFighterMaxHP(This,partyIdx,fighterIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetFighterMaxHP(This,partyIdx,fighterIdx,pRet) ) 

#define ICallbacks_CBGetFighterSMP(This,partyIdx,fighterIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetFighterSMP(This,partyIdx,fighterIdx,pRet) ) 

#define ICallbacks_CBGetFighterMaxSMP(This,partyIdx,fighterIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetFighterMaxSMP(This,partyIdx,fighterIdx,pRet) ) 

#define ICallbacks_CBGetFighterFP(This,partyIdx,fighterIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetFighterFP(This,partyIdx,fighterIdx,pRet) ) 

#define ICallbacks_CBGetFighterDP(This,partyIdx,fighterIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetFighterDP(This,partyIdx,fighterIdx,pRet) ) 

#define ICallbacks_CBGetFighterName(This,partyIdx,fighterIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetFighterName(This,partyIdx,fighterIdx,pRet) ) 

#define ICallbacks_CBGetFighterAnimation(This,partyIdx,fighterIdx,animationName,pRet)	\
    ( (This)->lpVtbl -> CBGetFighterAnimation(This,partyIdx,fighterIdx,animationName,pRet) ) 

#define ICallbacks_CBGetFighterChargePercent(This,partyIdx,fighterIdx,pRet)	\
    ( (This)->lpVtbl -> CBGetFighterChargePercent(This,partyIdx,fighterIdx,pRet) ) 

#define ICallbacks_CBFightTick(This)	\
    ( (This)->lpVtbl -> CBFightTick(This) ) 

#define ICallbacks_CBDrawTextAbsolute(This,text,font,size,x,y,crColor,isBold,isItalics,isUnderline,isCentred,isOutlined,pRet)	\
    ( (This)->lpVtbl -> CBDrawTextAbsolute(This,text,font,size,x,y,crColor,isBold,isItalics,isUnderline,isCentred,isOutlined,pRet) ) 

#define ICallbacks_CBReleaseFighterCharge(This,partyIdx,fighterIdx)	\
    ( (This)->lpVtbl -> CBReleaseFighterCharge(This,partyIdx,fighterIdx) ) 

#define ICallbacks_CBFightDoAttack(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,amount,toSMP,pRet)	\
    ( (This)->lpVtbl -> CBFightDoAttack(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,amount,toSMP,pRet) ) 

#define ICallbacks_CBFightUseItem(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,itemFile)	\
    ( (This)->lpVtbl -> CBFightUseItem(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,itemFile) ) 

#define ICallbacks_CBFightUseSpecialMove(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,moveFile)	\
    ( (This)->lpVtbl -> CBFightUseSpecialMove(This,sourcePartyIdx,sourceFightIdx,targetPartyIdx,targetFightIdx,moveFile) ) 

#define ICallbacks_CBDoEvents(This)	\
    ( (This)->lpVtbl -> CBDoEvents(This) ) 

#define ICallbacks_CBFighterAddStatusEffect(This,partyIdx,fightIdx,statusFile)	\
    ( (This)->lpVtbl -> CBFighterAddStatusEffect(This,partyIdx,fightIdx,statusFile) ) 

#define ICallbacks_CBFighterRemoveStatusEffect(This,partyIdx,fightIdx,statusFile)	\
    ( (This)->lpVtbl -> CBFighterRemoveStatusEffect(This,partyIdx,fightIdx,statusFile) ) 

#define ICallbacks_CBCheckMusic(This)	\
    ( (This)->lpVtbl -> CBCheckMusic(This) ) 

#define ICallbacks_CBReleaseScreenDC(This)	\
    ( (This)->lpVtbl -> CBReleaseScreenDC(This) ) 

#define ICallbacks_CBCanvasOpenHdc(This,cnv,pRet)	\
    ( (This)->lpVtbl -> CBCanvasOpenHdc(This,cnv,pRet) ) 

#define ICallbacks_CBCanvasCloseHdc(This,cnv,hdc)	\
    ( (This)->lpVtbl -> CBCanvasCloseHdc(This,cnv,hdc) ) 

#define ICallbacks_CBFileExists(This,strFile,pRet)	\
    ( (This)->lpVtbl -> CBFileExists(This,strFile,pRet) ) 

#define ICallbacks_CBCanvasLock(This,cnv)	\
    ( (This)->lpVtbl -> CBCanvasLock(This,cnv) ) 

#define ICallbacks_CBCanvasUnlock(This,cnv)	\
    ( (This)->lpVtbl -> CBCanvasUnlock(This,cnv) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterName_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fighterIdx,
    /* [string][retval][out] */ BSTR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterAnimation_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fighterIdx,
    /* [string] */ BSTR animationName,
    /* [string][retval][out] */ BSTR *pRet);


void __RPC_STUB ICallbacks_CBGetFighterAnimation_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBGetFighterChargePercent_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fighterIdx,
    /* [retval][out] */ int *pRet);


void __RPC_STUB ICallbacks_CBGetFighterChargePercent_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFightTick_Proxy( 
    ICallbacks * This);


void __RPC_STUB ICallbacks_CBFightTick_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDrawTextAbsolute_Proxy( 
    ICallbacks * This,
    /* [string] */ BSTR text,
    /* [string] */ BSTR font,
    int size,
    int x,
    int y,
    int crColor,
    int isBold,
    int isItalics,
    int isUnderline,
    int isCentred,
    /* [defaultvalue][in] */ int isOutlined,
    /* [retval][out] */ int *pRet);


void __RPC_STUB ICallbacks_CBDrawTextAbsolute_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBReleaseFighterCharge_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fighterIdx);


void __RPC_STUB ICallbacks_CBReleaseFighterCharge_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFightDoAttack_Proxy( 
    ICallbacks * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    int amount,
    int toSMP,
    /* [retval][out] */ int *pRet);


void __RPC_STUB ICallbacks_CBFightDoAttack_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFightUseItem_Proxy( 
    ICallbacks * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    /* [string] */ BSTR itemFile);


void __RPC_STUB ICallbacks_CBFightUseItem_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFightUseSpecialMove_Proxy( 
    ICallbacks * This,
    int sourcePartyIdx,
    int sourceFightIdx,
    int targetPartyIdx,
    int targetFightIdx,
    /* [string] */ BSTR moveFile);


void __RPC_STUB ICallbacks_CBFightUseSpecialMove_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBDoEvents_Proxy( 
    ICallbacks * This);


void __RPC_STUB ICallbacks_CBDoEvents_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFighterAddStatusEffect_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fightIdx,
    /* [string] */ BSTR statusFile);


void __RPC_STUB ICallbacks_CBFighterAddStatusEffect_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFighterRemoveStatusEffect_Proxy( 
    ICallbacks * This,
    int partyIdx,
    int fightIdx,
    /* [string] */ BSTR statusFile);


void __RPC_STUB ICallbacks_CBFighterRemoveStatusEffect_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCheckMusic_Proxy( 
    ICallbacks * This);


void __RPC_STUB ICallbacks_CBCheckMusic_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBReleaseScreenDC_Proxy( 
    ICallbacks * This);


void __RPC_STUB ICallbacks_CBReleaseScreenDC_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasOpenHdc_Proxy( 
    ICallbacks * This,
    int cnv,
    /* [retval][out] */ int *pRet);


void __RPC_STUB ICallbacks_CBCanvasOpenHdc_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasCloseHdc_Proxy( 
    ICallbacks * This,
    int cnv,
    int hdc);


void __RPC_STUB ICallbacks_CBCanvasCloseHdc_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBFileExists_Proxy( 
    ICallbacks * This,
    /* [string] */ BSTR strFile,
    /* [retval][out] */ short *pRet);


void __RPC_STUB ICallbacks_CBFileExists_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasLock_Proxy( 
    ICallbacks * This,
    int cnv);


void __RPC_STUB ICallbacks_CBCanvasLock_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE ICallbacks_CBCanvasUnlock_Proxy( 
    ICallbacks * This,
    int cnv);


void __RPC_STUB ICallbacks_CBCanvasUnlock_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __ICallbacks_INTERFACE_DEFINED__ */



#ifndef __TRANS3Lib_LIBRARY_DEFINED__
#define __TRANS3Lib_LIBRARY_DEFINED__

/* library TRANS3Lib */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_TRANS3Lib;

EXTERN_C const CLSID CLSID_Callbacks;

#ifdef __cplusplus

class DECLSPEC_UUID("6FD78CD3-F15B-4092-B549-EB07DEC99432")
Callbacks;
#endif
#endif /* __TRANS3Lib_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long *, unsigned long            , BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserMarshal(  unsigned long *, unsigned char *, BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserUnmarshal(unsigned long *, unsigned char *, BSTR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long *, BSTR * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


