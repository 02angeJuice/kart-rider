#requireAdmin
#pragma compile(Icon, bazzi.ico)
#include <WinAPI.au3>

HotKeySet("{ESC}", "onExit")

AdlibRegister("MyAdLibFunc", 4000)

While Sleep(100)
WEnd

func MyAdLibFunc()
			Local $hWND = WinGetHandle("KartDrift")
			ControlSend($hWND, "", "", "{R}")
			ControlSend($hWND, "", "", "{Q}")
endfunc

func onExit()
	MsgBox(0, "Exit", "App is shutting down.", 0)
	exit
endfunc