Attribute VB_Name = "CommonTileset"
'=======================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================

'===============================================
'Alterations for new isometric tilesets, .iso
'Edited by Delano for 3.0.4
'
' Altered subs: All
' New global constants.
'===============================================

'Tileset module-- defines a tileset
Option Explicit

Type tilesetHeader              '6 bytes
    version As Integer          '20=2.0, 21=2.1, etc
    tilesInSet As Integer       'number of tiles in set
    detail As Integer           'detail level in set MUST BE UNIFORM!
End Type

Global tileset As tilesetHeader    'current tileset file

'==============================================
' .iso Isometric Tileset File Format
' Introduced for 3.0.4
' Almost identical to .tsts!
'
' File structure:
'   Header:                 (6 bytes)
'       tileset.version = 30
'       tileset.tilesInSet
'       tileset.detail = ISODETAIL
'   Isometric Tiles:        (3072 bytes)
'       Stored in same way as .tsts, after masking.
'==============================================

'==============================================
'New variables for isometric tile system; 3.0.4
'GetTileInfo constants.

Public Const TSTTYPE As Byte = 0        'Should be 1!
Public Const ISOTYPE As Byte = 2
Public Const ISODETAIL As Byte = 150    'Arbitrary value!

Function addToTileSet(ByVal file As String) As Integer: On Error GoTo errorhandler
'==================================================
'Adds the current tile to the end of the tileset.
'Returns the number in the tst.
'file$ is the tst name, e.g. "default.tst"
'==================================================
'Edited by Delano for 3.0.4
'Isometric tilesets (.iso) added.
'Variable a >> setType

'Called by: CommonItem openItem         -tk2 compat
'           CommonPlayer openchar       -tk2 compat
'(toolkit)  tileedit mnusts_click, savetile2
'           tilesetedit Command1_Click      - unneeded changes, since cannot add .gph to .iso
'           tilesetadd Command1_Click

    Dim setType As Long, num As Long
    setType = tilesetInfo(file$)
    
    If (setType = TSTTYPE And tileset.detail = detail) Or (setType = ISOTYPE And tileset.detail = ISODETAIL) Then
    
        'If the versions are correct and the header was read.
        tileset.tilesInSet = tileset.tilesInSet + 1
                
        'Set up the file for rewriting the header with the updated tile number.
        num = FreeFile
        'Kill file$
        
        Open file$ For Binary As #num
            Put #num, 1, tileset
        Close #num
                    
        'Append the tile data.
        Call insertIntoTileSet(file$, tileset.tilesInSet)
        
        'Return the new tile number.
        addToTileSet = tileset.tilesInSet
        
    Else
        'Tile header couldn't be read or tst has the wrong detail level.
        MsgBox "Couldn't add to selected tileset", , "Incorrect version or detail level"
        addToTileSet = -1
    End If

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function calcInsertionPoint(ByRef ts As tilesetHeader, ByVal num As Long) As Long
'===================================================
'Calculates insertion point of tile #num in tileset.
'Returns the byte position in the file.
'.tst header is 6 bytes long!
'===================================================
'Edited by Delano for 3.0.4
'Added isometric case as for detail = 1.

'Called by openTileSet and insertIntoTileSet

    On Error GoTo errorhandler
    Dim ret As Long
    
    Select Case ts.detail
    
        Case 1, ISODETAIL:
            'Case added: Isometrics are the same file size!
            '32x32, 16.7 million colors. (32x32x3 bytes each)
            ret = (3072 * (num - 1)) + 7
            calcInsertionPoint = ret
            Exit Function
            
        Case 2:
            '16x16, 16.7 million colors (16x16x3 bytes)
            ret = (768 * (num - 1)) + 7
            calcInsertionPoint = ret
            Exit Function
            
        Case 3:
            '32x32, 256 colors (32x32x1 bytes)
            ret = (1024 * (num - 1)) + 7
            calcInsertionPoint = ret
            Exit Function
            
        Case 4:
            '16x16, 256 colors (16x16x1 bytes)
            ret = (256 * (num - 1)) + 7
            calcInsertionPoint = ret
            Exit Function
            
        Case 5:
            '32x32, 16 colors (32x32x1 byte)
            ret = (1024 * (num - 1)) + 7
            calcInsertionPoint = ret
            Exit Function
            
        Case 6:
            '16x16, 16 colors (16x16,1 bytes)
            ret = (256 * (num - 1)) + 7
            calcInsertionPoint = ret
            Exit Function
           
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function


Function createNewTileSet(ByVal file As String, Optional ByVal bIsometric As Boolean = False) As Integer: On Error Resume Next
'==================================================
'Creates a new tileset and inserts the first tile.
'Called when a new tst is set in the save dialogs.
'file$ is the new name, e.g. "default.tst"
'==================================================
'Edited by Delano for 3.0.4
'Now returns the tilenumber! -> converted to function

'Called by: CommonItem openItem                 -tk2 compat
'           CommonPlayer openchar               -tk2 compat
'(toolkit)  tileedit mnusts_click, savetile2
'           tilesetedit Command1_Click  - unneeded changes, since cannot add .gph to .iso
'           tilesetadd Command1_Click
    
    
    Dim num As Long, tileNumber As Integer, fileType As String
    
    fileType$ = GetExt(file$)                   ' tst or iso.
      
    If bIsometric And UCase$(fileType$) = "ISO" Then
        'Set the header information (6 bytes).
        'bIsometric passed in from forms.
        
        tileset.version = 30                    'Begun for version 3.0.4
        tileset.tilesInSet = 0
        tileset.detail = ISODETAIL              'In case tsts ever get upgraded.
    
    ElseIf Not bIsometric And UCase$(fileType$) = "TST" Then
        'Set the header information (6 bytes).
        
    tileset.version = 20
    tileset.tilesInSet = 0
        tileset.detail = Int(detail)
    End If
        
    
    'Set up a new file and write the header to it.
    num = FreeFile
    Kill file$          'We're creating a new file so we can kill the filename.
    
    Open file$ For Binary As #num
        Put #num, 1, tileset
    Close #num

    'Insert the first tile. tile number is returned (should be 1).
    createNewTileSet = addToTileSet(file$)
    
End Function


Function getTileNum(ByVal file As String) As Long: On Error GoTo errorhandler
'================================================
'Extracts the tile number from the filename.
'e.g. tileset.tst148 would return 148.
'================================================

'Called by: Routines opentile2, openwintile, savetile
'           tileedit mnusts_Click
'           tileinfo Form_Load

'    'New method.
'    Dim strArray() As String, number As String
'
'    'Split the file.
'    strArray$ = Split(file$, ".")
'    'Last element will be the extension. Take off first 3 letters.
'    number$ = Right$(strArray$(UBound(strArray$)), Len(strArray$(UBound(strArray$))) - 3)
'
'    getTileNum = val(number$)
'    Exit Function
'
'    'Old code:

    Dim Length As Long, t As Long, numb As String, part As String
    

    
    Length = Len(file$)
    For t = 1 To Length
        part$ = Mid$(file$, t, 1)
        If part$ = "." Then
            numb$ = Mid$(file$, t + 4, Length - t)
            getTileNum = val(numb$)
            Exit Function
        End If
    Next t

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Sub insertIntoTileSet(ByVal file As String, ByVal number As Long)
'======================================================================
'Inserts current image into the tileset at position 'number'.
'.tst and .iso are written in binary, whereas .gph is written in ascii.
'file$ is the name, e.g. "default.tst"
'======================================================================
'Edited by Delano for 3.0.4
'Added code to prepare the isometric tile for writing.
'Writing uses the same code as for high detail tsts.
'Variables: a >> setType, np >> insertPoint, off >> offset

