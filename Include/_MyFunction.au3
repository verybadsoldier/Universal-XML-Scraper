$__iLineNumber=0
;~ Function List
; #MISC Function# ===================================================================================================
;~ _CREATION_LOG([$iLOGPath = @ScriptDir & "\Log.txt"]) Create the Log file with starting info
;~ _LOG([$iMessage = ""],[$iLOGType = 0],[$iVerboseLVL = 0],[$iLOGPath = @ScriptDir & "\Log.txt"]) Write log message in file and in console
;~ _Download($iURL, $iPath, $iTimeOut = 20) Download URL to a file with @Error and TimeOut
;~ _DownloadWRetry($iURL, $iPath, $iRetry = 3) Download URL to a file with @Error and TimeOut With Retry
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
; Name...........: _LOG_Ceation
; Description ...: Create the Log file with starting info
; Syntax.........: _LOG_Ceation()
; Parameters ....: $iLOGPath	- Path to log File
; Return values .:
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=34 & ' - Func _LOG_Ceation($iLOGPath = "")•./Include/_MyFunction.au3'
Func _LOG_Ceation($iLOGPath = "")
	$__iLineNumber=35 & ' - Local $iVersion•./Include/_MyFunction.au3'
	Local $iVersion
	$__iLineNumber=36 & ' - If $iLOGPath = "" Then $iLOGPath = @ScriptDir & "\Log.txt"•./Include/_MyFunction.au3'
	If $iLOGPath = "" Then $iLOGPath = @ScriptDir & "\Log.txt"
	$__iLineNumber=37 & ' - If @Compiled Then•./Include/_MyFunction.au3'
	If @Compiled Then
		$__iLineNumber=38 & ' - $iVersion = FileGetVersion(@ScriptFullPath)•./Include/_MyFunction.au3'
		$iVersion = FileGetVersion(@ScriptFullPath)
	Else
		$__iLineNumber=40 & ' - $iVersion = "In Progress"•./Include/_MyFunction.au3'
		$iVersion = 'In Progress'
	EndIf
	$__iLineNumber=42 & ' - FileDelete($iLOGPath)•./Include/_MyFunction.au3'
	FileDelete($iLOGPath)
	$__iLineNumber=43 & ' - If Not _FileCreate($iLOGPath) Then MsgBox(4096, "Error", " E ...•./Include/_MyFunction.au3'
	If Not _FileCreate($iLOGPath) Then MsgBox(4096, "Error", " Erreur creation du Fichier LOG      error:" & @error)
	$__iLineNumber=44 & ' - _LOG(@ScriptFullPath & " (" & $iVersion & ")", 0, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG(@ScriptFullPath & " (" & $iVersion & ")", 0, $iLOGPath)
	$__iLineNumber=45 & ' - _LOG(@OSVersion & "(" & @OSArch & ") - " & @OSLang, 0, $iLOG ...•./Include/_MyFunction.au3'
	_LOG(@OSVersion & "(" & @OSArch & ") - " & @OSLang, 0, $iLOGPath)
EndFunc   ;==>_LOG_Ceation

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
$__iLineNumber=62 & ' - Func _LOG($iMessage = "", $iLOGType = 0, $iLOGPath = @Script ...•./Include/_MyFunction.au3'
Func _LOG($iMessage = "", $iLOGType = 0, $iLOGPath = @ScriptDir & "\Log.txt")
	$__iLineNumber=63 & ' - Local $tCur, $dtCur, $iTimestamp•./Include/_MyFunction.au3'
	Local $tCur, $dtCur, $iTimestamp
;~ 	Local $iVerboseLVL = IniRead($iINIPath, "GENERAL", "$vVerbose", 0)
	$__iLineNumber=65 & ' - $tCur = _Date_Time_GetLocalTime()•./Include/_MyFunction.au3'
	$tCur = _Date_Time_GetLocalTime()
	$__iLineNumber=66 & ' - $dtCur = _Date_Time_SystemTimeToArray($tCur)•./Include/_MyFunction.au3'
	$dtCur = _Date_Time_SystemTimeToArray($tCur)
	$__iLineNumber=67 & ' - $iTimestamp = "[" & StringRight("0" & $dtCur[3], 2) & ":" &  ...•./Include/_MyFunction.au3'
	$iTimestamp = "[" & StringRight("0" & $dtCur[3], 2) & ":" & StringRight("0" & $dtCur[4], 2) & ":" & StringRight("0" & $dtCur[5], 2) & "] - "
	$__iLineNumber=68 & ' - Switch $iLOGType•./Include/_MyFunction.au3'
	$__iLineNumber=69 & ' - Case 0•./Include/_MyFunction.au3'
	Switch $iLOGType
		Case 0
			$__iLineNumber=70 & ' - FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)•./Include/_MyFunction.au3'
			FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)
			$__iLineNumber=71 & ' - ConsoleWrite($iMessage & @CRLF)•./Include/_MyFunction.au3'
			ConsoleWrite($iMessage & @CRLF)
		$__iLineNumber=72 & ' - Case 1•./Include/_MyFunction.au3'
		Case 1
			$__iLineNumber=73 & ' - If $iLOGType <= $iVerboseLVL Then FileWrite($iLOGPath, $iTim ...•./Include/_MyFunction.au3'
			If $iLOGType <= $iVerboseLVL Then FileWrite($iLOGPath, $iTimestamp & "> " & $iMessage & @CRLF)
			$__iLineNumber=74 & ' - ConsoleWrite("+" & $iMessage & @CRLF)•./Include/_MyFunction.au3'
			ConsoleWrite("+" & $iMessage & @CRLF)
		$__iLineNumber=75 & ' - Case 2•./Include/_MyFunction.au3'
		Case 2
			$__iLineNumber=76 & ' - If $iLOGType <= $iVerboseLVL Then FileWrite($iLOGPath, $iTim ...•./Include/_MyFunction.au3'
			If $iLOGType <= $iVerboseLVL Then FileWrite($iLOGPath, $iTimestamp & "/!\ " & $iMessage & @CRLF)
			$__iLineNumber=77 & ' - ConsoleWrite("!" & $iMessage & @CRLF)•./Include/_MyFunction.au3'
			ConsoleWrite("!" & $iMessage & @CRLF)
		$__iLineNumber=78 & ' - Case 3•./Include/_MyFunction.au3'
		Case 3
			$__iLineNumber=79 & ' - If $iLOGType <= $iVerboseLVL Then•./Include/_MyFunction.au3'
			If $iLOGType <= $iVerboseLVL Then
				$__iLineNumber=80 & ' - FileWrite($iLOGPath, $iTimestamp & "------------------------ ...•./Include/_MyFunction.au3'
				FileWrite($iLOGPath, $iTimestamp & "--------------------------------------------------------------------------------" & @CRLF)
				$__iLineNumber=81 & ' - FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)•./Include/_MyFunction.au3'
				FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)
				$__iLineNumber=82 & ' - FileWrite($iLOGPath, $iTimestamp & "------------------------ ...•./Include/_MyFunction.au3'
				FileWrite($iLOGPath, $iTimestamp & "--------------------------------------------------------------------------------" & @CRLF)
			EndIf
			$__iLineNumber=84 & ' - ConsoleWrite(">----" & $iMessage & @CRLF)•./Include/_MyFunction.au3'
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
$__iLineNumber=104 & ' - Func _Download($iURL, $iPath, $iTimeOut = "")•./Include/_MyFunction.au3'
Func _Download($iURL, $iPath, $iTimeOut = "")
	$__iLineNumber=105 & ' - Local $inetgettime = 0, $aData, $hDownload•./Include/_MyFunction.au3'
	Local $inetgettime = 0, $aData, $hDownload
	$__iLineNumber=106 & ' - If $iTimeOut = "" Then $iTimeOut = 20•./Include/_MyFunction.au3'
	If $iTimeOut = "" Then $iTimeOut = 20
	$__iLineNumber=107 & ' - $hDownload = InetGet($iURL, $iPath, $INET_FORCERELOAD, $INET ...•./Include/_MyFunction.au3'
	$hDownload = InetGet($iURL, $iPath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
	Do
		Sleep(250)
		$__iLineNumber=110 & ' - $inetgettime = $inetgettime + 0.25•./Include/_MyFunction.au3'
		$inetgettime = $inetgettime + 0.25
		$__iLineNumber=111 & ' - If $inetgettime > $iTimeOut Then•./Include/_MyFunction.au3'
		If $inetgettime > $iTimeOut Then
			$__iLineNumber=112 & ' - InetClose($hDownload)•./Include/_MyFunction.au3'
			InetClose($hDownload)
			$__iLineNumber=113 & ' - _LOG("Timed out (" & $inetgettime & "s) for downloading file ...•./Include/_MyFunction.au3'
			_LOG("Timed out (" & $inetgettime & "s) for downloading file : " & $iPath, 1, $iLOGPath)
			$__iLineNumber=114 & ' - Return -2•./Include/_MyFunction.au3'
			Return -2
		EndIf
	$__iLineNumber=116 & ' - Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE) ; Chec ...•./Include/_MyFunction.au3'
	Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE) ; Check if the download is complete.

	$__iLineNumber=118 & ' - $aData = InetGetInfo($hDownload)•./Include/_MyFunction.au3'
	$aData = InetGetInfo($hDownload)
	$__iLineNumber=119 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=120 & ' - _LOG("File Downloaded ERROR InetGetInfo : " & $iPath, 2, $iL ...•./Include/_MyFunction.au3'
		_LOG("File Downloaded ERROR InetGetInfo : " & $iPath, 2, $iLOGPath)
		$__iLineNumber=121 & ' - InetClose($hDownload)•./Include/_MyFunction.au3'
		InetClose($hDownload)
		$__iLineNumber=122 & ' - FileDelete($iPath)•./Include/_MyFunction.au3'
		FileDelete($iPath)
		$__iLineNumber=123 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf

	$__iLineNumber=126 & ' - InetClose($hDownload)•./Include/_MyFunction.au3'
	InetClose($hDownload)

	$__iLineNumber=128 & ' - If $aData[$INET_DOWNLOADSUCCESS] Then•./Include/_MyFunction.au3'
	If $aData[$INET_DOWNLOADSUCCESS] Then
		$__iLineNumber=129 & ' - _LOG("File Downloaded Path : " & $iPath, 1, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("File Downloaded Path : " & $iPath, 1, $iLOGPath)
;~ 		_LOG("File Downloading URL : " & $iURL, 2, $iLOGPath)
		$__iLineNumber=131 & ' - Return $iPath•./Include/_MyFunction.au3'
		Return $iPath
	Else
		$__iLineNumber=133 & ' - _LOG("Error Downloading File : " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error Downloading File : " & $iPath, 2, $iLOGPath)
;~ 		_LOG("Error Downloading URL : " & $iURL, 2, $iLOGPath)
		$__iLineNumber=135 & ' - _LOG("Bytes read: " & $aData[$INET_DOWNLOADREAD], 2, $iLOGPa ...•./Include/_MyFunction.au3'
		_LOG("Bytes read: " & $aData[$INET_DOWNLOADREAD], 2, $iLOGPath)
		$__iLineNumber=136 & ' - _LOG("Size: " & $aData[$INET_DOWNLOADSIZE], 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Size: " & $aData[$INET_DOWNLOADSIZE], 2, $iLOGPath)
		$__iLineNumber=137 & ' - _LOG("Complete: " & $aData[$INET_DOWNLOADCOMPLETE], 2, $iLOG ...•./Include/_MyFunction.au3'
		_LOG("Complete: " & $aData[$INET_DOWNLOADCOMPLETE], 2, $iLOGPath)
		$__iLineNumber=138 & ' - _LOG("successful: " & $aData[$INET_DOWNLOADSUCCESS], 2, $iLO ...•./Include/_MyFunction.au3'
		_LOG("successful: " & $aData[$INET_DOWNLOADSUCCESS], 2, $iLOGPath)
		$__iLineNumber=139 & ' - _LOG("@error: " & $aData[$INET_DOWNLOADERROR], 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("@error: " & $aData[$INET_DOWNLOADERROR], 2, $iLOGPath)
		$__iLineNumber=140 & ' - _LOG("@extended: " & $aData[$INET_DOWNLOADEXTENDED], 2, $iLO ...•./Include/_MyFunction.au3'
		_LOG("@extended: " & $aData[$INET_DOWNLOADEXTENDED], 2, $iLOGPath)
		$__iLineNumber=141 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
EndFunc   ;==>_Download

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
$__iLineNumber=161 & ' - Func _DownloadWRetry($iURL, $iPath, $iRetry = "", $iTimeOut  ...•./Include/_MyFunction.au3'
Func _DownloadWRetry($iURL, $iPath, $iRetry = "", $iTimeOut = "")
	$__iLineNumber=162 & ' - Local $iCount = 0, $iResult = -1, $vTimer = TimerInit()•./Include/_MyFunction.au3'
	Local $iCount = 0, $iResult = -1, $vTimer = TimerInit()
	$__iLineNumber=163 & ' - If $iRetry = "" Then $iRetry = 3•./Include/_MyFunction.au3'
	If $iRetry = "" Then $iRetry = 3
	$__iLineNumber=164 & ' - If $iTimeOut = "" Then $iTimeOut = 20•./Include/_MyFunction.au3'
	If $iTimeOut = "" Then $iTimeOut = 20
	$__iLineNumber=165 & ' - While $iResult < 0 And $iCount < $iRetry•./Include/_MyFunction.au3'
	While $iResult < 0 And $iCount < $iRetry
		$__iLineNumber=166 & ' - $iCount = $iCount + 1•./Include/_MyFunction.au3'
		$iCount = $iCount + 1
		$__iLineNumber=167 & ' - $iResult = _Download($iURL, $iPath, $iTimeOut)•./Include/_MyFunction.au3'
		$iResult = _Download($iURL, $iPath, $iTimeOut)
	WEnd
	$__iLineNumber=169 & ' - _LOG("-In " & $iCount & " try and " & Round((TimerDiff($vTim ...•./Include/_MyFunction.au3'
	_LOG("-In " & $iCount & " try and " & Round((TimerDiff($vTimer) / 1000), 2) & "s", 1, $iLOGPath)
	$__iLineNumber=170 & ' - Return $iResult•./Include/_MyFunction.au3'
	Return $iResult
EndFunc   ;==>_DownloadWRetry

; #FUNCTION# ===================================================================================================
; Name...........: _MultiLang_LoadLangDef
; Description ...: Return a file size and convert to a readable form
; Syntax.........: _MultiLang_LoadLangDef($iLangPath, $vUserLang)
; Parameters ....: $iLangPath	- Path to the language
;                  $vUserLang	- User language code
; Return values .: Success      - Return the language files array
;                  Failure      - -1
; Author ........: Autoit Help
; Modified.......:
; Remarks .......: Brett Francis (BrettF)
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=187 & ' - Func _MultiLang_LoadLangDef($iLangPath, $vUserLang)•./Include/_MyFunction.au3'
Func _MultiLang_LoadLangDef($iLangPath, $vUserLang)
	;Create an array of available language files
	; ** n=0 is the default language file
	; [n][0] = Display Name in Local Language (Used for Select Function)
	; [n][1] = Language File (Full path.  In this case we used a $iLangPath
	; [n][2] = [Space delimited] Character codes as used by @OS_LANG (used to select correct lang file)
	$__iLineNumber=193 & ' - Local $aLangFiles[5][3]•./Include/_MyFunction.au3'
	Local $aLangFiles[5][3]

	$__iLineNumber=195 & ' - $aLangFiles[0][0] = "English (US)" ;•./Include/_MyFunction.au3'
	$aLangFiles[0][0] = "English (US)" ;
	$__iLineNumber=196 & ' - $aLangFiles[0][1] = $iLangPath & "\UXS-ENGLISH.XML"•./Include/_MyFunction.au3'
	$aLangFiles[0][1] = $iLangPath & "\UXS-ENGLISH.XML"
	$__iLineNumber=197 & ' - $aLangFiles[0][2] = "0409 " & _ ;English_United_States•./Include/_MyFunction.au3'
	$aLangFiles[0][2] = "0409 " & _ ;English_United_States
			"0809 " & _ ;English_United_Kingdom
			"0c09 " & _ ;English_Australia
			"1009 " & _ ;English_Canadian
			"1409 " & _ ;English_New_Zealand
			"1809 " & _ ;English_Irish
			"1c09 " & _ ;English_South_Africa
			"2009 " & _ ;English_Jamaica
			"2409 " & _ ;English_Caribbean
			"2809 " & _ ;English_Belize
			"2c09 " & _ ;English_Trinidad
			"3009 " & _ ;English_Zimbabwe
			"3409" ;English_Philippines

	$__iLineNumber=211 & ' - $aLangFiles[1][0] = "Français" ; French•./Include/_MyFunction.au3'
	$aLangFiles[1][0] = "Français" ; French
	$__iLineNumber=212 & ' - $aLangFiles[1][1] = $iLangPath & "\UXS-FRENCH.XML"•./Include/_MyFunction.au3'
	$aLangFiles[1][1] = $iLangPath & "\UXS-FRENCH.XML"
	$__iLineNumber=213 & ' - $aLangFiles[1][2] = "040c " & _ ;French_Standard•./Include/_MyFunction.au3'
	$aLangFiles[1][2] = "040c " & _ ;French_Standard
			"080c " & _ ;French_Belgian
			"0c0c " & _ ;French_Canadian
			"100c " & _ ;French_Swiss
			"140c " & _ ;French_Luxembourg
			"180c" ;French_Monaco

	$__iLineNumber=220 & ' - $aLangFiles[2][0] = "Portugues" ; Portuguese•./Include/_MyFunction.au3'
	$aLangFiles[2][0] = "Portugues" ; Portuguese
	$__iLineNumber=221 & ' - $aLangFiles[2][1] = $iLangPath & "\UXS-PORTUGUESE.XML"•./Include/_MyFunction.au3'
	$aLangFiles[2][1] = $iLangPath & "\UXS-PORTUGUESE.XML"
	$__iLineNumber=222 & ' - $aLangFiles[2][2] = "0816 " & _ ;Portuguese - Portugal•./Include/_MyFunction.au3'
	$aLangFiles[2][2] = "0816 " & _ ;Portuguese - Portugal
			"0416 " ;Portuguese - Brazil

	$__iLineNumber=225 & ' - $aLangFiles[3][0] = "Deutsch" ; German•./Include/_MyFunction.au3'
	$aLangFiles[3][0] = "Deutsch" ; German
	$__iLineNumber=226 & ' - $aLangFiles[3][1] = $iLangPath & "\UXS-GERMAN.XML"•./Include/_MyFunction.au3'
	$aLangFiles[3][1] = $iLangPath & "\UXS-GERMAN.XML"
	$__iLineNumber=227 & ' - $aLangFiles[3][2] = "0407 " & _ ;German - Germany•./Include/_MyFunction.au3'
	$aLangFiles[3][2] = "0407 " & _ ;German - Germany
			"0807 " & _ ;German - Switzerland
			"0C07 " & _ ;German - Austria
			"1007 " & _ ;German - Luxembourg
			"1407 " ;German - Liechtenstein

	$__iLineNumber=233 & ' - $aLangFiles[4][0] = "Espanol" ; Spanish•./Include/_MyFunction.au3'
	$aLangFiles[4][0] = "Espanol" ; Spanish
	$__iLineNumber=234 & ' - $aLangFiles[4][1] = $iLangPath & "\UXS-SPANISH.XML"•./Include/_MyFunction.au3'
	$aLangFiles[4][1] = $iLangPath & "\UXS-SPANISH.XML"
	$__iLineNumber=235 & ' - $aLangFiles[4][2] = "040A " & _ ;Spanish - Spain•./Include/_MyFunction.au3'
	$aLangFiles[4][2] = "040A " & _ ;Spanish - Spain
			"080A " & _ ;Spanish - Mexico
			"0C0A " & _ ;Spanish - Spain
			"100A " & _ ;Spanish - Guatemala
			"140A " & _ ;Spanish - Costa Rica
			"180A " & _ ;Spanish - Panama
			"1C0A " & _ ;Spanish - Dominican Republic
			"200A " & _ ;Spanish - Venezuela
			"240A " & _ ;Spanish - Colombia
			"280A " & _ ;Spanish - Peru
			"2C0A " & _ ;Spanish - Argentina
			"300A " & _ ;Spanish - Ecuador
			"340A " & _ ;Spanish - Chile
			"380A " & _ ;Spanish - Uruguay
			"3C0A " & _ ;Spanish - Paraguay
			"400A " & _ ;Spanish - Bolivia
			"440A " & _ ;Spanish - El Salvador
			"480A " & _ ;Spanish - Honduras
			"4C0A " & _ ;Spanish - Nicaragua
			"500A " & _ ;Spanish - Puerto Rico
			"540A " ;Spanish - United State

	;Set the available language files, names, and codes.
	$__iLineNumber=258 & ' - _MultiLang_SetFileInfo($aLangFiles)•./Include/_MyFunction.au3'
	_MultiLang_SetFileInfo($aLangFiles)
	$__iLineNumber=259 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=260 & ' - MsgBox(48, "Error", "Could not set file info.  Error Code "  ...•./Include/_MyFunction.au3'
		MsgBox(48, "Error", "Could not set file info.  Error Code " & @error)
		$__iLineNumber=261 & ' - _LOG("Could not set file info.  Error Code " & @error, 2, $i ...•./Include/_MyFunction.au3'
		_LOG("Could not set file info.  Error Code " & @error, 2, $iLOGPath)
		Exit
	EndIf

	;Check if the loaded settings file exists.  If not ask user to select language.
	$__iLineNumber=266 & ' - If $vUserLang = -1 Then•./Include/_MyFunction.au3'
	If $vUserLang = -1 Then
		;Create Selection GUI
		$__iLineNumber=268 & ' - _LOG("Loading language :" & StringLower(@OSLang), 1, $iLOGPa ...•./Include/_MyFunction.au3'
		_LOG("Loading language :" & StringLower(@OSLang), 1, $iLOGPath)
		$__iLineNumber=269 & ' - _MultiLang_LoadLangFile(StringLower(@OSLang))•./Include/_MyFunction.au3'
		_MultiLang_LoadLangFile(StringLower(@OSLang))
		$__iLineNumber=270 & ' - $vUserLang = _SelectGUI($aLangFiles, StringLower(@OSLang), " ...•./Include/_MyFunction.au3'
		$vUserLang = _SelectGUI($aLangFiles, StringLower(@OSLang), "langue", 1)
		$__iLineNumber=271 & ' - If @error Then•./Include/_MyFunction.au3'
		If @error Then
			$__iLineNumber=272 & ' - MsgBox(48, "Error", "Could not create selection GUI.  Error  ...•./Include/_MyFunction.au3'
			MsgBox(48, "Error", "Could not create selection GUI.  Error Code " & @error)
			$__iLineNumber=273 & ' - _LOG("Could not create selection GUI.  Error Code " & @error ...•./Include/_MyFunction.au3'
			_LOG("Could not create selection GUI.  Error Code " & @error, 2, $iLOGPath)
			Exit
		EndIf
		$__iLineNumber=276 & ' - IniWrite($iINIPath, "LAST_USE", "$vUserLang", $vUserLang)•./Include/_MyFunction.au3'
		IniWrite($iINIPath, "LAST_USE", "$vUserLang", $vUserLang)
	EndIf

	$__iLineNumber=279 & ' - _LOG("Language Selected : " & $vUserLang, 0, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG("Language Selected : " & $vUserLang, 0, $iLOGPath)

	;If you supplied an invalid $vUserLang, we will load the default language file
	$__iLineNumber=282 & ' - If _MultiLang_LoadLangFile($vUserLang) = 2 Then MsgBox(64, " ...•./Include/_MyFunction.au3'
	If _MultiLang_LoadLangFile($vUserLang) = 2 Then MsgBox(64, "Information", "Just letting you know that we loaded the default language file")
	$__iLineNumber=283 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=284 & ' - MsgBox(48, "Error", "Could not load lang file.  Error Code " ...•./Include/_MyFunction.au3'
		MsgBox(48, "Error", "Could not load lang file.  Error Code " & @error)
		$__iLineNumber=285 & ' - _LOG("Could not load lang file.  Error Code " & @error, 2, $ ...•./Include/_MyFunction.au3'
		_LOG("Could not load lang file.  Error Code " & @error, 2, $iLOGPath)
		Exit
	EndIf
	$__iLineNumber=288 & ' - Return $aLangFiles•./Include/_MyFunction.au3'
	Return $aLangFiles
EndFunc   ;==>_MultiLang_LoadLangDef

; #FUNCTION# ===================================================================================================
; Name...........: _SelectGUI
; Description ...: GUI to select from an array
; Syntax.........: _SelectGUI($aSelectionItem , [$default = -1] , [$vText = "standard"], [$vLanguageSelector = 0])
; Parameters ....: $aSelectionItem	- Array with info (see Remarks)
;                  $vLanguageSelector- If used as language selector
;                  $default			- Default value if nothing selected
; Return values .: Success      - Return the selected item
;                  Failure      - -1
; Author ........: Brett Francis (BrettF)
; Modified.......:
; Remarks .......: $aSelectionItem is a 2D Array
;~ 					[Name viewed][Note Used][Returned value]
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=307 & ' - Func _SelectGUI($aSelectionItem, $default = -1, $vText = "st ...•./Include/_MyFunction.au3'
Func _SelectGUI($aSelectionItem, $default = -1, $vText = "standard", $vLanguageSelector = 0)
	$__iLineNumber=308 & ' - If $aSelectionItem = -1 Or IsArray($aSelectionItem) = 0 Then•./Include/_MyFunction.au3'
	If $aSelectionItem = -1 Or IsArray($aSelectionItem) = 0 Then
		$__iLineNumber=309 & ' - _LOG("Selection Array Invalid", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Selection Array Invalid", 2, $iLOGPath)
		$__iLineNumber=310 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=312 & ' - If $vLanguageSelector = 1 Then•./Include/_MyFunction.au3'
	If $vLanguageSelector = 1 Then
		$__iLineNumber=313 & ' - $_gh_aLangFileArray = $aSelectionItem•./Include/_MyFunction.au3'
		$_gh_aLangFileArray = $aSelectionItem
		$__iLineNumber=314 & ' - If $default = -1 Then $default = @OSLang•./Include/_MyFunction.au3'
		If $default = -1 Then $default = @OSLang
	EndIf



	$__iLineNumber=319 & ' - Local $_Selector_gui_GUI = GUICreate(_MultiLang_GetText("win ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_GUI = GUICreate(_MultiLang_GetText("win_sel_" & $vText & "_Title"), 230, 100)
	$__iLineNumber=320 & ' - Local $_Selector_gui_Combo = GUICtrlCreateCombo("(" & _Multi ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_Combo = GUICtrlCreateCombo("(" & _MultiLang_GetText("win_sel_" & $vText & "_Title") & ")", 8, 48, 209, 25, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE)) ;BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	$__iLineNumber=321 & ' - Local $_Selector_gui_Button = GUICtrlCreateButton(_MultiLang ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_Button = GUICtrlCreateButton(_MultiLang_GetText("win_sel_" & $vText & "_button"), 144, 72, 75, 25)
	$__iLineNumber=322 & ' - Local $_Selector_gui_Label = GUICtrlCreateLabel(_MultiLang_G ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_Label = GUICtrlCreateLabel(_MultiLang_GetText("win_sel_" & $vText & "_text"), 8, 8, 212, 33)

	;Create List of available Items
	$__iLineNumber=325 & ' - For $i = 0 To UBound($aSelectionItem) - 1•./Include/_MyFunction.au3'
	For $i = 0 To UBound($aSelectionItem) - 1
		$__iLineNumber=326 & ' - GUICtrlSetData($_Selector_gui_Combo, $aSelectionItem[$i][0], ...•./Include/_MyFunction.au3'
		GUICtrlSetData($_Selector_gui_Combo, $aSelectionItem[$i][0], "(" & _MultiLang_GetText("win_sel_" & $vText & "_Title") & ")")
	Next

	$__iLineNumber=329 & ' - GUISetState(@SW_SHOW)•./Include/_MyFunction.au3'
	GUISetState(@SW_SHOW)
	$__iLineNumber=330 & ' - While 1•./Include/_MyFunction.au3'
	While 1
		$__iLineNumber=331 & ' - $nMsg = GUIGetMsg()•./Include/_MyFunction.au3'
		$nMsg = GUIGetMsg()
		$__iLineNumber=332 & ' - Switch $nMsg•./Include/_MyFunction.au3'
		$__iLineNumber=333 & ' - Case $_Selector_gui_Button•./Include/_MyFunction.au3'
		Switch $nMsg
			Case $_Selector_gui_Button
				ExitLoop
		EndSwitch
	WEnd
	$__iLineNumber=337 & ' - Local $_selected = GUICtrlRead($_Selector_gui_Combo)•./Include/_MyFunction.au3'
	Local $_selected = GUICtrlRead($_Selector_gui_Combo)
	$__iLineNumber=338 & ' - GUIDelete($_Selector_gui_GUI)•./Include/_MyFunction.au3'
	GUIDelete($_Selector_gui_GUI)

;~ 	MsgBox(0,"$_selected",$_selected)
;~ 	_ArrayDisplay($aSelectionItem,"$aSelectionItem")

	$__iLineNumber=343 & ' - For $i = 0 To UBound($aSelectionItem) - 1•./Include/_MyFunction.au3'
	For $i = 0 To UBound($aSelectionItem) - 1
		$__iLineNumber=344 & ' - If $aSelectionItem[$i][0] = $_selected Then•./Include/_MyFunction.au3'
		If $aSelectionItem[$i][0] = $_selected Then
			$__iLineNumber=345 & ' - If $vLanguageSelector = 1 Then•./Include/_MyFunction.au3'
			If $vLanguageSelector = 1 Then
				$__iLineNumber=346 & ' - _LOG("Value selected : " & StringLeft($aSelectionItem[$i][2] ...•./Include/_MyFunction.au3'
				_LOG("Value selected : " & StringLeft($aSelectionItem[$i][2], 4), 1, $iLOGPath)
				$__iLineNumber=347 & ' - Return StringLeft($aSelectionItem[$i][2], 4)•./Include/_MyFunction.au3'
				Return StringLeft($aSelectionItem[$i][2], 4)
			Else
				$__iLineNumber=349 & ' - _LOG("Value selected : " & $aSelectionItem[$i][2], 1, $iLOGP ...•./Include/_MyFunction.au3'
				_LOG("Value selected : " & $aSelectionItem[$i][2], 1, $iLOGPath)
				$__iLineNumber=350 & ' - Return $aSelectionItem[$i][2]•./Include/_MyFunction.au3'
				Return $aSelectionItem[$i][2]
			EndIf
		EndIf
	Next
	$__iLineNumber=354 & ' - _LOG("No Value selected (Default = " & $default & ")", 1, $i ...•./Include/_MyFunction.au3'
	_LOG("No Value selected (Default = " & $default & ")", 1, $iLOGPath)
	$__iLineNumber=355 & ' - Return $default•./Include/_MyFunction.au3'
	Return $default
EndFunc   ;==>_SelectGUI

; #FUNCTION# ===================================================================================================
; Name...........: _ByteSuffix($iBytes)
; Description ...: Return a file size and convert to a readable form
; Syntax.........: _ByteSuffix($iBytes)
; Parameters ....: $iBytes		- Size from a FileGetSize() function
; Return values .: Success      - Return a string with Size and suffixe
; Author ........: Autoit Help
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; yes in FileGetSize autoit Help
$__iLineNumber=370 & ' - Func _ByteSuffix($iBytes)•./Include/_MyFunction.au3'
Func _ByteSuffix($iBytes)
	$__iLineNumber=371 & ' - Local $iIndex = 0, $aArray = [" bytes", " KB", " MB", " GB", ...•./Include/_MyFunction.au3'
	Local $iIndex = 0, $aArray = [' bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB']
	$__iLineNumber=372 & ' - While $iBytes > 1023•./Include/_MyFunction.au3'
	While $iBytes > 1023
		$__iLineNumber=373 & ' - $iIndex += 1•./Include/_MyFunction.au3'
		$iIndex += 1
		$__iLineNumber=374 & ' - $iBytes /= 1024•./Include/_MyFunction.au3'
		$iBytes /= 1024
	WEnd
	$__iLineNumber=376 & ' - Return Round($iBytes) & $aArray[$iIndex]•./Include/_MyFunction.au3'
	Return Round($iBytes) & $aArray[$iIndex]
EndFunc   ;==>_ByteSuffix

$__iLineNumber=379 & ' - Func _IsChecked($idControlID)•./Include/_MyFunction.au3'
Func _IsChecked($idControlID)
	$__iLineNumber=380 & ' - Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GU ...•./Include/_MyFunction.au3'
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

$__iLineNumber=383 & ' - Func _FormatElapsedTime($Input_Seconds)•./Include/_MyFunction.au3'
Func _FormatElapsedTime($Input_Seconds)
	$__iLineNumber=384 & ' - If $Input_Seconds < 1 Then Return•./Include/_MyFunction.au3'
	If $Input_Seconds < 1 Then Return
	$__iLineNumber=385 & ' - Global $ElapsedMessage = ""•./Include/_MyFunction.au3'
	Global $ElapsedMessage = ''
	$__iLineNumber=386 & ' - Global $Input = $Input_Seconds•./Include/_MyFunction.au3'
	Global $Input = $Input_Seconds
	$__iLineNumber=387 & ' - Switch $Input_Seconds•./Include/_MyFunction.au3'
	$__iLineNumber=388 & ' - Case 0 To 59•./Include/_MyFunction.au3'
	Switch $Input_Seconds
		Case 0 To 59
			$__iLineNumber=389 & ' - GetSeconds()•./Include/_MyFunction.au3'
			GetSeconds()
		$__iLineNumber=390 & ' - Case 60 To 3599•./Include/_MyFunction.au3'
		Case 60 To 3599
			$__iLineNumber=391 & ' - GetMinutes()•./Include/_MyFunction.au3'
			GetMinutes()
			$__iLineNumber=392 & ' - GetSeconds()•./Include/_MyFunction.au3'
			GetSeconds()
		$__iLineNumber=393 & ' - Case 3600 To 86399•./Include/_MyFunction.au3'
		Case 3600 To 86399
			$__iLineNumber=394 & ' - GetHours()•./Include/_MyFunction.au3'
			GetHours()
			$__iLineNumber=395 & ' - GetMinutes()•./Include/_MyFunction.au3'
			GetMinutes()
			$__iLineNumber=396 & ' - GetSeconds()•./Include/_MyFunction.au3'
			GetSeconds()
		Case Else
			$__iLineNumber=398 & ' - GetDays()•./Include/_MyFunction.au3'
			GetDays()
			$__iLineNumber=399 & ' - GetHours()•./Include/_MyFunction.au3'
			GetHours()
			$__iLineNumber=400 & ' - GetMinutes()•./Include/_MyFunction.au3'
			GetMinutes()
			$__iLineNumber=401 & ' - GetSeconds()•./Include/_MyFunction.au3'
			GetSeconds()
	EndSwitch
	$__iLineNumber=403 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>_FormatElapsedTime

$__iLineNumber=406 & ' - Func GetDays()•./Include/_MyFunction.au3'
Func GetDays()
	$__iLineNumber=407 & ' - $Days = Int($Input / 86400)•./Include/_MyFunction.au3'
	$Days = Int($Input / 86400)
	$__iLineNumber=408 & ' - $Input -= ($Days * 86400)•./Include/_MyFunction.au3'
	$Input -= ($Days * 86400)
	$__iLineNumber=409 & ' - $ElapsedMessage &= $Days & " d, "•./Include/_MyFunction.au3'
	$ElapsedMessage &= $Days & ' d, '
	$__iLineNumber=410 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>GetDays

$__iLineNumber=413 & ' - Func GetHours()•./Include/_MyFunction.au3'
Func GetHours()
	$__iLineNumber=414 & ' - $Hours = Int($Input / 3600)•./Include/_MyFunction.au3'
	$Hours = Int($Input / 3600)
	$__iLineNumber=415 & ' - $Input -= ($Hours * 3600)•./Include/_MyFunction.au3'
	$Input -= ($Hours * 3600)
	$__iLineNumber=416 & ' - $ElapsedMessage &= $Hours & " h, "•./Include/_MyFunction.au3'
	$ElapsedMessage &= $Hours & ' h, '
	$__iLineNumber=417 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>GetHours

$__iLineNumber=420 & ' - Func GetMinutes()•./Include/_MyFunction.au3'
Func GetMinutes()
	$__iLineNumber=421 & ' - $Minutes = Int($Input / 60)•./Include/_MyFunction.au3'
	$Minutes = Int($Input / 60)
	$__iLineNumber=422 & ' - $Input -= ($Minutes * 60)•./Include/_MyFunction.au3'
	$Input -= ($Minutes * 60)
	$__iLineNumber=423 & ' - $ElapsedMessage &= $Minutes & " min, "•./Include/_MyFunction.au3'
	$ElapsedMessage &= $Minutes & ' min, '
	$__iLineNumber=424 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>GetMinutes

$__iLineNumber=427 & ' - Func GetSeconds()•./Include/_MyFunction.au3'
Func GetSeconds()
	$__iLineNumber=428 & ' - $ElapsedMessage &= Int($Input) & " sec."•./Include/_MyFunction.au3'
	$ElapsedMessage &= Int($Input) & ' sec.'
	$__iLineNumber=429 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>GetSeconds

$__iLineNumber=432 & ' - Func _MakeTEMPFile($iPath, $iPath_Temp)•./Include/_MyFunction.au3'
Func _MakeTEMPFile($iPath, $iPath_Temp)
	;Working on temporary picture
	$__iLineNumber=434 & ' - FileDelete($iPath_Temp)•./Include/_MyFunction.au3'
	FileDelete($iPath_Temp)
	$__iLineNumber=435 & ' - If Not FileCopy($iPath, $iPath_Temp, 9) Then•./Include/_MyFunction.au3'
	If Not FileCopy($iPath, $iPath_Temp, 9) Then
		$__iLineNumber=436 & ' - _LOG("Error copying " & $iPath & " to " & $iPath_Temp, 2, $i ...•./Include/_MyFunction.au3'
		_LOG("Error copying " & $iPath & " to " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=437 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=439 & ' - If Not FileDelete($iPath) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath) Then
		$__iLineNumber=440 & ' - _LOG("Error deleting " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath, 2, $iLOGPath)
		$__iLineNumber=441 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=443 & ' - Return $iPath_Temp•./Include/_MyFunction.au3'
	Return $iPath_Temp
EndFunc   ;==>_MakeTEMPFile

$__iLineNumber=446 & ' - Func _Coalesce($vValue1, $vValue2, $vTestValue = "")•./Include/_MyFunction.au3'
Func _Coalesce($vValue1, $vValue2, $vTestValue = "")
	$__iLineNumber=447 & ' - If $vValue1 = $vTestValue Then Return $vValue2•./Include/_MyFunction.au3'
	If $vValue1 = $vTestValue Then Return $vValue2
	$__iLineNumber=448 & ' - Return $vValue1•./Include/_MyFunction.au3'
	Return $vValue1
EndFunc   ;==>_Coalesce

#EndRegion MISC Function

#Region GDI Function
; #FUNCTION# ===================================================================================================
; Name...........: _OptiPNG
; Description ...: Optimize PNG
; Syntax.........: _OptiPNG($iPath)
; Parameters ....: $iPath		- Path to the picture
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: wakillon
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; https://www.autoitscript.com/forum/topic/122168-tinypicsharer-v-1034-new-version-08-june-2013/
$__iLineNumber=467 & ' - Func _OptiPNG($iPath, $iParamater = "-clobber")•./Include/_MyFunction.au3'
Func _OptiPNG($iPath, $iParamater = "-clobber")
	$__iLineNumber=468 & ' - Local $sRun, $iPid, $_StderrRead•./Include/_MyFunction.au3'
	Local $sRun, $iPid, $_StderrRead
	$__iLineNumber=469 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=470 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=471 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-OPTI_Temp.PNG ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-OPTI_Temp.PNG"
	$__iLineNumber=472 & ' - If StringLower($iExtension) <> ".png" Then•./Include/_MyFunction.au3'
	If StringLower($iExtension) <> ".png" Then
		$__iLineNumber=473 & ' - _LOG("Not a PNG file : " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Not a PNG file : " & $iPath, 2, $iLOGPath)
		$__iLineNumber=474 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=476 & ' - $vPathSize = _ByteSuffix(FileGetSize($iPath))•./Include/_MyFunction.au3'
	$vPathSize = _ByteSuffix(FileGetSize($iPath))
	$__iLineNumber=477 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=478 & ' - $sRun = $iScriptPath & "\Ressources\optipng.exe -o1 "" & $iP ...•./Include/_MyFunction.au3'
	$sRun = $iScriptPath & '\Ressources\optipng.exe -o1 "' & $iPath_Temp & '" ' & $iParamater & ' -out "' & $iPath & '"'
	$__iLineNumber=479 & ' - _LOG("OptiPNG command: " & $sRun, 1, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG("OptiPNG command: " & $sRun, 1, $iLOGPath)
	$__iLineNumber=480 & ' - $iPid = Run($sRun, "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHI ...•./Include/_MyFunction.au3'
	$iPid = Run($sRun, '', @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	$__iLineNumber=481 & ' - While ProcessExists($iPid)•./Include/_MyFunction.au3'
	While ProcessExists($iPid)
		$__iLineNumber=482 & ' - $_StderrRead = StderrRead($iPid)•./Include/_MyFunction.au3'
		$_StderrRead = StderrRead($iPid)
		$__iLineNumber=483 & ' - If Not @error And $_StderrRead <> "" Then•./Include/_MyFunction.au3'
		If Not @error And $_StderrRead <> '' Then
			$__iLineNumber=484 & ' - If StringInStr($_StderrRead, "error") Then•./Include/_MyFunction.au3'
			If StringInStr($_StderrRead, 'error') Then
				$__iLineNumber=485 & ' - _LOG("Error while optimizing " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG("Error while optimizing " & $iPath, 2, $iLOGPath)
				$__iLineNumber=486 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
		EndIf
	WEnd
	$__iLineNumber=490 & ' - $vPathSizeOptimized = _ByteSuffix(FileGetSize($iPath))•./Include/_MyFunction.au3'
	$vPathSizeOptimized = _ByteSuffix(FileGetSize($iPath))
	$__iLineNumber=491 & ' - _LOG("PNG Optimization (OptiPNG): " & $iPath & "(" & $vPathS ...•./Include/_MyFunction.au3'
	_LOG("PNG Optimization (OptiPNG): " & $iPath & "(" & $vPathSize & " -> " & $vPathSizeOptimized & ")", 0, $iLOGPath)
	$__iLineNumber=492 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=493 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=494 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=496 & ' - Return $iPath•./Include/_MyFunction.au3'
	Return $iPath
EndFunc   ;==>_OptiPNG

; #FUNCTION# ===================================================================================================
; Name...........: _PNGQuant
; Description ...: Optimize PNG
; Syntax.........: _PNGQuant($iPath,$iParamater = "")
; Parameters ....: $iPath		- Path to the picture
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: wakillon
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; https://www.autoitscript.com/forum/topic/122168-tinypicsharer-v-1034-new-version-08-june-2013/
$__iLineNumber=512 & ' - Func _Compression($iPath, $isoft = "pngquant.exe", $iParamat ...•./Include/_MyFunction.au3'
Func _Compression($iPath, $isoft = 'pngquant.exe', $iParamater = '--force --verbose --ordered --speed=1 --quality=50-90 --ext .png')
	$__iLineNumber=513 & ' - Local $sRun, $iPid, $_StderrRead•./Include/_MyFunction.au3'
	Local $sRun, $iPid, $_StderrRead
	$__iLineNumber=514 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=515 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=516 & ' - If StringLower($iExtension) <> ".png" Then•./Include/_MyFunction.au3'
	If StringLower($iExtension) <> ".png" Then
		$__iLineNumber=517 & ' - _LOG("Not a PNG file : " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Not a PNG file : " & $iPath, 2, $iLOGPath)
		$__iLineNumber=518 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=520 & ' - $vPathSize = _ByteSuffix(FileGetSize($iPath))•./Include/_MyFunction.au3'
	$vPathSize = _ByteSuffix(FileGetSize($iPath))
	$__iLineNumber=521 & ' - $sRun = """ & $iScriptPath & "\Ressources\pngquant.exe" " &  ...•./Include/_MyFunction.au3'
	$sRun = '"' & $iScriptPath & '\Ressources\pngquant.exe" ' & $iParamater & ' "' & $iPath &'"'
	$__iLineNumber=522 & ' - _LOG("PNGQuant command: " & $sRun, 1, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG("PNGQuant command: " & $sRun, 1, $iLOGPath)
	$__iLineNumber=523 & ' - $iPid = Run($sRun, "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHI ...•./Include/_MyFunction.au3'
	$iPid = Run($sRun, '', @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	$__iLineNumber=524 & ' - While ProcessExists($iPid)•./Include/_MyFunction.au3'
	While ProcessExists($iPid)
		$__iLineNumber=525 & ' - $_StderrRead = StderrRead($iPid)•./Include/_MyFunction.au3'
		$_StderrRead = StderrRead($iPid)
		$__iLineNumber=526 & ' - If Not @error And $_StderrRead <> "" Then•./Include/_MyFunction.au3'
		If Not @error And $_StderrRead <> '' Then
			$__iLineNumber=527 & ' - If StringInStr($_StderrRead, "error") And Not StringInStr($_ ...•./Include/_MyFunction.au3'
			If StringInStr($_StderrRead, 'error') And Not StringInStr($_StderrRead, 'No errors') Then
				$__iLineNumber=528 & ' - _LOG("Error while optimizing " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG("Error while optimizing " & $iPath, 2, $iLOGPath)
				$__iLineNumber=529 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
		EndIf
	WEnd
	$__iLineNumber=533 & ' - $vPathSizeOptimized = _ByteSuffix(FileGetSize($iPath))•./Include/_MyFunction.au3'
	$vPathSizeOptimized = _ByteSuffix(FileGetSize($iPath))
	$__iLineNumber=534 & ' - _LOG("PNG Optimization (PNGQuant): " & $iPath & "(" & $vPath ...•./Include/_MyFunction.au3'
	_LOG("PNG Optimization (PNGQuant): " & $iPath & "(" & $vPathSize & " -> " & $vPathSizeOptimized & ")", 0, $iLOGPath)
	$__iLineNumber=535 & ' - Return $iPath•./Include/_MyFunction.au3'
	Return $iPath
EndFunc   ;==>_Compression

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
$__iLineNumber=551 & ' - Func _GDIPlus_RelativePos($iValue, $iValueMax)•./Include/_MyFunction.au3'
Func _GDIPlus_RelativePos($iValue, $iValueMax)
	$__iLineNumber=552 & ' - If StringLeft($iValue, 1) = "%" Then Return Int($iValueMax * ...•./Include/_MyFunction.au3'
	If StringLeft($iValue, 1) = '%' Then Return Int($iValueMax * StringTrimLeft($iValue, 1))
	$__iLineNumber=553 & ' - Return $iValue•./Include/_MyFunction.au3'
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
$__iLineNumber=571 & ' - Func _GDIPlus_ResizeMax($iPath, $iMAX_Width, $iMAX_Height)•./Include/_MyFunction.au3'
Func _GDIPlus_ResizeMax($iPath, $iMAX_Width, $iMAX_Height)
	$__iLineNumber=572 & ' - Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New, ...•./Include/_MyFunction.au3'
	Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New, $iRatio, $hImageResized
	$__iLineNumber=573 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp,  ...•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp, $iResized
	$__iLineNumber=574 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=575 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-RESIZE_Temp." ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-RESIZE_Temp." & $iExtension
	$__iLineNumber=576 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=577 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=578 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=579 & ' - $iWidth = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=580 & ' - If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas  ...•./Include/_MyFunction.au3'
	If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=581 & ' - $iHeight = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=582 & ' - $iRatio = $iHeight / $iWidth•./Include/_MyFunction.au3'
	$iRatio = $iHeight / $iWidth
	$__iLineNumber=583 & ' - If $iMAX_Width <= 0 And $iMAX_Height > 0 Then $iMAX_Width =  ...•./Include/_MyFunction.au3'
	If $iMAX_Width <= 0 And $iMAX_Height > 0 Then $iMAX_Width = $iMAX_Height / $iRatio
	$__iLineNumber=584 & ' - If $iMAX_Height <= 0 And $iMAX_Width > 0 Then $iMAX_Height = ...•./Include/_MyFunction.au3'
	If $iMAX_Height <= 0 And $iMAX_Width > 0 Then $iMAX_Height = $iMAX_Width * $iRatio
	$__iLineNumber=585 & ' - $iHeight_New = $iMAX_Height•./Include/_MyFunction.au3'
	$iHeight_New = $iMAX_Height
	$__iLineNumber=586 & ' - $iWidth_New = $iMAX_Height / $iRatio•./Include/_MyFunction.au3'
	$iWidth_New = $iMAX_Height / $iRatio
	$__iLineNumber=587 & ' - If $iWidth_New > $iMAX_Width Then•./Include/_MyFunction.au3'
	If $iWidth_New > $iMAX_Width Then
		$__iLineNumber=588 & ' - $iWidth_New = $iMAX_Width•./Include/_MyFunction.au3'
		$iWidth_New = $iMAX_Width
		$__iLineNumber=589 & ' - $iHeight_New = $iWidth_New * $iRatio•./Include/_MyFunction.au3'
		$iHeight_New = $iWidth_New * $iRatio
		$__iLineNumber=590 & ' - _LOG("$iWidth_New too BIG $iSize_New " & $iWidth_New  & " x  ...•./Include/_MyFunction.au3'
		_LOG("$iWidth_New too BIG $iSize_New " & $iWidth_New  & " x " & $iHeight_New  &"("&$iHeight_New/$iWidth_New&")", 2, $iLOGPath)
	EndIf
	$__iLineNumber=592 & ' - $iWidth_New = Int($iWidth_New)•./Include/_MyFunction.au3'
	$iWidth_New = Int($iWidth_New)
	$__iLineNumber=593 & ' - $iHeight_New = Int($iHeight_New)•./Include/_MyFunction.au3'
	$iHeight_New = Int($iHeight_New)
	$__iLineNumber=594 & ' - If $iWidth <> $iWidth_New Or $iHeight <> $iHeight_New Then•./Include/_MyFunction.au3'
	If $iWidth <> $iWidth_New Or $iHeight <> $iHeight_New Then
		$__iLineNumber=595 & ' - $iResized = 1•./Include/_MyFunction.au3'
		$iResized = 1
		$__iLineNumber=596 & ' - _LOG("Resize Max : " & $iPath, 0, $iLOGPath) ; Debug•./Include/_MyFunction.au3'
		_LOG("Resize Max : " & $iPath, 0, $iLOGPath) ; Debug
		$__iLineNumber=597 & ' - _LOG("Origine = " & $iWidth & "x" & $iHeight, 1, $iLOGPath)  ...•./Include/_MyFunction.au3'
		_LOG("Origine = " & $iWidth & "x" & $iHeight, 1, $iLOGPath) ; Debug
		$__iLineNumber=598 & ' - _LOG("Finale = " & $iWidth_New & "x" & $iHeight_New, 1, $iLO ...•./Include/_MyFunction.au3'
		_LOG("Finale = " & $iWidth_New & "x" & $iHeight_New, 1, $iLOGPath) ; Debug
	Else
		$__iLineNumber=600 & ' - $iResized = 0•./Include/_MyFunction.au3'
		$iResized = 0
		$__iLineNumber=601 & ' - _LOG("No Resizing : " & $iPath, 0, $iLOGPath) ; Debug•./Include/_MyFunction.au3'
		_LOG("No Resizing : " & $iPath, 0, $iLOGPath) ; Debug
		$__iLineNumber=602 & ' - _LOG("Origine = " & $iWidth & "x" & $iHeight, 1, $iLOGPath)  ...•./Include/_MyFunction.au3'
		_LOG("Origine = " & $iWidth & "x" & $iHeight, 1, $iLOGPath) ; Debug
		$__iLineNumber=603 & ' - _LOG("Finale = " & $iWidth_New & "x" & $iHeight_New, 1, $iLO ...•./Include/_MyFunction.au3'
		_LOG("Finale = " & $iWidth_New & "x" & $iHeight_New, 1, $iLOGPath) ; Debug
	EndIf
	$__iLineNumber=605 & ' - $hImageResized = _GDIPlus_ImageResize($hImage, $iWidth_New,  ...•./Include/_MyFunction.au3'
	$hImageResized = _GDIPlus_ImageResize($hImage, $iWidth_New, $iHeight_New)
	$__iLineNumber=606 & ' - _GDIPlus_ImageSaveToFile($hImageResized, $iPath)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hImageResized, $iPath)
	$__iLineNumber=607 & ' - _GDIPlus_ImageDispose($hImageResized)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImageResized)
	$__iLineNumber=608 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=609 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=610 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=611 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=612 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=614 & ' - Return $iResized•./Include/_MyFunction.au3'
	Return $iResized
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
$__iLineNumber=638 & ' - Func _GDIPlus_Rotation($iPath, $iRotation = 0)•./Include/_MyFunction.au3'
Func _GDIPlus_Rotation($iPath, $iRotation = 0)
	$__iLineNumber=639 & ' - Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New•./Include/_MyFunction.au3'
	Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New
	#forceref $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New
	$__iLineNumber=641 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=642 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=643 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-ROTATE_Temp." ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-ROTATE_Temp." & $iExtension
	$__iLineNumber=644 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=645 & ' - If $iRotation = "" Or $iRotation > 7 Then $iRotation = 0•./Include/_MyFunction.au3'
	If $iRotation = '' Or $iRotation > 7 Then $iRotation = 0
	$__iLineNumber=646 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=647 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=648 & ' - $iWidth = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=649 & ' - If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas  ...•./Include/_MyFunction.au3'
	If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=650 & ' - $iHeight = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=651 & ' - _GDIPlus_ImageRotateFlip($hImage, $iRotation)•./Include/_MyFunction.au3'
	_GDIPlus_ImageRotateFlip($hImage, $iRotation)
	$__iLineNumber=652 & ' - $iWidth_New = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$iWidth_New = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=653 & ' - If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas  ...•./Include/_MyFunction.au3'
	If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=654 & ' - $iHeight_New = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$iHeight_New = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=655 & ' - _LOG("ROTATION (" & $iRotation & ") : " & $iPath, 0, $iLOGPa ...•./Include/_MyFunction.au3'
	_LOG("ROTATION (" & $iRotation & ") : " & $iPath, 0, $iLOGPath) ; Debug
	$__iLineNumber=656 & ' - _GDIPlus_ImageSaveToFile($hImage, $iPath)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hImage, $iPath)
	$__iLineNumber=657 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=658 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=659 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=660 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=661 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=663 & ' - Return $iPath•./Include/_MyFunction.au3'
	Return $iPath
EndFunc   ;==>_GDIPlus_Rotation

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_Transparency
; Description ...: Apply transparency on a picture
; Syntax.........: _GDIPlus_Transparency($iPath, $iTransLvl)
; Parameters ....: $iPath		- Path to the picture
;                  $iTransLvl	- Transparency level
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
;; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=679 & ' - Func _GDIPlus_Transparency($iPath, $iTransLvl)•./Include/_MyFunction.au3'
Func _GDIPlus_Transparency($iPath, $iTransLvl)
;~ 	MsgBox(0,"DEBUG","_GDIPlus_Transparency");Debug
	$__iLineNumber=681 & ' - Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGU ...•./Include/_MyFunction.au3'
	Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	$__iLineNumber=682 & ' - Local $MergedImageBackgroundColor = 0x00000000•./Include/_MyFunction.au3'
	Local $MergedImageBackgroundColor = 0x00000000
	$__iLineNumber=683 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=684 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=685 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-TRANS_Temp.PN ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-TRANS_Temp.PNG"
	$__iLineNumber=686 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=687 & ' - $iPath = $sDrive & $sDir & $sFileName & ".png"•./Include/_MyFunction.au3'
	$iPath = $sDrive & $sDir & $sFileName & ".png"
	$__iLineNumber=688 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=689 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=690 & ' - $ImageWidth = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$ImageWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=691 & ' - If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 ...•./Include/_MyFunction.au3'
	If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=692 & ' - $ImageHeight = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$ImageHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=693 & ' - $hGui = GUICreate("", $ImageWidth, $ImageHeight)•./Include/_MyFunction.au3'
	$hGui = GUICreate("", $ImageWidth, $ImageHeight)
	$__iLineNumber=694 & ' - $hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw  ...•./Include/_MyFunction.au3'
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$__iLineNumber=695 & ' - $hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ ...•./Include/_MyFunction.au3'
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ImageHeight, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$__iLineNumber=696 & ' - $hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Dr ...•./Include/_MyFunction.au3'
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	$__iLineNumber=697 & ' - _GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColo ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor)
	$__iLineNumber=698 & ' - _GDIPlus_GraphicsDrawImageRectRectTrans($hGraphic, $hImage,  ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImageRectRectTrans($hGraphic, $hImage, 0, 0, "", "", "", "", "", "", 2, $iTransLvl)
	$__iLineNumber=699 & ' - _LOG("Transparency (" & $iTransLvl & ") : " & $iPath, 0, $iL ...•./Include/_MyFunction.au3'
	_LOG("Transparency (" & $iTransLvl & ") : " & $iPath, 0, $iLOGPath) ; Debug
	$__iLineNumber=700 & ' - _GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)
	$__iLineNumber=701 & ' - _GDIPlus_GraphicsDispose($hGraphic)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphic)
	$__iLineNumber=702 & ' - _GDIPlus_BitmapDispose($hBMPBuff)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hBMPBuff)
	$__iLineNumber=703 & ' - _WinAPI_DeleteObject($hBMPBuff)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hBMPBuff)
	$__iLineNumber=704 & ' - _GDIPlus_GraphicsDispose($hGraphicGUI)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	$__iLineNumber=705 & ' - GUIDelete($hGui)•./Include/_MyFunction.au3'
	GUIDelete($hGui)
	$__iLineNumber=706 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=707 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=708 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=709 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=710 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=712 & ' - Return $iPath•./Include/_MyFunction.au3'
	Return $iPath
EndFunc   ;==>_GDIPlus_Transparency

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_TransparencyZone
; Description ...: Apply transparency on a picture
; Syntax.........: _GDIPlus_TransparencyZone($iPath, $vTarget_Width, $vTarget_Height, $iTransLvl = 1, $iX = 0, $iY = 0, $iWidth = "", $iHeight = "")
; Parameters ....: $iPath			- Path to the picture
;                  $vTarget_Width	- Target Width
;                  $vTarget_Height	- Target Height
;                  $iTransLvl		- Value range from 0 (Zero for invisible) to 1.0 (fully opaque)
;                  $iX				- X position of the transparency zone
;                  $iY				- Y position of the transparency zone
;                  $iWidth			- Width of the transparency zone
;                  $iHeight			- Height of the transparency zone
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=735 & ' - Func _GDIPlus_TransparencyZone($iPath, $vTarget_Width, $vTar ...•./Include/_MyFunction.au3'
Func _GDIPlus_TransparencyZone($iPath, $vTarget_Width, $vTarget_Height, $iTransLvl = 1, $iX = 0, $iY = 0, $iWidth = "", $iHeight = "")
	#forceref $iX, $iY, $iWidth, $iHeight
	$__iLineNumber=737 & ' - Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGU ...•./Include/_MyFunction.au3'
	Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	$__iLineNumber=738 & ' - Local $MergedImageBackgroundColor = 0x00000000•./Include/_MyFunction.au3'
	Local $MergedImageBackgroundColor = 0x00000000
	$__iLineNumber=739 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=740 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=741 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-TRANSZONE_Tem ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-TRANSZONE_Temp.PNG"
	$__iLineNumber=742 & ' - $iPath_CutHole_Temp = $sDrive & $sDir & $sFileName & "-CutHo ...•./Include/_MyFunction.au3'
	$iPath_CutHole_Temp = $sDrive & $sDir & $sFileName & "-CutHole_Temp.PNG"
	$__iLineNumber=743 & ' - $iPath_Crop_Temp = $sDrive & $sDir & $sFileName & "-CutCrop_ ...•./Include/_MyFunction.au3'
	$iPath_Crop_Temp = $sDrive & $sDir & $sFileName & "-CutCrop_Temp.PNG"
	$__iLineNumber=744 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=745 & ' - $iPath = $sDrive & $sDir & $sFileName & ".png"•./Include/_MyFunction.au3'
	$iPath = $sDrive & $sDir & $sFileName & ".png"
	$__iLineNumber=746 & ' - _GDIPlus_CalcPos($iX, $iY, $iWidth, $iHeight, $vTarget_Width ...•./Include/_MyFunction.au3'
	_GDIPlus_CalcPos($iX, $iY, $iWidth, $iHeight, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=747 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=748 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=749 & ' - $hNew_CutHole = _GDIPlus_ImageCutRectHole($hImage, $iX, $iY, ...•./Include/_MyFunction.au3'
	$hNew_CutHole = _GDIPlus_ImageCutRectHole($hImage, $iX, $iY, $iWidth, $iHeight, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=750 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=751 & ' - _LOG("Error _GDIPlus_ImageCutRectHole " & $iPath_Temp, 2, $i ...•./Include/_MyFunction.au3'
		_LOG("Error _GDIPlus_ImageCutRectHole " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=752 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=754 & ' - $hNew_Crop = _GDIPlus_ImageCrop($hImage, $iX, $iY, $iWidth,  ...•./Include/_MyFunction.au3'
	$hNew_Crop = _GDIPlus_ImageCrop($hImage, $iX, $iY, $iWidth, $iHeight, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=755 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=756 & ' - _LOG("Error _GDIPlus_ImageCrop " & $iPath_Temp, 2, $iLOGPath ...•./Include/_MyFunction.au3'
		_LOG("Error _GDIPlus_ImageCrop " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=757 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=759 & ' - _GDIPlus_ImageSaveToFile($hNew_CutHole, $iPath_CutHole_Temp)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hNew_CutHole, $iPath_CutHole_Temp)
	$__iLineNumber=760 & ' - _GDIPlus_ImageSaveToFile($hNew_Crop, $iPath_Crop_Temp)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hNew_Crop, $iPath_Crop_Temp)
	$__iLineNumber=761 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=762 & ' - _GDIPlus_BitmapDispose($hNew_CutHole)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hNew_CutHole)
	$__iLineNumber=763 & ' - _GDIPlus_BitmapDispose($hNew_Crop)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hNew_Crop)
	$__iLineNumber=764 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=765 & ' - _GDIPlus_Transparency($iPath_Crop_Temp, $iTransLvl)•./Include/_MyFunction.au3'
	_GDIPlus_Transparency($iPath_Crop_Temp, $iTransLvl)
	$__iLineNumber=766 & ' - _GDIPlus_Merge($iPath_CutHole_Temp, $iPath_Crop_Temp)•./Include/_MyFunction.au3'
	_GDIPlus_Merge($iPath_CutHole_Temp, $iPath_Crop_Temp)
	$__iLineNumber=767 & ' - FileCopy($iPath_CutHole_Temp, $iPath)•./Include/_MyFunction.au3'
	FileCopy($iPath_CutHole_Temp, $iPath)
	$__iLineNumber=768 & ' - FileDelete($iPath_CutHole_Temp)•./Include/_MyFunction.au3'
	FileDelete($iPath_CutHole_Temp)
	$__iLineNumber=769 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=770 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=771 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=773 & ' - Return $iPath•./Include/_MyFunction.au3'
	Return $iPath
EndFunc   ;==>_GDIPlus_TransparencyZone

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_ImageCutRectHole
; Description ...: Cut a rectangle hole on a picture
; Syntax.........: _GDIPlus_ImageCutRectHole($hImage, $iX, $iY, $iWidthCut, $iHeightCut, $vTarget_Width, $vTarget_Height)
; Parameters ....: $hImage			- Handle to the picture
;                  $iX				- X position of the cut
;                  $iY				- Y position of the cut
;                  $iWidthCut		- Width of the cut
;                  $iHeightCut		- Height of the cut
;                  $vTarget_Width	- Target Width
;                  $vTarget_Height	- Target Height
; Return values .: Success      - Return Handle
;                  Failure      - -1
; Author ........: UEZ
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; https://www.autoitscript.com/forum/topic/146755-solvedlayer-mask-in-gdi/
; Example .......;
$__iLineNumber=795 & ' - Func _GDIPlus_ImageCutRectHole($hImage, $iX, $iY, $iWidthCut ...•./Include/_MyFunction.au3'
Func _GDIPlus_ImageCutRectHole($hImage, $iX, $iY, $iWidthCut, $iHeightCut, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=796 & ' - Local $hTexture = _GDIPlus_TextureCreate($hImage, 4)•./Include/_MyFunction.au3'
	Local $hTexture = _GDIPlus_TextureCreate($hImage, 4)
	$__iLineNumber=797 & ' - $hImage = _GDIPlus_BitmapCreateFromScan0($vTarget_Width, $vT ...•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_BitmapCreateFromScan0($vTarget_Width, $vTarget_Height)
	$__iLineNumber=798 & ' - Local $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hImage)•./Include/_MyFunction.au3'
	Local $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hImage)
	$__iLineNumber=799 & ' - _GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, 2)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, 2)
	$__iLineNumber=800 & ' - _GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, 2)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, 2)
	$__iLineNumber=801 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, 0, 0, $iX, $vTarget_Hei ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, 0, 0, $iX, $vTarget_Height, $hTexture)
	$__iLineNumber=802 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, $iX + $iWidthCut, 0, $v ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, $iX + $iWidthCut, 0, $vTarget_Width - ($iX + $iWidthCut), $vTarget_Height, $hTexture)
	$__iLineNumber=803 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, 0, $iWidthCut, $iY ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, 0, $iWidthCut, $iY, $hTexture)
	$__iLineNumber=804 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, $iY + $iHeightCut, ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, $iY + $iHeightCut, $iWidthCut, $vTarget_Height - ($iY + $iHeightCut), $hTexture)
	$__iLineNumber=805 & ' - _GDIPlus_BrushDispose($hTexture)•./Include/_MyFunction.au3'
	_GDIPlus_BrushDispose($hTexture)
	$__iLineNumber=806 & ' - _GDIPlus_GraphicsDispose($hGfxCtxt)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGfxCtxt)
	$__iLineNumber=807 & ' - Return $hImage•./Include/_MyFunction.au3'
	Return $hImage
EndFunc   ;==>_GDIPlus_ImageCutRectHole

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_ImageCrop
; Description ...: Crop a picture
; Syntax.........: _GDIPlus_ImageCrop($hImage, $iX, $iY, $iWidthCut, $iHeightCut, $vTarget_Width, $vTarget_Height)
; Parameters ....: $hImage			- Handle to the picture
;                  $iX				- X position of the crop
;                  $iY				- Y position of the crop
;                  $iWidthCut		- Width of the crop
;                  $iHeightCut		- Height of the crop
;                  $vTarget_Width	- Target Width
;                  $vTarget_Height	- Target Height
; Return values .: Success      - Return Handle
;                  Failure      - -1
; Author ........: UEZ
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; https://www.autoitscript.com/forum/topic/146755-solvedlayer-mask-in-gdi/
; Example .......;
$__iLineNumber=829 & ' - Func _GDIPlus_ImageCrop($hImage, $iX, $iY, $iWidthCut, $iHei ...•./Include/_MyFunction.au3'
Func _GDIPlus_ImageCrop($hImage, $iX, $iY, $iWidthCut, $iHeightCut, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=830 & ' - Local $hTexture = _GDIPlus_TextureCreate($hImage, 4)•./Include/_MyFunction.au3'
	Local $hTexture = _GDIPlus_TextureCreate($hImage, 4)
	$__iLineNumber=831 & ' - $hImage = _GDIPlus_BitmapCreateFromScan0($vTarget_Width, $vT ...•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_BitmapCreateFromScan0($vTarget_Width, $vTarget_Height)
	$__iLineNumber=832 & ' - Local $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hImage)•./Include/_MyFunction.au3'
	Local $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hImage)
	$__iLineNumber=833 & ' - _GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, 2)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, 2)
	$__iLineNumber=834 & ' - _GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, 2)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, 2)
	$__iLineNumber=835 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, $iY, $iWidthCut, $ ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, $iY, $iWidthCut, $iHeightCut, $hTexture)
	$__iLineNumber=836 & ' - _GDIPlus_BrushDispose($hTexture)•./Include/_MyFunction.au3'
	_GDIPlus_BrushDispose($hTexture)
	$__iLineNumber=837 & ' - _GDIPlus_GraphicsDispose($hGfxCtxt)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGfxCtxt)
	$__iLineNumber=838 & ' - Return $hImage•./Include/_MyFunction.au3'
	Return $hImage
EndFunc   ;==>_GDIPlus_ImageCrop

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_CalcPos
; Description ...: Calculate Relative and tagged position and size
; Syntax.........: _GDIPlus_CalcPos(ByRef $iX, ByRef $iY, ByRef $iWidth, ByRef $iHeight, $vTarget_Width, $vTarget_Height)
; Parameters ....: $iX				- X position to calculate
;                  $iY				- Y position to calculate
;                  $iWidth			- Width
;                  $iHeight			- Height
;                  $vTarget_Width	- Target Width
;                  $vTarget_Height	- Target Height
; Return values .: Success      - Return position and size ByRef
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
$__iLineNumber=858 & ' - Func _GDIPlus_CalcPos(ByRef $iX, ByRef $iY, ByRef $iWidth, B ...•./Include/_MyFunction.au3'
Func _GDIPlus_CalcPos(ByRef $iX, ByRef $iY, ByRef $iWidth, ByRef $iHeight, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=859 & ' - $iWidth = _GDIPlus_RelativePos($iWidth, $vTarget_Width)•./Include/_MyFunction.au3'
	$iWidth = _GDIPlus_RelativePos($iWidth, $vTarget_Width)
	$__iLineNumber=860 & ' - If $iWidth = "" Then $iWidth = $vTarget_Width•./Include/_MyFunction.au3'
	If $iWidth = "" Then $iWidth = $vTarget_Width
	$__iLineNumber=861 & ' - $iHeight = _GDIPlus_RelativePos($iHeight, $vTarget_Height)•./Include/_MyFunction.au3'
	$iHeight = _GDIPlus_RelativePos($iHeight, $vTarget_Height)
	$__iLineNumber=862 & ' - If $iHeight = "" Then $iHeight = $vTarget_Height•./Include/_MyFunction.au3'
	If $iHeight = "" Then $iHeight = $vTarget_Height
	$__iLineNumber=863 & ' - $iX = _GDIPlus_CalcPosX($iX, $iWidth, $vTarget_Width)•./Include/_MyFunction.au3'
	$iX = _GDIPlus_CalcPosX($iX, $iWidth, $vTarget_Width)
	$__iLineNumber=864 & ' - $iY = _GDIPlus_CalcPosY($iY, $iHeight, $vTarget_Height)•./Include/_MyFunction.au3'
	$iY = _GDIPlus_CalcPosY($iY, $iHeight, $vTarget_Height)
EndFunc   ;==>_GDIPlus_CalcPos

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_CalcPosX
; Description ...: Calculate Relative and tagged X position
; Syntax.........: _GDIPlus_CalcPosX($iX, $iWidth, $vTarget_Width)
; Parameters ....: $iX				- X position to calculate
;                  $iWidth			- Width
;                  $vTarget_Width	- Target Width
; Return values .: Success      - Return $iX
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
$__iLineNumber=881 & ' - Func _GDIPlus_CalcPosX($iX, $iWidth, $vTarget_Width)•./Include/_MyFunction.au3'
Func _GDIPlus_CalcPosX($iX, $iWidth, $vTarget_Width)
	$__iLineNumber=882 & ' - $iX = _GDIPlus_RelativePos($iX, $vTarget_Width)•./Include/_MyFunction.au3'
	$iX = _GDIPlus_RelativePos($iX, $vTarget_Width)
	$__iLineNumber=883 & ' - Switch $iX•./Include/_MyFunction.au3'
	$__iLineNumber=884 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $iX
		Case 'CENTER'
			$__iLineNumber=885 & ' - $iX = ($vTarget_Width / 2) - ($iWidth / 2)•./Include/_MyFunction.au3'
			$iX = ($vTarget_Width / 2) - ($iWidth / 2)
		$__iLineNumber=886 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=887 & ' - $iX = 0•./Include/_MyFunction.au3'
			$iX = 0
		$__iLineNumber=888 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=889 & ' - $iX = $vTarget_Width - $iWidth•./Include/_MyFunction.au3'
			$iX = $vTarget_Width - $iWidth
	EndSwitch
	$__iLineNumber=891 & ' - Return Int($iX)•./Include/_MyFunction.au3'
	Return Int($iX)
EndFunc   ;==>_GDIPlus_CalcPosX

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_CalcPosY
; Description ...: Calculate Relative and tagged X position
; Syntax.........: _GDIPlus_CalcPosY($iY, $iHeight, $vTarget_Height)
; Parameters ....: $iY				- Y position to calculate
;                  $iHeight			- Height
;                  $vTarget_Height	- Target Height
; Return values .: Success      - Return $iY
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
$__iLineNumber=908 & ' - Func _GDIPlus_CalcPosY($iY, $iHeight, $vTarget_Height)•./Include/_MyFunction.au3'
Func _GDIPlus_CalcPosY($iY, $iHeight, $vTarget_Height)
	$__iLineNumber=909 & ' - $iY = _GDIPlus_RelativePos($iY, $vTarget_Height)•./Include/_MyFunction.au3'
	$iY = _GDIPlus_RelativePos($iY, $vTarget_Height)
	$__iLineNumber=910 & ' - Switch $iY•./Include/_MyFunction.au3'
	$__iLineNumber=911 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $iY
		Case 'CENTER'
			$__iLineNumber=912 & ' - $iY = ($vTarget_Height / 2) - ($iHeight / 2)•./Include/_MyFunction.au3'
			$iY = ($vTarget_Height / 2) - ($iHeight / 2)
		$__iLineNumber=913 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=914 & ' - $iY = 0•./Include/_MyFunction.au3'
			$iY = 0
		$__iLineNumber=915 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=916 & ' - $iY = $vTarget_Height - $iHeight•./Include/_MyFunction.au3'
			$iY = $vTarget_Height - $iHeight
	EndSwitch
	$__iLineNumber=918 & ' - Return Int($iY)•./Include/_MyFunction.au3'
	Return Int($iY)
EndFunc   ;==>_GDIPlus_CalcPosY

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_Merge($iPath1, $iPath2)
; Description ...: Merge 2 pictures
; Syntax.........: _GDIPlus_Merge($iPath1, $iPath2)
; Parameters ....: $iPath1		- First image path
;                  $iPath1		- Second image path
; Return values .: Success      - Return the path of the finale picture
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......: Delete $iPath2 after merging
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=935 & ' - Func _GDIPlus_Merge($iPath1, $iPath2)•./Include/_MyFunction.au3'
Func _GDIPlus_Merge($iPath1, $iPath2)
;~ 	MsgBox(0,"DEBUG","_GDIPlus_Merge");Debug
	$__iLineNumber=937 & ' - Local $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic, $ImageWidth ...•./Include/_MyFunction.au3'
	Local $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic, $ImageWidth, $ImageHeight
	$__iLineNumber=938 & ' - Local $MergedImageBackgroundColor = 0x00000000•./Include/_MyFunction.au3'
	Local $MergedImageBackgroundColor = 0x00000000
	$__iLineNumber=939 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=940 & ' - _PathSplit($iPath1, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath1, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=941 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-MER_Temp.PNG"•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-MER_Temp.PNG"

	$__iLineNumber=943 & ' - If _MakeTEMPFile($iPath1, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath1, $iPath_Temp) = -1 Then Return -1

	$__iLineNumber=945 & ' - $iPath1 = $sDrive & $sDir & $sFileName & ".png"•./Include/_MyFunction.au3'
	$iPath1 = $sDrive & $sDir & $sFileName & ".png"

	$__iLineNumber=947 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=948 & ' - $hImage1 = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage1 = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=949 & ' - $hImage2 = _GDIPlus_ImageLoadFromFile($iPath2)•./Include/_MyFunction.au3'
	$hImage2 = _GDIPlus_ImageLoadFromFile($iPath2)
	$__iLineNumber=950 & ' - $ImageWidth = _GDIPlus_ImageGetWidth($hImage1)•./Include/_MyFunction.au3'
	$ImageWidth = _GDIPlus_ImageGetWidth($hImage1)
	$__iLineNumber=951 & ' - If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 ...•./Include/_MyFunction.au3'
	If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=952 & ' - $ImageHeight = _GDIPlus_ImageGetHeight($hImage1)•./Include/_MyFunction.au3'
	$ImageHeight = _GDIPlus_ImageGetHeight($hImage1)
	$__iLineNumber=953 & ' - $hGui = GUICreate("", $ImageWidth, $ImageHeight)•./Include/_MyFunction.au3'
	$hGui = GUICreate("", $ImageWidth, $ImageHeight)
	$__iLineNumber=954 & ' - $hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw  ...•./Include/_MyFunction.au3'
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$__iLineNumber=955 & ' - $hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ ...•./Include/_MyFunction.au3'
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ImageHeight, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$__iLineNumber=956 & ' - $hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Dr ...•./Include/_MyFunction.au3'
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	$__iLineNumber=957 & ' - _GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColo ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor) ;Fill the Graphic Background (0x00000000 for transparent background in .png files)
	$__iLineNumber=958 & ' - _GDIPlus_GraphicsDrawImage($hGraphic, $hImage1, 0, 0)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage1, 0, 0)
	$__iLineNumber=959 & ' - _GDIPlus_GraphicsDrawImage($hGraphic, $hImage2, 0, 0)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage2, 0, 0)

	$__iLineNumber=961 & ' - _LOG("Merging " & $iPath2 & " on " & $iPath_Temp, 0, $iLOGPa ...•./Include/_MyFunction.au3'
	_LOG("Merging " & $iPath2 & " on " & $iPath_Temp, 0, $iLOGPath) ; Debug
	$__iLineNumber=962 & ' - _GDIPlus_ImageSaveToFile($hBMPBuff, $iPath1)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hBMPBuff, $iPath1)

	$__iLineNumber=964 & ' - _GDIPlus_GraphicsDispose($hGraphic)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphic)
	$__iLineNumber=965 & ' - _GDIPlus_BitmapDispose($hBMPBuff)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hBMPBuff)
	$__iLineNumber=966 & ' - _WinAPI_DeleteObject($hBMPBuff)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hBMPBuff)
	$__iLineNumber=967 & ' - _GDIPlus_GraphicsDispose($hGraphicGUI)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	$__iLineNumber=968 & ' - GUIDelete($hGui)•./Include/_MyFunction.au3'
	GUIDelete($hGui)
	$__iLineNumber=969 & ' - _GDIPlus_ImageDispose($hImage2)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage2)
	$__iLineNumber=970 & ' - _GDIPlus_ImageDispose($hImage1)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage1)
	$__iLineNumber=971 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=972 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=973 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=974 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=976 & ' - If Not FileDelete($iPath2) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath2) Then
		$__iLineNumber=977 & ' - _LOG("Error deleting " & $iPath2, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath2, 2, $iLOGPath)
		$__iLineNumber=978 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=980 & ' - Return $iPath1•./Include/_MyFunction.au3'
	Return $iPath1
EndFunc   ;==>_GDIPlus_Merge

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
$__iLineNumber=1008 & ' - Func _GDIPlus_GraphicsDrawImageRectRectTrans($hGraphics, $hI ...•./Include/_MyFunction.au3'
Func _GDIPlus_GraphicsDrawImageRectRectTrans($hGraphics, $hImage, $iSrcX, $iSrcY, $iSrcWidth = "", $iSrcHeight = "", _
		$iDstX = "", $iDstY = "", $iDstWidth = "", $iDstHeight = "", $iUnit = 2, $nTrans = 1)
	$__iLineNumber=1010 & ' - Local $tColorMatrix, $hImgAttrib, $iW = _GDIPlus_ImageGetWid ...•./Include/_MyFunction.au3'
	Local $tColorMatrix, $hImgAttrib, $iW = _GDIPlus_ImageGetWidth($hImage), $iH = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=1011 & ' - If $iSrcWidth = 0 Or $iSrcWidth = "" Then $iSrcWidth = $iW•./Include/_MyFunction.au3'
	If $iSrcWidth = 0 Or $iSrcWidth = "" Then $iSrcWidth = $iW
	$__iLineNumber=1012 & ' - If $iSrcHeight = 0 Or $iSrcHeight = "" Then $iSrcHeight = $i ...•./Include/_MyFunction.au3'
	If $iSrcHeight = 0 Or $iSrcHeight = "" Then $iSrcHeight = $iH
	$__iLineNumber=1013 & ' - If $iDstX = "" Then $iDstX = $iSrcX•./Include/_MyFunction.au3'
	If $iDstX = "" Then $iDstX = $iSrcX
	$__iLineNumber=1014 & ' - If $iDstY = "" Then $iDstY = $iSrcY•./Include/_MyFunction.au3'
	If $iDstY = "" Then $iDstY = $iSrcY
	$__iLineNumber=1015 & ' - If $iDstWidth = "" Then $iDstWidth = $iSrcWidth•./Include/_MyFunction.au3'
	If $iDstWidth = "" Then $iDstWidth = $iSrcWidth
	$__iLineNumber=1016 & ' - If $iDstHeight = "" Then $iDstHeight = $iSrcHeight•./Include/_MyFunction.au3'
	If $iDstHeight = "" Then $iDstHeight = $iSrcHeight
	$__iLineNumber=1017 & ' - If $iUnit = "" Then $iUnit = 2•./Include/_MyFunction.au3'
	If $iUnit = "" Then $iUnit = 2
	;;create color matrix data
	$__iLineNumber=1019 & ' - $tColorMatrix = DllStructCreate("float[5];float[5];float[5]; ...•./Include/_MyFunction.au3'
	$tColorMatrix = DllStructCreate("float[5];float[5];float[5];float[5];float[5]")
	;blending values:
	$__iLineNumber=1021 & ' - Local $x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStr ...•./Include/_MyFunction.au3'
	Local $x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStructSetData($tColorMatrix, 2, 1, 2) * DllStructSetData($tColorMatrix, 3, 1, 3) * _
			DllStructSetData($tColorMatrix, 4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 1, 5)
;~ 	$x = $x
	;;create an image attributes object and update its color matrix
	$__iLineNumber=1025 & ' - $hImgAttrib = _GDIPlus_ImageAttributesCreate()•./Include/_MyFunction.au3'
	$hImgAttrib = _GDIPlus_ImageAttributesCreate()
	$__iLineNumber=1026 & ' - _GDIPlus_ImageAttributesSetColorMatrix($hImgAttrib, 1, 1, Dl ...•./Include/_MyFunction.au3'
	_GDIPlus_ImageAttributesSetColorMatrix($hImgAttrib, 1, 1, DllStructGetPtr($tColorMatrix))
	$__iLineNumber=1027 & ' - _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $iSr ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $iSrcX, $iSrcY, $iSrcWidth, $iSrcHeight, $iDstX, $iDstY, $iDstWidth, $iDstHeight, $hImgAttrib, $iUnit)
	;;clean up
	$__iLineNumber=1029 & ' - _GDIPlus_ImageAttributesDispose($hImgAttrib)•./Include/_MyFunction.au3'
	_GDIPlus_ImageAttributesDispose($hImgAttrib)
	$__iLineNumber=1030 & ' - Return•./Include/_MyFunction.au3'
	Return
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectRectTrans

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_Imaging
; Description ...: Prepare a picture
; Syntax.........: _GDIPlus_Imaging($iPath, $aPicParameters, $vTarget_Width, $vTarget_Height, $vTarget_Maximize = 'no')
; Parameters ....: $iPath			- Path to the picture
;                  $aPicParameters	- Position Parameter
;                  $vTarget_Width	- Target Width
;                  $vTarget_Height	- Target Height
;                  $vTarget_Maximize- Maximize the picture (yes or no)
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......: 	$aPicParameters[0] = Target_Width
; 					$aPicParameters[1] = Target_Height
;				 	$aPicParameters[2] = Target_TopLeftX
;				 	$aPicParameters[3] = Target_TopLeftY
;				 	$aPicParameters[4] = Target_TopRightX
;				 	$aPicParameters[5] = Target_TopRightY
;				 	$aPicParameters[6] = Target_BottomLeftX
;				 	$aPicParameters[7] = Target_BottomLeftY
;				 	$aPicParameters[8] = Target_Maximize
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1058 & ' - Func _GDIPlus_Imaging($iPath, $aPicParameters, $vTarget_Widt ...•./Include/_MyFunction.au3'
Func _GDIPlus_Imaging($iPath, $aPicParameters, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1059 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=1060 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=1061 & ' - $aPicParameters[8] = StringUpper($aPicParameters[8])•./Include/_MyFunction.au3'
	$aPicParameters[8] = StringUpper($aPicParameters[8])
	$__iLineNumber=1062 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-IMAGING_Temp" ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-IMAGING_Temp" & $iExtension
	$__iLineNumber=1063 & ' - Local $hImage, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic•./Include/_MyFunction.au3'
	Local $hImage, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	$__iLineNumber=1064 & ' - Local $MergedImageBackgroundColor = 0x00000000•./Include/_MyFunction.au3'
	Local $MergedImageBackgroundColor = 0x00000000
	$__iLineNumber=1065 & ' - Local $iWidth = _GDIPlus_RelativePos($aPicParameters[0], $vT ...•./Include/_MyFunction.au3'
	Local $iWidth = _GDIPlus_RelativePos($aPicParameters[0], $vTarget_Width)
	$__iLineNumber=1066 & ' - Local $iHeight = _GDIPlus_RelativePos($aPicParameters[1], $v ...•./Include/_MyFunction.au3'
	Local $iHeight = _GDIPlus_RelativePos($aPicParameters[1], $vTarget_Height)
	$__iLineNumber=1067 & ' - If $aPicParameters[8] = "YES" Then _GDIPlus_ResizeMax($iPath ...•./Include/_MyFunction.au3'
	If $aPicParameters[8] = 'YES' Then _GDIPlus_ResizeMax($iPath, $iWidth, $iHeight)
	$__iLineNumber=1068 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=1069 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=1070 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=1071 & ' - If $iWidth <= 0 Or $aPicParameters[8] = "YES" Then $iWidth = ...•./Include/_MyFunction.au3'
	If $iWidth <= 0 Or $aPicParameters[8] = 'YES' Then $iWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=1072 & ' - If $iHeight <= 0 Or $aPicParameters[8] = "YES" Then $iHeight ...•./Include/_MyFunction.au3'
	If $iHeight <= 0 Or $aPicParameters[8] = 'YES' Then $iHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=1073 & ' - $hGui = GUICreate("", $vTarget_Width, $vTarget_Height)•./Include/_MyFunction.au3'
	$hGui = GUICreate("", $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1074 & ' - $hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw  ...•./Include/_MyFunction.au3'
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$__iLineNumber=1075 & ' - $hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($vTarget_Width ...•./Include/_MyFunction.au3'
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($vTarget_Width, $vTarget_Height, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$__iLineNumber=1076 & ' - $hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Dr ...•./Include/_MyFunction.au3'
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	$__iLineNumber=1077 & ' - _GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColo ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor) ; Fill the Graphic Background (0x00000000 for transparent background in .png files)
	$__iLineNumber=1078 & ' - Local $Image_C1X = _GDIPlus_CalcPosX($aPicParameters[2], $iW ...•./Include/_MyFunction.au3'
	Local $Image_C1X = _GDIPlus_CalcPosX($aPicParameters[2], $iWidth, $vTarget_Width)
	$__iLineNumber=1079 & ' - Local $Image_C1Y = _GDIPlus_CalcPosY($aPicParameters[3], $iH ...•./Include/_MyFunction.au3'
	Local $Image_C1Y = _GDIPlus_CalcPosY($aPicParameters[3], $iHeight, $vTarget_Height)
	$__iLineNumber=1080 & ' - Local $Image_C2X = _GDIPlus_RelativePos($aPicParameters[4],  ...•./Include/_MyFunction.au3'
	Local $Image_C2X = _GDIPlus_RelativePos($aPicParameters[4], $vTarget_Width)
	$__iLineNumber=1081 & ' - Local $Image_C2Y = _GDIPlus_RelativePos($aPicParameters[5],  ...•./Include/_MyFunction.au3'
	Local $Image_C2Y = _GDIPlus_RelativePos($aPicParameters[5], $vTarget_Height)
	$__iLineNumber=1082 & ' - Local $Image_C3X = _GDIPlus_RelativePos($aPicParameters[6],  ...•./Include/_MyFunction.au3'
	Local $Image_C3X = _GDIPlus_RelativePos($aPicParameters[6], $vTarget_Width)
	$__iLineNumber=1083 & ' - Local $Image_C3Y = _GDIPlus_RelativePos($aPicParameters[7],  ...•./Include/_MyFunction.au3'
	Local $Image_C3Y = _GDIPlus_RelativePos($aPicParameters[7], $vTarget_Height)
	$__iLineNumber=1084 & ' - Switch $Image_C2X•./Include/_MyFunction.au3'
	$__iLineNumber=1085 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C2X
		Case 'CENTER'
			$__iLineNumber=1086 & ' - $Image_C2X = Int(($vTarget_Width / 2) + ($iWidth / 2))•./Include/_MyFunction.au3'
			$Image_C2X = Int(($vTarget_Width / 2) + ($iWidth / 2))
		$__iLineNumber=1087 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1088 & ' - $Image_C2X = $iWidth•./Include/_MyFunction.au3'
			$Image_C2X = $iWidth
		$__iLineNumber=1089 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1090 & ' - $Image_C2X = $vTarget_Width•./Include/_MyFunction.au3'
			$Image_C2X = $vTarget_Width
		$__iLineNumber=1091 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1092 & ' - $Image_C2X = $Image_C1X + $iWidth•./Include/_MyFunction.au3'
			$Image_C2X = $Image_C1X + $iWidth
	EndSwitch
	$__iLineNumber=1094 & ' - Switch $Image_C2Y•./Include/_MyFunction.au3'
	$__iLineNumber=1095 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C2Y
		Case 'CENTER'
			$__iLineNumber=1096 & ' - $Image_C2Y = Int(($vTarget_Height / 2) - ($iHeight / 2))•./Include/_MyFunction.au3'
			$Image_C2Y = Int(($vTarget_Height / 2) - ($iHeight / 2))
		$__iLineNumber=1097 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1098 & ' - $Image_C2Y = 0•./Include/_MyFunction.au3'
			$Image_C2Y = 0
		$__iLineNumber=1099 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1100 & ' - $Image_C2Y = $vTarget_Height - $iHeight•./Include/_MyFunction.au3'
			$Image_C2Y = $vTarget_Height - $iHeight
		$__iLineNumber=1101 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1102 & ' - $Image_C2Y = $Image_C1Y•./Include/_MyFunction.au3'
			$Image_C2Y = $Image_C1Y
	EndSwitch
	$__iLineNumber=1104 & ' - Switch $Image_C3X•./Include/_MyFunction.au3'
	$__iLineNumber=1105 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C3X
		Case 'CENTER'
			$__iLineNumber=1106 & ' - $Image_C3X = Int(($vTarget_Width / 2) - ($iWidth / 2))•./Include/_MyFunction.au3'
			$Image_C3X = Int(($vTarget_Width / 2) - ($iWidth / 2))
		$__iLineNumber=1107 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1108 & ' - $Image_C3X = 0•./Include/_MyFunction.au3'
			$Image_C3X = 0
		$__iLineNumber=1109 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1110 & ' - $Image_C3X = $vTarget_Width - $iWidth•./Include/_MyFunction.au3'
			$Image_C3X = $vTarget_Width - $iWidth
		$__iLineNumber=1111 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1112 & ' - $Image_C3X = $Image_C1X•./Include/_MyFunction.au3'
			$Image_C3X = $Image_C1X
	EndSwitch
	$__iLineNumber=1114 & ' - Switch $Image_C3Y•./Include/_MyFunction.au3'
	$__iLineNumber=1115 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C3Y
		Case 'CENTER'
			$__iLineNumber=1116 & ' - $Image_C3Y = Int(($vTarget_Height / 2) + ($iHeight / 2))•./Include/_MyFunction.au3'
			$Image_C3Y = Int(($vTarget_Height / 2) + ($iHeight / 2))
		$__iLineNumber=1117 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1118 & ' - $Image_C3Y = 0 + $iHeight•./Include/_MyFunction.au3'
			$Image_C3Y = 0 + $iHeight
		$__iLineNumber=1119 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1120 & ' - $Image_C3Y = $vTarget_Height•./Include/_MyFunction.au3'
			$Image_C3Y = $vTarget_Height
		$__iLineNumber=1121 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1122 & ' - $Image_C3Y = $Image_C1Y + $iHeight•./Include/_MyFunction.au3'
			$Image_C3Y = $Image_C1Y + $iHeight
	EndSwitch

	$__iLineNumber=1125 & ' - $Image_C1X = $Image_C1X + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C1X = $Image_C1X + _GDIPlus_RelativePos($aPicParameters[9], $vTarget_Width)
	$__iLineNumber=1126 & ' - $Image_C1Y = $Image_C1Y + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C1Y = $Image_C1Y + _GDIPlus_RelativePos($aPicParameters[10], $vTarget_Width)
	$__iLineNumber=1127 & ' - $Image_C2X = $Image_C2X + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C2X = $Image_C2X + _GDIPlus_RelativePos($aPicParameters[9], $vTarget_Width)
	$__iLineNumber=1128 & ' - $Image_C2Y = $Image_C2Y + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C2Y = $Image_C2Y + _GDIPlus_RelativePos($aPicParameters[10], $vTarget_Width)
	$__iLineNumber=1129 & ' - $Image_C3X = $Image_C3X + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C3X = $Image_C3X + _GDIPlus_RelativePos($aPicParameters[9], $vTarget_Width)
	$__iLineNumber=1130 & ' - $Image_C3Y = $Image_C3Y + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C3Y = $Image_C3Y + _GDIPlus_RelativePos($aPicParameters[10], $vTarget_Width)

	$__iLineNumber=1132 & ' - _GDIPlus_DrawImagePoints($hGraphic, $hImage, $Image_C1X, $Im ...•./Include/_MyFunction.au3'
	_GDIPlus_DrawImagePoints($hGraphic, $hImage, $Image_C1X, $Image_C1Y, $Image_C2X, $Image_C2Y, $Image_C3X, $Image_C3Y)
	$__iLineNumber=1133 & ' - _GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)
	$__iLineNumber=1134 & ' - _GDIPlus_GraphicsDispose($hGraphic)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphic)
	$__iLineNumber=1135 & ' - _GDIPlus_BitmapDispose($hBMPBuff)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hBMPBuff)
	$__iLineNumber=1136 & ' - _WinAPI_DeleteObject($hBMPBuff)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hBMPBuff)
	$__iLineNumber=1137 & ' - _GDIPlus_GraphicsDispose($hGraphicGUI)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	$__iLineNumber=1138 & ' - GUIDelete($hGui)•./Include/_MyFunction.au3'
	GUIDelete($hGui)
	$__iLineNumber=1139 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=1140 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=1141 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=1142 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=1143 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1145 & ' - Return $iPath•./Include/_MyFunction.au3'
	Return $iPath
EndFunc   ;==>_GDIPlus_Imaging
#EndRegion GDI Function

#Region XML Function

; #FUNCTION# ===================================================================================================
; Name...........: _XML_Open
; Description ...: Open an XML Object
; Syntax.........: _XML_Open($iXMLPath)
; Parameters ....: $iXMLPath	- Path to the XML File
; Return values .: Success      - Object contening the XML File
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1164 & ' - Func _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
Func _XML_Open($iXMLPath)
	$__iLineNumber=1165 & ' - Local $oXMLDoc = _XML_CreateDOMDocument()•./Include/_MyFunction.au3'
	Local $oXMLDoc = _XML_CreateDOMDocument()
	$__iLineNumber=1166 & ' - _XML_Load($oXMLDoc, $iXMLPath)•./Include/_MyFunction.au3'
	_XML_Load($oXMLDoc, $iXMLPath)
	$__iLineNumber=1167 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1168 & ' - _LOG("_XML_Load @error:" & @CRLF & XML_My_ErrorParser(@error ...•./Include/_MyFunction.au3'
		_LOG('_XML_Load @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
		$__iLineNumber=1169 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1171 & ' - _XML_TIDY($oXMLDoc)•./Include/_MyFunction.au3'
	_XML_TIDY($oXMLDoc)
	$__iLineNumber=1172 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1173 & ' - _LOG("_XML_TIDY @error:" & @CRLF & XML_My_ErrorParser(@error ...•./Include/_MyFunction.au3'
		_LOG('_XML_TIDY @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
		$__iLineNumber=1174 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1176 & ' - _LOG($iXMLPath & " Open", 3, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG($iXMLPath & " Open", 3, $iLOGPath)
	$__iLineNumber=1177 & ' - Return $oXMLDoc•./Include/_MyFunction.au3'
	Return $oXMLDoc
EndFunc   ;==>_XML_Open

; #FUNCTION# ===================================================================================================
; Name...........: _XML_Read
; Description ...: Read Data in XML File or XML Object
; Syntax.........: _XML_Read($iXpath, [$iXMLType=0], [$iXMLPath=""], [$oXMLDoc=""])
; Parameters ....: $iXpath		- Xpath to the value to read
;                  $iXMLType	- Type of Value (0 = Node Value, 1 = Attribute Value)
;                  $iXMLPath	- Path to the XML File
;                  $oXMLDoc		- Object contening the XML File
; Return values .: Success      - First Value
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1196 & ' - Func _XML_Read($iXpath, $iXMLType = 0, $iXMLPath = "", $oXML ...•./Include/_MyFunction.au3'
Func _XML_Read($iXpath, $iXMLType = 0, $iXMLPath = "", $oXMLDoc = "")
	$__iLineNumber=1197 & ' - Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeN ...•./Include/_MyFunction.au3'
	Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeName
	$__iLineNumber=1198 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=1199 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1200 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1201 & ' - If $oXMLDoc = -1 Then•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then
			$__iLineNumber=1202 & ' - _LOG("_XML_Open ERROR (" & $iXpath & ")", 2, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG('_XML_Open ERROR (' & $iXpath & ')', 2, $iLOGPath)
			$__iLineNumber=1203 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		EndIf
	EndIf

	$__iLineNumber=1207 & ' - Switch $iXMLType•./Include/_MyFunction.au3'
	$__iLineNumber=1208 & ' - Case 0•./Include/_MyFunction.au3'
	Switch $iXMLType
		Case 0
			$__iLineNumber=1209 & ' - $iXMLValue = _XML_GetValue($oXMLDoc, $iXpath)•./Include/_MyFunction.au3'
			$iXMLValue = _XML_GetValue($oXMLDoc, $iXpath)
			$__iLineNumber=1210 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1211 & ' - If @error = 21 Then Return ""•./Include/_MyFunction.au3'
				If @error = 21 Then Return ""
				$__iLineNumber=1212 & ' - _LOG("_XML_GetValue ERROR (" & $iXpath & ")", 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG('_XML_GetValue ERROR (' & $iXpath & ')', 2, $iLOGPath)
				$__iLineNumber=1213 & ' - _LOG("_XML_GetValue @error(" & @error & ") :" & @CRLF & XML_ ...•./Include/_MyFunction.au3'
				_LOG('_XML_GetValue @error(' & @error & ') :' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
				$__iLineNumber=1214 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1216 & ' - If IsArray($iXMLValue) And UBound($iXMLValue) - 1 > 0 Then•./Include/_MyFunction.au3'
			If IsArray($iXMLValue) And UBound($iXMLValue) - 1 > 0 Then
				$__iLineNumber=1217 & ' - Return $iXMLValue[1]•./Include/_MyFunction.au3'
				Return $iXMLValue[1]
			Else
				$__iLineNumber=1219 & ' - _LOG("_XML_GetValue (" & $iXpath & ") is not an Array", 2, $ ...•./Include/_MyFunction.au3'
				_LOG('_XML_GetValue (' & $iXpath & ') is not an Array', 2, $iLOGPath)
				$__iLineNumber=1220 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
		$__iLineNumber=1222 & ' - Case 1•./Include/_MyFunction.au3'
		Case 1
			$__iLineNumber=1223 & ' - $iXpathSplit = StringSplit($iXpath, "/")•./Include/_MyFunction.au3'
			$iXpathSplit = StringSplit($iXpath, "/")
			$__iLineNumber=1224 & ' - $iXMLAttributeName = $iXpathSplit[UBound($iXpathSplit) - 1]•./Include/_MyFunction.au3'
			$iXMLAttributeName = $iXpathSplit[UBound($iXpathSplit) - 1]
			$__iLineNumber=1225 & ' - $iXpath = StringTrimRight($iXpath, StringLen($iXMLAttributeN ...•./Include/_MyFunction.au3'
			$iXpath = StringTrimRight($iXpath, StringLen($iXMLAttributeName) + 1)
			$__iLineNumber=1226 & ' - $oNode = _XML_SelectSingleNode($oXMLDoc, $iXpath)•./Include/_MyFunction.au3'
			$oNode = _XML_SelectSingleNode($oXMLDoc, $iXpath)
			$__iLineNumber=1227 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1228 & ' - _LOG("_XML_SelectSingleNode ERROR (" & $iXpath & ")", 2, $iL ...•./Include/_MyFunction.au3'
				_LOG('_XML_SelectSingleNode ERROR (' & $iXpath & ')', 2, $iLOGPath)
				$__iLineNumber=1229 & ' - _LOG("_XML_SelectSingleNode @error:" & @CRLF & XML_My_ErrorP ...•./Include/_MyFunction.au3'
				_LOG('_XML_SelectSingleNode @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
				$__iLineNumber=1230 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1232 & ' - $iXMLValue = _XML_GetNodeAttributeValue($oNode, $iXMLAttribu ...•./Include/_MyFunction.au3'
			$iXMLValue = _XML_GetNodeAttributeValue($oNode, $iXMLAttributeName)
			$__iLineNumber=1233 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1234 & ' - _LOG("_XML_GetNodeAttributeValue ERROR (" & $iXpath & ")", 2 ...•./Include/_MyFunction.au3'
				_LOG('_XML_GetNodeAttributeValue ERROR (' & $iXpath & ')', 2, $iLOGPath)
				$__iLineNumber=1235 & ' - _LOG("_XML_GetNodeAttributeValue @error:" & @CRLF & XML_My_E ...•./Include/_MyFunction.au3'
				_LOG('_XML_GetNodeAttributeValue @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
				$__iLineNumber=1236 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1238 & ' - Return $iXMLValue•./Include/_MyFunction.au3'
			Return $iXMLValue
		Case Else
			$__iLineNumber=1240 & ' - Return -2•./Include/_MyFunction.au3'
			Return -2
	EndSwitch

	$__iLineNumber=1243 & ' - Return -1•./Include/_MyFunction.au3'
	Return -1
EndFunc   ;==>_XML_Read

; #FUNCTION# ===================================================================================================
; Name...........: _XML_Replace
; Description ...: replace Data in XML File or XML Object
; Syntax.........: _XML_Replace($iXpath, $iValue, [$iXMLType=0], [$iXMLPath=""], [$oXMLDoc=""])
; Parameters ....: $iXpath		- Xpath to the value to replace
;~ 				   $iValue		- Value to replace
;                  $iXMLType	- Type of Value (0 = Node Value, 1 = Attribute Value)
;                  $iXMLPath	- Path to the XML File
;                  $oXMLDoc		- Object contening the XML File
; Return values .: Success      - 1
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1263 & ' - Func _XML_Replace($iXpath, $iValue, $iXMLType = 0, $iXMLPath ...•./Include/_MyFunction.au3'
Func _XML_Replace($iXpath, $iValue, $iXMLType = 0, $iXMLPath = "", $oXMLDoc = "")
	$__iLineNumber=1264 & ' - Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeN ...•./Include/_MyFunction.au3'
	Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeName
	$__iLineNumber=1265 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then
		$__iLineNumber=1266 & ' - _LOG("_XML_Replace Error : Need an Handle or Path", 2, $iLOG ...•./Include/_MyFunction.au3'
		_LOG('_XML_Replace Error : Need an Handle or Path', 2, $iLOGPath)
		$__iLineNumber=1267 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1269 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1270 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1271 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=1274 & ' - Switch $iXMLType•./Include/_MyFunction.au3'
	$__iLineNumber=1275 & ' - Case 0•./Include/_MyFunction.au3'
	Switch $iXMLType
		Case 0
			$__iLineNumber=1276 & ' - $iXMLValue = _XML_UpdateField($oXMLDoc, $iXpath, $iValue)•./Include/_MyFunction.au3'
			$iXMLValue = _XML_UpdateField($oXMLDoc, $iXpath, $iValue)
			$__iLineNumber=1277 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1278 & ' - _LOG("_XML_UpdateField @error:" & @CRLF & XML_My_ErrorParser ...•./Include/_MyFunction.au3'
				_LOG('_XML_UpdateField @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
				$__iLineNumber=1279 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1281 & ' - _XML_TIDY($oXMLDoc)•./Include/_MyFunction.au3'
			_XML_TIDY($oXMLDoc)
			$__iLineNumber=1282 & ' - _LOG("_XML_UpdateField (" & $iXpath & ") = " & $iValue, 1, $ ...•./Include/_MyFunction.au3'
			_LOG('_XML_UpdateField (' & $iXpath & ') = ' & $iValue, 1, $iLOGPath)
			$__iLineNumber=1283 & ' - Return 1•./Include/_MyFunction.au3'
			Return 1
		$__iLineNumber=1284 & ' - Case 1•./Include/_MyFunction.au3'
		Case 1
			$__iLineNumber=1285 & ' - $iXpathSplit = StringSplit($iXpath, "/")•./Include/_MyFunction.au3'
			$iXpathSplit = StringSplit($iXpath, "/")
			$__iLineNumber=1286 & ' - $iXMLAttributeName = $iXpathSplit[UBound($iXpathSplit) - 1]•./Include/_MyFunction.au3'
			$iXMLAttributeName = $iXpathSplit[UBound($iXpathSplit) - 1]
			$__iLineNumber=1287 & ' - $iXpath = StringTrimRight($iXpath, StringLen($iXMLAttributeN ...•./Include/_MyFunction.au3'
			$iXpath = StringTrimRight($iXpath, StringLen($iXMLAttributeName) + 1)
			$__iLineNumber=1288 & ' - _XML_SetAttrib($oXMLDoc, $iXpath, $iXMLAttributeName, $iValu ...•./Include/_MyFunction.au3'
			_XML_SetAttrib($oXMLDoc, $iXpath, $iXMLAttributeName, $iValue)
			$__iLineNumber=1289 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1290 & ' - _LOG("_XML_SelectSingleNode @error:" & @CRLF & XML_My_ErrorP ...•./Include/_MyFunction.au3'
				_LOG('_XML_SelectSingleNode @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
				$__iLineNumber=1291 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1293 & ' - _XML_TIDY($oXMLDoc)•./Include/_MyFunction.au3'
			_XML_TIDY($oXMLDoc)
			$__iLineNumber=1294 & ' - _LOG("_XML_UpdateField (" & $iXpath & ") = " & $iValue, 1, $ ...•./Include/_MyFunction.au3'
			_LOG('_XML_UpdateField (' & $iXpath & ') = ' & $iValue, 1, $iLOGPath)
			$__iLineNumber=1295 & ' - Return 1•./Include/_MyFunction.au3'
			Return 1
		Case Else
			$__iLineNumber=1297 & ' - _LOG("_XML_Replace : $iXMLType Unknown", 2, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG('_XML_Replace : $iXMLType Unknown', 2, $iLOGPath)
			$__iLineNumber=1298 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
	EndSwitch

	$__iLineNumber=1301 & ' - Return -1•./Include/_MyFunction.au3'
	Return -1
EndFunc   ;==>_XML_Replace

; #FUNCTION# ===================================================================================================
; Name...........: _XML_ListValue
; Description ...: List Data in XML File or XML Object
; Syntax.........: _XML_ListValue($iXpath, [$iXMLPath=""], [$oXMLDoc=""])
; Parameters ....: $iXpath		- Xpath to the values to read
;                  $iXMLPath	- Path to the XML File
;                  $oXMLDoc		- Object contening the XML File
; Return values .: Success      - Array with all the data ([0] = Nb of Values)
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......: No attribute
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1319 & ' - Func _XML_ListValue($iXpath, $iXMLPath = "", $oXMLDoc = "")•./Include/_MyFunction.au3'
Func _XML_ListValue($iXpath, $iXMLPath = "", $oXMLDoc = "")
	$__iLineNumber=1320 & ' - Local $iXMLValue = -1•./Include/_MyFunction.au3'
	Local $iXMLValue = -1
	$__iLineNumber=1321 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=1322 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1323 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1324 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=1327 & ' - $iXMLValue = _XML_GetValue($oXMLDoc, $iXpath)•./Include/_MyFunction.au3'
	$iXMLValue = _XML_GetValue($oXMLDoc, $iXpath)
	$__iLineNumber=1328 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1329 & ' - _LOG("_XML_GetValue ERROR (" & $iXpath & ")", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG('_XML_GetValue ERROR (' & $iXpath & ')', 2, $iLOGPath)
		$__iLineNumber=1330 & ' - _LOG("_XML_GetValue @error:" & @CRLF & XML_My_ErrorParser(@e ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetValue @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
		$__iLineNumber=1331 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1333 & ' - If IsArray($iXMLValue) Then•./Include/_MyFunction.au3'
	If IsArray($iXMLValue) Then
		$__iLineNumber=1334 & ' - Return $iXMLValue•./Include/_MyFunction.au3'
		Return $iXMLValue
	Else
		$__iLineNumber=1336 & ' - _LOG("_XML_GetValue (" & $iXpath & ") is not an Array", 2, $ ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetValue (' & $iXpath & ') is not an Array', 2, $iLOGPath)
		$__iLineNumber=1337 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf

	$__iLineNumber=1340 & ' - Return -1•./Include/_MyFunction.au3'
	Return -1
EndFunc   ;==>_XML_ListValue

; #FUNCTION# ===================================================================================================
; Name...........: _XML_ListNode
; Description ...: List Nodes in XML File or XML Object
; Syntax.........: _XML_ListNode($iXpath, [$iXMLPath=""], [$oXMLDoc=""])
; Parameters ....: $iXpath		- Xpath to the Node to read
;                  $iXMLPath	- Path to the XML File
;                  $oXMLDoc		- Object contening the XML File
; Return values .: Success      - Array with all the data ([0][0] = Nb of Values ; [x][0] = Node Name ; [x][1] = Node Value)
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......: No attribute
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1358 & ' - Func _XML_ListNode($iXpath, $iXMLPath = "", $oXMLDoc = "")•./Include/_MyFunction.au3'
Func _XML_ListNode($iXpath, $iXMLPath = "", $oXMLDoc = "")
	$__iLineNumber=1359 & ' - Local $iXMLValue = -1•./Include/_MyFunction.au3'
	Local $iXMLValue = -1
	$__iLineNumber=1360 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=1361 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1362 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1363 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=1366 & ' - $iXMLValue = _XML_GetChildren($oXMLDoc, $iXpath)•./Include/_MyFunction.au3'
	$iXMLValue = _XML_GetChildren($oXMLDoc, $iXpath)
	$__iLineNumber=1367 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1368 & ' - _LOG("_XML_GetChildNodes ERROR (" & $iXpath & ")", 2, $iLOGP ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetChildNodes ERROR (' & $iXpath & ')', 2, $iLOGPath)
		$__iLineNumber=1369 & ' - _LOG("_XML_GetChildNodes @error:" & @CRLF & XML_My_ErrorPars ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetChildNodes @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
		$__iLineNumber=1370 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1372 & ' - If IsArray($iXMLValue) Then•./Include/_MyFunction.au3'
	If IsArray($iXMLValue) Then
		$__iLineNumber=1373 & ' - Return $iXMLValue•./Include/_MyFunction.au3'
		Return $iXMLValue
	Else
		$__iLineNumber=1375 & ' - _LOG("_XML_GetValue (" & $iXpath & ") is not an Array", 2, $ ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetValue (' & $iXpath & ') is not an Array', 2, $iLOGPath)
		$__iLineNumber=1376 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1378 & ' - Return -1•./Include/_MyFunction.au3'
	Return -1
EndFunc   ;==>_XML_ListNode

; #FUNCTION# ===================================================================================================
; Name...........: _XML_Make
; Description ...: Create an XML File and Object
; Syntax.........: _XML_Make($iXMLPath,$iRoot,[$iUTF8 = True])
; Parameters ....: $iXMLPath	- Path to the XML File
;                  $iRoot		- Xpath Root
;                  $iUTF8		- UTF8 encoding
; Return values .: Success      - Object contening the XML File
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1396 & ' - Func _XML_Make($iXMLPath, $iRoot, $iUTF8 = True)•./Include/_MyFunction.au3'
Func _XML_Make($iXMLPath, $iRoot, $iUTF8 = True)
	$__iLineNumber=1397 & ' - FileDelete($iXMLPath)•./Include/_MyFunction.au3'
	FileDelete($iXMLPath)
	$__iLineNumber=1398 & ' - Local $oXMLDoc = _XML_CreateFile($iXMLPath, $iRoot, $iUTF8)•./Include/_MyFunction.au3'
	Local $oXMLDoc = _XML_CreateFile($iXMLPath, $iRoot, $iUTF8)
	$__iLineNumber=1399 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1400 & ' - _LOG("_XML_CreateFile @error:" & @CRLF & XML_My_ErrorParser( ...•./Include/_MyFunction.au3'
		_LOG('_XML_CreateFile @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
		$__iLineNumber=1401 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1403 & ' - Return $oXMLDoc•./Include/_MyFunction.au3'
	Return $oXMLDoc
EndFunc   ;==>_XML_Make

; #FUNCTION# ===================================================================================================
; Name...........: _XML_WriteValue
; Description ...: Create a node and is value in XML File or XML Object
; Syntax.........: _XML_WriteValue($iXpath, [$iValue=""], [$iXMLPath=""], [$oXMLDoc=""])
; Parameters ....: $iXpath		- Xpath to the value to read
;                  $iValue		- Value to write
;                  $iXMLPath	- Path to the XML File
;                  $oXMLDoc		- Object contening the XML File
; Return values .: Success      - 1
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1422 & ' - Func _XML_WriteValue($iXpath, $iValue = "", $iXMLPath = "",  ...•./Include/_MyFunction.au3'
Func _XML_WriteValue($iXpath, $iValue = "", $iXMLPath = "", $oXMLDoc = "", $ipos = "last()")
	$__iLineNumber=1423 & ' - Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeN ...•./Include/_MyFunction.au3'
	Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeName
	$__iLineNumber=1424 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=1425 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1426 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1427 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=1430 & ' - $iXpathSplit = StringSplit($iXpath, "/")•./Include/_MyFunction.au3'
	$iXpathSplit = StringSplit($iXpath, "/")
	$__iLineNumber=1431 & ' - $iXMLChildName = $iXpathSplit[UBound($iXpathSplit) - 1]•./Include/_MyFunction.au3'
	$iXMLChildName = $iXpathSplit[UBound($iXpathSplit) - 1]
	$__iLineNumber=1432 & ' - $iXpath = StringTrimRight($iXpath, StringLen($iXMLChildName) ...•./Include/_MyFunction.au3'
	$iXpath = StringTrimRight($iXpath, StringLen($iXMLChildName) + 1)
	$__iLineNumber=1433 & ' - _XML_CreateChildWAttr($oXMLDoc, $iXpath & "[" & $ipos & "]", ...•./Include/_MyFunction.au3'
	_XML_CreateChildWAttr($oXMLDoc, $iXpath & "[" & $ipos & "]", $iXMLChildName, Default, $iValue)
	$__iLineNumber=1434 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1435 & ' - _LOG("_XML_CreateChildWAttr ERROR (" & $iXpath & ")", 2, $iL ...•./Include/_MyFunction.au3'
		_LOG('_XML_CreateChildWAttr ERROR (' & $iXpath & ')', 2, $iLOGPath)
		$__iLineNumber=1436 & ' - _LOG("_XML_CreateChildWAttr @error:" & @CRLF & XML_My_ErrorP ...•./Include/_MyFunction.au3'
		_LOG('_XML_CreateChildWAttr @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
		$__iLineNumber=1437 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1439 & ' - Return 1•./Include/_MyFunction.au3'
	Return 1
EndFunc   ;==>_XML_WriteValue

; #FUNCTION# ===================================================================================================
; Name...........: _XML_WriteAttributs
; Description ...: Read Data in XML File or XML Object
; Syntax.........: _XML_WriteAttributs($iXpath, $iAttribute, [$iValue=""], [$iXMLPath=""], [$oXMLDoc=""])
; Parameters ....: $iXpath		- Xpath to the value to read
;                  $iAttribute	- Attribute name
;                  $iValue		- Value to write
;                  $iXMLPath	- Path to the XML File
;                  $oXMLDoc		- Object contening the XML File
; Return values .: Success      - 1
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1459 & ' - Func _XML_WriteAttributs($iXpath, $iAttribute, $iValue = "", ...•./Include/_MyFunction.au3'
Func _XML_WriteAttributs($iXpath, $iAttribute, $iValue = "", $iXMLPath = "", $oXMLDoc = "", $ipos = "last()")
	$__iLineNumber=1460 & ' - Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeN ...•./Include/_MyFunction.au3'
	Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeName
	$__iLineNumber=1461 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=1462 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1463 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1464 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=1467 & ' - _XML_SetAttrib($oXMLDoc, $iXpath & "[" & $ipos & "]", $iAttr ...•./Include/_MyFunction.au3'
	_XML_SetAttrib($oXMLDoc, $iXpath & "[" & $ipos & "]", $iAttribute, $iValue)
	$__iLineNumber=1468 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1469 & ' - _LOG("_XML_SetAttrib ERROR (" & $iXpath & ")", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG('_XML_SetAttrib ERROR (' & $iXpath & ')', 2, $iLOGPath)
		$__iLineNumber=1470 & ' - _LOG("_XML_SetAttrib @error:" & @CRLF & XML_My_ErrorParser(@ ...•./Include/_MyFunction.au3'
		_LOG('_XML_SetAttrib @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
		$__iLineNumber=1471 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1473 & ' - Return 1•./Include/_MyFunction.au3'
	Return 1
EndFunc   ;==>_XML_WriteAttributs

#EndRegion XML Function

#Region XML DOM Error/Event Handling
; This COM Error Hanlder will be used globally (excepting inside UDF Functions)
$__iLineNumber=1480 & ' - Global $oErrorHandler = ObjEvent("AutoIt.Error", ErrFunc_Cus ...•./Include/_MyFunction.au3'
Global $oErrorHandler = ObjEvent("AutoIt.Error", ErrFunc_CustomUserHandler_MAIN)
#forceref $oErrorHandler

; This is SetUp for the transfer UDF internal COM Error Handler to the user function
$__iLineNumber=1484 & ' - _XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_ ...•./Include/_MyFunction.au3'
_XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_XML)

$__iLineNumber=1486 & ' - Func ErrFunc_CustomUserHandler_MAIN($oError)•./Include/_MyFunction.au3'
Func ErrFunc_CustomUserHandler_MAIN($oError)
	$__iLineNumber=1487 & ' - ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") :  ...•./Include/_MyFunction.au3'
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

$__iLineNumber=1499 & ' - Func ErrFunc_CustomUserHandler_XML($oError)•./Include/_MyFunction.au3'
Func ErrFunc_CustomUserHandler_XML($oError)
	; here is declared another path to UDF au3 file
	; thanks to this with using _XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_XML)
	;  you get errors which after pressing F4 in SciTE4AutoIt you goes directly to the specified UDF Error Line
	$__iLineNumber=1503 & ' - ConsoleWrite(@ScriptDir & "\XMLWrapperEx.au3" & " (" & $oErr ...•./Include/_MyFunction.au3'
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

$__iLineNumber=1515 & ' - Func XML_DOM_EVENT_ondataavailable()•./Include/_MyFunction.au3'
Func XML_DOM_EVENT_ondataavailable()
	#CS
		$__iLineNumber=1517 & ' - ondataavailable Event•./Include/_MyFunction.au3'
		ondataavailable Event
		$__iLineNumber=1518 & ' - https://msdn.microsoft.com/en-us/library/ms754530(v=vs.85).a ...•./Include/_MyFunction.au3'
		https://msdn.microsoft.com/en-us/library/ms754530(v=vs.85).aspx
	#CE
	$__iLineNumber=1520 & ' - Local $oEventObj = @COM_EventObj•./Include/_MyFunction.au3'
	Local $oEventObj = @COM_EventObj
	$__iLineNumber=1521 & ' - ConsoleWrite("@COM_EventObj = " & ObjName($oEventObj, 3) & @ ...•./Include/_MyFunction.au3'
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	$__iLineNumber=1523 & ' - Local $sMessage = "XML_DOM_EVENT_ fired "ondataavailable"" & ...•./Include/_MyFunction.au3'
	Local $sMessage = 'XML_DOM_EVENT_ fired "ondataavailable"' & @CRLF
	$__iLineNumber=1524 & ' - ConsoleWrite($sMessage)•./Include/_MyFunction.au3'
	ConsoleWrite($sMessage)
EndFunc   ;==>XML_DOM_EVENT_ondataavailable

$__iLineNumber=1527 & ' - Func XML_DOM_EVENT_onreadystatechange()•./Include/_MyFunction.au3'
Func XML_DOM_EVENT_onreadystatechange()
	#CS
		$__iLineNumber=1529 & ' - onreadystatechange Event•./Include/_MyFunction.au3'
		onreadystatechange Event
		$__iLineNumber=1530 & ' - https://msdn.microsoft.com/en-us/library/ms759186(v=vs.85).a ...•./Include/_MyFunction.au3'
		https://msdn.microsoft.com/en-us/library/ms759186(v=vs.85).aspx
	#CE
	$__iLineNumber=1532 & ' - Local $oEventObj = @COM_EventObj•./Include/_MyFunction.au3'
	Local $oEventObj = @COM_EventObj
	$__iLineNumber=1533 & ' - ConsoleWrite("@COM_EventObj = " & ObjName($oEventObj, 3) & @ ...•./Include/_MyFunction.au3'
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	$__iLineNumber=1535 & ' - Local $sMessage = "XML_DOM_EVENT_ fired "onreadystatechange" ...•./Include/_MyFunction.au3'
	Local $sMessage = 'XML_DOM_EVENT_ fired "onreadystatechange" : ReadyState = ' & $oEventObj.ReadyState & @CRLF
	$__iLineNumber=1536 & ' - ConsoleWrite($sMessage)•./Include/_MyFunction.au3'
	ConsoleWrite($sMessage)

EndFunc   ;==>XML_DOM_EVENT_onreadystatechange

$__iLineNumber=1540 & ' - Func XML_DOM_EVENT_ontransformnode($oNodeCode_XSL, $oNodeDat ...•./Include/_MyFunction.au3'
Func XML_DOM_EVENT_ontransformnode($oNodeCode_XSL, $oNodeData_XML, $bBool)
	#forceref $oNodeCode_XSL, $oNodeData_XML, $bBool
	#CS
		$__iLineNumber=1543 & ' - ontransformnode Event•./Include/_MyFunction.au3'
		ontransformnode Event
		$__iLineNumber=1544 & ' - https://msdn.microsoft.com/en-us/library/ms767521(v=vs.85).a ...•./Include/_MyFunction.au3'
		https://msdn.microsoft.com/en-us/library/ms767521(v=vs.85).aspx
	#CE
	$__iLineNumber=1546 & ' - Local $oEventObj = @COM_EventObj•./Include/_MyFunction.au3'
	Local $oEventObj = @COM_EventObj
	$__iLineNumber=1547 & ' - ConsoleWrite("@COM_EventObj = " & ObjName($oEventObj, 3) & @ ...•./Include/_MyFunction.au3'
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	$__iLineNumber=1549 & ' - Local $sMessage = "XML_DOM_EVENT_ fired "ontransformnode"" & ...•./Include/_MyFunction.au3'
	Local $sMessage = 'XML_DOM_EVENT_ fired "ontransformnode"' & @CRLF
	$__iLineNumber=1550 & ' - ConsoleWrite($sMessage)•./Include/_MyFunction.au3'
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
$__iLineNumber=1568 & ' - Func XML_My_ErrorParser($iXMLWrapper_Error, $iXMLWrapper_Ext ...•./Include/_MyFunction.au3'
Func XML_My_ErrorParser($iXMLWrapper_Error, $iXMLWrapper_Extended = 0)
	$__iLineNumber=1569 & ' - Local $sErrorInfo = ""•./Include/_MyFunction.au3'
	Local $sErrorInfo = ''
	$__iLineNumber=1570 & ' - Switch $iXMLWrapper_Error•./Include/_MyFunction.au3'
	$__iLineNumber=1571 & ' - Case $XML_ERR_OK•./Include/_MyFunction.au3'
	Switch $iXMLWrapper_Error
		Case $XML_ERR_OK
			$__iLineNumber=1572 & ' - $sErrorInfo = "$XML_ERR_OK=" & $XML_ERR_OK & @CRLF & "All is ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_OK=' & $XML_ERR_OK & @CRLF & 'All is ok.'
		$__iLineNumber=1573 & ' - Case $XML_ERR_GENERAL•./Include/_MyFunction.au3'
		Case $XML_ERR_GENERAL
			$__iLineNumber=1574 & ' - $sErrorInfo = "$XML_ERR_GENERAL=" & $XML_ERR_GENERAL & @CRLF ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_GENERAL=' & $XML_ERR_GENERAL & @CRLF & 'The error which is not specifically defined.'
		$__iLineNumber=1575 & ' - Case $XML_ERR_COMERROR•./Include/_MyFunction.au3'
		Case $XML_ERR_COMERROR
			$__iLineNumber=1576 & ' - $sErrorInfo = "$XML_ERR_COMERROR=" & $XML_ERR_COMERROR & @CR ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_COMERROR=' & $XML_ERR_COMERROR & @CRLF & 'COM ERROR OCCURED. Check @extended and your own error handler function for details.'
		$__iLineNumber=1577 & ' - Case $XML_ERR_ISNOTOBJECT•./Include/_MyFunction.au3'
		Case $XML_ERR_ISNOTOBJECT
			$__iLineNumber=1578 & ' - $sErrorInfo = "$XML_ERR_ISNOTOBJECT=" & $XML_ERR_ISNOTOBJECT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_ISNOTOBJECT=' & $XML_ERR_ISNOTOBJECT & @CRLF & 'No object passed to function'
		$__iLineNumber=1579 & ' - Case $XML_ERR_INVALIDDOMDOC•./Include/_MyFunction.au3'
		Case $XML_ERR_INVALIDDOMDOC
			$__iLineNumber=1580 & ' - $sErrorInfo = "$XML_ERR_INVALIDDOMDOC=" & $XML_ERR_INVALIDDO ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_INVALIDDOMDOC=' & $XML_ERR_INVALIDDOMDOC & @CRLF & 'Invalid object passed to function'
		$__iLineNumber=1581 & ' - Case $XML_ERR_INVALIDATTRIB•./Include/_MyFunction.au3'
		Case $XML_ERR_INVALIDATTRIB
			$__iLineNumber=1582 & ' - $sErrorInfo = "$XML_ERR_INVALIDATTRIB=" & $XML_ERR_INVALIDAT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_INVALIDATTRIB=' & $XML_ERR_INVALIDATTRIB & @CRLF & 'Invalid object passed to function.'
		$__iLineNumber=1583 & ' - Case $XML_ERR_INVALIDNODETYPE•./Include/_MyFunction.au3'
		Case $XML_ERR_INVALIDNODETYPE
			$__iLineNumber=1584 & ' - $sErrorInfo = "$XML_ERR_INVALIDNODETYPE=" & $XML_ERR_INVALID ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_INVALIDNODETYPE=' & $XML_ERR_INVALIDNODETYPE & @CRLF & 'Invalid object passed to function.'
		$__iLineNumber=1585 & ' - Case $XML_ERR_OBJCREATE•./Include/_MyFunction.au3'
		Case $XML_ERR_OBJCREATE
			$__iLineNumber=1586 & ' - $sErrorInfo = "$XML_ERR_OBJCREATE=" & $XML_ERR_OBJCREATE & @ ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_OBJCREATE=' & $XML_ERR_OBJCREATE & @CRLF & 'Object can not be created.'
		$__iLineNumber=1587 & ' - Case $XML_ERR_NODECREATE•./Include/_MyFunction.au3'
		Case $XML_ERR_NODECREATE
			$__iLineNumber=1588 & ' - $sErrorInfo = "$XML_ERR_NODECREATE=" & $XML_ERR_NODECREATE & ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NODECREATE=' & $XML_ERR_NODECREATE & @CRLF & 'Can not create Node - check also COM Error Handler'
		$__iLineNumber=1589 & ' - Case $XML_ERR_NODEAPPEND•./Include/_MyFunction.au3'
		Case $XML_ERR_NODEAPPEND
			$__iLineNumber=1590 & ' - $sErrorInfo = "$XML_ERR_NODEAPPEND=" & $XML_ERR_NODEAPPEND & ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NODEAPPEND=' & $XML_ERR_NODEAPPEND & @CRLF & 'Can not append Node - check also COM Error Handler'
		$__iLineNumber=1591 & ' - Case $XML_ERR_PARSE•./Include/_MyFunction.au3'
		Case $XML_ERR_PARSE
			$__iLineNumber=1592 & ' - $sErrorInfo = "$XML_ERR_PARSE=" & $XML_ERR_PARSE & @CRLF & " ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_PARSE=' & $XML_ERR_PARSE & @CRLF & 'Error: with Parsing objects, .parseError.errorCode=' & $iXMLWrapper_Extended & ' Use _XML_ErrorParser_GetDescription() for get details.'
		$__iLineNumber=1593 & ' - Case $XML_ERR_PARSE_XSL•./Include/_MyFunction.au3'
		Case $XML_ERR_PARSE_XSL
			$__iLineNumber=1594 & ' - $sErrorInfo = "$XML_ERR_PARSE_XSL=" & $XML_ERR_PARSE_XSL & @ ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_PARSE_XSL=' & $XML_ERR_PARSE_XSL & @CRLF & 'Error with Parsing XSL objects .parseError.errorCode=' & $iXMLWrapper_Extended & ' Use _XML_ErrorParser_GetDescription() for get details.'
		$__iLineNumber=1595 & ' - Case $XML_ERR_LOAD•./Include/_MyFunction.au3'
		Case $XML_ERR_LOAD
			$__iLineNumber=1596 & ' - $sErrorInfo = "$XML_ERR_LOAD=" & $XML_ERR_LOAD & @CRLF & "Er ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_LOAD=' & $XML_ERR_LOAD & @CRLF & 'Error opening specified file.'
		$__iLineNumber=1597 & ' - Case $XML_ERR_SAVE•./Include/_MyFunction.au3'
		Case $XML_ERR_SAVE
			$__iLineNumber=1598 & ' - $sErrorInfo = "$XML_ERR_SAVE=" & $XML_ERR_SAVE & @CRLF & "Er ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_SAVE=' & $XML_ERR_SAVE & @CRLF & 'Error saving file.'
		$__iLineNumber=1599 & ' - Case $XML_ERR_PARAMETER•./Include/_MyFunction.au3'
		Case $XML_ERR_PARAMETER
			$__iLineNumber=1600 & ' - $sErrorInfo = "$XML_ERR_PARAMETER=" & $XML_ERR_PARAMETER & @ ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_PARAMETER=' & $XML_ERR_PARAMETER & @CRLF & 'Wrong parameter passed to function.'
		$__iLineNumber=1601 & ' - Case $XML_ERR_ARRAY•./Include/_MyFunction.au3'
		Case $XML_ERR_ARRAY
			$__iLineNumber=1602 & ' - $sErrorInfo = "$XML_ERR_ARRAY=" & $XML_ERR_ARRAY & @CRLF & " ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_ARRAY=' & $XML_ERR_ARRAY & @CRLF & 'Wrong array parameter passed to function. Check array dimension and conent.'
		$__iLineNumber=1603 & ' - Case $XML_ERR_XPATH•./Include/_MyFunction.au3'
		Case $XML_ERR_XPATH
			$__iLineNumber=1604 & ' - $sErrorInfo = "$XML_ERR_XPATH=" & $XML_ERR_XPATH & @CRLF & " ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_XPATH=' & $XML_ERR_XPATH & @CRLF & 'XPath syntax error - check also COM Error Handler.'
		$__iLineNumber=1605 & ' - Case $XML_ERR_NONODESMATCH•./Include/_MyFunction.au3'
		Case $XML_ERR_NONODESMATCH
			$__iLineNumber=1606 & ' - $sErrorInfo = "$XML_ERR_NONODESMATCH=" & $XML_ERR_NONODESMAT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NONODESMATCH=' & $XML_ERR_NONODESMATCH & @CRLF & 'No nodes match the XPath expression'
		$__iLineNumber=1607 & ' - Case $XML_ERR_NOCHILDMATCH•./Include/_MyFunction.au3'
		Case $XML_ERR_NOCHILDMATCH
			$__iLineNumber=1608 & ' - $sErrorInfo = "$XML_ERR_NOCHILDMATCH=" & $XML_ERR_NOCHILDMAT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NOCHILDMATCH=' & $XML_ERR_NOCHILDMATCH & @CRLF & 'There is no Child in nodes matched by XPath expression.'
		$__iLineNumber=1609 & ' - Case $XML_ERR_NOATTRMATCH•./Include/_MyFunction.au3'
		Case $XML_ERR_NOATTRMATCH
			$__iLineNumber=1610 & ' - $sErrorInfo = "$XML_ERR_NOATTRMATCH=" & $XML_ERR_NOATTRMATCH ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NOATTRMATCH=' & $XML_ERR_NOATTRMATCH & @CRLF & 'There is no such attribute in selected node.'
		$__iLineNumber=1611 & ' - Case $XML_ERR_DOMVERSION•./Include/_MyFunction.au3'
		Case $XML_ERR_DOMVERSION
			$__iLineNumber=1612 & ' - $sErrorInfo = "$XML_ERR_DOMVERSION=" & $XML_ERR_DOMVERSION & ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_DOMVERSION=' & $XML_ERR_DOMVERSION & @CRLF & 'DOM Version: ' & 'MSXML Version ' & $iXMLWrapper_Extended & ' or greater required for this function'
		$__iLineNumber=1613 & ' - Case $XML_ERR_EMPTYCOLLECTION•./Include/_MyFunction.au3'
		Case $XML_ERR_EMPTYCOLLECTION
			$__iLineNumber=1614 & ' - $sErrorInfo = "$XML_ERR_EMPTYCOLLECTION=" & $XML_ERR_EMPTYCO ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_EMPTYCOLLECTION=' & $XML_ERR_EMPTYCOLLECTION & @CRLF & 'Collections of objects was empty'
		$__iLineNumber=1615 & ' - Case $XML_ERR_EMPTYOBJECT•./Include/_MyFunction.au3'
		Case $XML_ERR_EMPTYOBJECT
			$__iLineNumber=1616 & ' - $sErrorInfo = "$XML_ERR_EMPTYOBJECT=" & $XML_ERR_EMPTYOBJECT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_EMPTYOBJECT=' & $XML_ERR_EMPTYOBJECT & @CRLF & 'Object is empty'
		Case Else
			$__iLineNumber=1618 & ' - $sErrorInfo = "=" & $iXMLWrapper_Error & @CRLF & "NO ERROR D ...•./Include/_MyFunction.au3'
			$sErrorInfo = '=' & $iXMLWrapper_Error & @CRLF & 'NO ERROR DESCRIPTION FOR THIS @error'
	EndSwitch

	$__iLineNumber=1621 & ' - Local $sExtendedInfo = ""•./Include/_MyFunction.au3'
	Local $sExtendedInfo = ''
	$__iLineNumber=1622 & ' - Switch $iXMLWrapper_Error•./Include/_MyFunction.au3'
	$__iLineNumber=1623 & ' - Case $XML_ERR_COMERROR, $XML_ERR_NODEAPPEND, $XML_ERR_NODECR ...•./Include/_MyFunction.au3'
	Switch $iXMLWrapper_Error
		Case $XML_ERR_COMERROR, $XML_ERR_NODEAPPEND, $XML_ERR_NODECREATE
			$__iLineNumber=1624 & ' - $sExtendedInfo = "COM ERROR NUMBER (@error returned via @ext ...•./Include/_MyFunction.au3'
			$sExtendedInfo = 'COM ERROR NUMBER (@error returned via @extended) =' & $iXMLWrapper_Extended
		$__iLineNumber=1625 & ' - Case $XML_ERR_PARAMETER•./Include/_MyFunction.au3'
		Case $XML_ERR_PARAMETER
			$__iLineNumber=1626 & ' - $sExtendedInfo = "This @error was fired by parameter: #" & $ ...•./Include/_MyFunction.au3'
			$sExtendedInfo = 'This @error was fired by parameter: #' & $iXMLWrapper_Extended
		Case Else
			$__iLineNumber=1628 & ' - Switch $iXMLWrapper_Extended•./Include/_MyFunction.au3'
			$__iLineNumber=1629 & ' - Case $XML_EXT_DEFAULT•./Include/_MyFunction.au3'
			Switch $iXMLWrapper_Extended
				Case $XML_EXT_DEFAULT
					$__iLineNumber=1630 & ' - $sExtendedInfo = "$XML_EXT_DEFAULT=" & $XML_EXT_DEFAULT & @C ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_DEFAULT=' & $XML_EXT_DEFAULT & @CRLF & 'Default - Do not return any additional information'
				$__iLineNumber=1631 & ' - Case $XML_EXT_XMLDOM•./Include/_MyFunction.au3'
				Case $XML_EXT_XMLDOM
					$__iLineNumber=1632 & ' - $sExtendedInfo = "$XML_EXT_XMLDOM=" & $XML_EXT_XMLDOM & @CRL ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_XMLDOM=' & $XML_EXT_XMLDOM & @CRLF & '"Microsoft.XMLDOM" related Error'
				$__iLineNumber=1633 & ' - Case $XML_EXT_DOMDOCUMENT•./Include/_MyFunction.au3'
				Case $XML_EXT_DOMDOCUMENT
					$__iLineNumber=1634 & ' - $sExtendedInfo = "$XML_EXT_DOMDOCUMENT=" & $XML_EXT_DOMDOCUM ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_DOMDOCUMENT=' & $XML_EXT_DOMDOCUMENT & @CRLF & '"Msxml2.DOMDocument" related Error'
				$__iLineNumber=1635 & ' - Case $XML_EXT_XSLTEMPLATE•./Include/_MyFunction.au3'
				Case $XML_EXT_XSLTEMPLATE
					$__iLineNumber=1636 & ' - $sExtendedInfo = "$XML_EXT_XSLTEMPLATE=" & $XML_EXT_XSLTEMPL ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_XSLTEMPLATE=' & $XML_EXT_XSLTEMPLATE & @CRLF & '"Msxml2.XSLTemplate" related Error'
				$__iLineNumber=1637 & ' - Case $XML_EXT_SAXXMLREADER•./Include/_MyFunction.au3'
				Case $XML_EXT_SAXXMLREADER
					$__iLineNumber=1638 & ' - $sExtendedInfo = "$XML_EXT_SAXXMLREADER=" & $XML_EXT_SAXXMLR ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_SAXXMLREADER=' & $XML_EXT_SAXXMLREADER & @CRLF & '"MSXML2.SAXXMLReader" related Error'
				$__iLineNumber=1639 & ' - Case $XML_EXT_MXXMLWRITER•./Include/_MyFunction.au3'
				Case $XML_EXT_MXXMLWRITER
					$__iLineNumber=1640 & ' - $sExtendedInfo = "$XML_EXT_MXXMLWRITER=" & $XML_EXT_MXXMLWRI ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_MXXMLWRITER=' & $XML_EXT_MXXMLWRITER & @CRLF & '"MSXML2.MXXMLWriter" related Error'
				$__iLineNumber=1641 & ' - Case $XML_EXT_FREETHREADEDDOMDOCUMENT•./Include/_MyFunction.au3'
				Case $XML_EXT_FREETHREADEDDOMDOCUMENT
					$__iLineNumber=1642 & ' - $sExtendedInfo = "$XML_EXT_FREETHREADEDDOMDOCUMENT=" & $XML_ ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_FREETHREADEDDOMDOCUMENT=' & $XML_EXT_FREETHREADEDDOMDOCUMENT & @CRLF & '"Msxml2.FreeThreadedDOMDocument" related Error'
				$__iLineNumber=1643 & ' - Case $XML_EXT_XMLSCHEMACACHE•./Include/_MyFunction.au3'
				Case $XML_EXT_XMLSCHEMACACHE
					$__iLineNumber=1644 & ' - $sExtendedInfo = "$XML_EXT_XMLSCHEMACACHE=" & $XML_EXT_XMLSC ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_XMLSCHEMACACHE=' & $XML_EXT_XMLSCHEMACACHE & @CRLF & '"Msxml2.XMLSchemaCache." related Error'
				$__iLineNumber=1645 & ' - Case $XML_EXT_STREAM•./Include/_MyFunction.au3'
				Case $XML_EXT_STREAM
					$__iLineNumber=1646 & ' - $sExtendedInfo = "$XML_EXT_STREAM=" & $XML_EXT_STREAM & @CRL ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_STREAM=' & $XML_EXT_STREAM & @CRLF & '"ADODB.STREAM" related Error'
				$__iLineNumber=1647 & ' - Case $XML_EXT_ENCODING•./Include/_MyFunction.au3'
				Case $XML_EXT_ENCODING
					$__iLineNumber=1648 & ' - $sExtendedInfo = "$XML_EXT_ENCODING=" & $XML_EXT_ENCODING &  ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_ENCODING=' & $XML_EXT_ENCODING & @CRLF & 'Encoding related Error'
				Case Else
					$__iLineNumber=1650 & ' - $sExtendedInfo = "$iXMLWrapper_Extended=" & $iXMLWrapper_Ext ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$iXMLWrapper_Extended=' & $iXMLWrapper_Extended & @CRLF & 'NO ERROR DESCRIPTION FOR THIS @extened'
			EndSwitch
	EndSwitch
	; return back @error and @extended for further debuging
	$__iLineNumber=1654 & ' - Return SetError($iXMLWrapper_Error, $iXMLWrapper_Extended, _•./Include/_MyFunction.au3'
	Return SetError($iXMLWrapper_Error, $iXMLWrapper_Extended, _
			'@error description:' & @CRLF & _
			$sErrorInfo & @CRLF & _
			@CRLF & _
			'@extended description:' & @CRLF & _
			$sExtendedInfo & @CRLF & _
			'')

EndFunc   ;==>XML_My_ErrorParser
#EndRegion XML DOM Error/Event Handling


#Region SendMail Function

$__iLineNumber=1668 & ' - Func _CreateMailslot($sMailSlotName)•./Include/_MyFunction.au3'
Func _CreateMailslot($sMailSlotName)
	$__iLineNumber=1669 & ' - Local $hHandle = _MailSlotCreate($sMailSlotName)•./Include/_MyFunction.au3'
	Local $hHandle = _MailSlotCreate($sMailSlotName)
	$__iLineNumber=1670 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1671 & ' - _LOG("MailSlot error : Failed to create new account! (" & $s ...•./Include/_MyFunction.au3'
		_LOG("MailSlot error : Failed to create new account! (" & $sMailSlotName & ")", 2, $iLOGPath)
		$__iLineNumber=1672 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1674 & ' - Return $hHandle•./Include/_MyFunction.au3'
	Return $hHandle
EndFunc   ;==>_CreateMailslot


$__iLineNumber=1678 & ' - Func _SendMail($hHandle, $sDataToSend)•./Include/_MyFunction.au3'
Func _SendMail($hHandle, $sDataToSend)
	$__iLineNumber=1679 & ' - If $sDataToSend Then•./Include/_MyFunction.au3'
	If $sDataToSend Then
		$__iLineNumber=1680 & ' - _MailSlotWrite($hHandle, $sDataToSend, 2)•./Include/_MyFunction.au3'
		_MailSlotWrite($hHandle, $sDataToSend, 2)
		$__iLineNumber=1681 & ' - Switch @error•./Include/_MyFunction.au3'
		$__iLineNumber=1682 & ' - Case 1•./Include/_MyFunction.au3'
		Switch @error
			Case 1
				$__iLineNumber=1683 & ' - _LOG("MailSlot error : Account that you try to send to likel ...•./Include/_MyFunction.au3'
				_LOG("MailSlot error : Account that you try to send to likely doesn't exist!", 2, $iLOGPath)
				$__iLineNumber=1684 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			$__iLineNumber=1685 & ' - Case 2•./Include/_MyFunction.au3'
			Case 2
				$__iLineNumber=1686 & ' - _LOG("MailSlot error : Message is blocked!", 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG("MailSlot error : Message is blocked!", 2, $iLOGPath)
				$__iLineNumber=1687 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			$__iLineNumber=1688 & ' - Case 3•./Include/_MyFunction.au3'
			Case 3
				$__iLineNumber=1689 & ' - _LOG("MailSlot error : Message is send but there is an open  ...•./Include/_MyFunction.au3'
				_LOG("MailSlot error : Message is send but there is an open handle left.", 2, $iLOGPath)
				$__iLineNumber=1690 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			$__iLineNumber=1691 & ' - Case 4•./Include/_MyFunction.au3'
			Case 4
				$__iLineNumber=1692 & ' - _LOG("MailSlot error : All is fucked up!", 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG("MailSlot error : All is fucked up!", 2, $iLOGPath)
				$__iLineNumber=1693 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			Case Else
				$__iLineNumber=1695 & ' - _LOG("MailSlot : Sucessfully sent =" & $sDataToSend, 3, $iLO ...•./Include/_MyFunction.au3'
				_LOG("MailSlot : Sucessfully sent =" & $sDataToSend, 3, $iLOGPath)
				$__iLineNumber=1696 & ' - Return 1•./Include/_MyFunction.au3'
				Return 1
		EndSwitch
	Else
		$__iLineNumber=1699 & ' - _LOG("MailSlot error : Nothing to send.", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("MailSlot error : Nothing to send.", 2, $iLOGPath)
	EndIf
EndFunc   ;==>_SendMail

$__iLineNumber=1703 & ' - Func _ReadMessage($hHandle)•./Include/_MyFunction.au3'
Func _ReadMessage($hHandle)
	$__iLineNumber=1704 & ' - Local $iSize = _MailSlotCheckForNextMessage($hHandle)•./Include/_MyFunction.au3'
	Local $iSize = _MailSlotCheckForNextMessage($hHandle)
	$__iLineNumber=1705 & ' - If $iSize Then•./Include/_MyFunction.au3'
	If $iSize Then
		$__iLineNumber=1706 & ' - Return _MailSlotRead($hHandle, $iSize, 2)•./Include/_MyFunction.au3'
		Return _MailSlotRead($hHandle, $iSize, 2)
	Else
		$__iLineNumber=1708 & ' - _LOG("MailSlot error : MailSlot is empty", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("MailSlot error : MailSlot is empty", 2, $iLOGPath)
		$__iLineNumber=1709 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
EndFunc   ;==>_ReadMessage


$__iLineNumber=1714 & ' - Func _CheckCount($hHandle)•./Include/_MyFunction.au3'
Func _CheckCount($hHandle)
	$__iLineNumber=1715 & ' - Local $iCount = _MailSlotGetMessageCount($hHandle)•./Include/_MyFunction.au3'
	Local $iCount = _MailSlotGetMessageCount($hHandle)
	$__iLineNumber=1716 & ' - Switch $iCount•./Include/_MyFunction.au3'
	$__iLineNumber=1717 & ' - Case 0•./Include/_MyFunction.au3'
	Switch $iCount
		Case 0
			$__iLineNumber=1718 & ' - _LOG("MailSlot : No new messages", 3, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG("MailSlot : No new messages", 3, $iLOGPath)
		$__iLineNumber=1719 & ' - Case 1•./Include/_MyFunction.au3'
		Case 1
			$__iLineNumber=1720 & ' - _LOG("MailSlot : There is 1 message waiting to be read.", 3, ...•./Include/_MyFunction.au3'
			_LOG("MailSlot : There is 1 message waiting to be read.", 3, $iLOGPath)
		Case Else
			$__iLineNumber=1722 & ' - _LOG("MailSlot : There are " & $iCount & " messages waiting  ...•./Include/_MyFunction.au3'
			_LOG("MailSlot : There are " & $iCount & " messages waiting to be read.", 3, $iLOGPath)
	EndSwitch
	$__iLineNumber=1724 & ' - Return $iCount•./Include/_MyFunction.au3'
	Return $iCount
EndFunc   ;==>_CheckCount

$__iLineNumber=1727 & ' - Func _CheckAnswer($hHandle, $idata)•./Include/_MyFunction.au3'
Func _CheckAnswer($hHandle, $idata)
	$__iLineNumber=1728 & ' - Local $iAnwser = ""•./Include/_MyFunction.au3'
	Local $iAnwser = ""
	$__iLineNumber=1729 & ' - Local $iSize•./Include/_MyFunction.au3'
	Local $iSize
	$__iLineNumber=1730 & ' - Local $iCounter = 0•./Include/_MyFunction.au3'
	Local $iCounter = 0
	$__iLineNumber=1731 & ' - While $iAnwser <> $idata And $iCounter < 500•./Include/_MyFunction.au3'
	While $iAnwser <> $idata And $iCounter < 500
		$__iLineNumber=1732 & ' - $iSize = _MailSlotCheckForNextMessage($hHandle)•./Include/_MyFunction.au3'
		$iSize = _MailSlotCheckForNextMessage($hHandle)
		$__iLineNumber=1733 & ' - If $iSize Then $idata = _MailSlotRead($hHandle, $iSize, 2)•./Include/_MyFunction.au3'
		If $iSize Then $idata = _MailSlotRead($hHandle, $iSize, 2)
		$__iLineNumber=1734 & ' - $iCounter += 1•./Include/_MyFunction.au3'
		$iCounter += 1
	WEnd
	$__iLineNumber=1736 & ' - Return 1•./Include/_MyFunction.au3'
	Return 1
EndFunc   ;==>_CheckAnswer


$__iLineNumber=1740 & ' - Func _CloseMailAccount(ByRef $hHandle)•./Include/_MyFunction.au3'
Func _CloseMailAccount(ByRef $hHandle)
	$__iLineNumber=1741 & ' - If _MailSlotClose($hHandle) Then•./Include/_MyFunction.au3'
	If _MailSlotClose($hHandle) Then
		$__iLineNumber=1742 & ' - $hHandle = 0•./Include/_MyFunction.au3'
		$hHandle = 0
		$__iLineNumber=1743 & ' - _LOG("MailSlot : Account succesfully closed.", 3, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("MailSlot : Account succesfully closed.", 3, $iLOGPath)
		$__iLineNumber=1744 & ' - Return 1•./Include/_MyFunction.au3'
		Return 1
	Else
		$__iLineNumber=1746 & ' - _LOG("MailSlot error : Account could not be closed!", 2, $iL ...•./Include/_MyFunction.au3'
		_LOG("MailSlot error : Account could not be closed!", 2, $iLOGPath)
		$__iLineNumber=1747 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf

EndFunc   ;==>_CloseMailAccount


$__iLineNumber=1753 & ' - Func _RestoreAccount($hHandle)•./Include/_MyFunction.au3'
Func _RestoreAccount($hHandle)
	$__iLineNumber=1754 & ' - Local $hMailSlotHandle = _MailSlotCreate($hHandle)•./Include/_MyFunction.au3'
	Local $hMailSlotHandle = _MailSlotCreate($hHandle)
	$__iLineNumber=1755 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1756 & ' - _LOG("MailSlot error : Account could not be created!", 2, $i ...•./Include/_MyFunction.au3'
		_LOG("MailSlot error : Account could not be created!", 2, $iLOGPath)
		$__iLineNumber=1757 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	Else
		$__iLineNumber=1759 & ' - _LOG("MailSlot error : New account with the same address suc ...•./Include/_MyFunction.au3'
		_LOG("MailSlot error : New account with the same address successfully created!", 2, $iLOGPath)
		$__iLineNumber=1760 & ' - Return $hMailSlotHandle•./Include/_MyFunction.au3'
		Return $hMailSlotHandle
	EndIf
EndFunc   ;==>_RestoreAccount

#EndRegion SendMail Function


#Region Not Used Function
$__iLineNumber=1768 & ' - Func ImageColorToTransparent($hImage2, $iColor = Default)•./Include/_MyFunction.au3'
Func ImageColorToTransparent($hImage2, $iColor = Default)
	$__iLineNumber=1769 & ' - Local $hBitmap1, $Reslt, $width, $height, $stride, $format,  ...•./Include/_MyFunction.au3'
	Local $hBitmap1, $Reslt, $width, $height, $stride, $format, $Scan0, $v_Buffer, $v_Value, $iIW, $iIH

	$__iLineNumber=1771 & ' - $GuiSizeX = _GDIPlus_ImageGetWidth($hImage2)•./Include/_MyFunction.au3'
	$GuiSizeX = _GDIPlus_ImageGetWidth($hImage2)
	$__iLineNumber=1772 & ' - $GuiSizeY = _GDIPlus_ImageGetHeight($hImage2)•./Include/_MyFunction.au3'
	$GuiSizeY = _GDIPlus_ImageGetHeight($hImage2)
	$__iLineNumber=1773 & ' - $hBitmap1 = _GDIPlus_BitmapCloneArea($hImage2, 0, 0, $GuiSiz ...•./Include/_MyFunction.au3'
	$hBitmap1 = _GDIPlus_BitmapCloneArea($hImage2, 0, 0, $GuiSizeX, $GuiSizeY, $GDIP_PXF32ARGB)
	$__iLineNumber=1774 & ' - If $iColor = Default Then $iColor = _GDIPlus_BitmapGetPixel( ...•./Include/_MyFunction.au3'
	If $iColor = Default Then $iColor = _GDIPlus_BitmapGetPixel($hBitmap1, 1, 1) ; Transparent color
	$__iLineNumber=1775 & ' - ProgressOn("", "Processing", "0 percent", "", @DesktopHeight ...•./Include/_MyFunction.au3'
	ProgressOn("", "Processing", "0 percent", "", @DesktopHeight - 80, 1)
	$__iLineNumber=1776 & ' - $Reslt = _GDIPlus_BitmapLockBits($hBitmap1, 0, 0, $GuiSizeX, ...•./Include/_MyFunction.au3'
	$Reslt = _GDIPlus_BitmapLockBits($hBitmap1, 0, 0, $GuiSizeX, $GuiSizeY, BitOR($GDIP_ILMREAD, $GDIP_ILMWRITE), $GDIP_PXF32ARGB)
	;Get the returned values of _GDIPlus_BitmapLockBits ()
	$__iLineNumber=1778 & ' - $width = DllStructGetData($Reslt, "width")•./Include/_MyFunction.au3'
	$width = DllStructGetData($Reslt, "width")
	$__iLineNumber=1779 & ' - $height = DllStructGetData($Reslt, "height")•./Include/_MyFunction.au3'
	$height = DllStructGetData($Reslt, "height")
	$__iLineNumber=1780 & ' - $stride = DllStructGetData($Reslt, "stride")•./Include/_MyFunction.au3'
	$stride = DllStructGetData($Reslt, "stride")
	$__iLineNumber=1781 & ' - $format = DllStructGetData($Reslt, "format")•./Include/_MyFunction.au3'
	$format = DllStructGetData($Reslt, "format")
	$__iLineNumber=1782 & ' - $Scan0 = DllStructGetData($Reslt, "Scan0")•./Include/_MyFunction.au3'
	$Scan0 = DllStructGetData($Reslt, "Scan0")
	$__iLineNumber=1783 & ' - For $i = 0 To $GuiSizeX - 1•./Include/_MyFunction.au3'
	For $i = 0 To $GuiSizeX - 1
		$__iLineNumber=1784 & ' - For $j = 0 To $GuiSizeY - 1•./Include/_MyFunction.au3'
		For $j = 0 To $GuiSizeY - 1
			$__iLineNumber=1785 & ' - $v_Buffer = DllStructCreate("dword", $Scan0 + ($j * $stride) ...•./Include/_MyFunction.au3'
			$v_Buffer = DllStructCreate("dword", $Scan0 + ($j * $stride) + ($i * 4))
			$__iLineNumber=1786 & ' - $v_Value = DllStructGetData($v_Buffer, 1)•./Include/_MyFunction.au3'
			$v_Value = DllStructGetData($v_Buffer, 1)
			$__iLineNumber=1787 & ' - If Hex($v_Value, 6) = Hex($iColor, 6) Then•./Include/_MyFunction.au3'
			If Hex($v_Value, 6) = Hex($iColor, 6) Then
				$__iLineNumber=1788 & ' - DllStructSetData($v_Buffer, 1, Hex($iColor, 6)) ; Sets Trans ...•./Include/_MyFunction.au3'
				DllStructSetData($v_Buffer, 1, Hex($iColor, 6)) ; Sets Transparency here. Alpha Channel = 00, not written to.
			EndIf
		Next
		$__iLineNumber=1791 & ' - ProgressSet(Int(100 * $i / ($GuiSizeX)), Int(100 * $i / ($Gu ...•./Include/_MyFunction.au3'
		ProgressSet(Int(100 * $i / ($GuiSizeX)), Int(100 * $i / ($GuiSizeX)) & " percent")
	Next
	$__iLineNumber=1793 & ' - _GDIPlus_BitmapUnlockBits($hBitmap1, $Reslt)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapUnlockBits($hBitmap1, $Reslt)
	$__iLineNumber=1794 & ' - ProgressOff()•./Include/_MyFunction.au3'
	ProgressOff()
	$__iLineNumber=1795 & ' - Return $hBitmap1•./Include/_MyFunction.au3'
	Return $hBitmap1
EndFunc   ;==>ImageColorToTransparent

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_CreateMask
; Description ...: Create a Mask
; Syntax.........: _GDIPlus_Fusion($iPath1,$iPath2)
; Parameters ....: $iPath1		- First image path
;                  $iPath1		- Second image path
; Return values .: Success      - Return the path of the finale picture
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1811 & ' - Func _GDIPlus_CreateMask($iPath_Temp, $iX, $iY, $iWidth, $iH ...•./Include/_MyFunction.au3'
Func _GDIPlus_CreateMask($iPath_Temp, $iX, $iY, $iWidth, $iHeight)
	$__iLineNumber=1812 & ' - Local $aRemapTable[2][2]•./Include/_MyFunction.au3'
	Local $aRemapTable[2][2]
	$__iLineNumber=1813 & ' - Local $iPathBlack_Source = $iScriptPath & "\Ressources\Black ...•./Include/_MyFunction.au3'
	Local $iPathBlack_Source = $iScriptPath & "\Ressources\Black.png"
	$__iLineNumber=1814 & ' - Local $iPathWhite_Source = $iScriptPath & "\Ressources\White ...•./Include/_MyFunction.au3'
	Local $iPathWhite_Source = $iScriptPath & "\Ressources\White.png"
	$__iLineNumber=1815 & ' - Local $iPathBlack_TEMP = $iScriptPath & "\TEMP\MIX\Black_TEM ...•./Include/_MyFunction.au3'
	Local $iPathBlack_TEMP = $iScriptPath & "\TEMP\MIX\Black_TEMP.png"
	$__iLineNumber=1816 & ' - Local $iPathWhite_TEMP = $iScriptPath & "\TEMP\MIX\White_TEM ...•./Include/_MyFunction.au3'
	Local $iPathWhite_TEMP = $iScriptPath & "\TEMP\MIX\White_TEMP.png"
	$__iLineNumber=1817 & ' - Local $iPathMask_TEMP = $iScriptPath & "\TEMP\MIX\Mask_TEMP. ...•./Include/_MyFunction.au3'
	Local $iPathMask_TEMP = $iScriptPath & "\TEMP\MIX\Mask_TEMP.png"
	$__iLineNumber=1818 & ' - Local $iPathMask = $iScriptPath & "\TEMP\MIX\Mask.png"•./Include/_MyFunction.au3'
	Local $iPathMask = $iScriptPath & "\TEMP\MIX\Mask.png"
	$__iLineNumber=1819 & ' - Local $iPathIMask = $iScriptPath & "\TEMP\MIX\IMask.png"•./Include/_MyFunction.au3'
	Local $iPathIMask = $iScriptPath & "\TEMP\MIX\IMask.png"

	$__iLineNumber=1821 & ' - $aRemapTable[0][0] = 1•./Include/_MyFunction.au3'
	$aRemapTable[0][0] = 1
	$__iLineNumber=1822 & ' - $aRemapTable[1][0] = 0xFFFFFFFF ;Farbe, die Transparent gema ...•./Include/_MyFunction.au3'
	$aRemapTable[1][0] = 0xFFFFFFFF ;Farbe, die Transparent gemacht werden soll

	$__iLineNumber=1824 & ' - FileCopy($iPathWhite_Source, $iPathWhite_TEMP, $FC_OVERWRITE ...•./Include/_MyFunction.au3'
	FileCopy($iPathWhite_Source, $iPathWhite_TEMP, $FC_OVERWRITE + $FC_CREATEPATH)
	$__iLineNumber=1825 & ' - FileCopy($iPathBlack_Source, $iPathMask_TEMP, $FC_OVERWRITE  ...•./Include/_MyFunction.au3'
	FileCopy($iPathBlack_Source, $iPathMask_TEMP, $FC_OVERWRITE + $FC_CREATEPATH)
	$__iLineNumber=1826 & ' - FileDelete($iPathMask)•./Include/_MyFunction.au3'
	FileDelete($iPathMask)
	$__iLineNumber=1827 & ' - FileDelete($iPathIMask)•./Include/_MyFunction.au3'
	FileDelete($iPathIMask)

	$__iLineNumber=1829 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=1830 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=1831 & ' - $ImageWidth = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$ImageWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=1832 & ' - If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 ...•./Include/_MyFunction.au3'
	If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=1833 & ' - $ImageHeight = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$ImageHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=1834 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=1835 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()

	$__iLineNumber=1837 & ' - Dim $aPicParameters[9]•./Include/_MyFunction.au3'
	Dim $aPicParameters[9]
	$__iLineNumber=1838 & ' - $aPicParameters[0] = $iWidth•./Include/_MyFunction.au3'
	$aPicParameters[0] = $iWidth
	$__iLineNumber=1839 & ' - $aPicParameters[1] = $iHeight•./Include/_MyFunction.au3'
	$aPicParameters[1] = $iHeight
	$__iLineNumber=1840 & ' - $aPicParameters[2] = $iX•./Include/_MyFunction.au3'
	$aPicParameters[2] = $iX
	$__iLineNumber=1841 & ' - $aPicParameters[3] = $iY•./Include/_MyFunction.au3'
	$aPicParameters[3] = $iY
	$__iLineNumber=1842 & ' - _GDIPlus_Imaging($iPathWhite_TEMP, $aPicParameters, $ImageWi ...•./Include/_MyFunction.au3'
	_GDIPlus_Imaging($iPathWhite_TEMP, $aPicParameters, $ImageWidth, $ImageHeight)
	$__iLineNumber=1843 & ' - $aPicParameters[0] = $ImageWidth•./Include/_MyFunction.au3'
	$aPicParameters[0] = $ImageWidth
	$__iLineNumber=1844 & ' - $aPicParameters[1] = $ImageHeight•./Include/_MyFunction.au3'
	$aPicParameters[1] = $ImageHeight
	$__iLineNumber=1845 & ' - $aPicParameters[2] = 0•./Include/_MyFunction.au3'
	$aPicParameters[2] = 0
	$__iLineNumber=1846 & ' - $aPicParameters[3] = 0•./Include/_MyFunction.au3'
	$aPicParameters[3] = 0
	$__iLineNumber=1847 & ' - $aPicParameters[4] = $ImageWidth•./Include/_MyFunction.au3'
	$aPicParameters[4] = $ImageWidth
	$__iLineNumber=1848 & ' - $aPicParameters[5] = 0•./Include/_MyFunction.au3'
	$aPicParameters[5] = 0
	$__iLineNumber=1849 & ' - $aPicParameters[6] = 0•./Include/_MyFunction.au3'
	$aPicParameters[6] = 0
	$__iLineNumber=1850 & ' - $aPicParameters[7] = $ImageHeight•./Include/_MyFunction.au3'
	$aPicParameters[7] = $ImageHeight
	$__iLineNumber=1851 & ' - _GDIPlus_Imaging($iPathMask_TEMP, $aPicParameters, $ImageWid ...•./Include/_MyFunction.au3'
	_GDIPlus_Imaging($iPathMask_TEMP, $aPicParameters, $ImageWidth, $ImageHeight)
	$__iLineNumber=1852 & ' - _GDIPlus_Merge($iPathMask_TEMP, $iPathWhite_TEMP)•./Include/_MyFunction.au3'
	_GDIPlus_Merge($iPathMask_TEMP, $iPathWhite_TEMP)

	$__iLineNumber=1854 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=1855 & ' - $hImage = _GDIPlus_BitmapCreateFromFile($iPathMask_TEMP)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_BitmapCreateFromFile($iPathMask_TEMP)
	$__iLineNumber=1856 & ' - $hImage_Result = _GDIPlus_BitmapCreateFromScan0($ImageWidth, ...•./Include/_MyFunction.au3'
	$hImage_Result = _GDIPlus_BitmapCreateFromScan0($ImageWidth, $ImageHeight)
	$__iLineNumber=1857 & ' - $hImage_Result_Ctxt = _GDIPlus_ImageGetGraphicsContext($hIma ...•./Include/_MyFunction.au3'
	$hImage_Result_Ctxt = _GDIPlus_ImageGetGraphicsContext($hImage_Result)

	$__iLineNumber=1859 & ' - $hIA = _GDIPlus_ImageAttributesCreate()•./Include/_MyFunction.au3'
	$hIA = _GDIPlus_ImageAttributesCreate()
	$__iLineNumber=1860 & ' - _GDIPlus_ImageAttributesSetRemapTable($hIA, 1, True, $aRemap ...•./Include/_MyFunction.au3'
	_GDIPlus_ImageAttributesSetRemapTable($hIA, 1, True, $aRemapTable)
	$__iLineNumber=1861 & ' - _GDIPlus_GraphicsDrawImageRectRect($hImage_Result_Ctxt, $hIm ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImageRectRect($hImage_Result_Ctxt, $hImage, 0, 0, $ImageWidth, $ImageHeight, 0, 0, $ImageWidth, $ImageHeight, $hIA)
	$__iLineNumber=1862 & ' - _GDIPlus_ImageSaveToFile($hImage_Result, $iPathMask)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hImage_Result, $iPathMask)

	$__iLineNumber=1864 & ' - _GDIPlus_GraphicsDispose($hImage_Result_Ctxt)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hImage_Result_Ctxt)
	$__iLineNumber=1865 & ' - _GDIPlus_BitmapDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hImage)
	$__iLineNumber=1866 & ' - _GDIPlus_BitmapDispose($hImage_Result)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hImage_Result)
	$__iLineNumber=1867 & ' - _GDIPlus_ImageAttributesDispose($hIA)•./Include/_MyFunction.au3'
	_GDIPlus_ImageAttributesDispose($hIA)
	$__iLineNumber=1868 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()

	$__iLineNumber=1870 & ' - FileCopy($iPathBlack_Source, $iPathBlack_TEMP, $FC_OVERWRITE ...•./Include/_MyFunction.au3'
	FileCopy($iPathBlack_Source, $iPathBlack_TEMP, $FC_OVERWRITE + $FC_CREATEPATH)
	$__iLineNumber=1871 & ' - FileCopy($iPathWhite_Source, $iPathMask_TEMP, $FC_OVERWRITE  ...•./Include/_MyFunction.au3'
	FileCopy($iPathWhite_Source, $iPathMask_TEMP, $FC_OVERWRITE + $FC_CREATEPATH)

	$__iLineNumber=1873 & ' - Dim $aPicParameters[9]•./Include/_MyFunction.au3'
	Dim $aPicParameters[9]
	$__iLineNumber=1874 & ' - $aPicParameters[0] = $iWidth•./Include/_MyFunction.au3'
	$aPicParameters[0] = $iWidth
	$__iLineNumber=1875 & ' - $aPicParameters[1] = $iHeight•./Include/_MyFunction.au3'
	$aPicParameters[1] = $iHeight
	$__iLineNumber=1876 & ' - $aPicParameters[2] = $iX•./Include/_MyFunction.au3'
	$aPicParameters[2] = $iX
	$__iLineNumber=1877 & ' - $aPicParameters[3] = $iY•./Include/_MyFunction.au3'
	$aPicParameters[3] = $iY
	$__iLineNumber=1878 & ' - _GDIPlus_Imaging($iPathBlack_TEMP, $aPicParameters, $ImageWi ...•./Include/_MyFunction.au3'
	_GDIPlus_Imaging($iPathBlack_TEMP, $aPicParameters, $ImageWidth, $ImageHeight)
	$__iLineNumber=1879 & ' - $aPicParameters[0] = $ImageWidth•./Include/_MyFunction.au3'
	$aPicParameters[0] = $ImageWidth
	$__iLineNumber=1880 & ' - $aPicParameters[1] = $ImageHeight•./Include/_MyFunction.au3'
	$aPicParameters[1] = $ImageHeight
	$__iLineNumber=1881 & ' - $aPicParameters[2] = 0•./Include/_MyFunction.au3'
	$aPicParameters[2] = 0
	$__iLineNumber=1882 & ' - $aPicParameters[3] = 0•./Include/_MyFunction.au3'
	$aPicParameters[3] = 0
	$__iLineNumber=1883 & ' - $aPicParameters[4] = $ImageWidth•./Include/_MyFunction.au3'
	$aPicParameters[4] = $ImageWidth
	$__iLineNumber=1884 & ' - $aPicParameters[5] = 0•./Include/_MyFunction.au3'
	$aPicParameters[5] = 0
	$__iLineNumber=1885 & ' - $aPicParameters[6] = 0•./Include/_MyFunction.au3'
	$aPicParameters[6] = 0
	$__iLineNumber=1886 & ' - $aPicParameters[7] = $ImageHeight•./Include/_MyFunction.au3'
	$aPicParameters[7] = $ImageHeight
	$__iLineNumber=1887 & ' - _GDIPlus_Imaging($iPathMask_TEMP, $aPicParameters, $ImageWid ...•./Include/_MyFunction.au3'
	_GDIPlus_Imaging($iPathMask_TEMP, $aPicParameters, $ImageWidth, $ImageHeight)
	$__iLineNumber=1888 & ' - _GDIPlus_Merge($iPathMask_TEMP, $iPathBlack_TEMP)•./Include/_MyFunction.au3'
	_GDIPlus_Merge($iPathMask_TEMP, $iPathBlack_TEMP)

	$__iLineNumber=1890 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=1891 & ' - $hImage = _GDIPlus_BitmapCreateFromFile($iPathMask_TEMP)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_BitmapCreateFromFile($iPathMask_TEMP)
	$__iLineNumber=1892 & ' - $hImage_Result = _GDIPlus_BitmapCreateFromScan0($ImageWidth, ...•./Include/_MyFunction.au3'
	$hImage_Result = _GDIPlus_BitmapCreateFromScan0($ImageWidth, $ImageHeight)
	$__iLineNumber=1893 & ' - $hImage_Result_Ctxt = _GDIPlus_ImageGetGraphicsContext($hIma ...•./Include/_MyFunction.au3'
	$hImage_Result_Ctxt = _GDIPlus_ImageGetGraphicsContext($hImage_Result)

	$__iLineNumber=1895 & ' - $hIA = _GDIPlus_ImageAttributesCreate()•./Include/_MyFunction.au3'
	$hIA = _GDIPlus_ImageAttributesCreate()
	$__iLineNumber=1896 & ' - _GDIPlus_ImageAttributesSetRemapTable($hIA, 1, True, $aRemap ...•./Include/_MyFunction.au3'
	_GDIPlus_ImageAttributesSetRemapTable($hIA, 1, True, $aRemapTable)
	$__iLineNumber=1897 & ' - _GDIPlus_GraphicsDrawImageRectRect($hImage_Result_Ctxt, $hIm ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImageRectRect($hImage_Result_Ctxt, $hImage, 0, 0, $ImageWidth, $ImageHeight, 0, 0, $ImageWidth, $ImageHeight, $hIA)
	$__iLineNumber=1898 & ' - _GDIPlus_ImageSaveToFile($hImage_Result, $iPathIMask)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hImage_Result, $iPathIMask)

	$__iLineNumber=1900 & ' - _GDIPlus_GraphicsDispose($hImage_Result_Ctxt)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hImage_Result_Ctxt)
	$__iLineNumber=1901 & ' - _GDIPlus_BitmapDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hImage)
	$__iLineNumber=1902 & ' - _GDIPlus_BitmapDispose($hImage_Result)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hImage_Result)
	$__iLineNumber=1903 & ' - _GDIPlus_ImageAttributesDispose($hIA)•./Include/_MyFunction.au3'
	_GDIPlus_ImageAttributesDispose($hIA)
	$__iLineNumber=1904 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=1905 & ' - FileDelete($iPathBlack_TEMP)•./Include/_MyFunction.au3'
	FileDelete($iPathBlack_TEMP)
	$__iLineNumber=1906 & ' - FileDelete($iPathWhite_TEMP)•./Include/_MyFunction.au3'
	FileDelete($iPathWhite_TEMP)
	$__iLineNumber=1907 & ' - FileDelete($iPathMask_TEMP)•./Include/_MyFunction.au3'
	FileDelete($iPathMask_TEMP)
EndFunc   ;==>_GDIPlus_CreateMask

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_ImageAttributesSetRemapTable
; Description ...: Put a Color in transparent
; Syntax.........: _GDIPlus_ImageAttributesSetRemapTable($hImageAttributes, $iColorAdjustType = 0, $fEnable = False, $aColorMap = 0)
; Parameters ....: $hImageAttributes	-
;                  $iColorAdjustType	-
;                  $fEnable				-
;                  $aColorMap			-
; Return values .: Return
; Author ........:
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; https://www.autoitscript.com/forum/topic/165975-bmp-to-png-with-transparent-color/
$__iLineNumber=1925 & ' - Func _GDIPlus_ImageAttributesSetRemapTable($hImageAttributes ...•./Include/_MyFunction.au3'
Func _GDIPlus_ImageAttributesSetRemapTable($hImageAttributes, $iColorAdjustType = 0, $fEnable = False, $aColorMap = 0)
	$__iLineNumber=1926 & ' - Local $iI, $iCount, $tColorMap, $aResult•./Include/_MyFunction.au3'
	Local $iI, $iCount, $tColorMap, $aResult
	$__iLineNumber=1927 & ' - If IsArray($aColorMap) And UBound($aColorMap) > 1 Then•./Include/_MyFunction.au3'
	If IsArray($aColorMap) And UBound($aColorMap) > 1 Then
		$__iLineNumber=1928 & ' - $iCount = $aColorMap[0][0]•./Include/_MyFunction.au3'
		$iCount = $aColorMap[0][0]
		$__iLineNumber=1929 & ' - $tColorMap = DllStructCreate("uint ColorMap[" & $iCount * 2  ...•./Include/_MyFunction.au3'
		$tColorMap = DllStructCreate("uint ColorMap[" & $iCount * 2 & "]")
		$__iLineNumber=1930 & ' - For $iI = 1 To $iCount•./Include/_MyFunction.au3'
		For $iI = 1 To $iCount
			$__iLineNumber=1931 & ' - $tColorMap.ColorMap((2 * $iI - 1)) = $aColorMap[$iI][0]•./Include/_MyFunction.au3'
			$tColorMap.ColorMap((2 * $iI - 1)) = $aColorMap[$iI][0]
			$__iLineNumber=1932 & ' - $tColorMap.ColorMap((2 * $iI)) = $aColorMap[$iI][1]•./Include/_MyFunction.au3'
			$tColorMap.ColorMap((2 * $iI)) = $aColorMap[$iI][1]
		Next
		$__iLineNumber=1934 & ' - $aResult = DllCall($__g_hGDIPDll, "int", "GdipSetImageAttrib ...•./Include/_MyFunction.au3'
		$aResult = DllCall($__g_hGDIPDll, "int", "GdipSetImageAttributesRemapTable", "handle", $hImageAttributes, "int", $iColorAdjustType, "int", $fEnable, "int", $iCount, "struct*", $tColorMap)
		$__iLineNumber=1935 & ' - If @error Then Return SetError(@error, @extended, False)•./Include/_MyFunction.au3'
		If @error Then Return SetError(@error, @extended, False)
		$__iLineNumber=1936 & ' - If $aResult[0] Then Return SetError(10, $aResult[0], False)•./Include/_MyFunction.au3'
		If $aResult[0] Then Return SetError(10, $aResult[0], False)
		$__iLineNumber=1937 & ' - Return True•./Include/_MyFunction.au3'
		Return True
	EndIf
	$__iLineNumber=1939 & ' - Return SetError(11, 0, False)•./Include/_MyFunction.au3'
	Return SetError(11, 0, False)
EndFunc   ;==>_GDIPlus_ImageAttributesSetRemapTable
#EndRegion Not Used Function
