Attribute VB_Name = "tilest"
'Tileset module-- defines a tileset

Type tilesetHeader  '6 bytes
    version As Integer  '20=2.0, 21=2.1, etc
    tilesInSet As Integer 'number of tiles in set
    detail As Integer   'detail level in set MUST BE UNIFORM!
End Type

Global tileset As tilesetHeader    'current tileset file

Function addToTileSet(file$) As Integer
    'adds the current tile to the tileset.
    'returns the number in the tst
    On Error Goto errorhandler
    a = tilesetInfo(file$)
    If a = 0 And tileset.detail = detail Then
        tileset.tilesInSet = tileset.tilesInSet + 1
        num = FreeFile
        Open file$ For Binary As #num
            Put #num, 1, tileset
        Close #num
        Call insertIntoTileSet(file$, tileset.tilesInSet)
        addToTileSet = tileset.tilesInSet
    Else
        MsgBox "Couldn't add to selected tileset", , "Incorrect version or detail level"
        addToTileSet = -1
    End If

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function


Function calcInsertionPoint(ts As tilesetHeader, num)
    'calculates insertion point of tile #num in tileset
    'header is 6 bytes long!
    On Error Goto errorhandler
    Select Case ts.detail
        Case 1:
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
    Call HandleError()
    Resume Next
End Function


Sub createNewTileSet(file$)
    'creates a new tileset
    'inserts current tile
    On Error Resume Next
    tileset.version = 20
    tileset.detail = Int(detail)
    tileset.tilesInSet = 0
    
    num = FreeFile
    Kill file$
    Open file$ For Binary As #num
        Put #num, 1, tileset
    Close #num
    'now to insert the image...
    aa = addToTileSet(file$)
End Sub


Function getTileNum(file$)
    'finds out which tile number
    'it is based upon a
    'filename.
    'ie: tileset.tst148
    'would yeild 148 as the return value
    'for this function.
    On Error Goto errorhandler
    length = Len(file$)
    For t = 1 To length
        part$ = Mid$(file$, t, 1)
        If part$ = "." Then
            numb$ = Mid$(file$, t + 4, length - t)
            getTileNum = val(numb$)
            Exit Function
        End If
    Next t

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function

Sub insertIntoTileSet(file$, number)
    'inserts current image into the tileset,
    'at position 'number'
    'NOTES:
    '-1 (transparent) is saved as:
    ' r0, g1, b2 in RGB
    ' 255 in 256 or 16
    On Error Resume Next
    Dim rrr As String * 1
    Dim ggg As String * 1
    Dim bbb As String * 1
    num = FreeFile
    a = tilesetInfo(file$)
    If a = 0 Then
        If tileset.detail = detail Then
            'calculate next insertion point...
            np = calcInsertionPoint(tileset, number)
            Open file$ For Binary As #num
                Select Case tileset.detail
                    Case 1:
                        '32x32x16.7 million (32x32x3 bytes)
                        off = np
                        For xx = 1 To 32
                            For yy = 1 To 32
                                If tilemem(xx, yy) = -1 Then
                                    rr = 0
                                    gg = 1
                                    bb = 2
                                Else
                                    rr = red(tilemem(xx, yy))
                                    gg = green(tilemem(xx, yy))
                                    bb = blue(tilemem(xx, yy))
                                End If
                                rrr = Chr$(rr)
                                Put #num, off, rrr
                                ggg = Chr$(gg)
                                Put #num, off + 1, ggg
                                bbb = Chr$(bb)
                                Put #num, off + 2, bbb
                                off = off + 3
                            Next yy
                        Next xx
                    Case 2:
                        '16x16x16.7 million (16x16x3 bytes)
                        off = np
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
                                rrr = Chr$(rr)
                                Put #num, off, rrr
                                ggg = Chr$(gg)
                                Put #num, off + 1, ggg
                                bbb = Chr$(bb)
                                Put #num, off + 2, bbb
                                off = off + 3
                            Next yy
                        Next xx
                    Case 3, 5:
                        '32x32x256 colors (32x32x1 bytes) (or 16 colors)
                        off = np
                        For xx = 1 To 32
                            For yy = 1 To 32
                                If tilemem(xx, yy) = -1 Then
                                    rrr = Chr$(255)
                                Else
                                    rrr = Chr$(tilemem(xx, yy))
                                End If
                                Put #num, off, rrr
                                off = off + 1
                            Next yy
                        Next xx
                    Case 4, 6:
                        '16x16x256 colors (32x32x1 bytes) (or 16 colors)
                        off = np
                        For xx = 1 To 16
                            For yy = 1 To 16
                                If tilemem(xx, yy) = -1 Then
                                    rrr = Chr$(255)
                                Else
                                    rrr = Chr$(tilemem(xx, yy))
                                End If
                                Put #num, off, rrr
                                off = off + 1
                            Next yy
                        Next xx
                End Select
            Close #num
        Else
            MsgBox "Cannot insert into tilest!", , "Wrong detail level"
        End If
    End If
