#requireAdmin
#pragma compile(Icon, icon/dao.ico)
#include <WinAPI.au3>

GuiCreate("",500,500)
GuiSetState()

HotKeySet("{ESC}", "onExit")


AdlibRegister("MyAdLibFunc", 5000)

While Sleep(100)
WEnd


func MyAdLibFunc()
			Local $hWND = WinGetHandle("KartDrift")
			ControlSend($hWND, "", "", "{R}")
			ControlSend($hWND, "", "", "{Q}")

			if WinActivate("KartDrift", "") then
				_WinAPI_ShowCursor(True)
			endif
endfunc


func onExit()
	MsgBox(0, "Exit", "App is shutting down.", 0)
	exit
endfunc



