;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Windows 7
; Author:         Ben Origas <borigas@gmail.com>
;

;Auto Execute************************************************************************************
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#SingleInstance force
#MaxHotkeysPerInterval 200
#NoTrayIcon
#Include Functions.ahk
#Include Hotkeys_dvorak.ahk
#Include HID_Control.ahk


;Show the tray icon if the script is not compiled
If (A_IsCompiled <> 1) {
	menu, tray, Icon
	fileExtension = .ahk
}else{
	fileExtension = .exe
}


; If start up (no cmd line params)
StringLen, argLen, 1
if (argLen = 0){
	;Start mouse volume if it exists
;	mouseVolName = MouseVolume%fileExtension%
;	if (FileExist(mouseVolName) != ""){
;		Run, %mouseVolName%
;	}
	
	DynamicLoadScript()
}

;Here on is only for the persistent instances

;End of AutoExecute Section
;Causes skip over body so can chain autoexecute sections via #Include
Gosub MyAutoHotKeyAHKEnd

MyAutoHotKeyAHKEnd: