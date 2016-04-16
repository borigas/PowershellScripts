;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Windows 7
; Author:         Ben Origas <borigas@gmail.com>
;

;Auto Execute************************************************************************************
#Include Libraries/AHKHID.ahk
#Include Libraries/Bin2Hex.ahk
#Include Functions.ahk

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#MaxHotkeysPerInterval 200

;Create GUI to receive messages
Gui, +LastFound
hGui := WinExist()

;Intercept WM_INPUT messages
WM_INPUT := 0xFF
OnMessage(WM_INPUT, "InputMsg")

;Register Remote Control with RIDEV_INPUTSINK (so that data is received even in the background)
AHKHID_Register(12, 1, hGui, RIDEV_INPUTSINK)

;Register Mouse
;AHKHID_Register(1, 2, hGui, RIDEV_INPUTSINK)

;End of AutoExecute Section
;Causes skip over body so can chain autoexecute sections via #Include
Gosub HID_Control_End

InputMsg(wParam, lParam) {
    Local devh, iKey, sLabel
    Critical
   
    ;Get handle of device
    devh := AHKHID_GetInputInfo(lParam, II_DEVHANDLE)
	   
    ;Check for error
    If (devh <> -1) {
        ;Get data
        iKey := AHKHID_GetInputData(lParam, uData)
		
        ;Check for error
        If (iKey <> -1) {
			DevType := AHKHID_GetDevInfo(devh, DI_DEVTYPE, True)
			Vendor := AHKHID_GetDevInfo(devh, DI_HID_VENDORID, True)
			ProductID := AHKHID_GetDevInfo(devh, DI_HID_PRODUCTID, True)
			VersionNum := AHKHID_GetDevInfo(devh, DI_HID_VERSIONNUMBER, True)
				
			;Check if it is my remote
			If (DevType = RIM_TYPEHID)
				And (Vendor = 1118)
				And (ProductID = 109)
				And (VersionNum = 272) {
					;Get keycode (0 indexed)
					iKey := NumGet(uData, 2, "UChar")
					sLabel := "Remote_" iKey
			/*
			} Else If (DevType = RIM_TYPEMOUSE)
				And (Vendor = 256)
				And (ProductID = 16)
				And (VersionNum = 0) {
					Flags := AHKHID_GetInputInfo(lParam, II_MSE_FLAGS) 
					ButtonFlags := AHKHID_GetInputInfo(lParam, II_MSE_BUTTONFLAGS) 
					ButtonData := AHKHID_GetInputInfo(lParam, II_MSE_BUTTONDATA) 
					RawButtons := AHKHID_GetInputInfo(lParam, II_MSE_RAWBUTTONS) 
					LastX := AHKHID_GetInputInfo(lParam, II_MSE_LASTX)
					LastY := AHKHID_GetInputInfo(lParam, II_MSE_LASTY) 
					ExtraInfo := AHKHID_GetInputInfo(lParam, II_MSE_EXTRAINFO)
					MsgBox ButtonFlags %ButtonFlags% ButtonFlags %ButtonFlags%
					;len := AHKHID_GetInputData(lParam, uData)
					;MsgBox %len%
					;Hex := Bin2Hex(&uData, len)
					;MsgBox %Hex%
			*/
			} Else {
				;MsgBox DevType %DevType%, Vendor %Vendor%, ProductID %ProductID%, VersionNum %VersionNum%, MouseType %RIM_TYPEMOUSE%
				sLabel := ""
			}
		   
            ;Call the appropriate sub if it exists
            If IsLabel(sLabel){
                Gosub, %sLabel%
			} Else If (sLabel <> "") {
				;MsgBox Label %sLabel% Not Found
			}
        }
    }
}
;Media Center Button
Remote_81:
	TurnOffLCD()
Return

HID_Control_End: