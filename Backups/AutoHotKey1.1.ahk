 ;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
:SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;User parameters************************************************************************************
#MaxHotkeysPerInterval 200
;#NoTrayIcon 
SendMode Input

;Test area************************************************************************************


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
  SoundGet, master_mute, MASTER, MUTE
  if master_mute = Off
  {
  	Send {Volume_Down 5}
  }
  return
*/
!WheelDown::
  SoundGet, master_mute, MASTER, MUTE
  if master_mute = Off
  {
  	Send {Volume_Down}
  	;GoSub,VolumeOSDVista
  }
return

;Volume up-------------------------------------------------------------------------------
/*
^!]::
  SoundGet, master_mute, MASTER, MUTE
  if master_mute = Off
  {
  	Send {Volume_Up 5}
  }
return
*/

!WheelUp::
  SoundGet, master_mute, MASTER, MUTE
  if master_mute = Off
  {
  	Send {Volume_Up}
  	;GoSub,VolumeOSDVista
  }
return

;Previous-------------------------------------------------------------------------------
^[::Send {Media_Prev}

;Next-------------------------------------------------------------------------------
^]::Send {Media_Next}

;More************************************************************************************

;Middle Mouse Button-------------------------------------------------------------------------------
^l::Send {MButton}

;Next Desktop-----------------------------------------------------------------------------
^!]::Send ^!{Right}

;Previous Desktop-----------------------------------------------------------------------------
^![::Send ^!{Left}

;TurnOffLCD-----------------------------------------------------------------------------
^!m::
	Sleep 500
	Run, C:\Program Files\Turn Off LCD.exe
return

;Old************************************************************************************

;Email signature line-------------------------------------------------------------------------------
^!s::Send Thanks,{Enter}Ben Origas

;Reload script-------------------------------------------------------------------------------
;^!r::Reload

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
Return*/