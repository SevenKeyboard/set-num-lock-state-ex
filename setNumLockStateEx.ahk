#Requires AutoHotkey v2.0.0+
;==============================================================
; setNumLockStateEx — Sets NumLock state with optional current-state checks and Always modes
;
; GitHub: https://github.com/SevenKeyboard/set-num-lock-state-ex
; Author: SevenKeyboard Ltd. (2026)
; License: The Unlicense
;
; Documentation / References:
;   Re: [V2] Overwrite ahk functions???
;     https://www.autohotkey.com/boards/viewtopic.php?t=123630#p549610
;==============================================================
class VersionManager_setNumLockStateEx
{
    static _ := this._init()
    static _init()    {
        global
        SETNUMLOCKSTATEEX_VERSION := "1.1.0"
    }
}
setNumLockStateEx(onOff := "", checkCurrentState := false)    {
    isNumLockAlways := SetNumLockStateHook_C22B4166.IsNumLockAlways
    switch (onOff), false
    {
        case "":
            setNumLockState()
        case "On", true:
            if (checkCurrentState && !isNumLockAlways && getKeyState("NumLock", "T"))
                return false
            setNumLockState(true)
        case "Off", false:
            if (checkCurrentState && !isNumLockAlways && !getKeyState("NumLock", "T"))
                return false
            setNumLockState(false)
        case "Toggle", -1:
            setNumLockState(!getKeyState("NumLock", "T"))
        ;---------------------------------
        case "Always", "A":
            setNumLockState("Always" (getKeyState("NumLock", "T") ? "On" : "Off"))
        case "AlwaysOn", "1A":
            if (checkCurrentState && isNumLockAlways && getKeyState("NumLock", "T"))
                return false
            setNumLockState("AlwaysOn")
        case "AlwaysOff", "0A":
            if (checkCurrentState && isNumLockAlways && !getKeyState("NumLock", "T"))
                return false
            setNumLockState("AlwaysOff")
        case "AlwaysToggle", "-1A":
            setNumLockState("Always" (getKeyState("NumLock", "T") ? "Off" : "On"))
        ;---------------------------------
        case "IsAlways":
            return isNumLockAlways
    }
    return true
}
class SetNumLockStateHook_C22B4166
{
    static _ := this._init()
    static _init()    {
        this._isNumLockAlways := false
        setNumLockState.defineProp("call", {call:this._setNumLockState})
    }
    static _setNumLockState(state?)    {
        if !(this is func)
            return
        fn := this ;  setNumLockState
        this := SetNumLockStateHook_C22B4166
        if (!isSet(state))    {
            this._isNumLockAlways := false
        }  else  {
            if (state == true || state == false || state ~= "iD)^(|On|Off)$")
                this._isNumLockAlways := false
            else if (state ~= "iD)^Always(On|Off)$")
                this._isNumLockAlways := true
        }
        return (func.Prototype.call)(fn, state?)
    }
    static IsNumLockAlways    {
        get => this._isNumLockAlways
    }
}