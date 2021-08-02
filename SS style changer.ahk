#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

NumpadAdd::
Suspend
return

#IfWinActive ahk_exe RobloxPlayerBeta.exe
z::Numpad1
x::Numpad2
c::Numpad3

 ; just in case you want Z X C
Numpad4::z
Numpad5::x 
Numpad6::c

#IfWinActive
