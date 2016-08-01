#include <GDIPlus.au3>
#include <misc.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>

Example2()

Func Example2()
	Local $hBitmap1, $hBitmap2, $hImage1, $hImage2, $hGraphicGUI
	Local $MergedImageBackgroundColor = 0x00000000

	_GDIPlus_Startup()
	$hImage1 = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Test-Img1.png")
	$Image1Width = _GDIPlus_ImageGetWidth($hImage1)
	If $Image1Width = 4294967295 Then $Image1Width = 0 ;4294967295 en cas d'erreur, soit 32 bits ÃƒÂ  1 (11111...1111111).
	$Image1Height = _GDIPlus_ImageGetHeight($hImage1)

	$hImage2 = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Test-Img2.png")
	$Image2Width = _GDIPlus_ImageGetWidth($hImage2)
	If $Image2Width = 4294967295 Then $Image2Width = 0 ;4294967295 en cas d'erreur, soit 32 bits ÃƒÂ  1 (11111...1111111).
	$Image2Height = _GDIPlus_ImageGetHeight($hImage2)

;~ 	$hImage3 = _GDIPlus_BitmapCreateFromHBITMAP($hImage2)
;~ 	$hImage2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage3,$MergedImageBackgroundColor)

	$hGui = GUICreate("GDIPlus Example", $Image1Width, $Image1Height)

	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($Image1Width, $Image1Height, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor)
;~ 	$hImage3 = _GDIPlus_CreateTextureTrans($hImage1, 0.75)
;~ 	_GDIPlus_DrawImagePoints($hGraphic,$hImage1, 0, 0, $Image1Width, 0, 0, $Image1Height)
	_GDIPlus_GraphicsDrawImageRectRectTrans($hGraphic, $hImage1, 0, 0, "", "","",  "",  "" ,  "",  2, 0.75)
	_GDIPlus_DrawImagePoints($hGraphic,$hImage2, 0, 0, $Image2Width, 0, 0, $Image2Height)

    ; Delete the previous GUI and all controls.
    GUIDelete($hGUI)

	_GDIPlus_ImageDispose($hImage1)
	_GDIPlus_ImageDispose($hImage2)
;~ 	_GDIPlus_ImageDispose($hImage3)
	_GDIPlus_ImageSaveToFile($hBMPBuff,@ScriptDir & "\Test-Fini.png")
	_WinAPI_DeleteObject($hBMPBuff)
	_GDIPlus_Shutdown()

EndFunc   ;==>Exemple2

Func Example3()
	Local $hBitmap1, $hBitmap2, $hImage1, $hImage2, $hGraphicGUI
	Local $MergedImageBackgroundColor = 0x00000000

	_GDIPlus_Startup()
	$hImage1 = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Test-Img1.png")
	$Image1Width = _GDIPlus_ImageGetWidth($hImage1)
	If $Image1Width = 4294967295 Then $Image1Width = 0 ;4294967295 en cas d'erreur, soit 32 bits ÃƒÂ  1 (11111...1111111).
	$Image1Height = _GDIPlus_ImageGetHeight($hImage1)

	$hImage2 = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Test-Img2.png")
	$Image2Width = _GDIPlus_ImageGetWidth($hImage2)
	If $Image2Width = 4294967295 Then $Image2Width = 0 ;4294967295 en cas d'erreur, soit 32 bits ÃƒÂ  1 (11111...1111111).
	$Image2Height = _GDIPlus_ImageGetHeight($hImage2)

;~ 	$hImage3 = _GDIPlus_BitmapCreateFromHBITMAP($hImage2)
;~ 	$hImage2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage3,$MergedImageBackgroundColor)

	$hGui = GUICreate("GDIPlus Example", $Image1Width, $Image1Height)

	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($Image1Width, $Image1Height, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
;~ --------
	$TextureBrush = _GDIPlus_CreateTextureTrans($hImage1, 0.5)
	$white = _GDIPlus_BrushCreateSolid(0xfFFFFFFF)
;~ 	-------
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor)

	_GDIPlus_GraphicsFillRect($hGraphic, 0, 0, $Image1Width, $Image1Height, $TextureBrush)
	_GDIPlus_DrawImagePoints($hGraphic,$hImage1, 0, 0, $Image1Width, 0, 0, $Image1Height)
;~ 	_GDIPlus_GraphicsDrawImageRectRectTrans($hGraphic, $hImage2, 0, 0, "", "","",  "",  "" ,  "",  2, 0.5)
;~ 	$hImage3 = _GDIPlus_CreateTextureTrans($hImage2, 0.5)
	_GDIPlus_DrawImagePoints($hGraphic,$hImage2, 0, 0, $Image2Width, 0, 0, $Image2Height)

    ; Delete the previous GUI and all controls.
    GUIDelete($hGUI)
    _GDIPlus_BrushDispose($white)
    _GDIPlus_BrushDispose($TextureBrush)
	_GDIPlus_ImageDispose($hImage1)
	_GDIPlus_ImageDispose($hImage2)
