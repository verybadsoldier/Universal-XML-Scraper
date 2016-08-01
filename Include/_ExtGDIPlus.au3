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

Func _RELATIVPOS($Pos, $source_size)
	If StringLeft($Pos, 1) = '%' Then
;~ 		ConsoleWrite("! Valeur = " & StringTrimLeft($Pos, 1) & " X " & $source_size & " = " & $source_size * StringTrimLeft($Pos, 1) & @CRLF)
		Return $source_size * StringTrimLeft($Pos, 1)
	Else
;~ 		ConsoleWrite("! Valeur = " & $Pos & @CRLF)
		Return $Pos
	EndIf
EndFunc   ;==>_RELATIVPOS