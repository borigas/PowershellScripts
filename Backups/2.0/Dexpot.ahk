;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Windows 7
; Author:         Ben Origas <borigas@gmail.com>
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include Functions.ahk

;Make function run on Windows power event
OnMessage(0x218, "DexpotStartPowerEvent")

;Causes skip over hotkeys so can chain autoexecute sections via #Include
Gosub DexpotAHKEnd

;Next Desktop-----------------------------------------------------------------------------
^!]::Send ^!{Right}

;Previous Desktop-----------------------------------------------------------------------------
^![::Send ^!{Left}

;Runs on windows power event-----------------------------------------------------------------------------
;Starts Dexpot
DexpotStartPowerEvent(wParam, lParam){	
	If (lParam = 0) {
		If (wParam = 7 OR wParam = 8) {
			StartDexpot()
		}
	}
}

;Start Dexpot**********************************************************************************
StartDexpot(){
	Process Exist, dexpot.exe
	If (%ErrorLevel% = 0)
	{
		;MsgBox Dexpot Starting
		Run, C:\Program Files (x86)\Dexpot\dexpot.exe
	}
}

;Keep at bottom of script
DexpotAHKEnd: