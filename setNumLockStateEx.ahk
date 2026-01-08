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
        SETNUMLOCKSTATEEX_VERSION := "1.1.0"
    }
}
setNumLockStateEx(onOff := "", checkCurrentState := false)    {
    static isNumLockAlways := false
    bRet := false
    prevSCS := A_StringCaseSense
    stringCaseSense Off
    switch (onOff)
    {
        case "":
            isNumLockAlways := false
            setNumLockState
        case "On", true:
            if (checkCurrentState && !isNumLockAlways && getKeyState("NumLock", "T"))
                goto Cleanup_A7C1484E
            isNumLockAlways := false
            setNumLockState On
        case "Off", false:
            if (checkCurrentState && !isNumLockAlways && !getKeyState("NumLock", "T"))
                goto Cleanup_A7C1484E
            isNumLockAlways := false
            setNumLockState Off
        case "Toggle", -1:
            isNumLockAlways := false
            setNumLockState % (!getKeyState("NumLock", "T"))
        ;---------------------------------
        case "Always", "A":
            isNumLockAlways := true
            setNumLockState % "Always" (getKeyState("NumLock", "T") ? "On" : "Off")
        case "AlwaysOn", "1A":
            if (checkCurrentState && isNumLockAlways && getKeyState("NumLock", "T"))
                goto Cleanup_A7C1484E
            isNumLockAlways := true
            setNumLockState AlwaysOn
        case "AlwaysOff", "0A":
            if (checkCurrentState && isNumLockAlways && !getKeyState("NumLock", "T"))
                goto Cleanup_A7C1484E
            isNumLockAlways := true
            setNumLockState AlwaysOff
        case "AlwaysToggle", "-1A":
            isNumLockAlways := true
            setNumLockState % "Always" (getKeyState("NumLock", "T") ? "Off" : "On")
        ;---------------------------------
        case "IsAlways":
            bRet := isNumLockAlways
            goto Cleanup_A7C1484E
    }
    bRet := true
Cleanup_A7C1484E:
    stringCaseSense % prevSCS
    return bRet
}