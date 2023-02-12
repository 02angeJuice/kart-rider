#requireAdmin
#pragma compile(Icon, orange-mushroom.ico)
#include <WinAPI.au3>
#include <Date.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#Include <StaticConstants.au3>
#Include <WindowsConstants.au3>

#include "animate.au3"

global $gName = 'KartDrift', $hWND = WinGetHandle($gName)
global $isGo = false, $titleIsGo = false
global $gTimer, $gSec, $gMin, $gHour, $gTime
global $count = 0
global $arrPlay[16] = ['🔸 🔸 🔸', '🟡 🔸 🔸', '🟡 🟡 🔸', '🟡 🟡 🟡', '🔸 🔸 🔸', '🟨 🔸 🔸', '🟨 🟨 🔸', '🟨 🟨 🟨', '🔸 🔸 🔸', '⚙️ 🔸 🔸', '⚙️ ⚙️ 🔸', '⚙️ ⚙️ ⚙️', '🔸 🔸 🔸', '❤️ 🔸 🔸', '❤️ ❤️ 🔸', '❤️ ❤️ ❤️']
global $arrIdle[3] = ['🟡  HOME : play & pause ', '🟡  END : exit ', '🟡  F5 : resize window ']
global $keys[3] = ["R", "ESC", "Q"]
global $gKeys = 0

Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 0)

Opt("MouseCoordMode", 2)

HotKeySet("{END}", "onExit")
HotKeySet("{HOME}", "togglePlay")
HotKeySet("{F5}", "setWindowSize")

setWindowSize()
trayAnimate('gear','on', 40 )

$gTimer = TimerInit()
AdlibRegister("fetchTitle", 1000)	;~ refresh the title bar every 1 second

;~ INTO THE LOOOOOP
while Sleep(1000)
	;~ waiting $isGo value for run
	if $isGo <> true then
		TraySetIcon("orange-mushroom.ico")
		_Animate_Stop()
		$titleIsGo = false
	else
		_Animate_Start("", 1)
		$titleIsGo = true

		ControlSend($hWND, "", "", '{'&$keys[$gKeys]&'}')
		$gKeys += 1
	endif

	if $gKeys > UBound($keys) - 1 then $gKeys = 0
wend	;~ end main

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

func trayAnimate($name, $order, $frames=0)
	local $n = '\' & $name & '\' & $name & '-'
	if $order == 'on' then
		For $i = 0 To $frames
			_Animate_AddIcon(@ScriptDir & $n & $i & '.ico', 0)
		Next
		return 1
	else
		return 0
	endif
endfunc

;~ the title bar has refresh
func fetchTitle()
	_TicksToTime(Int(TimerDiff($gTimer)), $gHour, $gMin, $gSec)
	local $sTime = $gTime
	local $gTime = timeFormat($gHour, $gMin, $gSec)

	if $sTime <> $gTime then
		local $titlAdd = $gTime

		if $titleIsGo <> true then
			WinSetTitle($hWND, "", $gName&' '&$arrIdle[0]&' '&$arrIdle[2]&' '&$arrIdle[1])
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
	local $pos = WinGetPos($hWND)
	if UBound($pos) <> 0 then	;~ $pos.length != 0
		local $newX = (@DesktopWidth - $pos[2]) / 2
		local $newY = (@DesktopHeight - $pos[3]) / 2

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