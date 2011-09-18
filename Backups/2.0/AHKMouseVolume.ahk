;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Windows 7
; Author:         Ben Origas <borigas@gmail.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force
#MaxHotkeysPerInterval 200
#NoTrayIcon

;Show the tray icon if the script is not compiled
If (A_IsCompiled <> 1) {
	menu, tray, Icon
}

;End of AutoExecute Section
;Causes skip over body so can chain autoexecute sections via #Include
Gosub MouseVolumeAHKEnd

;Body of script here
!WheelDown::
	Send {Volume_Down 2}
return

!WheelUp::
	Send {Volume_Up 2}
return


MouseVolumeAHKEnd: