#requireAdmin
#pragma compile(Icon, icon.ico)
#include <WinAPI.au3>
#include <Date.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>

global $gName = 'KartDrift', $hWND = WinGetHandle($gName)
global $paused = false, $isGoing = false
global $gTimer, $gSec, $gMin, $gHour, $gTime
global $count = 0
global $arrPlay[16] = ['🔸 🔸 🔸', '🟡 🔸 🔸', '🟡 🟡 🔸', '🟡 🟡 🟡', '🔸 🔸 🔸', '🟨 🔸 🔸', '🟨 🟨 🔸', '🟨 🟨 🟨', '🔸 🔸 🔸', '⚙️ 🔸 🔸', '⚙️ ⚙️ 🔸', '⚙️ ⚙️ ⚙️', '🔸 🔸 🔸', '❤️ 🔸 🔸', '❤️ ❤️ 🔸', '❤️ ❤️ ❤️']
global $arrIdle[3] = ['🟡  HOME : play & pause ', '🟡  END : exit ', '🟡  F5 : resize window ']

Opt("MouseCoordMode", 2)
HotKeySet("{END}", "onExit")
HotKeySet("{HOME}", "togglePlay")
HotKeySet("{F5}", "setWindowSize")

setWindowSize()
$gTimer = TimerInit()
AdlibRegister("fetchTitle", 1000)

while Sleep(2000)
	if $paused == true then
		ControlSend($hWND, "", "", "{R}")
		ControlSend($hWND, "", "", "{Q}")
		ControlSend($hWND, "", "", "{ESC}")
		$isGoing = true
	else
		$isGoing = false
	endif
wend

func togglePlay()
	$paused = not $paused
	if $paused == true then
		WinSetTitle($hWND, "", $gName&' '&'🔅 on')
	else
		WinSetTitle($hWND, "", $gName&' '&'🔅 off')
	endif
	return $paused
endfunc

func fetchTitle()
	_TicksToTime(Int(TimerDiff($gTimer)), $gHour, $gMin, $gSec)
	local $sTime = $gTime
	local $gTime = timeFormat($gHour, $gMin, $gSec)

	if $sTime <> $gTime then
		local $titlAdd = $gTime

		if $isGoing <> true then
			if mod($gSec, 5) == 0 then
				WinSetTitle($hWND, "", $gName&' '&$arrIdle[1])
			else
				WinSetTitle($hWND, "", $gName&' '&$arrIdle[0]&' '&$arrIdle[2])
			endif
		else
			WinSetTitle($hWND, "", $gName&' '&$arrPlay[$count])
			$count += 1

			if $count == UBound($arrPlay) then
				$count = 0
			endif

		endif
	endif
endfunc

func timeFormat($h, $m, $s)
	if $h == 0 and $m == 0 then
		return StringFormat("%i", $s)
	elseif $h == 0 and $m <> 0 then
		return StringFormat("%i:%i", $m, $s)
	else
		return StringFormat("%i:%i:%i", $h, $m, $s)
	endif
endfunc

func setWindowSize()
	WinActivate($hWND)
	$pos = WinGetPos($hWND)
	if UBound($pos) <> 0 then
		$newX = (@DesktopWidth - $pos[2]) / 2
		$newY = (@DesktopHeight - $pos[3]) / 2

		if $pos[2] <> 960 or $pos[3] <> 540 then
			WinMove($hWND, '', $newX, $newY, 960, 540)
		endif

		WinActivate($hWND)
	endif
endfunc

func onExit()
	AdlibUnRegister("fetchTitle")
	$gName = 'KartDrift'
	WinSetTitle($hWND, "", $gName)
	MsgBox(0, "Exit", "The app is shutting down.", .5)
	exit
endfunc