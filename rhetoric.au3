#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=rhetoric.exe
#AutoIt3Wrapper_Res_Fileversion=1.0.0.3
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=GFY License
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; rhetoric.au3
; -------------------------------------------------------------
; Starts Reason and automatically enters your login information
; Licensed under the GFY License.  You are free to do whatever.
; Contributors: rycar

If Not FileExists("rhetoric.txt") Then
	$handle = FileOpen("rhetoric.txt", 2)
	FileWriteLine($handle, "PutUsernameHere")
	FileWriteLine($handle, "PutPasswordHere")
	FileClose($handle)
	MsgBox(0, "Rhetoric", "Please edit 'rhetoric.txt' and put your username on the first line and password on the second line.")
	ShellExecuteWait("notepad.exe", "rhetoric.txt")
EndIf

Dim $username = "PutUsernameHere"
Dim $password = "PutPasswordHere"

$handle = FileOpen("rhetoric.txt")
$username = FileReadLine($handle, 1)
$password = FileReadLine($handle, 2)

if ($username = "PutUsernameHere" Or $username = "" Or $password = "PutPasswordHere" Or $password = "") Then
	MsgBox(0, "Rhetoric", "Please edit 'rhetoric.txt' and put your username on the first line and password on the second line. After you have done so, run this program again.")
	ShellExecuteWait("notepad.exe", "rhetoric.txt")
	Exit
EndIf

If ProcessExists("reason.exe") Then
	; Reason is already running
Else
	; Reason is not running, starting Reason
	If FileExists("C:\Program Files\Propellerhead\Reason\Reason.exe") Then
		ShellExecute("C:\Program Files\Propellerhead\Reason\Reason.exe")
	ElseIf FileExists("C:\Program Files (x86)\Propellerhead\Reason\Reason.exe") Then
		ShellExecute("C:\Program Files (x86)\Propellerhead\Reason\Reason.exe")
	EndIf
EndIf

If Not WinExists("Internet Verification") Then
	if (WinWait("Application Authorization", "", 30) = 0) Then Exit
	ControlClick("Application Authorization", "", "[CLASS:Button; INSTANCE:2]")
EndIf

if (WinWait("Internet Verification", "", 5) = 0) Then Exit
ControlSetText("Internet Verification", "", "[CLASS:Edit; INSTANCE:1]", $username)
ControlSetText("Internet Verification", "", "[CLASS:Edit; INSTANCE:2]", $password)
ControlClick("Internet Verification", "", "[CLASS:Button; INSTANCE:1]")

Exit