;~ Function List
; #MISC Function# ===================================================================================================
;~ _LOG([$iMessage = ""],[$iLOGType = 0],[$iVerboseLVL = 0],[$iLOGPath = @ScriptDir & "\Log.txt"]) Write log message in file and in console
; #XML Function# ===================================================================================================
;~ _XML_Read($iXpath, [$iXMLType=0], [$iXMLPath=""], [$oXMLDoc=""]) Read Data in XML File or XML Object
;~ _XML_Write($iXpath, [$iXMLType=0], [$iXMLPath=""], [$oXMLDoc=""]) Write Data in XML File or XML Object
; #GDI Function# ===================================================================================================
;~ _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $iSrcX, $iSrcY, [$iSrcWidth, _
;                                   [$iSrcHeight, [$iDstX, [$iDstY, [$iDstWidth, [$iDstHeight[, [$iUnit = 2]]]]]]])  Draw an Image object with transparency
;~ _GDIPlus_RelativePos($iValue, $iValueMax) Calculate relative position
;~ _GDIPlus_ResizeMax($iPath, $iMAX_Width, $iMAX_Height) Resize a Picture to the Max Size in Width and/or Height
;~ _GDIPlus_Rotation($iPath, $iRotation = 0) Rotate a picture
;~ _GDIPlus_Imaging($iPath, $A_PathImage, $A_MIX_IMAGE_Format, $B_Images, $TYPE = '') Prepare a picture
; #XML DOM Error/Event Handling# ===================================================================================
;~ Internal Function Handling XML Error

#Region MISC Function
; #FUNCTION# ===================================================================================================
; Name...........: _LOG
; Description ...: Write log message in file and in console
; Syntax.........: _LOG([$iMessage = ""],[$iLOGType = 0],[$iVerboseLVL = 0],[$iLOGPath = @ScriptDir & "\Log.txt"])
; Parameters ....: $iLOGPath		- Path to log File
;                  $iMessage	- Message
;                  $iLOGType	- Log Type (0 = Standard, 1 = Warning, 2 = Critical)
; Return values .:
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
Func _LOG($iMessage = "", $iLOGType = 0, $iVerboseLVL = 0, $iLOGPath = @ScriptDir & "\Log.txt")
	Local $tCur, $dtCur, $iTimestamp
	$tCur = _Date_Time_GetLocalTime()
	$dtCur = _Date_Time_SystemTimeToArray($tCur)
	$iTimestamp = "[" & StringRight("0" & $dtCur[3], 2) & ":" & StringRight("0" & $dtCur[4], 2) & ":" & StringRight("0" & $dtCur[5], 2) & "] - "
	Switch $iLOGType
		Case 0
			FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)
			ConsoleWrite($iMessage & @CRLF)
		Case 1
			If $iLOGType <= $iVerboseLVL Then FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)
			ConsoleWrite("+" & $iMessage & @CRLF)
		Case 2
			If $iLOGType <= $iVerboseLVL Then FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)
			ConsoleWrite("!" & $iMessage & @CRLF)
		Case Else
			ConsoleWrite(">----" & $iMessage & @CRLF)
	EndSwitch
EndFunc   ;==>_LOG

; #FUNCTION# ===================================================================================================
; Name...........: _Download
; Description ...: Download URL to a file with @Error and TimeOut
; Syntax.........: _Download($iURL, $iPath)
; Parameters ....: $iURL		- URL to download
;                  $iPath		- Path to download
;                  $iTimeOut	- Time to wait before time out in second
; Return values .: Success      - Return the path of the download
;                  Failure      - -1 : Error
;~ 								- -2 : Time Out
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
Func _Download($iURL, $iPath, $iTimeOut = 20)
	Local $inetgettime = 0, $aData, $hDownload
	$hDownload = InetGet($iURL, $iPath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
	Do
		Sleep(250)
		$inetgettime = $inetgettime + 0.25
		If $inetgettime > $iTimeOut Then
			InetClose($hDownload)
			_LOG("Timed out (" & $inetgettime &"s) for downloading file : "& $iPath,2)
			Return -2
		EndIf
	Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE) ; Check if the download is complete.

	$aData = InetGetInfo($hDownload)
	If @error Then
		_LOG("File Downloaded ERROR InetGetInfo : " & $iPath,2)
		InetClose($hDownload)
        FileDelete($iPath)
        Return -1
    EndIf

	InetClose($hDownload)

	If $aData[$INET_DOWNLOADSUCCESS] Then
		_LOG("File Downloaded : " & $iPath,1)
		Return $iPath
	Else
		_LOG("Error Downloading File : " & $iPath,2)
		_LOG("Bytes read: " & $aData[$INET_DOWNLOADREAD],2)
		_LOG("Size: " & $aData[$INET_DOWNLOADSIZE],2)
        _LOG("Complete: " & $aData[$INET_DOWNLOADCOMPLETE],2)
		_LOG("successful: " & $aData[$INET_DOWNLOADSUCCESS],2)
		_LOG("@error: " & $aData[$INET_DOWNLOADERROR],2)
		_LOG("@extended: " & $aData[$INET_DOWNLOADEXTENDED],2)
		Return -1
	EndIf
EndFunc

; #FUNCTION# ===================================================================================================
; Name...........: _DownloadWRetry
; Description ...: Download URL to a file with @Error and TimeOut With Retry
; Syntax.........: _DownloadWRetry($iURL, $iPath, $iRetry = 3)
; Parameters ....: $iURL		- URL to download
;                  $iPath		- Path to download
;~ 				   $iRetry		- Number of retry
; Return values .: Success      - Return the path of the download
;                  Failure      - -1 : Error
;~ 								- -2 : Time Out
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
Func _DownloadWRetry($iURL, $iPath, $iRetry = 3)
	Local $iCount = 0, $iResult = -1
	While $iResult<0 Or $iCount < $iRetry
		$iCount = $iCount + 1
		$iResult = _Download($iURL, $iPath)
	WEnd
	_LOG("-In " & $iCount & " retry",1)
	Return $iResult
EndFunc

#EndRegion MISC Function

#Region GDI Function
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
		$iDstX = "", $iDstY = "", $iDstWidth = "", $iDstHeight = "", $iUnit = 2, $nTrans = 1)
	Local $tColorMatrix, $hImgAttrib, $iW = _GDIPlus_ImageGetWidth($hImage), $iH = _GDIPlus_ImageGetHeight($hImage)
	If $iSrcWidth = 0 Or $iSrcWidth = "" Then $iSrcWidth = $iW
	If $iSrcHeight = 0 Or $iSrcHeight = "" Then $iSrcHeight = $iH
	If $iDstX = "" Then $iDstX = $iSrcX
	If $iDstY = "" Then $iDstY = $iSrcY
	If $iDstWidth = "" Then $iDstWidth = $iSrcWidth
	If $iDstHeight = "" Then $iDstHeight = $iSrcHeight
	If $iUnit = "" Then $iUnit = 2
	;;create color matrix data
	$tColorMatrix = DllStructCreate("float[5];float[5];float[5];float[5];float[5]")
	;blending values:
	Local $x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStructSetData($tColorMatrix, 2, 1, 2) * DllStructSetData($tColorMatrix, 3, 1, 3) * _
			DllStructSetData($tColorMatrix, 4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 1, 5)
	$x = $x
	;;create an image attributes object and update its color matrix
	$hImgAttrib = DllCall($__g_hGDIPDll, "int", "GdipCreateImageAttributes", "ptr*", 0)
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

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_RelativePos
; Description ...: Calculate relative position
; Syntax.........: _GDIPlus_RelativePos($iValue, $iValueMax)
; Parameters ....: $iValue		- Value
;                  $iValueMax	- Value Max
; Return values .: Return the relative Value
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
Func _GDIPlus_RelativePos($iValue, $iValueMax)
	If StringLeft($iValue, 1) = '%' Then Return $iValueMax * StringTrimLeft($iValue, 1)
	Return $iValue
