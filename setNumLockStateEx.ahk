#Requires AutoHotkey v2.0.0+
;==============================================================
; setNumLockStateEx — Sets NumLock state with optional current-state checks and Always modes
;
; GitHub: https://github.com/SevenKeyboard/set-num-lock-state-ex
; Author: SevenKeyboard Ltd. (2026)
; License: The Unlicense
;==============================================================
class VersionManager_setNumLockStateEx
{
    static _ := this._init()
    static _init()    {
        global
        SETNUMLOCKSTATEEX_VERSION := "1.0.0"
    }
}
setNumLockStateEx(onoff:="", checkCurrentState:=true)    {
    switch (onoff), false
    {
        case "":
            setNumLockState
        case "On",true:
            if (checkCurrentState && getKeyState("NumLock","T"))
                return false
            setNumLockState(true)
        case "Off",false:
            if (checkCurrentState && !getKeyState("NumLock","T"))
                return false
            setNumLockState(false)
        case "Toggle",-1:
            setNumLockState(!getKeyState("NumLock","T"))
        ;---------------------------------
        case "Always","A":
            setNumLockState("Always" (getKeyState("NumLock","T")?"On":"Off"))
        case "AlwaysOn","1A":
            if (checkCurrentState && getKeyState("NumLock","T"))
                return false
            setNumLockState("AlwaysOn")
        case "AlwaysOff","0A":
            if (checkCurrentState && !getKeyState("NumLock","T"))
                return false
            setNumLockState("AlwaysOff")
        case "AlwaysToggle","-1A":
            setNumLockState("Always" (getKeyState("NumLock","T")?"Off":"On"))
    }
    return true
}