'Called by: addToTileSet
'           Routines savetile
'NOTES:
' -1 (transparent) is saved as:
'       r0, g1, b2 in RGB
'       255 in 256 or 16

    On Error Resume Next
    Dim rrr As String * 1
    Dim ggg As String * 1
    Dim bbb As String * 1
    
    Dim num As Long, setType As Long, insertPoint As Long, Offset As Long, xx As Long, yy As Long
    Dim xCount As Integer, yCount As Integer
    Dim rr As Long, gg As Long, bb As Long
    
    num = FreeFile
    
    'Check the tst header.
    setType = tilesetInfo(file$)
    
        
    '============================================
    ' Isometric tileset addition starts here.
    ' Preparing the isometric tile for writing.
    
    'If into an isometric set (ISOTYPE).
    If setType = ISOTYPE Then
    
        'Now we're saving in 32x32 form. This will only work if the isometric tile is in
        'a 64x32 arrangement in tilemem - it will be for the tile editor or the tile grabber.
        'Tile saving in the advanced tileset editor is handled separately in that module.
        
        'Loop over the isoMaskBmp and on the unmasked (black) area we take the corresponding
        'pixel from the old tilemem and put it in the *next available* element in a new tilemem.
        'This way tilemem gets completely filled but the pixels will be in the wrong order
        'for normal tiles.
        
        xCount = 1: yCount = 1
        
        'Mask the isometric corners off using the isoMaskBmp
        For xx = 1 To 64
            For yy = 1 To 32
            
                'Store the tilemem temporarily.
                buftile(xx, yy) = tilemem(xx, yy)
            
                If isoMaskBmp(xx, yy) = RGB(0, 0, 0) Then
                    'If the pixel isn't masked (is black), move the pixel.
                    tilemem(xCount, yCount) = tilemem(xx, yy)
                    
'Call traceString("tilemem(" & xCount & ", " & yCount & ") = TileMem(" & xx & ", " & yy & ") = " & isoTileMem(xx, yy))
                    
                    'Increment the entry in the tilemem array.
                    yCount = yCount + 1
                    If yCount > 32 Then
                        xCount = xCount + 1
                        yCount = 1
                    End If
                    
                End If
            Next yy
        Next xx

    End If '(setType = ISOTYPE)
        
    'End isometric preparation. We still need to restore the tilemem array after writing!
    
    'The tile is now ready for writing: .iso uses the same code as high detail .tst.

    If (setType = TSTTYPE And tileset.detail = detail) Or (setType = ISOTYPE And tileset.detail = ISODETAIL) Then
        'Header could be read.
        
        'Calculate next insertion point in bytes.
        insertPoint = calcInsertionPoint(tileset, number)
        
            Open file$ For Binary As #num
        
                Select Case tileset.detail
                Case 1, ISODETAIL:                      'Iso case is the same.
                        '32x32x16.7 million (32x32x3 bytes)
                    Offset = insertPoint
                    
                    'Loop over every pixel in the matrix and write its
                    'RGB values to file.
                        For xx = 1 To 32
                            For yy = 1 To 32
                                If tilemem(xx, yy) = -1 Then
                                'If a transparent pixel, set a specific RGB combination.
                                    rr = 0
                                    gg = 1
                                    bb = 2
                                Else
                                'Calculate the RGB values from the colour value.
                                    rr = red(tilemem(xx, yy))
                                    gg = green(tilemem(xx, yy))
                                    bb = blue(tilemem(xx, yy))
                                End If
                            
                            'Convert the values to strings and write them to file as 3
                            'sequential bytes.
                                rrr = chr$(rr)
                            Put #num, Offset, rrr
                                ggg = chr$(gg)
                            Put #num, Offset + 1, ggg
                                bbb = chr$(bb)
                            Put #num, Offset + 2, bbb
                            
                            Offset = Offset + 3
                            Next yy
                        Next xx
                    
                    Case 2:
                        '16x16x16.7 million (16x16x3 bytes)
                    Offset = insertPoint
                        For xx = 1 To 16
                            For yy = 1 To 16
                        
                                If tilemem(xx, yy) = -1 Then
                                    rr = 0
                                    gg = 1
                                    bb = 2
                                Else
                                    rr = red(tilemem(xx, yy))
                                    gg = green(tilemem(xx, yy))
                                    bb = blue(tilemem(xx, yy))
                                End If
                            
                                rrr = chr$(rr)
                            Put #num, Offset, rrr
                                ggg = chr$(gg)
                            Put #num, Offset + 1, ggg
                                bbb = chr$(bb)
                            Put #num, Offset + 2, bbb
                            
                            Offset = Offset + 3
                            Next yy
                        Next xx
                    
                    Case 3, 5:
                        '32x32x256 colors (32x32x1 bytes) (or 16 colors)
                    Offset = insertPoint
                    
                    'Loop over every pixel in the matrix and write its
                    'RGB value to file.
                        For xx = 1 To 32
                            For yy = 1 To 32
                        
                                If tilemem(xx, yy) = -1 Then
                                'If transparent, set the value as 255.
                                    rrr = chr$(255)
                                Else
                                'Convert the RGB value to a string.
                                    rrr = chr$(tilemem(xx, yy))
                                End If
                            
                            'Write the colour string to file.
                            Put #num, Offset, rrr
                            
                            Offset = Offset + 1
                            Next yy
                        Next xx
                    
                    Case 4, 6:
                        '16x16x256 colors (32x32x1 bytes) (or 16 colors)
                    Offset = insertPoint
                        For xx = 1 To 16
                            For yy = 1 To 16
                        
                                If tilemem(xx, yy) = -1 Then
                                    rrr = chr$(255)
                                Else
                                    rrr = chr$(tilemem(xx, yy))
                                End If
                            
                            Put #num, Offset, rrr
                            
                            Offset = Offset + 1
                            Next yy
                        Next xx
                End Select
            
            Close #num
        Else
        'Detail level does not match.
        MsgBox "Cannot insert into tileset!", , "Wrong filetype or detail level"
        
    End If '(setType = TSTTYPE Or setType = ISOTYPE)
    
    If setType = ISOTYPE Then
        'Restore the tilemem from the buffer.
        For xx = 1 To 64
            For yy = 1 To 32
                tilemem(xx, yy) = buftile(xx, yy)
            Next yy
        Next xx
    End If
    
