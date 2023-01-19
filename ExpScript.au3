#requireAdmin
#pragma compile(Icon, icon/dao.ico)
#include <WinAPI.au3>
#include <ImageSearch.au3>

Opt("MouseCoordMode", 2)
HotKeySet("{ESC}", "onExit")

global $win = WinGetHandle("KartDrift")
global $x = 0, $y = 0

AdlibRegister("checkImage", 250)

while Sleep(100)
wend

func checkImage()

	local $lobby = _ImageSearch('img/lobby.png', 0, $x, $y, 0)
	local $lobbyExit = _ImageSearch('img/lobby-exit.png', 0, $x, $y, 0)
	local $itemUse = _ImageSearch('img/item-use.png', 0, $x, $y, 0)
	local $itemChange = _ImageSearch('img/item-change.png', 0, $x, $y, 0)

	local $itemAtk = _ImageSearch('img/item-atk.png', 0, $x, $y, 0)
	local $runLeft = _ImageSearch('img/run-left.png', 0, $x, $y, 0)
	local $runRight = _ImageSearch('img/run-right.png', 0, $x, $y, 0)

	;~ basic options
	if $lobby == 1 then
		ControlSend($win, "", "", "{R}")
		ConsoleWrite('lobby found'& @CRLF)
	endif

	if $lobbyExit == 1 then
		ControlSend($win, "", "", "{R}")
		ConsoleWrite('lobbyExit found'& @CRLF)
	endif

	if $itemUse == 1 then
		ControlSend($win, "", "", "{Q}")
		ConsoleWrite('itemUse found'& @CRLF)
	endif

	if $itemChange == 1 then
		ControlSend($win, "", "", "{Q}")
		ConsoleWrite('itemChange found'& @CRLF)
	endif

	;~ advance options
	if $itemAtk == 1 then
		ControlSend($win, "", "", "{Q}")
		ConsoleWrite('itemAtk found'& @CRLF)
	endif

	if $runLeft == 1 Or $runRight == 1 then
		for $i = 0 to 2 step +1
			ControlSend($win, "", "", "{LEFT}")
			ControlSend($win, "", "", "{RIGHT}")
		next
		ConsoleWrite('run found'& @CRLF)
	endif

endfunc

func onExit()
	MsgBox(0, "Exit", "App is shutting down.", 0)
	exit
endfunc



