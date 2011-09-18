;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Windows 7
; Author:         Ben Origas <borigas@gmail.com>
;

#Include Libraries/COM.ahk
#Include Libraries/VA.ahk
COM_Init()

;End of AutoExecute Section
;Causes skip over body so can chain autoexecute sections via #Include
Gosub FunctionsAHKEnd

VolumeUp(ChangeAmount){
	if (!IsMuted())
	{
		Send {Volume_Up %ChangeAmount%}
	}
}

VolumeDown(ChangeAmount){
	if (!IsMuted())
	{
		Send {Volume_Down %ChangeAmount%}
	}
}

MuteUnmute(){
  Send {Volume_Mute}
}

IsMuted(){
	master_mute := VA_GetMasterMute()
	return master_mute <> 0
}

PlayPause(){
	Send {Media_Play_Pause}
}

Signature(){
	SendInput Thanks,{Enter}Ben Origas
}

KillProcess(FriendlyName, ProcessName){
	MsgBox, 4, Kill %FriendlyName%?, Would you like to kill %FriendlyName%?
	IfMsgBox Yes
	{
		Process Close, %ProcessName%
	}
}

TurnOffLCD(){
	Sleep 800
	Run, Programs\TurnOffLCD.exe
}

RefreshInternet(){
	Run, Programs\RefreshInternet.bat
}

CheckModifiersNamedKey(keyName){
	keyName := "{" . keyName . "}"

	shiftStatus := GetKeyState("Shift")
	altStatus := GetKeyState("Alt")
	ctrlStatus := GetKeyState("Ctrl")
	
	if(ctrlStatus = 1){
		modifierKeys = ^%modifierKeys%
	}
	if(altStatus = 1){
		modifierKeys = !%modifierKeys%
	}
	if(shiftStatus = 1){
		modifierKeys = +%modifierKeys%
	}
	
	keyName := modifierKeys . keyName
	Send, %keyName%
}

FunctionsAHKEnd: