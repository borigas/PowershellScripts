;#Persistent
;SetTimer, MyTimer, 3000
;return

;MyTimer:
;msgbox It Works
;ExitApp
;return

maxTime := 500
iterationTime := 10
maxIterations := maxTime / iterationTime

MouseGetPos, xInit, yInit

i := 0
loop := 1
while(i < maxIterations and loop == 1)
{
	i := i + 1
	MouseGetPos, xCur, yCur
	if(xCur - 10 > xInit)
	{
		loop := 0
		Send {LWin down}{Right}{LWin up}
		;msgbox, Moved right
	}
	else if(xCur + 10 < xInit)
	{
		loop := 0
		Send {LWin down}{Left}{LWin up}
		;msgbox, Moved left
	}
	else if(yCur - 10 > yInit)
	{
		loop := 0
		Send {LWin down}{Down}{LWin up}
		;msgbox, Moved down
	}
	else if(yCur + 10 < yInit)
	{
		loop := 0
		Send {LWin down}{Up}{LWin up}
		;msgbox, Moved up
	}
	Sleep %iterationTime%
}

if(loop == 1)
{
	msgbox Timed out %1%
}