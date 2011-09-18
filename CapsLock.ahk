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

CapsLock & n::
	CheckModifiersNamedKey("Home")
Return

CapsLock & h::
	CheckModifiersNamedKey("Home")
return

CapsLock & m::
	CheckModifiersNamedKey("End")
Return

CapsLock & `;::
	CheckModifiersNamedKey("End")
Return

CapsLock & u::
	CheckModifiersNamedKey("Backspace")
Return

CapsLock & o::
	CheckModifiersNamedKey("Delete")
Return

;Text Expansion--------------------------------------------------------
;Type email closure
CapsLock & z::
	Send {CapsLock up}
	TypeSignature()
return
;Type my name
CapsLock & s::
	Send {CapsLock up}
	TypeMyName()
return

;Type my domain
CapsLock & d::
	Send {CapsLock up}
	TypeMyDomain()
return

;Type my email address
CapsLock & e::
	Send {CapsLock up}
	TypeMyEmail()
return

CapsLock & w::
	Send {CapsLock up}
	TypeWorkEmail()
return

;Type computer names
CapsLock & q::
	Send {CapsLock up}
	TypeQwerty()
return
CapsLock & a::
	Send {CapsLock up}
	TypeAvalanche()
return
CapsLock & b::
	Send {CapsLock up}
	TypeBruin()
return
CapsLock & c::
	Send {CapsLock up}
	TypeCornhusker()
return


;Minimize window
Capslock & Space::
	WinMinimize,A
Return

CapslockEnd: