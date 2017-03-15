#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <ComboConstants.au3>
#include <GuiConstants.au3>
#include <WindowsConstants.au3>
#include <IE.au3>
#include <Timers.au3>
#Include <Misc.au3>
#include <Constants.au3>
#include <INet.au3>
#Include <GuiButton.au3>
#Include <Clipboard.au3>
#Include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <file.au3>
#Include <Array.au3>
#include "StringSize.au3"
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>

$maingui = GUICreate("Text over progress bar", 200, 40)

$progress = GUICtrlCreateProgress(5, 5, 190, 30, $PBS_SMOOTH)
$text = GUICtrlCreateLabel("", 5, 12, 190, 30, $SS_CENTER) ;text shows on white background
GUICtrlSetColor(-1, 0x008000) ; choose some color which will be visible on progress background and also foreground
GUICtrlSetBkColor(-1, -2)
GUISetState()
$p = 0
$d = 1
$value = 0
$value_prev = 0
_Timer_SetTimer($maingui,1000,"addup")
While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
    #cs;If $p > 500 Then $d = -1
    If $p < 1 Then $d = 1
    $p += $d
    $value = StringFormat('%.1f', Round($p/5, 1))
    If $value <> $value_prev Then
        GUICtrlSetData($progress, $value)
        GUICtrlSetData($text, $value)
        $value_prev = $value
    #ce;EndIf
    Sleep(50)
WEnd
_Timer_KillAllTimers($maingui)
func addup($a, $b, $c, $d)
    $value += 1
    If $value <> $value_prev Then
        GUICtrlSetData($progress, $value)
        GUICtrlSetData($text, $value)
        $value_prev = $value
    EndIf
endfunc