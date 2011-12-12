;
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

;Navigation Shortcuts-------------------------------------------------
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

CapsLock & h::
	CheckModifiersNamedKey("Home")
Return

CapsLock & `;::
	CheckModifiersNamedKey("End")
Return

CapsLock & n::
	Send {Control Down}
	CheckModifiersNamedKey("Left")
	Send {Control Up}
return

CapsLock & m::
	Send {Control Down}
	CheckModifiersNamedKey("Right")
	Send {Control Up}
Return

CapsLock & u::
	CheckModifiersNamedKey("Backspace")
Return

CapsLock & o::
	CheckModifiersNamedKey("Delete")
Return

CapsLock & y::
	Send {Control Down}
	CheckModifiersNamedKey("Backspace")
	Send {Control Up}
Return

CapsLock & p::
	Send {Control Down}
	CheckModifiersNamedKey("Delete")
	Send {Control Up}
Return

;Text Expansion--------------------------------------------------------
;Type email signature
CapsLock & a::
	Send {CapsLock up}
	TypeSignature()
return

CapsLock & s::
	Send {CapsLock up}
	SwapMonitorWindows()
return

CapsLock & d::
	Send {CapsLock up}
	TypeMyDomain()
return

CapsLock & f::
	Send {CapsLock up}
	TypeWorkEmail()
return

CapsLock & g::
	Send {CapsLock up}
	TypeMyEmail()
return

;Mouse Hotkeys-------------------------------------------------
^CapsLock UP::
	SetCapsLockState, Off
return

CapsLock & MButton::
	;IfWinExist ahk_class SpotifyMainWindow
	;{
		;PlayPause()
	;}
	;else IfWinExist ahk_class ahk_class WMPlayerApp
	;{
		PlayPause()
	;}
	;else
	;{
		;PandoraPause()
	;}
return

^[::
	Send {WheelLeft}
return

CapsLock & [::
	MediaPrevious()
return

^]::
	Send {WheelRight}
return

CapsLock & ]::
	IfWinExist ahk_class SpotifyMainWindow
	{
		MediaNext()
	}
	else IfWinExist ahk_class ahk_class WMPlayerApp
	{
		MediaNext()
	}
	else
	{
		PandoraSkip()
	}
return

CapsLock & WheelUp::
	VolumeUp(2)
return

CapsLock & WheelDown::
	VolumeDown(2)
return

;Media Hotkeys-------------------------------------------------
CapsLock & r::
	PlayPause()
return

CapsLock & e::
	MediaPrevious()
return

CapsLock & t::
	MediaNext()
return

CapsLock & w::
	VolumeUp(2)
return

CapsLock & q::
	VolumeDown(2)
return

CapsLock & Tab::
	MuteUnmute()
return

CapsLock & x::
	PandoraPause()
return

CapsLock & c::
	PandoraSkip()
return

;Misc Actions--------------------------------------------------
CapsLock & z::
	TurnOffLCD()
return

;Minimize window-----------------------------------------------
CapsLock & Space::
	WinMinimize,A
Return

CapsLockEnd: