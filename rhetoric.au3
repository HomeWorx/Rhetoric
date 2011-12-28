;
;      _ __ _   _  ___ __ _ _ __
;     | '__| | | |/ __/ _` | '__|
;     | |  | |_| | (_| (_| | |
;     |_|   \__, |\___\__,_|_|
;           |___/
;
;
; rhetoric.au3
; -------------------------------------------------------------
; Starts Reason and automatically enters your login information
;

if not FileExists("rhetoric.txt") Then
    $handle = FileOpen("rhetoric.txt",2)
    FileWriteLine($handle,"PutUsernameHere")
    FileWriteLine($handle,"PutPasswordHere")
    FileClose($handle)
    msgbox(0,"Rhetoric","Please edit 'rhetoric.txt' and put your username on the first line and password on the second line.")
    ShellExecuteWait("notepad.exe","rhetoric.txt")
EndIf

dim $username="PutUsernameHere"
dim $password="PutPasswordHere"

$handle=fileopen("rhetoric.txt")
$username=FileReadLine($handle,1)
$password=FileReadLine($handle,2)

if ($username="PutUsernameHere" or $username="" or $password="PutPasswordHere" or $password="") Then
    msgbox(0,"Rhetoric","Please edit 'rhetoric.txt' and put your username on the first line and password on the second line. After you have done so, run this program again.")
    ShellExecuteWait("notepad.exe","rhetoric.txt")
    Exit
EndIf

if  ProcessExists("reason.exe" ) Then
    ; Reason is already running
else
	; Reason is not running, starting Reason
	if FileExists("C:\Program Files\Propellerhead\Reason\Reason.exe") then
		ShellExecute("C:\Program Files\Propellerhead\Reason\Reason.exe")
	elseif FileExists("C:\Program Files (x86)\Propellerhead\Reason\Reason.exe") then
		ShellExecute("C:\Program Files (x86)\Propellerhead\Reason\Reason.exe")
	EndIf
EndIf

if not WinExists("Internet Verification") then
	if (WinWait ("Application Authorization","",30)=0) then Exit
	ControlClick("Application Authorization","","[CLASS:Button; INSTANCE:2]")
EndIf

if (WinWait ("Internet Verification","",5)=0) then Exit
ControlSetText("Internet Verification","","[CLASS:Edit; INSTANCE:1]",$username)
ControlSetText("Internet Verification","","[CLASS:Edit; INSTANCE:2]",$password)
ControlClick("Internet Verification","","[CLASS:Button; INSTANCE:1]")

Exit