;~ 	_GDIPlus_ImageDispose($hImage3)
	_GDIPlus_ImageSaveToFile($hBMPBuff,@ScriptDir & "\Test-Fini.png")
	_WinAPI_DeleteObject($hBMPBuff)
	_GDIPlus_Shutdown()

EndFunc   ;==>Exemple2

Func Example()
	Local $hBitmap1, $hBitmap2, $hImage1, $hImage2, $hGraphics

	; Initialize GDI+ library
	_GDIPlus_Startup()

	; Capture full screen
	$hBitmap1 = _ScreenCapture_Capture("")
	$hImage1 = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap1)

	; Capture screen region
	$hBitmap2 = _ScreenCapture_Capture("", 0, 0, 400, 300)
	$hBitmap3 = _GDIPlus_BitmapCreateBitmapWithAlpha($hBitmap2, 50)
	$hImage2 = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap3)
;~ 	$hImage2 = _GDIPlus_BitmapCreateReflectionBitmap($hImage2,500,100)



;~ 	$hImage2 = _GDIPlus_BitmapCreateBitmapWithAlpha($hImage2, 50)

	; Draw one image in another
	$hGraphics = _GDIPlus_ImageGetGraphicsContext($hImage1)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hImage2, 100, 100)

	; Draw a frame around the inserted image
	_GDIPlus_GraphicsDrawRect($hGraphics, 100, 100, 400, 300)


	; Save resultant image
	_GDIPlus_ImageSaveToFile($hImage1, @MyDocumentsDir & "\GDIPlus_Image.jpg")

	; Clean up resources
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_ImageDispose($hImage1)
	_GDIPlus_ImageDispose($hImage2)
;~ 	_GDIPlus_ImageDispose($hImage3)
;~ 	_GDIPlus_ImageDispose($hImage4)
	_WinAPI_DeleteObject($hBitmap1)
	_WinAPI_DeleteObject($hBitmap2)

	; Shut down GDI+ library
	_GDIPlus_Shutdown()

	ShellExecute(@MyDocumentsDir & "\GDIPlus_Image.jpg")
EndFunc   ;==>Example

Func _GDIPlus_BitmapCreateReflectionBitmap($hBitmap, $iReflectionHeight, $iAlpha)

	Local $hGraphics, $hBrush, $hReflection[2], $hAlpha, $hResult, $Size

	$Size = DllCall($__g_hGDIPDll, 'uint', 'GdipGetImageDimension', 'handle', $hBitmap, 'float*', 0, 'float*', 0)
	If (@error) Or ($Size[0]) Then
		ConsoleWrite("ERREUR REFLECTION $Size" & @CRLF)
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
	If (@error) Or ($Size1[0]) Then
		ConsoleWrite("ERREUR ALPHA $Size1" & @CRLF)
		Return 0
	EndIf
	$Size2 = DllCall($__g_hGDIPDll, 'uint', 'GdipGetImageDimension', 'handle', $hAlpha, 'float*', 0, 'float*', 0)
	If (@error) Or ($Size2[0]) Then
		ConsoleWrite("ERREUR ALPHA $Size2" & @CRLF)
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


;
; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_GraphicsDrawImageRectRectTrans
; Description ...: Draw an Image object with transparency
; Syntax.........: _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $iSrcX, $iSrcY, [$iSrcWidth, _
;                                   [$iSrcHeight, [$iDstX, [$iDstY, [$iDstWidth, [$iDstHeight[, [$iUnit = 2]]]]]]])
; Parameters ....: $hGraphics   - Handle to a Graphics object
;                  $hImage      - Handle to an Image object
;                  $iSrcX       - The X coordinate of the upper left corner of the source image
;                  $iSrcY       - The Y coordinate of the upper left corner of the source image
;                  $iSrcWidth   - Width of the source image
;                  $iSrcHeight  - Height of the source image
;                  $iDstX       - The X coordinate of the upper left corner of the destination image
;                  $iDstY       - The Y coordinate of the upper left corner of the destination image
;                  $iDstWidth   - Width of the destination image
;                  $iDstHeight  - Height of the destination image
;                  $iUnit       - Specifies the unit of measure for the image
;                  $nTrans      - Value range from 0 (Zero for invisible) to 1.0 (fully opaque)
; Return values .: Success      - True
;                  Failure      - False
; Author ........: Siao
; Modified.......: Malkey
; Remarks .......:
; Related .......:
; Link ..........; http://www.autoitscript.com/forum/index.php?s=&showtopic=70573&view=findpost&p=517195
; Example .......; Yes
Func _GDIPlus_GraphicsDrawImageRectRectTrans($hGraphics, $hImage, $iSrcX, $iSrcY, $iSrcWidth = "", $iSrcHeight = "", _
    $iDstX = "", $iDstY = "", $iDstWidth = "" , $iDstHeight = "", $iUnit = 2, $nTrans = 1)
    Local $tColorMatrix, $x, $hImgAttrib, $iW = _GDIPlus_ImageGetWidth($hImage), $iH = _GDIPlus_ImageGetHeight($hImage)
    If $iSrcWidth = 0 or $iSrcWidth = "" Then $iSrcWidth = $iW
    If $iSrcHeight = 0 or $iSrcHeight = "" Then $iSrcHeight = $iH
    If $iDstX = "" Then $iDstX = $iSrcX
    If $iDstY = "" Then $iDstY = $iSrcY
    If $iDstWidth = "" Then $iDstWidth = $iSrcWidth
    If $iDstHeight = "" Then $iDstHeight = $iSrcHeight
    If $iUnit = "" Then $iUnit = 2
    ;;create color matrix data
    $tColorMatrix = DllStructCreate("float[5];float[5];float[5];float[5];float[5]")
    ;blending values:
    $x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStructSetData($tColorMatrix, 2, 1, 2) * DllStructSetData($tColorMatrix, 3, 1, 3) * _
            DllStructSetData($tColorMatrix, 4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 1, 5)
    ;;create an image attributes object and update its color matrix
    $hImgAttrib =  DllCall($__g_hGDIPDll, "int", "GdipCreateImageAttributes", "ptr*", 0)
    $hImgAttrib = $hImgAttrib[1]
     DllCall($__g_hGDIPDll, "int", "GdipSetImageAttributesColorMatrix", "ptr", $hImgAttrib, "int", 1, _
            "int", 1, "ptr", DllStructGetPtr($tColorMatrix), "ptr", 0, "int", 0)
    ;;draw image into graphic object with alpha blend
    DllCall($__g_hGDIPDll, "int", "GdipDrawImageRectRectI", "hwnd", $hGraphics, "hwnd", $hImage, "int", $iDstX, "int", _
            $iDstY, "int", $iDstWidth, "int", $iDstHeight, "int", $iSrcX, "int", $iSrcY, "int", $iSrcWidth, "int", _
            $iSrcHeight, "int", $iUnit, "ptr", $hImgAttrib, "int", 0, "int", 0)
    ;;clean up
    DllCall($__g_hGDIPDll, "int", "GdipDisposeImageAttributes", "ptr", $hImgAttrib)
    Return
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectRectTrans

; #FUNCTION# ============================================================================================
; Name...........: _GDIPlus_CreateTextureTrans
; Description ...: Creates a TextureBrush object based on an image, and sets image transparency property.
; Parameter
;           $hImage  - Pointer to the Image object.
;           $nTrans  - Value range from 0 (Zero for invisible) to 1.0 (fully opaque)
;           $iX      -  Leftmost coordinate of the image portion to be used by this brush.
;           $iY      - Uppermost coordinate of the image portion to be used by this brush.
;           $iWidth  - Width of the brush and width of the image portion to be used by the brush.
;           $iHeight - Height of the brush and height of the image portion to be used by the brush.
; Return   - Handle (pointer) to the new created TextureBrush object.
Func _GDIPlus_CreateTextureTrans($hImage, $nTrans = 0.5, $iX = 0, $iY = 0, $iWidth = "", $iHeight = "")
    Local $tColorMatrix, $x, $hImgAttrib, $iW = _GDIPlus_ImageGetWidth($hImage), $iH = _GDIPlus_ImageGetHeight($hImage)
    If $iWidth = 0 Or $iWidth = "" Then $iWidth = $iW
    If $iHeight = 0 Or $iHeight = "" Then $iHeight = $iH
    ;;create color matrix data
    $tColorMatrix = DllStructCreate("float[5];float[5];float[5];float[5];float[5]")
    ;blending values:
    $x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStructSetData($tColorMatrix, 2, 1, 2) * DllStructSetData($tColorMatrix, 3, 1, 3) * _
            DllStructSetData($tColorMatrix, 4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 1, 5)
    ;;create an image attributes object and update its color matrix
    $hImgAttrib = DllCall($__g_hGDIPDll, "int", "GdipCreateImageAttributes", "ptr*", 0)
    $hImgAttrib = $hImgAttrib[1]
    DllCall($__g_hGDIPDll, "int", "GdipSetImageAttributesColorMatrix", "ptr", $hImgAttrib, "int", 1, _
            "int", 1, "ptr", DllStructGetPtr($tColorMatrix), "ptr", 0, "int", 0)
    ;;draw image into graphic object with alpha blend
    Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateTextureIAI", "hwnd", $hImage, "ptr", $hImgAttrib, "int", $iX, "int", _
            $iY, "int", $iWidth, "int", $iHeight, "ptr*", 0)
    ;clean up
    DllCall($__g_hGDIPDll, "int", "GdipDisposeImageAttributes", "ptr", $hImgAttrib)
    Return $aResult[7]
EndFunc   ;==>_GDIPlus_CreateTextureTrans
