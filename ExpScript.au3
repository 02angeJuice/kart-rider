#requireAdmin
#pragma compile(Icon, icon/dao.ico)
#include <WinAPI.au3>
#include <ImageSearch.au3>

Opt("MouseCoordMode", 2)
HotKeySet("{ESC}", "onExit")

global $win = WinGetHandle("KartDrift")
global $x = 0, $y = 0

AdlibRegister("checkImage", 350)

while Sleep(100)
wend

func checkImage()
	local $modeItem = imgSearch('mode-item'), $modeSpeed = imgSearch('mode-speed')
	local $lobby = imgSearch('lobby'), $lobbyExit = imgSearch('lobby-exit'), $lobbyStay = imgSearch('lobby-stay')
	local $guideA = imgSearch('guide-a'), $guideB = imgSearch('guide-b') ,$change = imgSearch('change')
	local $itemAtk = imgSearch('item-atk'), $itemMagnet = imgSearch('item-magnet')
	local $slotAtk = imgSearch('slot-atk'), $slotNitro = imgSearch('slot-nitro')
	local $runLeft = imgSearch('run-left'), $runRight = imgSearch('run-right'), $dayStart = imgSearch('day')

	;~ basic options
	$isLobby = keyControl($lobby[0], $lobby[1], 'R')
	;~ if $isLobby == 1 then
	;~ 	$isItemMode = keyControl($modeItem[0], $modeItem[1])
	;~ 	$isSpeedMode = keyControl($modeSpeed[0], $modeItem[1])
	;~ endif

	keyControl($lobbyExit[0], $lobbyExit[1], 'ESC')
	keyControl($lobbyStay[0], $lobbyStay[1], 'ESC')
	keyControl($guideA[0], $guideA[1], 'Q')
	keyControl($guideB[0], $guideB[1], 'Q')
	keyControl($change[0], $change[1], 'W')
	keyControl($dayStart[0], $dayStart[1], 'ESC')
	keyControl($itemAtk[0], $itemAtk[1], 'Q')
	keyControl($itemMagnet[0], $itemMagnet[1], 'Q')
	keyControl($slotAtk[0], $slotAtk[1], 'W')
	keyControl($slotNitro[0], $slotNitro[1], 'W')
	keyControl($runLeft[0], $runLeft[1], 'LEFT')
	keyControl($runRight[0], $runRight[1], 'RIGHT')
endfunc

func keyControl($isTask, $task, $key='')
	switch $task
		case 'lobby', 'lobby-exit', 'lobby-exit'
			keyPress($isTask, $task, $key)
		case 'guide-a', 'guide-b' ,'change'
			keyPress($isTask, $task, $key)
		case 'day'
			keyPress($isTask, $task, $key)
		case 'item-atk', 'item-magnet'
			keyPress($isTask, $task, $key)
		case 'slot-atk', 'slot-nitro'
			keyPress($isTask, $task, $key)
		case 'run-left', 'run-right'
			keyPress($isTask, $task)
	endswitch
	return 1
endfunc

func keyPress($isTask, $task, $key='')
	if $isTask == 1 then
		if $task == 'run-left' or $task == 'run-right' then
			for $i = 0 to 2 step +1
				ControlSend($win, "", "", '{LEFT}')
				ControlSend($win, "", "", '{RIGHT}')
			next
			ConsoleWrite($task & ' : LEFT/RIGHT' & @CRLF)
		else
			ControlSend($win, "", "", '{' & $key & '}')
			ConsoleWrite($task & ' : ' & $key & @CRLF)
		endif
	endif
endfunc

func imgSearch($img)
	local $arr[2]
	$arr[0] = _ImageSearch('img/'&$img&'.png', 0, $x, $y, 0)
	$arr[1] = $img
	return $arr
endfunc

func onExit()
	MsgBox(0, "Exit", "App is shutting down.", 0)
	exit
endfunc



