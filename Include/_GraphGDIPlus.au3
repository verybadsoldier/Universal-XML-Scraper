$__iLineNumber=0
;#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

; #INDEX# ===============================================================================
; Title .........: GraphGDIPlus
; AutoIt Version: 3.3.0.0+
; Language: English
; Description ...: A Graph control to draw line graphs, using GDI+, also double-buffered.
; Notes .........:
; =======================================================================================



; #VARIABLES/INCLUDES# ==================================================================
#include-once
#include <GDIplus.au3>

$__iLineNumber=17 & ' - Global $aGraphGDIPlusaGraphArrayINTERNAL[1]•./Include/_GraphGDIPlus.au3'
Global $aGraphGDIPlusaGraphArrayINTERNAL[1]
; =======================================================================================



; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Create
; Description ...: Creates graph area, and prepares array of specified data
; Syntax.........: _GraphGDIPlus_Create($hWnd,$iLeft,$iTop,$iWidth,$iHeight,$hColorBorder = 0xFF000000,$hColorFill = 0xFFFFFFFF)
; Parameters ....:  $hWnd - Handle to GUI
;                   $iLeft - left most position in GUI
; $iTop - top most position in GUI
; $iWidth - width of graph in pixels
; $iHeight - height of graph in pixels
;                $hColorBorder - Color of graph border (ARGB)
;                $hColorFill - Color of background (ARGB)
; Return values .: Returns array containing variables for subsequent functions...
; Returned Graph array is:
; [1] graphic control handle
; [2] left
; [3] top
; [4] width
; [5] height
; [6] x low
; [7] x high
; [8] y low
; [9] y high
; [10] x ticks handles
; [11] x labels handles
; [12] y ticks handles
; [13] y labels handles
;                    [14] Border Color
;                    [15] Fill Color
;                    [16] Bitmap Handle
;                    [17] Backbuffer Handle
;                    [18] Last used x pos
;                    [19] Last used y pos
;                    [20] Pen (main) Handle
;                    [21] Brush (fill) Handle
;                    [22] Pen (border) Handle
;                    [23] Pen (grid) Handle
; =======================================================================================
$__iLineNumber=59 & ' - Func _GraphGDIPlus_Create($hWnd, $iLeft, $iTop, $iWidth, $iH ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Create($hWnd, $iLeft, $iTop, $iWidth, $iHeight, $hColorBorder = 0xFF000000, $hColorFill = 0xFFFFFFFF, $iSmooth = 2)
    $__iLineNumber=60 & ' - Local $graphics, $bitmap, $backbuffer, $brush, $bpen, $gpen, ...•./Include/_GraphGDIPlus.au3'
    Local $graphics, $bitmap, $backbuffer, $brush, $bpen, $gpen, $pen
    $__iLineNumber=61 & ' - Local $ahTicksLabelsX[1]•./Include/_GraphGDIPlus.au3'
    Local $ahTicksLabelsX[1]
    $__iLineNumber=62 & ' - Local $ahTicksLabelsY[1]•./Include/_GraphGDIPlus.au3'
    Local $ahTicksLabelsY[1]
    $__iLineNumber=63 & ' - Local $ahTicksX[1]•./Include/_GraphGDIPlus.au3'
    Local $ahTicksX[1]
    $__iLineNumber=64 & ' - Local $ahTicksY[1]•./Include/_GraphGDIPlus.au3'
    Local $ahTicksY[1]
    $__iLineNumber=65 & ' - Local $aGraphArray[1]•./Include/_GraphGDIPlus.au3'
    Local $aGraphArray[1]

    ;----- Set GUI transparency to SOLID (prevents GDI+ glitches) -----
    ;WinSetTrans($hWnd, "", 255) - causes problems when more than 2 graphs used
    ;----- GDI+ Initiate -----
    $__iLineNumber=70 & ' - _GDIPlus_Startup()•./Include/_GraphGDIPlus.au3'
    _GDIPlus_Startup()
    $__iLineNumber=71 & ' - $graphics = _GDIPlus_GraphicsCreateFromHWND($hWnd) ;graphics ...•./Include/_GraphGDIPlus.au3'
    $graphics = _GDIPlus_GraphicsCreateFromHWND($hWnd) ;graphics area
    $__iLineNumber=72 & ' - $bitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth + 1, $iH ...•./Include/_GraphGDIPlus.au3'
    $bitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth + 1, $iHeight + 1, $graphics);buffer bitmap
    $__iLineNumber=73 & ' - $backbuffer = _GDIPlus_ImageGetGraphicsContext($bitmap) ;buf ...•./Include/_GraphGDIPlus.au3'
    $backbuffer = _GDIPlus_ImageGetGraphicsContext($bitmap) ;buffer area
    $__iLineNumber=74 & ' - _GDIPlus_GraphicsSetSmoothingMode($backbuffer, $iSmooth)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsSetSmoothingMode($backbuffer, $iSmooth)

    ;----- Set background Color -----
    $__iLineNumber=77 & ' - $brush = _GDIPlus_BrushCreateSolid($hColorFill)•./Include/_GraphGDIPlus.au3'
    $brush = _GDIPlus_BrushCreateSolid($hColorFill)
    $__iLineNumber=78 & ' - _GDIPlus_GraphicsFillRect($backbuffer, 0, 0, $iWidth, $iHeig ...•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsFillRect($backbuffer, 0, 0, $iWidth, $iHeight, $brush)
    ;----- Set border Pen + color -----
    $__iLineNumber=80 & ' - $bpen = _GDIPlus_PenCreate($hColorBorder)•./Include/_GraphGDIPlus.au3'
    $bpen = _GDIPlus_PenCreate($hColorBorder)
    $__iLineNumber=81 & ' - _GDIPlus_PenSetEndCap($bpen, $GDIP_LINECAPROUND)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetEndCap($bpen, $GDIP_LINECAPROUND)
    ;----- Set Grid Pen + color -----
    $__iLineNumber=83 & ' - $gpen = _GDIPlus_PenCreate(0xFFf0f0f0)•./Include/_GraphGDIPlus.au3'
    $gpen = _GDIPlus_PenCreate(0xFFf0f0f0)
    $__iLineNumber=84 & ' - _GDIPlus_PenSetEndCap($gpen, $GDIP_LINECAPROUND)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetEndCap($gpen, $GDIP_LINECAPROUND)
    ;----- set Drawing Pen + Color -----
    $__iLineNumber=86 & ' - $pen = _GDIPlus_PenCreate() ;drawing pen initially black, us ...•./Include/_GraphGDIPlus.au3'
    $pen = _GDIPlus_PenCreate() ;drawing pen initially black, user to set
    $__iLineNumber=87 & ' - _GDIPlus_PenSetEndCap($pen, $GDIP_LINECAPROUND)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetEndCap($pen, $GDIP_LINECAPROUND)
    $__iLineNumber=88 & ' - _GDIPlus_GraphicsDrawRect($backbuffer, 0, 0, $iWidth, $iHeig ...•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDrawRect($backbuffer, 0, 0, $iWidth, $iHeight, $pen)
    ;----- draw -----
    $__iLineNumber=90 & ' - _GDIPlus_GraphicsDrawImageRect($graphics, $bitmap, $iLeft, $ ...•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDrawImageRect($graphics, $bitmap, $iLeft, $iTop, $iWidth + 1, $iHeight + 1)
    ;----- register redraw -----
    $__iLineNumber=92 & ' - GUIRegisterMsg(0x0006, "_GraphGDIPlus_ReDraw") ;0x0006 = win ...•./Include/_GraphGDIPlus.au3'
    GUIRegisterMsg(0x0006, "_GraphGDIPlus_ReDraw") ;0x0006 = win activate
    $__iLineNumber=93 & ' - GUIRegisterMsg(0x0003, "_GraphGDIPlus_ReDraw") ;0x0003 = win ...•./Include/_GraphGDIPlus.au3'
    GUIRegisterMsg(0x0003, "_GraphGDIPlus_ReDraw") ;0x0003 = win move
    ;----- prep + load array -----
    $__iLineNumber=95 & ' - Dim $aGraphArray[24] = ["", $graphics, $iLeft, $iTop, $iWidt ...•./Include/_GraphGDIPlus.au3'
    Dim $aGraphArray[24] = ["", $graphics, $iLeft, $iTop, $iWidth, $iHeight, 0, 1, 0, 1, _
            $ahTicksX, $ahTicksLabelsX, $ahTicksY, $ahTicksLabelsY, $hColorBorder, $hColorFill, _
            $bitmap, $backbuffer, 0, 0, $pen, $brush, $bpen, $gpen]
    ;----- prep re-draw array for all graphs created -----
    $__iLineNumber=99 & ' - ReDim $aGraphGDIPlusaGraphArrayINTERNAL[UBound($aGraphGDIPlu ...•./Include/_GraphGDIPlus.au3'
    ReDim $aGraphGDIPlusaGraphArrayINTERNAL[UBound($aGraphGDIPlusaGraphArrayINTERNAL) + 1]
    $__iLineNumber=100 & ' - $aGraphGDIPlusaGraphArrayINTERNAL[UBound($aGraphGDIPlusaGrap ...•./Include/_GraphGDIPlus.au3'
    $aGraphGDIPlusaGraphArrayINTERNAL[UBound($aGraphGDIPlusaGraphArrayINTERNAL) - 1] = $aGraphArray

    $__iLineNumber=102 & ' - Return $aGraphArray•./Include/_GraphGDIPlus.au3'
    Return $aGraphArray
EndFunc ;==>_GraphGDIPlus_Create
$__iLineNumber=104 & ' - Func _GraphGDIPlus_ReDraw($hWnd)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_ReDraw($hWnd)
    ;----- Allows redraw of the GDI+ Image upon window min/maximize -----
    $__iLineNumber=106 & ' - Local $i•./Include/_GraphGDIPlus.au3'
    Local $i
    $__iLineNumber=107 & ' - _WinAPI_RedrawWindow($hWnd, 0, 0, 0x0100)•./Include/_GraphGDIPlus.au3'
    _WinAPI_RedrawWindow($hWnd, 0, 0, 0x0100)
    $__iLineNumber=108 & ' - For $i = 1 To UBound($aGraphGDIPlusaGraphArrayINTERNAL) - 1•./Include/_GraphGDIPlus.au3'
    For $i = 1 To UBound($aGraphGDIPlusaGraphArrayINTERNAL) - 1
        $__iLineNumber=109 & ' - If $aGraphGDIPlusaGraphArrayINTERNAL[$i] = 0 Then ContinueLo ...•./Include/_GraphGDIPlus.au3'
        If $aGraphGDIPlusaGraphArrayINTERNAL[$i] = 0 Then ContinueLoop
        $__iLineNumber=110 & ' - _GraphGDIPlus_Refresh($aGraphGDIPlusaGraphArrayINTERNAL[$i])•./Include/_GraphGDIPlus.au3'
        _GraphGDIPlus_Refresh($aGraphGDIPlusaGraphArrayINTERNAL[$i])
    Next
EndFunc ;==>_GraphGDIPlus_ReDraw



; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Delete
; Description ...: Deletes previously created graph and related ticks/labels
; Syntax.........: _GraphGDIPlus_Delete($hWnd,ByRef $aGraphArray)
; Parameters ....:  $hWnd - GUI handle
;                   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                   $iKeepGDIPlus - if not zero, function will not _GDIPlus_Shutdown()
; =======================================================================================
$__iLineNumber=124 & ' - Func _GraphGDIPlus_Delete($hWnd, ByRef $aGraphArray, $iKeepG ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Delete($hWnd, ByRef $aGraphArray, $iKeepGDIPlus = 0)
    $__iLineNumber=125 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    $__iLineNumber=126 & ' - Local $ahTicksX, $ahTicksLabelsX, $ahTicksY, $ahTicksLabelsY ...•./Include/_GraphGDIPlus.au3'
    Local $ahTicksX, $ahTicksLabelsX, $ahTicksY, $ahTicksLabelsY, $i, $aTemp
    ;----- delete x ticks/labels -----
    $__iLineNumber=128 & ' - $ahTicksX = $aGraphArray[10]•./Include/_GraphGDIPlus.au3'
    $ahTicksX = $aGraphArray[10]
    $__iLineNumber=129 & ' - $ahTicksLabelsX = $aGraphArray[11]•./Include/_GraphGDIPlus.au3'
    $ahTicksLabelsX = $aGraphArray[11]
    $__iLineNumber=130 & ' - For $i = 1 To (UBound($ahTicksX) - 1)•./Include/_GraphGDIPlus.au3'
    For $i = 1 To (UBound($ahTicksX) - 1)
        $__iLineNumber=131 & ' - GUICtrlDelete($ahTicksX[$i])•./Include/_GraphGDIPlus.au3'
        GUICtrlDelete($ahTicksX[$i])
    Next
    $__iLineNumber=133 & ' - For $i = 1 To (UBound($ahTicksLabelsX) - 1)•./Include/_GraphGDIPlus.au3'
    For $i = 1 To (UBound($ahTicksLabelsX) - 1)
        $__iLineNumber=134 & ' - GUICtrlDelete($ahTicksLabelsX[$i])•./Include/_GraphGDIPlus.au3'
        GUICtrlDelete($ahTicksLabelsX[$i])
    Next
    ;----- delete y ticks/labels -----
    $__iLineNumber=137 & ' - $ahTicksY = $aGraphArray[12]•./Include/_GraphGDIPlus.au3'
    $ahTicksY = $aGraphArray[12]
    $__iLineNumber=138 & ' - $ahTicksLabelsY = $aGraphArray[13]•./Include/_GraphGDIPlus.au3'
    $ahTicksLabelsY = $aGraphArray[13]
    $__iLineNumber=139 & ' - For $i = 1 To (UBound($ahTicksY) - 1)•./Include/_GraphGDIPlus.au3'
    For $i = 1 To (UBound($ahTicksY) - 1)
        $__iLineNumber=140 & ' - GUICtrlDelete($ahTicksY[$i])•./Include/_GraphGDIPlus.au3'
        GUICtrlDelete($ahTicksY[$i])
    Next
    $__iLineNumber=142 & ' - For $i = 1 To (UBound($ahTicksLabelsY) - 1)•./Include/_GraphGDIPlus.au3'
    For $i = 1 To (UBound($ahTicksLabelsY) - 1)
        $__iLineNumber=143 & ' - GUICtrlDelete($ahTicksLabelsY[$i])•./Include/_GraphGDIPlus.au3'
        GUICtrlDelete($ahTicksLabelsY[$i])
    Next
    ;----- delete graphic control -----
    $__iLineNumber=146 & ' - _GDIPlus_GraphicsDispose($aGraphArray[17])•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDispose($aGraphArray[17])
    $__iLineNumber=147 & ' - _GDIPlus_BitmapDispose($aGraphArray[16])•./Include/_GraphGDIPlus.au3'
    _GDIPlus_BitmapDispose($aGraphArray[16])
    $__iLineNumber=148 & ' - _GDIPlus_GraphicsDispose($aGraphArray[1])•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDispose($aGraphArray[1])
    $__iLineNumber=149 & ' - _GDIPlus_BrushDispose($aGraphArray[21])•./Include/_GraphGDIPlus.au3'
    _GDIPlus_BrushDispose($aGraphArray[21])
    $__iLineNumber=150 & ' - _GDIPlus_PenDispose($aGraphArray[20])•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenDispose($aGraphArray[20])
    $__iLineNumber=151 & ' - _GDIPlus_PenDispose($aGraphArray[22])•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenDispose($aGraphArray[22])
    $__iLineNumber=152 & ' - _GDIPlus_PenDispose($aGraphArray[23])•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenDispose($aGraphArray[23])
    $__iLineNumber=153 & ' - If $iKeepGDIPlus = 0 Then _GDIPlus_Shutdown()•./Include/_GraphGDIPlus.au3'
    If $iKeepGDIPlus = 0 Then _GDIPlus_Shutdown()
    $__iLineNumber=154 & ' - _WinAPI_InvalidateRect($hWnd)•./Include/_GraphGDIPlus.au3'
    _WinAPI_InvalidateRect($hWnd)
    ;----- remove form global redraw array -----
    $__iLineNumber=156 & ' - For $i = 1 To UBound($aGraphGDIPlusaGraphArrayINTERNAL) - 1•./Include/_GraphGDIPlus.au3'
    For $i = 1 To UBound($aGraphGDIPlusaGraphArrayINTERNAL) - 1
        $__iLineNumber=157 & ' - $aTemp = $aGraphGDIPlusaGraphArrayINTERNAL[$i]•./Include/_GraphGDIPlus.au3'
        $aTemp = $aGraphGDIPlusaGraphArrayINTERNAL[$i]
        $__iLineNumber=158 & ' - If IsArray($aTemp) = 0 Then ContinueLoop•./Include/_GraphGDIPlus.au3'
        If IsArray($aTemp) = 0 Then ContinueLoop
        $__iLineNumber=159 & ' - If $aTemp[1] = $aGraphArray[1] Then $aGraphGDIPlusaGraphArra ...•./Include/_GraphGDIPlus.au3'
        If $aTemp[1] = $aGraphArray[1] Then $aGraphGDIPlusaGraphArrayINTERNAL[$i] = 0
    Next
    ;----- close array -----
    $__iLineNumber=162 & ' - $aGraphArray = 0•./Include/_GraphGDIPlus.au3'
    $aGraphArray = 0
EndFunc ;==>_GraphGDIPlus_Delete



; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Clear
; Description ...: Clears graph content
; Syntax.........: _GraphGDIPlus_Clear(ByRef $aGraphArray)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; =======================================================================================
$__iLineNumber=173 & ' - Func _GraphGDIPlus_Clear(ByRef $aGraphArray)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Clear(ByRef $aGraphArray)
    $__iLineNumber=174 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- Set background Color -----
    $__iLineNumber=176 & ' - _GDIPlus_GraphicsFillRect($aGraphArray[17], 0, 0, $aGraphArr ...•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsFillRect($aGraphArray[17], 0, 0, $aGraphArray[4], $aGraphArray[5], $aGraphArray[21])
    ;----- set border + Color -----
    $__iLineNumber=178 & ' - _GraphGDIPlus_RedrawRect($aGraphArray)•./Include/_GraphGDIPlus.au3'
    _GraphGDIPlus_RedrawRect($aGraphArray)
EndFunc ;==>_GraphGDIPlus_Clear



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Refresh
; Description ...: refreshes the graphic
; Syntax.........: _GraphGDIPlus_Refresh(ByRef $aGraphArray)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; ========================================================================================
$__iLineNumber=189 & ' - Func _GraphGDIPlus_Refresh(ByRef $aGraphArray)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Refresh(ByRef $aGraphArray)
    $__iLineNumber=190 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- draw -----
    $__iLineNumber=192 & ' - _GDIPlus_GraphicsDrawImageRect($aGraphArray[1], $aGraphArray ...•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDrawImageRect($aGraphArray[1], $aGraphArray[16], $aGraphArray[2], _
            $aGraphArray[3], $aGraphArray[4] + 1, $aGraphArray[5] + 1)
EndFunc ;==>_GraphGDIPlus_Refresh



; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Set_RangeX
; Description ...: Allows user to set the range of the X axis and set ticks and rounding levels
; Syntax.........: _GraphGDIPlus_Set_RangeX(ByRef $aGraphArray,$iLow,$iHigh,$iXTicks = 1,$bLabels = 1,$iRound = 0)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; $iLow - the lowest value for the X axis (can be negative)
; $iHigh - the highest value for the X axis
; $iXTicks - [optional] number of ticks to show below axis, if = 0 then no ticks created
; $bLabels - [optional] 1=show labels, any other number=do not show labels
; $iRound - [optional] rounding level of label values
; =======================================================================================
$__iLineNumber=209 & ' - Func _GraphGDIPlus_Set_RangeX(ByRef $aGraphArray, $iLow, $iH ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Set_RangeX(ByRef $aGraphArray, $iLow, $iHigh, $iXTicks = 1, $bLabels = 0, $iRound = 0)
    $__iLineNumber=210 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    $__iLineNumber=211 & ' - Local $ahTicksX, $ahTicksLabelsX, $i•./Include/_GraphGDIPlus.au3'
    Local $ahTicksX, $ahTicksLabelsX, $i
    ;----- load user vars to array -----
    $__iLineNumber=213 & ' - $aGraphArray[6] = $iLow•./Include/_GraphGDIPlus.au3'
    $aGraphArray[6] = $iLow
    $__iLineNumber=214 & ' - $aGraphArray[7] = $iHigh•./Include/_GraphGDIPlus.au3'
    $aGraphArray[7] = $iHigh
    ;----- prepare nested array -----
    $__iLineNumber=216 & ' - $ahTicksX = $aGraphArray[10]•./Include/_GraphGDIPlus.au3'
    $ahTicksX = $aGraphArray[10]
    $__iLineNumber=217 & ' - $ahTicksLabelsX = $aGraphArray[11]•./Include/_GraphGDIPlus.au3'
    $ahTicksLabelsX = $aGraphArray[11]
    ;----- delete any existing ticks -----
    $__iLineNumber=219 & ' - For $i = 1 To (UBound($ahTicksX) - 1)•./Include/_GraphGDIPlus.au3'
    For $i = 1 To (UBound($ahTicksX) - 1)
        $__iLineNumber=220 & ' - GUICtrlDelete($ahTicksX[$i])•./Include/_GraphGDIPlus.au3'
        GUICtrlDelete($ahTicksX[$i])
    Next
    $__iLineNumber=222 & ' - Dim $ahTicksX[1]•./Include/_GraphGDIPlus.au3'
    Dim $ahTicksX[1]
    ;----- create new ticks -----
;~     For $i = 1 To $iXTicks + 1
;~         ReDim $ahTicksX[$i + 1]
;~         $ahTicksX[$i] = GUICtrlCreateLabel("", (($i - 1) * ($aGraphArray[4] / $iXTicks)) + $aGraphArray[2], _
;~                 $aGraphArray[3] + $aGraphArray[5], 1, 5)
;~         GUICtrlSetBkColor(-1, 0x000000)
;~         GUICtrlSetState(-1, 128)
;~     Next
    ;----- delete any existing labels -----
    $__iLineNumber=232 & ' - For $i = 1 To (UBound($ahTicksLabelsX) - 1)•./Include/_GraphGDIPlus.au3'
    For $i = 1 To (UBound($ahTicksLabelsX) - 1)
        $__iLineNumber=233 & ' - GUICtrlDelete($ahTicksLabelsX[$i])•./Include/_GraphGDIPlus.au3'
        GUICtrlDelete($ahTicksLabelsX[$i])
    Next
    $__iLineNumber=235 & ' - Dim $ahTicksLabelsX[1]•./Include/_GraphGDIPlus.au3'
    Dim $ahTicksLabelsX[1]
    ;----- create new labels -----
;~     For $i = 1 To $iXTicks + 1
;~         ReDim $ahTicksLabelsX[$i + 1]
;~         $ahTicksLabelsX[$i] = GUICtrlCreateLabel("", _
;~                 ($aGraphArray[2] + (($aGraphArray[4] / $iXTicks) * ($i - 1))) - (($aGraphArray[4] / $iXTicks) / 2), _
;~                 $aGraphArray[3] + $aGraphArray[5] + 10, $aGraphArray[4] / $iXTicks, 13, 1)
;~         GUICtrlSetBkColor(-1, -2)
;~     Next
    ;----- if labels are required, then fill -----
    $__iLineNumber=245 & ' - If $bLabels = 1 Then•./Include/_GraphGDIPlus.au3'
    If $bLabels = 1 Then
        $__iLineNumber=246 & ' - For $i = 1 To (UBound($ahTicksLabelsX) - 1)•./Include/_GraphGDIPlus.au3'
        For $i = 1 To (UBound($ahTicksLabelsX) - 1)
            $__iLineNumber=247 & ' - GUICtrlSetData($ahTicksLabelsX[$i], _•./Include/_GraphGDIPlus.au3'
            GUICtrlSetData($ahTicksLabelsX[$i], _
                    StringFormat("%." & $iRound & "f", _GraphGDIPlus_Reference_Pixel("p", (($i - 1) * ($aGraphArray[4] / $iXTicks)), _
                    $aGraphArray[6], $aGraphArray[7], $aGraphArray[4])))
        Next
    EndIf
    ;----- load created arrays back into array -----
    $__iLineNumber=253 & ' - $aGraphArray[10] = $ahTicksX•./Include/_GraphGDIPlus.au3'
    $aGraphArray[10] = $ahTicksX
    $__iLineNumber=254 & ' - $aGraphArray[11] = $ahTicksLabelsX•./Include/_GraphGDIPlus.au3'
    $aGraphArray[11] = $ahTicksLabelsX
EndFunc ;==>_GraphGDIPlus_Set_RangeX



; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Set_RangeY
; Description ...: Allows user to set the range of the Y axis and set ticks and rounding levels
; Syntax.........: _GraphGDIPlus_SetRange_Y(ByRef $aGraphArray,$iLow,$iHigh,$iYTicks = 1,$bLabels = 1,$iRound = 0)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; $iLow - the lowest value for the Y axis (can be negative)
; $iHigh - the highest value for the Y axis
; $iYTicks - [optional] number of ticks to show next to axis, if = 0 then no ticks created
; $bLabels - [optional] 1=show labels, any other number=do not show labels
; $iRound - [optional] rounding level of label values
; =======================================================================================
$__iLineNumber=270 & ' - Func _GraphGDIPlus_Set_RangeY(ByRef $aGraphArray, $iLow, $iH ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Set_RangeY(ByRef $aGraphArray, $iLow, $iHigh, $iYTicks = 1, $bLabels = 0, $iRound = 0)
    $__iLineNumber=271 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    $__iLineNumber=272 & ' - Local $ahTicksY, $ahTicksLabelsY, $i•./Include/_GraphGDIPlus.au3'
    Local $ahTicksY, $ahTicksLabelsY, $i
    ;----- load user vars to array -----
    $__iLineNumber=274 & ' - $aGraphArray[8] = $iLow•./Include/_GraphGDIPlus.au3'
    $aGraphArray[8] = $iLow
    $__iLineNumber=275 & ' - $aGraphArray[9] = $iHigh•./Include/_GraphGDIPlus.au3'
    $aGraphArray[9] = $iHigh
    ;----- prepare nested array -----
    $__iLineNumber=277 & ' - $ahTicksY = $aGraphArray[12]•./Include/_GraphGDIPlus.au3'
    $ahTicksY = $aGraphArray[12]
    $__iLineNumber=278 & ' - $ahTicksLabelsY = $aGraphArray[13]•./Include/_GraphGDIPlus.au3'
    $ahTicksLabelsY = $aGraphArray[13]
    ;----- delete any existing ticks -----
    $__iLineNumber=280 & ' - For $i = 1 To (UBound($ahTicksY) - 1)•./Include/_GraphGDIPlus.au3'
    For $i = 1 To (UBound($ahTicksY) - 1)
        $__iLineNumber=281 & ' - GUICtrlDelete($ahTicksY[$i])•./Include/_GraphGDIPlus.au3'
        GUICtrlDelete($ahTicksY[$i])
    Next
    $__iLineNumber=283 & ' - Dim $ahTicksY[1]•./Include/_GraphGDIPlus.au3'
    Dim $ahTicksY[1]
    ;----- create new ticks -----
;~     For $i = 1 To $iYTicks + 1
;~         ReDim $ahTicksY[$i + 1]
;~         $ahTicksY[$i] = GUICtrlCreateLabel("", $aGraphArray[2] - 5, _
;~                 ($aGraphArray[3] + $aGraphArray[5]) - (($aGraphArray[5] / $iYTicks) * ($i - 1)), 5, 1)
;~         GUICtrlSetBkColor(-1, 0x000000)
;~         GUICtrlSetState(-1, 128)
;~     Next
    ;----- delete any existing labels -----
    $__iLineNumber=293 & ' - For $i = 1 To (UBound($ahTicksLabelsY) - 1)•./Include/_GraphGDIPlus.au3'
    For $i = 1 To (UBound($ahTicksLabelsY) - 1)
        $__iLineNumber=294 & ' - GUICtrlDelete($ahTicksLabelsY[$i])•./Include/_GraphGDIPlus.au3'
        GUICtrlDelete($ahTicksLabelsY[$i])
    Next
    $__iLineNumber=296 & ' - Dim $ahTicksLabelsY[1]•./Include/_GraphGDIPlus.au3'
    Dim $ahTicksLabelsY[1]
    ;----- create new labels -----
;~     For $i = 1 To $iYTicks + 1
;~         ReDim $ahTicksLabelsY[$i + 1]
;~         $ahTicksLabelsY[$i] = GUICtrlCreateLabel("", $aGraphArray[2] - 40, _
;~                 ($aGraphArray[3] + $aGraphArray[5]) - (($aGraphArray[5] / $iYTicks) * ($i - 1)) - 6, 30, 13, 2)
;~         GUICtrlSetBkColor(-1, -2)
;~     Next
    ;----- if labels are required, then fill -----
    $__iLineNumber=305 & ' - If $bLabels = 1 Then•./Include/_GraphGDIPlus.au3'
    If $bLabels = 1 Then
        $__iLineNumber=306 & ' - For $i = 1 To (UBound($ahTicksLabelsY) - 1)•./Include/_GraphGDIPlus.au3'
        For $i = 1 To (UBound($ahTicksLabelsY) - 1)
            $__iLineNumber=307 & ' - GUICtrlSetData($ahTicksLabelsY[$i], StringFormat("%." & $iRo ...•./Include/_GraphGDIPlus.au3'
            GUICtrlSetData($ahTicksLabelsY[$i], StringFormat("%." & $iRound & "f", _GraphGDIPlus_Reference_Pixel("p", _
                    (($i - 1) * ($aGraphArray[5] / $iYTicks)), $aGraphArray[8], $aGraphArray[9], $aGraphArray[5])))
        Next
    EndIf
    ;----- load created arrays back into array -----
    $__iLineNumber=312 & ' - $aGraphArray[12] = $ahTicksY•./Include/_GraphGDIPlus.au3'
    $aGraphArray[12] = $ahTicksY
    $__iLineNumber=313 & ' - $aGraphArray[13] = $ahTicksLabelsY•./Include/_GraphGDIPlus.au3'
    $aGraphArray[13] = $ahTicksLabelsY
EndFunc ;==>_GraphGDIPlus_Set_RangeY



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Plot_Start
; Description ...: Move starting point of plot
; Syntax.........: _GraphGDIPlus_Plot_Start(ByRef $aGraphArray,$iX,$iY)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; $iX - x value to start at
; $iY - y value to start at
; ========================================================================================
$__iLineNumber=326 & ' - Func _GraphGDIPlus_Plot_Start(ByRef $aGraphArray, $iX, $iY)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Plot_Start(ByRef $aGraphArray, $iX, $iY)
    $__iLineNumber=327 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- MOVE pen to start point -----
    $__iLineNumber=329 & ' - $aGraphArray[18] = _GraphGDIPlus_Reference_Pixel("x", $iX, $ ...•./Include/_GraphGDIPlus.au3'
    $aGraphArray[18] = _GraphGDIPlus_Reference_Pixel("x", $iX, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4])
    $__iLineNumber=330 & ' - $aGraphArray[19] = _GraphGDIPlus_Reference_Pixel("y", $iY, $ ...•./Include/_GraphGDIPlus.au3'
    $aGraphArray[19] = _GraphGDIPlus_Reference_Pixel("y", $iY, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5])
EndFunc ;==>_GraphGDIPlus_Plot_Start



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Plot_Line
; Description ...: draws straight line to x,y from previous point / starting point
; Syntax.........: _GraphGDIPlus_Plot_Line(ByRef $aGraphArray,$iX,$iY)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; $iX - x value to draw to
; $iY - y value to draw to
; ========================================================================================
$__iLineNumber=343 & ' - Func _GraphGDIPlus_Plot_Line(ByRef $aGraphArray, $iX, $iY)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Plot_Line(ByRef $aGraphArray, $iX, $iY)
    $__iLineNumber=344 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- Draw line from previous point to new point -----
    $__iLineNumber=346 & ' - $iX = _GraphGDIPlus_Reference_Pixel("x", $iX, $aGraphArray[6 ...•./Include/_GraphGDIPlus.au3'
    $iX = _GraphGDIPlus_Reference_Pixel("x", $iX, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4])
    $__iLineNumber=347 & ' - $iY = _GraphGDIPlus_Reference_Pixel("y", $iY, $aGraphArray[8 ...•./Include/_GraphGDIPlus.au3'
    $iY = _GraphGDIPlus_Reference_Pixel("y", $iY, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5])
;~  _GDIPlus_GraphicsDrawLine($aGraphArray[17], $aGraphArray[18], $aGraphArray[19], $iX, $iY, $aGraphArray[20])
    $__iLineNumber=349 & ' - DllCall($__g_hGDIPDll, "int", "GdipDrawLine", "handle", $aGr ...•./Include/_GraphGDIPlus.au3'
    DllCall($__g_hGDIPDll, "int", "GdipDrawLine", "handle", $aGraphArray[17], "handle", $aGraphArray[20], "float", $aGraphArray[18], "float", $aGraphArray[19], "float", $iX, "float", $iY)
    $__iLineNumber=350 & ' - _GraphGDIPlus_RedrawRect($aGraphArray)•./Include/_GraphGDIPlus.au3'
    _GraphGDIPlus_RedrawRect($aGraphArray)
    ;----- save current as last coords -----
    $__iLineNumber=352 & ' - $aGraphArray[18] = $iX•./Include/_GraphGDIPlus.au3'
    $aGraphArray[18] = $iX
    $__iLineNumber=353 & ' - $aGraphArray[19] = $iY•./Include/_GraphGDIPlus.au3'
    $aGraphArray[19] = $iY
EndFunc ;==>_GraphGDIPlus_Plot_Line



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Plot_Point
; Description ...: draws point at coords
; Syntax.........: _GraphGDIPlus_Plot_Point(ByRef $aGraphArray,$iX,$iY)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; $iX - x value to draw at
; $iY - y value to draw at
; ========================================================================================
$__iLineNumber=366 & ' - Func _GraphGDIPlus_Plot_Point(ByRef $aGraphArray, $iX, $iY)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Plot_Point(ByRef $aGraphArray, $iX, $iY)
    $__iLineNumber=367 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- Draw point from previous point to new point -----
    $__iLineNumber=369 & ' - $iX = _GraphGDIPlus_Reference_Pixel("x", $iX, $aGraphArray[6 ...•./Include/_GraphGDIPlus.au3'
    $iX = _GraphGDIPlus_Reference_Pixel("x", $iX, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4])
    $__iLineNumber=370 & ' - $iY = _GraphGDIPlus_Reference_Pixel("y", $iY, $aGraphArray[8 ...•./Include/_GraphGDIPlus.au3'
    $iY = _GraphGDIPlus_Reference_Pixel("y", $iY, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5])
;~  _GDIPlus_GraphicsDrawRect($aGraphArray[17], $iX-1, $iY-1, 2, 2, $aGraphArray[20])
    $__iLineNumber=372 & ' - DllCall($__g_hGDIPDll, "int", "GdipDrawRectangle", "handle", ...•./Include/_GraphGDIPlus.au3'
    DllCall($__g_hGDIPDll, "int", "GdipDrawRectangle", "handle", $aGraphArray[17], "handle", $aGraphArray[20], "float", $iX-1, "float", $iY-1,"float", 2, "float", 2)
    $__iLineNumber=373 & ' - _GraphGDIPlus_RedrawRect($aGraphArray)•./Include/_GraphGDIPlus.au3'
    _GraphGDIPlus_RedrawRect($aGraphArray)
    ;----- save current as last coords -----
    $__iLineNumber=375 & ' - $aGraphArray[18] = $iX•./Include/_GraphGDIPlus.au3'
    $aGraphArray[18] = $iX
    $__iLineNumber=376 & ' - $aGraphArray[19] = $iY•./Include/_GraphGDIPlus.au3'
    $aGraphArray[19] = $iY
EndFunc ;==>_GraphGDIPlus_Plot_Point



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Plot_Dot
; Description ...: draws single pixel dot at coords
; Syntax.........: _GraphGDIPlus_Plot_Dot(ByRef $aGraphArray,$iX,$iY)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; $iX - x value to draw at
; $iY - y value to draw at
; ========================================================================================
$__iLineNumber=389 & ' - Func _GraphGDIPlus_Plot_Dot(ByRef $aGraphArray, $iX, $iY)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Plot_Dot(ByRef $aGraphArray, $iX, $iY)
    $__iLineNumber=390 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- Draw point from previous point to new point -----
    $__iLineNumber=392 & ' - $iX = _GraphGDIPlus_Reference_Pixel("x", $iX, $aGraphArray[6 ...•./Include/_GraphGDIPlus.au3'
    $iX = _GraphGDIPlus_Reference_Pixel("x", $iX, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4])
    $__iLineNumber=393 & ' - $iY = _GraphGDIPlus_Reference_Pixel("y", $iY, $aGraphArray[8 ...•./Include/_GraphGDIPlus.au3'
    $iY = _GraphGDIPlus_Reference_Pixel("y", $iY, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5])
;~  _GDIPlus_GraphicsDrawRect($aGraphArray[17], $iX, $iY, 1, 1, $aGraphArray[20]) ;draws 2x2 dot ?HOW to get 1x1 pixel?????
    $__iLineNumber=395 & ' - DllCall($__g_hGDIPDll, "int", "GdipDrawRectangle", "handle", ...•./Include/_GraphGDIPlus.au3'
    DllCall($__g_hGDIPDll, "int", "GdipDrawRectangle", "handle", $aGraphArray[17], "handle", $aGraphArray[20], "float", $iX, "float", $iY,"float", 1, "float", 1)
    $__iLineNumber=396 & ' - _GraphGDIPlus_RedrawRect($aGraphArray)•./Include/_GraphGDIPlus.au3'
    _GraphGDIPlus_RedrawRect($aGraphArray)
    ;----- save current as last coords -----
    $__iLineNumber=398 & ' - $aGraphArray[18] = $iX•./Include/_GraphGDIPlus.au3'
    $aGraphArray[18] = $iX
    $__iLineNumber=399 & ' - $aGraphArray[19] = $iY•./Include/_GraphGDIPlus.au3'
    $aGraphArray[19] = $iY
EndFunc ;==>_GraphGDIPlus_Plot_Dot



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_PenColor
; Description ...: sets the Color for the next drawing
; Syntax.........: _GraphGDIPlus_Set_PenColor(ByRef $aGraphArray,$hColor,$hBkGrdColor = $GUI_GR_NOBKColor)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; $hColor - the Color of the next item (ARGB)
; ========================================================================================
$__iLineNumber=411 & ' - Func _GraphGDIPlus_Set_PenColor(ByRef $aGraphArray, $hColor)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Set_PenColor(ByRef $aGraphArray, $hColor)
    $__iLineNumber=412 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- apply pen Color -----
    $__iLineNumber=414 & ' - _GDIPlus_PenSetColor($aGraphArray[20], $hColor)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetColor($aGraphArray[20], $hColor)
EndFunc ;==>_GraphGDIPlus_Set_PenColor



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_PenSize
; Description ...: sets the pen for the next drawing
; Syntax.........: _GraphGDIPlus_Set_PenSize(ByRef $aGraphArray,$iSize = 1)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; $iSize - size of pen line
; ========================================================================================
$__iLineNumber=426 & ' - Func _GraphGDIPlus_Set_PenSize(ByRef $aGraphArray, $iSize =  ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Set_PenSize(ByRef $aGraphArray, $iSize = 1)
    $__iLineNumber=427 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- apply pen size -----
    $__iLineNumber=429 & ' - _GDIPlus_PenSetWidth($aGraphArray[20], $iSize)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetWidth($aGraphArray[20], $iSize)
EndFunc ;==>_GraphGDIPlus_Set_PenSize



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_PenDash
; Description ...: sets the pen dash style for the next drawing
; Syntax.........: GraphGDIPlus_Set_PenDash(ByRef $aGraphArray,$iDash = 0)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; $iDash - style of dash, where:
;                                       0 = solid line
;                                       1 = simple dashed line
;                                       2 = simple dotted line
;                                       3 = dash dot line
;                                       4 = dash dot dot line
; ========================================================================================
$__iLineNumber=446 & ' - Func _GraphGDIPlus_Set_PenDash(ByRef $aGraphArray, $iDash =  ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Set_PenDash(ByRef $aGraphArray, $iDash = 0)
    $__iLineNumber=447 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    $__iLineNumber=448 & ' - Local $Style•./Include/_GraphGDIPlus.au3'
    Local $Style
    $__iLineNumber=449 & ' - Switch $iDash•./Include/_GraphGDIPlus.au3'
    $__iLineNumber=450 & ' - Case 0 ;solid line _____•./Include/_GraphGDIPlus.au3'
    Switch $iDash
        Case 0 ;solid line _____
            $Style = $GDIP_DASHSTYLESOLID
        $__iLineNumber=452 & ' - Case 1 ;simple dash -----•./Include/_GraphGDIPlus.au3'
        Case 1 ;simple dash -----
            $__iLineNumber=453 & ' - $Style = $GDIP_DASHSTYLEDASH•./Include/_GraphGDIPlus.au3'
            $Style = $GDIP_DASHSTYLEDASH
        $__iLineNumber=454 & ' - Case 2 ;simple dotted .....•./Include/_GraphGDIPlus.au3'
        Case 2 ;simple dotted .....
            $__iLineNumber=455 & ' - $Style = $GDIP_DASHSTYLEDOT•./Include/_GraphGDIPlus.au3'
            $Style = $GDIP_DASHSTYLEDOT
        $__iLineNumber=456 & ' - Case 3 ;dash dot -.-.-•./Include/_GraphGDIPlus.au3'
        Case 3 ;dash dot -.-.-
            $__iLineNumber=457 & ' - $Style = $GDIP_DASHSTYLEDASHDOT•./Include/_GraphGDIPlus.au3'
            $Style = $GDIP_DASHSTYLEDASHDOT
        $__iLineNumber=458 & ' - Case 4 ;dash dot dot -..-..-..•./Include/_GraphGDIPlus.au3'
        Case 4 ;dash dot dot -..-..-..
            $__iLineNumber=459 & ' - $Style = $GDIP_DASHSTYLEDASHDOTDOT•./Include/_GraphGDIPlus.au3'
            $Style = $GDIP_DASHSTYLEDASHDOTDOT
    EndSwitch
    ;----- apply pen dash -----
    $__iLineNumber=462 & ' - _GDIPlus_PenSetDashStyle($aGraphArray[20], $Style)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetDashStyle($aGraphArray[20], $Style)
EndFunc ;==>_GraphGDIPlus_Set_PenDash



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_GridX
; Description ...: Adds X gridlines.
; Syntax.........: _GraphGDIPlus_Set_GridX(ByRef $aGraphArray, $Ticks=1, $hColor=0xf0f0f0)
; Parameters ....:  $aGraphArray - the array returned from _GraphGDIPlus_Create
;                   $Ticks - sets line at every nth unit assigned to axis
;               $hColor - [optional] RGB value, defining Color of grid. Default is a light gray
;                   $hColorY0 - [optional] RGB value, defining Color of Y=0 line, Default black
; =======================================================================================
$__iLineNumber=476 & ' - Func _GraphGDIPlus_Set_GridX(ByRef $aGraphArray, $Ticks = 1, ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Set_GridX(ByRef $aGraphArray, $Ticks = 1, $hColor = 0xFFf0f0f0, $hColorY0 = 0xFF000000)
    $__iLineNumber=477 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- Set gpen to user color -----
    $__iLineNumber=479 & ' - _GDIPlus_PenSetColor($aGraphArray[23], $hColor)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetColor($aGraphArray[23], $hColor)
    ;----- draw grid lines -----
    $__iLineNumber=482 & ' - Case $Ticks > 0•./Include/_GraphGDIPlus.au3'
    Select
        Case $Ticks > 0
            $__iLineNumber=483 & ' - For $i = $aGraphArray[6] To $aGraphArray[7] Step $Ticks•./Include/_GraphGDIPlus.au3'
            For $i = $aGraphArray[6] To $aGraphArray[7] Step $Ticks
                $__iLineNumber=484 & ' - If $i = Number($aGraphArray[6]) Or $i = Number($aGraphArray[ ...•./Include/_GraphGDIPlus.au3'
                If $i = Number($aGraphArray[6]) Or $i = Number($aGraphArray[7]) Then ContinueLoop
                $__iLineNumber=485 & ' - _GDIPlus_GraphicsDrawLine($aGraphArray[17], _•./Include/_GraphGDIPlus.au3'
                _GDIPlus_GraphicsDrawLine($aGraphArray[17], _
                        _GraphGDIPlus_Reference_Pixel("x", $i, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4]), _
                        1, _
                        _GraphGDIPlus_Reference_Pixel("x", $i, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4]), _
                        $aGraphArray[5] - 1, _
                        $aGraphArray[23])
            Next
    EndSelect
    ;----- draw y=0 -----
    $__iLineNumber=494 & ' - _GDIPlus_PenSetColor($aGraphArray[23], $hColorY0)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetColor($aGraphArray[23], $hColorY0)
    $__iLineNumber=495 & ' - _GDIPlus_GraphicsDrawLine($aGraphArray[17], _•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDrawLine($aGraphArray[17], _
            _GraphGDIPlus_Reference_Pixel("x", 0, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4]), _
            1, _
            _GraphGDIPlus_Reference_Pixel("x", 0, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4]), _
            $aGraphArray[5] - 1, _
            $aGraphArray[23])
    $__iLineNumber=501 & ' - _GDIPlus_GraphicsDrawLine($aGraphArray[17], _•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDrawLine($aGraphArray[17], _
            1, _
            _GraphGDIPlus_Reference_Pixel("y", 0, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5]), _
            $aGraphArray[4] - 1, _
            _GraphGDIPlus_Reference_Pixel("y", 0, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5]), _
            $aGraphArray[23])

    $__iLineNumber=508 & ' - _GraphGDIPlus_RedrawRect($aGraphArray)•./Include/_GraphGDIPlus.au3'
    _GraphGDIPlus_RedrawRect($aGraphArray)
    ;----- re-set to user specs -----
    $__iLineNumber=510 & ' - _GDIPlus_PenSetColor($aGraphArray[23], $hColor) ;set Color b ...•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetColor($aGraphArray[23], $hColor) ;set Color back to user def
EndFunc ;==>_GraphGDIPlus_Set_GridX



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_GridY
; Description ...: Adds Y gridlines.
; Syntax.........: _GraphGDIPlus_Set_GridY(ByRef $aGraphArray, $Ticks=1, $hColor=0xf0f0f0)
; Parameters ....:  $aGraphArray - the array returned from _GraphGDIPlus_Create
;                   $Ticks - sets line at every nth unit assigned to axis
;               $hColor - [optional] RGB value, defining Color of grid. Default is a light gray
;                   $hColorX0 - [optional] RGB value, defining Color of X=0 line, Default black
; =======================================================================================
$__iLineNumber=524 & ' - Func _GraphGDIPlus_Set_GridY(ByRef $aGraphArray, $Ticks = 1, ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Set_GridY(ByRef $aGraphArray, $Ticks = 1, $hColor = 0xFFf0f0f0, $hColorX0 = 0xFF000000)
    $__iLineNumber=525 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- Set gpen to user color -----
    $__iLineNumber=527 & ' - _GDIPlus_PenSetColor($aGraphArray[23], $hColor)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetColor($aGraphArray[23], $hColor)
    ;----- draw grid lines -----
    $__iLineNumber=530 & ' - Case $Ticks > 0•./Include/_GraphGDIPlus.au3'
    Select
        Case $Ticks > 0
            $__iLineNumber=531 & ' - For $i = $aGraphArray[8] To $aGraphArray[9] Step $Ticks•./Include/_GraphGDIPlus.au3'
            For $i = $aGraphArray[8] To $aGraphArray[9] Step $Ticks
                $__iLineNumber=532 & ' - If $i = Number($aGraphArray[8]) Or $i = Number($aGraphArray[ ...•./Include/_GraphGDIPlus.au3'
                If $i = Number($aGraphArray[8]) Or $i = Number($aGraphArray[9]) Then ContinueLoop
                $__iLineNumber=533 & ' - _GDIPlus_GraphicsDrawLine($aGraphArray[17], _•./Include/_GraphGDIPlus.au3'
                _GDIPlus_GraphicsDrawLine($aGraphArray[17], _
                        1, _
                        _GraphGDIPlus_Reference_Pixel("y", $i, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5]), _
                        $aGraphArray[4] - 1, _
                        _GraphGDIPlus_Reference_Pixel("y", $i, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5]), _
                        $aGraphArray[23])
            Next
    EndSelect
    ;----- draw abcissa/ordinate -----
    $__iLineNumber=542 & ' - _GDIPlus_PenSetColor($aGraphArray[23], $hColorX0)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetColor($aGraphArray[23], $hColorX0)
    $__iLineNumber=543 & ' - _GDIPlus_GraphicsDrawLine($aGraphArray[17], _•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDrawLine($aGraphArray[17], _
            _GraphGDIPlus_Reference_Pixel("x", 0, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4]), _
            1, _
            _GraphGDIPlus_Reference_Pixel("x", 0, $aGraphArray[6], $aGraphArray[7], $aGraphArray[4]), _
            $aGraphArray[5] - 1, _
            $aGraphArray[23])
    $__iLineNumber=549 & ' - _GDIPlus_GraphicsDrawLine($aGraphArray[17], _•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDrawLine($aGraphArray[17], _
            1, _
            _GraphGDIPlus_Reference_Pixel("y", 0, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5]), _
            $aGraphArray[4] - 1, _
            _GraphGDIPlus_Reference_Pixel("y", 0, $aGraphArray[8], $aGraphArray[9], $aGraphArray[5]), _
            $aGraphArray[23])

    $__iLineNumber=556 & ' - _GraphGDIPlus_RedrawRect($aGraphArray)•./Include/_GraphGDIPlus.au3'
    _GraphGDIPlus_RedrawRect($aGraphArray)
    ;----- re-set to user specs -----
    $__iLineNumber=558 & ' - _GDIPlus_PenSetColor($aGraphArray[23], $hColor) ;set Color b ...•./Include/_GraphGDIPlus.au3'
    _GDIPlus_PenSetColor($aGraphArray[23], $hColor) ;set Color back to user def
