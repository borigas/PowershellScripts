;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Windows 7
; Author:         Ben Origas <borigas@gmail.com>
;

#Include Libraries/COM.ahk
#Include Libraries/VA.ahk
COM_Init()

;End of AutoExecute Section
;Causes skip over body so can chain autoexecute sections via #Include
Gosub FunctionsAHKEnd

VolumeUp(ChangeAmount){
	if (!IsMuted())
	{
		Send {Volume_Up %ChangeAmount%}
	}
}

VolumeDown(ChangeAmount){
	if (!IsMuted())
	{
		Send {Volume_Down %ChangeAmount%}
	}
}

MuteUnmute(){
  Send {Volume_Mute}
}

IsMuted(){
	master_mute := VA_GetMasterMute()
	return master_mute <> 0
}

PlayPause(){
	Send {Media_Play_Pause}
}

MediaNext(){
	Send {Media_Next}
}

MediaPrevious(){
	Send {Media_Prev}
}

PandoraSkip(){
	Send ^!+9
}

PandoraPause(){
	Send ^!+8
}

Undo(){
	Send ^z
}

Cut(){
	Send ^x
}

Copy(){
	Send ^c
}

Paste(){
	Send ^v
}

Save(){
	Send ^s
}

TypeSignature(){
	SendInput Thanks,{Enter}Ben Origas
}

TypeMyName(){
	SendInput Ben Origas
}

TypeMyUsername(){
	SendInput borigas
}

TypeMyDomain(){
	SendInput benorigas.com
}

TypeMyEmail(){
	SendInput borigas@gmail.com
}

TypeWorkEmail(){
	SendInput borigas@nebraskaglobal.com
}

TypeQwerty(){
	SendInput Qwerty
}

TypeAvalanche(){
	SendInput Avalanche
}

TypeBruin(){
	SendInput Bruin
}

TypeCornhusker(){
	SendInput Cornhusker
}

KillProcess(FriendlyName, ProcessName){
	MsgBox, 4, Kill %FriendlyName%?, Would you like to kill %FriendlyName%?
	IfMsgBox Yes
	{
		Process Close, %ProcessName%
	}
}

TurnOffLCD(){
	Sleep 800
	Run, Programs\TurnOffLCD.exe
}

RefreshInternet(){
	Run, Programs\RefreshInternet.bat
}

CheckModifiersNamedKey(keyName){
	keyName := "{" . keyName . "}"

	shiftStatus := GetKeyState("Shift")
	altStatus := GetKeyState("Alt")
	ctrlStatus := GetKeyState("Ctrl")
	
	if(ctrlStatus = 1){
		modifierKeys = ^%modifierKeys%
	}
	if(altStatus = 1){
		modifierKeys = !%modifierKeys%
	}
	if(shiftStatus = 1){
		modifierKeys = +%modifierKeys%
	}
	
	keyName := modifierKeys . keyName
	Send, %keyName%
}

DynamicLoadScript(){
	; if compliled
	if (A_IsCompiled = 1){
		loadFileName = AHK%A_ScriptName%
		Process, Close, %loadFileName%
		
		;Direct to user's app data folder
		EnvGet, AppDataFolder, LOCALAPPDATA
		if(StrLen(AppDataFolder) < 10){
			AppDataFolder = C:\AutoHotKey
		}
		
		IfNotExist, %AppDataFolder%
		{
			MsgBox, Creating %AppDataFolder%
			FileCreateDir, %AppDataFolder%
		}
		
		loadFileName = %AppDataFolder%\%loadFileName%
		
		;Copy script
		CopyIfNewer(A_ScriptName, loadFileName)
		
		;Copy programs directory
		;FileCopyDir, %A_ScriptDir%\Programs, %AppDataFolder%\Programs, 0
		
		IfNotExist, %AppDataFolder%\Programs
		{
			MsgBox, Creating %AppDataFolder%\Programs
			FileCreateDir, %AppDataFolder%\Programs
		}
		Loop, %A_ScriptDir%\Programs\*, 1, 1
		{
			StringReplace, destPath, A_LoopFileLongPath, %A_ScriptDir%, %AppDataFolder%
			CopyIfNewer(A_LoopFileLongPath, destPath)
		}
		
		Run, %loadFileName% start
		ExitApp
	}
}

CopyIfNewer(sourcePath, destPath){
	preventCopy = 0
	IfExist, %destPath%
	{
		FileGetTime, sourceModTime, %sourcePath%, M
		FileGetTime, destModTime, %destPath%, M
		if (destModTime = sourceModTime){
			preventCopy = 1
		}
	}
	if (preventCopy <> 1){
		FileCopy, %sourcePath%, %destPath%, 1
		if ErrorLevel
			MsgBox, Could not copy "%sourcePath%" to "%destPath%"
	}
}

FunctionsAHKEnd: