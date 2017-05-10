$__iLineNumber=0
; #VARIABLES/INCLUDES# ==================================================================
#include-once
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <InetConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GuiMenu.au3>
#include "_WinHttp.au3"
#include "_GraphGDIPlus.au3"

#Region MISC Function
; #FUNCTION# ===================================================================================================
; Name...........: _Unzip
; Description ...: Unzip with 7za
; Syntax.........: _Unzip($iPathZip , $iPathTarget)
; Parameters ....: $iPathZip	- Zip Path
;~ 				   $iPathTarget	- Target folder path
; Return values .: Success      - Return the target folder path
;                  Failure      - -1
; Author ........: Screech inspiration : wakillon
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; https://www.autoitscript.com/forum/topic/122168-tinypicsharer-v-1034-new-version-08-june-2013/
$__iLineNumber=29 & ' - Func _Unzip($iPathZip, $iPathTarget)•./Include/_MyFunction.au3'
Func _Unzip($iPathZip, $iPathTarget)
	$__iLineNumber=30 & ' - Local $sRun, $iPid, $_StderrRead•./Include/_MyFunction.au3'
	Local $sRun, $iPid, $_StderrRead
	$__iLineNumber=31 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=32 & ' - _PathSplit($iPathZip, $sDrive, $sDir, $sFileName, $iExtensio ...•./Include/_MyFunction.au3'
	_PathSplit($iPathZip, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=33 & ' - If StringLower($iExtension) <> ".zip" Then•./Include/_MyFunction.au3'
	If StringLower($iExtension) <> ".zip" Then
		$__iLineNumber=34 & ' - _LOG("Not a ZIP file : " & $iPathZip, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Not a ZIP file : " & $iPathZip, 2, $iLOGPath)
		$__iLineNumber=35 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=37 & ' - $sRun = """ & $iScriptPath & "\Ressources\7za.exe" x "" & $i ...•./Include/_MyFunction.au3'
	$sRun = '"' & $iScriptPath & '\Ressources\7za.exe" x "' & $iPathZip & '" -o"' & $iPathTarget & '" -aoa'
	$__iLineNumber=38 & ' - _LOG("7za command: " & $sRun, 1, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG("7za command: " & $sRun, 1, $iLOGPath)
	$__iLineNumber=39 & ' - $iPid = Run($sRun, "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHI ...•./Include/_MyFunction.au3'
	$iPid = Run($sRun, '', @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	$__iLineNumber=40 & ' - While ProcessExists($iPid)•./Include/_MyFunction.au3'
	While ProcessExists($iPid)
		$__iLineNumber=41 & ' - $_StderrRead = StderrRead($iPid)•./Include/_MyFunction.au3'
		$_StderrRead = StderrRead($iPid)
		$__iLineNumber=42 & ' - If Not @error And $_StderrRead <> "" Then•./Include/_MyFunction.au3'
		If Not @error And $_StderrRead <> '' Then
			$__iLineNumber=43 & ' - If StringInStr($_StderrRead, "ERRORS") And Not StringInStr($ ...•./Include/_MyFunction.au3'
			If StringInStr($_StderrRead, 'ERRORS') And Not StringInStr($_StderrRead, 'Everything is Ok') Then
				$__iLineNumber=44 & ' - _LOG("Error while unziping " & $iPathZip, 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG("Error while unziping " & $iPathZip, 2, $iLOGPath)
				$__iLineNumber=45 & ' - Return -2•./Include/_MyFunction.au3'
				Return -2
			EndIf
		EndIf
	WEnd
	$__iLineNumber=49 & ' - _LOG("Unziped : " & $iPathZip & " to " & $iPathTarget, 0, $i ...•./Include/_MyFunction.au3'
	_LOG("Unziped : " & $iPathZip & " to " & $iPathTarget, 0, $iLOGPath)
	$__iLineNumber=50 & ' - Return $iPathTarget•./Include/_MyFunction.au3'
	Return $iPathTarget
EndFunc   ;==>_Unzip


; #FUNCTION# ===================================================================================================
; Name...........: _URIEncode
; Description ...: Create a valid URL
; Syntax.........: _URIEncode($sData)
; Parameters ....: $sData	- string to Encode
; Return values .:
; Author ........: ProgAndy
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........; https://www.autoitscript.com/forum/topic/95850-url-encoding/
; Example .......; No
$__iLineNumber=66 & ' - Func _URIEncode($sData)•./Include/_MyFunction.au3'
Func _URIEncode($sData)
	$__iLineNumber=67 & ' - Local $aData = StringSplit(BinaryToString(StringToBinary($sD ...•./Include/_MyFunction.au3'
	Local $aData = StringSplit(BinaryToString(StringToBinary($sData, 4), 1), "")
	$__iLineNumber=68 & ' - Local $nChar•./Include/_MyFunction.au3'
	Local $nChar
	$__iLineNumber=69 & ' - $sData = ""•./Include/_MyFunction.au3'
	$sData = ""
	$__iLineNumber=70 & ' - For $I = 1 To $aData[0]•./Include/_MyFunction.au3'
	For $I = 1 To $aData[0]
		$__iLineNumber=71 & ' - $nChar = Asc($aData[$I])•./Include/_MyFunction.au3'
		$nChar = Asc($aData[$I])
		$__iLineNumber=72 & ' - Switch $nChar•./Include/_MyFunction.au3'
		$__iLineNumber=73 & ' - Case 45, 46, 48 - 57, 65 To 90, 95, 97 To 122, 126•./Include/_MyFunction.au3'
		Switch $nChar
			Case 45, 46, 48 - 57, 65 To 90, 95, 97 To 122, 126
				$__iLineNumber=74 & ' - $sData &= $aData[$I]•./Include/_MyFunction.au3'
				$sData &= $aData[$I]
			$__iLineNumber=75 & ' - Case 32•./Include/_MyFunction.au3'
			Case 32
				$__iLineNumber=76 & ' - $sData &= "+"•./Include/_MyFunction.au3'
				$sData &= "+"
			Case Else
				$__iLineNumber=78 & ' - $sData &= "%" & Hex($nChar, 2)•./Include/_MyFunction.au3'
				$sData &= "%" & Hex($nChar, 2)
		EndSwitch
	Next
	$__iLineNumber=81 & ' - Return $sData•./Include/_MyFunction.au3'
	Return $sData
EndFunc   ;==>_URIEncode

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
$__iLineNumber=96 & ' - Func _LOG_Ceation($iLOGPathC = @ScriptDir & "\Log.txt")•./Include/_MyFunction.au3'
Func _LOG_Ceation($iLOGPathC = @ScriptDir & "\Log.txt")
	$__iLineNumber=97 & ' - Local $iVersion•./Include/_MyFunction.au3'
	Local $iVersion
	$__iLineNumber=98 & ' - If @Compiled Then•./Include/_MyFunction.au3'
	If @Compiled Then
		$__iLineNumber=99 & ' - $iVersion = FileGetVersion(@ScriptFullPath)•./Include/_MyFunction.au3'
		$iVersion = FileGetVersion(@ScriptFullPath)
	Else
		$__iLineNumber=101 & ' - $iVersion = "In Progress"•./Include/_MyFunction.au3'
		$iVersion = 'In Progress'
	EndIf
	$__iLineNumber=103 & ' - FileDelete($iLOGPathC)•./Include/_MyFunction.au3'
	FileDelete($iLOGPathC)
	$__iLineNumber=104 & ' - If Not _FileCreate($iLOGPathC) Then MsgBox(4096, "Error", "  ...•./Include/_MyFunction.au3'
	If Not _FileCreate($iLOGPathC) Then MsgBox(4096, "Error", " Erreur creation du Fichier LOG      error:" & @error)
	$__iLineNumber=105 & ' - _LOG(@ScriptFullPath & " (" & $iVersion & ")", 0, $iLOGPathC ...•./Include/_MyFunction.au3'
	_LOG(@ScriptFullPath & " (" & $iVersion & ")", 0, $iLOGPathC)
	$__iLineNumber=106 & ' - _LOG(@OSVersion & "(" & @OSArch & ") - " & @OSLang, 0, $iLOG ...•./Include/_MyFunction.au3'
	_LOG(@OSVersion & "(" & @OSArch & ") - " & @OSLang, 0, $iLOGPathC)
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
$__iLineNumber=123 & ' - Func _LOG($iMessage = "", $iLOGType = 0, $iLOGPath = @Script ...•./Include/_MyFunction.au3'
Func _LOG($iMessage = "", $iLOGType = 0, $iLOGPath = @ScriptDir & "\Log.txt")
	$__iLineNumber=124 & ' - Local $tCur, $dtCur, $iTimestamp•./Include/_MyFunction.au3'
	Local $tCur, $dtCur, $iTimestamp
;~ 	Local $iVerboseLVL = IniRead($iINIPath, "GENERAL", "$vVerbose", 0)
	$__iLineNumber=126 & ' - $tCur = _Date_Time_GetLocalTime()•./Include/_MyFunction.au3'
	$tCur = _Date_Time_GetLocalTime()
	$__iLineNumber=127 & ' - $dtCur = _Date_Time_SystemTimeToArray($tCur)•./Include/_MyFunction.au3'
	$dtCur = _Date_Time_SystemTimeToArray($tCur)
	$__iLineNumber=128 & ' - $iTimestamp = "[" & StringRight("0" & $dtCur[3], 2) & ":" &  ...•./Include/_MyFunction.au3'
	$iTimestamp = "[" & StringRight("0" & $dtCur[3], 2) & ":" & StringRight("0" & $dtCur[4], 2) & ":" & StringRight("0" & $dtCur[5], 2) & "] - "
	$__iLineNumber=129 & ' - Switch $iLOGType•./Include/_MyFunction.au3'
	$__iLineNumber=130 & ' - Case 0•./Include/_MyFunction.au3'
	Switch $iLOGType
		Case 0
			$__iLineNumber=131 & ' - FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)•./Include/_MyFunction.au3'
			FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)
			$__iLineNumber=132 & ' - ConsoleWrite($iMessage & @CRLF)•./Include/_MyFunction.au3'
			ConsoleWrite($iMessage & @CRLF)
		$__iLineNumber=133 & ' - Case 1•./Include/_MyFunction.au3'
		Case 1
			$__iLineNumber=134 & ' - If $iLOGType <= $iVerboseLVL Then FileWrite($iLOGPath, $iTim ...•./Include/_MyFunction.au3'
			If $iLOGType <= $iVerboseLVL Then FileWrite($iLOGPath, $iTimestamp & "> " & $iMessage & @CRLF)
			$__iLineNumber=135 & ' - ConsoleWrite("+" & $iMessage & @CRLF)•./Include/_MyFunction.au3'
			ConsoleWrite("+" & $iMessage & @CRLF)
		$__iLineNumber=136 & ' - Case 2•./Include/_MyFunction.au3'
		Case 2
			$__iLineNumber=137 & ' - If $iLOGType <= $iVerboseLVL Then•./Include/_MyFunction.au3'
			If $iLOGType <= $iVerboseLVL Then
				$__iLineNumber=138 & ' - FileWrite($iLOGPath, $iTimestamp & "/!\ " & $iMessage & @CRL ...•./Include/_MyFunction.au3'
				FileWrite($iLOGPath, $iTimestamp & "/!\ " & $iMessage & @CRLF)
			EndIf
			$__iLineNumber=140 & ' - ConsoleWrite("!" & $iMessage & @CRLF)•./Include/_MyFunction.au3'
			ConsoleWrite("!" & $iMessage & @CRLF)
		$__iLineNumber=141 & ' - Case 3•./Include/_MyFunction.au3'
		Case 3
;~ 			FileWrite($iLOGPath, $iTimestamp & $iMessage & @CRLF)
			$__iLineNumber=143 & ' - ConsoleWrite(">----" & $iMessage & @CRLF)•./Include/_MyFunction.au3'
			ConsoleWrite(">----" & $iMessage & @CRLF)
	EndSwitch
EndFunc   ;==>_LOG

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckURL
; Description ...: Check if an URL Exist
; Syntax ........: _CheckURL($vUrl)
; Parameters ....: $vUrl            - URL to test
; Return values .: Success - 1
;                  Failure - -1 (known error)
;~ 							 -2 (Unknown error)
; Author ........: Screech
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
$__iLineNumber=162 & ' - Func _CheckUrl($vUrl = "https://www.screenscraper.fr/api/ssu ...•./Include/_MyFunction.au3'
Func _CheckUrl($vUrl = "https://www.screenscraper.fr/api/ssuserInfos.php")
	$__iLineNumber=163 & ' - _LOG("Testing : " & $vUrl, 3, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG("Testing : " & $vUrl, 3, $iLOGPath)
	$__iLineNumber=164 & ' - Local $Timer = TimerInit()•./Include/_MyFunction.au3'
	Local $Timer = TimerInit()
	$__iLineNumber=165 & ' - Local $aURL = _WinHttpCrackUrl($vUrl)•./Include/_MyFunction.au3'
	Local $aURL = _WinHttpCrackUrl($vUrl)
	$__iLineNumber=166 & ' - Local $sScheme = $aURL[0]•./Include/_MyFunction.au3'
	Local $sScheme = $aURL[0]
	$__iLineNumber=167 & ' - Local $sDomain = $aURL[2]•./Include/_MyFunction.au3'
	Local $sDomain = $aURL[2]
	$__iLineNumber=168 & ' - Local $sPage = $aURL[6]•./Include/_MyFunction.au3'
	Local $sPage = $aURL[6]
	$__iLineNumber=169 & ' - Local $sExtra = $aURL[7]•./Include/_MyFunction.au3'
	Local $sExtra = $aURL[7]
;~  	_ArrayDisplay($aURL) ; Debug
	; Initialize and get session handle
	$__iLineNumber=172 & ' - Local $hOpen = _WinHttpOpen()•./Include/_MyFunction.au3'
	Local $hOpen = _WinHttpOpen()
	; Get connection handle
	$__iLineNumber=174 & ' - Local $hConnect = _WinHttpConnect($hOpen, $sDomain)•./Include/_MyFunction.au3'
	Local $hConnect = _WinHttpConnect($hOpen, $sDomain)
	; Make a Simple request
	$__iLineNumber=176 & ' - Switch $sScheme•./Include/_MyFunction.au3'
	$__iLineNumber=177 & ' - Case "http"•./Include/_MyFunction.au3'
	Switch $sScheme
		Case "http"
			$__iLineNumber=178 & ' - _LOG($sScheme & " Request", 3, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG($sScheme & " Request", 3, $iLOGPath)
			$__iLineNumber=179 & ' - $hRequest = _WinHttpSimpleSendRequest($hConnect, Default, $s ...•./Include/_MyFunction.au3'
			$hRequest = _WinHttpSimpleSendRequest($hConnect, Default, $sPage & $sExtra)
		$__iLineNumber=180 & ' - Case "https"•./Include/_MyFunction.au3'
		Case "https"
			$__iLineNumber=181 & ' - _LOG($sScheme & " Request", 3, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG($sScheme & " Request", 3, $iLOGPath)
			$__iLineNumber=182 & ' - $hRequest = _WinHttpSimpleSendSSLRequest($hConnect, Default, ...•./Include/_MyFunction.au3'
			$hRequest = _WinHttpSimpleSendSSLRequest($hConnect, Default, $sPage & $sExtra)
		Case Else
			$__iLineNumber=184 & ' - _LOG($sScheme & " - Not an HTTP or HTTPS url", 2, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG($sScheme & " - Not an HTTP or HTTPS url", 2, $iLOGPath)
	EndSwitch
	; Get full header
	$__iLineNumber=187 & ' - Local $sReturned = StringMid(_WinHttpQueryHeaders($hRequest) ...•./Include/_MyFunction.au3'
	Local $sReturned = StringMid(_WinHttpQueryHeaders($hRequest), 10, 3)
	; See what's returned
	$__iLineNumber=189 & ' - Switch $sReturned•./Include/_MyFunction.au3'
	$__iLineNumber=190 & ' - Case 200•./Include/_MyFunction.au3'
	Switch $sReturned
		Case 200
			$__iLineNumber=191 & ' - _LOG($sDomain & $sPage & " - OK (200) - " & Round((TimerDiff ...•./Include/_MyFunction.au3'
			_LOG($sDomain & $sPage & " - OK (200) - " & Round((TimerDiff($Timer) / 1000), 2) & "s", 3, $iLOGPath)
			$__iLineNumber=192 & ' - Return 1•./Include/_MyFunction.au3'
			Return 1
		$__iLineNumber=193 & ' - Case 400•./Include/_MyFunction.au3'
		Case 400
			$__iLineNumber=194 & ' - _LOG($sDomain & $sPage & " - Problème dans les parametres d" ...•./Include/_MyFunction.au3'
			_LOG($sDomain & $sPage & " - Problème dans les parametres d'url - " & Round((TimerDiff($Timer) / 1000), 2) & "s", 2, $iLOGPath)
			$__iLineNumber=195 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		$__iLineNumber=196 & ' - Case 401•./Include/_MyFunction.au3'
		Case 401
			$__iLineNumber=197 & ' - _LOG($sDomain & $sPage & " - API fermé pour les non-inscrit  ...•./Include/_MyFunction.au3'
			_LOG($sDomain & $sPage & " - API fermé pour les non-inscrit a ScreenScraper / les membres inactifs - " & Round((TimerDiff($Timer) / 1000), 2) & "s", 2, $iLOGPath)
			$__iLineNumber=198 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		$__iLineNumber=199 & ' - Case 403•./Include/_MyFunction.au3'
		Case 403
			$__iLineNumber=200 & ' - _LOG($sDomain & $sPage & " - Erreur de login developpeur - " ...•./Include/_MyFunction.au3'
			_LOG($sDomain & $sPage & " - Erreur de login developpeur - " & Round((TimerDiff($Timer) / 1000), 2) & "s", 2, $iLOGPath)
			$__iLineNumber=201 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		$__iLineNumber=202 & ' - Case 404•./Include/_MyFunction.au3'
		Case 404
			$__iLineNumber=203 & ' - _LOG($sDomain & $sPage & " - Aucune concordance trouvée ! -  ...•./Include/_MyFunction.au3'
			_LOG($sDomain & $sPage & " - Aucune concordance trouvée ! - " & Round((TimerDiff($Timer) / 1000), 2) & "s", 2, $iLOGPath)
			$__iLineNumber=204 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		$__iLineNumber=205 & ' - Case 426•./Include/_MyFunction.au3'
		Case 426
			$__iLineNumber=206 & ' - _LOG($sDomain & $sPage & " - Le logiciel de scrap a été bloq ...•./Include/_MyFunction.au3'
			_LOG($sDomain & $sPage & " - Le logiciel de scrap a été bloqué par ScreenScraper (gestion des versions obsolètes de logiciel ou non conforme aux régles de ScreenScraper) - " & Round((TimerDiff($Timer) / 1000), 2) & "s", 2, $iLOGPath)
			$__iLineNumber=207 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		$__iLineNumber=208 & ' - Case 429•./Include/_MyFunction.au3'
		Case 429
			$__iLineNumber=209 & ' - _LOG($sDomain & $sPage & " - Nombre de connexions en cours s ...•./Include/_MyFunction.au3'
			_LOG($sDomain & $sPage & " - Nombre de connexions en cours supérieur au nombres de connexions maximum autorisés - " & Round((TimerDiff($Timer) / 1000), 2) & "s", 2, $iLOGPath)
			$__iLineNumber=210 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		Case Else
			$__iLineNumber=212 & ' - _LOG($sDomain & $sPage & " - No referenced Status : " & $sRe ...•./Include/_MyFunction.au3'
			_LOG($sDomain & $sPage & " - No referenced Status : " & $sReturned & " - " & Round((TimerDiff($Timer) / 1000), 2) & "s", 2, $iLOGPath)
			$__iLineNumber=213 & ' - Return -2•./Include/_MyFunction.au3'
			Return -2
	EndSwitch
	; Close handles when they are not needed any more
	$__iLineNumber=216 & ' - _WinHttpCloseHandle($hRequest)•./Include/_MyFunction.au3'
	_WinHttpCloseHandle($hRequest)
	$__iLineNumber=217 & ' - _WinHttpCloseHandle($hConnect)•./Include/_MyFunction.au3'
	_WinHttpCloseHandle($hConnect)
	$__iLineNumber=218 & ' - _WinHttpCloseHandle($hOpen)•./Include/_MyFunction.au3'
	_WinHttpCloseHandle($hOpen)
EndFunc   ;==>_CheckUrl

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckURL2
; Description ...: Check if an URL Exist
; Syntax ........: _CheckURL2($sTestUrl)
; Parameters ....: $sTestUrl            - URL to test
; Return values .: Success - 1
;                  Failure - 0
; Author ........: DaleHohm
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........: https://www.autoitscript.com/forum/topic/22343-is-there-a-way-to-check-if-a-url-exists-without-calling-it/
; Example .......:
; ===============================================================================================================================
$__iLineNumber=235 & ' - Func _CheckURL2($sTestUrl = "https://www.screenscraper.fr/ap ...•./Include/_MyFunction.au3'
Func _CheckURL2($sTestUrl = "https://www.screenscraper.fr/api/ssuserInfos.php")
	$__iLineNumber=236 & ' - $sTestUrl = "http://www.google.fr"•./Include/_MyFunction.au3'
	$sTestUrl = "http://www.google.fr"
	$__iLineNumber=237 & ' - _LOG("Test de l"URL : " & $sTestUrl, 0, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG("Test de l'URL : " & $sTestUrl, 0, $iLOGPath)

	$__iLineNumber=239 & ' - Local $Timer = TimerInit()•./Include/_MyFunction.au3'
	Local $Timer = TimerInit()
	$__iLineNumber=240 & ' - $oHttpRequest = ""•./Include/_MyFunction.au3'
	$oHttpRequest = ""
	$__iLineNumber=241 & ' - $oHttpRequest = ObjCreate("MSXML2.ServerXMLHTTP")•./Include/_MyFunction.au3'
	$oHttpRequest = ObjCreate("MSXML2.ServerXMLHTTP")
	$__iLineNumber=242 & ' - $ResolveTimeout = 500•./Include/_MyFunction.au3'
	$ResolveTimeout = 500
	$__iLineNumber=243 & ' - $ConnectTimeout = 500•./Include/_MyFunction.au3'
	$ConnectTimeout = 500
	$__iLineNumber=244 & ' - $SendTimeout = 500•./Include/_MyFunction.au3'
	$SendTimeout = 500
	$__iLineNumber=245 & ' - $ReceiveTimeout = 500•./Include/_MyFunction.au3'
	$ReceiveTimeout = 500

	$__iLineNumber=247 & ' - $oHttpRequest.SetTimeouts($ResolveTimeout, $ConnectTimeout,  ...•./Include/_MyFunction.au3'
	$oHttpRequest.SetTimeouts($ResolveTimeout, $ConnectTimeout, $SendTimeout, $ReceiveTimeout)
	$__iLineNumber=248 & ' - $oHttpRequest.Open("GET", $sTestUrl)•./Include/_MyFunction.au3'
	$oHttpRequest.Open("GET", $sTestUrl)
	$__iLineNumber=249 & ' - $oHttpRequest.Send•./Include/_MyFunction.au3'
	$oHttpRequest.Send
	$__iLineNumber=250 & ' - $urlStatus = $oHttpRequest.Status•./Include/_MyFunction.au3'
	$urlStatus = $oHttpRequest.Status

;~     Local $oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
;~     $oHTTP.Open("HEAD", $sTestUrl, False)
;~     If @error Then _LOG("Opening HEAD error", 2, $iLOGPath)
;~     $oHTTP.Send()
;~     If @error Then _LOG("Error 105 (net::ERR_NAME_NOT_RESOLVED)", 2, $iLOGPath)
;~     Local $urlStatus = $oHTTP.Status
;~     If @error Then _LOG("Error 118 (net::ERR_CONNECTION_TIMED_OUT)", 2, $iLOGPath)

	$__iLineNumber=260 & ' - _LOG("Timer : " & Round((TimerDiff($Timer) / 1000), 2), 0, $ ...•./Include/_MyFunction.au3'
	_LOG("Timer : " & Round((TimerDiff($Timer) / 1000), 2), 0, $iLOGPath)

	$__iLineNumber=262 & ' - Switch $urlStatus•./Include/_MyFunction.au3'
	$__iLineNumber=263 & ' - Case 200•./Include/_MyFunction.au3'
	Switch $urlStatus
		Case 200
			$__iLineNumber=264 & ' - _LOG($sTestUrl & " OK (200)", 3, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG($sTestUrl & " OK (200)", 3, $iLOGPath)
			$__iLineNumber=265 & ' - Return 1•./Include/_MyFunction.au3'
			Return 1
		$__iLineNumber=266 & ' - Case 404•./Include/_MyFunction.au3'
		Case 404
			$__iLineNumber=267 & ' - _LOG("Connection Successful! (" & $urlStatus & ") - URL Not  ...•./Include/_MyFunction.au3'
			_LOG("Connection Successful! (" & $urlStatus & ") - URL Not Found: " & $sTestUrl, 2, $iLOGPath)
			$__iLineNumber=268 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		$__iLineNumber=269 & ' - Case 105•./Include/_MyFunction.au3'
		Case 105
			$__iLineNumber=270 & ' - _LOG("Connection error: ERR_NAME_NOT_RESOLVED (" & $urlStatu ...•./Include/_MyFunction.au3'
			_LOG("Connection error: ERR_NAME_NOT_RESOLVED (" & $urlStatus & ") - URL is Not Found: " & $sTestUrl, 2, $iLOGPath)
			$__iLineNumber=271 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		Case Else
			$__iLineNumber=273 & ' - _LOG("Connection error! (" & $urlStatus & ") - URL: " & $sTe ...•./Include/_MyFunction.au3'
			_LOG("Connection error! (" & $urlStatus & ") - URL: " & $sTestUrl, 2, $iLOGPath)
			$__iLineNumber=274 & ' - Return -2•./Include/_MyFunction.au3'
			Return -2
	EndSwitch
EndFunc   ;==>_CheckURL2

; #FUNCTION# ===================================================================================================
; Name...........: _Download
; Description ...: Download URL to a file with @Error and TimeOut
; Syntax.........: _Download($iURL, $iPath, $iTimeOut = 20, $iCRC = default)
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
$__iLineNumber=294 & ' - Func _Download($iURL, $iPath, $iTimeOut = 50, $iCRC = Defaul ...•./Include/_MyFunction.au3'
Func _Download($iURL, $iPath, $iTimeOut = 50, $iCRC = Default)
	$__iLineNumber=295 & ' - Local $inetgettime = 0, $aData, $hDownload, $vDataDL = 0•./Include/_MyFunction.au3'
	Local $inetgettime = 0, $aData, $hDownload, $vDataDL = 0
	$__iLineNumber=296 & ' - If $iURL = "" Then•./Include/_MyFunction.au3'
	If $iURL = "" Then
		$__iLineNumber=297 & ' - _LOG("Nothing to Downloaded : " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Nothing to Downloaded : " & $iPath, 2, $iLOGPath)
		$__iLineNumber=298 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf

;~ 	If _CheckUrl($iURL) <0 Then Return -1

	$__iLineNumber=303 & ' - $hDownload = InetGet($iURL, $iPath, $INET_FORCERELOAD, $INET ...•./Include/_MyFunction.au3'
	$hDownload = InetGet($iURL, $iPath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
	Do
		Sleep(250)
		$__iLineNumber=306 & ' - $aData = InetGetInfo($hDownload)•./Include/_MyFunction.au3'
		$aData = InetGetInfo($hDownload)
		$__iLineNumber=307 & ' - If $aData[$INET_DOWNLOADREAD] > $vDataDL Then•./Include/_MyFunction.au3'
		If $aData[$INET_DOWNLOADREAD] > $vDataDL Then
			$__iLineNumber=308 & ' - $vDataDL = $aData[$INET_DOWNLOADREAD]•./Include/_MyFunction.au3'
			$vDataDL = $aData[$INET_DOWNLOADREAD]
		Else
			$__iLineNumber=310 & ' - $inetgettime = $inetgettime + 0.25•./Include/_MyFunction.au3'
			$inetgettime = $inetgettime + 0.25
		EndIf
		$__iLineNumber=312 & ' - If $inetgettime > $iTimeOut Then•./Include/_MyFunction.au3'
		If $inetgettime > $iTimeOut Then
			$__iLineNumber=313 & ' - InetClose($hDownload)•./Include/_MyFunction.au3'
			InetClose($hDownload)
			$__iLineNumber=314 & ' - _LOG("File Downloading URL : " & $iURL, 3, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG("File Downloading URL : " & $iURL, 3, $iLOGPath)
			$__iLineNumber=315 & ' - _LOG("Timed out (" & $inetgettime & "s) for downloading file ...•./Include/_MyFunction.au3'
			_LOG("Timed out (" & $inetgettime & "s) for downloading file : " & $iPath, 1, $iLOGPath)
			$__iLineNumber=316 & ' - FileDelete($iPath)•./Include/_MyFunction.au3'
			FileDelete($iPath)
			$__iLineNumber=317 & ' - Return -2•./Include/_MyFunction.au3'
			Return -2
		EndIf
	$__iLineNumber=319 & ' - Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE) ; Chec ...•./Include/_MyFunction.au3'
	Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE) ; Check if the download is complete.


	$__iLineNumber=322 & ' - $aData = InetGetInfo($hDownload)•./Include/_MyFunction.au3'
	$aData = InetGetInfo($hDownload)
	$__iLineNumber=323 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=324 & ' - _LOG("File Downloaded ERROR InetGetInfo : " & $iPath, 2, $iL ...•./Include/_MyFunction.au3'
		_LOG("File Downloaded ERROR InetGetInfo : " & $iPath, 2, $iLOGPath)
		$__iLineNumber=325 & ' - InetClose($hDownload)•./Include/_MyFunction.au3'
		InetClose($hDownload)
		$__iLineNumber=326 & ' - FileDelete($iPath)•./Include/_MyFunction.au3'
		FileDelete($iPath)
		$__iLineNumber=327 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf

	$__iLineNumber=330 & ' - InetClose($hDownload)•./Include/_MyFunction.au3'
	InetClose($hDownload)
	$__iLineNumber=331 & ' - If $aData[$INET_DOWNLOADSUCCESS] Then•./Include/_MyFunction.au3'
	If $aData[$INET_DOWNLOADSUCCESS] Then
		$__iLineNumber=332 & ' - If ($aData[$INET_DOWNLOADSIZE] <> 0 And $aData[$INET_DOWNLOA ...•./Include/_MyFunction.au3'
		If ($aData[$INET_DOWNLOADSIZE] <> 0 And $aData[$INET_DOWNLOADREAD] <> $aData[$INET_DOWNLOADSIZE]) Or FileGetSize($iPath) < 50 Then
			$__iLineNumber=333 & ' - _LOG("Error Downloading URL : " & $iURL, 3, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG("Error Downloading URL : " & $iURL, 3, $iLOGPath)
			$__iLineNumber=334 & ' - _LOG("Error Downloading File : " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG("Error Downloading File : " & $iPath, 2, $iLOGPath)
			$__iLineNumber=335 & ' - _LOG("Error File Line 1 : " & FileReadLine($iPath), 2, $iLOG ...•./Include/_MyFunction.au3'
			_LOG("Error File Line 1 : " & FileReadLine($iPath), 2, $iLOGPath)
			$__iLineNumber=336 & ' - _LOG("Bytes read: " & $aData[$INET_DOWNLOADREAD], 2, $iLOGPa ...•./Include/_MyFunction.au3'
			_LOG("Bytes read: " & $aData[$INET_DOWNLOADREAD], 2, $iLOGPath)
			$__iLineNumber=337 & ' - _LOG("Size: " & $aData[$INET_DOWNLOADSIZE], 2, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG("Size: " & $aData[$INET_DOWNLOADSIZE], 2, $iLOGPath)
			$__iLineNumber=338 & ' - FileDelete($iPath)•./Include/_MyFunction.au3'
			FileDelete($iPath)
			$__iLineNumber=339 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		EndIf

		$__iLineNumber=342 & ' - If $iCRC <> Default Then•./Include/_MyFunction.au3'
		If $iCRC <> Default Then
			$__iLineNumber=343 & ' - $vDlCRC = StringRight(_CRC32ForFile($iPath), 8)•./Include/_MyFunction.au3'
			$vDlCRC = StringRight(_CRC32ForFile($iPath), 8)
			$__iLineNumber=344 & ' - If $vDlCRC <> $iCRC Then•./Include/_MyFunction.au3'
			If $vDlCRC <> $iCRC Then
				$__iLineNumber=345 & ' - _LOG("Error CRC File (" & $vDlCRC & " <> " & $iCRC & ") : "  ...•./Include/_MyFunction.au3'
				_LOG("Error CRC File (" & $vDlCRC & " <> " & $iCRC & ") : " & $iPath, 2, $iLOGPath)
;~ 				Return -1
			Else
				$__iLineNumber=348 & ' - _LOG(">>> CRC OK (" & $vDlCRC & " = " & $iCRC & ") : " & $iP ...•./Include/_MyFunction.au3'
				_LOG(">>> CRC OK (" & $vDlCRC & " = " & $iCRC & ") : " & $iPath, 1, $iLOGPath)
			EndIf
		EndIf
		$__iLineNumber=351 & ' - _LOG("File Downloading URL : " & $iURL, 3, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("File Downloading URL : " & $iURL, 3, $iLOGPath)
		$__iLineNumber=352 & ' - _LOG("File Downloaded Path : " & $iPath, 1, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("File Downloaded Path : " & $iPath, 1, $iLOGPath)
		$__iLineNumber=353 & ' - Return $iPath•./Include/_MyFunction.au3'
		Return $iPath
	Else
		$__iLineNumber=355 & ' - _LOG("Error Downloading URL : " & $iURL, 3, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error Downloading URL : " & $iURL, 3, $iLOGPath)
		$__iLineNumber=356 & ' - _LOG("Error Downloading File : " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error Downloading File : " & $iPath, 2, $iLOGPath)
		$__iLineNumber=357 & ' - _LOG("Bytes read: " & $aData[$INET_DOWNLOADREAD], 2, $iLOGPa ...•./Include/_MyFunction.au3'
		_LOG("Bytes read: " & $aData[$INET_DOWNLOADREAD], 2, $iLOGPath)
		$__iLineNumber=358 & ' - _LOG("Size: " & $aData[$INET_DOWNLOADSIZE], 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Size: " & $aData[$INET_DOWNLOADSIZE], 2, $iLOGPath)
		$__iLineNumber=359 & ' - _LOG("Complete: " & $aData[$INET_DOWNLOADCOMPLETE], 2, $iLOG ...•./Include/_MyFunction.au3'
		_LOG("Complete: " & $aData[$INET_DOWNLOADCOMPLETE], 2, $iLOGPath)
		$__iLineNumber=360 & ' - _LOG("successful: " & $aData[$INET_DOWNLOADSUCCESS], 2, $iLO ...•./Include/_MyFunction.au3'
		_LOG("successful: " & $aData[$INET_DOWNLOADSUCCESS], 2, $iLOGPath)
		$__iLineNumber=361 & ' - _LOG("@error: " & $aData[$INET_DOWNLOADERROR], 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("@error: " & $aData[$INET_DOWNLOADERROR], 2, $iLOGPath)
		$__iLineNumber=362 & ' - _LOG("@extended: " & $aData[$INET_DOWNLOADEXTENDED], 2, $iLO ...•./Include/_MyFunction.au3'
		_LOG("@extended: " & $aData[$INET_DOWNLOADEXTENDED], 2, $iLOGPath)
		$__iLineNumber=363 & ' - FileDelete($iPath)•./Include/_MyFunction.au3'
		FileDelete($iPath)
		$__iLineNumber=364 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
EndFunc   ;==>_Download

; #FUNCTION# ===================================================================================================
; Name...........: _DownloadWRetry
; Description ...: Download URL to a file with @Error and TimeOut With Retry
; Syntax.........: _DownloadWRetry($iURL, $iPath, $iRetry = 3, $iTimeOut = 20, $iCRC = default)
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
$__iLineNumber=384 & ' - Func _DownloadWRetry($iURL, $iPath, $iRetry = 3, $iTimeOut = ...•./Include/_MyFunction.au3'
Func _DownloadWRetry($iURL, $iPath, $iRetry = 3, $iTimeOut = 50, $iCRC = Default)
	$__iLineNumber=385 & ' - Local $iCount = 0, $iResult = -1, $vTimer = TimerInit()•./Include/_MyFunction.au3'
	Local $iCount = 0, $iResult = -1, $vTimer = TimerInit()
	$__iLineNumber=386 & ' - While $iResult < 0 And $iCount < $iRetry•./Include/_MyFunction.au3'
	While $iResult < 0 And $iCount < $iRetry
		$__iLineNumber=387 & ' - $iCount = $iCount + 1•./Include/_MyFunction.au3'
		$iCount = $iCount + 1
		$__iLineNumber=388 & ' - $iResult = _Download($iURL, $iPath, $iTimeOut, $iCRC)•./Include/_MyFunction.au3'
		$iResult = _Download($iURL, $iPath, $iTimeOut, $iCRC)
	WEnd
	$__iLineNumber=390 & ' - _LOG("-In " & $iCount & " try and " & Round((TimerDiff($vTim ...•./Include/_MyFunction.au3'
	_LOG("-In " & $iCount & " try and " & Round((TimerDiff($vTimer) / 1000), 2) & "s", 1, $iLOGPath)
	$__iLineNumber=391 & ' - Return $iResult•./Include/_MyFunction.au3'
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
$__iLineNumber=408 & ' - Func _MultiLang_LoadLangDef($iLangPath, $vUserLang)•./Include/_MyFunction.au3'
Func _MultiLang_LoadLangDef($iLangPath, $vUserLang)
	;Create an array of available language files
	; ** n=0 is the default language file
	; [n][0] = Display Name in Local Language (Used for Select Function)
	; [n][1] = Language File (Full path.  In this case we used a $iLangPath
	; [n][2] = [Space delimited] Character codes as used by @OS_LANG (used to select correct lang file)
	$__iLineNumber=414 & ' - Local $aLangFiles[9][3]•./Include/_MyFunction.au3'
	Local $aLangFiles[9][3]

	$__iLineNumber=416 & ' - $aLangFiles[0][0] = "Français" ; French•./Include/_MyFunction.au3'
	$aLangFiles[0][0] = "Français" ; French
	$__iLineNumber=417 & ' - $aLangFiles[0][1] = $iLangPath & "\UXS-FRENCH.XML"•./Include/_MyFunction.au3'
	$aLangFiles[0][1] = $iLangPath & "\UXS-FRENCH.XML"
	$__iLineNumber=418 & ' - $aLangFiles[0][2] = "040c " & _ ;French_Standard•./Include/_MyFunction.au3'
	$aLangFiles[0][2] = "040c " & _ ;French_Standard
			"080c " & _ ;French_Belgian
			"0c0c " & _ ;French_Canadian
			"100c " & _ ;French_Swiss
			"140c " & _ ;French_Luxembourg
			"180c" ;French_Monaco

	$__iLineNumber=425 & ' - $aLangFiles[1][0] = "English (UK)" ;•./Include/_MyFunction.au3'
	$aLangFiles[1][0] = "English (UK)" ;
	$__iLineNumber=426 & ' - $aLangFiles[1][1] = $iLangPath & "\UXS-ENGLISHUK.XML"•./Include/_MyFunction.au3'
	$aLangFiles[1][1] = $iLangPath & "\UXS-ENGLISHUK.XML"
	$__iLineNumber=427 & ' - $aLangFiles[1][2] = "0809 " ;English_United_Kingdom•./Include/_MyFunction.au3'
	$aLangFiles[1][2] = "0809 " ;English_United_Kingdom

	$__iLineNumber=429 & ' - $aLangFiles[2][0] = "English (US)" ;•./Include/_MyFunction.au3'
	$aLangFiles[2][0] = "English (US)" ;
	$__iLineNumber=430 & ' - $aLangFiles[2][1] = $iLangPath & "\UXS-ENGLISHUS.XML"•./Include/_MyFunction.au3'
	$aLangFiles[2][1] = $iLangPath & "\UXS-ENGLISHUS.XML"
	$__iLineNumber=431 & ' - $aLangFiles[2][2] = "0409 " & _ ;English_United_States•./Include/_MyFunction.au3'
	$aLangFiles[2][2] = "0409 " & _ ;English_United_States
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

	$__iLineNumber=445 & ' - $aLangFiles[3][0] = "Espanol" ; Spanish•./Include/_MyFunction.au3'
	$aLangFiles[3][0] = "Espanol" ; Spanish
	$__iLineNumber=446 & ' - $aLangFiles[3][1] = $iLangPath & "\UXS-SPANISH.XML"•./Include/_MyFunction.au3'
	$aLangFiles[3][1] = $iLangPath & "\UXS-SPANISH.XML"
	$__iLineNumber=447 & ' - $aLangFiles[3][2] = "040A " & _ ;Spanish - Spain•./Include/_MyFunction.au3'
	$aLangFiles[3][2] = "040A " & _ ;Spanish - Spain
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

	$__iLineNumber=469 & ' - $aLangFiles[4][0] = "Deutsch" ; German•./Include/_MyFunction.au3'
	$aLangFiles[4][0] = "Deutsch" ; German
	$__iLineNumber=470 & ' - $aLangFiles[4][1] = $iLangPath & "\UXS-GERMAN.XML"•./Include/_MyFunction.au3'
	$aLangFiles[4][1] = $iLangPath & "\UXS-GERMAN.XML"
	$__iLineNumber=471 & ' - $aLangFiles[4][2] = "0407 " & _ ;German - Germany•./Include/_MyFunction.au3'
	$aLangFiles[4][2] = "0407 " & _ ;German - Germany
			"0807 " & _ ;German - Switzerland
			"0C07 " & _ ;German - Austria
			"1007 " & _ ;German - Luxembourg
			"1407 " ;German - Liechtenstein

	$__iLineNumber=477 & ' - $aLangFiles[5][0] = "Portugues" ; Portuguese•./Include/_MyFunction.au3'
	$aLangFiles[5][0] = "Portugues" ; Portuguese
	$__iLineNumber=478 & ' - $aLangFiles[5][1] = $iLangPath & "\UXS-PORTUGUESE.XML"•./Include/_MyFunction.au3'
	$aLangFiles[5][1] = $iLangPath & "\UXS-PORTUGUESE.XML"
	$__iLineNumber=479 & ' - $aLangFiles[5][2] = "0816 " & _ ;Portuguese - Portugal•./Include/_MyFunction.au3'
	$aLangFiles[5][2] = "0816 " & _ ;Portuguese - Portugal
			"0416 " ;Portuguese - Brazil

	$__iLineNumber=482 & ' - $aLangFiles[6][0] = "Italian" ; Italian•./Include/_MyFunction.au3'
	$aLangFiles[6][0] = "Italian" ; Italian
	$__iLineNumber=483 & ' - $aLangFiles[6][1] = $iLangPath & "\UXS-ITALIAN.XML"•./Include/_MyFunction.au3'
	$aLangFiles[6][1] = $iLangPath & "\UXS-ITALIAN.XML"
	$__iLineNumber=484 & ' - $aLangFiles[6][2] = "0410 " & _ ;Italian - Italy•./Include/_MyFunction.au3'
	$aLangFiles[6][2] = "0410 " & _ ;Italian - Italy
			"0810 " ;Italian - Switzerland

	$__iLineNumber=487 & ' - $aLangFiles[7][0] = "Dutch" ; Dutch•./Include/_MyFunction.au3'
	$aLangFiles[7][0] = "Dutch" ; Dutch
	$__iLineNumber=488 & ' - $aLangFiles[7][1] = $iLangPath & "\UXS-DUTCH.XML"•./Include/_MyFunction.au3'
	$aLangFiles[7][1] = $iLangPath & "\UXS-DUTCH.XML"
	$__iLineNumber=489 & ' - $aLangFiles[7][2] = "0413 " & _ ;Dutch - Netherlands•./Include/_MyFunction.au3'
	$aLangFiles[7][2] = "0413 " & _ ;Dutch - Netherlands
			"0813 " ;Dutch - Belgium

	$__iLineNumber=492 & ' - $aLangFiles[8][0] = "Japanese" ; Japanese•./Include/_MyFunction.au3'
	$aLangFiles[8][0] = "Japanese" ; Japanese
	$__iLineNumber=493 & ' - $aLangFiles[8][1] = $iLangPath & "\UXS-JAPANESE.XML"•./Include/_MyFunction.au3'
	$aLangFiles[8][1] = $iLangPath & "\UXS-JAPANESE.XML"
	$__iLineNumber=494 & ' - $aLangFiles[8][2] = "0411 " ;Japanese - Japan•./Include/_MyFunction.au3'
	$aLangFiles[8][2] = "0411 " ;Japanese - Japan

	;Set the available language files, names, and codes.
	$__iLineNumber=497 & ' - _MultiLang_SetFileInfo($aLangFiles)•./Include/_MyFunction.au3'
	_MultiLang_SetFileInfo($aLangFiles)
	$__iLineNumber=498 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=499 & ' - MsgBox(48, "Error", "Could not set file info.  Error Code "  ...•./Include/_MyFunction.au3'
		MsgBox(48, "Error", "Could not set file info.  Error Code " & @error)
		$__iLineNumber=500 & ' - _LOG("Could not set file info.  Error Code " & @error, 2, $i ...•./Include/_MyFunction.au3'
		_LOG("Could not set file info.  Error Code " & @error, 2, $iLOGPath)
		Exit
	EndIf

	;Check if the loaded settings file exists.  If not ask user to select language.
	$__iLineNumber=505 & ' - If $vUserLang = -1 Then•./Include/_MyFunction.au3'
	If $vUserLang = -1 Then
		;Create Selection GUI
		$__iLineNumber=507 & ' - _LOG("Loading language :" & StringLower(@OSLang), 1, $iLOGPa ...•./Include/_MyFunction.au3'
		_LOG("Loading language :" & StringLower(@OSLang), 1, $iLOGPath)
		$__iLineNumber=508 & ' - _MultiLang_LoadLangFile(StringLower(@OSLang))•./Include/_MyFunction.au3'
		_MultiLang_LoadLangFile(StringLower(@OSLang))
		$__iLineNumber=509 & ' - $vUserLang = _SelectGUI($aLangFiles, StringLower(@OSLang), " ...•./Include/_MyFunction.au3'
		$vUserLang = _SelectGUI($aLangFiles, StringLower(@OSLang), "langue", 1)
		$__iLineNumber=510 & ' - If @error Then•./Include/_MyFunction.au3'
		If @error Then
			$__iLineNumber=511 & ' - MsgBox(48, "Error", "Could not create selection GUI.  Error  ...•./Include/_MyFunction.au3'
			MsgBox(48, "Error", "Could not create selection GUI.  Error Code " & @error)
			$__iLineNumber=512 & ' - _LOG("Could not create selection GUI.  Error Code " & @error ...•./Include/_MyFunction.au3'
			_LOG("Could not create selection GUI.  Error Code " & @error, 2, $iLOGPath)
			Exit
		EndIf
		$__iLineNumber=515 & ' - IniWrite($iINIPath, "LAST_USE", "$vUserLang", $vUserLang)•./Include/_MyFunction.au3'
		IniWrite($iINIPath, "LAST_USE", "$vUserLang", $vUserLang)
	EndIf

	$__iLineNumber=518 & ' - _LOG("Language Selected : " & $vUserLang, 0, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG("Language Selected : " & $vUserLang, 0, $iLOGPath)

	;If you supplied an invalid $vUserLang, we will load the default language file
	$__iLineNumber=521 & ' - If _MultiLang_LoadLangFile($vUserLang) = 2 Then MsgBox(64, " ...•./Include/_MyFunction.au3'
	If _MultiLang_LoadLangFile($vUserLang) = 2 Then MsgBox(64, "Information", "Just letting you know that we loaded the default language file")
	$__iLineNumber=522 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=523 & ' - MsgBox(48, "Error", "Could not load lang file.  Error Code " ...•./Include/_MyFunction.au3'
		MsgBox(48, "Error", "Could not load lang file.  Error Code " & @error)
		$__iLineNumber=524 & ' - _LOG("Could not load lang file.  Error Code " & @error, 2, $ ...•./Include/_MyFunction.au3'
		_LOG("Could not load lang file.  Error Code " & @error, 2, $iLOGPath)
		Exit
	EndIf
	$__iLineNumber=527 & ' - Return $aLangFiles•./Include/_MyFunction.au3'
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
$__iLineNumber=546 & ' - Func _SelectGUI($aSelectionItem, $default = -1, $vText = "st ...•./Include/_MyFunction.au3'
Func _SelectGUI($aSelectionItem, $default = -1, $vText = "standard", $vLanguageSelector = 0)
	$__iLineNumber=547 & ' - If $aSelectionItem = -1 Or IsArray($aSelectionItem) = 0 Then•./Include/_MyFunction.au3'
	If $aSelectionItem = -1 Or IsArray($aSelectionItem) = 0 Then
		$__iLineNumber=548 & ' - _LOG("Selection Array Invalid", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Selection Array Invalid", 2, $iLOGPath)
		$__iLineNumber=549 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=551 & ' - If $vLanguageSelector = 1 Then•./Include/_MyFunction.au3'
	If $vLanguageSelector = 1 Then
		$__iLineNumber=552 & ' - $_gh_aLangFileArray = $aSelectionItem•./Include/_MyFunction.au3'
		$_gh_aLangFileArray = $aSelectionItem
		$__iLineNumber=553 & ' - If $default = -1 Then $default = @OSLang•./Include/_MyFunction.au3'
		If $default = -1 Then $default = @OSLang
	EndIf


	$__iLineNumber=557 & ' - Local $_Selector_gui_GUI = GUICreate(_MultiLang_GetText("win ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_GUI = GUICreate(_MultiLang_GetText("win_sel_" & $vText & "_Title"), 340, 165, -1, -1, BitOR($WS_POPUP, $WS_BORDER), -1)
	$__iLineNumber=558 & ' - Local $_Selector_gui_Pic = GUICtrlCreatePic($iScriptPath & " ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_Pic = GUICtrlCreatePic($iScriptPath & "\" & "Ressources\Images\Wizard\UXS_Wizard_Half.jpg", 2, 2, 100, 160, -1, -1)
	$__iLineNumber=559 & ' - Local $_Selector_gui_Group = GUICtrlCreateGroup(_MultiLang_G ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_Group = GUICtrlCreateGroup(_MultiLang_GetText("win_sel_" & $vText & "_Title"), 108, 1, 230, 163, -1, -1)
	$__iLineNumber=560 & ' - GUICtrlSetBkColor(-1, "0xF0F0F0")•./Include/_MyFunction.au3'
	GUICtrlSetBkColor(-1, "0xF0F0F0")
	$__iLineNumber=561 & ' - Local $_Selector_gui_Label = GUICtrlCreateLabel(_MultiLang_G ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_Label = GUICtrlCreateLabel(_MultiLang_GetText("win_sel_" & $vText & "_text"), 116, 25, 215, 40, $SS_CENTERIMAGE, -1)
	$__iLineNumber=562 & ' - GUICtrlSetBkColor(-1, "-2")•./Include/_MyFunction.au3'
	GUICtrlSetBkColor(-1, "-2")
	$__iLineNumber=563 & ' - Local $_Selector_gui_Combo = GUICtrlCreateCombo("(" & _Multi ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_Combo = GUICtrlCreateCombo("(" & _MultiLang_GetText("win_sel_" & $vText & "_Title") & ")", 116, 75, 215, 21, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE)) ;BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	$__iLineNumber=564 & ' - GUICtrlSetData(-1, "")•./Include/_MyFunction.au3'
	GUICtrlSetData(-1, "")
	$__iLineNumber=565 & ' - Local $_Selector_gui_Button = GUICtrlCreateButton(_MultiLang ...•./Include/_MyFunction.au3'
	Local $_Selector_gui_Button = GUICtrlCreateButton(_MultiLang_GetText("win_sel_" & $vText & "_button"), 231, 125, 100, 30, -1, -1)
;~ 	$B_SelectorCancel = GUICtrlCreateButton("Cancel",116,125,100,30,-1,-1)

;~ 	Local $_Selector_gui_GUI = GUICreate(_MultiLang_GetText("win_sel_" & $vText & "_Title"), 230, 100)
;~ 	Local $_Selector_gui_Combo = GUICtrlCreateCombo("(" & _MultiLang_GetText("win_sel_" & $vText & "_Title") & ")", 8, 48, 209, 25, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE)) ;BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
;~ 	Local $_Selector_gui_Button = GUICtrlCreateButton(_MultiLang_GetText("win_sel_" & $vText & "_button"), 144, 72, 75, 25)
;~ 	Local $_Selector_gui_Label = GUICtrlCreateLabel(_MultiLang_GetText("win_sel_" & $vText & "_text"), 8, 8, 212, 33)

	;Create List of available Items
	$__iLineNumber=574 & ' - For $I = 0 To UBound($aSelectionItem) - 1•./Include/_MyFunction.au3'
	For $I = 0 To UBound($aSelectionItem) - 1
		$__iLineNumber=575 & ' - GUICtrlSetData($_Selector_gui_Combo, $aSelectionItem[$I][0], ...•./Include/_MyFunction.au3'
		GUICtrlSetData($_Selector_gui_Combo, $aSelectionItem[$I][0], "(" & _MultiLang_GetText("win_sel_" & $vText & "_Title") & ")")
	Next

	$__iLineNumber=578 & ' - GUISetState(@SW_SHOW)•./Include/_MyFunction.au3'
	GUISetState(@SW_SHOW)
	$__iLineNumber=579 & ' - While 1•./Include/_MyFunction.au3'
	While 1
		$__iLineNumber=580 & ' - $nMsg = GUIGetMsg()•./Include/_MyFunction.au3'
		$nMsg = GUIGetMsg()
		$__iLineNumber=581 & ' - Switch $nMsg•./Include/_MyFunction.au3'
		$__iLineNumber=582 & ' - Case $_Selector_gui_Button•./Include/_MyFunction.au3'
		Switch $nMsg
			Case $_Selector_gui_Button
				ExitLoop
		EndSwitch
	WEnd
	$__iLineNumber=586 & ' - Local $_selected = GUICtrlRead($_Selector_gui_Combo)•./Include/_MyFunction.au3'
	Local $_selected = GUICtrlRead($_Selector_gui_Combo)
	$__iLineNumber=587 & ' - GUIDelete($_Selector_gui_GUI)•./Include/_MyFunction.au3'
	GUIDelete($_Selector_gui_GUI)

;~ 	MsgBox(0,"$_selected",$_selected)
;~ 	_ArrayDisplay($aSelectionItem,"$aSelectionItem")

	$__iLineNumber=592 & ' - For $I = 0 To UBound($aSelectionItem) - 1•./Include/_MyFunction.au3'
	For $I = 0 To UBound($aSelectionItem) - 1
		$__iLineNumber=593 & ' - If $aSelectionItem[$I][0] = $_selected Then•./Include/_MyFunction.au3'
		If $aSelectionItem[$I][0] = $_selected Then
			$__iLineNumber=594 & ' - If $vLanguageSelector = 1 Then•./Include/_MyFunction.au3'
			If $vLanguageSelector = 1 Then
				$__iLineNumber=595 & ' - _LOG("Value selected : " & StringLeft($aSelectionItem[$I][2] ...•./Include/_MyFunction.au3'
				_LOG("Value selected : " & StringLeft($aSelectionItem[$I][2], 4), 1, $iLOGPath)
				$__iLineNumber=596 & ' - Return StringLeft($aSelectionItem[$I][2], 4)•./Include/_MyFunction.au3'
				Return StringLeft($aSelectionItem[$I][2], 4)
			Else
				$__iLineNumber=598 & ' - _LOG("Value selected : " & $aSelectionItem[$I][2], 1, $iLOGP ...•./Include/_MyFunction.au3'
				_LOG("Value selected : " & $aSelectionItem[$I][2], 1, $iLOGPath)
				$__iLineNumber=599 & ' - Return $aSelectionItem[$I][2]•./Include/_MyFunction.au3'
				Return $aSelectionItem[$I][2]
			EndIf
		EndIf
	Next
	$__iLineNumber=603 & ' - _LOG("No Value selected (Default = " & $default & ")", 1, $i ...•./Include/_MyFunction.au3'
	_LOG("No Value selected (Default = " & $default & ")", 1, $iLOGPath)
	$__iLineNumber=604 & ' - Return $default•./Include/_MyFunction.au3'
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
$__iLineNumber=619 & ' - Func _ByteSuffix($iBytes)•./Include/_MyFunction.au3'
Func _ByteSuffix($iBytes)
	$__iLineNumber=620 & ' - Local $iIndex = 0, $aArray = [" bytes", " KB", " MB", " GB", ...•./Include/_MyFunction.au3'
	Local $iIndex = 0, $aArray = [' bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB']
	$__iLineNumber=621 & ' - While $iBytes > 1023•./Include/_MyFunction.au3'
	While $iBytes > 1023
		$__iLineNumber=622 & ' - $iIndex += 1•./Include/_MyFunction.au3'
		$iIndex += 1
		$__iLineNumber=623 & ' - $iBytes /= 1024•./Include/_MyFunction.au3'
		$iBytes /= 1024
	WEnd
	$__iLineNumber=625 & ' - Return Round($iBytes) & $aArray[$iIndex]•./Include/_MyFunction.au3'
	Return Round($iBytes) & $aArray[$iIndex]
EndFunc   ;==>_ByteSuffix

; #FUNCTION# ===================================================================================================
; Name...........: _IsChecked
; Description ...: Return the state of a control Id
; Syntax.........: _IsChecked($idControlID)
; Parameters ....: $idControlID		- Control Id to test
; Return values .: Success      - $GUI_CHECKED
;                  Failure      - $GUI_UNCHECKED
; Author ........: Autoit Help
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; yes in autoit Help
$__iLineNumber=641 & ' - Func _IsChecked($idControlID)•./Include/_MyFunction.au3'
Func _IsChecked($idControlID)
	$__iLineNumber=642 & ' - Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GU ...•./Include/_MyFunction.au3'
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

; #FUNCTION# ===================================================================================================
; Name...........: _FormatElapsedTime
; Description ...: Return a formated time
; Syntax.........: _FormatElapsedTime($Input_Seconds)
; Parameters ....: $Input_Seconds	- Time in seconds
; Return values .: Success      - Return a formated string for time
; Author ........:
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
$__iLineNumber=657 & ' - Func _FormatElapsedTime($nr_sec)•./Include/_MyFunction.au3'
Func _FormatElapsedTime($nr_sec)
	$__iLineNumber=658 & ' - $sec2time_hour = Int($nr_sec / 3600)•./Include/_MyFunction.au3'
	$sec2time_hour = Int($nr_sec / 3600)
	$__iLineNumber=659 & ' - $sec2time_min = Int(($nr_sec - $sec2time_hour * 3600) / 60)•./Include/_MyFunction.au3'
	$sec2time_min = Int(($nr_sec - $sec2time_hour * 3600) / 60)
	$__iLineNumber=660 & ' - $sec2time_sec = $nr_sec - $sec2time_hour * 3600 - $sec2time_ ...•./Include/_MyFunction.au3'
	$sec2time_sec = $nr_sec - $sec2time_hour * 3600 - $sec2time_min * 60
	$__iLineNumber=661 & ' - Return StringFormat("%02d:%02d:%02d", $sec2time_hour, $sec2t ...•./Include/_MyFunction.au3'
	Return StringFormat('%02d:%02d:%02d', $sec2time_hour, $sec2time_min, $sec2time_sec)
EndFunc   ;==>_FormatElapsedTime


; #FUNCTION# ===================================================================================================
; Name...........: _FormatElapsedTime
; Description ...: Return a formated time
; Syntax.........: _FormatElapsedTime($Input_Seconds)
; Parameters ....: $Input_Seconds	- Time in seconds
; Return values .: Success      - Return a formated string for time
; Author ........:
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
$__iLineNumber=677 & ' - Func _FormatElapsedTime2($Input_Seconds)•./Include/_MyFunction.au3'
Func _FormatElapsedTime2($Input_Seconds)
	$__iLineNumber=678 & ' - If $Input_Seconds < 1 Then Return•./Include/_MyFunction.au3'
	If $Input_Seconds < 1 Then Return
	$__iLineNumber=679 & ' - Global $ElapsedMessage = ""•./Include/_MyFunction.au3'
	Global $ElapsedMessage = ''
	$__iLineNumber=680 & ' - Global $Input = $Input_Seconds•./Include/_MyFunction.au3'
	Global $Input = $Input_Seconds
	$__iLineNumber=681 & ' - Switch $Input_Seconds•./Include/_MyFunction.au3'
	$__iLineNumber=682 & ' - Case 0 To 59•./Include/_MyFunction.au3'
	Switch $Input_Seconds
		Case 0 To 59
			$__iLineNumber=683 & ' - GetSeconds()•./Include/_MyFunction.au3'
			GetSeconds()
		$__iLineNumber=684 & ' - Case 60 To 3599•./Include/_MyFunction.au3'
		Case 60 To 3599
			$__iLineNumber=685 & ' - GetMinutes()•./Include/_MyFunction.au3'
			GetMinutes()
			$__iLineNumber=686 & ' - GetSeconds()•./Include/_MyFunction.au3'
			GetSeconds()
		$__iLineNumber=687 & ' - Case 3600 To 86399•./Include/_MyFunction.au3'
		Case 3600 To 86399
			$__iLineNumber=688 & ' - GetHours()•./Include/_MyFunction.au3'
			GetHours()
			$__iLineNumber=689 & ' - GetMinutes()•./Include/_MyFunction.au3'
			GetMinutes()
			$__iLineNumber=690 & ' - GetSeconds()•./Include/_MyFunction.au3'
			GetSeconds()
		Case Else
			$__iLineNumber=692 & ' - GetDays()•./Include/_MyFunction.au3'
			GetDays()
			$__iLineNumber=693 & ' - GetHours()•./Include/_MyFunction.au3'
			GetHours()
			$__iLineNumber=694 & ' - GetMinutes()•./Include/_MyFunction.au3'
			GetMinutes()
			$__iLineNumber=695 & ' - GetSeconds()•./Include/_MyFunction.au3'
			GetSeconds()
	EndSwitch
	$__iLineNumber=697 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>_FormatElapsedTime2

$__iLineNumber=700 & ' - Func GetDays()•./Include/_MyFunction.au3'
Func GetDays()
	$__iLineNumber=701 & ' - $Days = Int($Input / 86400)•./Include/_MyFunction.au3'
	$Days = Int($Input / 86400)
	$__iLineNumber=702 & ' - $Input -= ($Days * 86400)•./Include/_MyFunction.au3'
	$Input -= ($Days * 86400)
	$__iLineNumber=703 & ' - $ElapsedMessage &= $Days & " d, "•./Include/_MyFunction.au3'
	$ElapsedMessage &= $Days & ' d, '
	$__iLineNumber=704 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>GetDays

$__iLineNumber=707 & ' - Func GetHours()•./Include/_MyFunction.au3'
Func GetHours()
	$__iLineNumber=708 & ' - $Hours = Int($Input / 3600)•./Include/_MyFunction.au3'
	$Hours = Int($Input / 3600)
	$__iLineNumber=709 & ' - $Input -= ($Hours * 3600)•./Include/_MyFunction.au3'
	$Input -= ($Hours * 3600)
	$__iLineNumber=710 & ' - $ElapsedMessage &= $Hours & " h, "•./Include/_MyFunction.au3'
	$ElapsedMessage &= $Hours & ' h, '
	$__iLineNumber=711 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>GetHours

$__iLineNumber=714 & ' - Func GetMinutes()•./Include/_MyFunction.au3'
Func GetMinutes()
	$__iLineNumber=715 & ' - $Minutes = Int($Input / 60)•./Include/_MyFunction.au3'
	$Minutes = Int($Input / 60)
	$__iLineNumber=716 & ' - $Input -= ($Minutes * 60)•./Include/_MyFunction.au3'
	$Input -= ($Minutes * 60)
	$__iLineNumber=717 & ' - $ElapsedMessage &= $Minutes & " min, "•./Include/_MyFunction.au3'
	$ElapsedMessage &= $Minutes & ' min, '
	$__iLineNumber=718 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>GetMinutes

$__iLineNumber=721 & ' - Func GetSeconds()•./Include/_MyFunction.au3'
Func GetSeconds()
	$__iLineNumber=722 & ' - $ElapsedMessage &= Int($Input) & " sec."•./Include/_MyFunction.au3'
	$ElapsedMessage &= Int($Input) & ' sec.'
	$__iLineNumber=723 & ' - Return $ElapsedMessage•./Include/_MyFunction.au3'
	Return $ElapsedMessage
EndFunc   ;==>GetSeconds

$__iLineNumber=726 & ' - Func _MakeTEMPFile($iPath, $iPath_Temp)•./Include/_MyFunction.au3'
Func _MakeTEMPFile($iPath, $iPath_Temp)
	;Working on temporary picture
	$__iLineNumber=728 & ' - FileDelete($iPath_Temp)•./Include/_MyFunction.au3'
	FileDelete($iPath_Temp)
	$__iLineNumber=729 & ' - If Not FileCopy($iPath, $iPath_Temp, $FC_OVERWRITE + $FC_CRE ...•./Include/_MyFunction.au3'
	If Not FileCopy($iPath, $iPath_Temp, $FC_OVERWRITE + $FC_CREATEPATH) Then
		Sleep(250)
		$__iLineNumber=731 & ' - If Not FileCopy($iPath, $iPath_Temp, $FC_OVERWRITE + $FC_CRE ...•./Include/_MyFunction.au3'
		If Not FileCopy($iPath, $iPath_Temp, $FC_OVERWRITE + $FC_CREATEPATH) Then
			$__iLineNumber=732 & ' - _LOG("Error copying " & $iPath & " to " & $iPath_Temp & " (" ...•./Include/_MyFunction.au3'
			_LOG("Error copying " & $iPath & " to " & $iPath_Temp & " (" & FileGetSize($iPath) & ")", 2, $iLOGPath)
			$__iLineNumber=733 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		EndIf
	EndIf
	$__iLineNumber=736 & ' - If Not FileDelete($iPath) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath) Then
		Sleep(250)
		$__iLineNumber=738 & ' - If Not FileDelete($iPath) Then•./Include/_MyFunction.au3'
		If Not FileDelete($iPath) Then
			$__iLineNumber=739 & ' - _LOG("Error deleting " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG("Error deleting " & $iPath, 2, $iLOGPath)
			$__iLineNumber=740 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		EndIf
	EndIf
	$__iLineNumber=743 & ' - _LOG($iPath & " to temp OK : " & $iPath_Temp, 1, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG($iPath & " to temp OK : " & $iPath_Temp, 1, $iLOGPath)
	$__iLineNumber=744 & ' - Return $iPath_Temp•./Include/_MyFunction.au3'
	Return $iPath_Temp
EndFunc   ;==>_MakeTEMPFile

$__iLineNumber=747 & ' - Func _Coalesce($vValue1, $vValue2, $vTestValue = "")•./Include/_MyFunction.au3'
Func _Coalesce($vValue1, $vValue2, $vTestValue = "")
	$__iLineNumber=748 & ' - If $vValue1 = $vTestValue Then Return $vValue2•./Include/_MyFunction.au3'
	If $vValue1 = $vTestValue Then Return $vValue2
	$__iLineNumber=749 & ' - Return $vValue1•./Include/_MyFunction.au3'
	Return $vValue1
EndFunc   ;==>_Coalesce

$__iLineNumber=752 & ' - Func _KillScrapeEngine($iScraper)•./Include/_MyFunction.au3'
Func _KillScrapeEngine($iScraper)
	$__iLineNumber=753 & ' - $aPID = ProcessList($iScraper)•./Include/_MyFunction.au3'
	$aPID = ProcessList($iScraper)
;~ 	_ArrayDisplay($aPID,"$aPID")
	$__iLineNumber=755 & ' - For $Boucle = 1 To $aPID[0][0]•./Include/_MyFunction.au3'
	For $Boucle = 1 To $aPID[0][0]
		$__iLineNumber=756 & ' - _LOG("Killing Process : " & $aPID[$Boucle][0] & " - " & $aPI ...•./Include/_MyFunction.au3'
		_LOG("Killing Process : " & $aPID[$Boucle][0] & " - " & $aPID[$Boucle][1], 0, $iLOGPath)
;~ 		_SendMail($sMailSlotCancel & $vBoucle, "CANCELED")
		$__iLineNumber=758 & ' - ProcessClose($aPID[$Boucle][1])•./Include/_MyFunction.au3'
		ProcessClose($aPID[$Boucle][1])
		$__iLineNumber=759 & ' - If @error Then _LOG("Error Killing Process : " & $aPID[$Bouc ...•./Include/_MyFunction.au3'
		If @error Then _LOG("Error Killing Process : " & $aPID[$Boucle][0] & " - " & $aPID[$Boucle][1] & "(" & @error & ")", 2, $iLOGPath)
	Next

EndFunc   ;==>_KillScrapeEngine

#EndRegion MISC Function

#Region GDI Function
; #FUNCTION# ===================================================================================================
; Name...........: _Compression
; Description ...: Optimize PNG
; Syntax.........: _Compression($iPath [, $isoft = 'pngquant.exe', $iParamater = '--force --verbose --ordered --speed=1 --quality=50-90 --ext .png'])
; Parameters ....: $iPath		- Path to the picture
;~ 				   $isoft		- exe to use
;~ 				   $iParamater	- parameter to use
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: inspiration : wakillon
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; https://www.autoitscript.com/forum/topic/122168-tinypicsharer-v-1034-new-version-08-june-2013/
$__iLineNumber=782 & ' - Func _Compression($iPath, $isoft = "pngquant.exe", $iParamat ...•./Include/_MyFunction.au3'
Func _Compression($iPath, $isoft = 'pngquant.exe', $iParamater = '--force --verbose --ordered --speed=1 --quality=50-90 --ext .png')
	$__iLineNumber=783 & ' - Local $sRun, $iPid, $_StderrRead•./Include/_MyFunction.au3'
	Local $sRun, $iPid, $_StderrRead
	$__iLineNumber=784 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=785 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=786 & ' - If StringLower($iExtension) <> ".png" Then•./Include/_MyFunction.au3'
	If StringLower($iExtension) <> ".png" Then
		$__iLineNumber=787 & ' - _LOG("Not a PNG file : " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Not a PNG file : " & $iPath, 2, $iLOGPath)
		$__iLineNumber=788 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=790 & ' - $vPathSize = _ByteSuffix(FileGetSize($iPath))•./Include/_MyFunction.au3'
	$vPathSize = _ByteSuffix(FileGetSize($iPath))
	$__iLineNumber=791 & ' - $sRun = """ & $iScriptPath & "\Ressources\pngquant.exe" " &  ...•./Include/_MyFunction.au3'
	$sRun = '"' & $iScriptPath & '\Ressources\pngquant.exe" ' & $iParamater & ' "' & $iPath & '"'
	$__iLineNumber=792 & ' - _LOG("PNGQuant command: " & $sRun, 1, $iLOGPath)•./Include/_MyFunction.au3'
	_LOG("PNGQuant command: " & $sRun, 1, $iLOGPath)
	$__iLineNumber=793 & ' - $iPid = Run($sRun, "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHI ...•./Include/_MyFunction.au3'
	$iPid = Run($sRun, '', @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	$__iLineNumber=794 & ' - While ProcessExists($iPid)•./Include/_MyFunction.au3'
	While ProcessExists($iPid)
		$__iLineNumber=795 & ' - $_StderrRead = StderrRead($iPid)•./Include/_MyFunction.au3'
		$_StderrRead = StderrRead($iPid)
		$__iLineNumber=796 & ' - If Not @error And $_StderrRead <> "" Then•./Include/_MyFunction.au3'
		If Not @error And $_StderrRead <> '' Then
			$__iLineNumber=797 & ' - If StringInStr($_StderrRead, "error") And Not StringInStr($_ ...•./Include/_MyFunction.au3'
			If StringInStr($_StderrRead, 'error') And Not StringInStr($_StderrRead, 'No errors') Then
				$__iLineNumber=798 & ' - _LOG("Error while optimizing " & $iPath, 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG("Error while optimizing " & $iPath, 2, $iLOGPath)
				$__iLineNumber=799 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
		EndIf
	WEnd
	$__iLineNumber=803 & ' - $vPathSizeOptimized = _ByteSuffix(FileGetSize($iPath))•./Include/_MyFunction.au3'
	$vPathSizeOptimized = _ByteSuffix(FileGetSize($iPath))
	$__iLineNumber=804 & ' - _LOG("PNG Optimization (PNGQuant): " & $iPath & "(" & $vPath ...•./Include/_MyFunction.au3'
	_LOG("PNG Optimization (PNGQuant): " & $iPath & "(" & $vPathSize & " -> " & $vPathSizeOptimized & ")", 0, $iLOGPath)
	$__iLineNumber=805 & ' - Return $iPath•./Include/_MyFunction.au3'
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
$__iLineNumber=821 & ' - Func _GDIPlus_RelativePos($iValue, $iValueMax)•./Include/_MyFunction.au3'
Func _GDIPlus_RelativePos($iValue, $iValueMax)
	$__iLineNumber=822 & ' - If StringLeft($iValue, 1) = "%" Then Return Int($iValueMax * ...•./Include/_MyFunction.au3'
	If StringLeft($iValue, 1) = '%' Then Return Int($iValueMax * StringTrimLeft($iValue, 1))
	$__iLineNumber=823 & ' - Return $iValue•./Include/_MyFunction.au3'
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
$__iLineNumber=841 & ' - Func _GDIPlus_ResizeMax($iPath, $iMAX_Width, $iMAX_Height)•./Include/_MyFunction.au3'
Func _GDIPlus_ResizeMax($iPath, $iMAX_Width, $iMAX_Height)
	$__iLineNumber=842 & ' - Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New, ...•./Include/_MyFunction.au3'
	Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New, $iRatio, $hImageResized
	$__iLineNumber=843 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp,  ...•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp, $iResized
	$__iLineNumber=844 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=845 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-RESIZE_Temp"  ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-RESIZE_Temp" & $iExtension
	$__iLineNumber=846 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=847 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=848 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=849 & ' - $iWidth = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=850 & ' - If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas  ...•./Include/_MyFunction.au3'
	If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=851 & ' - $iHeight = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=852 & ' - If $iWidth = -1 Or $iHeight = -1 Then MsgBox(0, "error", $iP ...•./Include/_MyFunction.au3'
	If $iWidth = -1 Or $iHeight = -1 Then MsgBox(0, "error", $iPath & " or " & $iPath_Temp & " Fucked")
	$__iLineNumber=853 & ' - $iRatio = $iHeight / $iWidth•./Include/_MyFunction.au3'
	$iRatio = $iHeight / $iWidth
	$__iLineNumber=854 & ' - If $iMAX_Width <= 0 And $iMAX_Height > 0 Then $iMAX_Width =  ...•./Include/_MyFunction.au3'
	If $iMAX_Width <= 0 And $iMAX_Height > 0 Then $iMAX_Width = $iMAX_Height / $iRatio
	$__iLineNumber=855 & ' - If $iMAX_Height <= 0 And $iMAX_Width > 0 Then $iMAX_Height = ...•./Include/_MyFunction.au3'
	If $iMAX_Height <= 0 And $iMAX_Width > 0 Then $iMAX_Height = $iMAX_Width * $iRatio
	$__iLineNumber=856 & ' - $iHeight_New = $iMAX_Height•./Include/_MyFunction.au3'
	$iHeight_New = $iMAX_Height
	$__iLineNumber=857 & ' - $iWidth_New = $iMAX_Height / $iRatio•./Include/_MyFunction.au3'
	$iWidth_New = $iMAX_Height / $iRatio
	$__iLineNumber=858 & ' - If $iWidth_New > $iMAX_Width Then•./Include/_MyFunction.au3'
	If $iWidth_New > $iMAX_Width Then
		$__iLineNumber=859 & ' - $iWidth_New = $iMAX_Width•./Include/_MyFunction.au3'
		$iWidth_New = $iMAX_Width
		$__iLineNumber=860 & ' - $iHeight_New = $iWidth_New * $iRatio•./Include/_MyFunction.au3'
		$iHeight_New = $iWidth_New * $iRatio
;~ 		_LOG("$iWidth_New too BIG $iSize_New " & $iWidth_New & " x " & $iHeight_New & "(" & $iHeight_New / $iWidth_New & ")", 2, $iLOGPath)
	EndIf
	$__iLineNumber=863 & ' - $iWidth_New = Int($iWidth_New)•./Include/_MyFunction.au3'
	$iWidth_New = Int($iWidth_New)
	$__iLineNumber=864 & ' - $iHeight_New = Int($iHeight_New)•./Include/_MyFunction.au3'
	$iHeight_New = Int($iHeight_New)
	$__iLineNumber=865 & ' - If $iWidth <> $iWidth_New Or $iHeight <> $iHeight_New Then•./Include/_MyFunction.au3'
	If $iWidth <> $iWidth_New Or $iHeight <> $iHeight_New Then
		$__iLineNumber=866 & ' - $iResized = 1•./Include/_MyFunction.au3'
		$iResized = 1
		$__iLineNumber=867 & ' - _LOG("Resize Max : " & $iPath, 0, $iLOGPath) ; Debug•./Include/_MyFunction.au3'
		_LOG("Resize Max : " & $iPath, 0, $iLOGPath) ; Debug
		$__iLineNumber=868 & ' - _LOG("Origine = " & $iWidth & "x" & $iHeight, 1, $iLOGPath)  ...•./Include/_MyFunction.au3'
		_LOG("Origine = " & $iWidth & "x" & $iHeight, 1, $iLOGPath) ; Debug
		$__iLineNumber=869 & ' - _LOG("Finale = " & $iWidth_New & "x" & $iHeight_New, 1, $iLO ...•./Include/_MyFunction.au3'
		_LOG("Finale = " & $iWidth_New & "x" & $iHeight_New, 1, $iLOGPath) ; Debug
	Else
		$__iLineNumber=871 & ' - $iResized = 0•./Include/_MyFunction.au3'
		$iResized = 0
		$__iLineNumber=872 & ' - _LOG("No Resizing : " & $iPath, 0, $iLOGPath) ; Debug•./Include/_MyFunction.au3'
		_LOG("No Resizing : " & $iPath, 0, $iLOGPath) ; Debug
		$__iLineNumber=873 & ' - _LOG("Origine = " & $iWidth & "x" & $iHeight, 1, $iLOGPath)  ...•./Include/_MyFunction.au3'
		_LOG("Origine = " & $iWidth & "x" & $iHeight, 1, $iLOGPath) ; Debug
		$__iLineNumber=874 & ' - _LOG("Finale = " & $iWidth_New & "x" & $iHeight_New, 1, $iLO ...•./Include/_MyFunction.au3'
		_LOG("Finale = " & $iWidth_New & "x" & $iHeight_New, 1, $iLOGPath) ; Debug
	EndIf
	$__iLineNumber=876 & ' - $hImageResized = _GDIPlus_ImageResize($hImage, $iWidth_New,  ...•./Include/_MyFunction.au3'
	$hImageResized = _GDIPlus_ImageResize($hImage, $iWidth_New, $iHeight_New)
	$__iLineNumber=877 & ' - _GDIPlus_ImageSaveToFile($hImageResized, $iPath)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hImageResized, $iPath)
	$__iLineNumber=878 & ' - _GDIPlus_ImageDispose($hImageResized)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImageResized)
	$__iLineNumber=879 & ' - _WinAPI_DeleteObject($hImageResized)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImageResized)
	$__iLineNumber=880 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=881 & ' - _WinAPI_DeleteObject($hImageResized)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImageResized)
	$__iLineNumber=882 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=883 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=884 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
;~ 		Return -1
	EndIf
	$__iLineNumber=887 & ' - Return $iResized•./Include/_MyFunction.au3'
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
$__iLineNumber=911 & ' - Func _GDIPlus_Rotation($iPath, $iRotation = 0)•./Include/_MyFunction.au3'
Func _GDIPlus_Rotation($iPath, $iRotation = 0)
	$__iLineNumber=912 & ' - Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New•./Include/_MyFunction.au3'
	Local $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New
	#forceref $hImage, $iWidth, $iHeight, $iWidth_New, $iHeight_New
	$__iLineNumber=914 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=915 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=916 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-ROTATE_Temp"  ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-ROTATE_Temp" & $iExtension
	$__iLineNumber=917 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=918 & ' - If $iRotation = "" Or $iRotation > 7 Then $iRotation = 0•./Include/_MyFunction.au3'
	If $iRotation = '' Or $iRotation > 7 Then $iRotation = 0
	$__iLineNumber=919 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=920 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=921 & ' - $iWidth = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=922 & ' - If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas  ...•./Include/_MyFunction.au3'
	If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=923 & ' - $iHeight = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=924 & ' - _GDIPlus_ImageRotateFlip($hImage, $iRotation)•./Include/_MyFunction.au3'
	_GDIPlus_ImageRotateFlip($hImage, $iRotation)
	$__iLineNumber=925 & ' - $iWidth_New = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$iWidth_New = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=926 & ' - If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas  ...•./Include/_MyFunction.au3'
	If $iWidth = 4294967295 Then $iWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=927 & ' - $iHeight_New = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$iHeight_New = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=928 & ' - _LOG("ROTATION (" & $iRotation & ") : " & $iPath, 0, $iLOGPa ...•./Include/_MyFunction.au3'
	_LOG("ROTATION (" & $iRotation & ") : " & $iPath, 0, $iLOGPath) ; Debug
	$__iLineNumber=929 & ' - _GDIPlus_ImageSaveToFile($hImage, $iPath)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hImage, $iPath)
	$__iLineNumber=930 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=931 & ' - _WinAPI_DeleteObject($hImage)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImage)
	$__iLineNumber=932 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=933 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=934 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
;~ 		Return -1
	EndIf
	$__iLineNumber=937 & ' - Return $iPath•./Include/_MyFunction.au3'
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
$__iLineNumber=953 & ' - Func _GDIPlus_Transparency($iPath, $iTransLvl)•./Include/_MyFunction.au3'
Func _GDIPlus_Transparency($iPath, $iTransLvl)
;~ 	MsgBox(0,"DEBUG","_GDIPlus_Transparency");Debug
	$__iLineNumber=955 & ' - Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGU ...•./Include/_MyFunction.au3'
	Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	$__iLineNumber=956 & ' - Local $MergedImageBackgroundColor = 0x00000000•./Include/_MyFunction.au3'
	Local $MergedImageBackgroundColor = 0x00000000
	$__iLineNumber=957 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=958 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=959 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-TRANS_Temp.PN ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-TRANS_Temp.PNG"
	$__iLineNumber=960 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=961 & ' - $iPath = $sDrive & $sDir & $sFileName & ".png"•./Include/_MyFunction.au3'
	$iPath = $sDrive & $sDir & $sFileName & ".png"
	$__iLineNumber=962 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=963 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=964 & ' - $ImageWidth = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$ImageWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=965 & ' - If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 ...•./Include/_MyFunction.au3'
	If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=966 & ' - $ImageHeight = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$ImageHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=967 & ' - $hGui = GUICreate("", $ImageWidth, $ImageHeight)•./Include/_MyFunction.au3'
	$hGui = GUICreate("", $ImageWidth, $ImageHeight)
	$__iLineNumber=968 & ' - $hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw  ...•./Include/_MyFunction.au3'
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$__iLineNumber=969 & ' - $hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ ...•./Include/_MyFunction.au3'
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ImageHeight, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$__iLineNumber=970 & ' - $hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Dr ...•./Include/_MyFunction.au3'
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	$__iLineNumber=971 & ' - _GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColo ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor)
	$__iLineNumber=972 & ' - _GDIPlus_GraphicsDrawImageRectRectTrans($hGraphic, $hImage,  ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImageRectRectTrans($hGraphic, $hImage, 0, 0, "", "", "", "", "", "", 2, $iTransLvl)
	$__iLineNumber=973 & ' - _LOG("Transparency (" & $iTransLvl & ") : " & $iPath, 0, $iL ...•./Include/_MyFunction.au3'
	_LOG("Transparency (" & $iTransLvl & ") : " & $iPath, 0, $iLOGPath) ; Debug
	$__iLineNumber=974 & ' - _GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)
	$__iLineNumber=975 & ' - _GDIPlus_GraphicsDispose($hGraphic)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphic)
	$__iLineNumber=976 & ' - _WinAPI_DeleteObject($hGraphic)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGraphic)
	$__iLineNumber=977 & ' - _GDIPlus_BitmapDispose($hBMPBuff)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hBMPBuff)
	$__iLineNumber=978 & ' - _WinAPI_DeleteObject($hBMPBuff)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hBMPBuff)
	$__iLineNumber=979 & ' - _GDIPlus_GraphicsDispose($hGraphicGUI)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	$__iLineNumber=980 & ' - _WinAPI_DeleteObject($hGraphicGUI)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGraphicGUI)
	$__iLineNumber=981 & ' - GUIDelete($hGui)•./Include/_MyFunction.au3'
	GUIDelete($hGui)
	$__iLineNumber=982 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=983 & ' - _WinAPI_DeleteObject($hImage)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImage)
	$__iLineNumber=984 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=985 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=986 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
;~ 		Return -1
	EndIf
	$__iLineNumber=989 & ' - Return $iPath•./Include/_MyFunction.au3'
	Return $iPath
EndFunc   ;==>_GDIPlus_Transparency

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_Text
; Description ...: Draw Text on picture
; Syntax.........: _GDIPlus_Text($iPath, $iString = '', $iX = 0, $iY = 0, $iFont = 'Arial', $iFontSize = 10, $iFontColor = 0xFFFFFFFF)
; Parameters ....: $iPath		- Path to the picture
;                  $iString		- String to draw
;                  $iX			- X position of the text
;                  $iY			- Y position of the text
;                  $iFont		- Font name
;                  $iFontSize	- Font size
;                  $iFontStyle	- Font Style
;~ 										0 - Normal weight or thickness of the typeface
;~ 										1 - Bold typeface
;~ 										2 - Italic typeface
;~ 										4 - Underline
;~ 										8 - Strikethrough
;                  $iFontColor	- Font Color
; Return values .: Success      - Return the Path of the Picture
;                  Failure      - -1
; Author ........: Screech
; Modified.......:
;; Related .......:
; Link ..........;
; Example .......; No
$__iLineNumber=1016 & ' - Func _GDIPlus_Text($iPath, $iString = "", $iX = 0, $iY = 0,  ...•./Include/_MyFunction.au3'
Func _GDIPlus_Text($iPath, $iString = '', $iX = 0, $iY = 0, $iFont = 'Arial', $iFontSize = 10, $iFontStyle = 0, $iFontColor = 0xFFFFFFFF, $iXOrigin = Default, $iYOrigin = Default)
;~ 	MsgBox(0,"DEBUG","_GDIPlus_Text");Debug
	$__iLineNumber=1018 & ' - Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGU ...•./Include/_MyFunction.au3'
	Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	$__iLineNumber=1019 & ' - Local $hFamily, $hFont, $tLayout, $hFormat, $hBrush, $hPen,  ...•./Include/_MyFunction.au3'
	Local $hFamily, $hFont, $tLayout, $hFormat, $hBrush, $hPen, $aInfo, $aStringSize
	$__iLineNumber=1020 & ' - Local $MergedImageBackgroundColor = 0x00000000•./Include/_MyFunction.au3'
	Local $MergedImageBackgroundColor = 0x00000000
	$__iLineNumber=1021 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=1022 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=1023 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-TEXT_Temp.PNG ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-TEXT_Temp.PNG"
	$__iLineNumber=1024 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=1025 & ' - $iPath = $sDrive & $sDir & $sFileName & ".png"•./Include/_MyFunction.au3'
	$iPath = $sDrive & $sDir & $sFileName & ".png"
	$__iLineNumber=1026 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=1027 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=1028 & ' - $ImageWidth = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	$ImageWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=1029 & ' - If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 ...•./Include/_MyFunction.au3'
	If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=1030 & ' - $ImageHeight = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	$ImageHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=1031 & ' - $hGui = GUICreate("", $ImageWidth, $ImageHeight)•./Include/_MyFunction.au3'
	$hGui = GUICreate("", $ImageWidth, $ImageHeight)
	$__iLineNumber=1032 & ' - $hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw  ...•./Include/_MyFunction.au3'
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$__iLineNumber=1033 & ' - $hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ ...•./Include/_MyFunction.au3'
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ImageHeight, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$__iLineNumber=1034 & ' - $hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Dr ...•./Include/_MyFunction.au3'
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	$__iLineNumber=1035 & ' - _GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColo ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor) ;Fill the Graphic Background (0x00000000 for transparent background in .png files)
	$__iLineNumber=1036 & ' - _GDIPlus_GraphicsDrawImage($hGraphic, $hImage, 0, 0)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage, 0, 0)

	$__iLineNumber=1038 & ' - $iX = _GDIPlus_RelativePos($iX, $ImageWidth)•./Include/_MyFunction.au3'
	$iX = _GDIPlus_RelativePos($iX, $ImageWidth)
	$__iLineNumber=1039 & ' - $iY = _GDIPlus_RelativePos($iY, $ImageHeight)•./Include/_MyFunction.au3'
	$iY = _GDIPlus_RelativePos($iY, $ImageHeight)
	$__iLineNumber=1040 & ' - Switch $iX•./Include/_MyFunction.au3'
	$__iLineNumber=1041 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $iX
		Case 'CENTER'
			$__iLineNumber=1042 & ' - $iX = Int($ImageWidth / 2)•./Include/_MyFunction.au3'
			$iX = Int($ImageWidth / 2)
		$__iLineNumber=1043 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1044 & ' - $iX = 0•./Include/_MyFunction.au3'
			$iX = 0
		$__iLineNumber=1045 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1046 & ' - $iX = $ImageWidth•./Include/_MyFunction.au3'
			$iX = $ImageWidth
	EndSwitch
	$__iLineNumber=1048 & ' - Switch $iY•./Include/_MyFunction.au3'
	$__iLineNumber=1049 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $iY
		Case 'CENTER'
			$__iLineNumber=1050 & ' - $iY = Int($ImageHeight / 2)•./Include/_MyFunction.au3'
			$iY = Int($ImageHeight / 2)
		$__iLineNumber=1051 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1052 & ' - $iY = 0•./Include/_MyFunction.au3'
			$iY = 0
		$__iLineNumber=1053 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1054 & ' - $iY = $ImageHeight•./Include/_MyFunction.au3'
			$iY = $ImageHeight
	EndSwitch
	$__iLineNumber=1056 & ' - $aStringSize = _GDIPlus_MeasureString($iString, $iFont, $iFo ...•./Include/_MyFunction.au3'
	$aStringSize = _GDIPlus_MeasureString($iString, $iFont, $iFontSize, $iFontStyle)
	$__iLineNumber=1057 & ' - $iXOrigin = _GDIPlus_RelativePos($iXOrigin, $ImageWidth)•./Include/_MyFunction.au3'
	$iXOrigin = _GDIPlus_RelativePos($iXOrigin, $ImageWidth)
	$__iLineNumber=1058 & ' - $iYOrigin = _GDIPlus_RelativePos($iYOrigin, $ImageWidth)•./Include/_MyFunction.au3'
	$iYOrigin = _GDIPlus_RelativePos($iYOrigin, $ImageWidth)
	$__iLineNumber=1059 & ' - Switch $iXOrigin•./Include/_MyFunction.au3'
	$__iLineNumber=1060 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $iXOrigin
		Case 'CENTER'
			$__iLineNumber=1061 & ' - $iXOrigin = $aStringSize[0] / 2•./Include/_MyFunction.au3'
			$iXOrigin = $aStringSize[0] / 2
		$__iLineNumber=1062 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1063 & ' - $iXOrigin = 0•./Include/_MyFunction.au3'
			$iXOrigin = 0
		$__iLineNumber=1064 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1065 & ' - $iXOrigin = $aStringSize[0]•./Include/_MyFunction.au3'
			$iXOrigin = $aStringSize[0]
		$__iLineNumber=1066 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1067 & ' - $iXOrigin = 0•./Include/_MyFunction.au3'
			$iXOrigin = 0
	EndSwitch
	$__iLineNumber=1069 & ' - Switch $iYOrigin•./Include/_MyFunction.au3'
	$__iLineNumber=1070 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $iYOrigin
		Case 'CENTER'
			$__iLineNumber=1071 & ' - $iYOrigin = $aStringSize[1] / 2•./Include/_MyFunction.au3'
			$iYOrigin = $aStringSize[1] / 2
		$__iLineNumber=1072 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1073 & ' - $iYOrigin = 0•./Include/_MyFunction.au3'
			$iYOrigin = 0
		$__iLineNumber=1074 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1075 & ' - $iYOrigin = $aStringSize[1]•./Include/_MyFunction.au3'
			$iYOrigin = $aStringSize[1]
		$__iLineNumber=1076 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1077 & ' - $iYOrigin = 0•./Include/_MyFunction.au3'
			$iYOrigin = 0
	EndSwitch

	$__iLineNumber=1080 & ' - $hFamily = _GDIPlus_FontFamilyCreate($iFont)•./Include/_MyFunction.au3'
	$hFamily = _GDIPlus_FontFamilyCreate($iFont)
	$__iLineNumber=1081 & ' - $hFont = _GDIPlus_FontCreate($hFamily, $iFontSize, $iFontSty ...•./Include/_MyFunction.au3'
	$hFont = _GDIPlus_FontCreate($hFamily, $iFontSize, $iFontStyle)
	$__iLineNumber=1082 & ' - $tLayout = _GDIPlus_RectFCreate($iX - $iXOrigin, $iY - $iYOr ...•./Include/_MyFunction.au3'
	$tLayout = _GDIPlus_RectFCreate($iX - $iXOrigin, $iY - $iYOrigin, $aStringSize[0], $aStringSize[1])
	$__iLineNumber=1083 & ' - $hFormat = _GDIPlus_StringFormatCreate() ; (2 - text are dra ...•./Include/_MyFunction.au3'
	$hFormat = _GDIPlus_StringFormatCreate() ; (2 - text are drawn vertically)
	$__iLineNumber=1084 & ' - $hBrush = _GDIPlus_BrushCreateSolid($iFontColor) ;0xFFFFFFFF ...•./Include/_MyFunction.au3'
	$hBrush = _GDIPlus_BrushCreateSolid($iFontColor) ;0xFFFFFFFF) ; (0x00FFFFFF - fully transparent. Alpha channel zero)
	$__iLineNumber=1085 & ' - $aInfo = _GDIPlus_GraphicsMeasureString($hGraphic, $iString, ...•./Include/_MyFunction.au3'
	$aInfo = _GDIPlus_GraphicsMeasureString($hGraphic, $iString, $hFont, $tLayout, $hFormat)
	$__iLineNumber=1086 & ' - _GDIPlus_GraphicsDrawStringEx($hGraphic, $iString, $hFont, $ ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawStringEx($hGraphic, $iString, $hFont, $aInfo[0], $hFormat, $hBrush)

	$__iLineNumber=1088 & ' - _GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)

	$__iLineNumber=1090 & ' - _GDIPlus_FontDispose($hFont)•./Include/_MyFunction.au3'
	_GDIPlus_FontDispose($hFont)
	$__iLineNumber=1091 & ' - _WinAPI_DeleteObject($hFont)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hFont)
	$__iLineNumber=1092 & ' - _GDIPlus_FontFamilyDispose($hFamily)•./Include/_MyFunction.au3'
	_GDIPlus_FontFamilyDispose($hFamily)
	$__iLineNumber=1093 & ' - _WinAPI_DeleteObject($hFamily)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hFamily)
	$__iLineNumber=1094 & ' - _GDIPlus_StringFormatDispose($hFormat)•./Include/_MyFunction.au3'
	_GDIPlus_StringFormatDispose($hFormat)
	$__iLineNumber=1095 & ' - _WinAPI_DeleteObject($hFormat)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hFormat)
	$__iLineNumber=1096 & ' - _GDIPlus_BrushDispose($hBrush)•./Include/_MyFunction.au3'
	_GDIPlus_BrushDispose($hBrush)
	$__iLineNumber=1097 & ' - _WinAPI_DeleteObject($hBrush)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hBrush)
	$__iLineNumber=1098 & ' - _GDIPlus_GraphicsDispose($hGraphic)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphic)
	$__iLineNumber=1099 & ' - _WinAPI_DeleteObject($hGraphic)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGraphic)
	$__iLineNumber=1100 & ' - _GDIPlus_BitmapDispose($hBMPBuff)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hBMPBuff)
	$__iLineNumber=1101 & ' - _WinAPI_DeleteObject($hBMPBuff)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hBMPBuff)
	$__iLineNumber=1102 & ' - _GDIPlus_GraphicsDispose($hGraphicGUI)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	$__iLineNumber=1103 & ' - _WinAPI_DeleteObject($hGraphicGUI)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGraphicGUI)
	$__iLineNumber=1104 & ' - GUIDelete($hGui)•./Include/_MyFunction.au3'
	GUIDelete($hGui)
	$__iLineNumber=1105 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=1106 & ' - _WinAPI_DeleteObject($hImage)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImage)
	$__iLineNumber=1107 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=1108 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=1109 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
;~ 		Return -1
	EndIf
	$__iLineNumber=1112 & ' - Return $iPath•./Include/_MyFunction.au3'
	Return $iPath
EndFunc   ;==>_GDIPlus_Text

$__iLineNumber=1115 & ' - Func _GDIPlus_MeasureString($sString, $sFont = "Arial", $fSi ...•./Include/_MyFunction.au3'
Func _GDIPlus_MeasureString($sString, $sFont = "Arial", $fSize = 10, $iStyle = 0, $bRound = True)
	$__iLineNumber=1116 & ' - Local $aSize[2]•./Include/_MyFunction.au3'
	Local $aSize[2]
	$__iLineNumber=1117 & ' - Local Const $hFamily = _GDIPlus_FontFamilyCreate($sFont)•./Include/_MyFunction.au3'
	Local Const $hFamily = _GDIPlus_FontFamilyCreate($sFont)
	$__iLineNumber=1118 & ' - If Not $hFamily Then Return SetError(1, 0, $aSize)•./Include/_MyFunction.au3'
	If Not $hFamily Then Return SetError(1, 0, $aSize)
	$__iLineNumber=1119 & ' - Local Const $hFormat = _GDIPlus_StringFormatCreate()•./Include/_MyFunction.au3'
	Local Const $hFormat = _GDIPlus_StringFormatCreate()
	$__iLineNumber=1120 & ' - Local Const $hFont = _GDIPlus_FontCreate($hFamily, $fSize, $ ...•./Include/_MyFunction.au3'
	Local Const $hFont = _GDIPlus_FontCreate($hFamily, $fSize, $iStyle)
	$__iLineNumber=1121 & ' - Local Const $tLayout = _GDIPlus_RectFCreate(0, 0, 0, 0)•./Include/_MyFunction.au3'
	Local Const $tLayout = _GDIPlus_RectFCreate(0, 0, 0, 0)
	$__iLineNumber=1122 & ' - Local Const $hGraphic = _GDIPlus_GraphicsCreateFromHWND(0)•./Include/_MyFunction.au3'
	Local Const $hGraphic = _GDIPlus_GraphicsCreateFromHWND(0)
	$__iLineNumber=1123 & ' - Local $aInfo = _GDIPlus_GraphicsMeasureString($hGraphic, $sS ...•./Include/_MyFunction.au3'
	Local $aInfo = _GDIPlus_GraphicsMeasureString($hGraphic, $sString, $hFont, $tLayout, $hFormat)
	$__iLineNumber=1124 & ' - $aSize[0] = $bRound ? Round($aInfo[0].Width, 0) : $aInfo[0]. ...•./Include/_MyFunction.au3'
	$aSize[0] = $bRound ? Round($aInfo[0].Width, 0) : $aInfo[0].Width
	$__iLineNumber=1125 & ' - $aSize[1] = $bRound ? Round($aInfo[0].Height, 0) : $aInfo[0] ...•./Include/_MyFunction.au3'
	$aSize[1] = $bRound ? Round($aInfo[0].Height, 0) : $aInfo[0].Height
	$__iLineNumber=1126 & ' - _GDIPlus_FontDispose($hFont)•./Include/_MyFunction.au3'
	_GDIPlus_FontDispose($hFont)
	$__iLineNumber=1127 & ' - _WinAPI_DeleteObject($hFont)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hFont)
	$__iLineNumber=1128 & ' - _GDIPlus_FontFamilyDispose($hFamily)•./Include/_MyFunction.au3'
	_GDIPlus_FontFamilyDispose($hFamily)
	$__iLineNumber=1129 & ' - _WinAPI_DeleteObject($hFamily)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hFamily)
	$__iLineNumber=1130 & ' - _GDIPlus_StringFormatDispose($hFormat)•./Include/_MyFunction.au3'
	_GDIPlus_StringFormatDispose($hFormat)
	$__iLineNumber=1131 & ' - _WinAPI_DeleteObject($hFormat)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hFormat)
	$__iLineNumber=1132 & ' - _GDIPlus_GraphicsDispose($hGraphic)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphic)
	$__iLineNumber=1133 & ' - Return $aSize•./Include/_MyFunction.au3'
	Return $aSize
EndFunc   ;==>_GDIPlus_MeasureString

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
$__iLineNumber=1156 & ' - Func _GDIPlus_TransparencyZone($iPath, $vTarget_Width, $vTar ...•./Include/_MyFunction.au3'
Func _GDIPlus_TransparencyZone($iPath, $vTarget_Width, $vTarget_Height, $iTransLvl = 1, $iX = 0, $iY = 0, $iWidth = "", $iHeight = "")
	#forceref $iX, $iY, $iWidth, $iHeight
	$__iLineNumber=1158 & ' - Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGU ...•./Include/_MyFunction.au3'
	Local $hImage, $ImageWidth, $ImageHeight, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	$__iLineNumber=1159 & ' - Local $MergedImageBackgroundColor = 0x00000000•./Include/_MyFunction.au3'
	Local $MergedImageBackgroundColor = 0x00000000
	$__iLineNumber=1160 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=1161 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=1162 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-TRANSZONE_Tem ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-TRANSZONE_Temp.PNG"
	$__iLineNumber=1163 & ' - $iPath_CutHole_Temp = $sDrive & $sDir & $sFileName & "-CutHo ...•./Include/_MyFunction.au3'
	$iPath_CutHole_Temp = $sDrive & $sDir & $sFileName & "-CutHole_Temp.PNG"
	$__iLineNumber=1164 & ' - $iPath_Crop_Temp = $sDrive & $sDir & $sFileName & "-CutCrop_ ...•./Include/_MyFunction.au3'
	$iPath_Crop_Temp = $sDrive & $sDir & $sFileName & "-CutCrop_Temp.PNG"
	$__iLineNumber=1165 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=1166 & ' - $iPath = $sDrive & $sDir & $sFileName & ".png"•./Include/_MyFunction.au3'
	$iPath = $sDrive & $sDir & $sFileName & ".png"
	$__iLineNumber=1167 & ' - _GDIPlus_CalcPos($iX, $iY, $iWidth, $iHeight, $vTarget_Width ...•./Include/_MyFunction.au3'
	_GDIPlus_CalcPos($iX, $iY, $iWidth, $iHeight, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1168 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=1169 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=1170 & ' - $hNew_CutHole = _GDIPlus_ImageCutRectHole($hImage, $iX, $iY, ...•./Include/_MyFunction.au3'
	$hNew_CutHole = _GDIPlus_ImageCutRectHole($hImage, $iX, $iY, $iWidth, $iHeight, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1171 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1172 & ' - _LOG("Error _GDIPlus_ImageCutRectHole " & $iPath_Temp, 2, $i ...•./Include/_MyFunction.au3'
		_LOG("Error _GDIPlus_ImageCutRectHole " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=1173 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1175 & ' - $hNew_Crop = _GDIPlus_ImageCrop($hImage, $iX, $iY, $iWidth,  ...•./Include/_MyFunction.au3'
	$hNew_Crop = _GDIPlus_ImageCrop($hImage, $iX, $iY, $iWidth, $iHeight, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1176 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1177 & ' - _LOG("Error _GDIPlus_ImageCrop " & $iPath_Temp, 2, $iLOGPath ...•./Include/_MyFunction.au3'
		_LOG("Error _GDIPlus_ImageCrop " & $iPath_Temp, 2, $iLOGPath)
		$__iLineNumber=1178 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1180 & ' - _GDIPlus_ImageSaveToFile($hNew_CutHole, $iPath_CutHole_Temp)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hNew_CutHole, $iPath_CutHole_Temp)
	$__iLineNumber=1181 & ' - _GDIPlus_ImageSaveToFile($hNew_Crop, $iPath_Crop_Temp)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hNew_Crop, $iPath_Crop_Temp)
	$__iLineNumber=1182 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=1183 & ' - _WinAPI_DeleteObject($hImage)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImage)
	$__iLineNumber=1184 & ' - _GDIPlus_BitmapDispose($hNew_CutHole)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hNew_CutHole)
	$__iLineNumber=1185 & ' - _WinAPI_DeleteObject($hNew_CutHole)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hNew_CutHole)
	$__iLineNumber=1186 & ' - _GDIPlus_BitmapDispose($hNew_Crop)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hNew_Crop)
	$__iLineNumber=1187 & ' - _WinAPI_DeleteObject($hNew_Crop)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hNew_Crop)
	$__iLineNumber=1188 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=1189 & ' - _GDIPlus_Transparency($iPath_Crop_Temp, $iTransLvl)•./Include/_MyFunction.au3'
	_GDIPlus_Transparency($iPath_Crop_Temp, $iTransLvl)
	$__iLineNumber=1190 & ' - _GDIPlus_Merge($iPath_CutHole_Temp, $iPath_Crop_Temp)•./Include/_MyFunction.au3'
	_GDIPlus_Merge($iPath_CutHole_Temp, $iPath_Crop_Temp)
	$__iLineNumber=1191 & ' - FileCopy($iPath_CutHole_Temp, $iPath)•./Include/_MyFunction.au3'
	FileCopy($iPath_CutHole_Temp, $iPath)
	$__iLineNumber=1192 & ' - FileDelete($iPath_CutHole_Temp)•./Include/_MyFunction.au3'
	FileDelete($iPath_CutHole_Temp)
	$__iLineNumber=1193 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=1194 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
;~ 		Return -1
	EndIf
	$__iLineNumber=1197 & ' - Return $iPath•./Include/_MyFunction.au3'
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
$__iLineNumber=1219 & ' - Func _GDIPlus_ImageCutRectHole($hImage, $iX, $iY, $iWidthCut ...•./Include/_MyFunction.au3'
Func _GDIPlus_ImageCutRectHole($hImage, $iX, $iY, $iWidthCut, $iHeightCut, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1220 & ' - Local $hTexture = _GDIPlus_TextureCreate($hImage, 4)•./Include/_MyFunction.au3'
	Local $hTexture = _GDIPlus_TextureCreate($hImage, 4)
	$__iLineNumber=1221 & ' - $hImage = _GDIPlus_BitmapCreateFromScan0($vTarget_Width, $vT ...•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_BitmapCreateFromScan0($vTarget_Width, $vTarget_Height)
	$__iLineNumber=1222 & ' - Local $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hImage)•./Include/_MyFunction.au3'
	Local $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hImage)
	$__iLineNumber=1223 & ' - _GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, 2)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, 2)
	$__iLineNumber=1224 & ' - _GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, 2)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, 2)
	$__iLineNumber=1225 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, 0, 0, $iX, $vTarget_Hei ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, 0, 0, $iX, $vTarget_Height, $hTexture)
	$__iLineNumber=1226 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, $iX + $iWidthCut, 0, $v ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, $iX + $iWidthCut, 0, $vTarget_Width - ($iX + $iWidthCut), $vTarget_Height, $hTexture)
	$__iLineNumber=1227 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, 0, $iWidthCut, $iY ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, 0, $iWidthCut, $iY, $hTexture)
	$__iLineNumber=1228 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, $iY + $iHeightCut, ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, $iY + $iHeightCut, $iWidthCut, $vTarget_Height - ($iY + $iHeightCut), $hTexture)
	$__iLineNumber=1229 & ' - _GDIPlus_BrushDispose($hTexture)•./Include/_MyFunction.au3'
	_GDIPlus_BrushDispose($hTexture)
	$__iLineNumber=1230 & ' - _WinAPI_DeleteObject($hTexture)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hTexture)
	$__iLineNumber=1231 & ' - _GDIPlus_GraphicsDispose($hGfxCtxt)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGfxCtxt)
	$__iLineNumber=1232 & ' - _WinAPI_DeleteObject($hGfxCtxt)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGfxCtxt)
	$__iLineNumber=1233 & ' - Return $hImage•./Include/_MyFunction.au3'
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
$__iLineNumber=1255 & ' - Func _GDIPlus_ImageCrop($hImage, $iX, $iY, $iWidthCut, $iHei ...•./Include/_MyFunction.au3'
Func _GDIPlus_ImageCrop($hImage, $iX, $iY, $iWidthCut, $iHeightCut, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1256 & ' - Local $hTexture = _GDIPlus_TextureCreate($hImage, 4)•./Include/_MyFunction.au3'
	Local $hTexture = _GDIPlus_TextureCreate($hImage, 4)
	$__iLineNumber=1257 & ' - $hImage = _GDIPlus_BitmapCreateFromScan0($vTarget_Width, $vT ...•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_BitmapCreateFromScan0($vTarget_Width, $vTarget_Height)
	$__iLineNumber=1258 & ' - Local $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hImage)•./Include/_MyFunction.au3'
	Local $hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($hImage)
	$__iLineNumber=1259 & ' - _GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, 2)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsSetSmoothingMode($hGfxCtxt, 2)
	$__iLineNumber=1260 & ' - _GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, 2)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsSetPixelOffsetMode($hGfxCtxt, 2)
	$__iLineNumber=1261 & ' - _GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, $iY, $iWidthCut, $ ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsFillRect($hGfxCtxt, $iX, $iY, $iWidthCut, $iHeightCut, $hTexture)
	$__iLineNumber=1262 & ' - _GDIPlus_BrushDispose($hTexture)•./Include/_MyFunction.au3'
	_GDIPlus_BrushDispose($hTexture)
	$__iLineNumber=1263 & ' - _WinAPI_DeleteObject($hTexture)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hTexture)
	$__iLineNumber=1264 & ' - _GDIPlus_GraphicsDispose($hGfxCtxt)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGfxCtxt)
	$__iLineNumber=1265 & ' - _WinAPI_DeleteObject($hGfxCtxt)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGfxCtxt)
	$__iLineNumber=1266 & ' - Return $hImage•./Include/_MyFunction.au3'
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
$__iLineNumber=1286 & ' - Func _GDIPlus_CalcPos(ByRef $iX, ByRef $iY, ByRef $iWidth, B ...•./Include/_MyFunction.au3'
Func _GDIPlus_CalcPos(ByRef $iX, ByRef $iY, ByRef $iWidth, ByRef $iHeight, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1287 & ' - $iWidth = _GDIPlus_RelativePos($iWidth, $vTarget_Width)•./Include/_MyFunction.au3'
	$iWidth = _GDIPlus_RelativePos($iWidth, $vTarget_Width)
	$__iLineNumber=1288 & ' - If $iWidth = "" Then $iWidth = $vTarget_Width•./Include/_MyFunction.au3'
	If $iWidth = "" Then $iWidth = $vTarget_Width
	$__iLineNumber=1289 & ' - $iHeight = _GDIPlus_RelativePos($iHeight, $vTarget_Height)•./Include/_MyFunction.au3'
	$iHeight = _GDIPlus_RelativePos($iHeight, $vTarget_Height)
	$__iLineNumber=1290 & ' - If $iHeight = "" Then $iHeight = $vTarget_Height•./Include/_MyFunction.au3'
	If $iHeight = "" Then $iHeight = $vTarget_Height
	$__iLineNumber=1291 & ' - $iX = _GDIPlus_CalcPosX($iX, $iWidth, $vTarget_Width)•./Include/_MyFunction.au3'
	$iX = _GDIPlus_CalcPosX($iX, $iWidth, $vTarget_Width)
	$__iLineNumber=1292 & ' - $iY = _GDIPlus_CalcPosY($iY, $iHeight, $vTarget_Height)•./Include/_MyFunction.au3'
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
$__iLineNumber=1309 & ' - Func _GDIPlus_CalcPosX($iX, $iWidth, $vTarget_Width)•./Include/_MyFunction.au3'
Func _GDIPlus_CalcPosX($iX, $iWidth, $vTarget_Width)
	$__iLineNumber=1310 & ' - $iX = _GDIPlus_RelativePos($iX, $vTarget_Width)•./Include/_MyFunction.au3'
	$iX = _GDIPlus_RelativePos($iX, $vTarget_Width)
	$__iLineNumber=1311 & ' - Switch $iX•./Include/_MyFunction.au3'
	$__iLineNumber=1312 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $iX
		Case 'CENTER'
			$__iLineNumber=1313 & ' - $iX = ($vTarget_Width / 2) - ($iWidth / 2)•./Include/_MyFunction.au3'
			$iX = ($vTarget_Width / 2) - ($iWidth / 2)
		$__iLineNumber=1314 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1315 & ' - $iX = 0•./Include/_MyFunction.au3'
			$iX = 0
		$__iLineNumber=1316 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1317 & ' - $iX = $vTarget_Width - $iWidth•./Include/_MyFunction.au3'
			$iX = $vTarget_Width - $iWidth
	EndSwitch
	$__iLineNumber=1319 & ' - Return Int($iX)•./Include/_MyFunction.au3'
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
$__iLineNumber=1336 & ' - Func _GDIPlus_CalcPosY($iY, $iHeight, $vTarget_Height)•./Include/_MyFunction.au3'
Func _GDIPlus_CalcPosY($iY, $iHeight, $vTarget_Height)
	$__iLineNumber=1337 & ' - $iY = _GDIPlus_RelativePos($iY, $vTarget_Height)•./Include/_MyFunction.au3'
	$iY = _GDIPlus_RelativePos($iY, $vTarget_Height)
	$__iLineNumber=1338 & ' - Switch $iY•./Include/_MyFunction.au3'
	$__iLineNumber=1339 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $iY
		Case 'CENTER'
			$__iLineNumber=1340 & ' - $iY = ($vTarget_Height / 2) - ($iHeight / 2)•./Include/_MyFunction.au3'
			$iY = ($vTarget_Height / 2) - ($iHeight / 2)
		$__iLineNumber=1341 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1342 & ' - $iY = 0•./Include/_MyFunction.au3'
			$iY = 0
		$__iLineNumber=1343 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1344 & ' - $iY = $vTarget_Height - $iHeight•./Include/_MyFunction.au3'
			$iY = $vTarget_Height - $iHeight
	EndSwitch
	$__iLineNumber=1346 & ' - Return Int($iY)•./Include/_MyFunction.au3'
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
$__iLineNumber=1363 & ' - Func _GDIPlus_Merge($iPath1, $iPath2)•./Include/_MyFunction.au3'
Func _GDIPlus_Merge($iPath1, $iPath2)
;~ 	MsgBox(0,"DEBUG","_GDIPlus_Merge");Debug
	$__iLineNumber=1365 & ' - Local $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic, $ImageWidth ...•./Include/_MyFunction.au3'
	Local $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic, $ImageWidth, $ImageHeight
	$__iLineNumber=1366 & ' - Local $MergedImageBackgroundColor = 0x00000000•./Include/_MyFunction.au3'
	Local $MergedImageBackgroundColor = 0x00000000
	$__iLineNumber=1367 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp
	$__iLineNumber=1368 & ' - _PathSplit($iPath1, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath1, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=1369 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-MER_Temp.PNG"•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-MER_Temp.PNG"

	$__iLineNumber=1371 & ' - If _MakeTEMPFile($iPath1, $iPath_Temp) = -1 Then•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath1, $iPath_Temp) = -1 Then
		$__iLineNumber=1372 & ' - _LOG("Error Merging " & $iPath1 & " and " & $iPath2, 2, $iLO ...•./Include/_MyFunction.au3'
		_LOG("Error Merging " & $iPath1 & " and " & $iPath2, 2, $iLOGPath)
		$__iLineNumber=1373 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf

	$__iLineNumber=1376 & ' - $iPath1 = $sDrive & $sDir & $sFileName & ".png"•./Include/_MyFunction.au3'
	$iPath1 = $sDrive & $sDir & $sFileName & ".png"

	$__iLineNumber=1378 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=1379 & ' - $hImage1 = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage1 = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=1380 & ' - $hImage2 = _GDIPlus_ImageLoadFromFile($iPath2)•./Include/_MyFunction.au3'
	$hImage2 = _GDIPlus_ImageLoadFromFile($iPath2)
	$__iLineNumber=1381 & ' - $ImageWidth = _GDIPlus_ImageGetWidth($hImage1)•./Include/_MyFunction.au3'
	$ImageWidth = _GDIPlus_ImageGetWidth($hImage1)
	$__iLineNumber=1382 & ' - If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 ...•./Include/_MyFunction.au3'
	If $ImageWidth = 4294967295 Then $ImageWidth = 0 ;4294967295 en cas d'erreur.
	$__iLineNumber=1383 & ' - $ImageHeight = _GDIPlus_ImageGetHeight($hImage1)•./Include/_MyFunction.au3'
	$ImageHeight = _GDIPlus_ImageGetHeight($hImage1)
	$__iLineNumber=1384 & ' - $hGui = GUICreate("", $ImageWidth, $ImageHeight)•./Include/_MyFunction.au3'
	$hGui = GUICreate("", $ImageWidth, $ImageHeight)
	$__iLineNumber=1385 & ' - $hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw  ...•./Include/_MyFunction.au3'
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$__iLineNumber=1386 & ' - $hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ ...•./Include/_MyFunction.au3'
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($ImageWidth, $ImageHeight, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$__iLineNumber=1387 & ' - $hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Dr ...•./Include/_MyFunction.au3'
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	$__iLineNumber=1388 & ' - _GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColo ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor) ;Fill the Graphic Background (0x00000000 for transparent background in .png files)
	$__iLineNumber=1389 & ' - _GDIPlus_GraphicsDrawImage($hGraphic, $hImage1, 0, 0)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage1, 0, 0)
	$__iLineNumber=1390 & ' - _GDIPlus_GraphicsDrawImage($hGraphic, $hImage2, 0, 0)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage2, 0, 0)

	$__iLineNumber=1392 & ' - _LOG("Merging " & $iPath2 & " on " & $iPath_Temp, 0, $iLOGPa ...•./Include/_MyFunction.au3'
	_LOG("Merging " & $iPath2 & " on " & $iPath_Temp, 0, $iLOGPath) ; Debug
	$__iLineNumber=1393 & ' - _GDIPlus_ImageSaveToFile($hBMPBuff, $iPath1)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hBMPBuff, $iPath1)

	$__iLineNumber=1395 & ' - _GDIPlus_GraphicsDispose($hGraphic)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphic)
	$__iLineNumber=1396 & ' - _WinAPI_DeleteObject($hGraphic)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGraphic)
	$__iLineNumber=1397 & ' - _GDIPlus_BitmapDispose($hBMPBuff)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hBMPBuff)
	$__iLineNumber=1398 & ' - _WinAPI_DeleteObject($hBMPBuff)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hBMPBuff)
	$__iLineNumber=1399 & ' - _GDIPlus_GraphicsDispose($hGraphicGUI)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	$__iLineNumber=1400 & ' - _WinAPI_DeleteObject($hGraphicGUI)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGraphicGUI)
	$__iLineNumber=1401 & ' - GUIDelete($hGui)•./Include/_MyFunction.au3'
	GUIDelete($hGui)
	$__iLineNumber=1402 & ' - _GDIPlus_ImageDispose($hImage2)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage2)
	$__iLineNumber=1403 & ' - _WinAPI_DeleteObject($hImage2)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImage2)
	$__iLineNumber=1404 & ' - _GDIPlus_ImageDispose($hImage1)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage1)
	$__iLineNumber=1405 & ' - _WinAPI_DeleteObject($hImage1)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImage1)
	$__iLineNumber=1406 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=1407 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=1408 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
;~ 		Return -1
	EndIf
	$__iLineNumber=1411 & ' - If Not FileDelete($iPath2) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath2) Then
		$__iLineNumber=1412 & ' - _LOG("Error deleting " & $iPath2, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath2, 2, $iLOGPath)
;~ 		Return -1
	EndIf
	$__iLineNumber=1415 & ' - Return $iPath1•./Include/_MyFunction.au3'
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
$__iLineNumber=1443 & ' - Func _GDIPlus_GraphicsDrawImageRectRectTrans($hGraphics, $hI ...•./Include/_MyFunction.au3'
Func _GDIPlus_GraphicsDrawImageRectRectTrans($hGraphics, $hImage, $iSrcX, $iSrcY, $iSrcWidth = "", $iSrcHeight = "", _
		$iDstX = "", $iDstY = "", $iDstWidth = "", $iDstHeight = "", $iUnit = 2, $nTrans = 1)
	$__iLineNumber=1445 & ' - Local $tColorMatrix, $hImgAttrib, $iW = _GDIPlus_ImageGetWid ...•./Include/_MyFunction.au3'
	Local $tColorMatrix, $hImgAttrib, $iW = _GDIPlus_ImageGetWidth($hImage), $iH = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=1446 & ' - If $iSrcWidth = 0 Or $iSrcWidth = "" Then $iSrcWidth = $iW•./Include/_MyFunction.au3'
	If $iSrcWidth = 0 Or $iSrcWidth = "" Then $iSrcWidth = $iW
	$__iLineNumber=1447 & ' - If $iSrcHeight = 0 Or $iSrcHeight = "" Then $iSrcHeight = $i ...•./Include/_MyFunction.au3'
	If $iSrcHeight = 0 Or $iSrcHeight = "" Then $iSrcHeight = $iH
	$__iLineNumber=1448 & ' - If $iDstX = "" Then $iDstX = $iSrcX•./Include/_MyFunction.au3'
	If $iDstX = "" Then $iDstX = $iSrcX
	$__iLineNumber=1449 & ' - If $iDstY = "" Then $iDstY = $iSrcY•./Include/_MyFunction.au3'
	If $iDstY = "" Then $iDstY = $iSrcY
	$__iLineNumber=1450 & ' - If $iDstWidth = "" Then $iDstWidth = $iSrcWidth•./Include/_MyFunction.au3'
	If $iDstWidth = "" Then $iDstWidth = $iSrcWidth
	$__iLineNumber=1451 & ' - If $iDstHeight = "" Then $iDstHeight = $iSrcHeight•./Include/_MyFunction.au3'
	If $iDstHeight = "" Then $iDstHeight = $iSrcHeight
	$__iLineNumber=1452 & ' - If $iUnit = "" Then $iUnit = 2•./Include/_MyFunction.au3'
	If $iUnit = "" Then $iUnit = 2
	;;create color matrix data
	$__iLineNumber=1454 & ' - $tColorMatrix = DllStructCreate("float[5];float[5];float[5]; ...•./Include/_MyFunction.au3'
	$tColorMatrix = DllStructCreate("float[5];float[5];float[5];float[5];float[5]")
	;blending values:
	$__iLineNumber=1456 & ' - Local $x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStr ...•./Include/_MyFunction.au3'
	Local $x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStructSetData($tColorMatrix, 2, 1, 2) * DllStructSetData($tColorMatrix, 3, 1, 3) * _
			DllStructSetData($tColorMatrix, 4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 1, 5)
;~ 	$x = $x
	;;create an image attributes object and update its color matrix
	$__iLineNumber=1460 & ' - $hImgAttrib = _GDIPlus_ImageAttributesCreate()•./Include/_MyFunction.au3'
	$hImgAttrib = _GDIPlus_ImageAttributesCreate()
	$__iLineNumber=1461 & ' - _GDIPlus_ImageAttributesSetColorMatrix($hImgAttrib, 1, 1, Dl ...•./Include/_MyFunction.au3'
	_GDIPlus_ImageAttributesSetColorMatrix($hImgAttrib, 1, 1, DllStructGetPtr($tColorMatrix))
	$__iLineNumber=1462 & ' - _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $iSr ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $iSrcX, $iSrcY, $iSrcWidth, $iSrcHeight, $iDstX, $iDstY, $iDstWidth, $iDstHeight, $hImgAttrib, $iUnit)
	;;clean up
	$__iLineNumber=1464 & ' - _GDIPlus_ImageAttributesDispose($hImgAttrib)•./Include/_MyFunction.au3'
	_GDIPlus_ImageAttributesDispose($hImgAttrib)
	$__iLineNumber=1465 & ' - _WinAPI_DeleteObject($hImgAttrib)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImgAttrib)
	$__iLineNumber=1466 & ' - Return•./Include/_MyFunction.au3'
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
$__iLineNumber=1494 & ' - Func _GDIPlus_Imaging($iPath, $aPicParameters, $vTarget_Widt ...•./Include/_MyFunction.au3'
Func _GDIPlus_Imaging($iPath, $aPicParameters, $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1495 & ' - Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp,  ...•./Include/_MyFunction.au3'
	Local $sDrive, $sDir, $sFileName, $iExtension, $iPath_Temp, $vNo4thPoint = 0
	$__iLineNumber=1496 & ' - _PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)•./Include/_MyFunction.au3'
	_PathSplit($iPath, $sDrive, $sDir, $sFileName, $iExtension)
	$__iLineNumber=1497 & ' - $aPicParameters[8] = StringUpper($aPicParameters[8])•./Include/_MyFunction.au3'
	$aPicParameters[8] = StringUpper($aPicParameters[8])
	$__iLineNumber=1498 & ' - $iPath_Temp = $sDrive & $sDir & $sFileName & "-IMAGING_Temp" ...•./Include/_MyFunction.au3'
	$iPath_Temp = $sDrive & $sDir & $sFileName & "-IMAGING_Temp" & $iExtension
	$__iLineNumber=1499 & ' - Local $hImage, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic•./Include/_MyFunction.au3'
	Local $hImage, $hGui, $hGraphicGUI, $hBMPBuff, $hGraphic
	$__iLineNumber=1500 & ' - Local $MergedImageBackgroundColor = 0x00000000•./Include/_MyFunction.au3'
	Local $MergedImageBackgroundColor = 0x00000000
	$__iLineNumber=1501 & ' - Local $iWidth = _GDIPlus_RelativePos($aPicParameters[0], $vT ...•./Include/_MyFunction.au3'
	Local $iWidth = _GDIPlus_RelativePos($aPicParameters[0], $vTarget_Width)
	$__iLineNumber=1502 & ' - Local $iHeight = _GDIPlus_RelativePos($aPicParameters[1], $v ...•./Include/_MyFunction.au3'
	Local $iHeight = _GDIPlus_RelativePos($aPicParameters[1], $vTarget_Height)
	$__iLineNumber=1503 & ' - If $aPicParameters[8] = "YES" Then _GDIPlus_ResizeMax($iPath ...•./Include/_MyFunction.au3'
	If $aPicParameters[8] = 'YES' Then _GDIPlus_ResizeMax($iPath, $iWidth, $iHeight)
	$__iLineNumber=1504 & ' - If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1•./Include/_MyFunction.au3'
	If _MakeTEMPFile($iPath, $iPath_Temp) = -1 Then Return -1
	$__iLineNumber=1505 & ' - _GDIPlus_Startup()•./Include/_MyFunction.au3'
	_GDIPlus_Startup()
	$__iLineNumber=1506 & ' - $hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)•./Include/_MyFunction.au3'
	$hImage = _GDIPlus_ImageLoadFromFile($iPath_Temp)
	$__iLineNumber=1507 & ' - If $iWidth <= 0 Or $aPicParameters[8] = "YES" Then $iWidth = ...•./Include/_MyFunction.au3'
	If $iWidth <= 0 Or $aPicParameters[8] = 'YES' Then $iWidth = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=1508 & ' - If $iHeight <= 0 Or $aPicParameters[8] = "YES" Then $iHeight ...•./Include/_MyFunction.au3'
	If $iHeight <= 0 Or $aPicParameters[8] = 'YES' Then $iHeight = _GDIPlus_ImageGetHeight($hImage)
	$__iLineNumber=1509 & ' - $hGui = GUICreate("", $vTarget_Width, $vTarget_Height)•./Include/_MyFunction.au3'
	$hGui = GUICreate("", $vTarget_Width, $vTarget_Height)
	$__iLineNumber=1510 & ' - $hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw  ...•./Include/_MyFunction.au3'
	$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hGui) ;Draw to this graphics, $hGraphicGUI, to display on GUI
	$__iLineNumber=1511 & ' - $hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($vTarget_Width ...•./Include/_MyFunction.au3'
	$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($vTarget_Width, $vTarget_Height, $hGraphicGUI) ; $hBMPBuff is a bitmap in memory
	$__iLineNumber=1512 & ' - $hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Dr ...•./Include/_MyFunction.au3'
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff) ; Draw to this graphics, $hGraphic, being the graphics of $hBMPBuff
	$__iLineNumber=1513 & ' - _GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColo ...•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsClear($hGraphic, $MergedImageBackgroundColor) ; Fill the Graphic Background (0x00000000 for transparent background in .png files)
	$__iLineNumber=1514 & ' - Local $Image_C1X = _GDIPlus_RelativePos($aPicParameters[2],  ...•./Include/_MyFunction.au3'
	Local $Image_C1X = _GDIPlus_RelativePos($aPicParameters[2], $vTarget_Width)
	$__iLineNumber=1515 & ' - Local $Image_C1Y = _GDIPlus_RelativePos($aPicParameters[3],  ...•./Include/_MyFunction.au3'
	Local $Image_C1Y = _GDIPlus_RelativePos($aPicParameters[3], $vTarget_Height)
	$__iLineNumber=1516 & ' - Local $Image_C2X = _GDIPlus_RelativePos($aPicParameters[4],  ...•./Include/_MyFunction.au3'
	Local $Image_C2X = _GDIPlus_RelativePos($aPicParameters[4], $vTarget_Width)
	$__iLineNumber=1517 & ' - Local $Image_C2Y = _GDIPlus_RelativePos($aPicParameters[5],  ...•./Include/_MyFunction.au3'
	Local $Image_C2Y = _GDIPlus_RelativePos($aPicParameters[5], $vTarget_Height)
	$__iLineNumber=1518 & ' - Local $Image_C3X = _GDIPlus_RelativePos($aPicParameters[6],  ...•./Include/_MyFunction.au3'
	Local $Image_C3X = _GDIPlus_RelativePos($aPicParameters[6], $vTarget_Width)
	$__iLineNumber=1519 & ' - Local $Image_C3Y = _GDIPlus_RelativePos($aPicParameters[7],  ...•./Include/_MyFunction.au3'
	Local $Image_C3Y = _GDIPlus_RelativePos($aPicParameters[7], $vTarget_Height)
	$__iLineNumber=1520 & ' - Local $Image_C4X = _GDIPlus_RelativePos($aPicParameters[11], ...•./Include/_MyFunction.au3'
	Local $Image_C4X = _GDIPlus_RelativePos($aPicParameters[11], $vTarget_Width)
	$__iLineNumber=1521 & ' - Local $Image_C4Y = _GDIPlus_RelativePos($aPicParameters[12], ...•./Include/_MyFunction.au3'
	Local $Image_C4Y = _GDIPlus_RelativePos($aPicParameters[12], $vTarget_Height)
	$__iLineNumber=1522 & ' - Local $Image_OriginX = _GDIPlus_RelativePos($aPicParameters[ ...•./Include/_MyFunction.au3'
	Local $Image_OriginX = _GDIPlus_RelativePos($aPicParameters[13], $iWidth)
	$__iLineNumber=1523 & ' - Local $Image_OriginY = _GDIPlus_RelativePos($aPicParameters[ ...•./Include/_MyFunction.au3'
	Local $Image_OriginY = _GDIPlus_RelativePos($aPicParameters[14], $iHeight)
	$__iLineNumber=1524 & ' - Switch $Image_OriginX•./Include/_MyFunction.au3'
	$__iLineNumber=1525 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_OriginX
		Case 'CENTER'
			$__iLineNumber=1526 & ' - $Image_OriginX = $iWidth / 2•./Include/_MyFunction.au3'
			$Image_OriginX = $iWidth / 2
		$__iLineNumber=1527 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1528 & ' - $Image_OriginX = 0•./Include/_MyFunction.au3'
			$Image_OriginX = 0
		$__iLineNumber=1529 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1530 & ' - $Image_OriginX = $iWidth•./Include/_MyFunction.au3'
			$Image_OriginX = $iWidth
		$__iLineNumber=1531 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1532 & ' - $Image_OriginX = 0•./Include/_MyFunction.au3'
			$Image_OriginX = 0
	EndSwitch
	$__iLineNumber=1534 & ' - Switch $Image_OriginY•./Include/_MyFunction.au3'
	$__iLineNumber=1535 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_OriginY
		Case 'CENTER'
			$__iLineNumber=1536 & ' - $Image_OriginY = $iHeight / 2•./Include/_MyFunction.au3'
			$Image_OriginY = $iHeight / 2
		$__iLineNumber=1537 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1538 & ' - $Image_OriginY = 0•./Include/_MyFunction.au3'
			$Image_OriginY = 0
		$__iLineNumber=1539 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1540 & ' - $Image_OriginY = $iHeight•./Include/_MyFunction.au3'
			$Image_OriginY = $iHeight
		$__iLineNumber=1541 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1542 & ' - $Image_OriginY = 0•./Include/_MyFunction.au3'
			$Image_OriginY = 0
	EndSwitch
	$__iLineNumber=1544 & ' - Switch $Image_C1X•./Include/_MyFunction.au3'
	$__iLineNumber=1545 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C1X
		Case 'CENTER'
			$__iLineNumber=1546 & ' - $Image_C1X = Int($vTarget_Width / 2)•./Include/_MyFunction.au3'
			$Image_C1X = Int($vTarget_Width / 2)
		$__iLineNumber=1547 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1548 & ' - $Image_C1X = 0•./Include/_MyFunction.au3'
			$Image_C1X = 0
		$__iLineNumber=1549 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1550 & ' - $Image_C1X = $vTarget_Width•./Include/_MyFunction.au3'
			$Image_C1X = $vTarget_Width
	EndSwitch
	$__iLineNumber=1552 & ' - Switch $Image_C1Y•./Include/_MyFunction.au3'
	$__iLineNumber=1553 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C1Y
		Case 'CENTER'
			$__iLineNumber=1554 & ' - $Image_C1Y = Int($vTarget_Height / 2)•./Include/_MyFunction.au3'
			$Image_C1Y = Int($vTarget_Height / 2)
		$__iLineNumber=1555 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1556 & ' - $Image_C1Y = 0•./Include/_MyFunction.au3'
			$Image_C1Y = 0
		$__iLineNumber=1557 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1558 & ' - $Image_C1Y = $vTarget_Height•./Include/_MyFunction.au3'
			$Image_C1Y = $vTarget_Height
	EndSwitch
	$__iLineNumber=1560 & ' - Switch $Image_C2X•./Include/_MyFunction.au3'
	$__iLineNumber=1561 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C2X
		Case 'CENTER'
			$__iLineNumber=1562 & ' - $Image_C2X = Int($vTarget_Width / 2) + $iWidth•./Include/_MyFunction.au3'
			$Image_C2X = Int($vTarget_Width / 2) + $iWidth
		$__iLineNumber=1563 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1564 & ' - $Image_C2X = $iWidth•./Include/_MyFunction.au3'
			$Image_C2X = $iWidth
		$__iLineNumber=1565 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1566 & ' - $Image_C2X = $vTarget_Width + $iWidth•./Include/_MyFunction.au3'
			$Image_C2X = $vTarget_Width + $iWidth
		$__iLineNumber=1567 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1568 & ' - $Image_C2X = $Image_C1X + $iWidth•./Include/_MyFunction.au3'
			$Image_C2X = $Image_C1X + $iWidth
	EndSwitch
	$__iLineNumber=1570 & ' - Switch $Image_C2Y•./Include/_MyFunction.au3'
	$__iLineNumber=1571 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C2Y
		Case 'CENTER'
			$__iLineNumber=1572 & ' - $Image_C2Y = Int($vTarget_Height / 2)•./Include/_MyFunction.au3'
			$Image_C2Y = Int($vTarget_Height / 2)
		$__iLineNumber=1573 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1574 & ' - $Image_C2Y = 0•./Include/_MyFunction.au3'
			$Image_C2Y = 0
		$__iLineNumber=1575 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1576 & ' - $Image_C2Y = $vTarget_Height•./Include/_MyFunction.au3'
			$Image_C2Y = $vTarget_Height
		$__iLineNumber=1577 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1578 & ' - $Image_C2Y = $Image_C1Y•./Include/_MyFunction.au3'
			$Image_C2Y = $Image_C1Y
	EndSwitch
	$__iLineNumber=1580 & ' - Switch $Image_C3X•./Include/_MyFunction.au3'
	$__iLineNumber=1581 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C3X
		Case 'CENTER'
			$__iLineNumber=1582 & ' - $Image_C3X = Int($vTarget_Width / 2)•./Include/_MyFunction.au3'
			$Image_C3X = Int($vTarget_Width / 2)
		$__iLineNumber=1583 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1584 & ' - $Image_C3X = 0•./Include/_MyFunction.au3'
			$Image_C3X = 0
		$__iLineNumber=1585 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1586 & ' - $Image_C3X = $vTarget_Width•./Include/_MyFunction.au3'
			$Image_C3X = $vTarget_Width
		$__iLineNumber=1587 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1588 & ' - $Image_C3X = $Image_C1X•./Include/_MyFunction.au3'
			$Image_C3X = $Image_C1X
	EndSwitch
	$__iLineNumber=1590 & ' - Switch $Image_C3Y•./Include/_MyFunction.au3'
	$__iLineNumber=1591 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C3Y
		Case 'CENTER'
			$__iLineNumber=1592 & ' - $Image_C3Y = Int($vTarget_Height / 2) + $iHeight•./Include/_MyFunction.au3'
			$Image_C3Y = Int($vTarget_Height / 2) + $iHeight
		$__iLineNumber=1593 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1594 & ' - $Image_C3Y = 0 + $iHeight•./Include/_MyFunction.au3'
			$Image_C3Y = 0 + $iHeight
		$__iLineNumber=1595 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1596 & ' - $Image_C3Y = $vTarget_Height + $iHeight•./Include/_MyFunction.au3'
			$Image_C3Y = $vTarget_Height + $iHeight
		$__iLineNumber=1597 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1598 & ' - $Image_C3Y = $Image_C1Y + $iHeight•./Include/_MyFunction.au3'
			$Image_C3Y = $Image_C1Y + $iHeight
	EndSwitch
	$__iLineNumber=1600 & ' - Switch $Image_C4X•./Include/_MyFunction.au3'
	$__iLineNumber=1601 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C4X
		Case 'CENTER'
			$__iLineNumber=1602 & ' - $Image_C4X = Int($vTarget_Width / 2) + $iWidth•./Include/_MyFunction.au3'
			$Image_C4X = Int($vTarget_Width / 2) + $iWidth
		$__iLineNumber=1603 & ' - Case "LEFT"•./Include/_MyFunction.au3'
		Case 'LEFT'
			$__iLineNumber=1604 & ' - $Image_C4X = $iWidth•./Include/_MyFunction.au3'
			$Image_C4X = $iWidth
		$__iLineNumber=1605 & ' - Case "RIGHT"•./Include/_MyFunction.au3'
		Case 'RIGHT'
			$__iLineNumber=1606 & ' - $Image_C4X = $vTarget_Width + $iWidth•./Include/_MyFunction.au3'
			$Image_C4X = $vTarget_Width + $iWidth
		$__iLineNumber=1607 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1608 & ' - $vNo4thPoint = 1•./Include/_MyFunction.au3'
			$vNo4thPoint = 1
			$__iLineNumber=1609 & ' - $Image_C4X = $Image_C1X + $iWidth•./Include/_MyFunction.au3'
			$Image_C4X = $Image_C1X + $iWidth
	EndSwitch
	$__iLineNumber=1611 & ' - Switch $Image_C4Y•./Include/_MyFunction.au3'
	$__iLineNumber=1612 & ' - Case "CENTER"•./Include/_MyFunction.au3'
	Switch $Image_C4Y
		Case 'CENTER'
			$__iLineNumber=1613 & ' - $Image_C4Y = Int($vTarget_Height / 2) + $iHeight•./Include/_MyFunction.au3'
			$Image_C4Y = Int($vTarget_Height / 2) + $iHeight
		$__iLineNumber=1614 & ' - Case "UP"•./Include/_MyFunction.au3'
		Case 'UP'
			$__iLineNumber=1615 & ' - $Image_C4Y = 0 + $iHeight•./Include/_MyFunction.au3'
			$Image_C4Y = 0 + $iHeight
		$__iLineNumber=1616 & ' - Case "DOWN"•./Include/_MyFunction.au3'
		Case 'DOWN'
			$__iLineNumber=1617 & ' - $Image_C4Y = $vTarget_Height + $iHeight•./Include/_MyFunction.au3'
			$Image_C4Y = $vTarget_Height + $iHeight
		$__iLineNumber=1618 & ' - Case ""•./Include/_MyFunction.au3'
		Case ''
			$__iLineNumber=1619 & ' - $vNo4thPoint = 1•./Include/_MyFunction.au3'
			$vNo4thPoint = 1
			$__iLineNumber=1620 & ' - $Image_C4Y = $Image_C1Y + $iHeight•./Include/_MyFunction.au3'
			$Image_C4Y = $Image_C1Y + $iHeight
	EndSwitch


	$__iLineNumber=1624 & ' - $Image_C1X = $Image_C1X + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C1X = $Image_C1X + _GDIPlus_RelativePos($aPicParameters[9], $vTarget_Width) - $Image_OriginX
	$__iLineNumber=1625 & ' - $Image_C1Y = $Image_C1Y + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C1Y = $Image_C1Y + _GDIPlus_RelativePos($aPicParameters[10], $vTarget_Height) - $Image_OriginY
	$__iLineNumber=1626 & ' - $Image_C2X = $Image_C2X + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C2X = $Image_C2X + _GDIPlus_RelativePos($aPicParameters[9], $vTarget_Width) - $Image_OriginX
	$__iLineNumber=1627 & ' - $Image_C2Y = $Image_C2Y + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C2Y = $Image_C2Y + _GDIPlus_RelativePos($aPicParameters[10], $vTarget_Height) - $Image_OriginY
	$__iLineNumber=1628 & ' - $Image_C3X = $Image_C3X + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C3X = $Image_C3X + _GDIPlus_RelativePos($aPicParameters[9], $vTarget_Width) - $Image_OriginX
	$__iLineNumber=1629 & ' - $Image_C3Y = $Image_C3Y + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C3Y = $Image_C3Y + _GDIPlus_RelativePos($aPicParameters[10], $vTarget_Height) - $Image_OriginY
	$__iLineNumber=1630 & ' - $Image_C4X = $Image_C4X + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C4X = $Image_C4X + _GDIPlus_RelativePos($aPicParameters[9], $vTarget_Width) - $Image_OriginX
	$__iLineNumber=1631 & ' - $Image_C4Y = $Image_C4Y + _GDIPlus_RelativePos($aPicParamete ...•./Include/_MyFunction.au3'
	$Image_C4Y = $Image_C4Y + _GDIPlus_RelativePos($aPicParameters[10], $vTarget_Height) - $Image_OriginY

	$__iLineNumber=1633 & ' - If $vNo4thPoint = 1 Then•./Include/_MyFunction.au3'
	If $vNo4thPoint = 1 Then
		$__iLineNumber=1634 & ' - _GDIPlus_DrawImagePoints($hGraphic, $hImage, $Image_C1X, $Im ...•./Include/_MyFunction.au3'
		_GDIPlus_DrawImagePoints($hGraphic, $hImage, $Image_C1X, $Image_C1Y, $Image_C2X, $Image_C2Y, $Image_C3X, $Image_C3Y)
	Else
		$__iLineNumber=1636 & ' - _GDIPlus_GraphicsDrawImage_4Points($hGraphic, $hImage, $Imag ...•./Include/_MyFunction.au3'
		_GDIPlus_GraphicsDrawImage_4Points($hGraphic, $hImage, $Image_C1X, $Image_C1Y, $Image_C2X, $Image_C2Y, $Image_C3X, $Image_C3Y, $Image_C4X, $Image_C4Y)
	EndIf
	$__iLineNumber=1638 & ' - _GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)•./Include/_MyFunction.au3'
	_GDIPlus_ImageSaveToFile($hBMPBuff, $iPath)
	$__iLineNumber=1639 & ' - _GDIPlus_GraphicsDispose($hGraphic)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphic)
	$__iLineNumber=1640 & ' - _WinAPI_DeleteObject($hGraphic)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGraphic)
	$__iLineNumber=1641 & ' - _GDIPlus_BitmapDispose($hBMPBuff)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hBMPBuff)
	$__iLineNumber=1642 & ' - _WinAPI_DeleteObject($hBMPBuff)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hBMPBuff)
	$__iLineNumber=1643 & ' - _GDIPlus_GraphicsDispose($hGraphicGUI)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hGraphicGUI)
	$__iLineNumber=1644 & ' - _WinAPI_DeleteObject($hGraphicGUI)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hGraphicGUI)
	$__iLineNumber=1645 & ' - GUIDelete($hGui)•./Include/_MyFunction.au3'
	GUIDelete($hGui)
	$__iLineNumber=1646 & ' - _GDIPlus_ImageDispose($hImage)•./Include/_MyFunction.au3'
	_GDIPlus_ImageDispose($hImage)
	$__iLineNumber=1647 & ' - _WinAPI_DeleteObject($hImage)•./Include/_MyFunction.au3'
	_WinAPI_DeleteObject($hImage)
	$__iLineNumber=1648 & ' - _GDIPlus_Shutdown()•./Include/_MyFunction.au3'
	_GDIPlus_Shutdown()
	$__iLineNumber=1649 & ' - If Not FileDelete($iPath_Temp) Then•./Include/_MyFunction.au3'
	If Not FileDelete($iPath_Temp) Then
		$__iLineNumber=1650 & ' - _LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("Error deleting " & $iPath_Temp, 2, $iLOGPath)
;~ 		Return -1
	EndIf
	$__iLineNumber=1653 & ' - Return $iPath•./Include/_MyFunction.au3'
	Return $iPath
EndFunc   ;==>_GDIPlus_Imaging

; #FUNCTION# ===================================================================================================
; Name...........: _GDIPlus_GraphicsDrawImage_4Points
; Description ...: Draw Pic with 4 points distortion
; Syntax.........: _GDIPlus_GraphicsDrawImage_4Points($hGraphics, $hImage, $X1, $Y1, $X2, $Y2, $X3, $Y3, $X4, $Y4, $fPrecision = 0.25)
; Parameters ....:
; Return values .:
; Author ........: eukalyptus
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; https://www.autoitscript.com/forum/topic/123623-gdi-image-question/#comment-860805
$__iLineNumber=1668 & ' - Func _GDIPlus_GraphicsDrawImage_4Points($hGraphics, $hImage, ...•./Include/_MyFunction.au3'
Func _GDIPlus_GraphicsDrawImage_4Points($hGraphics, $hImage, $X1, $Y1, $X2, $Y2, $X3, $Y3, $X4, $Y4, $fPrecision = 0.25)
	;by eukalyptus
	$__iLineNumber=1670 & ' - Local $aResult = DllCall($__g_hGDIPDll, "uint", "GdipCreateP ...•./Include/_MyFunction.au3'
	Local $aResult = DllCall($__g_hGDIPDll, "uint", "GdipCreatePath", "int", 0, "int*", 0)
	$__iLineNumber=1671 & ' - If @error Or Not IsArray($aResult) Then Return SetError(1, 1 ...•./Include/_MyFunction.au3'
	If @error Or Not IsArray($aResult) Then Return SetError(1, 1, False)
	$__iLineNumber=1672 & ' - Local $hPath = $aResult[2]•./Include/_MyFunction.au3'
	Local $hPath = $aResult[2]

	$__iLineNumber=1674 & ' - Local $iW = _GDIPlus_ImageGetWidth($hImage)•./Include/_MyFunction.au3'
	Local $iW = _GDIPlus_ImageGetWidth($hImage)
	$__iLineNumber=1675 & ' - Local $iH = _GDIPlus_ImageGetHeight($hImage)•./Include/_MyFunction.au3'
	Local $iH = _GDIPlus_ImageGetHeight($hImage)

	$__iLineNumber=1677 & ' - If $fPrecision <= 0 Then $fPrecision = 0.01•./Include/_MyFunction.au3'
	If $fPrecision <= 0 Then $fPrecision = 0.01
	$__iLineNumber=1678 & ' - If $fPrecision > 1 Then $fPrecision = 1•./Include/_MyFunction.au3'
	If $fPrecision > 1 Then $fPrecision = 1

	$__iLineNumber=1680 & ' - Local $iTX = Ceiling($iW * $fPrecision)•./Include/_MyFunction.au3'
	Local $iTX = Ceiling($iW * $fPrecision)
	$__iLineNumber=1681 & ' - Local $iTY = Ceiling($iH * $fPrecision)•./Include/_MyFunction.au3'
	Local $iTY = Ceiling($iH * $fPrecision)
	$__iLineNumber=1682 & ' - Local $iCnt = ($iTX + 1) * ($iTY + 1)•./Include/_MyFunction.au3'
	Local $iCnt = ($iTX + 1) * ($iTY + 1)
	$__iLineNumber=1683 & ' - Local $x, $Y•./Include/_MyFunction.au3'
	Local $x, $Y

	$__iLineNumber=1685 & ' - Local $tPoints = DllStructCreate("float[" & $iCnt * 2 & "]")•./Include/_MyFunction.au3'
	Local $tPoints = DllStructCreate("float[" & $iCnt * 2 & "]")
	$__iLineNumber=1686 & ' - Local $I•./Include/_MyFunction.au3'
	Local $I
	$__iLineNumber=1687 & ' - For $Y = 0 To $iTY•./Include/_MyFunction.au3'
	For $Y = 0 To $iTY
		$__iLineNumber=1688 & ' - For $x = 0 To $iTX•./Include/_MyFunction.au3'
		For $x = 0 To $iTX
			$__iLineNumber=1689 & ' - $I = ($Y * ($iTX + 1) + $x) * 2•./Include/_MyFunction.au3'
			$I = ($Y * ($iTX + 1) + $x) * 2
			$__iLineNumber=1690 & ' - DllStructSetData($tPoints, 1, $x * $iW / $iTX, $I + 1)•./Include/_MyFunction.au3'
			DllStructSetData($tPoints, 1, $x * $iW / $iTX, $I + 1)
			$__iLineNumber=1691 & ' - DllStructSetData($tPoints, 1, $Y * $iH / $iTY, $I + 2)•./Include/_MyFunction.au3'
			DllStructSetData($tPoints, 1, $Y * $iH / $iTY, $I + 2)
		Next
	Next

	$__iLineNumber=1695 & ' - $aResult = DllCall($__g_hGDIPDll, "uint", "GdipAddPathPolygo ...•./Include/_MyFunction.au3'
	$aResult = DllCall($__g_hGDIPDll, "uint", "GdipAddPathPolygon", "hwnd", $hPath, "ptr", DllStructGetPtr($tPoints), "int", $iCnt)
	$__iLineNumber=1696 & ' - If @error Or Not IsArray($aResult) Then Return SetError(1, 2 ...•./Include/_MyFunction.au3'
	If @error Or Not IsArray($aResult) Then Return SetError(1, 2, False)

	$__iLineNumber=1698 & ' - Local $tWarp = DllStructCreate("float[8]")•./Include/_MyFunction.au3'
	Local $tWarp = DllStructCreate("float[8]")
	$__iLineNumber=1699 & ' - DllStructSetData($tWarp, 1, $X1, 1)•./Include/_MyFunction.au3'
	DllStructSetData($tWarp, 1, $X1, 1)
	$__iLineNumber=1700 & ' - DllStructSetData($tWarp, 1, $Y1, 2)•./Include/_MyFunction.au3'
	DllStructSetData($tWarp, 1, $Y1, 2)
	$__iLineNumber=1701 & ' - DllStructSetData($tWarp, 1, $X2, 3)•./Include/_MyFunction.au3'
	DllStructSetData($tWarp, 1, $X2, 3)
	$__iLineNumber=1702 & ' - DllStructSetData($tWarp, 1, $Y2, 4)•./Include/_MyFunction.au3'
	DllStructSetData($tWarp, 1, $Y2, 4)
	$__iLineNumber=1703 & ' - DllStructSetData($tWarp, 1, $X3, 5)•./Include/_MyFunction.au3'
	DllStructSetData($tWarp, 1, $X3, 5)
	$__iLineNumber=1704 & ' - DllStructSetData($tWarp, 1, $Y3, 6)•./Include/_MyFunction.au3'
	DllStructSetData($tWarp, 1, $Y3, 6)
	$__iLineNumber=1705 & ' - DllStructSetData($tWarp, 1, $X4, 7)•./Include/_MyFunction.au3'
	DllStructSetData($tWarp, 1, $X4, 7)
	$__iLineNumber=1706 & ' - DllStructSetData($tWarp, 1, $Y4, 8)•./Include/_MyFunction.au3'
	DllStructSetData($tWarp, 1, $Y4, 8)

	$__iLineNumber=1708 & ' - $aResult = DllCall($__g_hGDIPDll, "uint", "GdipWarpPath", "h ...•./Include/_MyFunction.au3'
	$aResult = DllCall($__g_hGDIPDll, "uint", "GdipWarpPath", "hwnd", $hPath, "hwnd", 0, "ptr", DllStructGetPtr($tWarp), "int", 4, "float", 0, "float", 0, "float", $iW, "float", $iH, "int", 0, "float", 0)
	$__iLineNumber=1709 & ' - If @error Or Not IsArray($aResult) Then Return SetError(1, 3 ...•./Include/_MyFunction.au3'
	If @error Or Not IsArray($aResult) Then Return SetError(1, 3, False)

	$__iLineNumber=1711 & ' - $aResult = DllCall($__g_hGDIPDll, "uint", "GdipGetPathPoints ...•./Include/_MyFunction.au3'
	$aResult = DllCall($__g_hGDIPDll, "uint", "GdipGetPathPoints", "hwnd", $hPath, "ptr", DllStructGetPtr($tPoints), "int", $iCnt)
	$__iLineNumber=1712 & ' - If @error Or Not IsArray($aResult) Then Return SetError(1, 4 ...•./Include/_MyFunction.au3'
	If @error Or Not IsArray($aResult) Then Return SetError(1, 4, False)

	$__iLineNumber=1714 & ' - Local $tRectF = DllStructCreate("float X;float Y;float Width ...•./Include/_MyFunction.au3'
	Local $tRectF = DllStructCreate("float X;float Y;float Width;float Height")
	$__iLineNumber=1715 & ' - $aResult = DllCall($__g_hGDIPDll, "uint", "GdipGetPathWorldB ...•./Include/_MyFunction.au3'
	$aResult = DllCall($__g_hGDIPDll, "uint", "GdipGetPathWorldBounds", "hwnd", $hPath, "ptr", DllStructGetPtr($tRectF), "hwnd", 0, "hwnd", 0)
	$__iLineNumber=1716 & ' - If @error Or Not IsArray($aResult) Then Return SetError(1, 5 ...•./Include/_MyFunction.au3'
	If @error Or Not IsArray($aResult) Then Return SetError(1, 5, False)

	$__iLineNumber=1718 & ' - DllCall($__g_hGDIPDll, "uint", "GdipDeletePath", "hwnd", $hP ...•./Include/_MyFunction.au3'
	DllCall($__g_hGDIPDll, "uint", "GdipDeletePath", "hwnd", $hPath)

	$__iLineNumber=1720 & ' - Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics(DllStruct ...•./Include/_MyFunction.au3'
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics(DllStructGetData($tRectF, 1) + DllStructGetData($tRectF, 3), DllStructGetData($tRectF, 2) + DllStructGetData($tRectF, 4), $hGraphics)
	$__iLineNumber=1721 & ' - Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)•./Include/_MyFunction.au3'
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)

	$__iLineNumber=1723 & ' - Local $tDraw = DllStructCreate("float[6]")•./Include/_MyFunction.au3'
	Local $tDraw = DllStructCreate("float[6]")
	$__iLineNumber=1724 & ' - Local $pDraw = DllStructGetPtr($tDraw)•./Include/_MyFunction.au3'
	Local $pDraw = DllStructGetPtr($tDraw)
	$__iLineNumber=1725 & ' - Local $W = $iW / $iTX•./Include/_MyFunction.au3'
	Local $W = $iW / $iTX
	$__iLineNumber=1726 & ' - Local $H = $iH / $iTY•./Include/_MyFunction.au3'
	Local $H = $iH / $iTY
	$__iLineNumber=1727 & ' - Local $iO = ($iTX + 1) * 2•./Include/_MyFunction.au3'
	Local $iO = ($iTX + 1) * 2
	$__iLineNumber=1728 & ' - Local $fX1, $fY1, $fX2, $fY2, $fX3, $fY3, $fSX, $fSY•./Include/_MyFunction.au3'
	Local $fX1, $fY1, $fX2, $fY2, $fX3, $fY3, $fSX, $fSY

	$__iLineNumber=1730 & ' - For $Y = 0 To $iTY - 1•./Include/_MyFunction.au3'
	For $Y = 0 To $iTY - 1
		$__iLineNumber=1731 & ' - For $x = 0 To $iTX - 1•./Include/_MyFunction.au3'
		For $x = 0 To $iTX - 1
			$__iLineNumber=1732 & ' - $I = ($Y * ($iTX + 1) + $x) * 2•./Include/_MyFunction.au3'
			$I = ($Y * ($iTX + 1) + $x) * 2
			$__iLineNumber=1733 & ' - $fX1 = DllStructGetData($tPoints, 1, $I + 1)•./Include/_MyFunction.au3'
			$fX1 = DllStructGetData($tPoints, 1, $I + 1)
			$__iLineNumber=1734 & ' - $fY1 = DllStructGetData($tPoints, 1, $I + 2)•./Include/_MyFunction.au3'
			$fY1 = DllStructGetData($tPoints, 1, $I + 2)

			$__iLineNumber=1736 & ' - Switch $x•./Include/_MyFunction.au3'
			$__iLineNumber=1737 & ' - Case $iTX - 1•./Include/_MyFunction.au3'
			Switch $x
				Case $iTX - 1
					$__iLineNumber=1738 & ' - $fX2 = DllStructGetData($tPoints, 1, $I + 3)•./Include/_MyFunction.au3'
					$fX2 = DllStructGetData($tPoints, 1, $I + 3)
					$__iLineNumber=1739 & ' - $fY2 = DllStructGetData($tPoints, 1, $I + 4)•./Include/_MyFunction.au3'
					$fY2 = DllStructGetData($tPoints, 1, $I + 4)
					$__iLineNumber=1740 & ' - $fSX = 1•./Include/_MyFunction.au3'
					$fSX = 1
				Case Else
					$__iLineNumber=1742 & ' - $fX2 = DllStructGetData($tPoints, 1, $I + 5)•./Include/_MyFunction.au3'
					$fX2 = DllStructGetData($tPoints, 1, $I + 5)
					$__iLineNumber=1743 & ' - $fY2 = DllStructGetData($tPoints, 1, $I + 6)•./Include/_MyFunction.au3'
					$fY2 = DllStructGetData($tPoints, 1, $I + 6)
					$__iLineNumber=1744 & ' - $fSX = 2•./Include/_MyFunction.au3'
					$fSX = 2
			EndSwitch

			$__iLineNumber=1747 & ' - Switch $Y•./Include/_MyFunction.au3'
			$__iLineNumber=1748 & ' - Case $iTY - 1•./Include/_MyFunction.au3'
			Switch $Y
				Case $iTY - 1
					$__iLineNumber=1749 & ' - $fX3 = DllStructGetData($tPoints, 1, $I + 1 + $iO)•./Include/_MyFunction.au3'
					$fX3 = DllStructGetData($tPoints, 1, $I + 1 + $iO)
					$__iLineNumber=1750 & ' - $fY3 = DllStructGetData($tPoints, 1, $I + 2 + $iO)•./Include/_MyFunction.au3'
					$fY3 = DllStructGetData($tPoints, 1, $I + 2 + $iO)
					$__iLineNumber=1751 & ' - $fSY = 1•./Include/_MyFunction.au3'
					$fSY = 1
				Case Else
					$__iLineNumber=1753 & ' - $fX3 = DllStructGetData($tPoints, 1, $I + 1 + $iO * 2)•./Include/_MyFunction.au3'
					$fX3 = DllStructGetData($tPoints, 1, $I + 1 + $iO * 2)
					$__iLineNumber=1754 & ' - $fY3 = DllStructGetData($tPoints, 1, $I + 2 + $iO * 2)•./Include/_MyFunction.au3'
					$fY3 = DllStructGetData($tPoints, 1, $I + 2 + $iO * 2)
					$__iLineNumber=1755 & ' - $fSY = 2•./Include/_MyFunction.au3'
					$fSY = 2
			EndSwitch

			$__iLineNumber=1758 & ' - DllStructSetData($tDraw, 1, $fX1, 1)•./Include/_MyFunction.au3'
			DllStructSetData($tDraw, 1, $fX1, 1)
			$__iLineNumber=1759 & ' - DllStructSetData($tDraw, 1, $fY1, 2)•./Include/_MyFunction.au3'
			DllStructSetData($tDraw, 1, $fY1, 2)
			$__iLineNumber=1760 & ' - DllStructSetData($tDraw, 1, $fX2, 3)•./Include/_MyFunction.au3'
			DllStructSetData($tDraw, 1, $fX2, 3)
			$__iLineNumber=1761 & ' - DllStructSetData($tDraw, 1, $fY2, 4)•./Include/_MyFunction.au3'
			DllStructSetData($tDraw, 1, $fY2, 4)
			$__iLineNumber=1762 & ' - DllStructSetData($tDraw, 1, $fX3, 5)•./Include/_MyFunction.au3'
			DllStructSetData($tDraw, 1, $fX3, 5)
			$__iLineNumber=1763 & ' - DllStructSetData($tDraw, 1, $fY3, 6)•./Include/_MyFunction.au3'
			DllStructSetData($tDraw, 1, $fY3, 6)

			$__iLineNumber=1765 & ' - DllCall($__g_hGDIPDll, "uint", "GdipDrawImagePointsRect", "h ...•./Include/_MyFunction.au3'
			DllCall($__g_hGDIPDll, "uint", "GdipDrawImagePointsRect", "hwnd", $hContext, "hwnd", $hImage, "ptr", $pDraw, "int", 3, "float", $x * $W, "float", $Y * $H, "float", $W * $fSX, "float", $H * $fSY, "int", 2, "hwnd", 0, "ptr", 0, "ptr", 0)
		Next
	Next

	$__iLineNumber=1769 & ' - _GDIPlus_GraphicsDispose($hContext)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDispose($hContext)
	$__iLineNumber=1770 & ' - _GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)•./Include/_MyFunction.au3'
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)
	$__iLineNumber=1771 & ' - _GDIPlus_BitmapDispose($hBitmap)•./Include/_MyFunction.au3'
	_GDIPlus_BitmapDispose($hBitmap)
