#Include <GDIPlus.au3>

If StringRegExpReplace(@AutoItVersion, '(?<!\d)(\d)(?!\d)', '0\1') < '03.03.12.00' Then
    MsgBox(16, 'Error', 'Require AutoIt 3.3.12.0 or later.')
EndIf

$sFile = @ScriptDir & '\iPhone.png'

_GDIPlus_Startup()
$hBitmap = _GDIPlus_BitmapCreateFromFile($sFile)
$hReflection = _GDIPlus_BitmapCreateReflectionBitmap($hBitmap, _GDIPlus_ImageGetHeight($hBitmap) * 0.25, 128)
_GDIPlus_ImageSaveToFile($hReflection, StringRegExpReplace($sFile, '(\.[^\.]+)', '_Reflection\1'))
_GDIPlus_BitmapDispose($hReflection)
_GDIPlus_BitmapDispose($hBitmap)
_GDIPlus_Shutdown()

Func _GDIPlus_BitmapCreateReflectionBitmap($hBitmap, $iReflectionHeight, $iAlpha)

    Local $hGraphics, $hBrush, $hReflection[2], $hAlpha, $hResult, $Size

    $Size = DllCall($__g_hGDIPDll, 'uint', 'GdipGetImageDimension', 'handle', $hBitmap, 'float*', 0, 'float*', 0)
    If (@Error) Or ($Size[0]) Then
        Return 0
    EndIf
    If $iReflectionHeight > $Size[3] Then
        $iReflectionHeight = $Size[3]
    EndIf
    If $iReflectionHeight < 0 Then
        $iReflectionHeight = 0
    EndIf
    $hReflection[0] = _GDIPlus_BitmapCloneArea($hBitmap, 0, $Size[3] - $iReflectionHeight, $Size[2], $iReflectionHeight, $GDIP_PXF32ARGB)
    _GDIPlus_ImageRotateFlip($hReflection[0], 6)
    $hAlpha = _GDIPlus_BitmapCreateFromScan0($Size[2], $iReflectionHeight, $GDIP_PXF32ARGB)
    $hGraphics = _GDIPlus_ImageGetGraphicsContext($hAlpha)
    _GDIPlus_GraphicsClear($hGraphics, 0)
    $hBrush = _GDIPlus_LineBrushCreate(0, 0, 0, $iReflectionHeight, BitShift($iAlpha, -24), 0)
    _GDIPlus_GraphicsFillRect($hGraphics, 0, 0, $Size[2], $iReflectionHeight, $hBrush)
    _GDIPlus_GraphicsDispose($hGraphics)
    $hReflection[1] = _GDIPlus_BitmapCreateBitmapWithAlpha($hReflection[0], $hAlpha)
    $hResult = _GDIPlus_BitmapCreateFromScan0($Size[2], $Size[3] + $iReflectionHeight)
    $hGraphics = _GDIPlus_ImageGetGraphicsContext($hResult)
    _GDIPlus_GraphicsClear($hGraphics, 0)
    _GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $Size[2], $Size[3])
    _GDIPlus_GraphicsDrawImageRect($hGraphics, $hReflection[1], 0, $Size[3], $Size[2], $iReflectionHeight)
    _GDIPlus_GraphicsDispose($hGraphics)
    _GDIPlus_BitmapDispose($hAlpha)
    For $i = 0 To 1
        _GDIPlus_BitmapDispose($hReflection[$i])
    Next
    _GDIPlus_BrushDispose($hBrush)
    Return $hResult
EndFunc   ;==>_GDIPlus_BitmapCreateReflectionBitmap