EndFunc   ;==>_GDIPlus_RelativePos

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_ResizeMax
; Description ...: Resize a Picture to the Max Size in Width and/or Height
; Syntax.........: _GDIPlus_ResizeMax($iPath, $iMAX_Width, $iMAX_Height)
; Parameters ....: $iPath		- Path to the picture
;                  $iMAX_Width	- Max width
;                  $iMAX_Height	- Max height
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
Func _GDIPlus_ResizeMax($iPath, $iMAX_Width, $iMAX_Height)
	Local $iExtension = StringRight($iPath, 3)
	Local $iPath_Temp = StringTrimRight($iPath, 4) & "-RESIZE_Temp." & $iExtension
	Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New, $iRatio, $hImageResized

	;Working on temporary picture
	FileDelete($iPath_Temp)
	If Not FileCopy($iPath, $iPath_Temp, 9) Then
		_LOG("Error copying " & $iPath & " to " & $iPath_Temp, 2)
		Return -1
	EndIf
	If Not FileDelete($iPath) Then
		_LOG("Error deleting " & $iPath, 2)
		Return -1
	EndIf

	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas d'erreur.
	$iHeight = _GDIPlus_ImageGetHeight($hImage)

	If $iMAX_Width = '' Then $iMAX_Width = $iWidth
	If $iMAX_Height = '' Then $iMAX_Height = $iHeight

	$iWidth_New = $iWidth
	$iHeight_New = $iHeight

	If $iWidth > $iMAX_Width Then
		$iRatio = $iWidth / $iMAX_Width
		$iWidth_New = $iMAX_Width
		$iHeight_New = $iHeight / $iRatio
		If $iHeight_New > $iMAX_Height Then
			$iRatio = $iHeight_New / $iMAX_Height
			$iHeight_New = $iMAX_Height
			$iWidth_New = $iWidth_New / $iRatio
		EndIf
	EndIf

	If $iHeight > $iMAX_Height Then
		$iRatio = $iHeight / $iMAX_Height
		$iHeight_New = $iMAX_Height
		$iWidth_New = $iWidth / $iRatio
		If $iWidth_New > $iMAX_Width Then
			$iRatio = $iWidth_New / $iMAX_Width
			$iHeight_New = $iHeight_New / $iRatio
			$iWidth_New = $iMAX_Width
		EndIf
	EndIf

	If $iWidth <> $iWidth_New Or $iHeight <> $iHeight_New Then
		_LOG("Redimensionnement (RESIZEMAX) de " & $iPath) ; Debug
		_LOG("Origine = " & $iWidth & "x" & $iHeight, 1) ; Debug
		_LOG("Finale = " & $iWidth_New & "x" & $iHeight_New, 1) ; Debug
	Else
		_LOG("Pas de redimensionnement (RESIZEMAX) de " & $iPath) ; Debug
	EndIf

	$hImageResized = _GDIPlus_ImageResize($hImage, $iWidth_New, $iHeight_New)

	_GDIPlus_ImageSaveToFile($hImageResized, $iPath)
	_GDIPlus_ImageDispose($hImageResized)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
	If Not FileDelete($iPath_Temp) Then
		_LOG("Error deleting " & $iPath_Temp, 2)
		Return -1
	EndIf

	Return $iPath
EndFunc   ;==>_GDIPlus_ResizeMax

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_Rotation
; Description ...: Rotate a picture
; Syntax.........: _GDIPlus_Rotation($iPath, $iRotation = 0)
; Parameters ....: $iPath		- Path to the picture
;                  $iRotation	- Rotation Value
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......: 	0 - No rotation and no flipping (A 180-degree rotation, a horizontal flip and then a vertical flip)
;~ 					1 - A 90-degree rotation without flipping (A 270-degree rotation, a horizontal flip and then a vertical flip)
;~ 					2 - A 180-degree rotation without flipping (No rotation, a horizontal flip followed by a vertical flip)
;~ 					3 - A 270-degree rotation without flipping (A 90-degree rotation, a horizontal flip and then a vertical flip)
;~ 					4 - No rotation and a horizontal flip (A 180-degree rotation followed by a vertical flip)
;~ 					5 - A 90-degree rotation followed by a horizontal flip (A 270-degree rotation followed by a vertical flip)
;~ 					6 - A 180-degree rotation followed by a horizontal flip (No rotation and a vertical flip)
;~ 					7 - A 270-degree rotation followed by a horizontal flip (A 90-degree rotation followed by a vertical flip)
; Related .......:
; Link ..........;
; Example .......; No
Func _GDIPlus_Rotation($iPath, $iRotation = 0)
	Local $iExtension = StringRight($iPath, 3)
	Local $iPath_Temp = StringTrimRight($iPath, 4) & "-RESIZE_Temp." & $iExtension
	Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New

	;Working on temporary picture
	FileDelete($iPath_Temp)
	If Not FileCopy($iPath, $iPath_Temp, 9) Then
		_LOG("Error copying " & $iPath & " to " & $iPath_Temp, 2)
		Return -1
	EndIf
	If Not FileDelete($iPath) Then
		_LOG("Error deleting " & $iPath, 2)
		Return -1
	EndIf

	If $iRotation = '' Or $iRotation > 7 Then $iRotation = 0

	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas d'erreur.
	$iHeight = _GDIPlus_ImageGetHeight($hImage)

	_GDIPlus_ImageRotateFlip($hImage, $iRotation)
	$iWidth_New = _GDIPlus_ImageGetWidth($hImage)
	If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas d'erreur.
	$iHeight_New = _GDIPlus_ImageGetHeight($hImage)

	_LOG("ROTATION (" & $iRotation & ") de " & $iPath) ; Debug

	_GDIPlus_ImageSaveToFile($hImage, $iPath)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
	If Not FileDelete($iPath_Temp) Then
		_LOG("Error deleting " & $iPath_Temp, 2)
		Return -1
	EndIf
	Return $iPath