End Sub

Sub openFromTileSet(file$, number)
    'opens tile #number from a tileset by the
    'name of file$
    On Error Goto errorhandler
    Dim rrr As String * 1
    Dim ggg As String * 1
    Dim bbb As String * 1

    a = tilesetInfo(file$)
    If number < 1 Or number > tileset.tilesInSet Then Exit Sub
    If a = 0 Then
        detail = tileset.detail
        num = FreeFile
        Open file$ For Binary As #num
            np = calcInsertionPoint(tileset, number)
            Select Case tileset.detail
                Case 1:
                    '32x32x16.7 million
                    off = np
                    For xx = 1 To 32
                        For yy = 1 To 32
                            Get #num, off, rrr
                            Get #num, off + 1, ggg
                            Get #num, off + 2, bbb
                            off = off + 3
                            If Asc(rrr) = 0 And Asc(ggg) = 1 And Asc(bbb) = 2 Then
                                tilemem(xx, yy) = -1
                            Else
                                tilemem(xx, yy) = RGB(Asc(rrr), Asc(ggg), Asc(bbb))
                            End If
                        Next yy
                    Next xx
                Case 2:
                    '16x16x16.7 million
                    off = np
                    For xx = 1 To 16
                        For yy = 1 To 16
                            Get #num, off, rrr
                            Get #num, off + 1, ggg
                            Get #num, off + 2, bbb
                            off = off + 3
                            If Asc(rrr) = 0 And Asc(ggg) = 1 And Asc(bbb) = 2 Then
                                tilemem(xx, yy) = -1
                            Else
                                tilemem(xx, yy) = RGB(Asc(rrr), Asc(ggg), Asc(bbb))
                            End If
                        Next yy
                    Next xx
                Case 3, 5:
                    '32x32x256 (or 16)
                    off = np
                    For xx = 1 To 32
                        For yy = 1 To 32
                            Get #num, off, rrr
                            off = off + 1
                            If Asc(rrr) = 255 Then
                                tilemem(xx, yy) = -1
                            Else
                                tilemem(xx, yy) = Asc(rrr)
                            End If
                        Next yy
                    Next xx
                Case 4, 6:
                    '16x16x256 (or 16)
                    off = np
                    For xx = 1 To 16
                        For yy = 1 To 16
                            Get #num, off, rrr
                            off = off + 1
                            If Asc(rrr) = 255 Then
                                tilemem(xx, yy) = -1
                            Else
                                tilemem(xx, yy) = Asc(rrr)
                            End If
                        Next yy
                    Next xx
            End Select
        Close #num
    Else
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Function tilesetFilename(file$)
    'returns filename without the number
    'after the extention.
    On Error Goto errorhandler
    length = Len(file$)
    ret$ = ""
    For t = 1 To length
        part$ = Mid$(file$, t, 1)
        If part$ = "." Then
            ret$ = ret$ + ".tst"
            tilesetFilename = ret$
            Exit Function
        End If
        ret$ = ret$ + part$
    Next t

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function

Function tilesetInfo(file$)
    'gets tileset header.
    'returns 0 on success, 1 on failure
    On Error GoTo tserr
    
    errorsa = 0
    num = FreeFile
    Open file$ For Binary As #num
        Get #num, 1, tileset
    Close #num
    If tileset.version <> 20 Or errorsa = 1 Then
        tilesetInfo = 1
        Exit Function
    End If
    tilesetInfo = 0
    Exit Function
    
tserr:
    errorsa = 1
Resume Next
End Function


