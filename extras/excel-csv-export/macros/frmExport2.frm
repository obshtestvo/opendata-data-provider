VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frmExport2 
   Caption         =   "Insert Starting Point"
   ClientHeight    =   1560
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3030
   OleObjectBlob   =   "frmExport2.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frmExport2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub btnSubmit_Click()
frmExport2.Hide
frmExport.AutoDetectColumnsRows txtSRow.Text, txtSCol.Text
End Sub

Private Sub UserForm_Click()

End Sub
