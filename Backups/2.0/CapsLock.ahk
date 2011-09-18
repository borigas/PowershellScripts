;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Windows 7
; Author:         Ben Origas <borigas@gmail.com>

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include Functions.ahk

;End of AutoExecute Section
;Causes skip over body so can chain autoexecute sections via #Include
Gosub CapslockEnd

CapsLock & j::
	CheckModifiersNamedKey("Left")
Return

CapsLock & l::
	CheckModifiersNamedKey("Right")
Return

CapsLock & k::
	CheckModifiersNamedKey("Down")
Return

CapsLock & i::
	CheckModifiersNamedKey("Up")
Return

CapsLock & n::
	CheckModifiersNamedKey("Home")
Return

CapsLock & m::
	CheckModifiersNamedKey("End")
Return

CapsLock & u::
	CheckModifiersNamedKey("Backspace")
Return

CapsLock & o::
	CheckModifiersNamedKey("Delete")
Return

Capslock & Space::
	WinMinimize,A
Return

CapslockEnd: