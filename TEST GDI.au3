#include <Array.au3>
#include <GDIPlus.au3>

_GDIPlus_Startup()

$hImage=_GDIPlus_ImageLoadFromFile(@ScriptDir&"\1.png")
$hImage2=CreateLayerMask($hImage)
$hGraphics=_GDIPlus_ImageGetGraphicsContext($hImage2)
$hBrush=_GDIPlus_BrushCreateSolid(0xFFFFFFFF)
_GDIPlus_GraphicsFillEllipse($hGraphics, 10, 10, _GDIPlus_ImageGetWidth($hImage2)-20, _GDIPlus_ImageGetHeight($hImage2)-20, $hBrush)
_GDIPlus_BrushDispose($hBrush)
_GDIPlus_GraphicsDispose($hGraphics)
$hBitmap=ApplyLayerMask($hImage, $hImage2)
_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir&"\2.png")
_GDIPlus_ImageDispose($hImage)
_GDIPlus_ImageDispose($hImage2)
_GDIPlus_ImageDispose($hBitmap)

_GDIPlus_Shutdown()

Func CreateLayerMask($hImage)
$iWidth = _GDIPlus_ImageGetWidth($hImage)
$iHeight = _GDIPlus_ImageGetHeight($hImage)
$HBITMAP = _WinAPI_CreateBitmap($iWidth, $iHeight, 1, 32)
$hBmp = _GDIPlus_BitmapCreateFromHBITMAP($HBITMAP)
_WinAPI_DeleteObject($HBITMAP)
$hBitmap = _GDIPlus_BitmapCloneArea($hBmp, 0, 0, $iWidth, $iHeight, $GDIP_PXF32ARGB)
_GDIPlus_BitmapDispose($hBmp)
Return $hBitmap
EndFunc

Func ApplyLayerMask($hImage1, ByRef $hImage2, $bInvert=False)
If $bInvert Then
$iRBGA='000000FF'
Else
$iRBGA='FFFFFFFF'
EndIf
$iWidth = _GDIPlus_ImageGetWidth($hImage1)
$iHeight = _GDIPlus_ImageGetHeight($hImage1)
$HBITMAP = _WinAPI_CreateBitmap($iWidth, $iHeight, 1, 32)
$hBmp=_GDIPlus_BitmapCreateFromHBITMAP($HBITMAP)
_WinAPI_DeleteObject($HBITMAP)
$hBitmap = _GDIPlus_BitmapCloneArea($hBmp, 0, 0, $iWidth, $iHeight, $GDIP_PXF32ARGB)
_GDIPlus_BitmapDispose($hBmp)
$hGraphics = _GDIPlus_ImageGetGraphicsContext($hBitmap)
_GDIPlus_GraphicsDrawImage($hGraphics, $hImage, 0, 0)
_GDIPlus_GraphicsDispose($hGraphics)
$tBitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $iWidth, $iHeight, $GDIP_ILMWRITE, $GDIP_PXF32ARGB)
$tBitmapData2 = _GDIPlus_BitmapLockBits($hImage2, 0, 0, $iWidth, $iHeight, $GDIP_ILMWRITE, $GDIP_PXF32ARGB)
$tPixels = DllStructCreate("byte[" & $iHeight * $iWidth * 4 & "]", DllStructGetData($tBitmapData, "Scan0")) ; Create DLL structure for all pixels
$tPixels2 = DllStructCreate("byte[" & $iHeight * $iWidth * 4 & "]", DllStructGetData($tBitmapData2, "Scan0")) ; Create DLL structure for all pixels
$sPixels = DllStructGetData($tPixels, 1)
$sPixels2 = DllStructGetData($tPixels2, 1)
$iPixels=StringLen($sPixels)
$sPixels=StringMid($sPixels, 3, $iPixels-2)
$sPixels2=StringMid($sPixels2, 3, $iPixels-2)
$iPixels=StringLen($sPixels)
Dim $aPixels[$iPixels/8]
For $i=0 To $iPixels/8-1
If $iRBGA=StringMid($sPixels2, ($i*8)+1, 8) Then
$aPixels[$i]=StringMid($sPixels, ($i*8)+1, 8)
Else
$aPixels[$i]='00000000'
EndIf
Next
$sPixels=_ArrayToString($aPixels, "")
$sPixels="0x"&$sPixels
$sPixels1="0x"&$sPixels2
DllStructSetData($tPixels, 1, $sPixels)
_GDIPlus_BitmapUnlockBits($hBitmap, $tBitmapData)
_GDIPlus_BitmapUnlockBits($hImage2, $tBitmapData2)

$tPixels = 0
$tPixels2 = 0
$tBitmapData = 0
$tBitmapData2 = 0

Return $hBitmap
EndFunc