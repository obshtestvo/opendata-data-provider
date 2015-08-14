VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmExport 
   Caption         =   "Power Export"
   ClientHeight    =   4905
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8205.001
   OleObjectBlob   =   "frmExport.frx":0000
   ShowModal       =   0   'False
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frmExport"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim C1 As Long 'pyrva kolona
Dim C2 As Long 'posledna kolona
Dim R1 As Long 'pyrvi red
Dim R2 As Long 'posleden red

Dim ActSh As Worksheet 'obekt za sheet-a

Dim strSep As String 'Razdelitel - 1 simvol

Dim bigStr As String 'bufer za faila

Dim useStr As String 'string za vremenno syhranenie na stoinostta ot tekushtata kletka

Dim fileSaveName As String 'pylen pyt do file-a za save

Dim WidthArray() As Long 'masiv s dyljinite na poletata

Public Sub AddInfo(MyInfo As String)
txtInfo.Text = txtInfo.Text & Time & "    " & MyInfo & vbCrLf
txtInfo.SetFocus
DoEvents
End Sub



Public Sub CopyBoundariesToVariables()
C1 = txtC1.Text
C2 = txtC2.Text
R1 = txtR1.Text
R2 = txtR2.Text
End Sub

Public Sub AutoDetectColumnsRows(row As Long, col As Long)
'Avtomatichno otkrivane goleminata na lista, posledna kolona i red
Dim i As Long

C1 = col
R1 = row

i = row
While ActSh.Cells(i, col) <> ""
    i = i + 1
Wend
R2 = i - 1

i = col
While ActSh.Cells(row, i) <> ""
    i = i + 1
Wend
C2 = i - 1

txtC1.Text = C1
txtC2.Text = C2
txtR1.Text = R1
txtR2.Text = R2
End Sub


Public Sub MakeBigString()
Dim i As Long
Dim j As Long

For i = R1 To R2
    For j = C1 To C2
        'vzimame tekushtata kletka za po byrza obrabotka (proverqvame dali trqbva trim)
        'slojih .TEXT zashtoto ponqkoga pri chislata pishe 100.00 v kletkata a stoinostta e 100 (exportva se 100 vmesto 100.00)
        If chkTrim Then useStr = Trim(ActSh.Cells(i, j).Text) Else useStr = ActSh.Cells(i, j).Text
        If j < C2 Then
            'tuk trqbva da se otdeli fixed width i drugite
            If rbFixed Then
                bigStr = bigStr & useStr
                bigStr = bigStr & Space(WidthArray(j - C1 + 1) - Len(useStr))
            Else
                bigStr = bigStr & useStr & strSep
            End If
        Else
            'tuk trqbva da se otdeli fixed width i drugite
            If rbFixed Then
                bigStr = bigStr & useStr & Space(WidthArray(j - C1 + 1) - Len(useStr))
            Else
                bigStr = bigStr & useStr
            End If
        End If
    Next j
    If i < R2 Then bigStr = bigStr & vbCrLf
        
'statistika na ekrana
If i Mod 100 = 0 Then
    AddInfo ("Processed " & i & " / " & R2 & " Lines...")
End If

'save vyv file-a kogato bufera e pylen
If Len(bigStr) > 30000 Then
    Put 1, , bigStr
    bigStr = ""
    AddInfo ("Bufer Saved To File(~30K)! Buffer is empty again")
End If

Next i

If Len(bigStr) <= 30000 Then Put 1, , bigStr
Close 1
AddInfo ("Output File is READY!!!")
End Sub


Public Sub WriteAllThis()

fileSaveName = Application.GetSaveAsFilename( _
    InitialFileName:="output.txt", _
    FileFilter:="Text Files (*.*), *.*", _
    Title:="Tell me where to Save IT? :)")
If fileSaveName <> "False" Then
    Open fileSaveName For Binary As #1
    'Put 1, , bigStr
    'Close 1
    AddInfo "File 4 Save Is :  -=" & fileSaveName & "=-"
Else
    AddInfo "FileSave Canceled!"
End If

End Sub










Private Sub cmdAutoCR_Click()
frmExport2.Show 1
End Sub

Private Sub cmdExport_Click()
Dim i As Long
Dim j As Long

'izprazvane na golemiq string
bigStr = ""

'nastroika na pole
CopyBoundariesToVariables

'nastroika na separator
If rbFixed Then strSep = ""
If rbTab Then strSep = Chr(vbKeyTab)
If rbOther Then strSep = txtSep.Text

'nastroika na dyljina na poleta
If rbFixed Then
    ReDim WidthArray(C2 - C1 + 1)
    
    
    If rbAbove Then
        For i = C1 To C2
            WidthArray(i - C1 + 1) = ActSh.Cells(txtRow.Text, i)
        Next i
    End If
    
    
    If rbWidth Then
        For i = C1 To C2
            WidthArray(i - C1 + 1) = Round(ActSh.Cells(txtRow.Text, i).ColumnWidth)
        Next i
    End If
    
    
    If rbauto Then
        For i = C1 To C2
            WidthArray(i - C1 + 1) = Len(ActSh.Cells(R1, i))
        Next i
    End If
    
End If


'!!!!!!!!!!!!
txtInfo.Text = ""
AddInfo ("Exporting " & CStr((R2 - R1 + 1) * (C2 - C1 + 1)) & " cells...........")

WriteAllThis
If fileSaveName = "False" Then Exit Sub
MakeBigString


AddInfo ("-=END=-")
'frmExport.Hide
End Sub

Private Sub rdAuto_Click()

End Sub

Private Sub txtInfo_Change()

End Sub

Private Sub UserForm_Activate()
Set ActSh = ActiveSheet
AutoDetectColumnsRows 1, 1
End Sub

Private Sub UserForm_Click()

End Sub