End Sub

Sub openFromTileSet(ByVal file As String, ByVal number As Long): On Error GoTo errorhandler
'=====================================
'Opens tile number from a tileset.
'Loads it into tilemem
'file$ is the name, e.g. "default.tst"
'=====================================
'Edited by Delano for 3.0.4
'Opening a .iso uses the same code as a high detail .tst.
'Variables: a >> setType, np >> insertPoint, off >> offset

'Called by: Routines opentile2, openwintile
'           tilesetadd Command2_Click, List1_Click
    
  
    Dim rrr As String * 1
    Dim ggg As String * 1
    Dim bbb As String * 1

    Dim setType As Long, num As Long, xx As Long, yy As Long, insertPoint As Long, Offset As Long
    
    'Check the tst header.
    setType = tilesetInfo(file$)
    
    'Check the tile number being accessed is in the tileset.
    If number < 1 Or number > tileset.tilesInSet Then Exit Sub
    
    ChDir (currentDir$)
    
    'New tile type. This is exactly the same as for the case of standard high colour tsts!
    'Note: we're reading isometric tiles into tilemem! But this won't look right!
    'Drawing is handled by DrawTileIso in CommonTileDoc.

    If setType = TSTTYPE Or setType = ISOTYPE Then
        'If the header was read.
 
        detail = tileset.detail
        
        num = FreeFile
        Open file$ For Binary As #num
        
            'Calculate next insertion point in bytes.
            insertPoint = calcInsertionPoint(tileset, number)
            
            Select Case tileset.detail
                Case 1, ISODETAIL:                  'Addition.
                
                    detail = 1                      'Addition.
                    '32x32x16.7 million
                    Offset = insertPoint
                    
                    'Loop over every pixel in the tile and and read its RGB values from file.
                    For xx = 1 To 32
                        For yy = 1 To 32
                        
                            Get #num, Offset, rrr
                            Get #num, Offset + 1, ggg
                            Get #num, Offset + 2, bbb
                            Offset = Offset + 3
                            
                            'Convert the strings to numbers.
                            If Asc(rrr) = 0 And Asc(ggg) = 1 And Asc(bbb) = 2 Then
                                'Transparent colour.
                                tilemem(xx, yy) = -1
                            Else
                                'Set the colour value of the RGB components.
                                tilemem(xx, yy) = RGB(Asc(rrr), Asc(ggg), Asc(bbb))
                            End If
                        Next yy
                    Next xx
                    
                Case 2:
                    '16x16x16.7 million
                    Offset = insertPoint
                    
                    For xx = 1 To 16
                        For yy = 1 To 16
                        
                            Get #num, Offset, rrr
                            Get #num, Offset + 1, ggg
                            Get #num, Offset + 2, bbb
                            Offset = Offset + 3
                            
                            If Asc(rrr) = 0 And Asc(ggg) = 1 And Asc(bbb) = 2 Then
                                'Transparent colour.
                                tilemem(xx, yy) = -1
                            Else
                                tilemem(xx, yy) = RGB(Asc(rrr), Asc(ggg), Asc(bbb))
                            End If
                            
                        Next yy
                    Next xx
                    
                Case 3, 5:
                    '32x32x256 (or 16)
                    Offset = insertPoint
                    
                    For xx = 1 To 32
                        For yy = 1 To 32
                        
                            Get #num, Offset, rrr
                            Offset = Offset + 1
                            
                            If Asc(rrr) = 255 Then
                                'Transparent colour.
                                tilemem(xx, yy) = -1
                            Else
                                tilemem(xx, yy) = Asc(rrr)
                            End If
                            
                        Next yy
                    Next xx
                    
                Case 4, 6:
                    '16x16x256 (or 16)
                    Offset = insertPoint
                    
                    For xx = 1 To 16
                        For yy = 1 To 16
                        
                            Get #num, Offset, rrr
                            Offset = Offset + 1
                            
                            If Asc(rrr) = 255 Then
                                'Transparent colour.
                                tilemem(xx, yy) = -1
                            Else
                                tilemem(xx, yy) = Asc(rrr)
                            End If
                            
                        Next yy
                    Next xx
            End Select
            
        Close #num
    End If '(setType = TSTTYPE Or setType = ISOTYPE)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Function tilesetFilename(ByVal file As String) As String: On Error GoTo errorhandler