Func _GDIPlus_BitmapCreateBitmapWithAlpha($hBitmap, $hAlpha, $iChannel = 0)

    Local $hGraphics, $hBmp[2], $bProc, $tProc, $pProc, $Size1, $Size2, $Lenght, $Result
    Local $tData[2] = [$GDIP_ILMWRITE, $GDIP_ILMREAD]

    $Size1 = DllCall($__g_hGDIPDll, 'uint', 'GdipGetImageDimension', 'handle', $hBitmap, 'float*', 0, 'float*', 0)
    If (@Error) Or ($Size1[0]) Then
        Return 0
    EndIf
    $Size2 = DllCall($__g_hGDIPDll, 'uint', 'GdipGetImageDimension', 'handle', $hAlpha, 'float*', 0, 'float*', 0)
    If (@Error) Or ($Size2[0]) Then
        Return 0
    EndIf
    $hBmp[0] = _GDIPlus_BitmapCloneArea($hBitmap, 0, 0, $Size1[2], $Size1[3], $GDIP_PXF32ARGB)
    If ($Size1[2] = $Size2[2]) And ($Size1[3] = $Size2[3]) Then
        $hBmp[1] = $hAlpha
    Else
        $hBmp[1] = _GDIPlus_BitmapCreateFromScan0($Size1[2], $Size1[3], $GDIP_PXF32ARGB)
        $hGraphics = _GDIPlus_ImageGetGraphicsContext($hBmp[1])
        _GDIPlus_GraphicsClear($hGraphics, 0)
        _GDIPlus_GraphicsDrawImageRect($hGraphics, $hAlpha, 0, 0, $Size1[2], $Size1[3])
        _GDIPlus_GraphicsDispose($hGraphics)
    EndIf
    If ($iChannel < 0) Or ($iChannel > 3) Then
        $iChannel = 0
    EndIf
    For $i = 0 To 1
        $tData[$i] = _GDIPlus_BitmapLockBits($hBmp[$i], 0, 0, $Size1[2], $Size1[3], $tData[$i], $GDIP_PXF32ARGB)
    Next
    If @AutoItX64 Then
        $bProc = Binary('0x48894C240848895424104C894424184C894C24205541574831C0505050504883EC2848837C24600074054831C0EB0748C7C0010000004821C00F858100000048837C24680074054831C0EB0748C7C0010000004821C07555837C24700074054831C0EB0748C7C0010000004821C0752A4C637C24784D21FF7C0D4C637C24784983FF037F02EB0948C7C001000000EB034831C04821C07502EB0948C7C001000000EB034831C04821C07502EB0948C7C001000000EB034831C04821C07502EB0948C7C001000000EB034831C04821C0740B4831C04863C0E9950000004C8B7C24604983C7034C897C24284C8B7C246848634424784929C74983C7034C897C243048C7442438000000004C637C247049FFCF4C3B7C24387C4A488B6C24284C0FB67D00488B6C2430480FB645004C0FAFF84C89F848C7C1FF000000489948F7F94989C74C89F850488B6C24305888450048834424280448834424300448FF44243871A748C7C0010000004863C0EB034831C04883C448415F5DC3')
    Else
        $bProc = Binary('0x555331C0505050837C241800740431C0EB05B80100000021C07568837C241C00740431C0EB05B80100000021C07545837C242000740431C0EB05B80100000021C075228B5C242421DB7C0B8B5C242483FB037F02EB07B801000000EB0231C021C07502EB07B801000000EB0231C021C07502EB07B801000000EB0231C021C07502EB07B801000000EB0231C021C0740431C0EB6B8B5C241883C303891C248B5C241C2B5C242483C303895C2404C7442408000000008B5C24204B3B5C24087C368B2C240FB65D008B6C24040FB645000FAFD889D8B9FF00000099F7F989C3538B6C240458884500830424048344240404FF44240871BFB801000000EB0231C083C40C5B5DC21000')
    EndIf
    $Length = BinaryLen($bProc)
    $pProc = DllCall('kernel32.dll', 'ptr', 'VirtualAlloc', 'ptr', 0, 'ulong_ptr', $Length, 'dword', 0x1000, 'dword', 0x0040)
    $tProc = DllStructCreate('byte[' & $Length & ']', $pProc[0])
    DllStructSetData($tProc, 1, $bProc)
    $Result = DllCallAddress('uint', $pProc[0], 'ptr', $tData[0].Scan0, 'ptr', $tData[1].Scan0, 'uint', $Size1[2] * $Size1[3], 'uint', $iChannel)
    If Not $Result[0] Then
        ; Nothing
    EndIf
    DllCall('kernel32.dll', 'int', 'VirtualFree', 'ptr', $pProc[0], 'ulong_ptr', 0, 'dword', 0x4000)
    For $i = 0 To 1
        _GDIPlus_BitmapUnlockBits($hBmp[$i], $tData[$i])
    Next
    If $hBmp[1] <> $hAlpha Then
        _GDIPlus_BitmapDispose($hBmp[1])
    EndIf
    Return $hBmp[0]
EndFunc   ;==>_GDIPlus_BitmapCreateBitmapWithAlpha