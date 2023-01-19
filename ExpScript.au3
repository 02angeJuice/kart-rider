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
	local $lobby = _ImageSearch('img/lobby.png', 0, $x, $y, 0)
	local $lobbyExit = _ImageSearch('img/lobby-exit.png', 0, $x, $y, 0)
	local $itemGuide = _ImageSearch('img/item-guide.png', 0, $x, $y, 0)
	local $itemChange = _ImageSearch('img/item-change.png', 0, $x, $y, 0)

	local $itemAtk = _ImageSearch('img/item-atk.png', 0, $x, $y, 0)
	local $itemMagnet = _ImageSearch('img/item-magnet.png', 0, $x, $y, 0)

	local $slotAtk = _ImageSearch('img/slot-atk.png', 0, $x, $y, 0)
	local $slotNitro = _ImageSearch('img/slot-nitro.png', 0, $x, $y, 0)
	local $runLeft = _ImageSearch('img/run-left.png', 0, $x, $y, 0)
	local $runRight = _ImageSearch('img/run-right.png', 0, $x, $y, 0)

	;~ basic options
	keyControl($lobby, 'lobby', 'R')
	keyControl($lobbyExit, 'lobby-exit', 'ESC')
	keyControl($itemGuide, 'item-use', 'Q')
	keyControl($itemChange, 'item-change', 'W')
	keyControl($itemAtk, 'item-atk', 'Q')
	keyControl($itemMagnet, 'item-magnet', 'Q')
	keyControl($slotAtk, 'slot-atk', 'W')
	keyControl($slotNitro, 'slot-nitro', 'W')
	keyControl($runLeft, 'run-left', 'LEFT')
	keyControl($runRight, 'run-right', 'RIGHT')
endfunc

func keyControl($isTask, $task, $key)
	switch $task
		case 'lobby'
			keyPress($isTask, $task, $key)
		case 'lobby-exit'
			keyPress($isTask, $task, $key)
		case 'item-use'
			keyPress($isTask, $task, $key)
		case 'item-change'
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

func onExit()
	MsgBox(0, "Exit", "App is shutting down.", 0)
	exit
endfunc



