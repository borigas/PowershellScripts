; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Windows 7
; Author:         Ben Origas <borigas@gmail.com>

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include Functions.ahk
#Include MonitorSwap.ahk

;End of AutoExecute Section
;Causes skip over body so can chain autoexecute sections via #Include
Gosub CapsLockEnd

;Navigation and Editing -------------------------------------------------
CapsLock & h::
	CheckModifiersNamedKey("Left")
Return

CapsLock & n::
	CheckModifiersNamedKey("Right")
Return

CapsLock & t::
	CheckModifiersNamedKey("Down")
Return

CapsLock & c::
	CheckModifiersNamedKey("Up")
Return

CapsLock & d::
	CheckModifiersNamedKey("Home")
Return

CapsLock & s::
	CheckModifiersNamedKey("End")
Return

CapsLock & w::
	CheckModifiersNamedKey("PgUp")
Return

CapsLock & v::
	CheckModifiersNamedKey("PgDn")
Return

CapsLock & b::
	Send {Control Down}
	CheckModifiersNamedKey("Left")
	Send {Control Up}
return

CapsLock & m::
	Send {Control Down}
	CheckModifiersNamedKey("Right")
	Send {Control Up}
Return

CapsLock & g::
	CheckModifiersNamedKey("Backspace")
Return

CapsLock & r::
	CheckModifiersNamedKey("Delete")
Return

CapsLock & f::
	Send {Control Down}
	CheckModifiersNamedKey("Backspace")
	Send {Control Up}
Return

CapsLock & l::
	Send {Control Down}
	CheckModifiersNamedKey("Delete")
	Send {Control Up}
Return

;Text Expansion--------------------------------------------------------
;Type email signature
;CapsLock & a::
;	Send {CapsLock up}
;	TypeSignature()
;return

;sCapsLock & o::
;	Send {CapsLock up}
;	TypeMyName()
;return

;CapsLock & e::
;	Send {CapsLock up}
;	TypeMyDomain()
;return

;CapsLock & u::
;	Send {CapsLock up}
;	TypeMyUsername()
;return

;CapsLock & i::
;	Send {CapsLock up}
;	TypeMyEmail()
;return

;Mouse Hotkeys-------------------------------------------------
CapsLock UP::
	SetCapsLockState, Off
return

!CapsLock UP::
	SetCapsLockState, Off
return

CapsLock & MButton::
	PlayPause()
return

![::
	Send {WheelLeft}
return

CapsLock & [::
	MediaPrevious()
return

!]::
	Send {WheelRight}
return

CapsLock & ]::
	MediaNext()
return

CapsLock & WheelUp::
	VolumeUp(2)
return

CapsLock & WheelDown::
	VolumeDown(2)
return

;Media Hotkeys-------------------------------------------------
CapsLock & p::
	PlayPause()
return

CapsLock & .::
	MediaPrevious()
return

CapsLock & y::
	MediaNext()
return

CapsLock & ,::
	VolumeUp(2)
return

CapsLock & `;::
	VolumeDown(2)
return

CapsLock & Tab::
	MuteUnmute()
return

;Dvorak helpers-----------------------------------------------
CapsLock & '::
	Undo()
return

CapsLock & q::
	Cut()
return

CapsLock & j::
	Copy()
return

CapsLock & k::
	Paste()
return

CapsLock & o::
	Save()
return

;Misc Actions--------------------------------------------------
CapsLock & `::
#'::
	TurnOffLCD()
return

#o::
	SwapMonitorWindows()
return

;More************************************************************************************

;Crash firefox, causing save of session------------------------------------------------
^!+f::
	KillProcess("Firefox", "firefox.exe")
return

;Crash Chrome, causing save of session------------------------------------------------
^!+c::
	KillProcess("Chrome", "chrome.exe")
return

;Paste into command prompt
;#IfWinActive ahk_class ConsoleWindowClass
;	^v::
;		SendInput {Raw}%clipboard%
;	return
;#IfWinActive

;Reload script-------------------------------------------------------------------------------
^!+r::
	Reload
return

;Exit script
^!+x::
	ExitApp, 0
return
CapsLockEnd:
