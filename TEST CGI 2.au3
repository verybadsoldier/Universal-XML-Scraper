;idea from here -> http://danbystrom.se/2009/01/12/thumbnails-with-glass-table-reflection-in-gdi/
;coded by UEZ 2013-10-04

#include <GDIPlus.au3>

Opt("GUIOnEventMode", 1)

_GDIPlus_Startup()
Global Const $sFile = FileOpenDialog("Select an image", "", "Images (*.bmp,*.gif;*.jpg;*.png)")
If @error Then Exit


Global Const $hGUI = GUICreate("GDI+ Thumbnails with glass table reflection", 600, 400)
GUISetBkColor(0xF0F0F0)
GUISetState()

Global Const $hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
Global Const $hImage = _GDIPlus_ImageLoadFromFile($sFile)

$t = TimerInit()
Global Const $hBmp = _GDIPlus_BitmapCreateThumbnailWithReflection($hImage)
ConsoleWrite(TimerDiff($t) & " ms" & @LF)
$t = TimerInit()
Global Const $hBmp2 = _GDIPlus_BitmapCreateThumbnailWithReflection2($hImage)
ConsoleWrite(TimerDiff($t) & " ms" & @LF)
ConsoleWrite(_GDIPlus_ImageGetWidth($hBmp) & " x " & _GDIPlus_ImageGetHeight($hBmp) & @LF)
_GDIPlus_GraphicsDrawImage($hGraphic, $hBmp, (400 - _GDIPlus_ImageGetWidth($hBmp)) / 2, (400 - _GDIPlus_ImageGetHeight($hBmp)) / 2)
_GDIPlus_GraphicsDrawImage($hGraphic, $hBmp2, (600 + _GDIPlus_ImageGetWidth($hBmp2)) / 2, (400 - _GDIPlus_ImageGetHeight($hBmp2)) / 2)
GUISetOnEvent(-3, "_Exit")

While Sleep(2 ^ 16)
WEnd

Func _Exit()
    _GDIPlus_BitmapDispose($hBmp)
    _GDIPlus_BitmapDispose($hBmp2)
    _GDIPlus_ImageDispose($hImage)
    _GDIPlus_GraphicsDispose($hGraphic)
    _GDIPlus_Shutdown()
    Exit
EndFunc   ;==>_Exit

Func _GDIPlus_BitmapCreateThumbnailWithReflection($hImage, $iTNWidth = 150, $iTNHeight = 150, $iSkew = 40, $iBorderWhite = 2, $iBorderBlack = 1, $fBlur = 0.4, $iBrightness = 175, $iContrast = -70, $iSmooth = 7)
    Local $iWidth = _GDIPlus_ImageGetWidth($hImage), $iHeight = _GDIPlus_ImageGetHeight($hImage), $f
    If $iWidth > $iHeight Then
        $iTNHeight *= $iHeight / $iWidth
    ElseIf $iWidth < $iHeight Then
        $iTNWidth *= $iWidth / $iHeight
    EndIf
    Local $iW = Floor($iTNWidth + ($iBorderWhite + $iBorderBlack) * 2), $iH = Floor($iTNHeight + ($iBorderWhite + $iBorderBlack) * 2)
    Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iW, $iH * 2 - $iBorderBlack)
    Local $hCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmap)
    _GDIPlus_GraphicsSetInterpolationMode($hCtxt, $iSmooth)
;~  _GDIPlus_GraphicsClear($hCtxt, 0xFFFFFFFF)
    Local $hBitmap_tmp = _GDIPlus_BitmapCreateFromScan0($iW, $iH)
    Local $hCtxt_tmp = _GDIPlus_ImageGetGraphicsContext($hBitmap_tmp)
    _GDIPlus_GraphicsSetInterpolationMode($hCtxt_tmp, $iSmooth)
    Local $hPen = _GDIPlus_PenCreate(0xFFFFFFFF, $iBorderWhite)
    _GDIPlus_GraphicsDrawRect($hCtxt_tmp, $iBorderBlack, $iBorderBlack, $iW - $iBorderWhite - $iBorderBlack, $iH - $iBorderWhite - $iBorderBlack, $hPen)
    _GDIPlus_PenSetColor($hPen, 0xFF000000)
    _GDIPlus_PenSetWidth($hPen, $iBorderBlack)
    _GDIPlus_GraphicsDrawRect($hCtxt_tmp, 0, 0, $iW - $iBorderBlack / 2, $iH, $hPen)
    _GDIPlus_GraphicsDrawImageRect($hCtxt_tmp, $hImage, $iBorderWhite + $iBorderBlack, $iBorderWhite + $iBorderBlack, $iTNWidth, $iTNHeight)
    _GDIPlus_GraphicsDrawImage($hCtxt, $hBitmap_tmp, 0, 0)
    _GDIPlus_ImageRotateFlip($hBitmap_tmp, 6)

    Local Const $iQual = 6
    Local $hBmpSmall = _GDIPlus_BitmapCreateFromScan0($iW, $iH)
    Local $hGfxSmall = _GDIPlus_ImageGetGraphicsContext($hBmpSmall)
    _GDIPlus_GraphicsSetPixelOffsetMode($hGfxSmall, 2)
    Local $hBmpBig = _GDIPlus_BitmapCreateFromScan0($iW, $iH)
    Local $hGfxBig = _GDIPlus_ImageGetGraphicsContext($hBmpBig)
    _GDIPlus_GraphicsSetPixelOffsetMode($hGfxBig, 2)

    _GDIPlus_GraphicsScaleTransform($hGfxSmall, $fBlur, $fBlur)
    _GDIPlus_GraphicsSetInterpolationMode($hGfxSmall, $iQual)

    _GDIPlus_GraphicsScaleTransform($hGfxBig, 1 / $fBlur, 1 / $fBlur)
    _GDIPlus_GraphicsSetInterpolationMode($hGfxBig, $iQual)

    _GDIPlus_GraphicsDrawImageRect($hGfxSmall, $hBitmap_tmp, 0, 0, $iW, $iH)
    _GDIPlus_GraphicsDrawImageRect($hGfxBig, $hBmpSmall, 0, 0, $iW, $iH)

    _GDIPlus_GraphicsDrawImageRect($hCtxt_tmp, $hBmpBig, 0, 0, $iW, $iH)

    _GDIPlus_GraphicsDispose($hGfxSmall)
    _GDIPlus_GraphicsDispose($hGfxBig)
    _GDIPlus_BitmapDispose($hBmpSmall)
    _GDIPlus_BitmapDispose($hBmpBig)

    Local $fAlpha, $iColor, $iPixelColor
    Local $tBitmapData = _GDIPlus_BitmapLockBits($hBitmap_tmp, 0, 0, $iW, $iH, BitOR($GDIP_ILMWRITE, $GDIP_ILMREAD), $GDIP_PXF32ARGB)
    Local $iScan0 = DllStructGetData($tBitmapData, "Scan0") ;get scan0 (pixel data) from locked bitmap
    Local $tPixel = DllStructCreate("int[" & $iW * $iH & "];", $iScan0)
    Local $iPixel, $iRowOffset, $iR, $iG, $iB
    For $iY = 0 To $iH - 1
        $iRowOffset = $iY * $iW + 1
        $fAlpha = (0xF8 * ($iH - $iY - 0x18) / $iH)
        If $fAlpha < 0 Then $fAlpha = 0
        For $iX = 0 To $iW - 1
            $iPixelColor = BitAND(DllStructGetData($tPixel, 1, $iRowOffset + $iX), 0x00FFFFFF)
            $iR = BitAND(BitShift($iPixelColor, 16), 0x0000FF)
            $iG = BitAND(BitShift($iPixelColor, 8), 0x0000FF)
            $iB = BitAND($iPixelColor, 0x0000FF)
            DllStructSetData($tPixel, 1, "0x" & _
                    Hex(Int($fAlpha), 2) & _
                    Hex(Int(($iR * 3 + $iG * 2 + $iB * 2) / 8), 2) & _
                    Hex(Int(($iR * 2 + $iG * 3 + $iB * 2) / 8), 2) & _
                    Hex(Int(($iR * 2 + $iG * 2 + $iB * 3) / 8), 2), $iRowOffset + $iX)
        Next
    Next
    _GDIPlus_BitmapUnlockBits($hBitmap_tmp, $tBitmapData)
    _GDIPlus_PenDispose($hPen)
    _GDIPlus_GraphicsDrawImageRect($hCtxt, $hBitmap_tmp, 0, $iH, $iW, $iH)
    _GDIPlus_GraphicsDispose($hCtxt)
    _GDIPlus_GraphicsDispose($hCtxt_tmp)
    _GDIPlus_BitmapDispose($hBitmap_tmp)
    If $iSkew Then
        $iW = _GDIPlus_ImageGetWidth($hBitmap)
        $iH = _GDIPlus_ImageGetHeight($hBitmap)
        Local $hBitmapSkewed = _GDIPlus_BitmapCreateFromScan0($iW, $iH), $x
        $hCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmapSkewed)
;~      _GDIPlus_DrawImagePoints($hCtxt, $hBitmap, 0, 0, $iW, $iSkew, 0, $iH)
        For $x = 0 To $iW - 1
            _GDIPlus_GraphicsDrawImageRectRect($hCtxt, $hBitmap, _
                    $x, 0, 1, $iH, _
                    $x, 0, 1, $iH - $iSkew * ($iW - $x) / $iW)
        Next
        _GDIPlus_GraphicsDispose($hCtxt)
        _GDIPlus_BitmapDispose($hBitmap)
        Return $hBitmapSkewed
    EndIf
    Return $hBitmap
EndFunc   ;==>_GDIPlus_BitmapCreateThumbnailWithReflection

Func _GDIPlus_BitmapCreateThumbnailWithReflection2($hImage, $iTNWidth = 150, $iTNHeight = 150, $iSkew = 40, $iBorderWhite = 2, $iBorderBlack = 1, $fBlur = 3.25, $iBrightness = 170, $iContrast = -70, $iSmooth = 7)
    Local $iWidth = _GDIPlus_ImageGetWidth($hImage), $iHeight = _GDIPlus_ImageGetHeight($hImage), $f
    If $iWidth > $iHeight Then
        $iTNHeight *= $iHeight / $iWidth
    ElseIf $iWidth < $iHeight Then
        $iTNWidth *= $iWidth / $iHeight
    EndIf
    Local $iW = Floor($iTNWidth + ($iBorderWhite + $iBorderBlack) * 2), $iH = Floor($iTNHeight + ($iBorderWhite + $iBorderBlack) * 2)
    Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iW, $iH * 2 - $iBorderBlack)
    Local $hCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmap)
    _GDIPlus_GraphicsSetInterpolationMode($hCtxt, $iSmooth)
    Local $hBitmap_tmp = _GDIPlus_BitmapCreateFromScan0($iW, $iH)
    Local $hCtxt_tmp = _GDIPlus_ImageGetGraphicsContext($hBitmap_tmp)
    _GDIPlus_GraphicsSetInterpolationMode($hCtxt_tmp, $iSmooth)
    Local $hPen = _GDIPlus_PenCreate(0xFFFFFFFF, $iBorderWhite)
    _GDIPlus_GraphicsDrawRect($hCtxt_tmp, $iBorderBlack, $iBorderBlack, $iW - $iBorderWhite - $iBorderBlack, $iH - $iBorderWhite - $iBorderBlack, $hPen)
    _GDIPlus_PenSetColor($hPen, 0xFF000000)
    _GDIPlus_PenSetWidth($hPen, $iBorderBlack)
    _GDIPlus_GraphicsDrawRect($hCtxt_tmp, 0, 0, $iW - $iBorderBlack / 2, $iH, $hPen)
    _GDIPlus_GraphicsDrawImageRect($hCtxt_tmp, $hImage, $iBorderWhite + $iBorderBlack, $iBorderWhite + $iBorderBlack, $iTNWidth, $iTNHeight)
    _GDIPlus_GraphicsDrawImage($hCtxt, $hBitmap_tmp, 0, 0)
    _GDIPlus_ImageRotateFlip($hBitmap_tmp, 6)

    Local $hEffectBC = _GDIPlus_EffectCreateBrightnessContrast($iBrightness, $iContrast)
    _GDIPlus_BitmapApplyEffect($hBitmap_tmp, $hEffectBC)
    Local $hEffectBlur = _GDIPlus_EffectCreateBlur($fBlur, True)
    _GDIPlus_BitmapApplyEffect($hBitmap_tmp, $hEffectBlur)

    _GDIPlus_EffectDispose($hEffectBC)
    _GDIPlus_EffectDispose($hEffectBlur)

    Local $hAttribute_Alpha = _GDIPlus_ImageAttributesCreate()
    Local $hBitmap_Alpha = _GDIPlus_BitmapCreateFromScan0($iW, $iH)
    Local $hCtxt_Alpha = _GDIPlus_ImageGetGraphicsContext($hBitmap_Alpha), $iY, $tColorMatrix, $d = (-1 / 0x80)

    For $iY = 0 To $iH - 1
        $tColorMatrix = _GDIPlus_ColorMatrixCreateTranslate(0, 0, 0, $iY * $d)
        _GDIPlus_ImageAttributesSetColorMatrix($hAttribute_Alpha, 0, True, DllStructGetPtr($tColorMatrix))
        _GDIPlus_GraphicsDrawImageRectRect($hCtxt_Alpha, $hBitmap_tmp, 0, $iY, $iW, 1, 0, $iY, $iW, 1, $hAttribute_Alpha)
    Next

    _GDIPlus_GraphicsDispose($hCtxt_Alpha)
    _GDIPlus_ImageAttributesDispose($hAttribute_Alpha)
    _GDIPlus_PenDispose($hPen)
    _GDIPlus_GraphicsDrawImageRect($hCtxt, $hBitmap_Alpha, 0, $iH, $iW, $iH)
    _GDIPlus_GraphicsDispose($hCtxt)
    _GDIPlus_GraphicsDispose($hCtxt_tmp)
    _GDIPlus_BitmapDispose($hCtxt_Alpha)
    _GDIPlus_BitmapDispose($hBitmap_tmp)
    If $iSkew Then
        $iW = _GDIPlus_ImageGetWidth($hBitmap)
        $iH = _GDIPlus_ImageGetHeight($hBitmap)
        Local $hBitmapSkewed = _GDIPlus_BitmapCreateFromScan0($iW, $iH), $iX
        $hCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmapSkewed)
;~      _GDIPlus_DrawImagePoints($hCtxt, $hBitmap, 0, 0, $iW, $iSkew, 0, $iH)
        For $iX = 0 To $iW - 1
            _GDIPlus_GraphicsDrawImageRectRect($hCtxt, $hBitmap, _
                                                        $iX, 0, 1, $iH, _
                                                        $iX, 0, 1, $iH - $iSkew * ($iW - $iX) / $iW)
        Next
        _GDIPlus_GraphicsDispose($hCtxt)
        _GDIPlus_BitmapDispose($hBitmap)
        Return $hBitmapSkewed
    EndIf
    Return $hBitmap
EndFunc   ;==>_GDIPlus_BitmapCreateThumbnailWithReflection2