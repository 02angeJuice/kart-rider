#Include <WinAPI.au3>

GuiCreate("",500,500)
GuiSetState()

_WinAPI_ShowCursor(False)

Sleep(5000)
_WinAPI_ShowCursor(True)
Sleep(5000)