EndFunc ;==>_GraphGDIPlus_Set_GridY



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_RedrawRect
; Description ...: INTERNAL FUNCTION - Re-draws the border
; Syntax.........: _GraphGDIPlus_RedrawRect(ByRef $aGraphArray)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; Notes..........: This prevents drawing over the border of the graph area
; =========================================================================================
$__iLineNumber=570 & ' - Func _GraphGDIPlus_RedrawRect(ByRef $aGraphArray)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_RedrawRect(ByRef $aGraphArray)
    $__iLineNumber=571 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    ;----- draw border -----
    $__iLineNumber=573 & ' - _GDIPlus_GraphicsDrawRect($aGraphArray[17], 0, 0, $aGraphArr ...•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDrawRect($aGraphArray[17], 0, 0, $aGraphArray[4], $aGraphArray[5], $aGraphArray[22]) ;draw border
EndFunc ;==>_GraphGDIPlus_RedrawRect


; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Reference_Pixel
; Description ...: INTERNAL FUNCTION - performs pixel reference calculations
; Syntax.........: _GraphGDIPlus_Reference_Pixel($iType,$iValue,$iLow,$iHigh,$iTotalPixels)
; Parameters ....: $iType - "x"=x axis pix, "y" = y axis pix, "p"=value from pixels
; $iValue - pixels reference or value
; $iLow - lower limit of axis
; $iHigh - upper limit of axis
; $iTotalPixels - total number of pixels in range (either width or height)
; =========================================================================================
$__iLineNumber=587 & ' - Func _GraphGDIPlus_Reference_Pixel($iType, $iValue, $iLow, $ ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_Reference_Pixel($iType, $iValue, $iLow, $iHigh, $iTotalPixels)
    ;----- perform pixel reference calculations -----
    $__iLineNumber=589 & ' - Switch $iType•./Include/_GraphGDIPlus.au3'
    $__iLineNumber=590 & ' - Case "x"•./Include/_GraphGDIPlus.au3'
    Switch $iType
        Case "x"
            $__iLineNumber=591 & ' - Return (($iTotalPixels / ($iHigh - $iLow)) * (($iHigh - $iLo ...•./Include/_GraphGDIPlus.au3'
            Return (($iTotalPixels / ($iHigh - $iLow)) * (($iHigh - $iLow) * (($iValue - $iLow) / ($iHigh - $iLow))))
        $__iLineNumber=592 & ' - Case "y"•./Include/_GraphGDIPlus.au3'
        Case "y"
            $__iLineNumber=593 & ' - Return ($iTotalPixels - (($iTotalPixels / ($iHigh - $iLow))  ...•./Include/_GraphGDIPlus.au3'
            Return ($iTotalPixels - (($iTotalPixels / ($iHigh - $iLow)) * (($iHigh - $iLow) * (($iValue - $iLow) / ($iHigh - $iLow)))))
        $__iLineNumber=594 & ' - Case "p"•./Include/_GraphGDIPlus.au3'
        Case "p"
            $__iLineNumber=595 & ' - Return ($iValue / ($iTotalPixels / ($iHigh - $iLow))) + $iLo ...•./Include/_GraphGDIPlus.au3'
            Return ($iValue / ($iTotalPixels / ($iHigh - $iLow))) + $iLow
    EndSwitch
EndFunc ;==>_GraphGDIPlus_Reference_Pixel

; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_SaveImage
; Description ...: INTERNAL FUNCTION - save drawn image to file
; Syntax.........: _GraphGDIPlus_SaveImage($aGraphArray, $file)
; Parameters ....: ByRef $aGraphArray - the array returned from _GraphGDIPlus_Create
;                               $file - filename
; Autor .........: UEZ
; =========================================================================================
$__iLineNumber=607 & ' - Func _GraphGDIPlus_SaveImage(ByRef $aGraphArray, $file)•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_SaveImage(ByRef $aGraphArray, $file)
    $__iLineNumber=608 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    $__iLineNumber=609 & ' - _GDIPlus_ImageSaveToFile($aGraphArray[16], $file)•./Include/_GraphGDIPlus.au3'
    _GDIPlus_ImageSaveToFile($aGraphArray[16], $file)
    $__iLineNumber=610 & ' - If @error Then Return SetError(1, 0, 0)•./Include/_GraphGDIPlus.au3'
    If @error Then Return SetError(1, 0, 0)
    $__iLineNumber=611 & ' - Return 1•./Include/_GraphGDIPlus.au3'
    Return 1
EndFunc ;==>_GraphGDIPlus_SaveImage

$__iLineNumber=614 & ' - Func _GraphGDIPlus_DrawText(ByRef $aGraphArray, $sString, $i ...•./Include/_GraphGDIPlus.au3'
Func _GraphGDIPlus_DrawText(ByRef $aGraphArray, $sString, $iX, $iY, $iBrushColor = 0xFF000000, $sFont = "Arial", $iFontSize = 12, $iStyle = 0)
    $__iLineNumber=615 & ' - If IsArray($aGraphArray) = 0 Then Return•./Include/_GraphGDIPlus.au3'
    If IsArray($aGraphArray) = 0 Then Return
    $__iLineNumber=616 & ' - Local $hBrush = _GDIPlus_BrushCreateSolid($iBrushColor)•./Include/_GraphGDIPlus.au3'
    Local $hBrush = _GDIPlus_BrushCreateSolid($iBrushColor)
    $__iLineNumber=617 & ' - Local $hFormat = _GDIPlus_StringFormatCreate()•./Include/_GraphGDIPlus.au3'
    Local $hFormat = _GDIPlus_StringFormatCreate()
$__iLineNumber=618 & ' - Local $hFamily = _GDIPlus_FontFamilyCreate($sFont)•./Include/_GraphGDIPlus.au3'
Local $hFamily = _GDIPlus_FontFamilyCreate($sFont)
$__iLineNumber=619 & ' - Local $hFont = _GDIPlus_FontCreate($hFamily, $iFontSize, $iS ...•./Include/_GraphGDIPlus.au3'
Local $hFont = _GDIPlus_FontCreate($hFamily, $iFontSize, $iStyle)
    $__iLineNumber=620 & ' - Local $tLayout = _GDIPlus_RectFCreate($iX, $iY, 0, 0)•./Include/_GraphGDIPlus.au3'
    Local $tLayout = _GDIPlus_RectFCreate($iX, $iY, 0, 0)
    $__iLineNumber=621 & ' - _GDIPlus_GraphicsDrawStringEx($aGraphArray[17], $sString, $h ...•./Include/_GraphGDIPlus.au3'
    _GDIPlus_GraphicsDrawStringEx($aGraphArray[17], $sString, $hFont, $tLayout, $hFormat, $hBrush)
$__iLineNumber=622 & ' - _GDIPlus_FontDispose($hFont)•./Include/_GraphGDIPlus.au3'
_GDIPlus_FontDispose($hFont)
$__iLineNumber=623 & ' - _GDIPlus_FontFamilyDispose($hFamily)•./Include/_GraphGDIPlus.au3'
_GDIPlus_FontFamilyDispose($hFamily)
$__iLineNumber=624 & ' - _GDIPlus_StringFormatDispose($hFormat)•./Include/_GraphGDIPlus.au3'
_GDIPlus_StringFormatDispose($hFormat)
$__iLineNumber=625 & ' - _GDIPlus_BrushDispose($hBrush)•./Include/_GraphGDIPlus.au3'
_GDIPlus_BrushDispose($hBrush)
    $__iLineNumber=626 & ' - Return 1•./Include/_GraphGDIPlus.au3'
    Return 1
EndFunc ;==>_GraphGDIPlus_DrawText
