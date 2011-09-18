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

#SingleInstance force
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

mouseVolName = AHKMouseVolume%fileExtension%
if (FileExist(mouseVolName) != ""){
	Run, %mouseVolName%
}

;End of AutoExecute Section
;Causes skip over body so can chain autoexecute sections via #Include
Gosub MyAutoHotKeyAHKEnd

;Media Controls-------------------------------------------------------------------------------
^!l::
	PlayPause()
Return

^[::Send {Media_Prev}

^]::Send {Media_Next}

;Volume Controls-------------------------------------------------------------------------------------
^m::
	MuteUnmute()
return

^+[::
	VolumeDown(2)
return

^+]::
	VolumeUp(2)
return

;!WheelDown::
	;VolumeDown(2)
;return

;!WheelUp::
	;VolumeUp(2)
;return

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

;Middle Mouse Button-------------------------------------------------------------------------------
^l::Send {MButton}

;TurnOffLCD-----------------------------------------------------------------------------
^!m::
	TurnOffLCD()
return

;Email signature line-------------------------------------------------------------------------------
^!s::
	Signature()
return

;Paste into command prompt
#IfWinActive ahk_class ConsoleWindowClass
	^v::
		SendInput {Raw}%clipboard%
	return
#IfWinActive

;Old************************************************************************************

;Reload script-------------------------------------------------------------------------------
^!+r::
	Reload
return

;Ultramon Hotkey (Move to other monitor)--------------------------------------------------------------
;^![::Send ^!n

;Aero flip-------------------------------------------------------------------------------
;^!]::Send #^{Tab}

;Show Desktop-----------------------------------------------------------------------------
;^![::Send #d


;Volume OSD***********************************************************************************
/*VolumeOSDVista:
  If Not OSDon
  {
    WinGetActiveTitle, prevWindow
    CoordMode,Mouse,Screen
    MouseGetPos,mX,mY
    MouseClick,Left,1340,880,1,0 ; click the sound icon in tray
    ;Run, C:\Windows\System32\SndVol.exe -f
    WinGetActiveTitle, volumeWindow
    Sleep 300	;Pause .3s to make sure the volume slider opens on bottom right
    ;MouseMove,%mX%,%mY%,0
    OSDon=1
  }
  SetTimer,RemoveOSDVista,3000  ;Make it stay for 3s
Return

RemoveOSDVista:
  IfWinExist %volumeWindow%
    WinClose
  OSDon=0
  SetTimer,RemoveOSDVista,off
  IfWinExist %prevWindow%
  {
    WinGet, isMin, MinMax, %prevWindow%
    If (isMin != -1){
      WinActivate
    }
  }
Return

ShowVolOSD(){
	master_vol := VA_GetMasterVolume()
	Progress, BP50CBFF0000
;	Progress, %master_vol%
;	SplashImage, C:\Users\Public\Pictures\Sample Pictures\Penguins.jpg, B
}
*/

MyAutoHotKeyAHKEnd: