#requireAdmin
#pragma compile(Icon, orange-mushrom.ico)
#include <WinAPI.au3>
#include <Date.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>

global $gName = 'KartDrift', $hWND = WinGetHandle($gName)
global $isGo = false, $titleIsGo = false
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
AdlibRegister("fetchTitle", 1000)	;~ refresh the title bar every 1 second

;~ helper toggle
func togglePlay()
	$isGo = not $isGo
	if $isGo <> true then
		WinSetTitle($hWND, "", $gName&' '&'🔅 off')
	else
		WinSetTitle($hWND, "", $gName&' '&'🔅 on')
	endif
	return $isGo
endfunc

;~ INTO THE LOOOOOP
while Sleep(3000)
	;~ waiting $isGo value for run
	if $isGo <> true then
		$titleIsGo = false
	else
		$titleIsGo = true
		ControlSend($hWND, "", "", "{R}")
		ControlSend($hWND, "", "", "{Q}")
		ControlSend($hWND, "", "", "{ESC}")
	endif
wend	;~ end main

;~ the title bar has refresh
func fetchTitle()
	_TicksToTime(Int(TimerDiff($gTimer)), $gHour, $gMin, $gSec)
	local $sTime = $gTime
	local $gTime = timeFormat($gHour, $gMin, $gSec)

	if $sTime <> $gTime then
		local $titlAdd = $gTime

		if $titleIsGo <> true then
			if mod($gSec, 5) == 0 then
				WinSetTitle($hWND, "", $gName&' '&$arrIdle[1])
			else
				WinSetTitle($hWND, "", $gName&' '&$arrIdle[0]&' '&$arrIdle[2])
			endif
		else
			WinSetTitle($hWND, "", $gName&' '&$arrPlay[$count])
			$count += 1

			if $count == UBound($arrPlay) then	;~ $count == $arrPlay.length
				$count = 0
			endif
		endif


	endif
endfunc

;~ == NECESSARY FILES

;~ customize time format
func timeFormat($h, $m, $s)
	if $h == 0 and $m == 0 then
		return StringFormat("%i", $s)
	elseif $h == 0 and $m <> 0 then
		return StringFormat("%i:%i", $m, $s)
	else
		return StringFormat("%i:%i:%i", $h, $m, $s)
	endif
endfunc

;~ reset window size
func setWindowSize()
	WinActivate($hWND)
	$pos = WinGetPos($hWND)
	if UBound($pos) <> 0 then	;~ $pos.length != 0
		$newX = (@DesktopWidth - $pos[2]) / 2
		$newY = (@DesktopHeight - $pos[3]) / 2

		if $pos[2] <> 960 or $pos[3] <> 540 then
			WinMove($hWND, '', $newX, $newY, 960, 540)
		endif

		WinActivate($hWND)
	endif
endfunc

;~ exit app
func onExit()
	AdlibUnRegister("fetchTitle")
	$gName = 'KartDrift'
	WinSetTitle($hWND, "", $gName)
	MsgBox(0, "Exit", "The app is shutting down.", .5)
	exit
endfunc