EndFunc   ;==>_GDIPlus_GraphicsDrawImage_4Points
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
$__iLineNumber=1790 & ' - Func _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
Func _XML_Open($iXMLPath)
	$__iLineNumber=1791 & ' - Local $oXMLDoc = _XML_CreateDOMDocument()•./Include/_MyFunction.au3'
	Local $oXMLDoc = _XML_CreateDOMDocument()
	$__iLineNumber=1792 & ' - _XML_Load($oXMLDoc, $iXMLPath)•./Include/_MyFunction.au3'
	_XML_Load($oXMLDoc, $iXMLPath)
	$__iLineNumber=1793 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1794 & ' - _LOG("_XML_Load @error:" & @CRLF & XML_My_ErrorParser(@error ...•./Include/_MyFunction.au3'
		_LOG('_XML_Load @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
		$__iLineNumber=1795 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1797 & ' - _XML_TIDY($oXMLDoc)•./Include/_MyFunction.au3'
	_XML_TIDY($oXMLDoc)
	$__iLineNumber=1798 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1799 & ' - _LOG("_XML_TIDY @error:" & @CRLF & XML_My_ErrorParser(@error ...•./Include/_MyFunction.au3'
		_LOG('_XML_TIDY @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
		$__iLineNumber=1800 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
;~ 	_LOG($iXMLPath & " Open", 3, $iLOGPath)
	$__iLineNumber=1803 & ' - Return $oXMLDoc•./Include/_MyFunction.au3'
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
$__iLineNumber=1822 & ' - Func _XML_Read($iXpath, $iXMLType = 0, $iXMLPath = "", $oXML ...•./Include/_MyFunction.au3'
Func _XML_Read($iXpath, $iXMLType = 0, $iXMLPath = "", $oXMLDoc = "")
	$__iLineNumber=1823 & ' - Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeN ...•./Include/_MyFunction.au3'
	Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeName
	$__iLineNumber=1824 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=1825 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1826 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1827 & ' - If $oXMLDoc = -1 Then•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then
			$__iLineNumber=1828 & ' - _LOG("_XML_Open ERROR (" & $iXpath & ")", 2, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG('_XML_Open ERROR (' & $iXpath & ')', 2, $iLOGPath)
			$__iLineNumber=1829 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
		EndIf
	EndIf

	$__iLineNumber=1833 & ' - Switch $iXMLType•./Include/_MyFunction.au3'
	$__iLineNumber=1834 & ' - Case 0•./Include/_MyFunction.au3'
	Switch $iXMLType
		Case 0
			$__iLineNumber=1835 & ' - If _XML_NodeExists($oXMLDoc, $iXpath) <> $XML_RET_SUCCESS Th ...•./Include/_MyFunction.au3'
			If _XML_NodeExists($oXMLDoc, $iXpath) <> $XML_RET_SUCCESS Then
;~ 				_LOG('_XML_NodeExists ERROR (' & $iXpath & " doesn't exist)", 3, $iLOGPath)
				$__iLineNumber=1837 & ' - Return ""•./Include/_MyFunction.au3'
				Return ""
			EndIf
			$__iLineNumber=1839 & ' - $iXMLValue = _XML_GetValue($oXMLDoc, $iXpath)•./Include/_MyFunction.au3'
			$iXMLValue = _XML_GetValue($oXMLDoc, $iXpath)
			$__iLineNumber=1840 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1841 & ' - If @error = 21 Then Return ""•./Include/_MyFunction.au3'
				If @error = 21 Then Return ""
				$__iLineNumber=1842 & ' - _LOG("_XML_GetValue ERROR (" & $iXpath & ")", 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG('_XML_GetValue ERROR (' & $iXpath & ')', 2, $iLOGPath)
				$__iLineNumber=1843 & ' - _LOG("_XML_GetValue @error(" & @error & ") :" & @CRLF & XML_ ...•./Include/_MyFunction.au3'
				_LOG('_XML_GetValue @error(' & @error & ') :' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
				$__iLineNumber=1844 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1846 & ' - If IsArray($iXMLValue) And UBound($iXMLValue) - 1 > 0 Then•./Include/_MyFunction.au3'
			If IsArray($iXMLValue) And UBound($iXMLValue) - 1 > 0 Then
				$__iLineNumber=1847 & ' - _LOG("...Value..._XML_GetValue (" & $iXpath & ") = " & $iXML ...•./Include/_MyFunction.au3'
				_LOG('...Value..._XML_GetValue (' & $iXpath & ') = ' & $iXMLValue[1], 3, $iLOGPath)
				$__iLineNumber=1848 & ' - Return $iXMLValue[1]•./Include/_MyFunction.au3'
				Return $iXMLValue[1]
			Else
				$__iLineNumber=1850 & ' - _LOG("_XML_GetValue (" & $iXpath & ") is not an Array", 2, $ ...•./Include/_MyFunction.au3'
				_LOG('_XML_GetValue (' & $iXpath & ') is not an Array', 2, $iLOGPath)
				$__iLineNumber=1851 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
		$__iLineNumber=1853 & ' - Case 1•./Include/_MyFunction.au3'
		Case 1
			$__iLineNumber=1854 & ' - $iXpathSplit = StringSplit($iXpath, "/")•./Include/_MyFunction.au3'
			$iXpathSplit = StringSplit($iXpath, "/")
			$__iLineNumber=1855 & ' - $iXMLAttributeName = $iXpathSplit[UBound($iXpathSplit) - 1]•./Include/_MyFunction.au3'
			$iXMLAttributeName = $iXpathSplit[UBound($iXpathSplit) - 1]
			$__iLineNumber=1856 & ' - $iXpath = StringTrimRight($iXpath, StringLen($iXMLAttributeN ...•./Include/_MyFunction.au3'
			$iXpath = StringTrimRight($iXpath, StringLen($iXMLAttributeName) + 1)
			$__iLineNumber=1857 & ' - $oNode = _XML_SelectSingleNode($oXMLDoc, $iXpath)•./Include/_MyFunction.au3'
			$oNode = _XML_SelectSingleNode($oXMLDoc, $iXpath)
			$__iLineNumber=1858 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1859 & ' - _LOG("_XML_SelectSingleNode ERROR (" & $iXpath & ")", 2, $iL ...•./Include/_MyFunction.au3'
				_LOG('_XML_SelectSingleNode ERROR (' & $iXpath & ')', 2, $iLOGPath)
				$__iLineNumber=1860 & ' - _LOG("_XML_SelectSingleNode @error:" & @CRLF & XML_My_ErrorP ...•./Include/_MyFunction.au3'
				_LOG('_XML_SelectSingleNode @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
				$__iLineNumber=1861 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1863 & ' - $iXMLValue = _XML_GetNodeAttributeValue($oNode, $iXMLAttribu ...•./Include/_MyFunction.au3'
			$iXMLValue = _XML_GetNodeAttributeValue($oNode, $iXMLAttributeName)
			$__iLineNumber=1864 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1865 & ' - _LOG("_XML_GetNodeAttributeValue ERROR (" & $iXpath & ")", 2 ...•./Include/_MyFunction.au3'
				_LOG('_XML_GetNodeAttributeValue ERROR (' & $iXpath & ')', 2, $iLOGPath)
				$__iLineNumber=1866 & ' - _LOG("_XML_GetNodeAttributeValue @error:" & @CRLF & XML_My_E ...•./Include/_MyFunction.au3'
				_LOG('_XML_GetNodeAttributeValue @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
				$__iLineNumber=1867 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1869 & ' - _LOG("...Attribut..._XML_GetValue (" & $iXpath & ") = " & $i ...•./Include/_MyFunction.au3'
			_LOG('...Attribut..._XML_GetValue (' & $iXpath & ') = ' & $iXMLValue, 3, $iLOGPath)
			$__iLineNumber=1870 & ' - Return $iXMLValue•./Include/_MyFunction.au3'
			Return $iXMLValue
		Case Else
			$__iLineNumber=1872 & ' - Return -2•./Include/_MyFunction.au3'
			Return -2
	EndSwitch

	$__iLineNumber=1875 & ' - Return -1•./Include/_MyFunction.au3'
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
$__iLineNumber=1895 & ' - Func _XML_Replace($iXpath, $iValue = " ", $iXMLType = 0, $iX ...•./Include/_MyFunction.au3'
Func _XML_Replace($iXpath, $iValue = " ", $iXMLType = 0, $iXMLPath = "", $oXMLDoc = "")
	$__iLineNumber=1896 & ' - Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeN ...•./Include/_MyFunction.au3'
	Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeName
	$__iLineNumber=1897 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then
		$__iLineNumber=1898 & ' - _LOG("_XML_Replace Error : Need an Handle or Path", 2, $iLOG ...•./Include/_MyFunction.au3'
		_LOG('_XML_Replace Error : Need an Handle or Path', 2, $iLOGPath)
		$__iLineNumber=1899 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1901 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1902 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1903 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=1906 & ' - Switch $iXMLType•./Include/_MyFunction.au3'
	$__iLineNumber=1907 & ' - Case 0•./Include/_MyFunction.au3'
	Switch $iXMLType
		Case 0
			$__iLineNumber=1908 & ' - $iXMLValue = _XML_UpdateField($oXMLDoc, $iXpath, $iValue)•./Include/_MyFunction.au3'
			$iXMLValue = _XML_UpdateField($oXMLDoc, $iXpath, $iValue)
			$__iLineNumber=1909 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1910 & ' - _LOG("_XML_UpdateField @error:" & @CRLF & XML_My_ErrorParser ...•./Include/_MyFunction.au3'
				_LOG('_XML_UpdateField @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
				$__iLineNumber=1911 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1913 & ' - _XML_TIDY($oXMLDoc)•./Include/_MyFunction.au3'
			_XML_TIDY($oXMLDoc)
			$__iLineNumber=1914 & ' - _LOG("_XML_UpdateField (" & $iXpath & ") = " & $iValue, 1, $ ...•./Include/_MyFunction.au3'
			_LOG('_XML_UpdateField (' & $iXpath & ') = ' & $iValue, 1, $iLOGPath)
			$__iLineNumber=1915 & ' - Return 1•./Include/_MyFunction.au3'
			Return 1
		$__iLineNumber=1916 & ' - Case 1•./Include/_MyFunction.au3'
		Case 1
			$__iLineNumber=1917 & ' - $iXpathSplit = StringSplit($iXpath, "/")•./Include/_MyFunction.au3'
			$iXpathSplit = StringSplit($iXpath, "/")
			$__iLineNumber=1918 & ' - $iXMLAttributeName = $iXpathSplit[UBound($iXpathSplit) - 1]•./Include/_MyFunction.au3'
			$iXMLAttributeName = $iXpathSplit[UBound($iXpathSplit) - 1]
			$__iLineNumber=1919 & ' - $iXpath = StringTrimRight($iXpath, StringLen($iXMLAttributeN ...•./Include/_MyFunction.au3'
			$iXpath = StringTrimRight($iXpath, StringLen($iXMLAttributeName) + 1)
			$__iLineNumber=1920 & ' - _XML_SetAttrib($oXMLDoc, $iXpath, $iXMLAttributeName, $iValu ...•./Include/_MyFunction.au3'
			_XML_SetAttrib($oXMLDoc, $iXpath, $iXMLAttributeName, $iValue)
			$__iLineNumber=1921 & ' - If @error Then•./Include/_MyFunction.au3'
			If @error Then
				$__iLineNumber=1922 & ' - _LOG("_XML_SelectSingleNode @error:" & @CRLF & XML_My_ErrorP ...•./Include/_MyFunction.au3'
				_LOG('_XML_SelectSingleNode @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
				$__iLineNumber=1923 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			EndIf
			$__iLineNumber=1925 & ' - _XML_TIDY($oXMLDoc)•./Include/_MyFunction.au3'
			_XML_TIDY($oXMLDoc)
			$__iLineNumber=1926 & ' - _LOG("_XML_UpdateField (" & $iXpath & ") = " & $iValue, 1, $ ...•./Include/_MyFunction.au3'
			_LOG('_XML_UpdateField (' & $iXpath & ') = ' & $iValue, 1, $iLOGPath)
			$__iLineNumber=1927 & ' - Return 1•./Include/_MyFunction.au3'
			Return 1
		Case Else
			$__iLineNumber=1929 & ' - _LOG("_XML_Replace : $iXMLType Unknown", 2, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG('_XML_Replace : $iXMLType Unknown', 2, $iLOGPath)
			$__iLineNumber=1930 & ' - Return -1•./Include/_MyFunction.au3'
			Return -1
	EndSwitch

	$__iLineNumber=1933 & ' - Return -1•./Include/_MyFunction.au3'
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
$__iLineNumber=1951 & ' - Func _XML_ListValue($iXpath, $iXMLPath = "", $oXMLDoc = "")•./Include/_MyFunction.au3'
Func _XML_ListValue($iXpath, $iXMLPath = "", $oXMLDoc = "")
	$__iLineNumber=1952 & ' - Local $iXMLValue = -1•./Include/_MyFunction.au3'
	Local $iXMLValue = -1
	$__iLineNumber=1953 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=1954 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1955 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1956 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=1959 & ' - $iXMLValue = _XML_GetValue($oXMLDoc, $iXpath)•./Include/_MyFunction.au3'
	$iXMLValue = _XML_GetValue($oXMLDoc, $iXpath)
	$__iLineNumber=1960 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=1961 & ' - _LOG("_XML_GetValue ERROR (" & $iXpath & ")", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG('_XML_GetValue ERROR (' & $iXpath & ')', 2, $iLOGPath)
		$__iLineNumber=1962 & ' - _LOG("_XML_GetValue @error:" & @CRLF & XML_My_ErrorParser(@e ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetValue @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
		$__iLineNumber=1963 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=1965 & ' - If IsArray($iXMLValue) Then•./Include/_MyFunction.au3'
	If IsArray($iXMLValue) Then
		$__iLineNumber=1966 & ' - Return $iXMLValue•./Include/_MyFunction.au3'
		Return $iXMLValue
	Else
		$__iLineNumber=1968 & ' - _LOG("_XML_GetValue (" & $iXpath & ") is not an Array", 2, $ ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetValue (' & $iXpath & ') is not an Array', 2, $iLOGPath)
		$__iLineNumber=1969 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf

	$__iLineNumber=1972 & ' - Return -1•./Include/_MyFunction.au3'
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
$__iLineNumber=1990 & ' - Func _XML_ListNode($iXpath, $iXMLPath = "", $oXMLDoc = "")•./Include/_MyFunction.au3'
Func _XML_ListNode($iXpath, $iXMLPath = "", $oXMLDoc = "")
	$__iLineNumber=1991 & ' - Local $iXMLValue = -1•./Include/_MyFunction.au3'
	Local $iXMLValue = -1
	$__iLineNumber=1992 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=1993 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=1994 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=1995 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=1998 & ' - $iXMLValue = _XML_GetChildren($oXMLDoc, $iXpath)•./Include/_MyFunction.au3'
	$iXMLValue = _XML_GetChildren($oXMLDoc, $iXpath)
	$__iLineNumber=1999 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=2000 & ' - _LOG("_XML_GetChildNodes ERROR (" & $iXpath & ")", 2, $iLOGP ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetChildNodes ERROR (' & $iXpath & ')', 2, $iLOGPath)
		$__iLineNumber=2001 & ' - _LOG("_XML_GetChildNodes @error:" & @CRLF & XML_My_ErrorPars ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetChildNodes @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
		$__iLineNumber=2002 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=2004 & ' - If IsArray($iXMLValue) Then•./Include/_MyFunction.au3'
	If IsArray($iXMLValue) Then
		$__iLineNumber=2005 & ' - Return $iXMLValue•./Include/_MyFunction.au3'
		Return $iXMLValue
	Else
		$__iLineNumber=2007 & ' - _LOG("_XML_GetValue (" & $iXpath & ") is not an Array", 2, $ ...•./Include/_MyFunction.au3'
		_LOG('_XML_GetValue (' & $iXpath & ') is not an Array', 2, $iLOGPath)
		$__iLineNumber=2008 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=2010 & ' - Return -1•./Include/_MyFunction.au3'
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
$__iLineNumber=2028 & ' - Func _XML_Make($iXMLPath, $iRoot, $iUTF8 = True)•./Include/_MyFunction.au3'
Func _XML_Make($iXMLPath, $iRoot, $iUTF8 = True)
	$__iLineNumber=2029 & ' - FileDelete($iXMLPath)•./Include/_MyFunction.au3'
	FileDelete($iXMLPath)
	$__iLineNumber=2030 & ' - Local $oXMLDoc = _XML_CreateFile($iXMLPath, $iRoot, $iUTF8)•./Include/_MyFunction.au3'
	Local $oXMLDoc = _XML_CreateFile($iXMLPath, $iRoot, $iUTF8)
	$__iLineNumber=2031 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=2032 & ' - _LOG("_XML_CreateFile @error:" & @CRLF & XML_My_ErrorParser( ...•./Include/_MyFunction.au3'
		_LOG('_XML_CreateFile @error:' & @CRLF & XML_My_ErrorParser(@error), 2, $iLOGPath)
		$__iLineNumber=2033 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=2035 & ' - Return $oXMLDoc•./Include/_MyFunction.au3'
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
$__iLineNumber=2054 & ' - Func _XML_WriteValue($iXpath, $iValue = "", $iXMLPath = "",  ...•./Include/_MyFunction.au3'
Func _XML_WriteValue($iXpath, $iValue = "", $iXMLPath = "", $oXMLDoc = "", $ipos = "last()")
	$__iLineNumber=2055 & ' - Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeN ...•./Include/_MyFunction.au3'
	Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeName
	$__iLineNumber=2056 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=2057 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=2058 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=2059 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=2062 & ' - $iXpathSplit = StringSplit($iXpath, "/")•./Include/_MyFunction.au3'
	$iXpathSplit = StringSplit($iXpath, "/")
	$__iLineNumber=2063 & ' - $iXMLChildName = $iXpathSplit[UBound($iXpathSplit) - 1]•./Include/_MyFunction.au3'
	$iXMLChildName = $iXpathSplit[UBound($iXpathSplit) - 1]
	$__iLineNumber=2064 & ' - $iXpath = StringTrimRight($iXpath, StringLen($iXMLChildName) ...•./Include/_MyFunction.au3'
	$iXpath = StringTrimRight($iXpath, StringLen($iXMLChildName) + 1)
	$__iLineNumber=2065 & ' - _XML_CreateChildWAttr($oXMLDoc, $iXpath & "[" & $ipos & "]", ...•./Include/_MyFunction.au3'
	_XML_CreateChildWAttr($oXMLDoc, $iXpath & "[" & $ipos & "]", $iXMLChildName, Default, $iValue)
	$__iLineNumber=2066 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=2067 & ' - _LOG("_XML_CreateChildWAttr ERROR (" & $iXpath & ")", 2, $iL ...•./Include/_MyFunction.au3'
		_LOG('_XML_CreateChildWAttr ERROR (' & $iXpath & ')', 2, $iLOGPath)
		$__iLineNumber=2068 & ' - _LOG("_XML_CreateChildWAttr @error:" & @CRLF & XML_My_ErrorP ...•./Include/_MyFunction.au3'
		_LOG('_XML_CreateChildWAttr @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
		$__iLineNumber=2069 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=2071 & ' - Return 1•./Include/_MyFunction.au3'
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
$__iLineNumber=2091 & ' - Func _XML_WriteAttributs($iXpath, $iAttribute, $iValue = "", ...•./Include/_MyFunction.au3'
Func _XML_WriteAttributs($iXpath, $iAttribute, $iValue = "", $iXMLPath = "", $oXMLDoc = "", $ipos = "last()")
	$__iLineNumber=2092 & ' - Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeN ...•./Include/_MyFunction.au3'
	Local $iXMLValue = -1, $oNode, $iXpathSplit, $iXMLAttributeName
	$__iLineNumber=2093 & ' - If $iXMLPath = "" And $oXMLDoc = "" Then Return -1•./Include/_MyFunction.au3'
	If $iXMLPath = "" And $oXMLDoc = "" Then Return -1
	$__iLineNumber=2094 & ' - If $iXMLPath <> "" Then•./Include/_MyFunction.au3'
	If $iXMLPath <> "" Then
		$__iLineNumber=2095 & ' - $oXMLDoc = _XML_Open($iXMLPath)•./Include/_MyFunction.au3'
		$oXMLDoc = _XML_Open($iXMLPath)
		$__iLineNumber=2096 & ' - If $oXMLDoc = -1 Then Return -1•./Include/_MyFunction.au3'
		If $oXMLDoc = -1 Then Return -1
	EndIf

	$__iLineNumber=2099 & ' - _XML_SetAttrib($oXMLDoc, $iXpath & "[" & $ipos & "]", $iAttr ...•./Include/_MyFunction.au3'
	_XML_SetAttrib($oXMLDoc, $iXpath & "[" & $ipos & "]", $iAttribute, $iValue)
	$__iLineNumber=2100 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=2101 & ' - _LOG("_XML_SetAttrib ERROR (" & $iXpath & ")", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG('_XML_SetAttrib ERROR (' & $iXpath & ')', 2, $iLOGPath)
		$__iLineNumber=2102 & ' - _LOG("_XML_SetAttrib @error:" & @CRLF & XML_My_ErrorParser(@ ...•./Include/_MyFunction.au3'
		_LOG('_XML_SetAttrib @error:' & @CRLF & XML_My_ErrorParser(@error), 3, $iLOGPath)
		$__iLineNumber=2103 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=2105 & ' - Return 1•./Include/_MyFunction.au3'
	Return 1
EndFunc   ;==>_XML_WriteAttributs

#EndRegion XML Function

#Region XML DOM Error/Event Handling
; This COM Error Hanlder will be used globally (excepting inside UDF Functions)
$__iLineNumber=2112 & ' - Global $oErrorHandler = ObjEvent("AutoIt.Error", ErrFunc_Cus ...•./Include/_MyFunction.au3'
Global $oErrorHandler = ObjEvent("AutoIt.Error", ErrFunc_CustomUserHandler_MAIN)
#forceref $oErrorHandler

; This is SetUp for the transfer UDF internal COM Error Handler to the user function
$__iLineNumber=2116 & ' - _XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_ ...•./Include/_MyFunction.au3'
_XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_XML)

$__iLineNumber=2118 & ' - Func ErrFunc_CustomUserHandler_MAIN($oError)•./Include/_MyFunction.au3'
Func ErrFunc_CustomUserHandler_MAIN($oError)
	$__iLineNumber=2119 & ' - ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") :  ...•./Include/_MyFunction.au3'
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

$__iLineNumber=2131 & ' - Func ErrFunc_CustomUserHandler_XML($oError)•./Include/_MyFunction.au3'
Func ErrFunc_CustomUserHandler_XML($oError)
	; here is declared another path to UDF au3 file
	; thanks to this with using _XML_ComErrorHandler_UserFunction(ErrFunc_CustomUserHandler_XML)
	;  you get errors which after pressing F4 in SciTE4AutoIt you goes directly to the specified UDF Error Line
	$__iLineNumber=2135 & ' - ConsoleWrite("XMLWrapperEx" & " (" & $oError.scriptline & ") ...•./Include/_MyFunction.au3'
	ConsoleWrite('XMLWrapperEx' & " (" & $oError.scriptline & ") : UDF ==> COM Error intercepted ! " & @CRLF & _
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

$__iLineNumber=2147 & ' - Func XML_DOM_EVENT_ondataavailable()•./Include/_MyFunction.au3'
Func XML_DOM_EVENT_ondataavailable()
	#CS
		$__iLineNumber=2149 & ' - ondataavailable Event•./Include/_MyFunction.au3'
		ondataavailable Event
		$__iLineNumber=2150 & ' - https://msdn.microsoft.com/en-us/library/ms754530(v=vs.85).a ...•./Include/_MyFunction.au3'
		https://msdn.microsoft.com/en-us/library/ms754530(v=vs.85).aspx
	#CE
	$__iLineNumber=2152 & ' - Local $oEventObj = @COM_EventObj•./Include/_MyFunction.au3'
	Local $oEventObj = @COM_EventObj
	$__iLineNumber=2153 & ' - ConsoleWrite("@COM_EventObj = " & ObjName($oEventObj, 3) & @ ...•./Include/_MyFunction.au3'
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	$__iLineNumber=2155 & ' - Local $sMessage = "XML_DOM_EVENT_ fired "ondataavailable"" & ...•./Include/_MyFunction.au3'
	Local $sMessage = 'XML_DOM_EVENT_ fired "ondataavailable"' & @CRLF
	$__iLineNumber=2156 & ' - ConsoleWrite($sMessage)•./Include/_MyFunction.au3'
	ConsoleWrite($sMessage)
EndFunc   ;==>XML_DOM_EVENT_ondataavailable

$__iLineNumber=2159 & ' - Func XML_DOM_EVENT_onreadystatechange()•./Include/_MyFunction.au3'
Func XML_DOM_EVENT_onreadystatechange()
	#CS
		$__iLineNumber=2161 & ' - onreadystatechange Event•./Include/_MyFunction.au3'
		onreadystatechange Event
		$__iLineNumber=2162 & ' - https://msdn.microsoft.com/en-us/library/ms759186(v=vs.85).a ...•./Include/_MyFunction.au3'
		https://msdn.microsoft.com/en-us/library/ms759186(v=vs.85).aspx
	#CE
	$__iLineNumber=2164 & ' - Local $oEventObj = @COM_EventObj•./Include/_MyFunction.au3'
	Local $oEventObj = @COM_EventObj
	$__iLineNumber=2165 & ' - ConsoleWrite("@COM_EventObj = " & ObjName($oEventObj, 3) & @ ...•./Include/_MyFunction.au3'
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	$__iLineNumber=2167 & ' - Local $sMessage = "XML_DOM_EVENT_ fired "onreadystatechange" ...•./Include/_MyFunction.au3'
	Local $sMessage = 'XML_DOM_EVENT_ fired "onreadystatechange" : ReadyState = ' & $oEventObj.ReadyState & @CRLF
	$__iLineNumber=2168 & ' - ConsoleWrite($sMessage)•./Include/_MyFunction.au3'
	ConsoleWrite($sMessage)

EndFunc   ;==>XML_DOM_EVENT_onreadystatechange

$__iLineNumber=2172 & ' - Func XML_DOM_EVENT_ontransformnode($oNodeCode_XSL, $oNodeDat ...•./Include/_MyFunction.au3'
Func XML_DOM_EVENT_ontransformnode($oNodeCode_XSL, $oNodeData_XML, $bBool)
	#forceref $oNodeCode_XSL, $oNodeData_XML, $bBool
	#CS
		$__iLineNumber=2175 & ' - ontransformnode Event•./Include/_MyFunction.au3'
		ontransformnode Event
		$__iLineNumber=2176 & ' - https://msdn.microsoft.com/en-us/library/ms767521(v=vs.85).a ...•./Include/_MyFunction.au3'
		https://msdn.microsoft.com/en-us/library/ms767521(v=vs.85).aspx
	#CE
	$__iLineNumber=2178 & ' - Local $oEventObj = @COM_EventObj•./Include/_MyFunction.au3'
	Local $oEventObj = @COM_EventObj
	$__iLineNumber=2179 & ' - ConsoleWrite("@COM_EventObj = " & ObjName($oEventObj, 3) & @ ...•./Include/_MyFunction.au3'
	ConsoleWrite('@COM_EventObj = ' & ObjName($oEventObj, 3) & @CRLF)

	$__iLineNumber=2181 & ' - Local $sMessage = "XML_DOM_EVENT_ fired "ontransformnode"" & ...•./Include/_MyFunction.au3'
	Local $sMessage = 'XML_DOM_EVENT_ fired "ontransformnode"' & @CRLF
	$__iLineNumber=2182 & ' - ConsoleWrite($sMessage)•./Include/_MyFunction.au3'
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
$__iLineNumber=2200 & ' - Func XML_My_ErrorParser($iXMLWrapper_Error, $iXMLWrapper_Ext ...•./Include/_MyFunction.au3'
Func XML_My_ErrorParser($iXMLWrapper_Error, $iXMLWrapper_Extended = 0)
	$__iLineNumber=2201 & ' - Local $sErrorInfo = ""•./Include/_MyFunction.au3'
	Local $sErrorInfo = ''
	$__iLineNumber=2202 & ' - Switch $iXMLWrapper_Error•./Include/_MyFunction.au3'
	$__iLineNumber=2203 & ' - Case $XML_ERR_SUCCESS•./Include/_MyFunction.au3'
	Switch $iXMLWrapper_Error
		Case $XML_ERR_SUCCESS
			$__iLineNumber=2204 & ' - $sErrorInfo = "$XML_ERR_SUCCESS=" & $XML_ERR_SUCCESS & @CRLF ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_SUCCESS=' & $XML_ERR_SUCCESS & @CRLF & 'All is ok.'
		$__iLineNumber=2205 & ' - Case $XML_ERR_GENERAL•./Include/_MyFunction.au3'
		Case $XML_ERR_GENERAL
			$__iLineNumber=2206 & ' - $sErrorInfo = "$XML_ERR_GENERAL=" & $XML_ERR_GENERAL & @CRLF ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_GENERAL=' & $XML_ERR_GENERAL & @CRLF & 'The error which is not specifically defined.'
		$__iLineNumber=2207 & ' - Case $XML_ERR_COMERROR•./Include/_MyFunction.au3'
		Case $XML_ERR_COMERROR
			$__iLineNumber=2208 & ' - $sErrorInfo = "$XML_ERR_COMERROR=" & $XML_ERR_COMERROR & @CR ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_COMERROR=' & $XML_ERR_COMERROR & @CRLF & 'COM ERROR OCCURED. Check @extended and your own error handler function for details.'
		$__iLineNumber=2209 & ' - Case $XML_ERR_ISNOTOBJECT•./Include/_MyFunction.au3'
		Case $XML_ERR_ISNOTOBJECT
			$__iLineNumber=2210 & ' - $sErrorInfo = "$XML_ERR_ISNOTOBJECT=" & $XML_ERR_ISNOTOBJECT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_ISNOTOBJECT=' & $XML_ERR_ISNOTOBJECT & @CRLF & 'No object passed to function'
		$__iLineNumber=2211 & ' - Case $XML_ERR_INVALIDDOMDOC•./Include/_MyFunction.au3'
		Case $XML_ERR_INVALIDDOMDOC
			$__iLineNumber=2212 & ' - $sErrorInfo = "$XML_ERR_INVALIDDOMDOC=" & $XML_ERR_INVALIDDO ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_INVALIDDOMDOC=' & $XML_ERR_INVALIDDOMDOC & @CRLF & 'Invalid object passed to function'
		$__iLineNumber=2213 & ' - Case $XML_ERR_INVALIDATTRIB•./Include/_MyFunction.au3'
		Case $XML_ERR_INVALIDATTRIB
			$__iLineNumber=2214 & ' - $sErrorInfo = "$XML_ERR_INVALIDATTRIB=" & $XML_ERR_INVALIDAT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_INVALIDATTRIB=' & $XML_ERR_INVALIDATTRIB & @CRLF & 'Invalid object passed to function.'
		$__iLineNumber=2215 & ' - Case $XML_ERR_INVALIDNODETYPE•./Include/_MyFunction.au3'
		Case $XML_ERR_INVALIDNODETYPE
			$__iLineNumber=2216 & ' - $sErrorInfo = "$XML_ERR_INVALIDNODETYPE=" & $XML_ERR_INVALID ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_INVALIDNODETYPE=' & $XML_ERR_INVALIDNODETYPE & @CRLF & 'Invalid object passed to function.'
		$__iLineNumber=2217 & ' - Case $XML_ERR_OBJCREATE•./Include/_MyFunction.au3'
		Case $XML_ERR_OBJCREATE
			$__iLineNumber=2218 & ' - $sErrorInfo = "$XML_ERR_OBJCREATE=" & $XML_ERR_OBJCREATE & @ ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_OBJCREATE=' & $XML_ERR_OBJCREATE & @CRLF & 'Object can not be created.'
		$__iLineNumber=2219 & ' - Case $XML_ERR_NODECREATE•./Include/_MyFunction.au3'
		Case $XML_ERR_NODECREATE
			$__iLineNumber=2220 & ' - $sErrorInfo = "$XML_ERR_NODECREATE=" & $XML_ERR_NODECREATE & ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NODECREATE=' & $XML_ERR_NODECREATE & @CRLF & 'Can not create Node - check also COM Error Handler'
		$__iLineNumber=2221 & ' - Case $XML_ERR_NODEAPPEND•./Include/_MyFunction.au3'
		Case $XML_ERR_NODEAPPEND
			$__iLineNumber=2222 & ' - $sErrorInfo = "$XML_ERR_NODEAPPEND=" & $XML_ERR_NODEAPPEND & ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NODEAPPEND=' & $XML_ERR_NODEAPPEND & @CRLF & 'Can not append Node - check also COM Error Handler'
		$__iLineNumber=2223 & ' - Case $XML_ERR_PARSE•./Include/_MyFunction.au3'
		Case $XML_ERR_PARSE
			$__iLineNumber=2224 & ' - $sErrorInfo = "$XML_ERR_PARSE=" & $XML_ERR_PARSE & @CRLF & " ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_PARSE=' & $XML_ERR_PARSE & @CRLF & 'Error: with Parsing objects, .parseError.errorCode=' & $iXMLWrapper_Extended & ' Use _XML_ErrorParser_GetDescription() for get details.'
		$__iLineNumber=2225 & ' - Case $XML_ERR_PARSE_XSL•./Include/_MyFunction.au3'
		Case $XML_ERR_PARSE_XSL
			$__iLineNumber=2226 & ' - $sErrorInfo = "$XML_ERR_PARSE_XSL=" & $XML_ERR_PARSE_XSL & @ ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_PARSE_XSL=' & $XML_ERR_PARSE_XSL & @CRLF & 'Error with Parsing XSL objects .parseError.errorCode=' & $iXMLWrapper_Extended & ' Use _XML_ErrorParser_GetDescription() for get details.'
		$__iLineNumber=2227 & ' - Case $XML_ERR_LOAD•./Include/_MyFunction.au3'
		Case $XML_ERR_LOAD
			$__iLineNumber=2228 & ' - $sErrorInfo = "$XML_ERR_LOAD=" & $XML_ERR_LOAD & @CRLF & "Er ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_LOAD=' & $XML_ERR_LOAD & @CRLF & 'Error opening specified file.'
		$__iLineNumber=2229 & ' - Case $XML_ERR_SAVE•./Include/_MyFunction.au3'
		Case $XML_ERR_SAVE
			$__iLineNumber=2230 & ' - $sErrorInfo = "$XML_ERR_SAVE=" & $XML_ERR_SAVE & @CRLF & "Er ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_SAVE=' & $XML_ERR_SAVE & @CRLF & 'Error saving file.'
		$__iLineNumber=2231 & ' - Case $XML_ERR_PARAMETER•./Include/_MyFunction.au3'
		Case $XML_ERR_PARAMETER
			$__iLineNumber=2232 & ' - $sErrorInfo = "$XML_ERR_PARAMETER=" & $XML_ERR_PARAMETER & @ ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_PARAMETER=' & $XML_ERR_PARAMETER & @CRLF & 'Wrong parameter passed to function.'
		$__iLineNumber=2233 & ' - Case $XML_ERR_ARRAY•./Include/_MyFunction.au3'
		Case $XML_ERR_ARRAY
			$__iLineNumber=2234 & ' - $sErrorInfo = "$XML_ERR_ARRAY=" & $XML_ERR_ARRAY & @CRLF & " ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_ARRAY=' & $XML_ERR_ARRAY & @CRLF & 'Wrong array parameter passed to function. Check array dimension and conent.'
		$__iLineNumber=2235 & ' - Case $XML_ERR_XPATH•./Include/_MyFunction.au3'
		Case $XML_ERR_XPATH
			$__iLineNumber=2236 & ' - $sErrorInfo = "$XML_ERR_XPATH=" & $XML_ERR_XPATH & @CRLF & " ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_XPATH=' & $XML_ERR_XPATH & @CRLF & 'XPath syntax error - check also COM Error Handler.'
		$__iLineNumber=2237 & ' - Case $XML_ERR_NONODESMATCH•./Include/_MyFunction.au3'
		Case $XML_ERR_NONODESMATCH
			$__iLineNumber=2238 & ' - $sErrorInfo = "$XML_ERR_NONODESMATCH=" & $XML_ERR_NONODESMAT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NONODESMATCH=' & $XML_ERR_NONODESMATCH & @CRLF & 'No nodes match the XPath expression'
		$__iLineNumber=2239 & ' - Case $XML_ERR_NOCHILDMATCH•./Include/_MyFunction.au3'
		Case $XML_ERR_NOCHILDMATCH
			$__iLineNumber=2240 & ' - $sErrorInfo = "$XML_ERR_NOCHILDMATCH=" & $XML_ERR_NOCHILDMAT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NOCHILDMATCH=' & $XML_ERR_NOCHILDMATCH & @CRLF & 'There is no Child in nodes matched by XPath expression.'
		$__iLineNumber=2241 & ' - Case $XML_ERR_NOATTRMATCH•./Include/_MyFunction.au3'
		Case $XML_ERR_NOATTRMATCH
			$__iLineNumber=2242 & ' - $sErrorInfo = "$XML_ERR_NOATTRMATCH=" & $XML_ERR_NOATTRMATCH ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_NOATTRMATCH=' & $XML_ERR_NOATTRMATCH & @CRLF & 'There is no such attribute in selected node.'
		$__iLineNumber=2243 & ' - Case $XML_ERR_DOMVERSION•./Include/_MyFunction.au3'
		Case $XML_ERR_DOMVERSION
			$__iLineNumber=2244 & ' - $sErrorInfo = "$XML_ERR_DOMVERSION=" & $XML_ERR_DOMVERSION & ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_DOMVERSION=' & $XML_ERR_DOMVERSION & @CRLF & 'DOM Version: ' & 'MSXML Version ' & $iXMLWrapper_Extended & ' or greater required for this function'
		$__iLineNumber=2245 & ' - Case $XML_ERR_EMPTYCOLLECTION•./Include/_MyFunction.au3'
		Case $XML_ERR_EMPTYCOLLECTION
			$__iLineNumber=2246 & ' - $sErrorInfo = "$XML_ERR_EMPTYCOLLECTION=" & $XML_ERR_EMPTYCO ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_EMPTYCOLLECTION=' & $XML_ERR_EMPTYCOLLECTION & @CRLF & 'Collections of objects was empty'
		$__iLineNumber=2247 & ' - Case $XML_ERR_EMPTYOBJECT•./Include/_MyFunction.au3'
		Case $XML_ERR_EMPTYOBJECT
			$__iLineNumber=2248 & ' - $sErrorInfo = "$XML_ERR_EMPTYOBJECT=" & $XML_ERR_EMPTYOBJECT ...•./Include/_MyFunction.au3'
			$sErrorInfo = '$XML_ERR_EMPTYOBJECT=' & $XML_ERR_EMPTYOBJECT & @CRLF & 'Object is empty'
		Case Else
			$__iLineNumber=2250 & ' - $sErrorInfo = "=" & $iXMLWrapper_Error & @CRLF & "NO ERROR D ...•./Include/_MyFunction.au3'
			$sErrorInfo = '=' & $iXMLWrapper_Error & @CRLF & 'NO ERROR DESCRIPTION FOR THIS @error'
	EndSwitch

	$__iLineNumber=2253 & ' - Local $sExtendedInfo = ""•./Include/_MyFunction.au3'
	Local $sExtendedInfo = ''
	$__iLineNumber=2254 & ' - Switch $iXMLWrapper_Error•./Include/_MyFunction.au3'
	$__iLineNumber=2255 & ' - Case $XML_ERR_COMERROR, $XML_ERR_NODEAPPEND, $XML_ERR_NODECR ...•./Include/_MyFunction.au3'
	Switch $iXMLWrapper_Error
		Case $XML_ERR_COMERROR, $XML_ERR_NODEAPPEND, $XML_ERR_NODECREATE
			$__iLineNumber=2256 & ' - $sExtendedInfo = "COM ERROR NUMBER (@error returned via @ext ...•./Include/_MyFunction.au3'
			$sExtendedInfo = 'COM ERROR NUMBER (@error returned via @extended) =' & $iXMLWrapper_Extended
		$__iLineNumber=2257 & ' - Case $XML_ERR_PARAMETER•./Include/_MyFunction.au3'
		Case $XML_ERR_PARAMETER
			$__iLineNumber=2258 & ' - $sExtendedInfo = "This @error was fired by parameter: #" & $ ...•./Include/_MyFunction.au3'
			$sExtendedInfo = 'This @error was fired by parameter: #' & $iXMLWrapper_Extended
		Case Else
			$__iLineNumber=2260 & ' - Switch $iXMLWrapper_Extended•./Include/_MyFunction.au3'
			$__iLineNumber=2261 & ' - Case $XML_EXT_DEFAULT•./Include/_MyFunction.au3'
			Switch $iXMLWrapper_Extended
				Case $XML_EXT_DEFAULT
					$__iLineNumber=2262 & ' - $sExtendedInfo = "$XML_EXT_DEFAULT=" & $XML_EXT_DEFAULT & @C ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_DEFAULT=' & $XML_EXT_DEFAULT & @CRLF & 'Default - Do not return any additional information'
				$__iLineNumber=2263 & ' - Case $XML_EXT_XMLDOM•./Include/_MyFunction.au3'
				Case $XML_EXT_XMLDOM
					$__iLineNumber=2264 & ' - $sExtendedInfo = "$XML_EXT_XMLDOM=" & $XML_EXT_XMLDOM & @CRL ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_XMLDOM=' & $XML_EXT_XMLDOM & @CRLF & '"Microsoft.XMLDOM" related Error'
				$__iLineNumber=2265 & ' - Case $XML_EXT_DOMDOCUMENT•./Include/_MyFunction.au3'
				Case $XML_EXT_DOMDOCUMENT
					$__iLineNumber=2266 & ' - $sExtendedInfo = "$XML_EXT_DOMDOCUMENT=" & $XML_EXT_DOMDOCUM ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_DOMDOCUMENT=' & $XML_EXT_DOMDOCUMENT & @CRLF & '"Msxml2.DOMDocument" related Error'
				$__iLineNumber=2267 & ' - Case $XML_EXT_XSLTEMPLATE•./Include/_MyFunction.au3'
				Case $XML_EXT_XSLTEMPLATE
					$__iLineNumber=2268 & ' - $sExtendedInfo = "$XML_EXT_XSLTEMPLATE=" & $XML_EXT_XSLTEMPL ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_XSLTEMPLATE=' & $XML_EXT_XSLTEMPLATE & @CRLF & '"Msxml2.XSLTemplate" related Error'
				$__iLineNumber=2269 & ' - Case $XML_EXT_SAXXMLREADER•./Include/_MyFunction.au3'
				Case $XML_EXT_SAXXMLREADER
					$__iLineNumber=2270 & ' - $sExtendedInfo = "$XML_EXT_SAXXMLREADER=" & $XML_EXT_SAXXMLR ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_SAXXMLREADER=' & $XML_EXT_SAXXMLREADER & @CRLF & '"MSXML2.SAXXMLReader" related Error'
				$__iLineNumber=2271 & ' - Case $XML_EXT_MXXMLWRITER•./Include/_MyFunction.au3'
				Case $XML_EXT_MXXMLWRITER
					$__iLineNumber=2272 & ' - $sExtendedInfo = "$XML_EXT_MXXMLWRITER=" & $XML_EXT_MXXMLWRI ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_MXXMLWRITER=' & $XML_EXT_MXXMLWRITER & @CRLF & '"MSXML2.MXXMLWriter" related Error'
				$__iLineNumber=2273 & ' - Case $XML_EXT_FREETHREADEDDOMDOCUMENT•./Include/_MyFunction.au3'
				Case $XML_EXT_FREETHREADEDDOMDOCUMENT
					$__iLineNumber=2274 & ' - $sExtendedInfo = "$XML_EXT_FREETHREADEDDOMDOCUMENT=" & $XML_ ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_FREETHREADEDDOMDOCUMENT=' & $XML_EXT_FREETHREADEDDOMDOCUMENT & @CRLF & '"Msxml2.FreeThreadedDOMDocument" related Error'
				$__iLineNumber=2275 & ' - Case $XML_EXT_XMLSCHEMACACHE•./Include/_MyFunction.au3'
				Case $XML_EXT_XMLSCHEMACACHE
					$__iLineNumber=2276 & ' - $sExtendedInfo = "$XML_EXT_XMLSCHEMACACHE=" & $XML_EXT_XMLSC ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_XMLSCHEMACACHE=' & $XML_EXT_XMLSCHEMACACHE & @CRLF & '"Msxml2.XMLSchemaCache." related Error'
				$__iLineNumber=2277 & ' - Case $XML_EXT_STREAM•./Include/_MyFunction.au3'
				Case $XML_EXT_STREAM
					$__iLineNumber=2278 & ' - $sExtendedInfo = "$XML_EXT_STREAM=" & $XML_EXT_STREAM & @CRL ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_STREAM=' & $XML_EXT_STREAM & @CRLF & '"ADODB.STREAM" related Error'
				$__iLineNumber=2279 & ' - Case $XML_EXT_ENCODING•./Include/_MyFunction.au3'
				Case $XML_EXT_ENCODING
					$__iLineNumber=2280 & ' - $sExtendedInfo = "$XML_EXT_ENCODING=" & $XML_EXT_ENCODING &  ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$XML_EXT_ENCODING=' & $XML_EXT_ENCODING & @CRLF & 'Encoding related Error'
				Case Else
					$__iLineNumber=2282 & ' - $sExtendedInfo = "$iXMLWrapper_Extended=" & $iXMLWrapper_Ext ...•./Include/_MyFunction.au3'
					$sExtendedInfo = '$iXMLWrapper_Extended=' & $iXMLWrapper_Extended & @CRLF & 'NO ERROR DESCRIPTION FOR THIS @extened'
			EndSwitch
	EndSwitch
	; return back @error and @extended for further debuging
	$__iLineNumber=2286 & ' - Return SetError($iXMLWrapper_Error, $iXMLWrapper_Extended, _•./Include/_MyFunction.au3'
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

$__iLineNumber=2299 & ' - Func _CreateMailslot($sMailSlotName)•./Include/_MyFunction.au3'
Func _CreateMailslot($sMailSlotName)
	$__iLineNumber=2300 & ' - Local $hHandle = _MailSlotCreate($sMailSlotName)•./Include/_MyFunction.au3'
	Local $hHandle = _MailSlotCreate($sMailSlotName)
	$__iLineNumber=2301 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=2302 & ' - _LOG("MailSlot error : Failed to create new account! (" & $s ...•./Include/_MyFunction.au3'
		_LOG("MailSlot error : Failed to create new account! (" & $sMailSlotName & ")", 2, $iLOGPath)
		$__iLineNumber=2303 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
	$__iLineNumber=2305 & ' - Return $hHandle•./Include/_MyFunction.au3'
	Return $hHandle
EndFunc   ;==>_CreateMailslot


$__iLineNumber=2309 & ' - Func _SendMail($hHandle, $sDataToSend)•./Include/_MyFunction.au3'
Func _SendMail($hHandle, $sDataToSend)
	$__iLineNumber=2310 & ' - If $sDataToSend Then•./Include/_MyFunction.au3'
	If $sDataToSend Then
		$__iLineNumber=2311 & ' - _MailSlotWrite($hHandle, $sDataToSend, 2)•./Include/_MyFunction.au3'
		_MailSlotWrite($hHandle, $sDataToSend, 2)
		$__iLineNumber=2312 & ' - Switch @error•./Include/_MyFunction.au3'
		$__iLineNumber=2313 & ' - Case 1•./Include/_MyFunction.au3'
		Switch @error
			Case 1
				$__iLineNumber=2314 & ' - _LOG("MailSlot error : Account that you try to send to doesn ...•./Include/_MyFunction.au3'
				_LOG("MailSlot error : Account that you try to send to doesn't exist!", 2, $iLOGPath)
				$__iLineNumber=2315 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			$__iLineNumber=2316 & ' - Case 2•./Include/_MyFunction.au3'
			Case 2
				$__iLineNumber=2317 & ' - _LOG("MailSlot error : Message is blocked!", 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG("MailSlot error : Message is blocked!", 2, $iLOGPath)
				$__iLineNumber=2318 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			$__iLineNumber=2319 & ' - Case 3•./Include/_MyFunction.au3'
			Case 3
				$__iLineNumber=2320 & ' - _LOG("MailSlot error : Message is send but there is an open  ...•./Include/_MyFunction.au3'
				_LOG("MailSlot error : Message is send but there is an open handle left.", 2, $iLOGPath)
				$__iLineNumber=2321 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			$__iLineNumber=2322 & ' - Case 4•./Include/_MyFunction.au3'
			Case 4
				$__iLineNumber=2323 & ' - _LOG("MailSlot error : All is fucked up!", 2, $iLOGPath)•./Include/_MyFunction.au3'
				_LOG("MailSlot error : All is fucked up!", 2, $iLOGPath)
				$__iLineNumber=2324 & ' - Return -1•./Include/_MyFunction.au3'
				Return -1
			Case Else
				$__iLineNumber=2326 & ' - _LOG("MailSlot : Sucessfully sent =" & $sDataToSend, 3, $iLO ...•./Include/_MyFunction.au3'
				_LOG("MailSlot : Sucessfully sent =" & $sDataToSend, 3, $iLOGPath)
				$__iLineNumber=2327 & ' - Return 1•./Include/_MyFunction.au3'
				Return 1
		EndSwitch
	Else
		$__iLineNumber=2330 & ' - _LOG("MailSlot error : Nothing to send.", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("MailSlot error : Nothing to send.", 2, $iLOGPath)
	EndIf
EndFunc   ;==>_SendMail

$__iLineNumber=2334 & ' - Func _ReadMessage($hHandle)•./Include/_MyFunction.au3'
Func _ReadMessage($hHandle)
	$__iLineNumber=2335 & ' - Local $iSize = _MailSlotCheckForNextMessage($hHandle)•./Include/_MyFunction.au3'
	Local $iSize = _MailSlotCheckForNextMessage($hHandle)
	$__iLineNumber=2336 & ' - If $iSize Then•./Include/_MyFunction.au3'
	If $iSize Then
		$__iLineNumber=2337 & ' - Return _MailSlotRead($hHandle, $iSize, 2)•./Include/_MyFunction.au3'
		Return _MailSlotRead($hHandle, $iSize, 2)
	Else
		$__iLineNumber=2339 & ' - _LOG("MailSlot error : MailSlot is empty", 2, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("MailSlot error : MailSlot is empty", 2, $iLOGPath)
		$__iLineNumber=2340 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf
EndFunc   ;==>_ReadMessage


$__iLineNumber=2345 & ' - Func _CheckCount($hHandle)•./Include/_MyFunction.au3'
Func _CheckCount($hHandle)
	$__iLineNumber=2346 & ' - Local $iCount = _MailSlotGetMessageCount($hHandle)•./Include/_MyFunction.au3'
	Local $iCount = _MailSlotGetMessageCount($hHandle)
	$__iLineNumber=2347 & ' - Switch $iCount•./Include/_MyFunction.au3'
	$__iLineNumber=2348 & ' - Case 0•./Include/_MyFunction.au3'
	Switch $iCount
		Case 0
			$__iLineNumber=2349 & ' - _LOG("MailSlot : No new messages", 3, $iLOGPath)•./Include/_MyFunction.au3'
			_LOG("MailSlot : No new messages", 3, $iLOGPath)
		$__iLineNumber=2350 & ' - Case 1•./Include/_MyFunction.au3'
		Case 1
			$__iLineNumber=2351 & ' - _LOG("MailSlot : There is 1 message waiting to be read.", 3, ...•./Include/_MyFunction.au3'
			_LOG("MailSlot : There is 1 message waiting to be read.", 3, $iLOGPath)
		Case Else
			$__iLineNumber=2353 & ' - _LOG("MailSlot : There are " & $iCount & " messages waiting  ...•./Include/_MyFunction.au3'
			_LOG("MailSlot : There are " & $iCount & " messages waiting to be read.", 3, $iLOGPath)
	EndSwitch
	$__iLineNumber=2355 & ' - Return $iCount•./Include/_MyFunction.au3'
	Return $iCount
EndFunc   ;==>_CheckCount

$__iLineNumber=2358 & ' - Func _CheckAnswer($hHandle, $idata)•./Include/_MyFunction.au3'
Func _CheckAnswer($hHandle, $idata)
	$__iLineNumber=2359 & ' - Local $iAnwser = ""•./Include/_MyFunction.au3'
	Local $iAnwser = ""
	$__iLineNumber=2360 & ' - Local $iSize•./Include/_MyFunction.au3'
	Local $iSize
	$__iLineNumber=2361 & ' - Local $iCounter = 0•./Include/_MyFunction.au3'
	Local $iCounter = 0
	$__iLineNumber=2362 & ' - While $iAnwser <> $idata And $iCounter < 500•./Include/_MyFunction.au3'
	While $iAnwser <> $idata And $iCounter < 500
		$__iLineNumber=2363 & ' - $iSize = _MailSlotCheckForNextMessage($hHandle)•./Include/_MyFunction.au3'
		$iSize = _MailSlotCheckForNextMessage($hHandle)
		$__iLineNumber=2364 & ' - If $iSize Then $idata = _MailSlotRead($hHandle, $iSize, 2)•./Include/_MyFunction.au3'
		If $iSize Then $idata = _MailSlotRead($hHandle, $iSize, 2)
		$__iLineNumber=2365 & ' - $iCounter += 1•./Include/_MyFunction.au3'
		$iCounter += 1
	WEnd
	$__iLineNumber=2367 & ' - Return 1•./Include/_MyFunction.au3'
	Return 1
EndFunc   ;==>_CheckAnswer


$__iLineNumber=2371 & ' - Func _CloseMailAccount(ByRef $hHandle)•./Include/_MyFunction.au3'
Func _CloseMailAccount(ByRef $hHandle)
	$__iLineNumber=2372 & ' - If _MailSlotClose($hHandle) Then•./Include/_MyFunction.au3'
	If _MailSlotClose($hHandle) Then
		$__iLineNumber=2373 & ' - $hHandle = 0•./Include/_MyFunction.au3'
		$hHandle = 0
		$__iLineNumber=2374 & ' - _LOG("MailSlot : Account succesfully closed.", 3, $iLOGPath)•./Include/_MyFunction.au3'
		_LOG("MailSlot : Account succesfully closed.", 3, $iLOGPath)
		$__iLineNumber=2375 & ' - Return 1•./Include/_MyFunction.au3'
		Return 1
	Else
		$__iLineNumber=2377 & ' - _LOG("MailSlot error : Account could not be closed!", 2, $iL ...•./Include/_MyFunction.au3'
		_LOG("MailSlot error : Account could not be closed!", 2, $iLOGPath)
		$__iLineNumber=2378 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	EndIf

EndFunc   ;==>_CloseMailAccount


$__iLineNumber=2384 & ' - Func _RestoreAccount($hHandle)•./Include/_MyFunction.au3'
Func _RestoreAccount($hHandle)
	$__iLineNumber=2385 & ' - Local $hMailSlotHandle = _MailSlotCreate($hHandle)•./Include/_MyFunction.au3'
	Local $hMailSlotHandle = _MailSlotCreate($hHandle)
	$__iLineNumber=2386 & ' - If @error Then•./Include/_MyFunction.au3'
	If @error Then
		$__iLineNumber=2387 & ' - _LOG("MailSlot error : Account could not be created!", 2, $i ...•./Include/_MyFunction.au3'
		_LOG("MailSlot error : Account could not be created!", 2, $iLOGPath)
		$__iLineNumber=2388 & ' - Return -1•./Include/_MyFunction.au3'
		Return -1
	Else
		$__iLineNumber=2390 & ' - _LOG("MailSlot error : New account with the same address suc ...•./Include/_MyFunction.au3'
		_LOG("MailSlot error : New account with the same address successfully created!", 2, $iLOGPath)
		$__iLineNumber=2391 & ' - Return $hMailSlotHandle•./Include/_MyFunction.au3'
		Return $hMailSlotHandle
	EndIf
EndFunc   ;==>_RestoreAccount

#EndRegion SendMail Function
