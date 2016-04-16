
; Comma-delimited list of processes to exclude.
ProcessGatherExcludeList = sidebar.exe

Gosub MonitorSwapEnd

SwapMonitorWindows(){
    global ProcessGatherExcludeList
	
	SetWinDelay, -1
	
	; Copy bounds of all monitors to an array.
    SysGet, monCount, MonitorCount
    Loop, %monCount%
	{
		SysGet, monitor%A_Index%, MonitorWorkArea, %A_Index%
		;MsgBox % monitor%A_Index%Left . ", " . monitor%A_Index%Right . ", " . monitor%A_Index%Top . ", " . monitor%A_Index%Bottom
	}	
	
	; Get all windows
	WinGet, windows, List
	
	Loop, %windows%
	{
        ; Set Last Found Window.
        WinExist("ahk_id " . windows%A_Index%)
		WinGet, procName, ProcessName
		
		;Check if its excluded
		if procName in %ProcessGatherExcludeList%
		{
			;MsgBox ProcNameExcluding %procName% %ProcessGatherExcludeList%
			continue
		}
		
		WinGet, maximizedState, MinMax
		if(maximizedState = 1 || maximizedState = -1)
		{
			WinRestore
		}
		WinGetPos, x, y, w, h
		currentMonitor = 
		Loop, %monCount%
		{
			; "//" causes integer division
			avgX := x + (w//2)
			avgY := y + (h//2)
			if(avgX >= monitor%A_Index%Left && avgX < monitor%A_Index%Right && avgY >= monitor%A_Index%Top && avgY < monitor%A_Index%Bottom)
			{
				currentMonitor = %A_Index%
				break
			}
		}
		
		; If current monitor was identifiable
		if currentMonitor != 
		{
			nextMonitor := currentMonitor + 1
			if(nextMonitor > monCount)
			{
				nextMonitor := nextMonitor - monCount
			}
			
			if(currentMonitor = nextMonitor)
			{
				continue
			}
			xScale := (monitor%nextMonitor%Right - monitor%nextMonitor%Left) / (monitor%currentMonitor%Right - monitor%currentMonitor%Left)
			yScale := (monitor%nextMonitor%Bottom - monitor%nextMonitor%Top) / (monitor%currentMonitor%Bottom - monitor%currentMonitor%Top)
			
			;MsgBox % "Moving " . procName . " from " . currentMonitor . " to " . nextMonitor
			
			newLeft := monitor%nextMonitor%Left + (x - monitor%currentMonitor%Left) * xScale
			newTop := monitor%nextMonitor%Top + (y - monitor%currentMonitor%Top) * yScale
			newWidth := w * xScale
			newHeight := h * yScale
			
			if(procName = "spotify.exe"){
				MsgBox % "Moving " . procName . " from " . currentMonitor . " to " . nextMonitor . " x: " . x . " y: " . y . " w: " . w . " h: " . h
			}
			
			WinMove,,, newLeft, newTop, newWidth, newHeight
			
		}
		if(maximizedState = 1)
		{
			WinMaximize
		}
		else if(maximizedState = -1)
		{
			WinMinimize
		}
	}
}

MonitorSwapEnd: