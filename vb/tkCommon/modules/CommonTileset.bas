Attribute VB_Name = "CommonTileset"
'==============================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'==============================================================================
Option Explicit
'==============================================================================
'Tileset module-- defines a tileset
'==============================================================================

Public Type tilesetHeader               '6 bytes.
    version As Integer                  '20=2.0, 21=2.1, etc.
    tilesInSet As Integer               'number of tiles in set.
    detail As Integer                   'detail level in set MUST BE UNIFORM!
End Type

Public tileset As tilesetHeader         'current tileset file

'==============================================================================
' .tst Tileset File Format
'
' File structure:
'   Header:                 (6 bytes)
'       tileset.version = TST_VERSION
'       tileset.tilesInSet
'       tileset.detail = specifies size and bit depth (see calcInsertionPoint)
'   Tiles:                  (size * size * depth bytes)
'       Pixel converted to rgb components, tile saved in columns / rows.
'==============================================================================

'==============================================================================
' .iso Isometric Tileset File Format
' Introduced for 3.0.4
'
' File structure:
'   Header:                 (6 bytes)
'       tileset.version = ISO_VERSION
'       tileset.tilesInSet
'       tileset.detail = ISODETAIL
'   Isometric Tiles:        (32 * 32 * 3 bytes)
'       Tiles are masked - formed into 32x32 array (see insertIntoTileset)
'==============================================================================

'==============================================================================
'Tileset constants
'==============================================================================
Public Const TSTTYPE As Byte = 0                    'Should be 1!
Public Const ISOTYPE As Byte = 2
Public Const ISODETAIL As Byte = 150                'Arbitrary value!
Public Const TR_COLOR_24 As Long = 131328           'Transparent colour in 24-bit tiles = RGB(0,1,2)
Public Const TR_COLOR_8 As Long = 255               'Transparent colour in 8-bit tiles (bc).

Private Const TST_HEADER = 6                        'Length of tileset header in bytes.
Private Const TST_VERSION As Byte = 20
Private Const ISO_VERSION As Byte = 30

Public Function addToTileSet(ByVal file As String) As Integer: On Error Resume Next
'==============================================================================
'Adds the current tile to the end of the tileset.
'Returns the number in the tst.
'file is the tst name, e.g. "default.tst"
'==============================================================================
'Called by: CommonItem openItem         -tk2 compat
'           CommonPlayer openchar       -tk2 compat
'(toolkit)  tileedit mnusts_click, savetile2
'           tilesetedit Command1_Click      - unneeded changes, since cannot add .gph to .iso
'           tilesetadd Command1_Click

    Dim num As Long
    
    If (tilesetInfo(file) = TSTTYPE And tileset.detail = detail) Or _
       (tilesetInfo(file) = ISOTYPE And tileset.detail = ISODETAIL) Then
    
        'If the versions are correct and the header was read.
        tileset.tilesInSet = tileset.tilesInSet + 1
                
        'Set up the file for rewriting the header with the updated tile number.
        num = FreeFile
        
        Open file For Binary Access Write As num
            Put num, 1, tileset
        Close num
                    
        'Append the tile data.
        Call insertIntoTileSet(file, tileset.tilesInSet)
        
        'Return the new tile number.
        addToTileSet = tileset.tilesInSet
        
    Else
        'Tile header couldn't be read or tst has the wrong detail level.
        MsgBox "Couldn't add to selected tileset", , "Incorrect version or detail level"
        addToTileSet = -1
    End If

End Function

Private Function calcInsertionPoint(ByRef ts As tilesetHeader, _
                                    ByRef size As Long, ByRef depth As Long, _
                                    ByVal number As Long) As Long
'==============================================================================
'Calculates the byte position of the number tile in a tileset by on its quality.
'Assigns size and depth dependent on quality.
'==============================================================================
'Called by openTileSet and insertIntoTileSet

    On Error Resume Next

    Select Case ts.detail
        Case 1, ISODETAIL
            '32x32, 16.7 million colors (32x32x3 bytes)
            size = 32: depth = 3
        Case 2
            '16x16, 16.7 million colors (16x16x3 bytes)
            size = 16: depth = 3
        Case 3, 5
            '32x32, 256 colors (32x32x1 bytes)
            size = 32: depth = 1
        Case 4, 6
            '16x16, 256 colors (16x16x1 bytes)
            size = 16: depth = 1
        Case Else
            size = 32: depth = 3
    End Select
    
    calcInsertionPoint = size * size * depth * (number - 1) + (TST_HEADER + 1)

End Function

Public Function createNewTileSet(ByVal file As String, Optional ByVal bIsometric As Boolean = False) As Integer: On Error Resume Next
'==============================================================================
'Creates a new tileset and inserts the first tile.
'Called when a new tst is set in the save dialogs.
'file is the new name, e.g. "default.tst"
'==============================================================================
'Called by: CommonItem openItem                 -tk2 compat
'           CommonPlayer openchar               -tk2 compat
'(toolkit)  tileedit mnusts_click, savetile2
'           tilesetedit Command1_Click  - unneeded changes, since cannot add .gph to .iso
'           tilesetadd Command1_Click
    
    Dim num As Long
    
    If bIsometric And UCase$(GetExt(file)) = "ISO" Then
        'Set the header information (6 bytes).
        'bIsometric passed in from forms.
        
        tileset.version = ISO_VERSION                   'Begun for version 3.0.4
        tileset.tilesInSet = 0
        tileset.detail = ISODETAIL                      'In case tsts ever get upgraded.
    
    ElseIf Not bIsometric And UCase$(GetExt(file)) = "TST" Then
        'Set the header information (6 bytes).
        
        tileset.version = TST_VERSION
        tileset.tilesInSet = 0
        tileset.detail = detail
    End If
        
    'Set up a new file and write the header to it.
    num = FreeFile
    Kill file          'We're creating a new file so we can kill the filename.
    
    Open file For Binary Access Write As num
        Put num, 1, tileset
    Close num

    'Insert the first tile. tile number is returned (should be 1).
    createNewTileSet = addToTileSet(file)
    
End Function

Public Function getTileNum(ByVal file As String) As Long: On Error Resume Next
'==============================================================================
'Extracts the tile number from the filename.
'e.g. tileset.tst148 would return 148.
'==============================================================================
'Called by: Routines opentile2, openwintile, savetile
'           tileedit mnusts_Click
'           tileinfo Form_Load

    Dim strArray() As String, number As String

    'Split the file.
    strArray = Split(file, ".")
    'Last element will be the extension. Take off first 3 letters.
    number = Right$(strArray(UBound(strArray)), Len(strArray(UBound(strArray))) - 3)

    getTileNum = val(number)

End Function

Public Sub insertIntoTileSet(ByVal file As String, ByVal number As Long)
'==============================================================================
'Inserts current image into the tileset at position 'number'.
'.tst and .iso are written in binary, whereas .gph is written in ascii.
'file is the name, e.g. "default.tst"
'==============================================================================
'Last edited by Delano for 3.0.6

'Called by: addToTileSet, Routines savetile

    Dim tileBlock() As Byte, lTile(32, 32) As Long, r As Byte, g As Byte, b As Byte
    Dim position As Long, size As Long, depth As Long, num As Long, element As Long
    Dim x As Long, y As Long, xCount As Long, yCount As Long

    If tilesetInfo(file) = ISOTYPE Then
    
        'Now we're saving in 32x32 form. This will only work if the isometric tile is in
        'a 64x32 arrangement in tilemem - it will be for the tile editor or the tile grabber.
        'Tile saving in the advanced tileset editor is handled separately in that module.
        
        'Loop over the isoMaskBmp and on the unmasked (black) area we take the corresponding
        'pixel from the old tilemem and put it in the *next available* element in a new tilemem.
        'This way tilemem gets completely filled but the pixels will be in the wrong order
        'for normal tiles.
        xCount = 1: yCount = 1
        
        'Mask the isometric corners off using the isoMaskBmp
        For x = 1 To 64
            For y = 1 To 32
            
                If isoMaskBmp(x, y) = RGB(0, 0, 0) Then
                    'If the pixel isn't masked (is black), move the pixel.
                    lTile(xCount, yCount) = lTile(x, y)
                    
                    'Increment the entry in the ltile array.
                    yCount = yCount + 1
                    If yCount > 32 Then
                        xCount = xCount + 1
                        yCount = 1
                    End If
                End If
            Next y
        Next x

    Else
        'Put tileMem straight to the working set.
        For x = 1 To 32
            For y = 1 To 32
                lTile(x, y) = tileMem(x, y)
            Next y
        Next x
    End If '(setType = ISOTYPE)
    

    If (tilesetInfo(file) = TSTTYPE And tileset.detail = detail) Or (tilesetInfo(file) = ISOTYPE And tileset.detail = ISODETAIL) Then
        'Header could be read.
        
        'Calculate next insertion point in bytes.
        position = calcInsertionPoint(tileset, size, depth, number)
        ReDim tileBlock(size * size * depth - 1)
        
        For x = 1 To size
            For y = 1 To size
            
                If depth = 3 Then
                
                    'Convert long colour to rgb byte values.
                    If lTile(x, y) = -1 Then
                        'Transparent colour.
                        r = 0: g = 1: b = 2
                    Else
                        r = red(lTile(x, y))
                        g = green(lTile(x, y))
                        b = blue(lTile(x, y))
                    End If
                    
                    'Set the bytes in the block.
                    tileBlock(element) = r
                    tileBlock(element + 1) = g
                    tileBlock(element + 2) = b
                    element = element + 3
                    
                Else
                
                    If lTile(x, y) = -1 Then
                        'Transparent colour.
                        tileBlock(element) = TR_COLOR_8
                    Else
                        tileBlock(element) = lTile(x, y)
                    End If
                    element = element + 1
                    
                End If
            Next y
        Next x
        
        ChDir (currentDir)
        num = FreeFile
        
        Open file For Binary Access Write As num
    
            Put num, position, tileBlock
            
        Close num

    Else
        'Detail level does not match.
        MsgBox "Cannot insert into tileset!", , "Wrong filetype or detail level"
        
    End If '(setType = TSTTYPE Or setType = ISOTYPE)
    