EndFunc   ;==>_GDIPlus_Rotation

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_Imaging
; Description ...: Prepare a picture
; Syntax.........: _GDIPlus_Imaging($iPath, $A_PathImage, $A_MIX_IMAGE_Format, $B_Images, $TYPE = '')
; Parameters ....: $iPath		- Path to the picture
;                  $iRotation	- Rotation Value
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
Func _GDIPlus_Imaging($iPath, $A_PathImage, $A_MIX_IMAGE_Format, $B_Images, $TYPE = '')
	Local $iExtension = StringRight($iPath, 3)
	Local $iPath_Temp = StringTrimRight($iPath, 4) & "-IMAGING_Temp." & $iExtension
	Local $hImage, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	Local $MergedImageBackgroundColor = 0x00000000

	Local $iWidth = _GDIPlus_RelativePos($A_MIX_IMAGE_Format[$B_Images][4], $A_PathImage[0][0])
	Local $iHeight = _GDIPlus_RelativePos($A_MIX_IMAGE_Format[$B_Images][5], $A_PathImage[0][1])

	If StringRight($TYPE, 3) = 'MAX' Then
		$iPath = _GDIPlus_ResizeMax($iPath, $iWidth, $iHeight)
	EndIf

	;Working on temporary picture
	FileDelete($iPath_Temp)
	If Not FileCopy($iPath, $iPath_Temp, 9) Then
		_LOG("Error copying " & $iPath & " to " & $iPath_Temp, 2)
		Return -1
	EndIf
	If Not FileDelete($iPath) Then
		_LOG("Error deleting " & $iPath, 2)
		Return -1
	EndIf

	_GDIPlus_Startup()
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$hGui = GUICreate("", $A_PathImage[0][0], $A_PathImage[0][1])
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($A_PathImage[0][0], $A_PathImage[0][1], $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor) ; Fill the Graphic Background (0x00000000 for transparent background in .png files)

	If $iWidth = "" Or StringRight($TYPE, 3) = 'MAX' Then $iWidth = _GDIPlus_ImageGetWidth($hImage)
	If $iHeight = "" Or StringRight($TYPE, 3) = 'MAX' Then $iHeight = _GDIPlus_ImageGetHeight($hImage)
	Local $Image_C1X = _GDIPlus_RelativePos($A_MIX_IMAGE_Format[$B_Images][6], $A_PathImage[0][0])
	Local $Image_C1Y = _GDIPlus_RelativePos($A_MIX_IMAGE_Format[$B_Images][7], $A_PathImage[0][1])
	Local $Image_C2X = _GDIPlus_RelativePos($A_MIX_IMAGE_Format[$B_Images][8], $A_PathImage[0][0])
	Local $Image_C2Y = _GDIPlus_RelativePos($A_MIX_IMAGE_Format[$B_Images][9], $A_PathImage[0][1])
	Local $Image_C3X = _GDIPlus_RelativePos($A_MIX_IMAGE_Format[$B_Images][10], $A_PathImage[0][0])
	Local $Image_C3Y = _GDIPlus_RelativePos($A_MIX_IMAGE_Format[$B_Images][11], $A_PathImage[0][1])

	Switch $Image_C1X
		Case 'CENTER'
			$Image_C1X = ($A_PathImage[0][0] / 2) - ($iWidth / 2)
		Case 'LEFT'
			$Image_C1X = 0
		Case 'RIGHT'
			$Image_C1X = $A_PathImage[0][0] - $iWidth
	EndSwitch
	Switch $Image_C1Y
		Case 'CENTER'
			$Image_C1Y = ($A_PathImage[0][1] / 2) - ($iHeight / 2)
		Case 'UP'
			$Image_C1Y = 0
		Case 'DOWN'
			$Image_C1Y = $A_PathImage[0][1] - $iHeight
	EndSwitch
	Switch $Image_C2X
		Case 'CENTER'
			$Image_C2X = ($A_PathImage[0][0] / 2) + ($iWidth / 2)
		Case 'LEFT'
			$Image_C2X = $iWidth
		Case 'RIGHT'
			$Image_C2X = $A_PathImage[0][0]
		Case ''
			$Image_C2X = $Image_C1X + $iWidth
	EndSwitch
	Switch $Image_C2Y
		Case 'CENTER'
			$Image_C2Y = ($A_PathImage[0][1] / 2) - ($iHeight / 2)
		Case 'UP'
			$Image_C2Y = 0
		Case 'DOWN'
			$Image_C2Y = $A_PathImage[0][1] - $iHeight
		Case ''
			$Image_C2Y = $Image_C1Y
	EndSwitch
	Switch $Image_C3X
		Case 'CENTER'
			$Image_C3X = ($A_PathImage[0][0] / 2) - ($iWidth / 2)
		Case 'LEFT'
			$Image_C3X = 0
		Case 'RIGHT'
			$Image_C3X = $A_PathImage[0][0] - $iWidth
		Case ''
			$Image_C3X = $Image_C1X
	EndSwitch
	Switch $Image_C3Y
		Case 'CENTER'
			$Image_C3Y = ($A_PathImage[0][1] / 2) + ($iHeight / 2)
		Case 'UP'
			$Image_C3Y = 0 + $iHeight
		Case 'DOWN'
			$Image_C3Y = $A_PathImage[0][1]
		Case ''
			$Image_C3Y = $Image_C1Y + $iHeight
	EndSwitch

	ConsoleWrite("+ Preparation de l'image (_IMAGING) de " & $iPath & @CRLF) ; Debug
	ConsoleWrite("+ ----- C1 = " & $Image_C1X & "x" & $Image_C1Y & @CRLF) ; Debug
	ConsoleWrite("+ ----- C2 = " & $Image_C2X & "x" & $Image_C2Y & @CRLF) ; Debug
	ConsoleWrite("+ ----- C3 = " & $Image_C3X & "x" & $Image_C3Y & @CRLF) ; Debug
	ConsoleWrite("+ ----- (Size) = " & $iWidth & "x" & $iHeight & @CRLF) ; Debug

	_GDIPlus_DrawImagePoints($hGraphic, $hImage, $Image_C1X, $Image_C1Y, $Image_C2X, $Image_C2Y, $Image_C3X, $Image_C3Y)
	_GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_BitmapDispose($hBMPBuff)
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	GUIDelete($hGui)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()

	If Not FileDelete($iPath_Temp) Then
		_LOG("Error deleting " & $iPath_Temp, 2)
		Return -1
	EndIf

	Return $iPath
EndFunc   ;==>_GDIPlus_Imaging

#EndRegion GDI Function

#Region XML Function
; #FUNCTION# ===================================================================================================
; Name...........: _XML_Read
; Description ...: Read Data in XML File or XML Object
; Syntax.........: _XML_Read($iXpath, [$iXMLType=0], [$iXMLPath=""], [$oXMLDoc=""])
; Parameters ....: $iXpath		- Xpath to the value to read
;                  $iXMLType	- Type of Value (0 = Node Value, 1 = Attribute Value)
;                  $iXMLPath	- Path to the XML File
;                  $oXMLDoc		- Object contening the XML File
; Return values .: Success      - Value
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
Func _XML_Read($iXpath, $iXMLType = 0, $iXMLPath = "", $oXMLDoc = "")
	Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeName
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	If $iXMLPath <> "" Then
		_XML_Load($oXMLDoc, $iXMLPath)
		If @error Then
			_LOG('_XML_Load @error:' & @CRLF & XML_My_ErrorParser(@error), 2)
			Return -1
		EndIf
		_XML_TIDY($oXMLDoc)
		If @error Then
			_LOG('_XML_TIDY @error:' & @CRLF & XML_My_ErrorParser(@error), 2)
			Return -1
		EndIf
	EndIf

	Switch $iXMLType
		Case 0
			$iXMLValue = _XML_GetValue($oXMLDoc, $iXpath)
			If @error Then
				_LOG('_XML_GetValue @error:' & @CRLF & XML_My_ErrorParser(@error), 2)
				Return -1
			EndIf
			If IsArray($iXMLValue) Then
				_LOG('_XML_GetValue (' & $iXpath & ') = ' & $iXMLValue[1], 1)
				Return $iXMLValue[1]
			Else
				_LOG('_XML_GetValue (' & $iXpath & ') is not an Array', 2)
				Return -1
			EndIf
		Case 1
			$iXpathSplit = StringSplit($iXpath, "/")
			$iXMLAttributeName = $iXpathSplit[UBound($iXpathSplit) - 1]
			$iXpath = StringTrimRight($iXpath, StringLen($iXMLAttributeName) + 1)
			$oNode = _XML_SelectSingleNode($oXMLDoc, $iXpath)
			If @error Then
				_LOG('_XML_SelectSingleNode @error:' & @CRLF & XML_My_ErrorParser(@error), 2)
				Return -1
			EndIf
			$iXMLValue = _XML_GetNodeAttributeValue($oNode, $iXMLAttributeName)
			If @error Then
				_LOG('_XML_GetNodeAttributeValue @error:' & @CRLF & XML_My_ErrorParser(@error), 2)
				Return -1
			EndIf
			Return $iXMLValue
		Case Else
			Return -1
	EndSwitch

	Return -1
EndFunc   ;==>_XML_Read
#EndRegion XML Function

#Region XML DOM Error/Event Handling
; This COM Error Hanlder will be used globally (excepting inside UDF Functions)
Global $oErrorHandler = ObjEvent("AutoIt.Error", ErrFunc_CustomUserHandler_MAIN)
#forceref $oErrorHandler

; This is SetUp for the transfer UDF internal COM Error Handler to the user function
_XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_XML)

Func ErrFunc_CustomUserHandler_MAIN($oError)
	ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") : MainScript ==> COM Error intercepted !" & @CRLF & _
			@TAB & "err.number is: " & @TAB & @TAB & "0x" & Hex($oError.number) & @CRLF & _
			@TAB & "err.windescription:" & @TAB & $oError.windescription & @CRLF & _
			@TAB & "err.description is: " & @TAB & $oError.description & @CRLF & _
			@TAB & "err.source is: " & @TAB & @TAB & $oError.source & @CRLF & _
			@TAB & "err.helpfile is: " & @TAB & $oError.helpfile & @CRLF & _
			@TAB & "err.helpcontext is: " & @TAB & $oError.helpcontext & @CRLF & _
			@TAB & "err.lastdllerror is: " & @TAB & $oError.lastdllerror & @CRLF & _
			@TAB & "err.scriptline is: " & @TAB & $oError.scriptline & @CRLF & _
			@TAB & "err.retcode is: " & @TAB & "0x" & Hex($oError.retcode) & @CRLF & @CRLF)
EndFunc   ;==>ErrFunc_CustomUserHandler_MAIN

Func ErrFunc_CustomUserHandler_XML($oError)
	; here is declared another path to UDF au3 file
	; thanks to this with using _XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_XML)
	;  you get errors which after pressing F4 in SciTE4AutoIt you goes directly to the specified UDF Error Line
	ConsoleWrite(@ScriptDir & '\XMLWrapperEx.au3' & " (" & $oError.scriptline & ") : UDF ==> COM Error intercepted ! " & @CRLF & _
			@TAB & "err.number is: " & @TAB & @TAB & "0x" & Hex($oError.number) & @CRLF & _
			@TAB & "err.windescription:" & @TAB & $oError.windescription & @CRLF & _
			@TAB & "err.description is: " & @TAB & $oError.description & @CRLF & _
			@TAB & "err.source is: " & @TAB & @TAB & $oError.source & @CRLF & _
			@TAB & "err.helpfile is: " & @TAB & $oError.helpfile & @CRLF & _
			@TAB & "err.helpcontext is: " & @TAB & $oError.helpcontext & @CRLF & _
			@TAB & "err.lastdllerror is: " & @TAB & $oError.lastdllerror & @CRLF & _
			@TAB & "err.scriptline is: " & @TAB & $oError.scriptline & @CRLF & _
			@TAB & "err.retcode is: " & @TAB & "0x" & Hex($oError.retcode) & @CRLF & @CRLF)
EndFunc   ;==>ErrFunc_CustomUserHandler_XML

Func XML_DOM_EVENT_ondataavailable()
	#CS
		ondataavailable Event
		https://msdn.microsoft.com/en-us/library/ms754530(v=vs.85).aspx
	#CE
	Local $oEventObj = @COM_EventObj
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	Local $sMessage = 'XML_DOM_EVENT_ fired "ondataavailable"' & @CRLF
	ConsoleWrite($sMessage)
EndFunc   ;==>XML_DOM_EVENT_ondataavailable

Func XML_DOM_EVENT_onreadystatechange()
	#CS
		onreadystatechange Event
		https://msdn.microsoft.com/en-us/library/ms759186(v=vs.85).aspx
	#CE
	Local $oEventObj = @COM_EventObj
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	Local $sMessage = 'XML_DOM_EVENT_ fired "onreadystatechange" : ReadyState = ' & $oEventObj.ReadyState & @CRLF
	ConsoleWrite($sMessage)

EndFunc   ;==>XML_DOM_EVENT_onreadystatechange

Func XML_DOM_EVENT_ontransformnode($oNodeCode_XSL, $oNodeData_XML, $bBool)
	#forceref $oNodeCode_XSL, $oNodeData_XML, $bBool
	#CS
		ontransformnode Event
		https://msdn.microsoft.com/en-us/library/ms767521(v=vs.85).aspx
	#CE
	Local $oEventObj = @COM_EventObj
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	Local $sMessage = 'XML_DOM_EVENT_ fired "ontransformnode"' & @CRLF
	ConsoleWrite($sMessage)

EndFunc   ;==>XML_DOM_EVENT_ontransformnode

; #FUNCTION# ====================================================================================================================
; Name ..........: XML_My_ErrorParser
; Description ...: Changing $XML_ERR_ ... to human readable description
; Syntax ........: XML_My_ErrorParser($iXMLWrapper_Error, $iXMLWrapper_Extended)
; Parameters ....: $iXMLWrapper_Error	- an integer value.
;                  $iXMLWrapper_Extended           - an integer value.
; Return values .: description as string
; Author ........: mLipok
; Modified ......:
; Remarks .......: This function is only example of how user can parse @error and @extended to human readable description
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func XML_My_ErrorParser($iXMLWrapper_Error, $iXMLWrapper_Extended = 0)
	Local $sErrorInfo = ''
	Switch $iXMLWrapper_Error
		Case $XML_ERR_OK
			$sErrorInfo = '$XML_ERR_OK=' & $XML_ERR_OK & @CRLF & 'All is ok.'
		Case $XML_ERR_GENERAL
			$sErrorInfo = '$XML_ERR_GENERAL=' & $XML_ERR_GENERAL & @CRLF & 'The error which is not specifically defined.'
		Case $XML_ERR_COMERROR
			$sErrorInfo = '$XML_ERR_COMERROR=' & $XML_ERR_COMERROR & @CRLF & 'COM ERROR OCCURED. Check @extended and your own error handler function for details.'
		Case $XML_ERR_ISNOTOBJECT
			$sErrorInfo = '$XML_ERR_ISNOTOBJECT=' & $XML_ERR_ISNOTOBJECT & @CRLF & 'No object passed to function'
		Case $XML_ERR_INVALIDDOMDOC
			$sErrorInfo = '$XML_ERR_INVALIDDOMDOC=' & $XML_ERR_INVALIDDOMDOC & @CRLF & 'Invalid object passed to function'
		Case $XML_ERR_INVALIDATTRIB
			$sErrorInfo = '$XML_ERR_INVALIDATTRIB=' & $XML_ERR_INVALIDATTRIB & @CRLF & 'Invalid object passed to function.'
		Case $XML_ERR_INVALIDNODETYPE
			$sErrorInfo = '$XML_ERR_INVALIDNODETYPE=' & $XML_ERR_INVALIDNODETYPE & @CRLF & 'Invalid object passed to function.'
		Case $XML_ERR_OBJCREATE
			$sErrorInfo = '$XML_ERR_OBJCREATE=' & $XML_ERR_OBJCREATE & @CRLF & 'Object can not be created.'
		Case $XML_ERR_NODECREATE
			$sErrorInfo = '$XML_ERR_NODECREATE=' & $XML_ERR_NODECREATE & @CRLF & 'Can not create Node - check also COM Error Handler'
		Case $XML_ERR_NODEAPPEND
			$sErrorInfo = '$XML_ERR_NODEAPPEND=' & $XML_ERR_NODEAPPEND & @CRLF & 'Can not append Node - check also COM Error Handler'
		Case $XML_ERR_PARSE
			$sErrorInfo = '$XML_ERR_PARSE=' & $XML_ERR_PARSE & @CRLF & 'Error: with Parsing objects, .parseError.errorCode=' & $iXMLWrapper_Extended & ' Use _XML_ErrorParser_GetDescription() for get details.'
		Case $XML_ERR_PARSE_XSL
			$sErrorInfo = '$XML_ERR_PARSE_XSL=' & $XML_ERR_PARSE_XSL & @CRLF & 'Error with Parsing XSL objects .parseError.errorCode=' & $iXMLWrapper_Extended & ' Use _XML_ErrorParser_GetDescription() for get details.'
		Case $XML_ERR_LOAD
			$sErrorInfo = '$XML_ERR_LOAD=' & $XML_ERR_LOAD & @CRLF & 'Error opening specified file.'
		Case $XML_ERR_SAVE
			$sErrorInfo = '$XML_ERR_SAVE=' & $XML_ERR_SAVE & @CRLF & 'Error saving file.'
		Case $XML_ERR_PARAMETER
			$sErrorInfo = '$XML_ERR_PARAMETER=' & $XML_ERR_PARAMETER & @CRLF & 'Wrong parameter passed to function.'
		Case $XML_ERR_ARRAY
			$sErrorInfo = '$XML_ERR_ARRAY=' & $XML_ERR_ARRAY & @CRLF & 'Wrong array parameter passed to function. Check array dimension and conent.'
		Case $XML_ERR_XPATH
			$sErrorInfo = '$XML_ERR_XPATH=' & $XML_ERR_XPATH & @CRLF & 'XPath syntax error - check also COM Error Handler.'
		Case $XML_ERR_NONODESMATCH
			$sErrorInfo = '$XML_ERR_NONODESMATCH=' & $XML_ERR_NONODESMATCH & @CRLF & 'No nodes match the XPath expression'
		Case $XML_ERR_NOCHILDMATCH
			$sErrorInfo = '$XML_ERR_NOCHILDMATCH=' & $XML_ERR_NOCHILDMATCH & @CRLF & 'There is no Child in nodes matched by XPath expression.'
		Case $XML_ERR_NOATTRMATCH
			$sErrorInfo = '$XML_ERR_NOATTRMATCH=' & $XML_ERR_NOATTRMATCH & @CRLF & 'There is no such attribute in selected node.'
		Case $XML_ERR_DOMVERSION
			$sErrorInfo = '$XML_ERR_DOMVERSION=' & $XML_ERR_DOMVERSION & @CRLF & 'DOM Version: ' & 'MSXML Version ' & $iXMLWrapper_Extended & ' or greater required for this function'
		Case $XML_ERR_EMPTYCOLLECTION
			$sErrorInfo = '$XML_ERR_EMPTYCOLLECTION=' & $XML_ERR_EMPTYCOLLECTION & @CRLF & 'Collections of objects was empty'
		Case $XML_ERR_EMPTYOBJECT
			$sErrorInfo = '$XML_ERR_EMPTYOBJECT=' & $XML_ERR_EMPTYOBJECT & @CRLF & 'Object is empty'
		Case Else
			$sErrorInfo = '=' & $iXMLWrapper_Error & @CRLF & 'NO ERROR DESCRIPTION FOR THIS @error'
	EndSwitch

	Local $sExtendedInfo = ''
	Switch $iXMLWrapper_Error
		Case $XML_ERR_COMERROR, $XML_ERR_NODEAPPEND, $XML_ERR_NODECREATE
			$sExtendedInfo = 'COM ERROR NUMBER (@error returned via @extended) =' & $iXMLWrapper_Extended
		Case $XML_ERR_PARAMETER
			$sExtendedInfo = 'This @error was fired by parameter: #' & $iXMLWrapper_Extended
		Case Else
			Switch $iXMLWrapper_Extended
				Case $XML_EXT_DEFAULT
					$sExtendedInfo = '$XML_EXT_DEFAULT=' & $XML_EXT_DEFAULT & @CRLF & 'Default - Do not return any additional information'
				Case $XML_EXT_XMLDOM
					$sExtendedInfo = '$XML_EXT_XMLDOM=' & $XML_EXT_XMLDOM & @CRLF & '"Microsoft.XMLDOM" related Error'
				Case $XML_EXT_DOMDOCUMENT
					$sExtendedInfo = '$XML_EXT_DOMDOCUMENT=' & $XML_EXT_DOMDOCUMENT & @CRLF & '"Msxml2.DOMDocument" related Error'
				Case $XML_EXT_XSLTEMPLATE
					$sExtendedInfo = '$XML_EXT_XSLTEMPLATE=' & $XML_EXT_XSLTEMPLATE & @CRLF & '"Msxml2.XSLTemplate" related Error'
				Case $XML_EXT_SAXXMLREADER
					$sExtendedInfo = '$XML_EXT_SAXXMLREADER=' & $XML_EXT_SAXXMLREADER & @CRLF & '"MSXML2.SAXXMLReader" related Error'
				Case $XML_EXT_MXXMLWRITER
					$sExtendedInfo = '$XML_EXT_MXXMLWRITER=' & $XML_EXT_MXXMLWRITER & @CRLF & '"MSXML2.MXXMLWriter" related Error'
				Case $XML_EXT_FREETHREADEDDOMDOCUMENT
					$sExtendedInfo = '$XML_EXT_FREETHREADEDDOMDOCUMENT=' & $XML_EXT_FREETHREADEDDOMDOCUMENT & @CRLF & '"Msxml2.FreeThreadedDOMDocument" related Error'
				Case $XML_EXT_XMLSCHEMACACHE
					$sExtendedInfo = '$XML_EXT_XMLSCHEMACACHE=' & $XML_EXT_XMLSCHEMACACHE & @CRLF & '"Msxml2.XMLSchemaCache." related Error'
				Case $XML_EXT_STREAM
					$sExtendedInfo = '$XML_EXT_STREAM=' & $XML_EXT_STREAM & @CRLF & '"ADODB.STREAM" related Error'
				Case $XML_EXT_ENCODING
					$sExtendedInfo = '$XML_EXT_ENCODING=' & $XML_EXT_ENCODING & @CRLF & 'Encoding related Error'
				Case Else
					$sExtendedInfo = '$iXMLWrapper_Extended=' & $iXMLWrapper_Extended & @CRLF & 'NO ERROR DESCRIPTION FOR THIS @extened'
			EndSwitch
	EndSwitch
	; return back @error and @extended for further debuging
	Return SetError($iXMLWrapper_Error, $iXMLWrapper_Extended, _
			'@error description:' & @CRLF & _
			$sErrorInfo & @CRLF & _
			@CRLF & _
			'@extended description:' & @CRLF & _
			$sExtendedInfo & @CRLF & _
			'')

EndFunc   ;==>XML_My_ErrorParser
#EndRegion XML DOM Error/Event Handling
