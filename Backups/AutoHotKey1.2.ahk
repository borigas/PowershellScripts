;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;

;Auto Execute************************************************************************************
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
:SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#MaxHotkeysPerInterval 200
#NoTrayIcon
SendMode Input
#Include Libraries/COM.ahk
#Include Libraries/VA.ahk
COM_Init()

;Make function run on Windows power event
OnMessage(0x218, "fn_PowerEvent")


;Test area************************************************************************************
^!d::GoSub StartDexpot

;Media/Volume************************************************************************************

;Play/Pause-------------------------------------------------------------------------------
^!l::Send {Media_Play_Pause}

;Mute-------------------------------------------------------------------------------------
^m::
  Send {Volume_Mute}
  ;GoSub, VolumeOSDVista
return

;Volume down-------------------------------------------------------------------------------
/*^![::
  master_mute := VA_GetMasterMute()
  ;master_vol := VA_GetMasterVolume()
  if master_mute = 0
  {
  	Send {Volume_Down 5}
	;ShowVolOSD()
	;Progress, master_vol	
  }
  return
*/
!WheelDown::
  master_mute := VA_GetMasterMute()
  ;master_vol := VA_GetMasterVolume()
  if master_mute = 0
  {
  	Send {Volume_Down}
	;ShowVolOSD()
	;Progress, master_vol
  	;GoSub,VolumeOSDVista
  }
return

;Volume up-------------------------------------------------------------------------------
/*
^!]::
  master_mute := VA_GetMasterMute()
  ;master_vol := VA_GetMasterVolume()
  if master_mute = 0
  {
  	Send {Volume_Up 5}
	;ShowVolOSD()
	;Progress, master_vol	
  }
return
*/

!WheelUp::
  master_mute := VA_GetMasterMute()
  ;master_vol := VA_GetMasterVolume()
  if master_mute = 0
  {
  	Send {Volume_Up}
	;ShowVolOSD()
	;Progress, master_vol
  	;GoSub,VolumeOSDVista
  }
return

;Previous-------------------------------------------------------------------------------
^[::Send {Media_Prev}

;Next-------------------------------------------------------------------------------
^]::Send {Media_Next}

;More************************************************************************************

;Crash firefox, causing save of session------------------------------------------------
^!+f::
	MsgBox, 4, Kill Firefox?, Would you like to kill Firefox?
	IfMsgBox Yes
		Process Close, firefox.exe
return

;Kill uTorrent and restart------------------------------------------------
^!+u::
	MsgBox, 4, Restart µTorrent?, Would you like to restart µTorrent?
	IfMsgBox No
		return
	WinClose, µTorrent 2.0
	Process, Close, uTorrent.exe
	Sleep 800
	Run, C:\Program Files (x86)\uTorrent\uTorrent.exe
return

;RefreshInternetConnection------------------------------------------------
^!+i::
	Run, RefreshInternet.bat
return

;Middle Mouse Button-------------------------------------------------------------------------------
^l::Send {MButton}

;Next Desktop-----------------------------------------------------------------------------
^!]::Send ^!{Right}

;Previous Desktop-----------------------------------------------------------------------------
^![::Send ^!{Left}

;TurnOffLCD-----------------------------------------------------------------------------
^!m::
	Sleep 800
	Run, C:\Program Files\Turn Off LCD.exe
return

;Email signature line-------------------------------------------------------------------------------
^!s::Send Thanks,{Enter}Ben Origas

;Old************************************************************************************

;Reload script-------------------------------------------------------------------------------
^!+a::
	Reload
return

;Ultramon Hotkey (Move to other monitor)--------------------------------------------------------------
;^![::Send ^!n

;Aero flip-------------------------------------------------------------------------------
;^!]::Send #^{Tab}

;Show Desktop-----------------------------------------------------------------------------
;^![::Send #d

;Runs on windows power event-----------------------------------------------------------------------------
;Starts Dexpot
fn_PowerEvent(wParam, lParam){	
	If (lParam = 0) {
		If (wParam = 7 OR wParam = 8) {
			GoSub StartDexpot
		}
	}
}


;Start Dexpot**********************************************************************************
StartDexpot:
	Process Exist, dexpot.exe
	If %ErrorLevel% = 0
	{
		;MsgBox Dexpot Starting
		Run, C:\Program Files (x86)\Dexpot\dexpot.exe
	}
return


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