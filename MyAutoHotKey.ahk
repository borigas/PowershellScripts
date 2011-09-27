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
#Include CapsLock.ahk
#Include Dexpot.ahk
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
	

;Handles dynamic load
cmdLineArgs = %1%
scriptName = %A_ScriptName%

;Here on is only for the persistent instances

;End of AutoExecute Section
;Causes skip over body so can chain autoexecute sections via #Include
Gosub MyAutoHotKeyAHKEnd

;More************************************************************************************

;Crash firefox, causing save of session------------------------------------------------
^!+f::
	KillProcess("Firefox", "firefox.exe")
return

;Crash Chrome, causing save of session------------------------------------------------
^!+c::
	KillProcess("Chrome", "chrome.exe")
return

;Kill uTorrent and restart------------------------------------------------
^!+u::
	MsgBox, 4, Restart µTorrent?, Would you like to restart µTorrent?
	IfMsgBox No
		return
	Process, Close, uTorrent.exe
	Sleep 800
	Run, C:\Program Files (x86)\uTorrent\uTorrent.exe
return

;RefreshInternetConnection------------------------------------------------
^!+i::
	RefreshInternet()
return

;Paste into command prompt
#IfWinActive ahk_class ConsoleWindowClass
	^v::
		SendInput {Raw}%clipboard%
	return
#IfWinActive

;Reload script-------------------------------------------------------------------------------
^!+r::
	Reload
return

MyAutoHotKeyAHKEnd: