#Requires AutoHotkey v1.1.31+
;==============================================================
; setNumLockStateEx — Sets NumLock state with optional current-state checks and Always modes
;
; GitHub: https://github.com/SevenKeyboard/set-num-lock-state-ex
; Author: SevenKeyboard Ltd. (2026)
; License: The Unlicense
;==============================================================
class VersionManager_setNumLockStateEx
{
    static _ := VersionManager_setNumLockStateEx._init()
    _init()    {
        global
        SETNUMLOCKSTATEEX_VERSION := "1.0.0"
    }
}
setNumLockStateEx(onoff:="", checkCurrentState:=true)    {
    bRet:=false
    prevSCS:=A_StringCaseSense
    stringCaseSense Off
    switch (onoff)
    {
        case "":
            setNumLockState
        case "On",true:
            if (checkCurrentState && getKeyState("NumLock","T"))
                goto Cleanup_A7C1484E
            setNumLockState On
        case "Off",false:
            if (checkCurrentState && !getKeyState("NumLock","T"))
                goto Cleanup_A7C1484E
            setNumLockState Off
        case "Toggle",-1:
            setNumLockState % (!getKeyState("NumLock","T"))
        ;---------------------------------
        case "Always","A":
            setNumLockState % "Always" (getKeyState("NumLock","T")?"On":"Off")
        case "AlwaysOn","1A":
            if (checkCurrentState && getKeyState("NumLock","T"))
                goto Cleanup_A7C1484E
            setNumLockState AlwaysOn
        case "AlwaysOff","0A":
            if (checkCurrentState && !getKeyState("NumLock","T"))
                goto Cleanup_A7C1484E
            setNumLockState AlwaysOff
        case "AlwaysToggle","-1A":
            setNumLockState % "Always" (getKeyState("NumLock","T")?"Off":"On")
    }
    bRet:=true
Cleanup_A7C1484E:
    stringCaseSense % prevSCS
    return bRet
}