'========================================================
'Returns filename without the number after the extention.
'e.g. "default.tst123" returns "default.tst"
'========================================================
'Edited by Delano for 3.0.4
'Rewrote using arrays - to allow for both .iso and .tst
    
'Called by: CommonTileAnim tileaniminsert
'           Commonboard openboard
'           Commontkgfx drawtile, drawtileCNV
'           Routines opentile2, openwintile, savetile
'           tileinfo Form_Load
    
    'New method.
    Dim strArray() As String
    
    'Split the file.
    strArray$ = Split(file$, ".")
    'Last element will be the extension. Take the first 3 letters.
    strArray$(UBound(strArray$)) = Left$(strArray$(UBound(strArray$)), 3)
    
    tilesetFilename$ = Join(strArray$, ".")

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function

Function tilesetInfo(ByVal file As String) As Long: On Error GoTo tserr
'==========================================
'Gets tileset header.
'Returns 0 on success, 1 on failure, 2 on isometric.
'New constants introduced:
'       TSTTYPE = 0
'       ISOTYPE = 2
'file$ is the name, e.g. "default.tst"
'==========================================
'Edited Delano for 3.0.4

'Called by: CommonTileset addToTileSet, insertIntoTileSet, openFromTileSet
'           tkMainForm fillTilesetBar
'           tileedit mnusts_Click, savetile2_Click
'           tilesetform Form_Load
'           tilesetedit Command1_Click
'           tilesetadd Command1_Click, Form_Load

    
    
    Dim errorsA As Long, num As Long
    
    errorsA = 0
    tilesetInfo = 1
    
    num = FreeFile
    Open file$ For Binary As #num
        Get #num, 1, tileset
    Close #num
    
    If errorsA = 1 Then Exit Function
    
    If tileset.version = 30 And tileset.detail = ISODETAIL And UCase$(GetExt(file$)) = "ISO" Then
        'This is an isometric tileset.
        tilesetInfo = ISOTYPE
            
    ElseIf tileset.version = 20 And UCase$(GetExt(file$)) = "TST" Then
        'This is a standard tileset.
        tilesetInfo = TSTTYPE
              
    End If
        
    Exit Function
    
tserr:
    errorsA = 1
Resume Next
End Function