End Sub

Public Sub openFromTileSet(ByVal file As String, ByVal number As Long): On Error Resume Next
'==============================================================================
'Opens tile number from a tileset.
'Loads it into tilemem. file is the name, e.g. "default.tst"
'==============================================================================
'Last edited by Delano for 3.0.6

'Called by: Routines opentile2, openwintile
'           tilesetadd Command2_Click, List1_Click

    Dim tileBlock() As Byte, size As Long, depth As Long, position As Long
    Dim num As Long, element As Long, x As Long, y As Long
    
    ' Check valid file, valid tile number, valid header.
    If Not fileExists(file) Then Exit Sub
    Dim lngInfo As Long
    lngInfo = tilesetInfo(file)
    If (number < 1 Or number > tileset.tilesInSet) Then Exit Sub
    If (lngInfo <> TSTTYPE And lngInfo <> ISOTYPE) Then Exit Sub
 
    detail = tileset.detail
    If detail = ISODETAIL Then detail = 1
    
    'Receive information about byte position, tile size, byte depth.
    position = calcInsertionPoint(tileset, size, depth, number)
    ReDim tileBlock(size * size * depth - 1)
    
    ChDir (currentDir)
    num = FreeFile
    
    Open file For Binary Access Read As num

        Get num, position, tileBlock
        
    Close num
        
    For x = 1 To size
        For y = 1 To size
        
            If depth = 3 Then
                '3 bytes per colour, convert to rbg.
                'Set the colour value of the RGB components.
                tileMem(x, y) = RGB(tileBlock(element), _
                                    tileBlock(element + 1), _
                                    tileBlock(element + 2))
                element = element + 3
                
                If tileMem(x, y) = TR_COLOR_24 Then
                    'Transparent colour.
                    tileMem(x, y) = -1
                End If
            Else
                '1 byte per colour.
                If tileBlock(element) = TR_COLOR_8 Then
                    'Transparent colour.
                    tileMem(x, y) = -1
                Else
                    tileMem(x, y) = tileBlock(element)
                End If
                element = element + 1
            End If
        Next y
    Next x

End Sub

Public Function tilesetFilename(ByVal file As String) As String: On Error Resume Next
'==============================================================================
'Returns filename without the number after the extention.
'e.g. "default.tst123" returns "default.tst"
'==============================================================================
'Called by: CommonTileAnim tileaniminsert
'           Commonboard openboard
'           Commontkgfx drawtile, drawtileCNV
'           Routines opentile2, openwintile, savetile
'           tileinfo Form_Load
    
    Dim strArray() As String
    
    'Split the file.
    strArray = Split(file, ".")
    'Last element will be the extension. Take the first 3 letters.
    strArray(UBound(strArray)) = Left$(strArray(UBound(strArray)), 3)
    
    tilesetFilename = Join(strArray, ".")

End Function

Public Function tilesetInfo(ByVal file As String) As Long: On Error Resume Next
'==============================================================================
'Gets tileset header.
'Returns TSTTYPE on success, 1 on failure, ISOTYPE on isometric.
'==============================================================================
'Called by: CommonTileset addToTileSet, insertIntoTileSet, openFromTileSet
'           tkMainForm fillTilesetBar
'           tileedit mnusts_Click, savetile2_Click
'           tilesetform Form_Load
'           tilesetedit Command1_Click
'           tilesetadd Command1_Click, Form_Load

    Dim num As Long
    
    If fileExists(file) Then
    
        num = FreeFile
        Open file For Binary Access Read As num
            Get num, 1, tileset
        Close num
        
        Debug.Print tileset.detail & " " & tileset.tilesInSet & " " & tileset.version
    
        If tileset.version = ISO_VERSION And tileset.detail = ISODETAIL And UCase$(GetExt(file)) = "ISO" Then
            'This is an isometric tileset.
            tilesetInfo = ISOTYPE
        ElseIf tileset.version = TST_VERSION And UCase$(GetExt(file)) = "TST" Then
            'This is a standard tileset.
            tilesetInfo = TSTTYPE
        End If
    Else
        'Fail.
        tilesetInfo = 1
    End If
    
End Function
