Attribute VB_Name = "paksystem"
'pak file subsystem
'feb 14, 2001
Declare Function PAKAdd Lib "tkpak.dll" (ByVal fileToAdd As String, ByVal addAs As String, ByVal pakfile As String) As Long

Declare Function PAKAddCompressed Lib "tkpak.dll" (ByVal fileToAdd As String, ByVal addAs As String, ByVal pakfile As String, ByVal CompType As Long) As Long

Declare Function PAKExtract Lib "tkpak.dll" (ByVal fileToExt As String, ByVal saveAs As String, ByVal pakfile As String) As Long

Declare Function PAKGetFileCount Lib "tkpak.dll" (ByVal pakfile As String) As Long

Declare Function PAKFileExist Lib "tkpak.dll" (ByVal FileToCheck As String, ByVal pakfile As String) As Long

Declare Function PAKTest Lib "tkpak.dll" () As Long

Global Const CompTypeHUFF = 0   'huffman compression
Global Const CompTypeZLIB = 1   'using zlib compression
Function CountProjectFiles() As Integer
    'returns the total number of files in the project
    count = 1 'the main file counts as 1
    
    'count stuff in tiles dir...
    a$ = Dir$(projectPath$ + tilepath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop
    
    'count stuff in board dir...
    a$ = Dir$(projectPath$ + brdpath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop
    
    'count stuff in character dir...
    a$ = Dir$(projectPath$ + tempath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in spc dir...
    a$ = Dir$(projectPath$ + spcpath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in bkg dir...
    a$ = Dir$(projectPath$ + bkgpath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in media dir...
    a$ = Dir$(projectPath$ + mediapath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in prg dir...
    a$ = Dir$(projectPath$ + prgpath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in font dir...
    a$ = Dir$(projectPath$ + fontpath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in item dir...
    a$ = Dir$(projectPath$ + itmpath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in enemy dir...
    a$ = Dir$(projectPath$ + enepath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in bmp dir...
    a$ = Dir$(projectPath$ + bmppath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop
    
    'count stuff in ststuas dir...
    a$ = Dir$(projectPath$ + statuspath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    'count stuff in misc dir...
    a$ = Dir$(projectPath$ + miscPath$ + "*.*")
    Do While a$ <> ""
        count = count + 1
        a$ = Dir$
    Loop

    CountProjectFiles = count
End Function


Sub CreatePakFile(file As String, compressYN As Boolean)
    'creates a pakfile from the currently loaded project.
    'also compresses if indicated.
    
    Dim numFiles As Integer
    
    numFiles = CountProjectFiles()
    If numFiles = 0 Then Exit Sub
    
    statusbar.Show

    'now add the files to the pakfile...
    
    count = 0
    If Not (compressYN) Then
        'first add the main file...
        l = PAKAdd(gampath$ + mainfile$, "main.gam", file)
        count = count + 1
        p = Int(count / numFiles * 100)
        statusbar.setStatus (p)
        
        'tile dir...
        a$ = Dir$(projectPath$ + tilepath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + tilepath$ + a$, tilepath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'board dir...
        a$ = Dir$(projectPath$ + brdpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + brdpath$ + a$, brdpath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'char dir...
        a$ = Dir$(projectPath$ + tempath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + tempath$ + a$, tempath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'spc dir...
        a$ = Dir$(projectPath$ + spcpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + spcpath$ + a$, spcpath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
    
        'bkg dir...
        a$ = Dir$(projectPath$ + bkgpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + bkgpath$ + a$, bkgpath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'media dir...
        a$ = Dir$(projectPath$ + mediapath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + mediapath$ + a$, mediapath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'prg dir...
        a$ = Dir$(projectPath$ + prgpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + prgpath$ + a$, prgpath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'font dir...
        a$ = Dir$(projectPath$ + fontpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + fontpath$ + a$, fontpath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'item dir...
        a$ = Dir$(projectPath$ + itmpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + itmpath$ + a$, itmpath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
    
        'ene dir...
        a$ = Dir$(projectPath$ + enepath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + enepath$ + a$, enepath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
    
        'bmp dir...
        a$ = Dir$(projectPath$ + bmppath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + bmppath$ + a$, bmppath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
   
        'status dir...
        a$ = Dir$(projectPath$ + statuspath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + statuspath$ + a$, statuspath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'misc dir...
        a$ = Dir$(projectPath$ + miscPath$ + "*.*")
        Do While a$ <> ""
            l = PAKAdd(projectPath$ + miscPath$ + a$, miscPath$ + a$, file)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
    Else
        'COMPRESSION!
        'first add the main file...
        l = PAKAddCompressed(gampath$ + mainfile$, "main.gam", file, CompTypeZLIB)
        count = count + 1
        p = Int(count / numFiles * 100)
        statusbar.setStatus (p)
        
        'tile dir...
        a$ = Dir$(projectPath$ + tilepath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + tilepath$ + a$, tilepath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'board dir...
        a$ = Dir$(projectPath$ + brdpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + brdpath$ + a$, brdpath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'char dir...
        a$ = Dir$(projectPath$ + tempath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + tempath$ + a$, tempath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'spc dir...
        a$ = Dir$(projectPath$ + spcpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + spcpath$ + a$, spcpath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
    
        'bkg dir...
        a$ = Dir$(projectPath$ + bkgpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + bkgpath$ + a$, bkgpath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'media dir...
        a$ = Dir$(projectPath$ + mediapath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + mediapath$ + a$, mediapath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'prg dir...
        a$ = Dir$(projectPath$ + prgpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + prgpath$ + a$, prgpath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'font dir...
        a$ = Dir$(projectPath$ + fontpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + fontpath$ + a$, fontpath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'item dir...
        a$ = Dir$(projectPath$ + itmpath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + itmpath$ + a$, itmpath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
    
        'ene dir...
        a$ = Dir$(projectPath$ + enepath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + enepath$ + a$, enepath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
    
        'bmp dir...
        a$ = Dir$(projectPath$ + bmppath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + bmppath$ + a$, bmppath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
   
        'status dir...
        a$ = Dir$(projectPath$ + statuspath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + statuspath$ + a$, statuspath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
        
        'misc dir...
        a$ = Dir$(projectPath$ + miscPath$ + "*.*")
        Do While a$ <> ""
            l = PAKAddCompressed(projectPath$ + miscPath$ + a$, miscPath$ + a$, file, CompTypeZLIB)
            count = count + 1
            p = Int(count / numFiles * 100)
            statusbar.setStatus (p)
            a$ = Dir$
        Loop
    End If
    
    statusbar.Hide
End Sub


Function PAKTestSystem() As Boolean
    'test pakfile system
    On Error GoTo pakerr
    
    a = PAKTest()
    PAKTestSystem = True
    Exit Function
    
pakerr:
    MsgBox "The file tkpak.dll could not be initialised.  You likely need to download the MFC runtimes.  You can get then at http://rpgtoolkit.com"
    PAKTestSystem = False
End Function


