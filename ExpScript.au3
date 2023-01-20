#requireAdmin
#pragma compile(Icon, icon/dao.ico)
#include <WinAPI.au3>
#include <ImageSearch.au3>

Opt("MouseCoordMode", 2)
HotKeySet("{ESC}", "onExit")

global $win = WinGetHandle("KartDrift")
global $x = 0, $y = 0

AdlibRegister("checkImage", 225)

while Sleep(100)
wend

func checkImage()
	local $modeItem = imgSearch('mode-item')
	local $modeSpeed = imgSearch('mode-speed')
	local $lobby = imgSearch('lobby')
	local $lobbyExit = imgSearch('lobby-exit')
	local $itemGuide = imgSearch('item-guide')
	local $itemChange = imgSearch('item-change')
	local $reset = imgSearch('reset')

	local $itemAtk = imgSearch('item-atk')
	local $itemMagnet = imgSearch('item-magnet')
	local $slotAtk = imgSearch('slot-atk')
	local $slotNitro = imgSearch('slot-nitro')
	local $runLeft = imgSearch('run-left')
	local $runRight = imgSearch('run-right')

	;~ basic options
	$isLobby = keyControl($lobby[0], $lobby[1], 'R')
	;~ if $isLobby == 1 then
	;~ 	$isItemMode = keyControl($modeItem[0], $modeItem[1])
	;~ 	$isSpeedMode = keyControl($modeSpeed[0], $modeItem[1])
	;~ endif

	keyControl($lobbyExit[0], $lobbyExit[1], 'ESC')
	keyControl($itemGuide[0], $itemGuide[1], 'Q')
	keyControl($itemChange[0], $itemChange[1], 'W')
	keyControl($reset[0], $reset[1], 'ESC')
	keyControl($itemAtk[0], $itemAtk[1], 'Q')
	keyControl($itemMagnet[0], $itemMagnet[1], 'Q')
	keyControl($slotAtk[0], $slotAtk[1], 'W')
	keyControl($slotNitro[0], $slotNitro[1], 'W')
	keyControl($runLeft[0], $runLeft[1], 'LEFT')
	keyControl($runRight[0], $runRight[1], 'RIGHT')
endfunc

func keyControl($isTask, $task, $key='')
	switch $task
		case 'lobby'
			keyPress($isTask, $task, $key)
		case 'lobby-exit'
			keyPress($isTask, $task, $key)
		case 'item-guide'
			keyPress($isTask, $task, $key)
		case 'item-change'
			keyPress($isTask, $task, $key)
		case 'reset'
			keyPress($isTask, $task, $key)
		case 'item-atk'
			keyPress($isTask, $task, $key)
		case 'item-magnet'
			keyPress($isTask, $task, $key)
		case 'slot-atk'
			keyPress($isTask, $task, $key)
		case 'slot-nitro'
			keyPress($isTask, $task, $key)
		case 'run-left'
			keyPress($isTask, $task)
		case 'run-right'
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



